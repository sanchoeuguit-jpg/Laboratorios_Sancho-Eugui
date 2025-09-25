-- 1. Listar todas las canciones con el nombre de su álbum y artista
SELECT c.titulo AS cancion, a.titulo AS album, ar.nombre AS artista
FROM canciones c
JOIN albumes a ON c.id_album = a.id_album
JOIN artistas ar ON a.id_artista = ar.id_artista;

-- 2. Mostrar usuarios y el plan al que están suscritos
SELECT u.nombre, p.nombre AS plan, s.estado
FROM usuarios u
JOIN suscripciones s ON u.id_usuario = s.id_usuario
JOIN planes p ON s.id_plan = p.id_plan;

-- 3. Ver playlists de cada usuario junto con cuántas canciones contiene
SELECT u.nombre, pl.nombre AS playlist, COUNT(pc.id_cancion) AS num_canciones
FROM usuarios u
JOIN playlists pl ON u.id_usuario = pl.id_usuario
LEFT JOIN playlist_canciones pc ON pl.id_playlist = pc.id_playlist
GROUP BY pl.id_playlist;

-- 4. Listar historial de reproducción con nombre de usuario y canción
SELECT h.fecha_reproduccion, u.nombre, c.titulo
FROM historial h
JOIN usuarios u ON h.id_usuario = u.id_usuario
JOIN canciones c ON h.id_cancion = c.id_cancion;

-- 5. Mostrar canciones y si tienen likes, junto con el usuario que dio like
SELECT c.titulo, u.nombre AS usuario_like
FROM canciones c
LEFT JOIN likes l ON c.id_cancion = l.id_cancion
LEFT JOIN usuarios u ON l.id_usuario = u.id_usuario;

-- 6. Usuarios que tienen más de 1 playlist
SELECT u.nombre, COUNT(pl.id_playlist) AS total_playlists
FROM usuarios u
JOIN playlists pl ON u.id_usuario = pl.id_usuario
GROUP BY u.id_usuario
HAVING COUNT(pl.id_playlist) >1;

-- 7. Canciones con más reproducciones que el promedio global
SELECT titulo, reproducciones
FROM canciones
WHERE reproducciones > (SELECT AVG(reproducciones) FROM canciones);

-- 8. Artistas con al menos un álbum que tenga más de 3 canciones
SELECT DISTINCT ar.nombre
FROM artistas ar
JOIN albumes a ON ar.id_artista = a.id_artista
JOIN canciones c ON a.id_album = c.id_album
GROUP BY a.id_album
HAVING COUNT(c.id_cancion) > 3;

-- 9. Usuarios que dieron like a la canción más popular
SELECT DISTINCT u.nombre
FROM usuarios u
JOIN likes l ON u.id_usuario = l.id_usuario
WHERE l.id_cancion = (
    SELECT id_cancion
    FROM canciones
    ORDER BY reproducciones DESC
    LIMIT 1
);

-- 10. Canciones reproducidas por más de 2 usuarios distintos
SELECT c.titulo, COUNT(DISTINCT h.id_usuario) AS usuarios
FROM canciones c
JOIN historial h ON c.id_cancion = h.id_cancion
GROUP BY c.id_cancion
HAVING COUNT(DISTINCT h.id_usuario) > 2;

-- 11. Top 5 canciones más reproducidas
SELECT titulo, reproducciones
FROM canciones
ORDER BY reproducciones DESC
LIMIT 5;

-- 12. Cantidad total de likes por artista
SELECT ar.nombre, COUNT(l.id_like) AS total_likes
FROM artistas ar
JOIN albumes a ON ar.id_artista = a.id_artista
JOIN canciones c ON a.id_album = c.id_album
LEFT JOIN likes l ON c.id_cancion = l.id_cancion
GROUP BY ar.id_artista;

-- 13. Promedio de duración de canciones por género
SELECT a.genero, SEC_TO_TIME(AVG(TIME_TO_SEC(c.duracion))) AS duracion_promedio
FROM canciones c
JOIN albumes a ON c.id_album = a.id_album
GROUP BY a.genero;

-- 14. Número de usuarios suscritos a cada plan
SELECT p.nombre, COUNT(s.id_usuario) AS total_usuarios
FROM planes p
LEFT JOIN suscripciones s ON p.id_plan = s.id_plan
GROUP BY p.id_plan;

-- 15. El usuario con más reproducciones en el historial
SELECT u.nombre, COUNT(h.id_historial) AS total_reproducciones
FROM usuarios u
JOIN historial h ON u.id_usuario = h.id_usuario
GROUP BY u.id_usuario
ORDER BY total_reproducciones DESC
LIMIT 1;

-- 16. Las 10 canciones más reproducidas
SELECT titulo, reproducciones
FROM canciones
ORDER BY reproducciones DESC
LIMIT 10;

-- 17. Usuarios que tienen plan activo
SELECT u.nombre, p.nombre AS plan
FROM usuarios u
JOIN suscripciones s ON u.id_usuario = s.id_usuario
JOIN planes p ON s.id_plan = p.id_plan
WHERE s.estado = 'Activo';

-- 18. Listar las playlists con su cantidad respectiva de canciones
SELECT pl.nombre, COUNT(pc.id_cancion) AS total_canciones
FROM playlists pl
LEFT JOIN playlist_canciones pc ON pl.id_playlist = pc.id_playlist
GROUP BY pl.id_playlist;

-- 19. Listar las canciones reproducidas el último mes
SELECT DISTINCT c.titulo
FROM canciones c
JOIN historial h ON c.id_cancion = h.id_cancion
WHERE h.fecha_reproduccion >= DATE_SUB(NOW(), INTERVAL 1 MONTH);

-- 20. Usuarios que escucharon un mismo artista más de 2 veces
SELECT u.nombre, ar.nombre AS artista, COUNT(*) AS reproducciones
FROM historial h
JOIN usuarios u ON h.id_usuario = u.id_usuario
JOIN canciones c ON h.id_cancion = c.id_cancion
JOIN albumes a ON c.id_album = a.id_album
JOIN artistas ar ON a.id_artista = ar.id_artista
GROUP BY u.id_usuario, ar.id_artista
HAVING COUNT(*) > 2;

-- 21. Canciones con duración mayor al promedio
SELECT titulo, duracion
FROM canciones
WHERE TIME_TO_SEC(duracion) > (
    SELECT AVG(TIME_TO_SEC(duracion)) FROM canciones
);

-- 22. Álbum con más reproducciones totales
SELECT a.titulo, SUM(c.reproducciones) AS total_reproducciones
FROM albumes a
JOIN canciones c ON a.id_album = c.id_album
GROUP BY a.id_album
ORDER BY total_reproducciones DESC
LIMIT 1;

-- 23. Género musical más popular según reproducciones
SELECT a.genero, SUM(c.reproducciones) AS total
FROM albumes a
JOIN canciones c ON a.id_album = c.id_album
GROUP BY a.genero
ORDER BY total DESC
LIMIT 1;

-- 24. Usuario con más likes dados
SELECT u.nombre, COUNT(l.id_like) AS total_likes
FROM usuarios u
JOIN likes l ON u.id_usuario = l.id_usuario
GROUP BY u.id_usuario
ORDER BY total_likes DESC
LIMIT 1;

-- 25. Canciones que nunca han sido reproducidas
SELECT titulo
FROM canciones
WHERE id_cancion NOT IN (SELECT id_cancion FROM historial);

-- 26. Playlists con canciones de más de 2 géneros diferentes
SELECT pl.nombre, COUNT(DISTINCT a.genero) AS generos
FROM playlists pl
JOIN playlist_canciones pc ON pl.id_playlist = pc.id_playlist
JOIN canciones c ON pc.id_cancion = c.id_cancion
JOIN albumes a ON c.id_album = a.id_album
GROUP BY pl.id_playlist
HAVING COUNT(DISTINCT a.genero) > 2;

-- 27. Usuarios que escucharon canciones de al menos 3 artistas distintos
SELECT u.nombre, COUNT(DISTINCT ar.id_artista) AS artistas
FROM usuarios u
JOIN historial h ON u.id_usuario = h.id_usuario
JOIN canciones c ON h.id_cancion = c.id_cancion
JOIN albumes a ON c.id_album = a.id_album
JOIN artistas ar ON a.id_artista = ar.id_artista
GROUP BY u.id_usuario
HAVING COUNT(DISTINCT ar.id_artista) >= 3;

-- 28. Ranking de artistas por número de oyentes únicos
SELECT ar.nombre, COUNT(DISTINCT h.id_usuario) AS oyentes
FROM artistas ar
JOIN albumes a ON ar.id_artista = a.id_artista
JOIN canciones c ON a.id_album = c.id_album
JOIN historial h ON c.id_cancion = h.id_cancion
GROUP BY ar.id_artista
ORDER BY oyentes DESC;

-- 29. Plan con mayor ingreso generado
SELECT p.nombre, SUM(p.precio) AS ingreso
FROM planes p
JOIN suscripciones s ON p.id_plan = s.id_plan
WHERE s.estado = 'Activo'
GROUP BY p.id_plan
ORDER BY ingreso DESC
LIMIT 1;

-- 30. Canciones agregadas a playlists en los últimos 7 días
SELECT DISTINCT c.titulo
FROM canciones c
JOIN playlist_canciones pc ON c.id_cancion = pc.id_cancion
JOIN playlists pl ON pc.id_playlist = pl.id_playlist
WHERE pl.fecha_creacion >= DATE_SUB(NOW(), INTERVAL 7 DAY);

-- 31. Listar los 5 artistas con mayor cantidad de canciones
SELECT ar.nombre, COUNT(c.id_cancion) AS total_canciones
FROM artistas ar
JOIN albumes a ON ar.id_artista = a.id_artista
JOIN canciones c ON a.id_album = c.id_album
GROUP BY ar.id_artista
ORDER BY total_canciones DESC
LIMIT 5;

-- 32. Mostrar los álbumes lanzados después del año 2020 junto con su artista
SELECT a.titulo, ar.nombre, a.fecha_lanzamiento
FROM albumes a
JOIN artistas ar ON a.id_artista = ar.id_artista
WHERE YEAR(a.fecha_lanzamiento) > 2020;

-- 33. Obtener los usuarios que nunca han creado una playlist
SELECT nombre
FROM usuarios
WHERE id_usuario NOT IN (SELECT id_usuario FROM playlists);

-- 34. Mostrar las canciones que aparecen en más de 2 playlists distintas
SELECT c.titulo, COUNT(DISTINCT pc.id_playlist) AS num_playlists
FROM canciones c
JOIN playlist_canciones pc ON c.id_cancion = pc.id_cancion
GROUP BY c.id_cancion
HAVING COUNT(DISTINCT pc.id_playlist) > 2;

-- 35. Listar los artistas que tienen canciones con más de 1000 reproducciones
SELECT DISTINCT ar.nombre
FROM artistas ar
JOIN albumes a ON ar.id_artista = a.id_artista
JOIN canciones c ON a.id_album = c.id_album
WHERE c.reproducciones > 1000;

-- 36. Mostrar el top 3 de usuarios con más canciones reproducidas en total
SELECT u.nombre, COUNT(h.id_historial) AS total
FROM usuarios u
JOIN historial h ON u.id_usuario = h.id_usuario
GROUP BY u.id_usuario
ORDER BY total DESC
LIMIT 3;

-- 37. Playlists que contienen al menos una canción de cada género musical
SELECT pl.nombre
FROM playlists pl
JOIN playlist_canciones pc ON pl.id_playlist = pc.id_playlist
JOIN canciones c ON pc.id_cancion = c.id_cancion
JOIN albumes a ON c.id_album = a.id_album
GROUP BY pl.id_playlist
HAVING COUNT(DISTINCT a.genero) = (SELECT COUNT(DISTINCT genero) FROM albumes);

-- 38. Mostrar los usuarios que tienen una suscripción vencida
SELECT u.nombre, s.fecha_fin
FROM usuarios u
JOIN suscripciones s ON u.id_usuario = s.id_usuario
WHERE s.estado = 'Vencido';

-- 39. Listar canciones que recibieron likes de más de 3 usuarios diferentes
SELECT c.titulo, COUNT(DISTINCT l.id_usuario) AS usuarios
FROM canciones c
JOIN likes l ON c.id_cancion = l.id_cancion
GROUP BY c.id_cancion
HAVING COUNT(DISTINCT l.id_usuario) > 3;

-- 40. Mostrar los álbumes con la duración promedio de sus canciones
SELECT a.titulo, SEC_TO_TIME(AVG(TIME_TO_SEC(c.duracion))) AS duracion_promedio
FROM albumes a
JOIN canciones c ON a.id_album = c.id_album
GROUP BY a.id_album;

-- 41. Obtener los artistas que no tienen ningún álbum registrado
SELECT nombre
FROM artistas
WHERE id_artista NOT IN (SELECT id_artista FROM albumes);

-- 42. Listar los usuarios que nunca han dado like a una canción
SELECT nombre
FROM usuarios
WHERE id_usuario NOT IN (SELECT id_usuario FROM likes);

-- 43. Mostrar las canciones más reproducidas por cada usuario (una por usuario)
SELECT u.nombre, c.titulo
FROM usuarios u
JOIN historial h ON u.id_usuario = h.id_usuario
JOIN canciones c ON h.id_cancion = c.id_cancion
WHERE h.id_cancion = (
    SELECT h2.id_cancion
    FROM historial h2
    WHERE h2.id_usuario = u.id_usuario
    GROUP BY h2.id_cancion
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 44. Listar el top 5 de canciones más agregadas a playlists
SELECT c.titulo, COUNT(pc.id_playlist) AS total_playlists
FROM canciones c
JOIN playlist_canciones pc ON c.id_cancion = pc.id_cancion
GROUP BY c.id_cancion
ORDER BY total_playlists DESC
LIMIT 5;

-- 45. Mostrar el plan con menor número de usuarios suscritos
SELECT p.nombre, COUNT(s.id_usuario) AS total
FROM planes p
LEFT JOIN suscripciones s ON p.id_plan = s.id_plan
GROUP BY p.id_plan
ORDER BY total ASC
LIMIT 1;

-- 46. Listar las canciones reproducidas por usuarios de México
SELECT DISTINCT c.titulo
FROM canciones c
JOIN historial h ON c.id_cancion = h.id_cancion
JOIN usuarios u ON h.id_usuario = u.id_usuario
WHERE u.pais = 'México';

-- 47. Mostrar los artistas cuyo género principal coincide con el género más popular
SELECT ar.nombre
FROM artistas ar
WHERE ar.genero_principal = (
    SELECT a.genero
    FROM albumes a
    JOIN canciones c ON a.id_album = c.id_album
    GROUP BY a.genero
    ORDER BY SUM(c.reproducciones) DESC
    LIMIT 1
);

-- 48. Listar los usuarios que tienen al menos una playlist con más de 5 canciones
SELECT DISTINCT u.nombre
FROM usuarios u
JOIN playlists pl ON u.id_usuario = pl.id_usuario
JOIN playlist_canciones pc ON pl.id_playlist = pc.id_playlist
GROUP BY pl.id_playlist
HAVING COUNT(pc.id_cancion) > 5;

-- 49. Mostrar los usuarios que comparten canciones en común en sus playlists
SELECT DISTINCT u1.nombre AS usuario1, u2.nombre AS usuario2
FROM playlist_canciones pc1
JOIN playlist_canciones pc2 ON pc1.id_cancion = pc2.id_cancion AND pc1.id_playlist <> pc2.id_playlist
JOIN playlists p1 ON pc1.id_playlist = p1.id_playlist
JOIN playlists p2 ON pc2.id_playlist = p2.id_playlist
JOIN usuarios u1 ON p1.id_usuario = u1.id_usuario
JOIN usuarios u2 ON p2.id_usuario = u2.id_usuario
WHERE u1.id_usuario < u2.id_usuario;

-- 50. Listar los artistas que tienen canciones en playlists de más de 5 usuarios diferentes
SELECT ar.nombre, COUNT(DISTINCT pl.id_usuario) AS usuarios
FROM artistas ar
JOIN albumes a ON ar.id_artista = a.id_artista
JOIN canciones c ON a.id_album = c.id_album
JOIN playlist_canciones pc ON c.id_cancion = pc.id_cancion
JOIN playlists pl ON pc.id_playlist = pl.id_playlist
GROUP BY ar.id_artista
HAVING COUNT(DISTINCT pl.id_usuario) > 5;

