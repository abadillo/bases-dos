

CREATE OR REPLACE PROCEDURE VALIDAR_JERARQUIA_EMPLEADO_JEFE (id_empleado_sup IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
AS $$
DECLARE

	jefe_superior_reg EMPLEADO_JEFE%ROWTYPE;
	
BEGIN

	SELECT * INTO jefe_superior_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_sup AND tipo = tipo_va;
	
	IF (jefe_superior_reg IS NULL) THEN
		RAISE INFO 'El jefe del empleado que ingresó debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El jefe del empleado que ingresó debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;


---------/-///-/-/-/--/---/-/-/-/-/-/-/--/--//---//-/-/-/-/-/-/-/-/-/-/-/-/--/----//////--------------------



CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_EMPLEADO_JEFE(id_empleado IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
AS $$
DECLARE

	empleado_reg EMPLEADO_JEFE%ROWTYPE;
	
BEGIN

	select * into empleado_reg from EMPLEADO_JEFE where id = id_empleado AND tipo = tipo_va;
	
	IF (empleado_reg IS NULL) THEN
		RAISE INFO 'El empleado ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El empleado ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;


---------/-///-/-/-/--/---/-/-/-/-/-/-/--/--//---//-/-/-/-/-/-/-/-/-/-/-/-/--/----//////--------------------


CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_LUGAR(id_lugar IN integer, tipo_va IN LUGAR.tipo%TYPE)
AS $$
DECLARE

	lugar_reg LUGAR%ROWTYPE;
	
BEGIN

	select * into lugar_reg from LUGAR where id = id_lugar AND tipo = tipo_va;
	
	IF (lugar_reg IS NULL) THEN
		RAISE INFO 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;
