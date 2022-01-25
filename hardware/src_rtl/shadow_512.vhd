----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Farris El Machtani Idrissi
-- 
-- Create Date: 01/12/2022 03:40:45 PM
-- Design Name: 
-- Module Name: shadow_512 - Behavioral
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

entity shadow_512 is
  Port ( 
        clk: in std_logic;
        d_in: in std_logic_vector(511 downto 0);
        d_out: out std_logic_vector(511 downto 0);
        --controller
        EN: in std_logic
  
  );
end shadow_512;

architecture Behavioral of shadow_512 is
signal currState: std_logic_vector(511 downto 0):=d_in;
--entity related signals
--signal dbox_in: std_logic_vector(511 downto 0);
--signal dbox_out: std_logic_vector(511 downto 0);
--signal sbox_in : std_logic_vector(3 downto 0);
--signal sbox_out: std_logic_vector(3 downto 0);
--signal round_in: std_logic_vector(3 downto 0);
--signal round_out: std_logic_vector(3 downto 0);
--signal lbox_in: std_logic_vector(63 downto 0);
--signal lbox_out: std_logic_vector(63 downto 0);
--internal signals
signal nextState: std_logic_vector(511 downto 0);

--storing entity results
type mem is array (0 to 31) of std_logic_vector(3 downto 0);
signal sbox_out: mem;
signal lbox_out: mem;

begin
    --generate statement must be outside of a process
    sbox_calc:for I in 0 to 31 generate
    sbox: ENTITY work.sbox
    port map(
    index => currState(32*3+I)&currState(32*2+I) & currState(32+I)&currState(I),
    output => sbox_out(I)
    );
    --add nextState statements, apply to inner components
    end generate;
    
    lbox_calc: for J in 0 to 1 generate
        lbox: ENTITY work.l_box
        port map(
            input => currState(32*(J+2)-1 downto 32*(J+1)-32),
            output => lbox_out(J)
        );
    end generate;
    
    



--enitity declarations

    state: process(clk)
    
    begin
        if rising_edge(clk) then
            if EN = '1' then
                currState <= nextState;
            end if;
        end if;
    end process;

    calc: process(clk)
    
    begin

    
    
    
    end process;

--    dbox: ENTITY work.diffusion_shadow
--        port map(
--            clk => clk,
--            input => dbox_in,
--            output => dbox_out
--        );
--    round: ENTITY work.round
--        port map(
--            index => dbox_in,
--            output => dbox_out
--        );
--    lbox: ENTITY work.l_box
--        port map(
--            input => lbox_in,
--            output => lbox_out
--        );
--    sbox: ENTITY work.sbox
--        port map(
--            index => dbox_in,
--            output => dbox_out
--        );


end Behavioral;
