BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ' || 'user_role';
    EXECUTE IMMEDIATE 'DROP TABLE ' || 'users';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

-- DROP TABLE IF EXISTS user_role;
-- DROP TABLE IF EXISTS users;
-- DROP SEQUENCE IF EXISTS global_seq;

-- CREATE SEQUENCE global_seq START WITH 100000;

CREATE TABLE users
(
    id               NUMBER(10) GENERATED ALWAYS as identity(start with 100000 increment by 1) PRIMARY KEY,
    name             VARCHAR2(50)                           NOT NULL,
    email            VARCHAR(30)                           NOT NULL,
    password         VARCHAR(25)                           NOT NULL,
    registered       TIMESTAMP           DEFAULT CURRENT_TIMESTAMP NOT NULL,
    enabled          number              DEFAULT 1 NOT NULL,
    calories_per_day INTEGER             DEFAULT 2000  NOT NULL
);
CREATE UNIQUE INDEX users_unique_email_idx ON users (email);

CREATE TABLE user_role
(
    user_id INTEGER NOT NULL,
    role    VARCHAR2(25) NOT NULL,
    CONSTRAINT user_roles_idx UNIQUE (user_id, role),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);