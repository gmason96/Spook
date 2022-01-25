----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 04:42:05 PM
-- Design Name: 
-- Module Name: sboxTop - Behavioral
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

entity sboxTop is
  Port ( 
  Din: in std_logic_vector(127 downto 0);
  Dout: out std_logic_vector(127 downto 0)
  );
end sboxTop;

architecture Behavioral of sboxTop is

signal temp: std_logic_vector(127 downto 0):=Din;

begin


    sbox_calc:for I in 0 to 31 generate
        -- assumes ROM implementation of SBOX is valid
        -- may need to revert to serial implementation
            sbox: ENTITY work.sbox
            port map(
            --legal?
                index => temp(4*I+3 downto 4*I),
                output => temp(4*I+3 downto 4*I)
            );
     end generate;
     
     Dout <= temp;


end Behavioral;
