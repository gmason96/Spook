----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Farris El Machtani Idrissi
-- 
-- Create Date: 01/19/2022 03:44:47 PM
-- Design Name: 
-- Module Name: BMAP - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: maps bytes to bits in little endian order
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

entity BMAP is
  generic (
  q: integer
  );
  Port ( 
  input: in std_logic_vector(8*q-1 downto 0);
  output: out std_logic_vector(8*q-1 downto 0)
  );
end BMAP;

architecture Behavioral of BMAP is

begin


end Behavioral;
