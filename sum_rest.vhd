-- CIRCUITO INCREMENTADOR Y REDUCTOR EN 1
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity sum_rest is
	port(cantidad: in std_logic_vector (7 downto 0);
		  up_down: in std_logic;
		  q: out std_logic_vector (7 downto 0);
		  vacio: out std_logic);
end sum_rest;
-- ARQUITECTURA
architecture funcion of sum_rest is
begin
 q<= cantidad + 1 when up_down='0' else (cantidad - 1);
 vacio<= '1' when cantidad=0 else '0';
end funcion;