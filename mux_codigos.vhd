-- MUX PARA CODIGOS
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity mux_codigos is
	port(a,b: in std_logic_vector (3 downto 0);
			sel: in std_logic;
			c: out std_logic_vector (3 downto 0));
end mux_codigos;
-- ARQUITECTURA
architecture funcion of mux_codigos is
begin
	c<= a when sel='0' else b;
end funcion;