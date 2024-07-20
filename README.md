
<div align="center">
  <img src="https://cdn.prod.website-files.com/6323af3a160e0a067e91428a/640692e652648a6b2a90d734_Group.svg" width="200" height="150">
</div>

<div align="center">

# Prueba tecnica data analytics
</div>

## Indice
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Tabla de contenido</summary>
  <ol>
    <li><a href="#Introducción">Introducción</a></li>
    <li><a href="#Objetivos">Objetivos</a></li>
    <li><a href="#Pasos">Pasos</a></li>
    <li><a href="#Diagrama">Diagrama</a></li>
    <li><a href="#Arquitectura">Arquitectura</a></li>
    <li><a href="#Riesgo">Riesgo</a></li>
    <li><a href="#Desarrollador">Desarrollador</a></li>
  </ol>
</details>

## Introducción
Esta es el repisotorio para las pruebas de la empresa Cometa para el cargo de Data Analytics.

## Objetivos
**El objetivo consister en realizar dos pruebas, una en jupyter notebook y otra en una base de datos SQL.**

La prueba 1 busca alcanzar los siguientes objetivos especificos:
- Extraer los datos, tranformarlos y cargarlos.
- Identificar y manejar los valores faltantes. 
- Eliminar o validar que no existan duplicados.
- Corregir cualquier dato malformado.

La prueba 2 busca alcanzar los siguientes objetivos especificos:
- Consultar para validar que no haya students o fulfillments repetidos.
- Consultar y analizar los ingresos del colegio para considerar que existe algún riesgo financiero o no




## Pasos
La prueba 1 fue desarrollada siguiendo los pasos a continuación:

1. Se trabajo el primer analisis en [Analisis_Limpieza_Datos.ipynb](Analisis_Limpieza_Datos.ipynb) donde se hizo los primeros pasos ,desde la carga del archivo excel hasta las tranformaciones de las columnas que daban informacion general de cada registro y las columnas relacionadas con los alumnos. Este archivo muetra parte de mi metodologia de trabajo y observaciones.
2. Luego de haber trabajado en ese archivo se guardo el dataframe como csv ([Alumnos y padres parcial.csv](Alumnos%20y%20padres%20parcial.csv))
3. Finalmente se hicieron los ultimos cambios en las columnas relacionadas a los padres leyendo el csv guardado, se hizco para tener dos jupyter distintos y no hacer tan engorrosa la documentacion, ademas de que los pasos fueron casi iguales al del primer jupiter. El archivo final y limpio es [Alumnos y padres limpio.csv](Alumnos%20y%20padres%20limpio.csv)

La prueba 2 fue desarrollada siguiendo los pasos a continuación:
1. Se cargo en una base de datos el script [db.sql](db.sql)
2. Se hicieron consultas para poder ver los datos faltantes. El archivo es [Prueba tecnica.sql](Prueba%20tecnica.sql)
3. Se hicieron consultas para poder poder analizar si hay un riesgo financiero o no(Las conclusiones estaran mas abajo)
4. Se interpreto la arquitectura de datos y se hizo un diagrama entidad relacion en base al achivo [db.sql](db.sql) (Mas abajo se mostrara)

## Diagrama

#<div align="center">
  #<img src="

## Arquitectura
**Tabla students_student**

Esta tabla almacena información sobre los estudiantes. Veamos el significado de cada columna:
1. id: Un identificador único para cada estudiante.
2. hash: Este campo podría estar relacionado con la seguridad o el hash de datos.
3. created y modified: Estas columnas registran las fechas y horas en que se creó o modificó un registro.
4. archived: Un valor booleano que indica si el estudiante está archivado o no.
5. first_name y last_name: Estos campos almacenan los nombres y apellidos del estudiante.
6. gender: El género del estudiante.
7. birthdate: La fecha de nacimiento del estudiante.
8. identifier: Un identificador adicional, como un número de matrícula.
9. created_by_id: El ID del usuario que creó el registro del estudiante.
10. school_id y section_id: Estos campos se relacionan con la escuela y la sección a la que pertenece el estudiante.
11. billing_guardian_id: El ID del responsable de facturación asociado con el estudiante probablemente.
12. enrollment_code: Un código que podria relacionarse con algun curso.
13. deleted y deleted_by_cascade: Información sobre eliminación de registros.
14. entry_date: La fecha en que el estudiante ingresó a la escuela.
15. is_active: Indica si el estudiante esta activo o no.
16. inscription_status: El estado de inscripción del estudiante.
17. is_ready: Si el estudiante está listo para comenzar.
18. state: El estado general del estudiante.

**Tabla fulfillments**

Esta tabla esta relacionada con pagos o cumplimiento de órdenes.
1. id: Un identificador único para cada registro de cumplimiento.
2. student_id: El ID del estudiante asociado con este cumplimiento.
3. order_id: El ID de la orden relacionada con este cumplimiento (por ejemplo, una factura o pedido).
4. total, total_paid y total_remaining: Estos campos almacenan información sobre los montos totales, pagados y pendientes en relación con la orden.
5. paid_date: La fecha en que se realizó el pago.
6. status: El estado del cumplimiento.
7. discount_breakdown: Un campo que podría contener detalles sobre los descuentos aplicados (generalmente en formato JSON).

**Relaciones entre las tablas**

- Segun el archivo [db.sql](db.sql) y haciendo el diagrama no pude encontrar alguna relacion entre las tablas que se pueda graficasr, pero se puede hacer alguna modificacioin en la columna "student_id" para poder aplicar el foreign key en el id de la tabla students_student.
- A pesar de esto las tablas tienen una relacion no grafica a la hora de trabajar en sql ya que se puede unir informacion de alumnos con los cumplimientos y asi poder hacer analisis.

## Riesgo

1. Analizando las consultas donde el monto total a pagar fue 30959231 mientras que la cantidad pagada 1202471, no podriamos deducir si hay un riesgo ya que no disponemos de las reservas de al institucion para ir determinando en el tiempo si la tendencia pueda ser buena o mala.
2. Tambien podemos notar que aquellos alumnos que se han inscrito han pagado casi en su totalidad el total, pero observamos que  fuero poco alumnos, por lo que puedo concluier que tal vez estan en epoca donde las clases ya estan en curso, ya que usalmente la gente suele inscribirse a principio de año
3. Tenemos alumnos en estado pendiente, es decir estan completando el proceso de inscripcion y han pagado un parte inicial del total, esto puede ser una buena señal ya que es problable que el alumno termine de realizar la inscripcion o el proceso y pague el total faltante.
4. Tambien tenemos alumnos que no han iniciado el proceso, han pagado pero podrian cancelar el pago y talvez pedir una devolucion. Esto no podria ser bueno para la institucion
5. En sintesis no puedo determianr si hay un riesgo financiero ya que estos datos fueron tomados en un determinado tiempo, aun que la sitacion respecto a los pagos pudiera ser malas, depende en que momento del año se esten tomando los datos y ademas seria importante conocer los gastos de la institucion.


## Desarrollador
<div align="center">

 
| [<img src="https://avatars.githubusercontent.com/u/44064764?v=4" width=115><br><sub>Franco Aguilera</sub>](https://github.com/franco18min) |
|:------------------------------------------------------------------------------------------------------------------------------------------:| 


Aquí esta mi Linkedin si te quieres poner en contacto conmigo: </br>

[![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/franco-aguilera-0686ba255/)

</div>
