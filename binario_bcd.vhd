library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity binario_bcd is
	generic(n: integer :=7);
	port(numero: in std_logic_vector(n-1 downto 0);
		  millar, centena, decena, unidad: out integer range 0 to 15);
end binario_bcd;
-- ARQUITECTURA
architecture funcion of binario_bcd is
signal x,y,z: integer range 0 to 128;
begin
x<=(conv_integer(numero)) / 10;
y<= x/10;
z<= y/10;
unidad<= (conv_integer(numero)) mod 10;
decena<= x mod 10;
centena<= y mod 10;
millar<= z mod 10;
end funcion;