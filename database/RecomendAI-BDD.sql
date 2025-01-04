-- i. Top 10 de contenidos (a su criterio) que tengan al menos 100 puntuaciones.
SELECT C.ID, C.TITULO, SUM(CC.PUNTUACION) PUNTUACION_TOTAL
FROM CONTENIDO C
JOIN CONTENIDOCONVERSACION CC ON C.ID = CC.IDCONTENIDO
GROUP BY C.ID, C.TITULO
HAVING PUNTUACION_TOTAL >= 100
ORDER BY PUNTUACION_TOTAL DESC
LIMIT 10;

-- ii. Por cada formato, mostrar cantidad de contenidos, de recomendaciones hechas, de consumidas y promedio de puntuación global.
SELECT T.ID, T.NOMBRE, COUNT(DISTINCT C.ID) CANTIDAD_CONTENIDOS, COUNT(DISTINCT CC.IDCONVERSACION) RECOMENDACIONES, COUNT(CC.CONSUMIO) CONSUMIDOS, AVG(CC.PUNTUACION) PUNTUACION_GLOBAL
FROM TIPO T
LEFT JOIN CONTENIDO C ON T.ID = C.IDTIPO
LEFT JOIN CONTENIDOCONVERSACION CC ON C.ID = CC.IDCONTENIDO
GROUP BY T.ID, T.NOMBRE;

-- iii. Armar una playlist de recomendadas con canciones emocionantes para cuando estás aburrido.
SELECT DISTINCT C.ID, C.TITULO
FROM CONTENIDO C
JOIN CONTENIDOCARACTERISTICAEMOCION CCE ON C.ID = CCE.IDCONTENIDO
WHERE EXISTS (
			SELECT 1
            FROM CARACTERISTICA CAR
            WHERE CAR.NOMBRE LIKE 'EMOCIONANTE'
            AND CAR.ID = CCE.IDCARACTERISTICA
)AND EXISTS(
			SELECT 1
            FROM TIPO T
            WHERE T.NOMBRE LIKE 'CANCION'
            AND T.ID = C.IDTIPO
)AND EXISTS(
			SELECT 1
            FROM EMOCION E
            WHERE E.NOMBRE LIKE 'ABURRIDO'
            AND E.ID = CCE.IDEMOCION
);

-- iv. Saga de películas más “atrapante” del catálogo
SELECT C.ID, C.TITULO, SUM(CCE.PESO_GLOBAL) PESO_GLOBAL_TOTAL
FROM CONTENIDO C 
JOIN CONTENIDOCONTENIDO CC ON CC.IDCONTENIDOPADRE = C.ID
JOIN CONTENIDOCARACTERISTICAEMOCION CCE ON CCE.IDCONTENIDO = C.ID
LEFT JOIN (
			SELECT CCE.IDCONTENIDO ID
			FROM CONTENIDOCARACTERISTICAEMOCION CCE
			WHERE EXISTS(
						SELECT 1
						FROM CARACTERISTICA CAR
						WHERE CAR.NOMBRE LIKE 'ATRAPANTE' AND CAR.ID = CCE.IDCARACTERISTICA
					)
) AS CA ON CA.ID = C.ID
GROUP BY C.ID, C.TITULO
HAVING SUM(CCE.PESO_GLOBAL) = (
								SELECT MAX(ST.PESO_GLOBAL)
                                FROM(
									SELECT SUM(PESO_GLOBAL) PESO_GLOBAL
                                    FROM CONTENIDOCONTENIDO CC1
                                    JOIN CONTENIDOCARACTERISTICAEMOCION CCE ON CCE.IDCONTENIDO = CC1.IDCONTENIDOPADRE
                                    GROUP BY CC1.IDCONTENIDOPADRE
                                ) AS ST
);

-- v. Personas que participen de alguna manera en contenidos de todos los formatos posibles.
SELECT P.ID ID_PARTICIPE, P.NOMBRE
FROM PARTICIPE P
WHERE NOT EXISTS(
				SELECT 1
                FROM TIPO T
                WHERE NOT EXISTS(
								SELECT 1
                                FROM CONTENIDO C
                                JOIN ROLPARTICIPECONTENIDO RPC ON C.ID = RPC.IDCONTENIDO
                                WHERE RPC.IDPARTICIPE = P.ID
                                AND C.IDTIPO = T.ID
                )
);

-- vi. Elaborar una consulta interesante para este modelo. Enunciarla en lenguaje natural y en SQL
-- Consulta: Se quiere conocer a los usuarios que presentan mayor versatilidad emocional
SELECT U.ID, U.EMAIL, COUNT(DISTINCT ECU.IDEMOCION)
FROM USUARIO U 
JOIN CONVERSACIONEMOCIONUSUARIO ECU ON U.ID = ECU.IDUSUARIO
GROUP BY U.ID, U.EMAIL, ECU.IDEMOCION
ORDER BY ECU.IDEMOCION DESC;

-- vii. Generar una vista de la ficha técnica de un contenido cualquiera.
CREATE VIEW Ficha_tecnica AS
SELECT c.id AS id_contenido, c.titulo AS titulo, t.nombre AS formato, c.duracion AS duracion, c.año AS año_publicación, p.nombre AS pais_origen, t.nombre AS tipo, car.nombre AS caracteristica, g.nombre AS género, te.nombre AS temática
FROM contenido c JOIN pais p ON c.idPais = p.id
				JOIN tipo t ON c.idTipo = t.id
				LEFT JOIN contenidocaracteristicaemocion cce ON c.id = cce.idContenido
				LEFT JOIN caracteristica car ON cce.idCaracteristica = car.id
                LEFT JOIN contenidogenero cg on c.id = cg.idContenido
                LEFT JOIN genero g on cg.idGenero = g.id
                left JOIN contenidotematica ct on ct.idContenido = c.id
                left JOIN tematica te on tE.id = ct.idTematica;				
-- Verificacion con "contenido cualquiera"
SELECT * 
FROM Ficha_tecnica 
WHERE id_contenido = 1;
