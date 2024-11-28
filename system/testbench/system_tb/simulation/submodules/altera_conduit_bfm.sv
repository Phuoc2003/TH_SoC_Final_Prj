// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       altera_conduit_bfm
// role:width:direction:                              scl_in:1:output,scl_oe:1:input,sda_in:1:output,sda_oe:1:input
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module altera_conduit_bfm
(
   sig_scl_in,
   sig_scl_oe,
   sig_sda_in,
   sig_sda_oe
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   output sig_scl_in;
   input sig_scl_oe;
   output sig_sda_in;
   input sig_sda_oe;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_scl_in_t;
   typedef logic ROLE_scl_oe_t;
   typedef logic ROLE_sda_in_t;
   typedef logic ROLE_sda_oe_t;

   reg sig_scl_in_temp;
   reg sig_scl_in_out;
   logic [0 : 0] sig_scl_oe_in;
   logic [0 : 0] sig_scl_oe_local;
   reg sig_sda_in_temp;
   reg sig_sda_in_out;
   logic [0 : 0] sig_sda_oe_in;
   logic [0 : 0] sig_sda_oe_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_scl_oe_change;
   event signal_input_sda_oe_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "18.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // scl_in
   // -------------------------------------------------------

   function automatic void set_scl_in (
      ROLE_scl_in_t new_value
   );
      // Drive the new value to scl_in.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_scl_in_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // scl_oe
   // -------------------------------------------------------
   function automatic ROLE_scl_oe_t get_scl_oe();
   
      // Gets the scl_oe input value.
      $sformat(message, "%m: called get_scl_oe");
      print(VERBOSITY_DEBUG, message);
      return sig_scl_oe_in;
      
   endfunction

   // -------------------------------------------------------
   // sda_in
   // -------------------------------------------------------

   function automatic void set_sda_in (
      ROLE_sda_in_t new_value
   );
      // Drive the new value to sda_in.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_sda_in_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // sda_oe
   // -------------------------------------------------------
   function automatic ROLE_sda_oe_t get_sda_oe();
   
      // Gets the sda_oe input value.
      $sformat(message, "%m: called get_sda_oe");
      print(VERBOSITY_DEBUG, message);
      return sig_sda_oe_in;
      
   endfunction

   assign sig_scl_in = sig_scl_in_temp;
   assign sig_scl_oe_in = sig_scl_oe;
   assign sig_sda_in = sig_sda_in_temp;
   assign sig_sda_oe_in = sig_sda_oe;


   always @(sig_scl_oe_in) begin
      if (sig_scl_oe_local != sig_scl_oe_in)
         -> signal_input_scl_oe_change;
      sig_scl_oe_local = sig_scl_oe_in;
   end
   
   always @(sig_sda_oe_in) begin
      if (sig_sda_oe_local != sig_sda_oe_in)
         -> signal_input_sda_oe_change;
      sig_sda_oe_local = sig_sda_oe_in;
   end
   


// synthesis translate_on

endmodule

