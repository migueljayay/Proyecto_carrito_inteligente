-- MEMORIA RAM 16X8
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity ram16x8 is
	port(dato: in std_logic_vector (7 downto 0);
		  direccion: in integer range 0 to 15;
		  clk, wr, reset: in std_logic;
		  q: out std_logic_vector (7 downto 0):= (others => '0'));
end ram16x8;
-- ARQUITECTURA
architecture funcion of ram16x8 is
type data_array is array (0 to 15) of std_logic_vector (7 downto 0); -- 2^N DIRECCIONES DE M BITS / DIRECCION; MATRIZ 2^N X M
																							-- EJ.: 16 DIRECCIONES DE 8 BITS
signal ram: data_array:= (
			X"00",X"00",X"00",X"00",
			X"00",X"00",X"00",X"00",
			X"00",X"00",X"00",X"00",
			X"00",X"00",X"00",X"00");
begin
	process (reset,clk)
	begin
		if (reset='1') then
				for i in 0 to 15 loop
					ram(i)<= X"00"; -- ENCERO TODAS LAS DIRECCIONES DE LA RAM
				end loop;
		elsif (clk'event and clk='1') then
			if (wr='1') then
				ram(direccion) <= dato;
			end if;
		end if;
	end process;
q<=ram(direccion);
end funcion;