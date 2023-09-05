--CONTADOR DE 6 Y 3 SEGUNDOS PARA TIEMPO DE MENSAJES EN PANTALLA
library ieee;
use ieee.std_logic_1164.all;
-- ENTIDAD
entity seis_seg is
	port(en, clk_1hz, reset: in std_logic;
							seis,tres: out std_logic);
end seis_seg;
-- ARQUITECTURA
architecture funcion of seis_seg is
signal conta: integer range 0 to 7 := 0;
begin
	process(reset,clk_1hz)
	begin
		if (reset='1') then
			conta<=0;
		elsif (clk_1hz'event and clk_1hz='1') then
			if en='1' then
				conta<= conta + 1;
			end if;
		end if;
	end process;
seis<= '0' when conta<6 else '1';
tres<='0' when conta<3 else '1';
end funcion;
