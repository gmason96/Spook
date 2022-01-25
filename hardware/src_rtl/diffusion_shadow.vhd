----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/12/2022 03:43:51 PM
-- Design Name: 
-- Module Name: diffusion_shadow - Behavioral
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

entity diffusion_shadow is
   generic(
    m:integer:= 4
   );
  Port ( 
    input: in std_logic_vector(511 downto 0);
    output: out std_logic_vector(511 downto 0)
  );
end diffusion_shadow;

architecture Behavioral of diffusion_shadow is
signal u0,v0,a0,b0,c0,d0: std_logic_vector(31 downto 0);
signal u1,v1,a1,b1,c1,d1: std_logic_vector(31 downto 0);
signal u2,v2,a2,b2,c2,d2: std_logic_vector(31 downto 0);
signal u3,v3,a3,b3,c3,d3: std_logic_vector(31 downto 0);
constant w0: std_logic_vector(31 downto 0):= input(31 downto 0);
constant x0: std_logic_vector(31 downto 0):= input(63 downto 32);
constant y0: std_logic_vector(31 downto 0):= input(95 downto 64);
constant z0: std_logic_vector(31 downto 0):= input(127 downto 96);

constant w1: std_logic_vector(31 downto 0):= input(159 downto 128);
constant x1: std_logic_vector(31 downto 0):= input(191 downto 160);
constant y1: std_logic_vector(31 downto 0):= input(223 downto 192);
constant z1: std_logic_vector(31 downto 0):= input(255 downto 224);

constant w2: std_logic_vector(31 downto 0):= input(287 downto 256);
constant x2: std_logic_vector(31 downto 0):= input(319 downto 288);
constant y2: std_logic_vector(31 downto 0):= input(351 downto 320);
constant z2: std_logic_vector(31 downto 0):= input(383 downto 352);

constant w3: std_logic_vector(31 downto 0):= input(415 downto 384);
constant x3: std_logic_vector(31 downto 0):= input(447 downto 416);
constant y3: std_logic_vector(31 downto 0):= input(479 downto 448);
constant z3: std_logic_vector(31 downto 0):= input(511 downto 480);
begin

        u0 <= w0 xor x0;
        v0 <= y0 xor z0;
        --first 32 bits
        a0 <= x0 xor v0;
        --second 32 bits
        b0 <= w0 xor v0;
        --3rd 32 bits
        c0 <= u0 xor z0;
        --bits up to 127
        d0 <= u0 xor y0;
        ----------------
        u1 <= w1 xor x1;
        v1 <= y1 xor z1;
        --first 32 bits
        a1 <= x1 xor v1;
        --second 32 bits
        b1 <= w1 xor v1;
        --3rd 32 bits
        c1 <= u1 xor z1;
        --bits up to 127
        d1 <= u1 xor y1;
        ----------------
        u2 <= w2 xor x2;
        v2 <= y2 xor z2;
        --first 32 bits
        a2 <= x2 xor v2;
        --second 32 bits
        b2 <= w2 xor v2;
        --3rd 32 bits
        c2 <= u2 xor z2;
        --bits up to 127
        d2 <= u0 xor y2;
         ----------------
       
        u3 <= w3 xor x3;
        v3 <= y3 xor z3;
        --first 32 bits
        a3 <= x3 xor v3;
        --second 32 bits
        b3 <= w3 xor v3;
        --3rd 32 bits
        c3 <= u3 xor z3;
        --bits up to 127
        d3 <= u3 xor y3;
    --may be wrong way (reverse if needed lol)
    output <= a0&b0&c0&d0 & a1&b1&c1&d1 & a2&b2&c2&d2 & a3&b3&c3&d3;
 
end Behavioral;





















