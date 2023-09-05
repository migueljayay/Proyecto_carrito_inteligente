-- MEMORIA ROM
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity rom16x16 is
	port(direccion: in integer range 0 to 15;
		  clk: in std_logic;
		  q: out std_logic_vector (15 downto 0):= (others => '0'));
end rom16x16;
-- ARQUITECTURA
architecture funcion of rom16x16 is
type data_array is array (0 to 15) of std_logic_vector (15 downto 0);
constant rom: data_array:= ( -- X"RSTU"; R: PRECIO; ST: DIA DE ELABORACION Y VENCIMIENTO; U: TIPO DE PRODUCTO 
	X"9171",	X"1122",	X"B113",	X"1064",
	X"B1E5",	X"E166",	X"7187",	X"7148",
	X"C1A1",	X"D182",	X"71C3",	X"F124",
	X"7115",	X"D136",	X"E187",	X"B1B8"
	);
begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			q<=rom(direccion);
		end if;
	end process;
end funcion;