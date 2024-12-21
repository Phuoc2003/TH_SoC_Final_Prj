/*
 * source.c
 *
 *  Created on: 05-11-2024
 *      Author: PeterPhan
 */


#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "SH1106.h"
#include "DS1307.h"
#include "bitmap.h"
#include "horse_anim.h"

ALT_AVALON_I2C_DEV_t *i2c_dev;
#define AHT_ADDR   0x38

float Temp = 0.0;
float Humid = 0.0;

void I2C0_Init(){
	/* Check if LCD connected to I2C */
	i2c_dev = alt_avalon_i2c_open("/dev/i2c_0");
	if (NULL==i2c_dev)  {
		printf("Error: Cannot find /dev/i2c_0\n");
		return;
	}
	printf("Successfully open I2C");
}


void AHT20_Read()
{
    uint8_t dum[6];
    uint8_t reg = 0x71;

    // Send register address (0x71) and read back 1 byte
    alt_avalon_i2c_master_target_set(i2c_dev, AHT_ADDR);
    alt_avalon_i2c_master_tx(i2c_dev, &reg, 1,
    								ALT_AVALON_I2C_NO_INTERRUPTS);
//    HAL_I2C_Master_Transmit(&HI2C, AHT_ADDR, &reg, 1, 100);
    alt_avalon_i2c_master_rx(i2c_dev, dum, 1,
       								ALT_AVALON_I2C_NO_INTERRUPTS);

    // Check calibration status
    if (!(dum[0] & (1 << 3)))
    {
        dum[0] = 0xBE, dum[1] = 0x08, dum[2] = 0x00;
        alt_avalon_i2c_master_tx(i2c_dev, dum, 3,
            								ALT_AVALON_I2C_NO_INTERRUPTS);
        usleep(10000);
    }

    // Trigger measurement command
    dum[0] = 0xAC, dum[1] = 0x33, dum[2] = 0x00;
    alt_avalon_i2c_master_tx(i2c_dev, dum, 3,
                								ALT_AVALON_I2C_NO_INTERRUPTS);
    usleep(80000);

    // Poll until the sensor completes the measurement
    do {
    	alt_avalon_i2c_master_tx(i2c_dev, &reg, 1,
    	    								ALT_AVALON_I2C_NO_INTERRUPTS);
        alt_avalon_i2c_master_rx(i2c_dev, dum, 1,
               								ALT_AVALON_I2C_NO_INTERRUPTS);
        usleep(100);
    } while (dum[0] & (1 << 7));

    // Read measurement results (6 bytes)
    alt_avalon_i2c_master_rx(i2c_dev, dum, 6,
                   								ALT_AVALON_I2C_NO_INTERRUPTS);

    // Process humidity and temperature data
    float h20 = (dum[1]) << 12 | (dum[2]) << 4 | (dum[3] >> 4);
    float t20 = (dum[3] & 0x0F) << 16 | (dum[4]) << 8 | dum[5];
    Temp = (t20 / 1048576.0) * 200.0 - 50.0;
    Humid = h20 / 10485.76;

}


int main()
{
	char buffer[16];
	uint32_t nguyen;
	uint32_t thapphan;
	I2C0_Init();
	SH1106_Init (); // initialise the display
	const char *DAYS_OF_WEEK[7] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		/* Start DS1307 timing. Pass user I2C handle pointer to function. */
	DS1307_Init();
		/* To test leap year correction. */
	DS1307_SetTimeZone(+8, 00);
	DS1307_SetDate(29);
	DS1307_SetMonth(2);
	DS1307_SetYear(2024);
	DS1307_SetDayOfWeek(4);
	DS1307_SetHour(23);
	DS1307_SetMinute(59);
	DS1307_SetSecond(30);
	  while (1)
	  {
		  usleep(5000000);
		  AHT20_Read();
		  printf("\nTemp: %d, Humid: %d", (int)Temp, (int)Humid);

		  Temp = Temp * 100;
		  nguyen = Temp / 100;
		  thapphan = (uint32_t)Temp % 100;
		  sprintf(buffer, "Temp: %d.%02d", nguyen, thapphan);
		  SH1106_GotoXY(12, 0);
		  SH1106_Puts(buffer, &Font_7x10, 1);

		  Humid = Humid * 100;
		  nguyen = Humid / 100;
		  thapphan = (uint32_t)Humid % 100;
		  sprintf(buffer, "Humidity: %d.%02d", nguyen, thapphan);
		  SH1106_GotoXY(12, 15);
		  SH1106_Puts(buffer, &Font_7x10, 1);
		  SH1106_UpdateScreen();
	  }



	return 1;
}
