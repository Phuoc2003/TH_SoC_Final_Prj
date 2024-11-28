/*
 * source.c
 *
 *  Created on: 05-11-2024
 *      Author: PeterPhan
 */


#include <stdio.h>
#include "SH1106.h"

ALT_AVALON_I2C_DEV_t *i2c_dev;

void I2C0_Init(){
	/* Check if LCD connected to I2C */
	i2c_dev = alt_avalon_i2c_open("/dev/i2c_0");
	if (NULL==i2c_dev)  {
		printf("Error: Cannot find /dev/i2c_0\n");
		return;
	}
	printf("Successfully open I2C");
}

int main()
{
	I2C0_Init();
	SH1106_Init (); // initialise the display
	SH1106_GotoXY (12,10); // goto 10, 10
	SH1106_Puts ("HELLO", &Font_11x18, 1); // print Hello
	return 1;
}
