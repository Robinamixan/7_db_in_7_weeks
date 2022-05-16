INSERT INTO countries VALUES ('pl','Poland');

INSERT INTO cities VALUES ('Warsaw','00-001', 'pl');

INSERT INTO venues (name, type, postal_code, country_code, active) VALUES ('My Place', 'public', '00-001', 'pl', true);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Wedding', '2018-02-26 21:00:00', '2018-02-26 23:00:00', (
    SELECT venue_id
    FROM venues
    WHERE name = 'Voodoo Doughnut'
));

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Dinner with Mom', '2018-02-26 18:00:00', '2018-02-26 20:30:00', (
    SELECT venue_id
    FROM venues
    WHERE name = 'My Place'
));

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Valentine''s Day', '2018-02-14 00:00:00', '2018-02-14 23:59:00', NULL);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Moby', '2018-02-06 21:00', '2018-02-06 23:00', (
    SELECT venue_id
    FROM venues
    WHERE name = 'Crystal Ballroom'
));
