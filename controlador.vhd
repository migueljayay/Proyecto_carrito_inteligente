library ieee;
use ieee.std_logic_1164.all;
--ENTIDAD
Entity controlador is
	Port(
		 reset, clock, empezar, registro, seis, ingresar, leer, devolucion, finalizar, vacio, tres, fin_cuenta, pagar,
		 num, fin_dig, qp, qr, ok, correcto, fin_intento:	in std_logic; -- ENTRADAS DEL CONTROLADOR
 		 r_seis, r_dig, r_totales, r_intento, regist, mensaje, ingreso, leer_pr, en, guardar, devol, wr, u_d, sel, cuenta,
		 calcular, pago, eff, rff, sdig, registrar, dec: out std_logic; -- SALIDAS
		 vactual: out integer range 0 to 31); -- SALIDA PARA MOSTRAR MENSAJES
end controlador;

Architecture control of controlador is
	Type State is (TA,TB,TC,TD,TE,TF,TG,TH,TI,TJ,TK,TL,TM,TN,T0,TP,TQ,TR,TS,TT,TU,TV,TW,TX,TY,TZ);
	Signal y : State;
Begin
	Process(Reset, Clock) -- TRANSICIONES DE ESTADO
	Begin
		If Reset = '1' then y <= TA;
		elsif clock'event and clock = '1' then
			case y is
				when TA => IF empezar='1' THEN y <= TB; elsif registro='1' then y <= TP; else y<=TA; end if;				
				when TB => If seis = '1' then y <= TC; else  y <= TB; end if;	
				when TC => IF ingresar='1' THEN y <= TD; elsif devolucion='1' then y <= TI; elsif finalizar='1' then y<=TK; end if;
				when TD => if leer='1' then y<= TE; else y<=TD; end if;
				when TE => If seis = '1' then y <= TX; else  y <= TE; end if;
				when TX => y <= TF;
  				when TF => If seis = '1' then y <= TY; else  y <= TF; end if;
				when TY => y <= TG;
				when TG => If seis = '1' then y <= TZ; else  y <= TG; end if;
				when TZ => y <= TH;
				when TH => If seis = '1' then y <= TC; else  y <= TH; end if;
				when TI => If leer = '1' then y <= TJ; else  y <= TI; end if;
				when TJ => If tres = '1' then y <= TC; else  y <= TJ; end if;
				when TK => y <= TL;
				when TL => If fin_cuenta = '0' then y <= TM; else  y <= TN; end if;
				when TM => y <= TK;
				when TN => If pagar = '1' then y <= T0; else  y <= TN; end if;
				when T0 => If leer = '1' then y <= TP; else  y <= T0; end if;
				when TP => If num = '1' then y <= TQ; else  y <= TP; end if;
				when TQ => If num = '1' then y <= TQ; elsif fin_dig='1' then y <= TR; else y<= TP; end if;
				when TR => If correcto = '1' then y <= TS; else  y <= TV; end if;
				when TS => If qp = '1' then y <= TT; elsif qr='1' then y <= TU; else y<= TS; end if;
				when TT => If tres = '1' then y <= TA; else  y <= TT; end if;
				when TU => If ok = '1' then y <= TA; else  y <= TU; end if;
				when TV => If tres = '0' then y <= TV; elsif fin_intento='1' then y<=TW; else  y <= TP; end if;
				when TW => If fin_intento = '0' then y <= TP; else  y <= TW; end if;
				when others => y <= Ta;				
			end case;
		end if;
	end Process;
-- SALIDAS
-- VACtual
with y select
	vactual <=	1	when	TB,
					2	when	TC,
					3	when	TD,
					4	when	TE,
					5	when	TF,
					6	when	TG,
					7	when	TH,
					8	when	TI,
					9	when	TJ,
					10	when	TK,
					11	when	TL,
					12	when	TM,
					13	when	TN,
					14	when	T0,
					15	when	TP,
					16	when	TQ,
					17	when	TR,
					18	when	TS,
					19	when	TT,
					20	when	TU,
					21	when	TV,
					22	when	TW,
					23	when	TX,
					24	when	TY,
					25	when	TZ,
					0	when	others;

r_seis<= '1' when (y= TA or y=TC or y=TX or y=TY or y=TZ) else '0';
r_dig<= '1' when (y=TA or (y=TR and correcto='0')) else '0';
r_totales<='1' when y=TA else '0';
r_intento<='1' when y=TA else '0';
regist<='1' when y=TA else '0';
mensaje<='1' when y=TB else '0';
ingreso<='1' when (y=TD or y=TE or y=TF or y=TG or y=TH  or y=TX or y=TY or y=TZ) else '0';
leer_pr<='1' when ((y=TD and leer='1') or y=TK) else '0';
en<='1' when (y=TB or y=TE or y=TF or y=TG or y=TH or y=TJ or y=TT or y=TV) else '0';
guardar<='1' when ((y=TE and seis='1') or (y=TI and vacio='0')) else '0';
devol<= '1' when (y=TI or y=TJ) else '0';
wr<='1' when (y=TE or y=TI) else '0';
u_d<='1' when y=TI else '0';
sel<= '1' when ((y=TC and finalizar='1') or y=TK or y=TL or y=TM) else '0';
cuenta<='1' when y=TM else '0';
calcular<='1' when y=TL else '0';
pago<='1' when y=TN else '0';
eff<='1' when ((y=TA and registro='1') or (y=TN and pagar='1')) else '0';
rff<='1' when ((y=TT and tres='1') or (y=TU and ok='1')) else '0';
sdig<='1' when (y=TQ and num='1') else '0';
registrar<='1' when y=TT else '0';
End control;