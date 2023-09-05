-- BLOQUE DE TOTALES
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- ENTIDAD
entity totales is
	port (precio: in std_logic_vector (3 downto 0);
			cantidad: in std_logic_vector (7 downto 0);
			calcular,reset: in std_logic;
			pago_t: out std_logic_vector (9 downto 0);
			produc_t: out std_logic_vector (7 downto 0);
			produc_r: out std_logic_vector (5 downto 0));
end totales;
-- ARQUITECTURA
architecture funcion of totales is
signal acum_pago: std_logic_vector (11 downto 0):= (others => '0');
signal acum_produc: std_logic_vector (7 downto 0):= (others => '0');
signal acum_repet: std_logic_vector (5 downto 0):= (others => '0');
begin
	process(reset,calcular)
	begin
		if(reset='1') then
			acum_pago<= (others => '0'); acum_produc<= (others => '0'); acum_repet<= (others => '0');
		elsif (calcular'event and calcular='1') then
			acum_pago <= acum_pago + (precio * cantidad);
			acum_produc <= acum_produc + cantidad;
			if (cantidad > 1) then
				acum_repet <= acum_repet + 1;
			end if;
		end if;
	end process;
	pago_t<= acum_pago(9 downto 0);
	produc_t<= acum_produc;
	produc_r<= acum_repet;
end funcion;
			