----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 08:53:23 PM
-- Design Name: 
-- Module Name: shadow512 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shadow512 is
  Port ( 
  
    Din: in std_logic_vector(511 downto 0);
    Dout: out std_logic_vector(511 downto 0)
  );
end shadow512;

architecture Behavioral of shadow512 is

signal in0,in1,in2,in3,in4,in5: std_logic_vector(511 downto 0);
signal out0,out1,out2,out3,out4,out5: std_logic_vector(511 downto 0);
begin

    in0<= Din;
    round0: entity work.shadowRound
    port map(
        din => in0,
        dout => out0,
        round => "0000"
    );
    in1<=out0;
    round1: entity work.shadowRound
    port map(
        din => in1,
        dout => out1,
        round => "0010"
    );
    in2<=out1;
    round2: entity work.shadowRound
    port map(
        din => in2,
        dout => out2,
        round => "0100"
    );
    in3<=out2;
    round3: entity work.shadowRound
    port map(
        din => in3,
        dout => out3,
        round => "0110"
    );
    in4<=out3;
    round4: entity work.shadowRound
    port map(
        din => in4,
        dout => out4,
        round => "1000"
    );
    in5<=out4;
    round5: entity work.shadowRound
    port map(
        din => in5,
        dout => out5,
        round => "1100"
    );
    Dout<=out5;
end Behavioral;
