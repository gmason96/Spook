--Author: Farris El Machtani Idrissi
--Description: Basically a 16x4 ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.design_pkg.all;

entity sboxInv is 

    port(
        index : in std_logic_vector(3 downto 0);
        output: out std_logic_vector(3 downto 0)
    );  
end entity;

architecture behavioral of sboxInv is
type MEMORY_16_4 is array (0 to 15) of std_logic_vector(3 downto 0);
    constant ROM_16_4 : MEMORY_16_4 := (
        x"0",
        x"8",
        x"1",
        x"F",
        x"2",
        x"A",
        x"7",
        x"9",
        x"4",
        x"13",
        x"5",
        x"6",
        x"E",
        x"3",
        x"B",
        x"C"
    );
    
    signal sbox_out: mem;
    signal temp: std_logic_vector(3 downto 0);
    
begin
    --encryption
    temp(3)<= (index(0) and index(1)) xor index(2);
    temp(0)<= (index(3) and index(0)) xor index(1);
    temp(1)<= (index(3) and index(0)) xor index(1);
    temp(1) <= (index(3) and index(0)) xor index(1);
    --end testing

--    genration: for I in 0 to 31 generate
--        encrypting: if decrypt ='0' generate
--            mem(I)<= 
            
            
            
        
--        end generate;
--        decrypting: if decrypt = '1' generate
        
--        end generate;
    
    output <= temp;
end behavioral;

















 