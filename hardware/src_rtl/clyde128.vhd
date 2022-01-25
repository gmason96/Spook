----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Farris El Machtani Idrissi
-- 
-- Create Date: 01/21/2022 07:34:18 PM
-- Design Name: Clyde-128 TOPLEVEL
-- Module Name: clyde128 - Behavioral
-- Project Name: Spook
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

entity clyde128 is
  Port ( 
    din : in std_logic_vector(127 downto 0);
    tweak: in std_logic_vector(127 downto 0);
    key: in std_logic_vector(127 downto 0);
    dout: out std_logic_vector(127 downto 0);
    --controller
    --maybe perform dec/end in parallel and use decrpt as a select bit 
    --     for MUX going to res signal
    decrypt: in std_logic
  );
end clyde128;

architecture Behavioral of clyde128 is
signal in0,in1,in2,in3,in4,in5: std_logic_vector(127 downto 0);
signal out0,out1,out2,out3,out4,out5: std_logic_vector(127 downto 0);
--TK constants
constant tk0: std_logic_vector(127 downto 0):= key xor tweak;
constant tk1: std_logic_vector(127 downto 0):= ((tweak(63 downto 0) xor tweak(127 downto 64)) & tweak(63 downto 0)) ;
constant tk2: std_logic_vector(127 downto 0):= (tweak(127 downto 64) & (tweak(63 downto 0) xor tweak(127 downto 64)));

signal res: std_logic_vector(127 downto 0);

begin

    in0 <= Din xor (key & tweak);
    
    in1 <= out0 xor tk1;
    
    in2 <= out1 xor tk2;
    
    in3 <= out2 xor tk0;
    
    in4 <= out3 xor tk1;
    
    in5 <= out4 xor tk2;
    
    res <= out5 xor tk0;

    comp0: ENTITY work.CALC 
        port map(
        Din => in0,
        Dout => out0,
        round => "0000"
    );
    
    comp1: ENTITY work.CALC 
        port map(
        Din => in1,
        Dout => out1,
        round => "0001"
    );
    
    comp2: ENTITY work.CALC 
        port map(
        Din => in2,
        Dout => out2,
        round => "0010"
    );
    
    comp3: ENTITY work.CALC 
        port map(
        Din => in3,
        Dout => out3,
        round => "0011"
    );
    
    comp4: ENTITY work.CALC 
        port map(
        Din => in4,
        Dout => out4,
        round => "0100"
    );
    
    comp5: ENTITY work.CALC 
        port map(
        Din => in5,
        Dout => out5,
        round => "0101"
    );
    
    Dout <= res;



end Behavioral;
