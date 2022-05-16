CREATE TABLE countries (
    country_code char(2) PRIMARY KEY,
    country_name text UNIQUE
);

INSERT INTO countries (country_code, country_name)
VALUES ('us','United States'), ('mx','Mexico'), ('au','Australia'),
       ('gb','United Kingdom'), ('de','Germany');

CREATE TABLE cities (
    name text NOT NULL,
    postal_code varchar(9) CHECK (postal_code <> ''),
    country_code char(2) REFERENCES countries,
    PRIMARY KEY (country_code, postal_code)
);

INSERT INTO cities
VALUES ('Portland','97206','us');

CREATE TABLE venues (
    venue_id SERIAL PRIMARY KEY,
    name varchar(255),
    street_address text,
    type char(7) CHECK ( type in ('public','private') ) DEFAULT 'public',
    postal_code varchar(9),
    country_code char(2),
    FOREIGN KEY (country_code, postal_code)
        REFERENCES cities (country_code, postal_code) MATCH FULL
);

ALTER TABLE venues ADD COLUMN active bool DEFAULT TRUE;

INSERT INTO venues (name, postal_code, country_code)
VALUES ('Crystal Ballroom', '97206', 'us');

INSERT INTO venues (name, postal_code, country_code)
VALUES ('Voodoo Doughnut', '97206', 'us') RETURNING venue_id;

CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    title varchar(255),
    starts timestamp,
    ends timestamp,
    venue_id integer,
    FOREIGN KEY (venue_id) REFERENCES venues (venue_id) MATCH FULL
);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club', '2018-02-15 17:30:00', '2018-02-15 19:30:00', 2),
       ('April Fools Day', '2018-04-01 00:00:00', '2018-04-01 23:59:00', NULL),
       ('Christmas Day', '2018-02-15 19:30:00', '2018-12-25 23:59:00', NULL);

CREATE INDEX events_title
    ON events USING hash (title);

CREATE INDEX events_starts
    ON events USING btree (starts);
