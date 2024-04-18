--Создаем таблицы

CREATE TABLE IF NOT EXISTS arena
(
	id integer PRIMARY KEY,
    name varchar(100) NOT NULL UNIQUE, 
	size integer NOT NULL DEFAULT 100
);

CREATE TABLE IF NOT EXISTS team
(
	id integer PRIMARY KEY,
    city varchar(100) NOT NULL, 
	name varchar(100) NOT NULL UNIQUE, 
	coach_name varchar(100) NOT NULL UNIQUE, 
	arena_id integer NOT NULL,
	FOREIGN KEY (arena_id) REFERENCES arena(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS player
(
	id integer PRIMARY KEY,
    name varchar(100) NOT NULL UNIQUE, 
	position varchar(100) NOT NULL, 
	height numeric NOT NULL CHECK (height > 0), 
	weight numeric NOT NULL CHECK (height > 0),
	salary numeric NOT NULL CHECK (height > 0),
	team_id integer NOT NULL,
	FOREIGN KEY (team_id) REFERENCES team(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS game(
	id integer PRIMARY KEY,
	owner_team_id integer NOT NULL,
	guest_team_id integer NOT NULL,
	game_date date NOT NULL,
	winner_team_id integer NOT NULL,
	owner_score integer NOT NULL DEFAULT 0 CHECK (owner_score >= 0),
	guest_score integer NOT NULL DEFAULT 0 CHECK (owner_score >= 0),
	arena_id integer NOT NULL,
	UNIQUE (owner_team_id, guest_team_id),
	FOREIGN KEY (owner_team_id) REFERENCES team(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (guest_team_id) REFERENCES team(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (winner_team_id) REFERENCES team(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (arena_id) REFERENCES arena(id) ON UPDATE CASCADE ON DELETE CASCADE
);

--Заполняем таблицы

INSERT INTO arena
VALUES
(10, 'Палау Блауграна', 8250),
(20, 'Визинк-Центр - Паласио де Депортес', 15500),
(30, 'УСК ЦСКА им. А.Я. Гомельского', 5000),
(40, 'Пис энд Френдшип Стадиум', 12000),
(50, 'СИБУР Арена', 7140);

INSERT INTO team
VALUES
(10, 'Барселона', 'Барселона', 'Шарунас Ясикявичюс', (SELECT id from arena WHERE name = 'Палау Блауграна')),
(20, 'Мадрид', 'Реал Мадрид', 'Пабло Ласо', (SELECT id from arena WHERE name = 'Визинк-Центр - Паласио де Депортес')),
(30, 'Москва', 'ЦСКА', 'Димитрис Итудис', (SELECT id from arena WHERE name = 'УСК ЦСКА им. А.Я. Гомельского')),
(40, 'Пирей', 'Олимпиакос', 'Георгиос Барцокас', (SELECT id from arena WHERE name = 'Пис энд Френдшип Стадиум')),
(50, 'Санкт-Петербург', 'Зенит', 'Хавьер Паскуаль', (SELECT id from arena WHERE name = 'СИБУР Арена'));

INSERT INTO player
VALUES
(10, 'Рафа Вильяр', 'защитник', 188, 85, 100000, (SELECT id from team WHERE name = 'Барселона')),
(20, 'Кайл Курич', 'защитник', 193, 85, 100000, (SELECT id from team WHERE name = 'Барселона')),
(30, 'Ибу Дьянко Баджи', 'центровой', 211, 103, 200000, (SELECT id from team WHERE name = 'Барселона')),
(40, 'Ник Калатес', 'разыгрывающий', 198, 97, 150000, (SELECT id from team WHERE name = 'Барселона')),
(50, 'Никола Миротич', 'форвард', 208, 107, 175000, (SELECT id from team WHERE name = 'Барселона')),
(60, 'Джейси Кэрролл', 'защитник', 188, 82, 175000, (SELECT id from team WHERE name = 'Реал Мадрид')),
(70, 'Эли Джон Ндиайе', 'центровой', 203, 110, 275000, (SELECT id from team WHERE name = 'Реал Мадрид')),
(80, 'Уолтер Тавареш', 'центровой', 220, 120, 273000, (SELECT id from team WHERE name = 'Реал Мадрид')),
(90, 'Томас Давид Эртель', 'разыгрывающий', 189, 88, 173000, (SELECT id from team WHERE name = 'Реал Мадрид')),
(100, 'Гершон Ябуселе', 'форвард', 203, 118, 99000, (SELECT id from team WHERE name = 'Реал Мадрид')),
(110, 'Габриэль Иффе Лундберг', 'защитник', 193, 96, 101000, (SELECT id from team WHERE name = 'ЦСКА')),
(120, 'Юрий Умрихин', 'защитник', 190, 75, 251000, (SELECT id from team WHERE name = 'ЦСКА')),
(130, 'Иван Анатольевич Ухов', 'разыгрывающий', 193, 77, 175000, (SELECT id from team WHERE name = 'ЦСКА')),
(140, 'Александр Хоменко', 'разыгрывающий', 192, 85, 375000, (SELECT id from team WHERE name = 'ЦСКА')),
(150, 'Андрей Лопатин', 'лёгкий форвард', 208, 92, 205000, (SELECT id from team WHERE name = 'ЦСКА')),
(160, 'Тайлер Дорси', 'защитник', 193, 83, 205000, (SELECT id from team WHERE name = 'Олимпиакос')),
(170, 'Яннулис Ларенцакис', 'защитник', 196, 87, 75000, (SELECT id from team WHERE name = 'Олимпиакос')),
(180, 'Хассан Мартин', 'центровой', 201, 107, 375000, (SELECT id from team WHERE name = 'Олимпиакос')),
(190, 'Михалис Лунцис', 'разыгрывающий', 195, 90, 475000, (SELECT id from team WHERE name = 'Олимпиакос')),
(200, 'Георгиос Принтезис', 'форвард', 205, 184, 105000, (SELECT id from team WHERE name ='Олимпиакос')),
(210, 'Билли Джеймс Бэрон', 'защитник', 188, 88, 75000, (SELECT id from team WHERE name = 'Зенит')),
(220, 'Артурас Гудайтис', 'центровой', 208, 99, 165000, (SELECT id from team WHERE name = 'Зенит')),
(230, 'Денис Захаров', 'разыгрывающий', 192, 88, 163000, (SELECT id from team WHERE name = 'Зенит')),
(240, 'Миндаугас Кузминскас', 'лёгкий форвард', 204, 93, 295000, (SELECT id from team WHERE name = 'Зенит')),
(250, 'Алекс Пойтресс', 'форвард', 201, 108, 247000, (SELECT id from team WHERE name = 'Зенит'));

INSERT INTO game
VALUES
(10, (SELECT id FROM team WHERE name = 'Барселона'), (SELECT id FROM team WHERE name = 'Зенит'), '2021-10-22', (SELECT id FROM team WHERE name = 'Барселона'), 84, 58, (SELECT id FROM arena WHERE name = 'Палау Блауграна')),
(20, (SELECT id FROM team WHERE name = 'Барселона'), (SELECT id FROM team WHERE name = 'ЦСКА'), '2021-11-17', (SELECT id FROM team WHERE name = 'Барселона'), 81, 73, (SELECT id FROM arena WHERE name = 'Палау Блауграна')),
(30, (SELECT id FROM team WHERE name = 'Барселона'), (SELECT id FROM team WHERE name = 'Реал Мадрид'), '2021-10-12', (SELECT id FROM team WHERE name = 'Барселона'), 93, 80, (SELECT id FROM arena WHERE name = 'Палау Блауграна')),
(40, (SELECT id FROM team WHERE name = 'Барселона'), (SELECT id FROM team WHERE name = 'Олимпиакос'), '2021-10-15', (SELECT id FROM team WHERE name = 'Барселона'), 83, 68, (SELECT id FROM arena WHERE name = 'Палау Блауграна')),
(50, (SELECT id FROM team WHERE name = 'Зенит'), (SELECT id FROM team WHERE name = 'Реал Мадрид'), '2022-12-15', (SELECT id FROM team WHERE name = 'Реал Мадрид'), 68, 75, (SELECT id FROM arena WHERE name = 'СИБУР Арена')),
(60, (SELECT id FROM team WHERE name = 'Зенит'), (SELECT id FROM team WHERE name = 'ЦСКА'), '2022-01-15', (SELECT id FROM team WHERE name = 'ЦСКА'), 67, 77, (SELECT id FROM arena WHERE name = 'СИБУР Арена')),
(70, (SELECT id FROM team WHERE name = 'Зенит'), (SELECT id FROM team WHERE name = 'Олимпиакос'), '2022-10-20', (SELECT id FROM team WHERE name = 'Зенит'), 84, 78, (SELECT id FROM arena WHERE name = 'СИБУР Арена')),
(80, (SELECT id FROM team WHERE name = 'Реал Мадрид'), (SELECT id FROM team WHERE name = 'ЦСКА'), '2021-10-28', (SELECT id FROM team WHERE name = 'Реал Мадрид'), 71, 65, (SELECT id FROM arena WHERE name = 'Визинк-Центр - Паласио де Депортес')),
(90, (SELECT id FROM team WHERE name = 'Реал Мадрид'), (SELECT id FROM team WHERE name = 'Олимпиакос'), '2022-02-01', (SELECT id FROM team WHERE name = 'Реал Мадрид'), 75, 67, (SELECT id FROM arena WHERE name = 'Визинк-Центр - Паласио де Депортес')),
(100, (SELECT id FROM team WHERE name = 'ЦСКА'), (SELECT id FROM team WHERE name = 'Олимпиакос'), '2022-02-02', (SELECT id FROM team WHERE name = 'ЦСКА'), 79, 78, (SELECT id FROM arena WHERE name = 'УСК ЦСКА им. А.Я. Гомельского'));

/*создаем таблицу для отображения изменений списка игроков. 
Создаем триггерную функцию, которая будет вносить информацию об изменениях
таблицы игроков в созданную таблицу*/

--DROP TABLE player_audit
CREATE TABLE IF NOT EXISTS player_audit (
	player_audit_id serial PRIMARY KEY,
	modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
	modified_type VARCHAR,
	id integer,
    name varchar(100) NOT NULL, 
	position varchar(100) NOT NULL, 
	height numeric NOT NULL CHECK (height > 0), 
	weight numeric NOT NULL CHECK (height > 0),
	salary numeric NOT NULL CHECK (height > 0),
	team_id integer NOT NULL
);
--SELECT * FROM player_audit

CREATE OR REPLACE FUNCTION fnc_trg_player_changed()
RETURNS TRIGGER AS 
$$
BEGIN

IF (TG_OP='INSERT') THEN
INSERT INTO player_audit(modified_type, id, name, position, height, weight, salary, team_id) VALUES
('INSERT', NEW.id, NEW.name, NEW.position, NEW.height, NEW.weight, NEW.salary, NEW.team_id);
RETURN NEW;

ELSEIF (TG_OP='UPDATE') THEN
INSERT INTO player_audit(modified_type, id, name, position, height, weight, salary, team_id) VALUES
('UPDATE', OLD.id, OLD.name, OLD.position, OLD.height, OLD.weight, OLD.salary, OLD.team_id);
RETURN OLD;

ELSEIF (TG_OP='DELETE') THEN
INSERT INTO player_audit(modified_type, id, name, position, height, weight, salary, team_id) VALUES
('DELETE', OLD.id, OLD.name, OLD.position, OLD.height, OLD.weight, OLD.salary, OLD.team_id);
RETURN OLD;
END IF;

END
$$
LANGUAGE plpgsql;

CREATE TRIGGER trg_player_changed
AFTER UPDATE OR DELETE OR INSERT
ON player
FOR EACH ROW
EXECUTE PROCEDURE fnc_trg_player_changed();

/*INSERT INTO player VALUES 
(260, 'Ин', 'защитник', 188, 75, 100000, 20);

SELECT * FROM player_audit;

UPDATE player
SET name='Жакобс'
WHERE id=260;

DELETE FROM player
WHERE id=260;*/