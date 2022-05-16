CREATE TABLE logs (
                      event_id integer,
                      old_title varchar(255),
                      old_starts timestamp,
                      old_ends timestamp,
                      logged_at timestamp DEFAULT current_timestamp
);

CREATE OR REPLACE FUNCTION log_event() RETURNS trigger AS $$
DECLARE
BEGIN
    INSERT INTO logs (event_id, old_title, old_starts, old_ends)
    VALUES (OLD.event_id, OLD.title, OLD.starts, OLD.ends);
    RAISE NOTICE 'Someone just changed event #%', OLD.event_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_events
    AFTER UPDATE ON events
    FOR EACH ROW EXECUTE PROCEDURE log_event();

UPDATE events
SET ends='2018-05-04 01:00:00'
WHERE title='House Party';

-- VIEWS

CREATE VIEW holidays AS
SELECT event_id AS holiday_id, title AS name, starts AS date
FROM events
WHERE title LIKE '%Day%' AND venue_id IS NULL;

ALTER TABLE events
    ADD colors text ARRAY;

CREATE OR REPLACE VIEW holidays AS
SELECT event_id AS holiday_id, title AS name, starts AS date, colors
FROM events
WHERE title LIKE '%Day%' AND venue_id IS NULL;

CREATE RULE update_holidays AS ON UPDATE TO holidays DO INSTEAD
    UPDATE events
    SET title = NEW.name,
        starts = NEW.date,
        colors = NEW.colors
    WHERE title = OLD.name;

UPDATE holidays SET colors = '{"red","green"}' where name = 'Christmas Day';

-- Crosstab()

CREATE TEMPORARY TABLE month_count(month INT);
INSERT INTO month_count VALUES (1),(2),(3),(4),(5),
                               (6),(7),(8),(9),(10),(11),(12);

SELECT * FROM crosstab(
        'SELECT extract(year from starts) as year,
        extract(month from starts) as month, count(*)
        FROM events
        GROUP BY year, month
        ORDER BY year, month',
        'SELECT * FROM month_count'
    );
