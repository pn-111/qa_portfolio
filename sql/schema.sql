-- Создаем таблицу пользователей
CREATE TABLE users (
    id INTEGER PRIMARY KEY,                                 -- id пользователя
    name VARCHAR(100) NOT NULL,                             -- Имя, не может быть пустым (NOT NULL)
    email VARCHAR(100) UNIQUE NOT NULL                      -- Почта, должна быть уникальной (UNIQUE) 
);
-- Создаем таблицу водительских прав
CREATE TABLE licenses (
    id INTEGER PRIMARY KEY,                                 -- id прав
    user_id INTEGER REFERENCES users(id) UNIQUE NOT NULL,   -- ссылка на id пользователя
    number VARCHAR(20) UNIQUE NOT NULL,                     -- номер прав
    status VARCHAR(100) DEFAULT 'pending'                   -- статус
);
-- Создаем таблицу автомобилей
CREATE TABLE cars (
    id INTEGER PRIMARY KEY,                                 -- id автомобиля
    model VARCHAR(50),                                      -- модель
    status VARCHAR(100) DEFAULT 'available'                 -- статус
);
-- Создаем таблицу поездок
CREATE TABLE rides (
    id INTEGER PRIMARY KEY,                                 -- id поездки
    user_id INTEGER REFERENCES users(id) NOT NULL,          -- ссылка на id пользователя
    car_id INTEGER REFERENCES cars(id) NOT NULL,            -- ссылка на id автомобиля
    start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,-- время начала поездки
    end_time TIMESTAMP                                      -- время конца поездки
);

-- Добавляем пользователей
INSERT INTO users (name, email) VALUES ('Иван', 'ivan@test.ru');
INSERT INTO users (name, email) VALUES ('Петр', 'petr@test.ru');

-- Добавляем права
INSERT INTO licenses (user_id, number, status) VALUES (1, '11111111111111111111', 'approved');

-- Добавляем автомобиль
INSERT INTO cars (model) VALUES ('Kia Rio');

-- Добавляем поездки
INSERT INTO rides (user_id, car_id, start_time, end_time) VALUES (1, 1, '2026-11-15 10:00:00', '2026-11-15 11:30:00');
INSERT INTO rides (user_id, car_id, start_time, end_time) VALUES (1, 1, '2026-11-15 15:00:00', '2026-11-15 14:00:00'); --поездка с багом

-- Добавляем колонку стоимости в таблицу поездок
ALTER TABLE rides ADD COLUMN cost DECIMAL(10,2);

-- Обновляем нормальную поездку (id=1)
UPDATE rides SET cost = 450.00 WHERE id = 1;

-- Обновляем багованную поездку (id=2) — делаем отрицательную стоимость
UPDATE rides SET cost = -150.00 WHERE id = 2;