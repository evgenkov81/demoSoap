

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE public.roles
(
    id   bigint                NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.roles
    OWNER TO postgres;



CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq
    OWNER TO postgres;



ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;




CREATE TABLE public.users
(
    login    character varying(64) NOT NULL,
    name     character varying(64),
    password character varying(64) NOT NULL
);


ALTER TABLE public.users
    OWNER TO postgres;


CREATE TABLE public.users_to_roles
(
    user_login character varying(64) NOT NULL,
    role_id    bigint                NOT NULL
);


ALTER TABLE public.users_to_roles
    OWNER TO postgres;


ALTER TABLE ONLY public.roles
    ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);

INSERT INTO public.roles (id, name)
VALUES (1, 'CLIENT'),
       (2, 'SUPPORT'),
       (3, 'ADMIN'),
       (4, 'PROGRAMMER');

INSERT INTO public.users (login, name, password)
VALUES ('User1', 'Sam', '123'),
       ('User2', 'Jon', '321'),
       ('User3', 'Tom', '456');


INSERT INTO public.users_to_roles (user_login, role_id)
VALUES ('User1', 1),
       ('User1', 4),
       ('User2', 3),
       ('User2', 4),
       ('User3', 2);



SELECT pg_catalog.setval('public.roles_id_seq', 4, true);



ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (login);



ALTER TABLE ONLY public.users_to_roles
    ADD CONSTRAINT users_to_roles_pk PRIMARY KEY (user_login, role_id);


ALTER TABLE ONLY public.users_to_roles
    ADD CONSTRAINT users_to_roles_roles_id_fk FOREIGN KEY (role_id) REFERENCES public.roles (id) ON DELETE CASCADE;



ALTER TABLE ONLY public.users_to_roles
    ADD CONSTRAINT users_to_roles_users_login_fk FOREIGN KEY (user_login) REFERENCES public.users (login) ON DELETE CASCADE;



