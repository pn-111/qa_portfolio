-- пользователи с одобренными правами
SELECT name
FROM users AS u
JOIN licenses AS l ON u.id = l.user_id
WHERE l.status = 'approved';

-- поиск бага с временем поездки
SELECT id
FROM rides
WHERE start_time > end_time;

-- количество поездок по каждому пользователю
SELECT u.name, COUNT(r.id) AS rides
FROM users AS u
LEFT JOIN rides AS r ON u.id = r.user_id
GROUP BY u.name;

-- пользователи у которых больше 1 поездки
SELECT u.name, COUNT(r.id) AS rides
FROM users AS u
JOIN rides AS r ON u.id = r.user_id
GROUP BY u.name
HAVING COUNT(r.id) > 1;

-- пользователи без зарегистрированных водительских прав
SELECT u.name
FROM users AS u
LEFT JOIN licenses AS l ON u.id = l.user_id
WHERE l.id IS NULL;

-- поездки с отрицательной стоимостью
SELECT id, user_id, cost
FROM rides
WHERE cost <= 0;