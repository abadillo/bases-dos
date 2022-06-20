# Sistema de procesamiento de transacciones (OLTP) 

Se desarrolló un OLTP que soporta los procesos de negocio de una agencia de inteligencia ficticia. Dichos procesos incluyen, mantenimiento de empleados y estructura organizacional, y venta de piezas de inteligencia. Para la automatización de los procesos relacionados se implementó un diseño de seguridad tomando en cuenta roles, cuentas, privilegios de sistema y de objetos. El sistema OLTP fue desarrollado en su totalidad con PostgreSQL PLpgSQL.

![Modelo Entidad Relación](https://github.com/abadillo/bases-dos/blob/e4f034f5af3acfc50c94886707ff65b73c155267/modelo/vc5.png)


# Sistema de soporte a la toma de decisiones (Data Mart / DSS)

Se desarrolló un DSS que extrae y transforma la información proveniente del OLTP para la construcción de métricas y reportes. El sistema DSS fue desarrollado en su totalidad con PostgreSQL PLpgSQL y Jaspersoft Studio

![Modelo DSS](https://github.com/abadillo/bases-dos/blob/e4f034f5af3acfc50c94886707ff65b73c155267/scripts_DW/dm3.png)


## Tecnologias usadas

- Manejador de bases de datos relacional PostgreSQL 13.0
- Generador de reportes TIBCO Jaspersoft Studio
- Modelador de base de datos SQL Developer Data Modeler-Oracle

## Integrantes

- [Antonio Badillo](https://github.com/abadillo)
- [Gabriel Manrique](https://github.com/Manrique3)
- [Mickel Arroz](https://github.com/ByMJAJ)
