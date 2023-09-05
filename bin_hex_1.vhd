-- BCD A PALABRA HEXADECIMAL SIN CONSIDERAR EL CERO.
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity bin_hex_1 is
	port(numero: in std_logic_vector (3 downto 0);
			n_hex: out std_logic_vector (7 downto 0));
end bin_hex_1;
--ARQUITECTURA
architecture funcion of bin_hex_1 is
begin
n_hex<= "0011"&numero when (numero>"0000") else X"20";
end funcion;