-- SE HARA UNA VALIDACION DE DATOS DUPLICADOS EN LA TABLA  PARA IR HACIENDO OBSERVACIONES
-- Ver id duplicados
SELECT id, COUNT(*)
FROM students_student
GROUP BY id
HAVING COUNT(*) > 1;
--Sin observaciones

-- Verificamos que no haya matriculas duplicadas
SELECT identifier, COUNT(*)
FROM students_student
GROUP BY identifier
HAVING COUNT(*) > 1;
--Tenemos varias matriculas duplicadas, lo cual es un error importante, ya que la idea de que una alumno tenga su matricula es que sea su unica

-- Verificamos que no haya alumnos duplicados segun el nombre, apellido y fecha de nacimiento
SELECT first_name, last_name, birthdate, COUNT(*) FROM students_student
GROUP BY first_name, last_name, birthdate
HAVING COUNT(*) > 1;
--Tenemos alumnos con nombres y apellidos iguales,podria ser determinante para saber si es la misma persona, pero lo podemos confirmar con la fecha de nacimiento

-- Vamos a ver los nombres y apellidos de los alumnos que tienen el mismo de order_id
SELECT f.order_id, s.first_name, s.last_name
FROM fulfillments f
JOIN students_student s ON f.student_id = s.id::text
WHERE f.order_id IN (
    SELECT order_id
    FROM fulfillments
    GROUP BY order_id
    HAVING COUNT(*) > 1
);
--Tenemos id de ordenes iguales y para diferentes personas por lo que considero un error ya que puede afectar a la integridad  de lso datos

--VAMOS A ANALIZAR SI EXISTE UN RIESGO FINANCIERO EN BASE A LOS ALUMNOS QUE PAGARON COMO LA DEUDA TOTAL
SELECT
    SUM(total) AS monto_total_a_pagar,
    SUM(total_paid) AS monto_total_pagado
FROM fulfillments;

--El monto total es 30959231 mientras que la cantidad pagada 1202471, esto podria indicar un riesgo como tambien no, ya que tampoco sabemos el prespuesto del colegio
--
SELECT
    s.inscription_status AS estado_inscripcion,
    SUM(f.total) AS monto_total_a_pagar,
    SUM(f.total_paid) AS monto_total_pagado,
    SUM(f.total - f.total_paid) AS diferencia
FROM students_student s
JOIN fulfillments f ON s.id = f.student_id :: UUID
GROUP BY s.inscription_status;
--Podemos notar que los alumnos incriptos ya han pagado casi en su totalidad el total, tambien notamos que que hay muchas inscripciones pendientes
--Las inscripciones pendientes son buenas señales ya que si algunos han pagado de antemano y estan en proceso de inscripcion, probablemente terminando pagando el total
--Los inscriptos tal vez no sean una buena señal ya que a pesar del estado podrian ser mas propensos a pedi un reembolso y terminar el proceso

--LA CONCLUSION DEL RIESGO FINANCIERO ESTARA EN EL README EN BASE EL ANALISIS QUE HICE AQUI.

