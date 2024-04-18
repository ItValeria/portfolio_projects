--1
CREATE VIEW v_arena_more_9000 AS
SELECT name
FROM arena
WHERE size>9000
ORDER BY name;

--SELECT * FROM v_arena_more_9000;

--2
CREATE VIEW v_arena_team AS
(SELECT name 
FROM arena
UNION
SELECT name 
FROM team)
ORDER BY name DESC;

--SELECT * FROM v_arena_team;

--3
CREATE MATERIALIZED VIEW mv_formula_team AS
SELECT CONCAT('город: ', city, '; команда: ', name, '; тренер: ', coach_name) 
AS "полная информация"
FROM team
ORDER BY "полная информация";

--SELECT * FROM mv_formula_team;

--4
CREATE MATERIALIZED VIEW mv_formula_player AS
SELECT ROUND(AVG(height),1) AS avg_height, MIN(height) AS min_height, MAX(height) AS max_height, SUM(salary) AS total_salary
FROM player;

--SELECT * FROM mv_formula_player;

--5
--DROP TABLE player_audit
CREATE TABLE player_audit (
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