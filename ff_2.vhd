-- FF ESTADO DE PAGO O REGISTRO
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity ff_2 is
	port(a,b,clk, reset: in std_logic;
			 qp, qr: out std_logic);
end ff_2;
-- ARQUITECTURA
architecture funcion of ff_2 is
begin
	process (reset, clk)
		begin
			if(reset='1') then
				qp<='0'; qr<='0';
			elsif (clk'event and clk='1') then
				qp<=a; qr<=b;
			end if;
	end process;
end funcion;