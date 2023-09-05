----------------------------------------------------------------------------------
-- COPYRIGHT 2019 Jes�s Eduardo M�ndez Rosales
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--
--							LIBRER�A LCD 4 BITS
--
-- Descripci�n: Con �sta librer�a podr�s implementar c�digos para una LCD 16x2 de manera
-- f�cil y r�pida, con todas las ventajas de utilizar una FPGA.
--
-- Caracter�sticas:
-- 
--	Los comandos que puedes utilizar son los siguientes:
--
-- LCD_INI() -> Inicializa la lcd.
--		 			 NOTA: Dentro de los par�ntesis poner un vector de 2 bits para encender o apagar
--					 		 el cursor y activar o desactivar el parpadeo.
--
--		"1x" -- Cursor ON
--		"0x" -- Cursor OFF
--		"x1" -- Parpadeo ON
--		"x0" -- Parpadeo OFF
--
--   Por ejemplo: LCD_INI("10") -- Inicializar LCD con cursor encendido y sin parpadeo 
--	
--			
-- CHAR() -> Manda una letra may�scula o min�scula
--
--				 IMPORTANTE: 1) Debido a que VHDL no es sensible a may�sculas y min�sculas, si se quiere
--								    escribir una letra may�scula se debe escribir una "M" antes de la letra.
--								 2) Si se quiere escribir la letra "S" may�scula, se declara "MAS"
--											
-- 	Por ejemplo: CHAR(A)  -- Escribe en la LCD la letra "a"
--						 CHAR(MA) -- Escribe en la LCD la letra "A"	
--						 CHAR(S)	 -- Escribe en la LCD la letra "s"
--						 CHAR(MAS)	 -- Escribe en la LCD la letra "S"	
--	
--
-- POS() -> Escribir en la posici�n que se indique.
--				NOTA: Dentro de los par�ntesis se dene poner la posici�n de la LCD a la que se quiere ir, empezando
--						por el rengl�n seguido de la posici�n vertical, ambos n�meros separados por una coma.
--		
--		Por ejemplo: POS(1,2) -- Manda cursor al rengl�n 1, poscici�n 2
--						 POS(2,4) -- Manda cursor al rengl�n 2, poscici�n 4		
--
--
-- CHAR_ASCII() -> Escribe un caracter a partir de su c�digo en ASCII
--						 NOTA: Dentro de los parentesis escribir x"(n�mero hex.)"
--
--		Por ejemplo: CHAR_ASCII(x"40") -- Escribe en la LCD el caracter "@"
--
--
-- CODIGO_FIN() -> Finaliza el c�digo. 
--						 NOTA: Dentro de los par�ntesis poner cualquier n�mero: 1,2,3,4...,8,9.
--
--
-- BUCLE_INI() -> Indica el inicio de un bucle. 
--						NOTA: Dentro de los par�ntesis poner cualquier n�mero: 1,2,3,4...,8,9.
--
--
-- BUCLE_FIN() -> Indica el final del bucle.
--						NOTA: Dentro de los par�ntesis poner cualquier n�mero: 1,2,3,4...,8,9.
--
--
-- INT_NUM() -> Escribe en la LCD un n�mero entero.
--					 NOTA: Dentro de los par�ntesis poner s�lo un n�mero que vaya del 0 al 9,
--						    si se quiere escribir otro n�mero entero se tiene que volver
--							 a llamar la funci�n
--
--
-- CREAR_CHAR() -> Funci�n que crea el caracter dise�ado previamente en "CARACTERES_ESPECIALES.vhd"
--                 NOTA: Dentro de los par�ntesis poner el nombre del caracter dibujado (CHAR1,CHAR2,CHAR3,..,CHAR8)
--								 
--
-- CHAR_CREADO() -> Escribe en la LCD el caracter creado por medio de la funci�n "CREAR_CHAR()"
--						  NOTA: Dentro de los par�ntesis poner el nombre del caracter creado.
--
--     Por ejemplo: 
--
--				Dentro de CARACTERES_ESPECIALES.vhd se dibujan los caracteres personalizados utilizando los vectores 
--				"CHAR_1", "CHAR_2","CHAR_3",...,"CHAR_7","CHAR_8"
--
--								 '1' => [#] - Se activa el pixel de la matr�z.
--                       '0' => [ ] - Se desactiva el pixel de la matriz.
--
-- 			Si se quiere crear el				Entonces CHAR_1 queda de la siguiente
--				siguiente caracter:					manera:
--												
--				  1  2  3  4  5						CHAR_1 <=
--  		  1 [ ][ ][ ][ ][ ]							"00000"&			
-- 		  2 [ ][ ][ ][ ][ ]							"00000"&			  
-- 		  3 [ ][#][ ][#][ ]							"01010"&   		  
-- 		  4 [ ][ ][ ][ ][ ]		=====>			"00000"&			   
-- 		  5 [#][ ][ ][ ][#]							"10001"&          
-- 		  6 [ ][#][#][#][ ]							"01110"&			  
-- 		  7 [ ][ ][ ][ ][ ]							"00000"&			  
-- 		  8 [ ][ ][ ][ ][ ]							"00000";			
--
--		
--			Como el caracter se cre� en el vector "CHAR_1",entonces se escribe en las funci�nes como "CHAR1"
--			
--			CREAR_CHAR(CHAR1)  -- Crea el caracter personalizado (CHAR1)
--			CHAR_CREADO(CHAR1) -- Muestra en la LCD el caracter creado (CHAR1)		
--
-- 
--
-- LIMPIAR_PANTALLA() -> Manda a limpiar la LCD.
--								 NOTA: �sta funci�n se activa poniendo dentro de los par�ntesis
--										 un '1' y se desactiva con un '0'. 
--
--		Por ejemplo: LIMPIAR_PANTALLA('1') -- Limpiar pantalla est� activado.
--						 LIMPIAR_PANTALLA('0') -- Limpiar pantalla est� desactivado.
--
--
--	Con los puertos de entrada "CORD" y "CORI" se hacen corrimientos a la derecha y a la
--	izquierda respectivamente. NOTA: La velocidad del corrimiento se puede cambiar 
-- modificando la variable "DELAY_COR".
--
-- Algunas funci�nes generan un vector ("BLCD") cuando se termin� de ejecutar dicha funci�n y
--	que puede ser utilizado como una bandera, el vector solo dura un ciclo de INST.
--	   
--		LCD_INI() ---------- BLCD <= x"01"
--		CHAR() ------------- BLCD <= x"02"
--		POS() -------------- BLCD <= x"03"
-- 	INT_NUM() ---------- BLCD <= x"04"
--	   CHAR_ASCII() ------- BLCD <= x"05"
--	   BUCLE_INI() -------- BLCD <= x"06"
--		BUCLE_FIN() -------- BLCD <= x"07"
--		LIMPIAR_PANTALLA() - BLCD <= x"08"
--	   CREAR_CHAR() ------- BLCD <= x"09"
--	 	CHAR_CREADO() ------ BLCD <= x"0A"
--
--
--		�IMPORTANTE!
--		
--		1) Se deber� especificar el n�mero de INSTes en la constante "NUM_INSTES". El valor 
--			de la �ltima instrucci�n es el que se colocar�
--		2) En caso de utilizar a la librer�a como TOP del dise�o, se deber� comentar el puerto gen�rico y 
--			descomentar la constante "FPGA_CLK" para especificar la frecuencia de reloj.
--		3) Cada funci�n se acompa�a con " INST(NUM) <= <FUNCI�N> " como lo muestra en el c�digo
-- 		demostrativo.
--
--
--                C�DIGO DEMOSTRATIVO
--
--		CONSTANT NUM_INSTES : INTEGER := 7;
--
-- 	INST(0) <= LCD_INI("11"); 		-- INICIALIZAMOS LCD, CURSOR A HOME, CURSOR ON, PARPADEO ON.
-- 	INST(1) <= POS(1,1);				-- EMPEZAMOS A ESCRIBIR EN LA LINEA 1, POSICI�N 1
-- 	INST(2) <= CHAR(MH);				-- ESCRIBIMOS EN LA LCD LA LETRA "h" MAYUSCULA
-- 	INST(3) <= CHAR(O);			
-- 	INST(4) <= CHAR(L);
-- 	INST(5) <= CHAR(A);
-- 	INST(6) <= CHAR_ASCII(x"21"); -- ESCRIBIMOS EL CARACTER "!"
-- 	INST(7) <= CODIGO_FIN(1);	   -- FINALIZAMOS EL CODIGO
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.COMANDOS_LCD4BITS_REVC.ALL;

entity LIB_LCD4BITS_INTESC_REVC is

GENERIC(
			FPGA_CLK : INTEGER := 100_000_000
);


PORT(CLK: IN STD_LOGIC;

-----------------------------------------------------
------------------PUERTOS DE LA LCD------------------
	  RS 		  : OUT STD_LOGIC;							--
	  RW		  : OUT STD_LOGIC;							--
	  ENA 	  : OUT STD_LOGIC;							--
	  DATA_LCD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);  --
-----------------------------------------------------
-----------------------------------------------------
	  
	  
-----------------------------------------------------------
--------------ABAJO ESCRIBE TUS PUERTOS--------------------	
	 	  
	 VACTUAL: IN integer range 0 to 31;
	 MSJ, vacio : IN STD_LOGIC;
	pre_d, pre_u, fecha_d, fecha_u, pago_m,pago_c,pago_d,pago_u,
	prodt_c,prodt_d,prodt_u,prodr_d,prodr_u,reca_m,reca_c,reca_d,reca_u,compras_c,
	compras_d,compras_u: in std_logic_vector(7 downto 0);
	tipo: in integer range 0 to 7; -- obtenido de los 4 LSB de la rom
	c_dig: in std_logic_vector(2 downto 0); -- usado para mostrar asterisco en ingreso de claves
	intento: in std_logic_vector(1 downto 0) -- usado para ir mostrando los intentos que quedan en ingreso de clave
	
	
-----------------------------------------------------------
-----------------------------------------------------------

	  );

end LIB_LCD4BITS_INTESC_REVC;

architecture Behavioral of LIB_LCD4BITS_INTESC_REVC is


CONSTANT NUM_INSTES : INTEGER := 43; 	--INDICAR EL N�MERO DE INSTES PARA LA LCD


--------------------------------------------------------------------------------
-------------------------SE�ALES DE LA LCD (NO BORRAR)--------------------------
																										--
component PROCESADOR_LCD4BITS_REVC is														--
																										--
GENERIC(																								--
			FPGA_CLK : INTEGER := 50_000_000;												--
			NUM_INST : INTEGER := 1																--
);																										--
																										--
PORT( CLK 				 : IN  STD_LOGIC;														--
	   VECTOR_MEM 		 : IN  STD_LOGIC_VECTOR(8  DOWNTO 0);							--
	   C1A,C2A,C3A,C4A : IN  STD_LOGIC_VECTOR(39 DOWNTO 0);							--
	   C5A,C6A,C7A,C8A : IN  STD_LOGIC_VECTOR(39 DOWNTO 0);							--
	   RS 				 : OUT STD_LOGIC;														--
	   RW 				 : OUT STD_LOGIC;														--
	   ENA 				 : OUT STD_LOGIC;														--
	   BD_LCD 			 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			         	--
	   DATA 				 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);							--
	   DIR_MEM 			 : OUT INTEGER RANGE 0 TO NUM_INSTES					--
	);																									--
																										--
end component PROCESADOR_LCD4BITS_REVC;													--
																										--
COMPONENT CARACTERES_ESPECIALES4BITS_REVC is													--
																										--
PORT( C1,C2,C3,C4 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);								--
		C5,C6,C7,C8 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)									--
	 );																								--
																										--
end COMPONENT CARACTERES_ESPECIALES4BITS_REVC;													--
																										--
CONSTANT CHAR1 : INTEGER := 1;																--
CONSTANT CHAR2 : INTEGER := 2;																--
CONSTANT CHAR3 : INTEGER := 3;																--
CONSTANT CHAR4 : INTEGER := 4;																--
CONSTANT CHAR5 : INTEGER := 5;																--
CONSTANT CHAR6 : INTEGER := 6;																--
CONSTANT CHAR7 : INTEGER := 7;																--
CONSTANT CHAR8 : INTEGER := 8;																--
																										--
type ram is array (0 to  NUM_INSTES) of std_logic_vector(8 downto 0); 	--
signal INST : ram := (others => (others => '0'));										--
																										--
signal blcd 			  : std_logic_vector(7 downto 0):= (others => '0');		--																										
signal vector_mem 	  : STD_LOGIC_VECTOR(8  DOWNTO 0) := (others => '0');		--
signal c1s,c2s,c3s,c4s : std_logic_vector(39 downto 0) := (others => '0');		--
signal c5s,c6s,c7s,c8s : std_logic_vector(39 downto 0) := (others => '0'); 	--
signal dir_mem 		  : integer range 0 to NUM_INSTES := 0;				--
																										--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
---------------------------AGREGA TUS SE�ALES AQU�------------------------------
SIGNAL F11,F12,F13,F14,F15,F16,F17,F18,F19,F110,F111,F112,F113,F114,F115,F116: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL F21,F22,F23,F24,F25,F26,F27,F28,F29,F210,F211,F212,F213,F214,F215,F216: STD_LOGIC_VECTOR(7 DOWNTO 0);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


begin


---------------------------------------------------------------
-------------------COMPONENTES PARA LCD------------------------
																				 --
u1: PROCESADOR_LCD4BITS_REVC											 --
GENERIC map( FPGA_CLK => FPGA_CLK,									 --
				 NUM_INST => NUM_INSTES )						 --
																				 --
PORT map( CLK,VECTOR_MEM,C1S,C2S,C3S,C4S,C5S,C6S,C7S,C8S,RS, --
			 RW,ENA,BLCD,DATA_LCD, DIR_MEM );						 --
																				 --
U2 : CARACTERES_ESPECIALES4BITS_REVC								 --
PORT MAP( C1S,C2S,C3S,C4S,C5S,C6S,C7S,C8S );				 		 --
																				 --
VECTOR_MEM <= INST(DIR_MEM);											 --
																				 --
---------------------------------------------------------------
---------------------------------------------------------------


-------------------------------------------------------------------
---------------ESCRIBE TU C�DIGO PARA LA LCD-----------------------
INST(0) <= LCD_INI ("00"); -- CURSOR APAGADO
-- CREACION DE CARACTERES ESPECIALES
INST(1) <= CREAR_CHAR(1); -- INICIO DE BUCLE
INST(2) <= CREAR_CHAR(2); -- EMPEZAR A ESCRIBIR EN FILA1 COLUMNA 1
INST(3) <= CREAR_CHAR(3);
INST(4) <= CREAR_CHAR(4);
INST(5) <= CREAR_CHAR(5);
INST(6) <= CREAR_CHAR(6);
INST(7) <= BUCLE_INI(1);
-----------------------------------------
INST(8) <= POS(1,1);
INST(9) <= CHAR_CREADO(1) WHEN (VACTUAL=1 AND MSJ='1') ELSE CHAR_ASCII (F11);
INST(10) <= CHAR_CREADO(2) WHEN (VACTUAL=1 AND MSJ='1') ELSE CHAR_ASCII (F12);
INST(11) <= CHAR_CREADO(3) WHEN (VACTUAL=1 AND MSJ='1') ELSE CHAR_ASCII (F13);
INST(12) <= CHAR_ASCII (F14);
INST(13) <= CHAR_ASCII (F15);
INST(14) <= CHAR_ASCII (F16);
INST(15) <= CHAR_ASCII (F17);
INST(16) <= CHAR_ASCII (F18);
INST(17) <= CHAR_ASCII (F19);
INST(18) <= CHAR_ASCII (F110);
INST(19) <= CHAR_ASCII (F111);
INST(20) <= CHAR_ASCII (F112);
INST(21) <= CHAR_ASCII (F113);
INST(22) <= CHAR_ASCII (F114);
INST(23) <= CHAR_ASCII (F115);
INST(24) <= CHAR_ASCII (F116);
------------------------------------------
INST(25) <= POS(2,1);
INST(26) <= CHAR_CREADO(4) WHEN (VACTUAL=1 AND MSJ='1') ELSE CHAR_ASCII (F21);
INST(27) <= CHAR_CREADO(5) WHEN (VACTUAL=1 AND MSJ='1') ELSE CHAR_ASCII (F22);
INST(28) <= CHAR_CREADO(6) WHEN (VACTUAL=1 AND MSJ='1') ELSE CHAR_ASCII (F23);
INST(29) <= CHAR_ASCII (F24);
INST(30) <= CHAR_ASCII (F25);
INST(31) <= CHAR_ASCII (F26);
INST(32) <= CHAR_ASCII (F27);
INST(33) <= CHAR_ASCII (F28);
INST(34) <= CHAR_ASCII (F29);
INST(35) <= CHAR_ASCII (F210);
INST(36) <= CHAR_ASCII (F211);
INST(37) <= CHAR_ASCII (F212);
INST(38) <= CHAR_ASCII (F213);
INST(39) <= CHAR_ASCII (F214);
INST(40) <= CHAR_ASCII (F215);
INST(41) <= CHAR_ASCII (F216);
-----------------------------------------
INST(42) <= BUCLE_FIN(1);
INST(43) <= CODIGO_FIN (1); -- FIN DE CODIGO

-------------------------------------------------------------------
-------------------------------------------------------------------




-------------------------------------------------------------------
--------------------ESCRIBE TU C�DIGO DE VHDL----------------------
PROCESS (VACTUAL,MSJ)
begin

	IF (VACTUAL=1 AND MSJ='1') THEN
--		F13<=X"42";F14<=X"49";F15<=X"45";F16<=X"4e";F17<=X"56";F18<=X"45";F19<=X"4e";
--		F110<=X"49";F111<=X"44";F112<=X"4f"; F113
--		(F11&F12&F13&F14&F15&F16&F17&F18&F19&F110&F111&F112&F113&F114&F115&F116)<=X"202020204249454e56454e49444f2041"; -- BIENVENIDO A
--		(F21&F22&F23&F24&F25&F26&F27&F28&F29&F210&F211&F212&F213&F214&F215&F216)<=X"2020202020204d4547414d4158492020"; -- MEGAMAXI
	F11<=X"20";	F12<=X"20";	F13<=X"20";	F14<=X"20";	F15<=X"42";	F16<=X"49";	F17<=X"45";	F18<=X"4e";	F19<=X"56";	F110<=X"45";	F111<=X"4e";	F112<=X"49";	F113<=X"44";	F114<=X"4f";	F115<=X"20";	F116<=X"41"; -- BIENVENIDO A
   F21<=X"20";	F22<=X"20";	F23<=X"20";	F24<=X"20";	F25<=X"20";	F26<=X"20";	F27<=X"4d";	F28<=X"45";	F29<=X"47";	F210<=X"41";	F211<=X"4d";	F212<=X"41";	F213<=X"58";	F214<=X"49";	F215<=X"20";	F216<=X"20"; -- MEGAMAXI
	
	
	ELSIF (VACTUAL=2) THEN
		F11<=X"49";		F21<=X"20";
		F12<=X"6e";		F22<=X"20";
		F13<=X"67";		F23<=X"20";
		F14<=X"72";		F24<=X"20";
		F15<=X"65";		F25<=X"20";
		F16<=X"73";		F26<=X"20";
		F17<=X"65";		F27<=X"20";
		F18<=X"2c";		F28<=X"20";
		F19<=X"64";		F29<=X"20";
		F110<=X"65";	F210<=X"20";
		F111<=X"76";	F211<=X"20";
		F112<=X"75";	F212<=X"20";
		F113<=X"65";	F213<=X"20";
		F114<=X"6c";	F214<=X"20";
		F115<=X"76";	F215<=X"20";
		F116<=X"61";	F216<=X"20";



	ELSIF (VACTUAL=3) THEN
--		(F11&F12&F13&F14&F15&F16&F17&F18&F19&F110&F111&F112&F113&F114&F115&F116)<=X"20202020202020202020202020202020";
--		(F21&F22&F23&F24&F25&F26&F27&F28&F29&F210&F211&F212&F213&F214&F215&F216)<=X"4348414f202020202020202020202020"; -- CHAO
			F11<=X"20";	F21<=X"43";
			F12<=X"20";	F22<=X"48";
			F13<=X"20";	F23<=X"41";
			F14<=X"20";	F24<=X"4f";
			F15<=X"20";	F25<=X"20";
			F16<=X"20";	F26<=X"20";
			F17<=X"20";	F27<=X"20";
			F18<=X"20";	F28<=X"20";
			F19<=X"20";	F29<=X"20";
			F110<=X"20";	F210<=X"20";
			F111<=X"20";	F211<=X"20";
			F112<=X"20";	F212<=X"20";
			F113<=X"20";	F213<=X"20";
			F114<=X"20";	F214<=X"20";
			F115<=X"20";	F215<=X"20";
			F116<=X"20";	F216<=X"20";
	
	ELSE
--		(F11&F12&F13&F14&F15&F16&F17&F18&F19&F110&F111&F112&F113&F114&F115&F116)<=X"20202020202020202020202020202020";
--		(F21&F22&F23&F24&F25&F26&F27&F28&F29&F210&F211&F212&F213&F214&F215&F216)<=X"20202020202020202020202020202020";

			F11<=X"20";	F21<=X"20";
			F12<=X"20";	F22<=X"20";
			F13<=X"20";	F23<=X"20";
			F14<=X"20";	F24<=X"20";
			F15<=X"20";	F25<=X"20";
			F16<=X"20";	F26<=X"20";
			F17<=X"20";	F27<=X"20";
			F18<=X"20";	F28<=X"20";
			F19<=X"20";	F29<=X"20";
			F110<=X"20";	F210<=X"20";
			F111<=X"20";	F211<=X"20";
			F112<=X"20";	F212<=X"20";
			F113<=X"20";	F213<=X"20";
			F114<=X"20";	F214<=X"20";
			F115<=X"20";	F215<=X"20";
			F116<=X"20";	F216<=X"20";

	END IF;

END PROCESS;

-------------------------------------------------------------------
-------------------------------------------------------------------





end Behavioral;

