// Author Raj Dasadia
//Top module


module LAB4_legacy_4014 ( clk, reset, bit4_player2, bit4_password, bit4_setDigit_units, bit4_setDigit_tens, pushButton_RNG, pushButton_player2, pushButton_password, 
		        seg7_CPU, seg7_player2, seg7_sum,seg7_units, seg7_tens, hexFdetection_led_red, hexFdetection_led_green, accessControl_led_red, accessControl_led_green);


input clk, reset;

input pushButton_RNG, pushButton_player2, pushButton_password;

input [3:0] bit4_player2, bit4_password;
input [3:0] bit4_setDigit_tens, bit4_setDigit_units;

output hexFdetection_led_red, hexFdetection_led_green, accessControl_led_red, accessControl_led_green;

output [6:0] seg7_CPU, seg7_player2, seg7_sum, seg7_units, seg7_tens;


wire load_sig_player1, load_sig_player2, pulse_player2, pulse_password;
wire [3:0] fourBitOut_player2, sum4bit, digit_tens, digit_units, count ;
wire load_sig_RNG, reconfig, decrement, enable, timeout;




access_control access_control1 (clk, reset, load_sig_RNG, load_sig_player2,  pulse_password, pushButton_RNG, pulse_player2, bit4_password, timeout, reconfig, enable, accessControl_led_red, accessControl_led_green);

randomNumGenerator randomNumGenerator1 (clk, reset, load_sig_RNG, count);

fourBitAdder adder (count, fourBitOut_player2, sum4bit);

hexFdetector win_detector (sum4bit, hexFdetection_led_red, hexFdetection_led_green);


loadreg loadreg_player2 ( clk, reset, load_sig_player2, bit4_player2, fourBitOut_player2 );

sevenSegDisplayDecoder sevenSegDisplayDecoder_CPU (count, seg7_CPU);
sevenSegDisplayDecoder sevenSegDisplayDecoder_player2 (fourBitOut_player2, seg7_player2);
sevenSegDisplayDecoder sevenSegDisplayDecoder_sum (sum4bit, seg7_sum);
sevenSegDisplayDecoder sevenSegDisplayDecoder_tens (digit_tens, seg7_tens);
sevenSegDisplayDecoder sevenSegDisplayDecoder_units (digit_units, seg7_units);


singlePulseButton singlePulseButton_player2 (pushButton_player2, pulse_player2, clk, reset);
singlePulseButton singlePulseButton_password (pushButton_password, pulse_password, clk, reset);

countDownToZero countDownToZero1(clk, reset, reconfig, bit4_setDigit_tens, bit4_setDigit_units, decrement, timeout, digit_tens, digit_units);

TimerOneSecond TimerOneSecond1(clk, reset, enable, decrement);



endmodule 
