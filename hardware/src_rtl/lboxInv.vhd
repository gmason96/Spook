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
use work.design_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lboxInv is
  Port ( 
    input: in std_logic_vector(63 downto 0);
    output: out std_logic_vector(63 downto 0)
  
  );
end lboxInv;

architecture Behavioral of lboxInv is
    signal a0,a1,a2,a3 : std_logic_vector(31 downto 0);
    signal b0,b1,b2,b3 : std_logic_vector(31 downto 0);
    constant x: std_logic_vector(31 downto 0) := input(63 downto 32);
    constant y: std_logic_vector(31 downto 0) := input(31 downto 0);
    signal c0,c1,c2,d0,d1,d2 : std_logic_vector(31 downto 0);

begin
        --no need for this to be clocked
        a0 <= x xor rot(x,25);
        
        b0 <= y xor rot(y,25);
        
        c0 <= x xor rot(a0,31);
        
        d0 <= y xor rot(b0,31);
        
        c1 <= c0 xor rot(a0,20);
        
        d1 <= d0 xor rot(b0,20);
        
        a1 <= c1 xor rot(c1,31);
        
        b1 <= d1 xor rot(d1,31);
        
        c2 <= c1 xor rot(b1,26);
    
        d2 <= d1 xor rot(a1,25);
        
        a2 <= a1 xor rot(c2,17);

        b2 <= b1 xor rot(d2,17);
        
        a3 <= rot(a2,16);
        
        b3 <= rot(b2,16);
    
    output <= a3 & b3;

end Behavioral;
