--DIGITOS INGRESADOS
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity digitos is
	port(clk, reset: in std_logic;
				 digito: in std_logic_vector(3 downto 0);
					  clave_ingr: out std_logic_vector (15 downto 0);
					  fin_dig: out std_logic;
					  c_digitos: out integer range 0 to 7
					  );
end digitos;
-- ARQUITECTURA
architecture funcion of digitos is
signal conta: integer range 0 to 7 := 0;
signal numero: std_logic_vector (15 downto 0):= (others => '0');
begin
	process(reset,clk)
	begin
		if (reset='1') then
			conta<=0; numero<= (others => '0');
		elsif (clk'event and clk='1') then
				conta<= conta+1;
				numero <= numero (11 downto 0) & digito;
		end if;
	end process;
clave_ingr<= numero;
c_digitos<=conta;
fin_dig<='0' when conta<4 else '1';
end funcion;