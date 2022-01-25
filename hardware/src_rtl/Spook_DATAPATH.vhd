----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 08:35:06 PM
-- Design Name: 
-- Module Name: Spook_DATAPATH - Behavioral
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

entity Spook_DATAPATH is
  Port ( 
    --data values
    BDI: in std_logic_vector(31 downto 0);
    BD0: out std_logic_vector(31 downto 0);
    key: in std_logic_vector(31 downto 0);
    clk: in std_logic;
    --control values
    en_clyde, en_shadow: in std_logic
  );
end Spook_DATAPATH;

architecture Behavioral of Spook_DATAPATH is
    signal stateClyde: std_logic_vector(127 downto 0);
    signal stateShadow: std_logic_vector(511 downto 0);
    signal clydeOut: std_logic_vector(127 downto 0);
    signal shadowOut: std_logic_vector(127 downto 0);
begin
    clyde_reg:process(clk)
    begin
        if rising_edge(clk) then
            if en_clyde = '1' then
                stateClyde <= clydeOut;
            end if;
            if en_shadow = '1' then
                stateShadow <= shadowOut;
            end if;
        end if;
    end process;
    
    encA: ENTITY work.clyde128
    port map(
        Din <= 
    
    );


end Behavioral;
