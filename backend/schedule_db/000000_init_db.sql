-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.teachers
(
    teacher_id serial NOT NULL,
    user_id serial,
    firstname character varying(64) NOT NULL,
    secondname character varying(64) NOT NULL,
    middlename character varying(64),
    CONSTRAINT pk_teacher_id PRIMARY KEY (teacher_id),
    UNIQUE (user_id)
);

CREATE TABLE IF NOT EXISTS public.subjects
(
    subject_id serial NOT NULL,
    name character varying(150) NOT NULL,
    CONSTRAINT pk_subject_id PRIMARY KEY (subject_id)
);

CREATE TABLE IF NOT EXISTS public.teacher_subjects
(
    subject_with_teacher_id serial NOT NULL,
    subject_id serial NOT NULL,
    teacher_id serial NOT NULL,
    CONSTRAINT pk_subject_with_teacher PRIMARY KEY (subject_with_teacher_id),
    CONSTRAINT un_subject_teacher_id UNIQUE (subject_id, teacher_id)
);

CREATE TABLE IF NOT EXISTS public.specialties
(
    speciality_id serial NOT NULL,
    name character varying(64),
    PRIMARY KEY (speciality_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.groups
(
    group_id serial NOT NULL,
    speciality_id serial,
    name character varying(64),
    course serial,
    PRIMARY KEY (group_id)
);

CREATE TABLE IF NOT EXISTS public.group_subjects
(
    group_id serial NOT NULL,
    subject_id serial NOT NULL,
    PRIMARY KEY (group_id, subject_id)
);

CREATE TABLE IF NOT EXISTS public.cabinets
(
    cabinet_id serial NOT NULL,
    adress character varying,
    floor serial,
    "number" serial,
    seats serial,
    CONSTRAINT pk_cabinet_id PRIMARY KEY (cabinet_id)
);

CREATE TABLE IF NOT EXISTS public.cabinet_subjects
(
    subject_id serial,
    cabinet_id serial,
    CONSTRAINT pk_subject_cabinet_id PRIMARY KEY (subject_id, cabinet_id)
);

CREATE TABLE IF NOT EXISTS public.subgroups
(
    subgroup_id serial,
    name character varying,
    CONSTRAINT pk_subgroup_id PRIMARY KEY (subgroup_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.subgroup_subjects
(
    subgroup_id serial,
    subject_id serial,
    PRIMARY KEY (subgroup_id, subject_id)
);

CREATE TABLE IF NOT EXISTS public.students
(
    student_id serial NOT NULL,
    user_id serial NOT NULL,
    first_name character varying(64) NOT NULL,
    second_name character varying(64) NOT NULL,
    middle_name character varying(64),
    group_id serial NOT NULL,
    subgroup_id serial,
    CONSTRAINT pk_students PRIMARY KEY (student_id, user_id)
);

CREATE TABLE IF NOT EXISTS public.lesson_types
(
    lesson_type_id serial NOT NULL,
    name character varying,
    CONSTRAINT pk_lesson_type_id PRIMARY KEY (lesson_type_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.lessons
(
    lesson_id bigserial NOT NULL,
    group_id serial,
    subgroup_id serial,
    day date NOT NULL,
    type_lesson_id serial NOT NULL,
    cabinet_id serial NOT NULL,
    number_lesson smallserial NOT NULL,
    subject_id serial NOT NULL,
    CONSTRAINT pk_lesson_id PRIMARY KEY (lesson_id)
);

ALTER TABLE IF EXISTS public.teacher_subjects
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subjects (subject_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.teacher_subjects
    ADD FOREIGN KEY (teacher_id)
    REFERENCES public.teachers (teacher_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.groups
    ADD FOREIGN KEY (speciality_id)
    REFERENCES public.specialties (speciality_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.group_subjects
    ADD FOREIGN KEY (group_id)
    REFERENCES public.groups (group_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.group_subjects
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subjects (subject_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.cabinet_subjects
    ADD CONSTRAINT fk_subject_cabinet_subjects FOREIGN KEY (subject_id)
    REFERENCES public.subjects (subject_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.cabinet_subjects
    ADD CONSTRAINT fk_cabinet_cabinet_subjects FOREIGN KEY (cabinet_id)
    REFERENCES public.cabinets (cabinet_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.subgroup_subjects
    ADD FOREIGN KEY (subgroup_id)
    REFERENCES public.subgroups (subgroup_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.subgroup_subjects
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subjects (subject_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.students
    ADD CONSTRAINT fk_group_id FOREIGN KEY (group_id)
    REFERENCES public.groups (group_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.students
    ADD CONSTRAINT fk_subgroup_id FOREIGN KEY (subgroup_id)
    REFERENCES public.subgroups (subgroup_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.lessons
    ADD FOREIGN KEY (group_id)
    REFERENCES public.groups (group_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.lessons
    ADD FOREIGN KEY (subgroup_id)
    REFERENCES public.subgroups (subgroup_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.lessons
    ADD FOREIGN KEY (cabinet_id)
    REFERENCES public.cabinets (cabinet_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.lessons
    ADD FOREIGN KEY (type_lesson_id)
    REFERENCES public.lesson_types (lesson_type_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.lessons
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subjects (subject_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;