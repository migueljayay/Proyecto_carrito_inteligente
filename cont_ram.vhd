--CONTADOR PARA DIRECCIONES RAM
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity cont_ram is
	port(clk, reset: in std_logic;
					  q: out integer range 0 to 15;
							fin: out std_logic);
end cont_ram;
-- ARQUITECTURA
architecture funcion of cont_ram is
signal conta: integer range 0 to 15 := 0;
begin
	process(reset,clk)
	begin
		if (reset='1') then
			conta<=0;
		elsif (clk'event and clk='1') then
				conta<= conta + 1;
		end if;
	end process;
q<=conta;
fin<= '0' when conta<15 else '1';
end funcion;