-- DECIMAL A BCD
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity dec_to_bcd is
 port(teclado: in std_logic_vector (8 downto 0);
		digito: out integer range 0 to 15);
end dec_to_bcd;
-- ARQUITECTURA
architecture funcion of dec_to_bcd is
begin
	with teclado select
		digito<= 1 when "000000001",
				   2 when "000000010",
					3 when "000000100",
					4 when "000001000",
					5 when "000010000",
					6 when "000100000",
					7 when "001000000",
					8 when "010000000",
					9 when "100000000",
					0 when others;
end funcion;