-- VALIDADOR DE CLAVE TARJETA/REGISTRO DIARIO
library ieee;
use ieee.std_logic_1164.all;
--ENTIDAD
entity validacion is
	port(clave_ingreso: in std_logic_vector (15 downto 0);
				correcto: out std_logic);
end validacion;
-- ARQUITECTURA
architecture funcion of validacion is
constant clave_seteada_tarjeta: std_logic_vector (15 downto 0):= X"1234";
constant clave_seteada_registro: std_logic_vector (15 downto 0):= X"4321";
begin
correcto<='1' when (clave_ingreso=clave_seteada_tarjeta or clave_ingreso=clave_seteada_registro) else '0';
end funcion;
