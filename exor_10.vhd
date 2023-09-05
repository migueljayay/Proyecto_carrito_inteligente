-- VALIDACION DE INGRESO DE NUMERO
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity exor_10 is
 port(teclado: in std_logic_vector (9 downto 0);
		num: out std_logic);
end exor_10;
-- ARQUITECTURA
architecture funcion of exor_10 is
begin
	num<= (teclado(9) xor teclado (8) xor teclado (7) xor teclado (6) xor teclado (5) xor teclado (4) xor teclado (3) xor teclado (2) xor teclado (1) xor teclado (0));
end funcion;