----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2021 05:31:49 PM
-- Design Name: 
-- Module Name: round_constant - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity round is 
    generic(
    b:integer:=0
    );
    port(
        index : in std_logic_vector(3 downto 0);
        state: in std_logic_vector(127 downto 0);
        output: out std_logic_vector(3 downto 0)
    );  
end entity;

architecture behavioral of round is
type MEMORY_12_4 is array (0 to 15) of std_logic_vector(3 downto 0);
    constant ROM_12_4 : MEMORY_12_4 := (
        x"8",
        x"4",
        x"2",
        x"1",
        x"C",
        x"6",
        x"3",
        x"D",
        x"A",
        x"5",
        x"E",
        x"7",
        x"0",
        x"0",
        x"0",
        x"0"
    );
    signal temp: std_logic_vector(127 downto 0):=state;
    signal outRound: std_logic_vector(3 downto 0):=ROM_12_4(to_integer(unsigned(index)));
begin
    temp(0+B) <= outRound(0) xor state(0);
    temp(32+B) <= outRound(1) xor state(32);
    temp(64+B) <= outRound(2) xor state(64);
    temp(96+B) <= outRound(3) xor state(96);

    output <= temp;
end behavioral;
