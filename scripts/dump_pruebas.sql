 
-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.dept_deptno_seq;

CREATE SEQUENCE public.dept_deptno_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.emp_empno_seq;

CREATE SEQUENCE public.emp_empno_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.producto_prodid_seq;

CREATE SEQUENCE public.producto_prodid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.dept definition

-- Drop table

-- DROP TABLE public.dept;

CREATE TABLE public.dept (
	deptno serial4 NOT NULL,
	dname varchar(50) NOT NULL,
	loc varchar(50) NOT NULL,
	CONSTRAINT pk_deptno PRIMARY KEY (deptno)
);


-- public.producto definition

-- Drop table

-- DROP TABLE public.producto;

CREATE TABLE public.producto (
	prodid serial4 NOT NULL,
	descrip varchar(100) NULL,
	CONSTRAINT pk_prodid PRIMARY KEY (prodid)
);

-- Table Triggers

create trigger modif_producto before
insert
    or
delete
    or
update
    on
    public.producto for each row execute function verif_hora();


-- public.emp definition

-- Drop table

-- DROP TABLE public.emp;

CREATE TABLE public.emp (
	empno serial4 NOT NULL,
	ename varchar(50) NOT NULL,
	job varchar(50) NOT NULL,
	hiredate date NOT NULL,
	deptno int4 NOT NULL,
	sal numeric(10) NULL,
	comm numeric(10) NULL,
	mgr int4 NULL,
	CONSTRAINT pk_empno PRIMARY KEY (empno),
	CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES public.dept(deptno),
	CONSTRAINT fk_mgr FOREIGN KEY (mgr) REFERENCES public.emp(empno)
);



CREATE OR REPLACE PROCEDURE public.consulta(id integer)
 LANGUAGE plpgsql
AS $procedure$
	DECLARE
	salario integer;
	cargo varchar;
	BEGIN
		SELECT sal, job
		INTO salario,cargo
		FROM emp WHERE empno=id;
		RAISE NOTICE 'RESULTADO DE SALARIO: % RESULTA DEL CARGO: %',salario,cargo;
		--SELECT job
		--INTO cargo
		--FROM emp WHERE empno=id;
		--RAISE NOTICE 'RESULTADO CARGO: % ',cargo;
	END
$procedure$
;

CREATE OR REPLACE PROCEDURE public.consulta()
 LANGUAGE plpgsql
AS $procedure$
	DECLARE
	salario record;
	cargo record;
	BEGIN
		SELECT sal
		INTO salario
		FROM emp;
		RAISE NOTICE 'RESULTADO % ',salario;
		SELECT job
		INTO cargo
		FROM emp;
		RAISE NOTICE 'RESULTA % ',cargo;
	END
$procedure$
;

CREATE OR REPLACE PROCEDURE public.consulta_nueva(id integer, INOUT salario integer, INOUT cargo character varying)
 LANGUAGE plpgsql
AS $procedure$
	BEGIN
		SELECT sal,job
		INTO salario, cargo
		FROM emp WHERE empno=id;
	END
$procedure$
;

CREATE OR REPLACE PROCEDURE public.dele_producto(id integer)
 LANGUAGE plpgsql
AS $procedure$
declare
	codigo record;
	BEGIN
	SELECT prodid
	INTO codigo
	FROM producto
	WHERE prodid=id;
	--RAISE NOTICE 'NO HIZO NADA';
	/*exception
		when no_data_found then
			DELETE FROM producto
			WHERE  prodid = id;
	*/
	if codigo is null then
		RAISE EXCEPTION 'NO SE PUEDE ELIMINAR %',id;
	else
		DELETE FROM producto
			WHERE  prodid = id;
	end if;
	END
$procedure$
;

CREATE OR REPLACE PROCEDURE public.eliminar_producto(v_prodid integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
--- Variables

	temp producto;

BEGIN

	select * into temp from PRODUCTO where prodid = v_prodid;

	raise notice 'producto con id % se va a eliminar', temp.prodid;

--	exception
--	when no_data_found then
--	      raise exception 'no se encontro el producto de id %', v_prodid;

	if temp is null then
		raise exception 'no se encontro el producto de id %', v_prodid;

	else
		delete from PRODUCTO where prodid = v_prodid;

	end if;

	-- commit;

end $procedure$
;

CREATE OR REPLACE PROCEDURE public.fallo()
 LANGUAGE plpgsql
AS $procedure$
	BEGIN
		IF
			current_time >= cast ('9:00:00.0' as time) and current_time <= cast ('17:00:00.0' as time) then
   			raise notice 'malo %', CURRENT_TIME ;
  		ELSE
    		raise notice 'bueno %', CURRENT_TIME ;
			COMMIT;
		END IF;
	END
$procedure$
;

CREATE OR REPLACE PROCEDURE public.insert_producto(id integer, descripcion character varying)
 LANGUAGE plpgsql
AS $procedure$
	BEGIN
		if found THEN
			RAISE EXCEPTION 'Ya existe';
		else
			RAISE NOTICE 'Se agregó el producto';
		END if;
		INSERT INTO producto VALUES (id,descripcion);
	END
$procedure$
;

CREATE OR REPLACE PROCEDURE public.insertar_producto(v_prodid integer, v_descrip character varying)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
--- Variables

BEGIN

	insert into PRODUCTO values (v_prodid, v_descrip);
--	commit;

end $procedure$
;

CREATE OR REPLACE FUNCTION public.sal_anual(sal_mensual numeric, comision numeric)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
begin

--	if comision is null then comision = 0; end if;
--
--	if sal_mensual is null then sal_mensual = 0; end if;
--	return (sal_mensual*12) + comision;

	return (COALESCE(sal_mensual,0)*12) + COALESCE(comision,0);

end;
$function$
;

CREATE OR REPLACE FUNCTION public.sal_anual(sal_mensual integer, comision integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
begin

	return (sal_mensual*12) + comision;


end;
$function$
;

CREATE OR REPLACE FUNCTION public.salario(salario numeric, comision numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
	BEGIN
	IF comision IS NULL THEN
	 	RETURN salario*12;
	END IF;
	IF salario IS NULL THEN
		RETURN 0;
	END IF;
	RETURN((salario*12)+comision);
	END;

$function$
;

CREATE OR REPLACE FUNCTION public.salario(id integer, salario numeric, comision numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
	BEGIN
	IF comision IS NULL THEN
	 	--RETURN salario*12;
		RETURN 0;
	END IF;
	RETURN((salario*12)+comision);
	END;

$function$
;

CREATE OR REPLACE FUNCTION public.salario_anual(salario numeric, comision numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
	BEGIN

	RETURN(COALESCE(salario,0)*12 + COALESCE(comision,0));
	END;

$function$
;

CREATE OR REPLACE PROCEDURE public.sel_salario_cargo_emp(v_empno integer, INOUT v_sal numeric, INOUT v_job character varying)
 LANGUAGE plpgsql
AS $procedure$

BEGIN

  	select
  		job, sal into v_job, v_sal
  	from
  		emp
  	where
  		empno = v_empno;



end $procedure$
;

CREATE OR REPLACE FUNCTION public.verif_hora()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin

	if current_time >= cast ('9:00:00.0' as time) and current_time <= cast ('17:00:00.0' as time) then

		raise exception 'malo % -- %', CURRENT_TIME , cast ('9:00:00.0' as time);
		return null;


	else

		raise notice 'bueno % -- %', CURRENT_TIME , cast ('17:00:00.0' as time);

		IF (TG_OP = 'DELETE') THEN
			return old;
		else
			return new;
		end if;




	end if;

end;
$function$
;
