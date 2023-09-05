--CONTADOR DOWN PARA INTENTOS DE CLAVE PARA TARJETA O PARA EL REGISTRO DIARIO
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity cont_intentos is
	port(clk, reset: in std_logic;
					  q: out integer range 0 to 3;
							fin: out std_logic);
end cont_intentos;
-- ARQUITECTURA
architecture funcion of cont_intentos is
signal conta: integer range 0 to 3 := 3;
begin
	process(reset,clk)
	begin
		if (reset='1') then
			conta<=3;
		elsif (clk'event and clk='1') then
				conta<= conta-1;
		end if;
	end process;
q<=conta;
fin<= '0' when conta>0 else '1';
end funcion;