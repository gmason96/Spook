----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2021 04:28:37 PM
-- Design Name: 
-- Module Name: l_box - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity l_box is
  Port ( 
    input: in std_logic_vector(63 downto 0);
    output: out std_logic_vector(63 downto 0)
  
  );
end l_box;

architecture Behavioral of l_box is
    signal a,a0,a1,a2,a3 : std_logic_vector(31 downto 0);
    signal b,b0,b1,b2,b3 : std_logic_vector(31 downto 0);
    constant x: std_logic_vector(31 downto 0) := input(63 downto 32);
    constant y: std_logic_vector(31 downto 0) := input(31 downto 0);
    signal c,d : std_logic_vector(31 downto 0);

begin
        -- prior to design_pkg addition change if needed
        --no need for this to be clocked
        a0 <= x xor (x(19 downto 0) & x(31 downto 20));
        
        b0 <= y xor (y(19 downto 0) & y(31 downto 20));
        
        a1 <= a0 xor (a0(28 downto 0) & a0(31 downto 29));
        
        b1 <= b0 xor (b0(28 downto 0) & b0(31 downto 29));
        
        a2 <= a1 xor (x(14 downto 0) & x(31 downto 15));
        
        b2 <= b1 xor (y(14 downto 0) & y(31 downto 15));
        
        c <= a2 xor (a2(0 downto 0) & a2(31 downto 1));
        
        d <= b2 xor (b2(0 downto 0) & b2(31 downto 1));
        
        a3 <= a2 xor (d(5 downto 0) & d(31 downto 6));
    
        b3 <= b2 xor (c(6 downto 0) & c(31 downto 7));
        
        a <= a3 xor (c(16 downto 0) & c(31 downto 17));
        
        b <= b3 xor (d(16 downto 0) & d(31 downto 17));
    
    output <= a & b;

end Behavioral;
