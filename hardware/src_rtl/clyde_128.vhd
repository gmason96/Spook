----------------------------------------------------------------------------------
-- Company: George Mason University
-- Engineer: Farris El Machtani Idrissi
-- 
-- Create Date: 12/08/2021 05:31:26 PM
-- Design Name: 
-- Module Name: clyde_128 - Behavioral
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
library xil_defaultlib;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


-- Uncomment the following library declaration
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clyde_128 is
  Port ( 
    din : in std_logic_vector(127 downto 0);
    clk: in std_logic;
    tweak: in std_logic_vector(127 downto 0);
    key: in std_logic_vector(127 downto 0);
    E_start: in std_logic;
    E_done: out std_logic;
    dout: out std_logic_vector(127 downto 0);
    
    --controller
    decrypt: in std_logic;
    EN: in std_logic;
    enc: in std_logic
    --roundCount: in integer
  );
end clyde_128;


architecture Behavioral of clyde_128 is
    constant op: std_logic:=decrypt;
    type mem is array (0 to 31) of std_logic_vector(3 downto 0);
    signal sbox_out: mem;
    signal sboxState: std_logic_vector(127 downto 0);
    signal lboxState: std_logic_vector(127 downto 0);
    signal roundState: std_logic_vector(127 downto 0);
    signal currRound: std_logic_vector(3 downto 0);
    signal roundOut: std_logic_vector(3 downto 0);
    signal roundCount: std_logic_vector(3 downto 0);
    --entity signals
--    signal sbox_in : std_logic_vector(3 downto 0);
--    --signal sbox_out: std_logic_vector(3 downto 0);
--    signal round_in: std_logic_vector(3 downto 0);
--    signal round_out: std_logic_vector(3 downto 0);
--    signal lbox_in: std_logic_vector(63 downto 0);
--    signal lbox_out: std_logic_vector(63 downto 0);
    --key signals
    signal tk0: std_logic_vector(127 downto 0):= din xor (key xor tweak);
    signal tk1: std_logic_vector(127 downto 0):= din xor ((tweak(63 downto 0) 
            xor tweak(127 downto 64)) & tweak(63 downto 0)) ;
    signal tk2: std_logic_vector(127 downto 0):= din xor (tweak(127 downto 64) &(tweak(63 downto 0) 
            xor tweak(127 downto 64)));
    signal currTweak: std_logic_vector(127 downto 0);
    --register components
    signal nextState: std_logic_vector(127 downto 0);
    signal currState: std_logic_vector(127 downto 0) := din xor (key xor tweak);
    
    signal keySelect: std_logic_vector(1 downto 0);

begin
    --keySelect <= std_logic_vector(to_unsigned(roundCount+1 mod 3,2));


    --only datapath segments should be created in this portion of code
    --counting and rounds will be satsified through the clyde_128_controller
    -- the encryption begins with the XOR of the plaintext and key value(0)
    --      for this porion, we simply set a signal to the value of the key and xor with the message
    --      block input coming from the port map
    -- this signal is known as x
    
    --currTweak <= tk0 when keyCount = "00" tk1 when "01" tk2 when others;
    
    
    with keySelect select
        currTweak <= tk0 when "00",
                     tk1 when "10",
                     tk2 when others;   
    state: process(clk)
    begin
        if rising_edge(clk) then
            if EN = '1' then
                currState <= nextState;
            end if;
        end if;

    end process;
    
    counter: process(clk)
    begin
        if rising_edge(clk) then
            if enc = '1' then
                --add 1 to roundCount
                roundCount <= std_logic_vector(to_unsigned(1+to_integer(unsigned(roundCount)),4));
             end if;
        end if;
    
    
    end process;
   
    sbox_calc:for I in 0 to 31 generate
        -- assumes ROM implementation of SBOX is valid
        -- may need to revert to serial implementation
        encryption: if op = '0' generate
            sbox: ENTITY work.sbox
            port map(
                index => currState(32*3+I)&currState(32*2+I) & currState(32+I)&currState(I),
                output => sbox_out(I)
            );
            sboxState(I)<= sbox_out(I)(0);
            sboxState(32+I)<= sbox_out(I)(1);
            sboxState(64+I)<= sbox_out(I)(2);
            sboxState(96+I)<= sbox_out(I)(3);
        end generate;
        decryption: if op = '1' generate
            sboxInv: ENTITY work.sboxInv
            port map(
                index => currState(32*3+I)&currState(32*2+I) & currState(32+I)&currState(I),
                output => sbox_out(I)
            );
            sboxState(I)<= sbox_out(I)(0);
            sboxState(32+I)<= sbox_out(I)(1);
            sboxState(64+I)<= sbox_out(I)(2);
            sboxState(96+I)<= sbox_out(I)(3);
        end generate;
    end generate;
    
    lbox_calc: for I in 0 to 1 generate
            encryption: if op = '0' generate
            lbox: ENTITY work.l_box
            port map(
                input => sboxState(32*3+I)&sboxState(32*2+I) & sboxState(32+I)&sboxState(I),
                output => lboxState(63+64*I downto 64*I)
            );

        end generate;
        decryption: if op = '1' generate
            lboxInv: ENTITY work.lboxInv
            port map(
                input => sboxState(32*3+I)&sboxState(32*2+I) & sboxState(32+I)&sboxState(I),
                output => lboxState(63+64*I downto 64*I)
            );

        end generate;
    end generate;
    --TO DO
    -- figure out proper way to factor current round
    round_calc: for I in 0 to 1 generate
        round: ENTITY work.round
        port map(
            index => currRound,
            state => lboxState,
            output => roundState
        );
    end generate;
--    --component declarations
--    round: ENTITY work.round
--        port map(
--            index => currRound,
--            output => roundOut
--        );
    
--    lbox: ENTITY work.l_box
--        port map(
--            input => lbox_in,
--            output => lbox_out
--        );

--    sbox: ENTITY work.sbox 
--        port map(
--        index => sbox_in,
--        output => sbox_out
--    );
    dout <= currState;

end Behavioral;
