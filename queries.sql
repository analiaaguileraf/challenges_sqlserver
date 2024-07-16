-- Ejercicio 1

SELECT TOP 200
    DisplayName,
    Location,
    Reputation
FROM 
    Users
ORDER BY 
    Reputation DESC;

-- Ejercicio 2

SELECT TOP 200
    Posts.Title, 
    Users.DisplayName 
FROM 
    Posts
JOIN 
    Users 
ON 
    Posts.OwnerUserId = Users.Id
WHERE 
    Posts.OwnerUserId IS NOT NULL;

-- Ejercicio 3

SELECT TOP 200
    Users.DisplayName, 
    AVG(Posts.Score) AS PromedioScore
FROM 
    Posts
JOIN 
    Users 
ON 
    Posts.OwnerUserId = Users.Id
GROUP BY 
    Users.DisplayName;

-- Ejercicio 4

SELECT TOP 200
    Users.DisplayName
FROM 
    Users
WHERE 
    Users.Id IN (
        SELECT 
            Comments.UserId
        FROM 
            Comments
        GROUP BY 
            Comments.UserId
        HAVING 
            COUNT(Comments.Id) > 100
    );

-- Ejercicio 5

UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR TRIM(Location) = ''

PRINT 'La actualizacion se realizo correctamente. Se actualizaron' + CAST(@@ROWCOUNT AS VARCHAR(10)) + 'filas.'

-- Para visualizar los users con locaciones dessconocidas
SELECT TOP (200) Displayname, Location 
FROM Users
WHERE Location = 'Desconocido'
ORDER BY DisplayName

-- Ejercicio 6

DELETE Comments
FROM Comments
JOIN Users On Comments.UserId = Users.Id
WHERE Users.Reputation < 100;

DECLARE @DeletedCount INT;
SET @DeletedCount = @@ROWCOUNT;
PRINT CAST(@DeletedCount AS VARCHAR) + ' comentarios fueron eliminados.';

-- Ejercicio 7
SELECT TOP 200
    U.DisplayName, 
    COALESCE(P.NumeroPublicaciones, 0) AS TotalPosts,
    COALESCE(C.NumeroComentarios, 0) AS TotalComments,
    COALESCE(B.NumeroMedallas, 0) AS TotalBadges
FROM 
    Users U
LEFT JOIN (
    SELECT 
        OwnerUserId, 
        COUNT(*) AS NumeroPublicaciones
    FROM 
        Posts
    GROUP BY 
        OwnerUserId
) P ON U.Id = P.OwnerUserId
LEFT JOIN (
    SELECT 
        UserId, 
        COUNT(*) AS NumeroComentarios
    FROM 
        Comments
    GROUP BY 
        UserId
) C ON U.Id = C.UserId
LEFT JOIN (
    SELECT 
        UserId, 
        COUNT(*) AS NumeroMedallas
    FROM 
        Badges
    GROUP BY 
        UserId
) B ON U.Id = B.UserId;

-- Ejercicio 8

SELECT TOP 10
    Title, 
    Score 
FROM 
    Posts
ORDER BY 
    Score DESC;

-- Ejercicio 9

SELECT TOP 5
    Text, 
    CreationDate 
FROM 
    Comments
ORDER BY 
    CreationDate DESC;
