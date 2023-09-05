-- CODIGO PARA REGISTRO DIARIO
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity registro_diario is
port (pago_total: in std_logic_vector(9 downto 0);
			reset,clk: in std_logic;
			recaudo: out std_logic_vector(11 downto 0);
			compras: out std_logic_vector(6 downto 0));
end registro_diario;
-- ARQUITECTURA
architecture funcion of registro_diario is
signal x: std_logic_vector (11 downto 0):= (others => '0');
signal y: std_logic_vector (6 downto 0):= (others => '0');
begin
	process(reset, clk)
	begin
		if(reset='1') then
			x<= (others => '0'); y<= (others => '0');
		elsif(clk'event and clk='1') then
			x<=x + pago_total;
			y<=y+1;
		end if;
	end process;
	recaudo<=x;
	compras<=y;
end funcion;