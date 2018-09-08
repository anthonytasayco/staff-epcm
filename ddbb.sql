--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_honeypot_loginattempt; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE admin_honeypot_loginattempt (
    id integer NOT NULL,
    username character varying(255),
    ip_address inet,
    session_key character varying(50),
    user_agent text,
    "timestamp" timestamp with time zone NOT NULL,
    path text
);


ALTER TABLE admin_honeypot_loginattempt OWNER TO ccapu;

--
-- Name: admin_honeypot_loginattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE admin_honeypot_loginattempt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin_honeypot_loginattempt_id_seq OWNER TO ccapu;

--
-- Name: admin_honeypot_loginattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE admin_honeypot_loginattempt_id_seq OWNED BY admin_honeypot_loginattempt.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO ccapu;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO ccapu;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO ccapu;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO ccapu;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO ccapu;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO ccapu;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO ccapu;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO ccapu;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO ccapu;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO ccapu;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO ccapu;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO ccapu;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: cache_table; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cache_table (
    cache_key character varying(255) NOT NULL,
    value text NOT NULL,
    expires timestamp with time zone NOT NULL
);


ALTER TABLE cache_table OWNER TO ccapu;

--
-- Name: cursos_beneficios; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_beneficios (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    nombre character varying(256) NOT NULL,
    descript text NOT NULL,
    posicion integer NOT NULL,
    curso_id integer NOT NULL,
    CONSTRAINT cursos_beneficios_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_beneficios OWNER TO ccapu;

--
-- Name: cursos_beneficios_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_beneficios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_beneficios_id_seq OWNER TO ccapu;

--
-- Name: cursos_beneficios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_beneficios_id_seq OWNED BY cursos_beneficios.id;


--
-- Name: cursos_contenidos; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_contenidos (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    nombre character varying(256) NOT NULL,
    descript text NOT NULL,
    posicion integer NOT NULL,
    curso_id integer NOT NULL,
    CONSTRAINT cursos_contenidos_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_contenidos OWNER TO ccapu;

--
-- Name: cursos_contenidos_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_contenidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_contenidos_id_seq OWNER TO ccapu;

--
-- Name: cursos_contenidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_contenidos_id_seq OWNED BY cursos_contenidos.id;


--
-- Name: cursos_cursos; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursos (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    posicion integer NOT NULL,
    nombre character varying(256) NOT NULL,
    img character varying(200) NOT NULL,
    nuevo boolean NOT NULL,
    online boolean NOT NULL,
    classroom boolean NOT NULL,
    webcast boolean NOT NULL,
    descript text NOT NULL,
    yt_img_usage boolean NOT NULL,
    video character varying(1024) NOT NULL,
    archivo character varying(100) NOT NULL,
    fechas character varying(256) NOT NULL,
    horarios character varying(256) NOT NULL,
    lugar character varying(256) NOT NULL,
    inversion character varying(256) NOT NULL,
    cod character varying(32) NOT NULL,
    precio numeric(6,2) NOT NULL,
    categoria_id integer NOT NULL,
    dc_descript text NOT NULL,
    dm_descript text NOT NULL,
    dm_video character varying(1024) NOT NULL,
    dm_video_id character varying(1024) NOT NULL,
    iv_descript text NOT NULL,
    iv_descript_pie text NOT NULL,
    mt_descript text NOT NULL,
    video_id character varying(1024) NOT NULL,
    de_interes boolean NOT NULL,
    inicio date NOT NULL,
    nombre_complex character varying(256) NOT NULL,
    dc_titulo character varying(64) NOT NULL,
    mt_titulo character varying(64) NOT NULL,
    iv_tabla text NOT NULL,
    dm_titulo character varying(64) NOT NULL,
    CONSTRAINT cursos_cursos_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_cursos OWNER TO ccapu;

--
-- Name: cursos_cursos_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursos_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursos_id_seq OWNED BY cursos_cursos.id;


--
-- Name: cursos_cursos_idiomas; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursos_idiomas (
    id integer NOT NULL,
    cursos_id integer NOT NULL,
    idiomas_id integer NOT NULL
);


ALTER TABLE cursos_cursos_idiomas OWNER TO ccapu;

--
-- Name: cursos_cursos_idiomas_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursos_idiomas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursos_idiomas_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursos_idiomas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursos_idiomas_id_seq OWNED BY cursos_cursos_idiomas.id;


--
-- Name: cursos_cursos_rubro; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursos_rubro (
    id integer NOT NULL,
    cursos_id integer NOT NULL,
    rubros_id integer NOT NULL
);


ALTER TABLE cursos_cursos_rubro OWNER TO ccapu;

--
-- Name: cursos_cursos_rubro_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursos_rubro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursos_rubro_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursos_rubro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursos_rubro_id_seq OWNED BY cursos_cursos_rubro.id;


--
-- Name: cursos_cursoscategorias; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursoscategorias (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    nombre character varying(256) NOT NULL,
    descript text NOT NULL,
    img_s character varying(200) NOT NULL,
    img_i character varying(200) NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT cursos_cursoscategorias_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_cursoscategorias OWNER TO ccapu;

--
-- Name: cursos_cursoscategorias_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursoscategorias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursoscategorias_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursoscategorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursoscategorias_id_seq OWNED BY cursos_cursoscategorias.id;


--
-- Name: cursos_cursoscategorias_idiomas; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursoscategorias_idiomas (
    id integer NOT NULL,
    cursoscategorias_id integer NOT NULL,
    idiomas_id integer NOT NULL
);


ALTER TABLE cursos_cursoscategorias_idiomas OWNER TO ccapu;

--
-- Name: cursos_cursoscategorias_idiomas_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursoscategorias_idiomas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursoscategorias_idiomas_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursoscategorias_idiomas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursoscategorias_idiomas_id_seq OWNED BY cursos_cursoscategorias_idiomas.id;


--
-- Name: cursos_cursoscategorias_rubros; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursoscategorias_rubros (
    id integer NOT NULL,
    cursoscategorias_id integer NOT NULL,
    rubros_id integer NOT NULL
);


ALTER TABLE cursos_cursoscategorias_rubros OWNER TO ccapu;

--
-- Name: cursos_cursoscategorias_rubro_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursoscategorias_rubro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursoscategorias_rubro_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursoscategorias_rubro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursoscategorias_rubro_id_seq OWNED BY cursos_cursoscategorias_rubros.id;


--
-- Name: cursos_cursosdeinteres; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_cursosdeinteres (
    id integer NOT NULL,
    titulo character varying(50) NOT NULL,
    detalle character varying(50) NOT NULL
);


ALTER TABLE cursos_cursosdeinteres OWNER TO ccapu;

--
-- Name: cursos_cursosdeinteres_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_cursosdeinteres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_cursosdeinteres_id_seq OWNER TO ccapu;

--
-- Name: cursos_cursosdeinteres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_cursosdeinteres_id_seq OWNED BY cursos_cursosdeinteres.id;


--
-- Name: cursos_idiomas; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_idiomas (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    nombre character varying(256) NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT cursos_idiomas_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_idiomas OWNER TO ccapu;

--
-- Name: cursos_idiomas_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_idiomas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_idiomas_id_seq OWNER TO ccapu;

--
-- Name: cursos_idiomas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_idiomas_id_seq OWNED BY cursos_idiomas.id;


--
-- Name: cursos_profesores; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_profesores (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    img character varying(200) NOT NULL,
    nombres character varying(128) NOT NULL,
    apellidos character varying(128) NOT NULL,
    detalle character varying(50) NOT NULL,
    cargo character varying(128) NOT NULL,
    descript text NOT NULL,
    linkedin character varying(200) NOT NULL,
    posicion integer NOT NULL,
    descript_simple text NOT NULL,
    CONSTRAINT cursos_profesores_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_profesores OWNER TO ccapu;

--
-- Name: cursos_profesores_cursos; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_profesores_cursos (
    id integer NOT NULL,
    profesores_id integer NOT NULL,
    cursos_id integer NOT NULL
);


ALTER TABLE cursos_profesores_cursos OWNER TO ccapu;

--
-- Name: cursos_profesores_cursos_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_profesores_cursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_profesores_cursos_id_seq OWNER TO ccapu;

--
-- Name: cursos_profesores_cursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_profesores_cursos_id_seq OWNED BY cursos_profesores_cursos.id;


--
-- Name: cursos_profesores_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_profesores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_profesores_id_seq OWNER TO ccapu;

--
-- Name: cursos_profesores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_profesores_id_seq OWNED BY cursos_profesores.id;


--
-- Name: cursos_rubros; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE cursos_rubros (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    posicion integer NOT NULL,
    nombre character varying(256) NOT NULL,
    CONSTRAINT cursos_rubros_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE cursos_rubros OWNER TO ccapu;

--
-- Name: cursos_rubros_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE cursos_rubros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cursos_rubros_id_seq OWNER TO ccapu;

--
-- Name: cursos_rubros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE cursos_rubros_id_seq OWNED BY cursos_rubros.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO ccapu;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO ccapu;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO ccapu;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO ccapu;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO ccapu;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO ccapu;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO ccapu;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO ccapu;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO ccapu;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: eventos_noticias_eventossociales; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE eventos_noticias_eventossociales (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    nombre character varying(512) NOT NULL,
    fecha date NOT NULL,
    img character varying(200) NOT NULL,
    descript text NOT NULL
);


ALTER TABLE eventos_noticias_eventossociales OWNER TO ccapu;

--
-- Name: eventos_noticias_eventossociales_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE eventos_noticias_eventossociales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_noticias_eventossociales_id_seq OWNER TO ccapu;

--
-- Name: eventos_noticias_eventossociales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE eventos_noticias_eventossociales_id_seq OWNED BY eventos_noticias_eventossociales.id;


--
-- Name: eventos_noticias_homeeventosseccion; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE eventos_noticias_homeeventosseccion (
    id integer NOT NULL,
    cabecera character varying(128) NOT NULL,
    b_titulo character varying(128) NOT NULL,
    b_descript text NOT NULL
);


ALTER TABLE eventos_noticias_homeeventosseccion OWNER TO ccapu;

--
-- Name: eventos_noticias_homeeventosseccion_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE eventos_noticias_homeeventosseccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_noticias_homeeventosseccion_id_seq OWNER TO ccapu;

--
-- Name: eventos_noticias_homeeventosseccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE eventos_noticias_homeeventosseccion_id_seq OWNED BY eventos_noticias_homeeventosseccion.id;


--
-- Name: eventos_noticias_homenoticiasseccion; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE eventos_noticias_homenoticiasseccion (
    id integer NOT NULL,
    cabecera character varying(128) NOT NULL,
    b_titulo character varying(128) NOT NULL,
    b_descript text NOT NULL
);


ALTER TABLE eventos_noticias_homenoticiasseccion OWNER TO ccapu;

--
-- Name: eventos_noticias_homenoticiasseccion_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE eventos_noticias_homenoticiasseccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_noticias_homenoticiasseccion_id_seq OWNER TO ccapu;

--
-- Name: eventos_noticias_homenoticiasseccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE eventos_noticias_homenoticiasseccion_id_seq OWNED BY eventos_noticias_homenoticiasseccion.id;


--
-- Name: eventos_noticias_noticias; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE eventos_noticias_noticias (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    fecha date NOT NULL,
    nombre character varying(256) NOT NULL,
    img character varying(200) NOT NULL,
    descript text NOT NULL,
    nombre_x character varying(258) NOT NULL
);


ALTER TABLE eventos_noticias_noticias OWNER TO ccapu;

--
-- Name: eventos_noticias_noticias_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE eventos_noticias_noticias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_noticias_noticias_id_seq OWNER TO ccapu;

--
-- Name: eventos_noticias_noticias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE eventos_noticias_noticias_id_seq OWNED BY eventos_noticias_noticias.id;


--
-- Name: formularios_contacto; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE formularios_contacto (
    id integer NOT NULL,
    fecha timestamp with time zone NOT NULL,
    nombres character varying(120) NOT NULL,
    email character varying(75) NOT NULL,
    telefono character varying(120) NOT NULL,
    empresa character varying(120) NOT NULL,
    mensaje text NOT NULL
);


ALTER TABLE formularios_contacto OWNER TO ccapu;

--
-- Name: formularios_contacto_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE formularios_contacto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE formularios_contacto_id_seq OWNER TO ccapu;

--
-- Name: formularios_contacto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE formularios_contacto_id_seq OWNED BY formularios_contacto.id;


--
-- Name: formularios_contactotrabajo; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE formularios_contactotrabajo (
    id integer NOT NULL,
    fecha timestamp with time zone NOT NULL,
    telefono character varying(256) NOT NULL,
    nombres character varying(120) NOT NULL,
    email character varying(75) NOT NULL,
    adjunto character varying(100) NOT NULL
);


ALTER TABLE formularios_contactotrabajo OWNER TO ccapu;

--
-- Name: formularios_contactotrabajo_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE formularios_contactotrabajo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE formularios_contactotrabajo_id_seq OWNER TO ccapu;

--
-- Name: formularios_contactotrabajo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE formularios_contactotrabajo_id_seq OWNED BY formularios_contactotrabajo.id;


--
-- Name: formularios_destinatarios; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE formularios_destinatarios (
    id integer NOT NULL,
    form_contacto character varying(1024) NOT NULL,
    form_suscript character varying(1024) NOT NULL,
    form_trabajo character varying(1024) NOT NULL,
    form_socios character varying(1024) NOT NULL
);


ALTER TABLE formularios_destinatarios OWNER TO ccapu;

--
-- Name: formularios_destinatarios_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE formularios_destinatarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE formularios_destinatarios_id_seq OWNER TO ccapu;

--
-- Name: formularios_destinatarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE formularios_destinatarios_id_seq OWNED BY formularios_destinatarios.id;


--
-- Name: formularios_socioscontacto; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE formularios_socioscontacto (
    id integer NOT NULL,
    fecha timestamp with time zone NOT NULL,
    nombres character varying(120) NOT NULL,
    email character varying(75) NOT NULL,
    telefono character varying(120) NOT NULL,
    empresa character varying(120) NOT NULL,
    mensaje text NOT NULL
);


ALTER TABLE formularios_socioscontacto OWNER TO ccapu;

--
-- Name: formularios_socioscontacto_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE formularios_socioscontacto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE formularios_socioscontacto_id_seq OWNER TO ccapu;

--
-- Name: formularios_socioscontacto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE formularios_socioscontacto_id_seq OWNED BY formularios_socioscontacto.id;


--
-- Name: formularios_suscript; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE formularios_suscript (
    id integer NOT NULL,
    fecha timestamp with time zone NOT NULL,
    nombres character varying(120) NOT NULL,
    email character varying(75) NOT NULL
);


ALTER TABLE formularios_suscript OWNER TO ccapu;

--
-- Name: formularios_suscript_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE formularios_suscript_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE formularios_suscript_id_seq OWNER TO ccapu;

--
-- Name: formularios_suscript_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE formularios_suscript_id_seq OWNED BY formularios_suscript.id;


--
-- Name: seo_infoseo; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE seo_infoseo (
    id integer NOT NULL,
    seo_alerts boolean NOT NULL,
    emails_support character varying(512) NOT NULL
);


ALTER TABLE seo_infoseo OWNER TO ccapu;

--
-- Name: seo_infoseo_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE seo_infoseo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seo_infoseo_id_seq OWNER TO ccapu;

--
-- Name: seo_infoseo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE seo_infoseo_id_seq OWNED BY seo_infoseo.id;


--
-- Name: seo_seoredirects; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE seo_seoredirects (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    url_in character varying(1024) NOT NULL,
    url_out character varying(1024) NOT NULL,
    code_type smallint NOT NULL
);


ALTER TABLE seo_seoredirects OWNER TO ccapu;

--
-- Name: seo_seoredirects_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE seo_seoredirects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seo_seoredirects_id_seq OWNER TO ccapu;

--
-- Name: seo_seoredirects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE seo_seoredirects_id_seq OWNED BY seo_seoredirects.id;


--
-- Name: seo_seotags; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE seo_seotags (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    url_seo character varying(1024) NOT NULL,
    title character varying(70) NOT NULL,
    descript text NOT NULL,
    extend text NOT NULL
);


ALTER TABLE seo_seotags OWNER TO ccapu;

--
-- Name: seo_seotags_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE seo_seotags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seo_seotags_id_seq OWNER TO ccapu;

--
-- Name: seo_seotags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE seo_seotags_id_seq OWNED BY seo_seotags.id;


--
-- Name: seo_urlregister; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE seo_urlregister (
    id integer NOT NULL,
    url character varying(1024) NOT NULL
);


ALTER TABLE seo_urlregister OWNER TO ccapu;

--
-- Name: seo_urlregister_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE seo_urlregister_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seo_urlregister_id_seq OWNER TO ccapu;

--
-- Name: seo_urlregister_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE seo_urlregister_id_seq OWNED BY seo_urlregister.id;


--
-- Name: terminos_preguntas_quest; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE terminos_preguntas_quest (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    nombre character varying(256) NOT NULL,
    descript text NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT terminos_preguntas_quest_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE terminos_preguntas_quest OWNER TO ccapu;

--
-- Name: terminos_preguntas_quest_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE terminos_preguntas_quest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE terminos_preguntas_quest_id_seq OWNER TO ccapu;

--
-- Name: terminos_preguntas_quest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE terminos_preguntas_quest_id_seq OWNED BY terminos_preguntas_quest.id;


--
-- Name: terminos_preguntas_questseccion; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE terminos_preguntas_questseccion (
    id integer NOT NULL,
    cabecera character varying(128) NOT NULL,
    b_titulo character varying(128) NOT NULL
);


ALTER TABLE terminos_preguntas_questseccion OWNER TO ccapu;

--
-- Name: terminos_preguntas_questseccion_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE terminos_preguntas_questseccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE terminos_preguntas_questseccion_id_seq OWNER TO ccapu;

--
-- Name: terminos_preguntas_questseccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE terminos_preguntas_questseccion_id_seq OWNED BY terminos_preguntas_questseccion.id;


--
-- Name: terminos_preguntas_terms; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE terminos_preguntas_terms (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    slug character varying(180) NOT NULL,
    nombre character varying(256) NOT NULL,
    descript text NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT terminos_preguntas_terms_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE terminos_preguntas_terms OWNER TO ccapu;

--
-- Name: terminos_preguntas_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE terminos_preguntas_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE terminos_preguntas_terms_id_seq OWNER TO ccapu;

--
-- Name: terminos_preguntas_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE terminos_preguntas_terms_id_seq OWNED BY terminos_preguntas_terms.id;


--
-- Name: terminos_preguntas_termsseccion; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE terminos_preguntas_termsseccion (
    id integer NOT NULL,
    cabecera character varying(128) NOT NULL,
    b_titulo character varying(128) NOT NULL
);


ALTER TABLE terminos_preguntas_termsseccion OWNER TO ccapu;

--
-- Name: terminos_preguntas_termsseccion_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE terminos_preguntas_termsseccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE terminos_preguntas_termsseccion_id_seq OWNER TO ccapu;

--
-- Name: terminos_preguntas_termsseccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE terminos_preguntas_termsseccion_id_seq OWNED BY terminos_preguntas_termsseccion.id;


--
-- Name: web_clientes; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_clientes (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    img character varying(200) NOT NULL,
    nombre character varying(256) NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT web_clientes_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE web_clientes OWNER TO ccapu;

--
-- Name: web_clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_clientes_id_seq OWNER TO ccapu;

--
-- Name: web_clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_clientes_id_seq OWNED BY web_clientes.id;


--
-- Name: web_conocenos; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_conocenos (
    id integer NOT NULL,
    cabecera character varying(50) NOT NULL,
    img character varying(200) NOT NULL,
    qs text NOT NULL,
    pa text NOT NULL,
    ms text NOT NULL,
    vs text NOT NULL,
    bg_titulo character varying(50) NOT NULL,
    bg_img character varying(200) NOT NULL,
    bg_vid character varying(1024) NOT NULL,
    bg_vid_id character varying(50) NOT NULL,
    cf_descript text NOT NULL,
    cf_img character varying(200) NOT NULL,
    cf_vid character varying(1024) NOT NULL,
    cf_vid_id character varying(50) NOT NULL,
    ns_titulo character varying(64) NOT NULL,
    ns_descript text NOT NULL,
    nr_titulo character varying(64) NOT NULL,
    nr_descript text NOT NULL
);


ALTER TABLE web_conocenos OWNER TO ccapu;

--
-- Name: web_conocenos_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_conocenos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_conocenos_id_seq OWNER TO ccapu;

--
-- Name: web_conocenos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_conocenos_id_seq OWNED BY web_conocenos.id;


--
-- Name: web_contactoseccion; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_contactoseccion (
    id integer NOT NULL,
    cabecera character varying(64) NOT NULL,
    titulo character varying(64) NOT NULL,
    descript text NOT NULL
);


ALTER TABLE web_contactoseccion OWNER TO ccapu;

--
-- Name: web_contactoseccion_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_contactoseccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_contactoseccion_id_seq OWNER TO ccapu;

--
-- Name: web_contactoseccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_contactoseccion_id_seq OWNED BY web_contactoseccion.id;


--
-- Name: web_ellosopinan; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_ellosopinan (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    img character varying(200) NOT NULL,
    nombre character varying(256) NOT NULL,
    cargo character varying(128) NOT NULL,
    descript text NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT web_staff_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE web_ellosopinan OWNER TO ccapu;

--
-- Name: web_infosite; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_infosite (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    email character varying(128) NOT NULL,
    telefono character varying(50) NOT NULL,
    direccion character varying(120) NOT NULL,
    site character varying(60) NOT NULL,
    facebook character varying(200) NOT NULL,
    twitter character varying(200) NOT NULL,
    youtube character varying(200) NOT NULL,
    instagram character varying(200) NOT NULL,
    linkedin character varying(200) NOT NULL,
    pinterest character varying(200) NOT NULL,
    titulo character varying(40) NOT NULL,
    ga character varying(24) NOT NULL,
    coordenadas character varying(42) NOT NULL,
    favi57 character varying(200) NOT NULL,
    favi72 character varying(200) NOT NULL,
    favi114 character varying(200) NOT NULL,
    favi256 character varying(200) NOT NULL,
    whatsapp character varying(50) NOT NULL,
    footer_inf text NOT NULL
);


ALTER TABLE web_infosite OWNER TO ccapu;

--
-- Name: web_infosite_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_infosite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_infosite_id_seq OWNER TO ccapu;

--
-- Name: web_infosite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_infosite_id_seq OWNED BY web_infosite.id;


--
-- Name: web_libroseccion; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_libroseccion (
    id integer NOT NULL,
    cabecera character varying(64) NOT NULL,
    descript text NOT NULL,
    pie text NOT NULL
);


ALTER TABLE web_libroseccion OWNER TO ccapu;

--
-- Name: web_libroseccion_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_libroseccion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_libroseccion_id_seq OWNER TO ccapu;

--
-- Name: web_libroseccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_libroseccion_id_seq OWNED BY web_libroseccion.id;


--
-- Name: web_paises; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_paises (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    posicion integer NOT NULL,
    img character varying(200) NOT NULL,
    nombre character varying(64) NOT NULL,
    CONSTRAINT web_paises_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE web_paises OWNER TO ccapu;

--
-- Name: web_paises_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_paises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_paises_id_seq OWNER TO ccapu;

--
-- Name: web_paises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_paises_id_seq OWNED BY web_paises.id;


--
-- Name: web_porqueelegirnos; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_porqueelegirnos (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    icon character varying(200) NOT NULL,
    icon_h character varying(200) NOT NULL,
    nombre character varying(64) NOT NULL,
    descript text NOT NULL,
    posicion integer NOT NULL,
    enlace character varying(1024) NOT NULL,
    CONSTRAINT web_porqueelegirnos_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE web_porqueelegirnos OWNER TO ccapu;

--
-- Name: web_porqueelegirnos_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_porqueelegirnos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_porqueelegirnos_id_seq OWNER TO ccapu;

--
-- Name: web_porqueelegirnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_porqueelegirnos_id_seq OWNED BY web_porqueelegirnos.id;


--
-- Name: web_respaldos; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_respaldos (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    img character varying(200) NOT NULL,
    nombre character varying(50) NOT NULL,
    posicion integer NOT NULL,
    CONSTRAINT web_respaldos_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE web_respaldos OWNER TO ccapu;

--
-- Name: web_respaldos_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_respaldos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_respaldos_id_seq OWNER TO ccapu;

--
-- Name: web_respaldos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_respaldos_id_seq OWNED BY web_respaldos.id;


--
-- Name: web_sliders; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_sliders (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    posicion integer NOT NULL,
    titulo character varying(256) NOT NULL,
    fondo character varying(200) NOT NULL,
    enlace character varying(1024) NOT NULL,
    enlace_text character varying(360) NOT NULL,
    CONSTRAINT web_sliders_posicion_check CHECK ((posicion >= 0))
);


ALTER TABLE web_sliders OWNER TO ccapu;

--
-- Name: web_sliders_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_sliders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_sliders_id_seq OWNER TO ccapu;

--
-- Name: web_sliders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_sliders_id_seq OWNED BY web_sliders.id;


--
-- Name: web_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_staff_id_seq OWNER TO ccapu;

--
-- Name: web_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_staff_id_seq OWNED BY web_ellosopinan.id;


--
-- Name: web_translaterdicc; Type: TABLE; Schema: public; Owner: ccapu
--

CREATE TABLE web_translaterdicc (
    id integer NOT NULL,
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    created_by integer,
    modified_by integer,
    variable character varying(520) NOT NULL,
    nombre character varying(520) NOT NULL,
    nombre_es character varying(520),
    nombre_en character varying(520),
    nombre_pt character varying(520)
);


ALTER TABLE web_translaterdicc OWNER TO ccapu;

--
-- Name: web_translaterdicc_id_seq; Type: SEQUENCE; Schema: public; Owner: ccapu
--

CREATE SEQUENCE web_translaterdicc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web_translaterdicc_id_seq OWNER TO ccapu;

--
-- Name: web_translaterdicc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ccapu
--

ALTER SEQUENCE web_translaterdicc_id_seq OWNED BY web_translaterdicc.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY admin_honeypot_loginattempt ALTER COLUMN id SET DEFAULT nextval('admin_honeypot_loginattempt_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_beneficios ALTER COLUMN id SET DEFAULT nextval('cursos_beneficios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_contenidos ALTER COLUMN id SET DEFAULT nextval('cursos_contenidos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos ALTER COLUMN id SET DEFAULT nextval('cursos_cursos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_idiomas ALTER COLUMN id SET DEFAULT nextval('cursos_cursos_idiomas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_rubro ALTER COLUMN id SET DEFAULT nextval('cursos_cursos_rubro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias ALTER COLUMN id SET DEFAULT nextval('cursos_cursoscategorias_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_idiomas ALTER COLUMN id SET DEFAULT nextval('cursos_cursoscategorias_idiomas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_rubros ALTER COLUMN id SET DEFAULT nextval('cursos_cursoscategorias_rubro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursosdeinteres ALTER COLUMN id SET DEFAULT nextval('cursos_cursosdeinteres_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_idiomas ALTER COLUMN id SET DEFAULT nextval('cursos_idiomas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores ALTER COLUMN id SET DEFAULT nextval('cursos_profesores_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores_cursos ALTER COLUMN id SET DEFAULT nextval('cursos_profesores_cursos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_rubros ALTER COLUMN id SET DEFAULT nextval('cursos_rubros_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_eventossociales ALTER COLUMN id SET DEFAULT nextval('eventos_noticias_eventossociales_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_homeeventosseccion ALTER COLUMN id SET DEFAULT nextval('eventos_noticias_homeeventosseccion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_homenoticiasseccion ALTER COLUMN id SET DEFAULT nextval('eventos_noticias_homenoticiasseccion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_noticias ALTER COLUMN id SET DEFAULT nextval('eventos_noticias_noticias_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_contacto ALTER COLUMN id SET DEFAULT nextval('formularios_contacto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_contactotrabajo ALTER COLUMN id SET DEFAULT nextval('formularios_contactotrabajo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_destinatarios ALTER COLUMN id SET DEFAULT nextval('formularios_destinatarios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_socioscontacto ALTER COLUMN id SET DEFAULT nextval('formularios_socioscontacto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_suscript ALTER COLUMN id SET DEFAULT nextval('formularios_suscript_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_infoseo ALTER COLUMN id SET DEFAULT nextval('seo_infoseo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_seoredirects ALTER COLUMN id SET DEFAULT nextval('seo_seoredirects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_seotags ALTER COLUMN id SET DEFAULT nextval('seo_seotags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_urlregister ALTER COLUMN id SET DEFAULT nextval('seo_urlregister_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_quest ALTER COLUMN id SET DEFAULT nextval('terminos_preguntas_quest_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_questseccion ALTER COLUMN id SET DEFAULT nextval('terminos_preguntas_questseccion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_terms ALTER COLUMN id SET DEFAULT nextval('terminos_preguntas_terms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_termsseccion ALTER COLUMN id SET DEFAULT nextval('terminos_preguntas_termsseccion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_clientes ALTER COLUMN id SET DEFAULT nextval('web_clientes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_conocenos ALTER COLUMN id SET DEFAULT nextval('web_conocenos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_contactoseccion ALTER COLUMN id SET DEFAULT nextval('web_contactoseccion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_ellosopinan ALTER COLUMN id SET DEFAULT nextval('web_staff_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_infosite ALTER COLUMN id SET DEFAULT nextval('web_infosite_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_libroseccion ALTER COLUMN id SET DEFAULT nextval('web_libroseccion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_paises ALTER COLUMN id SET DEFAULT nextval('web_paises_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_porqueelegirnos ALTER COLUMN id SET DEFAULT nextval('web_porqueelegirnos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_respaldos ALTER COLUMN id SET DEFAULT nextval('web_respaldos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_sliders ALTER COLUMN id SET DEFAULT nextval('web_sliders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_translaterdicc ALTER COLUMN id SET DEFAULT nextval('web_translaterdicc_id_seq'::regclass);


--
-- Data for Name: admin_honeypot_loginattempt; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY admin_honeypot_loginattempt (id, username, ip_address, session_key, user_agent, "timestamp", path) FROM stdin;
\.


--
-- Name: admin_honeypot_loginattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('admin_honeypot_loginattempt_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add log entry	7	add_logentry
20	Can change log entry	7	change_logentry
21	Can delete log entry	7	delete_logentry
22	Can add login attempt	8	add_loginattempt
23	Can change login attempt	8	change_loginattempt
24	Can delete login attempt	8	delete_loginattempt
25	Can add info site	9	add_infosite
26	Can change info site	9	change_infosite
27	Can delete info site	9	delete_infosite
28	Can add item	10	add_sliders
29	Can change item	10	change_sliders
30	Can delete item	10	delete_sliders
31	Can add item	11	add_porqueelegirnos
32	Can change item	11	change_porqueelegirnos
33	Can delete item	11	delete_porqueelegirnos
34	Can add Conócenos	12	add_conocenos
35	Can change Conócenos	12	change_conocenos
36	Can delete Conócenos	12	delete_conocenos
37	Can add cliente	13	add_clientes
38	Can change cliente	13	change_clientes
39	Can delete cliente	13	delete_clientes
43	Can add cliente	15	add_respaldos
44	Can change cliente	15	change_respaldos
45	Can delete cliente	15	delete_respaldos
46	Can add país	16	add_paises
47	Can change país	16	change_paises
48	Can delete país	16	delete_paises
49	Can add Palabra	17	add_translaterdicc
50	Can change Palabra	17	change_translaterdicc
51	Can delete Palabra	17	delete_translaterdicc
52	Can add Eventos Sección	18	add_homeeventosseccion
53	Can change Eventos Sección	18	change_homeeventosseccion
54	Can delete Eventos Sección	18	delete_homeeventosseccion
55	Can add Evento	19	add_eventossociales
56	Can change Evento	19	change_eventossociales
57	Can delete Evento	19	delete_eventossociales
58	Can add Noticias Sección	20	add_homenoticiasseccion
59	Can change Noticias Sección	20	change_homenoticiasseccion
60	Can delete Noticias Sección	20	delete_homenoticiasseccion
61	Can add Noticia	21	add_noticias
62	Can change Noticia	21	change_noticias
63	Can delete Noticia	21	delete_noticias
64	Can add Terminos Sección	22	add_termsseccion
65	Can change Terminos Sección	22	change_termsseccion
66	Can delete Terminos Sección	22	delete_termsseccion
67	Can add termino	23	add_terms
68	Can change termino	23	change_terms
69	Can delete termino	23	delete_terms
70	Can add Preguntas Sección	24	add_questseccion
71	Can change Preguntas Sección	24	change_questseccion
72	Can delete Preguntas Sección	24	delete_questseccion
73	Can add Pregunta frecuente	25	add_quest
74	Can change Pregunta frecuente	25	change_quest
75	Can delete Pregunta frecuente	25	delete_quest
76	Can add categoría	26	add_cursoscategorias
77	Can change categoría	26	change_cursoscategorias
78	Can delete categoría	26	delete_cursoscategorias
79	Can add rubro	27	add_rubros
80	Can change rubro	27	change_rubros
81	Can delete rubro	27	delete_rubros
82	Can add curso	28	add_cursos
83	Can change curso	28	change_cursos
84	Can delete curso	28	delete_cursos
88	Can add contenido	30	add_contenidos
89	Can change contenido	30	change_contenidos
90	Can delete contenido	30	delete_contenidos
91	Can add Profesor	31	add_profesores
92	Can change Profesor	31	change_profesores
93	Can delete Profesor	31	delete_profesores
94	Can add Destinatarios	32	add_destinatarios
95	Can change Destinatarios	32	change_destinatarios
96	Can delete Destinatarios	32	delete_destinatarios
97	Can add Contacto	33	add_contacto
98	Can change Contacto	33	change_contacto
99	Can delete Contacto	33	delete_contacto
100	Can add Contacto Socio	34	add_socioscontacto
101	Can change Contacto Socio	34	change_socioscontacto
102	Can delete Contacto Socio	34	delete_socioscontacto
103	Can add Contacto	35	add_contactotrabajo
104	Can change Contacto	35	change_contactotrabajo
105	Can delete Contacto	35	delete_contactotrabajo
106	Can add suscriptor	36	add_suscript
107	Can change suscriptor	36	change_suscript
108	Can delete suscriptor	36	delete_suscript
109	Can add Configuración General	37	add_infoseo
110	Can change Configuración General	37	change_infoseo
111	Can delete Configuración General	37	delete_infoseo
112	Can add url	38	add_urlregister
113	Can change url	38	change_urlregister
114	Can delete url	38	delete_urlregister
115	Can add Título y descripción	39	add_seotags
116	Can change Título y descripción	39	change_seotags
117	Can delete Título y descripción	39	delete_seotags
118	Can add redirección	40	add_seoredirects
119	Can change redirección	40	change_seoredirects
120	Can delete redirección	40	delete_seoredirects
121	Can add Beneficio	41	add_beneficios
122	Can change Beneficio	41	change_beneficios
123	Can delete Beneficio	41	delete_beneficios
127	Can add Cusos de Interés	43	add_cursosdeinteres
128	Can change Cusos de Interés	43	change_cursosdeinteres
129	Can delete Cusos de Interés	43	delete_cursosdeinteres
130	Can add persona	44	add_ellosopinan
131	Can change persona	44	change_ellosopinan
132	Can delete persona	44	delete_ellosopinan
133	Can add Contacto Sección	45	add_contactoseccion
134	Can change Contacto Sección	45	change_contactoseccion
135	Can delete Contacto Sección	45	delete_contactoseccion
136	Can add Lib. de Reclamaciones Sección	46	add_libroseccion
137	Can change Lib. de Reclamaciones Sección	46	change_libroseccion
138	Can delete Lib. de Reclamaciones Sección	46	delete_libroseccion
142	Can add idioma	48	add_idiomas
143	Can change idioma	48	change_idiomas
144	Can delete idioma	48	delete_idiomas
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('auth_permission_id_seq', 144, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$15000$re0Mr9TPCGnT$/tIpNJ8mHjJbizwzBtCmpHAHOQwDC3RhaQe5Q/321NI=	2017-02-23 11:37:43.813967-05	t	ccapudev			chevarrias@gmail.com	t	t	2017-02-23 11:37:24.989367-05
1	pbkdf2_sha256$15000$71q3Nwom714C$HtNmEDjBt284m6adjcfl/5hALPQ5Ftc7jgFFmHZE2ik=	2017-02-23 11:35:48-05	t	admin			chevarrias@gmail.com	t	t	2017-02-16 11:56:28-05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: cache_table; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cache_table (cache_key, value, expires) FROM stdin;
:1:rl:56f0c5ae2816fae857c0c5892a2496f8	gAJLAS4=	2017-02-16 19:40:40-05
:1:b1f0a076a4656en	gAJYBwAAAE5vbWJyZXNxAS4=	2017-02-16 23:46:29-05
:1:b1f0a076a4656pt	gAJYBwAAAE5vbWJyZXNxAS4=	2017-02-16 23:46:30-05
:1:48705aa6c3a08es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCgAAAENPTsOTQ0VOT1NxAoWBcQN9cQRiLg==	2017-02-21 18:41:32-05
:1:8d45d50f1275ces	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYDQAAAFF1aWVuZXMgc29tb3NxAoWBcQN9cQRiLg==	2017-02-21 19:42:36-05
:1:fcc9b6b082c4fes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYDwAAAFByb2plY3QgQWNhZGVteXEChYFxA31xBGIu	2017-02-21 19:42:36-05
:1:e2bf825da29bbes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBwAAAE1pc2nDs25xAoWBcQN9cQRiLg==	2017-02-21 19:42:36-05
:1:a7b2a45f95bf6es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBwAAAFZpc2nDs25xAoWBcQN9cQRiLg==	2017-02-21 19:42:36-05
:1:f720d44d4e57aes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYGgAAAHBvciBxdcOpIDxzdHJvbmc+ZWxlZ2lybm9zcQKFgXEDfXEEYi4=	2017-02-21 19:42:36-05
:1:85954391f2277es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCwAAAENvbnRhY3Rhbm9zcQKFgXEDfXEEYi4=	2017-02-21 19:43:51-05
:1:1d1c7e5bc2d84es	gAJYEQAAAFBPUlFVw4kgRUxFR0lSTk9TcQEu	2017-02-21 20:51:49-05
:1:10eac818e66dees	gAJYDQAAAENPTU8gRlVOQ0lPTkFxAS4=	2017-02-21 20:52:34-05
:1:6d54c006f7b80es	gAJYCAAAAFZFUiBNw4FTcQEu	2017-02-21 20:52:34-05
:1:b5b4d2091e61ces	gAJYGwAAAE1BTlRFTlRFPC9zdHJvbmc+IElORk9STUFET3EBLg==	2017-02-21 20:52:34-05
:1:6fb57a4aff5f3es	gAJYGQAAAE5VRVNUUk9TPC9zdHJvbmc+IEVWRU5UT1NxAS4=	2017-02-21 20:52:34-05
:1:af17757ae9597es	gAJYKwAAAMKhc3VzY3JpYmV0ZSBhaG9yYSE8c3Ryb25nPmUgaW5mb3JtYXRlIG3DoXNxAS4=	2017-02-21 20:52:34-05
:1:c026af5305b33es	gAJYBgAAAEVOVklBUnEBLg==	2017-02-21 20:52:34-05
:1:3d948be5f236ces	gAJYGgAAAE51ZXN0cm9zIDxzdHJvbmc+Q0xJRU5URVM6cQEu	2017-02-21 20:52:34-05
:1:6f9420d19302des	gAJYJQAAAE51ZXN0cm9zIGFsdW1ub3M8c3Ryb25nPlBST1ZJRU5FTiBERTpxAS4=	2017-02-21 20:52:34-05
:1:209b518000fa5es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCQAAAE1vZGFsaWRhZHEChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:003480a1d97a3es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBgAAAElkaW9tYXEChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:c6de13e3df467es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBQAAAFJ1YnJvcQKFgXEDfXEEYi4=	2017-02-21 22:17:26-05
:1:8f00112720d85es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYDAAAAERlc2NyaXBjacOzbnEChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:cfc090151f9f4es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYFwAAAERFVEFMTEVTIFkgTU9EQUxJREFERVM6cQKFgXEDfXEEYi4=	2017-02-21 22:17:26-05
:1:0aa48f19405f6es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBwAAAEZlY2hhczpxAoWBcQN9cQRiLg==	2017-02-21 22:17:26-05
:1:0996b35d633c3es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCQAAAEhvcmFyaW9zOnEChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:5389f4963e49aes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBgAAAEx1Z2FyOnEChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:17fb868f3a774es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCwAAAEludmVyc2nDs246cQKFgXEDfXEEYi4=	2017-02-21 22:17:26-05
:1:b4134ef50d63ces	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYDAAAAGNvbnTDoWN0YW5vc3EChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:11f03b0b44601es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYDQAAAGNvbXByYXIgY3Vyc29xAoWBcQN9cQRiLg==	2017-02-21 22:17:26-05
:1:7b5666f0287e6es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYDAAAAG1ldG9kb2xvZ8OtYXEChYFxA31xBGIu	2017-02-21 22:17:26-05
:1:c9cda79623a06es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCgAAAGNvbnRlbmlkb3NxAoWBcQN9cQRiLg==	2017-02-21 22:17:26-05
:1:1a0b74013b13ces	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCAAAAGRvY2VudGVzcQKFgXEDfXEEYi4=	2017-02-21 22:17:26-05
:1:6db51f850801aes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCgAAAGJlbmVmaWNpb3NxAoWBcQN9cQRiLg==	2017-02-21 22:17:26-05
:1:652e4ef618d6des	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCgAAAGludmVyc2nDs25xAoWBcQN9cQRiLg==	2017-02-21 22:17:26-05
:1:9099af2a96f8aes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCgAAAG1ldG9sb2fDrWFxAoWBcQN9cQRiLg==	2017-02-21 22:51:57-05
:1:7dcd411130b34es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYJQAAAE5VRVNUUk8gPHN0cm9uZz5DT05URU5JRE8gREVUQUxMQURPIDpxAoWBcQN9cQRiLg==	2017-02-21 22:51:57-05
:1:19f47cb41e7c4es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCQAAAGNvbnRlbmlkb3EChYFxA31xBGIu	2017-02-21 22:51:57-05
:1:584d3ef1cf22ces	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYIwAAAENPTsOTQ0UgTlVFU1RST1MgPHN0cm9uZz5CRU5FRklDSU9TcQKFgXEDfXEEYi4=	2017-02-21 22:51:57-05
:1:eae45b970eae9es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCAAAAG9iamV0aXZvcQKFgXEDfXEEYi4=	2017-02-21 22:51:57-05
:1:06884adebb3e3es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYHQAAAENPTsOTQ0UgTEEgPHN0cm9uZz5JTlZFUlNJw5NOcQKFgXEDfXEEYi4=	2017-02-21 22:51:57-05
:1:92ef232adb741es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYCgAAAEludmVyc2nDs25xAoWBcQN9cQRiLg==	2017-02-21 22:51:57-05
:1:2f076f1b7c64fes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYFQAAAFNPTElDSVRBIElORk9STUFDScOTTnEChYFxA31xBGIu	2017-02-21 22:51:57-05
:1:5ce9cfb207f2fes	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYXQAAAFBhcmEgbcOhcyBpbmZvcm1hY2nDs24gbGxlbmEgdHVzIGRhdG9zIHkgbm9zIGVzdGFyZW1vcyBjb211bmljYW5kbyBjb250aWdvPGJyPiBhIGxhIGJyZXZlZGFkLnEChYFxA31xBGIu	2017-02-21 22:51:57-05
:1:0a20c82fd2886es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBgAAAENvcnJlb3EChYFxA31xBGIu	2017-02-21 22:52:33-05
:1:6c94c8c88cc34es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBwAAAEVtcHJlc2FxAoWBcQN9cQRiLg==	2017-02-21 22:52:33-05
:1:f7294b7b5fb93es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBgAAAENpdWRhZHEChYFxA31xBGIu	2017-02-21 22:52:33-05
:1:44a536c7c37e6es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYEgAAAERlamUgc3UgZHVkYSBhcXVpOnEChYFxA31xBGIu	2017-02-21 22:52:33-05
:1:575e4735844d8es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYPwAAAEFjZXB0byBMYXMgY29uZGljaW9uZXMgZGUgdHJhdGFtaWVudG8gcGFyYSBtaXMgZGF0b3MgcGVyc29uYWxlc3EChYFxA31xBGIu	2017-02-21 22:52:33-05
:1:13bc49a5e4d89es	gAJjZGphbmdvLnV0aWxzLnNhZmVzdHJpbmcKU2FmZVRleHQKcQFYBAAAAFBhaXNxAoWBcQN9cQRiLg==	2017-02-21 22:52:49-05
:1:96cb4572a7bd3es	gAJYDgAAAEluaWNpYSBTZXNpw7NucQEu	2017-02-22 00:00:47-05
:1:daceeebafa82ces	gAJYCgAAAFJlZ2lzdHJhdGVxAS4=	2017-02-22 00:00:47-05
:1:148ba6e401d4bes	gAJYCgAAAE1pIENhcnJpdG9xAS4=	2017-02-22 00:00:47-05
:1:1b96bc00048f5es	gAJYCgAAAENvbsOzY2Vub3NxAS4=	2017-02-22 00:00:47-05
:1:a412ced8e9c0ces	gAJYFgAAAFRlcm1pbm9zIHkgQ29uZGljaW9uZXNxAS4=	2017-02-22 00:00:47-05
:1:4e6bb31184357es	gAJYFAAAAFByZWd1bnRhcyBGcmVjdWVudGVzcQEu	2017-02-22 00:00:47-05
:1:ccd52e8146f14es	gAJYCAAAAE5vdGljaWFzcQEu	2017-02-22 00:00:47-05
:1:301b7b4507b26es	gAJYBwAAAEV2ZW50b3NxAS4=	2017-02-22 00:00:47-05
:1:984f6dc1d53f7es	gAJYDAAAAENvbnTDoWN0YW5vc3EBLg==	2017-02-22 00:00:47-05
:1:61109fa4c57b3es	gAJYDQAAAFPDrWd1ZW5vcyBlbjpxAS4=	2017-02-22 00:00:47-05
:1:4b91ba9ecabe6es	gAJYEgAAAElSIEEgQ0FNUFVTIE9OTElORXEBLg==	2017-02-22 00:00:47-05
:1:92cd27aa496e5es	gAJYDwAAAHNvYnJlIG5vc29zdHJvc3EBLg==	2017-02-22 00:00:48-05
:1:6e6ed4a02a990es	gAJYCwAAAFNpZ3Vlbm9zIGVucQEu	2017-02-22 00:00:48-05
:1:179eed8d04d10es	gAJYDAAAAFRlIE9mcmVjZW1vc3EBLg==	2017-02-22 00:00:48-05
:1:6c81a6529879ces	gAJYEwAAAFNlcnZpY2lvIGFsIGNsaWVudGVxAS4=	2017-02-22 00:00:48-05
:1:6bedb38ad1718es	gAJYFgAAAFRlcm1pbm9zIHkgY29uZGljaW9uZXNxAS4=	2017-02-22 00:00:48-05
:1:45f6385817fe6es	gAJYFgAAAExpYnJvIGRlIHJlY2xhbWFjaW9uZXNxAS4=	2017-02-22 00:00:48-05
:1:9f8d34153635fes	gAJYCAAAAENvbnRhY3RvcQEu	2017-02-22 00:00:48-05
:1:76889398e6204es	gAJYCQAAAE1pIGN1ZW50YXEBLg==	2017-02-22 00:00:48-05
:1:56e30eb9d7ca2es	gAJYGAAAAE9sdmlkYXN0ZSB0dSBjb250cmFzZcOxYXEBLg==	2017-02-22 00:00:48-05
:1:9c8fdc447c8abes	gAJYDwAAAENvbnRhY3Rhbm9zIGFsOnEBLg==	2017-02-22 00:00:48-05
:1:8db8b3f226a8aes	gAJYDwAAAE1ldG9kb3MgZGUgcGFnb3EBLg==	2017-02-22 00:00:48-05
:1:a1458202d9282es	gAJYHQAAAFRvZG9zIGxvcyBEZXJlY2hvcyBSZXNlcnZhZG9zcQEu	2017-02-22 00:00:48-05
:1:b3b4488c38f8bes	gAJYEwAAAERpc2XDsW8gUMOhZ2luYSBXZWJxAS4=	2017-02-22 00:00:48-05
:1:086e548aeccd4es	gAJYHAAAAMKhUmVnaXN0cmF0ZTwvc3Ryb25nPiBhaG9yYSFxAS4=	2017-02-22 00:00:48-05
:1:59a1b26fc172des	gAJYMgAAAMKhU2kgbm8gdGllbmVzIHVuYSBjdWVudGEgcmVnaXN0cmF0ZSB5IGVtcGllemEgeWEucQEu	2017-02-22 00:00:48-05
:1:765141384d994es	gAJYBgAAAE5vbWJyZXEBLg==	2017-02-22 00:00:48-05
:1:b935d73ef5396es	gAJYCQAAAEFwZWxsaWRvc3EBLg==	2017-02-22 00:00:48-05
:1:afd5b95a04566es	gAJYEgAAAFRlbGVmb25vIC8gQ2VsdWxhcnEBLg==	2017-02-22 00:00:48-05
:1:a1dba5a270f87es	gAJYEgAAAENvcnJlbyBFbGVjdMOzbmljb3EBLg==	2017-02-22 00:00:48-05
:1:5b64653acc3fces	gAJYEQAAAE51ZXZhIENvbnRyYXNlw7FhcQEu	2017-02-22 00:00:48-05
:1:df50f0bb80f38es	gAJYEwAAAFJlcGV0aXIgQ29udHJhc2XDsWFxAS4=	2017-02-22 00:00:48-05
:1:716d0d65d338aes	gAJYDwAAAEluaWNpYXIgU2VzacOzbnEBLg==	2017-02-22 00:00:48-05
:1:9fbf2d9e824a9es	gAJYIQAAAE9sdmlkYXN0ZSB0dTwvc3Ryb25nPiBjb250cmFzZcOxYXEBLg==	2017-02-22 00:00:48-05
:1:367f2f2291608es	gAJYbwAAAEVzY3JpYmUgdHUgZGlyZWNjacOzbiBkZSBjb3JyZW8gZWxlY3Ryw7NuaWNvLjxicj5MZSBlbnZpYXJlbW9zIHVuIGVubGFjZSBwYXJhIHF1ZSBwdWVkYSBjYW1iaWFyIHN1IGNvbnRyYXNlw7FhLnEBLg==	2017-02-22 00:00:48-05
:1:69a8da8a58755es	gAJYEQAAAEVzY3JpYmUgdHUgY29ycmVvcQEu	2017-02-22 00:00:48-05
:1:08a573d006525es	gAJYBgAAAEVudmlhcnEBLg==	2017-02-22 00:00:48-05
:1:b1f0a076a4656es	gAJYBwAAAE5vbWJyZXNxAS4=	2017-02-22 00:00:55-05
:1:67e40ad8f62fdes	gAJYEwAAAENvcnJlbyBFbGVjdHLDs25pY29xAS4=	2017-02-22 00:00:55-05
:1:9590edf63bf71es	gAJYEQAAAFRlbMOpZm9uby9DZWx1bGFycQEu	2017-02-22 00:00:55-05
:1:8e43055ba0eaaes	gAJYDwAAAERlamEgdHUgbWVuc2FqZXEBLg==	2017-02-22 00:00:55-05
:1:b465968b9e9fdes	gAJYCwAAAEVzY3LDrWJlbm9zcQEu	2017-02-22 00:00:55-05
:1:5ec4017006cf4es	gAJYCAAAAExsYW1hbm9zcQEu	2017-02-22 00:00:55-05
\.


--
-- Data for Name: cursos_beneficios; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_beneficios (id, active, created, modified, created_by, modified_by, nombre, descript, posicion, curso_id) FROM stdin;
1	t	2017-02-23 15:28:57.605667-05	2017-02-23 15:28:57.605706-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	1
2	t	2017-02-23 15:28:57.610355-05	2017-02-23 15:28:57.610398-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	1
3	t	2017-02-23 15:29:06.811918-05	2017-02-23 15:29:06.811963-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	2
4	t	2017-02-23 15:29:06.813123-05	2017-02-23 15:29:06.813156-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	2
5	t	2017-02-23 15:29:08.916577-05	2017-02-23 15:29:08.916613-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	3
6	t	2017-02-23 15:29:08.917853-05	2017-02-23 15:29:08.917904-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	3
7	t	2017-02-23 15:29:09.809498-05	2017-02-23 15:29:09.809543-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	4
8	t	2017-02-23 15:29:09.817206-05	2017-02-23 15:29:09.817259-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	4
9	t	2017-02-23 15:29:09.996304-05	2017-02-23 15:29:09.996357-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	5
10	t	2017-02-23 15:29:10.031338-05	2017-02-23 15:29:10.031403-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	5
11	t	2017-02-23 15:29:10.063962-05	2017-02-23 15:29:10.064018-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	6
12	t	2017-02-23 15:29:10.06564-05	2017-02-23 15:29:10.065688-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	6
13	t	2017-02-23 15:29:10.154312-05	2017-02-23 15:29:10.154367-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	7
14	t	2017-02-23 15:29:10.17075-05	2017-02-23 15:29:10.170813-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	7
15	t	2017-02-23 15:29:10.211594-05	2017-02-23 15:29:10.211628-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	8
16	t	2017-02-23 15:29:10.21307-05	2017-02-23 15:29:10.213111-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	8
17	t	2017-02-23 15:29:10.377553-05	2017-02-23 15:29:10.377604-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	9
18	t	2017-02-23 15:29:10.385058-05	2017-02-23 15:29:10.385114-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	9
19	t	2017-02-23 15:29:10.472771-05	2017-02-23 15:29:10.472826-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	10
20	t	2017-02-23 15:29:10.475306-05	2017-02-23 15:29:10.475352-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	10
21	t	2017-02-23 15:29:10.61552-05	2017-02-23 15:29:10.615551-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	11
22	t	2017-02-23 15:29:10.616582-05	2017-02-23 15:29:10.616613-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	11
23	t	2017-02-23 15:29:10.898258-05	2017-02-23 15:29:10.898298-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	12
24	t	2017-02-23 15:29:10.908197-05	2017-02-23 15:29:10.908241-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	12
25	t	2017-02-23 15:29:10.979583-05	2017-02-23 15:29:10.979627-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	13
26	t	2017-02-23 15:29:10.981332-05	2017-02-23 15:29:10.981376-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	13
27	t	2017-02-23 15:29:11.163089-05	2017-02-23 15:29:11.163142-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	14
28	t	2017-02-23 15:29:11.164892-05	2017-02-23 15:29:11.164943-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	14
29	t	2017-02-23 15:29:11.342559-05	2017-02-23 15:29:11.342596-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	15
30	t	2017-02-23 15:29:11.40451-05	2017-02-23 15:29:11.404573-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	15
31	t	2017-02-23 15:29:11.54204-05	2017-02-23 15:29:11.542075-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	16
32	t	2017-02-23 15:29:11.543112-05	2017-02-23 15:29:11.543141-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	16
33	t	2017-02-23 15:29:11.778777-05	2017-02-23 15:29:11.778819-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	17
34	t	2017-02-23 15:29:11.780012-05	2017-02-23 15:29:11.780046-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	17
35	t	2017-02-23 15:29:11.901186-05	2017-02-23 15:29:11.901235-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	18
36	t	2017-02-23 15:29:11.902722-05	2017-02-23 15:29:11.902763-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	18
37	t	2017-02-23 15:29:12.265058-05	2017-02-23 15:29:12.265099-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	19
38	t	2017-02-23 15:29:12.266783-05	2017-02-23 15:29:12.266818-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	19
39	t	2017-02-23 15:29:12.310132-05	2017-02-23 15:29:12.310169-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	20
40	t	2017-02-23 15:29:12.311115-05	2017-02-23 15:29:12.311134-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	20
41	t	2017-02-23 15:29:12.46892-05	2017-02-23 15:29:12.468963-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	21
42	t	2017-02-23 15:29:12.470377-05	2017-02-23 15:29:12.470414-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	21
43	t	2017-02-23 15:29:12.810759-05	2017-02-23 15:29:12.810804-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	22
44	t	2017-02-23 15:29:12.812284-05	2017-02-23 15:29:12.812323-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	22
45	t	2017-02-23 15:29:12.918765-05	2017-02-23 15:29:12.918813-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	23
46	t	2017-02-23 15:29:12.920302-05	2017-02-23 15:29:12.92035-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	23
47	t	2017-02-23 15:29:13.098196-05	2017-02-23 15:29:13.098238-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	24
48	t	2017-02-23 15:29:13.099645-05	2017-02-23 15:29:13.099694-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	24
49	t	2017-02-23 15:29:13.262143-05	2017-02-23 15:29:13.262188-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	25
50	t	2017-02-23 15:29:13.264664-05	2017-02-23 15:29:13.264708-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	25
51	t	2017-02-23 15:29:13.395728-05	2017-02-23 15:29:13.395769-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	26
52	t	2017-02-23 15:29:13.396756-05	2017-02-23 15:29:13.396788-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	26
53	t	2017-02-23 15:29:13.809055-05	2017-02-23 15:29:13.809102-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	27
54	t	2017-02-23 15:29:13.846822-05	2017-02-23 15:29:13.846876-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	27
55	t	2017-02-23 15:29:14.093843-05	2017-02-23 15:29:14.09388-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	28
56	t	2017-02-23 15:29:14.095674-05	2017-02-23 15:29:14.095698-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	28
57	t	2017-02-23 15:29:14.099071-05	2017-02-23 15:29:14.099117-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	29
58	t	2017-02-23 15:29:14.100474-05	2017-02-23 15:29:14.100506-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	29
59	t	2017-02-23 15:29:14.229599-05	2017-02-23 15:29:14.229647-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	30
60	t	2017-02-23 15:29:14.231012-05	2017-02-23 15:29:14.231055-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	30
61	t	2017-02-23 15:29:14.359971-05	2017-02-23 15:29:14.360015-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	31
62	t	2017-02-23 15:29:14.362483-05	2017-02-23 15:29:14.362537-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	31
63	t	2017-02-23 15:29:14.547103-05	2017-02-23 15:29:14.547147-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	32
64	t	2017-02-23 15:29:14.548356-05	2017-02-23 15:29:14.54839-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	32
65	t	2017-02-23 15:29:14.713128-05	2017-02-23 15:29:14.713171-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	33
66	t	2017-02-23 15:29:14.714444-05	2017-02-23 15:29:14.714477-05	0	0	Opciones Para Asistir Al Curso	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	33
\.


--
-- Name: cursos_beneficios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_beneficios_id_seq', 66, true);


--
-- Data for Name: cursos_contenidos; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_contenidos (id, active, created, modified, created_by, modified_by, nombre, descript, posicion, curso_id) FROM stdin;
1	t	2017-02-23 15:28:57.60029-05	2017-02-23 15:28:57.600342-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	1
2	t	2017-02-23 15:28:57.603073-05	2017-02-23 15:28:57.603122-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	1
3	t	2017-02-23 15:28:57.603922-05	2017-02-23 15:28:57.603949-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	1
4	t	2017-02-23 15:29:06.807826-05	2017-02-23 15:29:06.807862-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	2
5	t	2017-02-23 15:29:06.808909-05	2017-02-23 15:29:06.808941-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	2
6	t	2017-02-23 15:29:06.809589-05	2017-02-23 15:29:06.809618-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	2
7	t	2017-02-23 15:29:08.911601-05	2017-02-23 15:29:08.91165-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	3
8	t	2017-02-23 15:29:08.913111-05	2017-02-23 15:29:08.913156-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	3
9	t	2017-02-23 15:29:08.914594-05	2017-02-23 15:29:08.914642-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	3
10	t	2017-02-23 15:29:09.776492-05	2017-02-23 15:29:09.776552-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	4
11	t	2017-02-23 15:29:09.796268-05	2017-02-23 15:29:09.796313-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	4
12	t	2017-02-23 15:29:09.798031-05	2017-02-23 15:29:09.798072-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	4
13	t	2017-02-23 15:29:09.978267-05	2017-02-23 15:29:09.978326-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	5
14	t	2017-02-23 15:29:09.981602-05	2017-02-23 15:29:09.981654-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	5
15	t	2017-02-23 15:29:09.987618-05	2017-02-23 15:29:09.987662-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	5
19	t	2017-02-23 15:29:10.117398-05	2017-02-23 15:29:10.117448-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	7
20	t	2017-02-23 15:29:10.121822-05	2017-02-23 15:29:10.121878-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	7
21	t	2017-02-23 15:29:10.149281-05	2017-02-23 15:29:10.149357-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	7
22	t	2017-02-23 15:29:10.207546-05	2017-02-23 15:29:10.207591-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	8
23	t	2017-02-23 15:29:10.208877-05	2017-02-23 15:29:10.208914-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	8
24	t	2017-02-23 15:29:10.209697-05	2017-02-23 15:29:10.209719-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	8
25	t	2017-02-23 15:29:10.372528-05	2017-02-23 15:29:10.372576-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	9
26	t	2017-02-23 15:29:10.374078-05	2017-02-23 15:29:10.374132-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	9
27	t	2017-02-23 15:29:10.375041-05	2017-02-23 15:29:10.375079-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	9
28	t	2017-02-23 15:29:10.467534-05	2017-02-23 15:29:10.46776-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	10
29	t	2017-02-23 15:29:10.469218-05	2017-02-23 15:29:10.469259-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	10
30	t	2017-02-23 15:29:10.470277-05	2017-02-23 15:29:10.470317-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	10
31	t	2017-02-23 15:29:10.612017-05	2017-02-23 15:29:10.612055-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	11
32	t	2017-02-23 15:29:10.613134-05	2017-02-23 15:29:10.613168-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	11
33	t	2017-02-23 15:29:10.6139-05	2017-02-23 15:29:10.613931-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	11
34	t	2017-02-23 15:29:10.889333-05	2017-02-23 15:29:10.889394-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	12
35	t	2017-02-23 15:29:10.891192-05	2017-02-23 15:29:10.891238-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	12
36	t	2017-02-23 15:29:10.89448-05	2017-02-23 15:29:10.894555-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	12
37	t	2017-02-23 15:29:10.973828-05	2017-02-23 15:29:10.973884-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	13
38	t	2017-02-23 15:29:10.976173-05	2017-02-23 15:29:10.976215-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	13
39	t	2017-02-23 15:29:10.977155-05	2017-02-23 15:29:10.977193-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	13
40	t	2017-02-23 15:29:11.158613-05	2017-02-23 15:29:11.158666-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	14
41	t	2017-02-23 15:29:11.160391-05	2017-02-23 15:29:11.160437-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	14
42	t	2017-02-23 15:29:11.161237-05	2017-02-23 15:29:11.161264-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	14
43	t	2017-02-23 15:29:11.338534-05	2017-02-23 15:29:11.338591-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	15
44	t	2017-02-23 15:29:11.340048-05	2017-02-23 15:29:11.340086-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	15
45	t	2017-02-23 15:29:11.340798-05	2017-02-23 15:29:11.340826-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	15
46	t	2017-02-23 15:29:11.537795-05	2017-02-23 15:29:11.537839-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	16
47	t	2017-02-23 15:29:11.539355-05	2017-02-23 15:29:11.539405-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	16
48	t	2017-02-23 15:29:11.540355-05	2017-02-23 15:29:11.540383-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	16
49	t	2017-02-23 15:29:11.774792-05	2017-02-23 15:29:11.774833-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	17
50	t	2017-02-23 15:29:11.776007-05	2017-02-23 15:29:11.77604-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	17
51	t	2017-02-23 15:29:11.776786-05	2017-02-23 15:29:11.776819-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	17
52	t	2017-02-23 15:29:11.8963-05	2017-02-23 15:29:11.896342-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	18
53	t	2017-02-23 15:29:11.897653-05	2017-02-23 15:29:11.897692-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	18
54	t	2017-02-23 15:29:11.898649-05	2017-02-23 15:29:11.898698-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	18
55	t	2017-02-23 15:29:12.225526-05	2017-02-23 15:29:12.225567-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	19
56	t	2017-02-23 15:29:12.260317-05	2017-02-23 15:29:12.260374-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	19
57	t	2017-02-23 15:29:12.262585-05	2017-02-23 15:29:12.262636-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	19
58	t	2017-02-23 15:29:12.305924-05	2017-02-23 15:29:12.305988-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	20
59	t	2017-02-23 15:29:12.307477-05	2017-02-23 15:29:12.307526-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	20
60	t	2017-02-23 15:29:12.308199-05	2017-02-23 15:29:12.308228-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	20
61	t	2017-02-23 15:29:12.464837-05	2017-02-23 15:29:12.464881-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	21
62	t	2017-02-23 15:29:12.46636-05	2017-02-23 15:29:12.466399-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	21
63	t	2017-02-23 15:29:12.46711-05	2017-02-23 15:29:12.467136-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	21
64	t	2017-02-23 15:29:12.806896-05	2017-02-23 15:29:12.806937-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	22
65	t	2017-02-23 15:29:12.808217-05	2017-02-23 15:29:12.80825-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	22
66	t	2017-02-23 15:29:12.808819-05	2017-02-23 15:29:12.808845-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	22
67	t	2017-02-23 15:29:12.911158-05	2017-02-23 15:29:12.911205-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	23
68	t	2017-02-23 15:29:12.914924-05	2017-02-23 15:29:12.91498-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	23
69	t	2017-02-23 15:29:12.916281-05	2017-02-23 15:29:12.916339-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	23
70	t	2017-02-23 15:29:13.092628-05	2017-02-23 15:29:13.092683-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	24
71	t	2017-02-23 15:29:13.094487-05	2017-02-23 15:29:13.094534-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	24
72	t	2017-02-23 15:29:13.095971-05	2017-02-23 15:29:13.096018-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	24
73	t	2017-02-23 15:29:13.251825-05	2017-02-23 15:29:13.251874-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	25
74	t	2017-02-23 15:29:13.253584-05	2017-02-23 15:29:13.253634-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	25
75	t	2017-02-23 15:29:13.254578-05	2017-02-23 15:29:13.254628-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	25
76	t	2017-02-23 15:29:13.391377-05	2017-02-23 15:29:13.391423-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	26
77	t	2017-02-23 15:29:13.392739-05	2017-02-23 15:29:13.392779-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	26
78	t	2017-02-23 15:29:13.39374-05	2017-02-23 15:29:13.393821-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	26
79	t	2017-02-23 15:29:13.795795-05	2017-02-23 15:29:13.795849-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	27
80	t	2017-02-23 15:29:13.798398-05	2017-02-23 15:29:13.798452-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	27
81	t	2017-02-23 15:29:13.800478-05	2017-02-23 15:29:13.800499-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	27
82	t	2017-02-23 15:29:14.078267-05	2017-02-23 15:29:14.078328-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	28
83	t	2017-02-23 15:29:14.080478-05	2017-02-23 15:29:14.080535-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	28
84	t	2017-02-23 15:29:14.082307-05	2017-02-23 15:29:14.082353-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	28
88	t	2017-02-23 15:29:14.225011-05	2017-02-23 15:29:14.225057-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	30
89	t	2017-02-23 15:29:14.226569-05	2017-02-23 15:29:14.226616-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	30
90	t	2017-02-23 15:29:14.227503-05	2017-02-23 15:29:14.227546-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	30
91	t	2017-02-23 15:29:14.355549-05	2017-02-23 15:29:14.355588-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	31
92	t	2017-02-23 15:29:14.357308-05	2017-02-23 15:29:14.357349-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	31
93	t	2017-02-23 15:29:14.358065-05	2017-02-23 15:29:14.358093-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	31
94	t	2017-02-23 15:29:14.542057-05	2017-02-23 15:29:14.542105-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	0	32
95	t	2017-02-23 15:29:14.543745-05	2017-02-23 15:29:14.543798-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	1	32
96	t	2017-02-23 15:29:14.545017-05	2017-02-23 15:29:14.545055-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t\t\t\t\t\t\t\t</ol>	2	32
97	t	2017-02-23 15:29:14.708956-05	2017-02-23 19:46:05.745148-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	33
98	t	2017-02-23 15:29:14.710465-05	2017-02-23 19:46:05.747315-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	33
99	t	2017-02-23 15:29:14.711254-05	2017-02-23 19:46:05.749093-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	2	33
16	t	2017-02-23 15:29:10.056476-05	2017-02-23 20:26:33.220487-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	6
17	t	2017-02-23 15:29:10.059978-05	2017-02-23 20:26:33.222053-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	6
18	t	2017-02-23 15:29:10.061472-05	2017-02-23 20:26:33.223563-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	2	6
85	t	2017-02-23 15:29:14.088902-05	2017-02-23 20:26:46.641217-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	0	29
86	t	2017-02-23 15:29:14.090481-05	2017-02-23 20:26:46.642775-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	1	29
87	t	2017-02-23 15:29:14.095153-05	2017-02-23 20:26:46.64401-05	0	0	Introducción a la certificación PSP	<ol>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n\t<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum, tempore.</li>\r\n</ol>\r\n	2	29
\.


--
-- Name: cursos_contenidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_contenidos_id_seq', 99, true);


--
-- Data for Name: cursos_cursos; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursos (id, active, created, modified, created_by, modified_by, slug, posicion, nombre, img, nuevo, online, classroom, webcast, descript, yt_img_usage, video, archivo, fechas, horarios, lugar, inversion, cod, precio, categoria_id, dc_descript, dm_descript, dm_video, dm_video_id, iv_descript, iv_descript_pie, mt_descript, video_id, de_interes, inicio, nombre_complex, dc_titulo, mt_titulo, iv_tabla, dm_titulo) FROM stdin;
3	t	2017-02-23 15:29:08.904123-05	2017-02-23 19:00:51.45289-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-2	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
4	t	2017-02-23 15:29:09.764052-05	2017-02-23 19:00:51.460895-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-3	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	3	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
2	t	2017-02-23 15:29:06.801273-05	2017-02-23 19:00:51.444934-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-1	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
7	t	2017-02-23 15:29:10.085979-05	2017-02-23 19:00:51.526704-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-5	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
8	t	2017-02-23 15:29:10.195265-05	2017-02-23 19:00:51.537668-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-6	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
6	t	2017-02-23 15:29:09.982255-05	2017-02-23 20:26:33.211367-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-4	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	f	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
11	t	2017-02-23 15:29:10.602482-05	2017-02-23 19:00:51.580741-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-9	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
12	t	2017-02-23 15:29:10.869166-05	2017-02-23 19:00:51.592633-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-10	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
10	t	2017-02-23 15:29:10.456313-05	2017-02-23 19:00:51.56722-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-8	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	2	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
15	t	2017-02-23 15:29:11.330736-05	2017-02-23 19:00:51.655808-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-13	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	2	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
16	t	2017-02-23 15:29:11.529413-05	2017-02-23 19:00:51.673535-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-14	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
14	t	2017-02-23 15:29:11.151397-05	2017-02-23 19:00:51.639232-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-12	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	3	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
19	t	2017-02-23 15:29:12.201384-05	2017-02-23 19:00:51.729432-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-17	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	3	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
20	t	2017-02-23 15:29:12.295076-05	2017-02-23 19:00:51.753702-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-18	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	2	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
18	t	2017-02-23 15:29:11.882301-05	2017-02-23 19:00:51.709591-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-16	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
23	t	2017-02-23 15:29:12.897705-05	2017-02-23 19:00:51.838065-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-21	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
24	t	2017-02-23 15:29:13.083468-05	2017-02-23 19:00:51.866265-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-22	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	3	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
22	t	2017-02-23 15:29:12.798267-05	2017-02-23 19:00:51.808399-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-20	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
27	t	2017-02-23 15:29:13.777386-05	2017-02-23 19:00:51.943206-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-25	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
28	t	2017-02-23 15:29:14.063317-05	2017-02-23 19:00:51.981373-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-32	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
26	t	2017-02-23 15:29:13.381933-05	2017-02-23 19:00:51.912112-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-24	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
31	t	2017-02-23 15:29:14.340771-05	2017-02-23 19:00:52.09236-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-28	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
32	t	2017-02-23 15:29:14.526269-05	2017-02-23 19:00:52.12213-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-29	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
30	t	2017-02-23 15:29:14.212226-05	2017-02-23 19:00:52.05995-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-27	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	2	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
1	t	2017-02-23 15:28:57.583635-05	2017-02-23 19:00:51.432861-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
5	t	2017-02-23 15:29:09.934494-05	2017-02-23 19:00:51.508163-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-31	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	2	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
9	t	2017-02-23 15:29:10.358736-05	2017-02-23 19:00:51.553213-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-7	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	3	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
17	t	2017-02-23 15:29:11.764554-05	2017-02-23 19:00:51.692279-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-15	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	5	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
21	t	2017-02-23 15:29:12.455496-05	2017-02-23 19:00:51.783999-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-19	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	1	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
25	t	2017-02-23 15:29:13.239682-05	2017-02-23 19:00:51.889675-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-23	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	2	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
13	t	2017-02-23 15:29:10.963633-05	2017-02-23 19:00:51.614495-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-11	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	t	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
29	t	2017-02-23 15:29:14.069466-05	2017-02-23 20:26:46.632185-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-26	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	f	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	3	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
33	t	2017-02-23 15:29:14.700124-05	2017-02-23 20:43:23.399526-05	0	0	diplomado-en-manejo-de-proyectos-en-rango-z-30	1	Diplomado en Manejo de proyectos en rango z	uploads/cursos/b20-img.jpg	t	t	t	f	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat</p>\r\n	f	https://www.youtube.com/watch?v=dM6ao3HgRew		03 SESIONES	03 SESIONES	MODALIDAD ONLINE, A TRAVÉS DE NUESTRA PLATAFORMA. PRESENCIAL: CALLE 8, NRO 220, SAN BORJA– LIMA-PERÚ	S/. 3,100 (INCLUIDO IMPUESTOS IGV) | USD$ 950 FACILIDADES DE PAGO (SUJETO A COORDINACIÓN)	<functio	69.00	4	<p>Valoramos la EXPERIENCIA PRACTICA EN PROYECTOS, por eso te brindamos docentes no solamente certificados en PSP (Planning Scheduling Professional), si no con amplia experiencia en entornos Multiculturales de Proyectos tipo EPC, EPCM en la industria de Construcci&oacute;n, Minera, O&amp;G, Energ&iacute;a en el Per&uacute; y el Mundo. Docentes que viven d&iacute;a a d&iacute;a la aplicaci&oacute;n de la teor&iacute;a y la pr&aacute;ctica de los conceptos del AACE International en sus trabajos.</p>\r\n	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	https://www.youtube.com/watch?v=dM6ao3HgRew	dM6ao3HgRew	<p>Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc</p>\r\n	<ul>\r\n\t<li>Tarifas en Nuevos soles y D&oacute;lares Americanos. INCLUYE IMPUESTO (IGV).</li>\r\n\t<li>(*) Asociados: Pre-Inscritos en III Congreso International del AACE &ndash; Per&uacute; Section,Ex_Alumnos de PROTRAIN e-Learning y CMS Project Consulting.</li>\r\n\t<li>DESCUENTO CORPORATIVO (m&aacute;s de 2 participantes) en un mismo grupo.</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Clases presenciales y Online con docente en tiempo real.</li>\r\n\t<li>Presentaciones con casos y ejemplos pr&aacute;cticos</li>\r\n</ul>\r\n	dM6ao3HgRew	t	2017-02-23		NUESTRO <STAFF PROFESIONAL>	NUESTRA <METODOLOGIA>	<table border="1" cellpadding="0" cellspacing="0" style="width:580px">\r\n\t<thead>\r\n\t\t<tr>\r\n\t\t\t<th scope="col">Categor&iacute;a</th>\r\n\t\t\t<th scope="col">Inscripcion temprana(Early Bird) Hasta el 15/Jul/16</th>\r\n\t\t\t<th scope="col">Inscripcion Regular(Regular) Desde el 16/Jul/16</th>\r\n\t\t</tr>\r\n\t</thead>\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td>INDIVIDUAL</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>ASOCIADOS</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>\r\n\t\t\t<p>MIENBROS AACEI</p>\r\n\t\t\t</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td>CORPORATIVO</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t\t<td>S/.2600 | USD$ 796</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n	COURSE <DEMO QUIZ>
\.


--
-- Name: cursos_cursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursos_id_seq', 33, true);


--
-- Data for Name: cursos_cursos_idiomas; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursos_idiomas (id, cursos_id, idiomas_id) FROM stdin;
7	33	1
\.


--
-- Name: cursos_cursos_idiomas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursos_idiomas_id_seq', 7, true);


--
-- Data for Name: cursos_cursos_rubro; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursos_rubro (id, cursos_id, rubros_id) FROM stdin;
79	33	21
80	33	23
\.


--
-- Name: cursos_cursos_rubro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursos_rubro_id_seq', 80, true);


--
-- Data for Name: cursos_cursoscategorias; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursoscategorias (id, active, created, modified, created_by, modified_by, slug, nombre, descript, img_s, img_i, posicion) FROM stdin;
5	t	2017-02-22 20:14:48.794943-05	2017-02-23 18:47:33.434562-05	0	0	especialidades	Especialidades	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat nulla,</p>\r\n	uploads/cursecc_sup/b15-img-2.jpg	uploads/cursecc_inf/b15-img-1.jpg	2
4	t	2017-02-22 20:14:43.185019-05	2017-02-23 18:47:55.076595-05	0	0	certificaciones	Certificaciones	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat nulla,</p>\r\n	uploads/cursecc_sup/b15-img-2.jpg	uploads/cursecc_inf/b15-img-1.jpg	3
3	t	2017-02-22 20:14:15.547785-05	2017-02-23 18:48:16.923522-05	0	0	software	Software	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat nulla,</p>\r\n	uploads/cursecc_sup/b15-img-2.jpg	uploads/cursecc_inf/b15-img-1.jpg	4
2	t	2017-02-22 20:14:02.568592-05	2017-02-23 18:48:42.265177-05	0	0	in-house	In House	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat nulla,</p>\r\n	uploads/cursecc_sup/b15-img-2.jpg	uploads/cursecc_inf/b15-img-1.jpg	5
1	t	2017-02-22 20:08:49.089412-05	2017-02-23 19:02:11.353037-05	0	0	diplomado	Diplomado	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue. Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus auctor. Suspendisse aliquam urna sed nunc venenatis, vel accumsan nunc suscipit. Ut at consequat nulla,</p>\r\n	uploads/cursecc_sup/b15-img-2.jpg	uploads/cursecc_inf/b15-img-1.jpg	1
\.


--
-- Name: cursos_cursoscategorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursoscategorias_id_seq', 5, true);


--
-- Data for Name: cursos_cursoscategorias_idiomas; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursoscategorias_idiomas (id, cursoscategorias_id, idiomas_id) FROM stdin;
3	5	2
4	5	3
5	4	1
6	4	3
7	3	1
8	3	2
9	3	3
10	2	1
11	2	2
12	2	3
13	1	1
14	1	2
\.


--
-- Name: cursos_cursoscategorias_idiomas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursoscategorias_idiomas_id_seq', 14, true);


--
-- Name: cursos_cursoscategorias_rubro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursoscategorias_rubro_id_seq', 17, true);


--
-- Data for Name: cursos_cursoscategorias_rubros; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursoscategorias_rubros (id, cursoscategorias_id, rubros_id) FROM stdin;
4	5	24
5	5	25
6	5	26
7	4	24
8	4	26
9	4	22
10	3	25
11	3	21
12	3	23
13	2	26
14	2	21
15	1	21
16	1	22
17	1	23
\.


--
-- Data for Name: cursos_cursosdeinteres; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_cursosdeinteres (id, titulo, detalle) FROM stdin;
1		
\.


--
-- Name: cursos_cursosdeinteres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_cursosdeinteres_id_seq', 1, false);


--
-- Data for Name: cursos_idiomas; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_idiomas (id, active, created, modified, created_by, modified_by, slug, nombre, posicion) FROM stdin;
1	t	2017-02-23 18:07:40.513689-05	2017-02-23 18:07:40.513731-05	0	0	aleman	Aleman	1
2	t	2017-02-23 18:07:48.074954-05	2017-02-23 18:07:48.074994-05	0	0	ingles	Ingles	1
3	t	2017-02-23 18:07:57.762099-05	2017-02-23 18:07:57.762132-05	0	0	espanol	Español	1
\.


--
-- Name: cursos_idiomas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_idiomas_id_seq', 3, true);


--
-- Data for Name: cursos_profesores; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_profesores (id, active, created, modified, created_by, modified_by, slug, img, nombres, apellidos, detalle, cargo, descript, linkedin, posicion, descript_simple) FROM stdin;
1	t	2017-02-23 15:46:14.467856-05	2017-02-23 15:46:14.467927-05	0	0	juan-arturo-allccaco-quispe	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
2	t	2017-02-23 15:46:22.673575-05	2017-02-23 15:46:22.673627-05	0	0	juan-arturo-allccaco-quispe-1	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
3	t	2017-02-23 15:46:25.191992-05	2017-02-23 15:46:25.192039-05	0	0	juan-arturo-allccaco-quispe-2	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
4	t	2017-02-23 15:46:26.866923-05	2017-02-23 15:46:26.866968-05	0	0	juan-arturo-allccaco-quispe-3	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
5	t	2017-02-23 15:46:28.274319-05	2017-02-23 15:46:28.274365-05	0	0	juan-arturo-allccaco-quispe-4	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
6	t	2017-02-23 15:46:29.59254-05	2017-02-23 15:46:29.592592-05	0	0	juan-arturo-allccaco-quispe-5	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
7	t	2017-02-23 15:46:29.793111-05	2017-02-23 15:46:29.793153-05	0	0	juan-arturo-allccaco-quispe-6	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
8	t	2017-02-23 15:46:31.0245-05	2017-02-23 15:46:31.024547-05	0	0	juan-arturo-allccaco-quispe-7	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
9	t	2017-02-23 15:46:52.160574-05	2017-02-23 15:46:52.160624-05	0	0	juan-arturo-allccaco-quispe-8	uploads/teachers/profe.png	Juan Arturo	Allccaco Quispe	CCE	Profesional certificado como CCP	<p>tiene una Maestr&iacute;a en Administraci&oacute;n de Total Cost Management - Asociaci&oacute;n Italiana de Ingenier&iacute;a Econ&oacute;mica &ndash; Mil&aacute;n, licenciatura en Econom&iacute;a y Administraci&oacute;n de Empresas. + 10 a&ntilde;os de experiencia en entornos EPCM como control de proyectos, control de costos, programaci&oacute;n, planificaci&oacute;n, licitaciones. Experiencia internacional en industrias de aeropuertos, l&iacute;neas ferroviarias, autopistas, puentes y Centrales Hidroel&eacute;ctricas en Filipinas, Nigeria, Argelia, Libia, Europa y Am&eacute;rica del Sur y otros.</p>\r\n	https://pe.linkedin.com/	1	tiene una Maestría en Administración de Total Cost Management - Asociación Italiana de Ingeniería Económica – Milán
\.


--
-- Data for Name: cursos_profesores_cursos; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_profesores_cursos (id, profesores_id, cursos_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	2	1
35	2	2
36	2	3
37	2	4
38	2	5
39	2	6
40	2	7
41	2	8
42	2	9
43	2	10
44	2	11
45	2	12
46	2	13
47	2	14
48	2	15
49	2	16
50	2	17
51	2	18
52	2	19
53	2	20
54	2	21
55	2	22
56	2	23
57	2	24
58	2	25
59	2	26
60	2	27
61	2	28
62	2	29
63	2	30
64	2	31
65	2	32
66	2	33
67	3	1
68	3	2
69	3	3
70	3	4
71	3	5
72	3	6
73	3	7
74	3	8
75	3	9
76	3	10
77	3	11
78	3	12
79	3	13
80	3	14
81	3	15
82	3	16
83	3	17
84	3	18
85	3	19
86	3	20
87	3	21
88	3	22
89	3	23
90	3	24
91	3	25
92	3	26
93	3	27
94	3	28
95	3	29
96	3	30
97	3	31
98	3	32
99	3	33
100	4	1
101	4	2
102	4	3
103	4	4
104	4	5
105	4	6
106	4	7
107	4	8
108	4	9
109	4	10
110	4	11
111	4	12
112	4	13
113	4	14
114	4	15
115	4	16
116	4	17
117	4	18
118	4	19
119	4	20
120	4	21
121	4	22
122	4	23
123	4	24
124	4	25
125	4	26
126	4	27
127	4	28
128	4	29
129	4	30
130	4	31
131	4	32
132	4	33
133	5	1
134	5	2
135	5	3
136	5	4
137	5	5
138	5	6
139	5	7
140	5	8
141	5	9
142	5	10
143	5	11
144	5	12
145	5	13
146	5	14
147	5	15
148	5	16
149	5	17
150	5	18
151	5	19
152	5	20
153	5	21
154	5	22
155	5	23
156	5	24
157	5	25
158	5	26
159	5	27
160	5	28
161	5	29
162	5	30
163	5	31
164	5	32
165	5	33
166	6	1
167	6	2
168	6	3
169	6	4
170	6	5
171	6	6
172	6	7
173	6	8
174	6	9
175	6	10
176	6	11
177	6	12
178	6	13
179	6	14
180	6	15
181	6	16
182	6	17
183	6	18
184	6	19
185	6	20
186	6	21
187	6	22
188	6	23
189	6	24
190	6	25
191	6	26
192	6	27
193	6	28
194	6	29
195	6	30
196	6	31
197	6	32
198	6	33
199	7	1
200	7	2
201	7	3
202	7	4
203	7	5
204	7	6
205	7	7
206	7	8
207	7	9
208	7	10
209	7	11
210	7	12
211	7	13
212	7	14
213	7	15
214	7	16
215	7	17
216	7	18
217	7	19
218	7	20
219	7	21
220	7	22
221	7	23
222	7	24
223	7	25
224	7	26
225	7	27
226	7	28
227	7	29
228	7	30
229	7	31
230	7	32
231	7	33
232	8	1
233	8	2
234	8	3
235	8	4
236	8	5
237	8	6
238	8	7
239	8	8
240	8	9
241	8	10
242	8	11
243	8	12
244	8	13
245	8	14
246	8	15
247	8	16
248	8	17
249	8	18
250	8	19
251	8	20
252	8	21
253	8	22
254	8	23
255	8	24
256	8	25
257	8	26
258	8	27
259	8	28
260	8	29
261	8	30
262	8	31
263	8	32
264	8	33
265	9	1
266	9	2
267	9	3
268	9	4
269	9	5
270	9	6
271	9	7
272	9	8
273	9	9
274	9	10
275	9	11
276	9	12
277	9	13
278	9	14
279	9	15
280	9	16
281	9	17
282	9	18
283	9	19
284	9	20
285	9	21
286	9	22
287	9	23
288	9	24
289	9	25
290	9	26
291	9	27
292	9	28
293	9	29
294	9	30
295	9	31
296	9	32
297	9	33
\.


--
-- Name: cursos_profesores_cursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_profesores_cursos_id_seq', 297, true);


--
-- Name: cursos_profesores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_profesores_id_seq', 9, true);


--
-- Data for Name: cursos_rubros; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY cursos_rubros (id, active, created, modified, created_by, modified_by, slug, posicion, nombre) FROM stdin;
21	t	2017-02-23 17:59:29.048521-05	2017-02-23 18:00:15.753164-05	0	0	mineria	1	Minería
22	t	2017-02-23 18:00:51.843244-05	2017-02-23 18:00:51.843289-05	0	0	administracion	1	Administración
23	t	2017-02-23 18:01:14.845859-05	2017-02-23 18:01:14.845921-05	0	0	gestion	3	Gestión
24	t	2017-02-23 18:01:47.965133-05	2017-02-23 18:01:47.965184-05	0	0	produccion	4	Producción
25	t	2017-02-23 18:02:47.095052-05	2017-02-23 18:02:47.095101-05	0	0	maquinaria	5	Maquinaria
26	t	2017-02-23 18:03:14.476487-05	2017-02-23 18:03:14.476532-05	0	0	desarrollo	6	Desarrollo
\.


--
-- Name: cursos_rubros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('cursos_rubros_id_seq', 26, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2017-02-16 18:49:27.364979-05	1	Destinatarios	1		32	1
2	2017-02-16 18:55:01.829728-05	1	Destinatarios	2	Modificado/a form_contacto.	32	1
3	2017-02-16 19:10:30.64888-05	1	Destinatarios	2	Modificado/a form_contacto.	32	1
4	2017-02-16 19:25:01.628613-05	1	Destinatarios	2	Modificado/a form_contacto.	32	1
5	2017-02-22 16:21:48.903847-05	1	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
6	2017-02-22 16:21:53.240213-05	2	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
7	2017-02-22 16:21:54.792962-05	3	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
8	2017-02-22 16:21:55.756305-05	4	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
9	2017-02-22 16:21:55.882334-05	5	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
10	2017-02-22 16:21:55.932332-05	6	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
11	2017-02-22 16:21:55.954045-05	7	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
12	2017-02-22 16:21:56.106422-05	8	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
13	2017-02-22 16:21:56.280899-05	9	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
14	2017-02-22 16:21:56.474076-05	10	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
15	2017-02-22 16:21:56.828851-05	11	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
16	2017-02-22 16:21:57.536448-05	12	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
17	2017-02-22 16:21:57.735641-05	13	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
18	2017-02-22 16:21:57.741906-05	14	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
19	2017-02-22 16:21:57.761556-05	15	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
20	2017-02-22 16:21:57.826877-05	16	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
21	2017-02-22 16:21:57.902099-05	17	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
22	2017-02-22 16:21:58.034884-05	18	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
23	2017-02-22 16:21:58.198126-05	19	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
24	2017-02-22 16:22:05.477241-05	20	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
25	2017-02-22 16:22:07.395909-05	21	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
26	2017-02-22 16:22:08.863814-05	22	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
27	2017-02-22 16:22:10.58681-05	23	Evento EPCM  conferencia internacional de cursos multidioma	1		19	1
28	2017-02-22 16:50:23.11334-05	24	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		19	1
29	2017-02-22 16:50:35.473025-05	1	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
30	2017-02-22 16:50:40.724866-05	2	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
31	2017-02-22 16:50:43.847859-05	3	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
32	2017-02-22 16:50:44.785972-05	4	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
33	2017-02-22 16:50:45.717346-05	5	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
34	2017-02-22 16:50:47.052736-05	6	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
35	2017-02-22 16:50:47.513608-05	7	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
36	2017-02-22 16:50:48.974599-05	8	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
37	2017-02-22 16:50:50.021453-05	9	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
38	2017-02-22 16:50:50.997006-05	10	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
39	2017-02-22 16:50:51.938737-05	11	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
40	2017-02-22 16:50:53.280655-05	12	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
41	2017-02-22 16:50:54.215135-05	13	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
42	2017-02-22 16:50:55.591714-05	14	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
43	2017-02-22 16:50:55.90857-05	15	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
44	2017-02-22 16:50:57.447281-05	16	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
45	2017-02-22 16:50:58.549417-05	17	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
46	2017-02-22 16:50:59.641396-05	18	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
47	2017-02-22 16:51:00.311441-05	19	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
48	2017-02-22 16:51:01.738639-05	20	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
49	2017-02-22 16:51:02.720795-05	21	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
50	2017-02-22 16:51:03.925236-05	22	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
51	2017-02-22 16:51:05.374316-05	23	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
52	2017-02-22 16:51:05.802429-05	24	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
53	2017-02-22 16:51:07.526823-05	25	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
54	2017-02-22 16:51:08.653639-05	26	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
55	2017-02-22 16:51:09.627404-05	27	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
56	2017-02-22 16:51:10.636304-05	28	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
57	2017-02-22 16:51:10.778143-05	29	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
58	2017-02-22 16:51:11.784154-05	30	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
59	2017-02-22 16:51:13.109014-05	31	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
60	2017-02-22 16:51:13.379855-05	32	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
61	2017-02-22 16:51:13.886117-05	33	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
62	2017-02-22 16:51:15.177928-05	34	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
63	2017-02-22 16:51:15.315031-05	35	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
64	2017-02-22 16:51:15.553241-05	36	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
65	2017-02-22 16:51:16.672413-05	37	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
66	2017-02-22 16:51:16.874204-05	38	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
67	2017-02-22 16:51:17.052281-05	39	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
68	2017-02-22 16:51:19.961442-05	40	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	1		21	1
69	2017-02-22 18:50:46.000795-05	1	Banner - 1	1		10	1
70	2017-02-22 18:50:50.447876-05	2	Banner - 1	1		10	1
71	2017-02-22 18:50:52.865751-05	3	Banner - 1	1		10	1
72	2017-02-22 19:03:10.08634-05	2	Banner - 2	2	Modificado/a posicion y fondo.	10	1
73	2017-02-22 19:03:17.366673-05	3	Banner - 3	2	Modificado/a posicion y fondo.	10	1
74	2017-02-22 19:06:04.34-05	1	MIXED MODE	1		11	1
75	2017-02-22 19:06:08.188014-05	2	MIXED MODE	1		11	1
76	2017-02-22 19:06:10.486995-05	3	MIXED MODE	1		11	1
77	2017-02-22 19:06:12.893256-05	4	MIXED MODE	1		11	1
78	2017-02-22 19:06:15.311579-05	5	MIXED MODE	1		11	1
79	2017-02-22 19:06:18.135188-05	6	MIXED MODE	1		11	1
80	2017-02-22 19:17:49.400611-05	1	Conócenos Sección	2	Modificado/a cabecera, img, qs, pa, ms, vs, bg_titulo, bg_img, bg_vid, cf_descript, cf_img, cf_vid, ns_titulo, ns_descript, nr_titulo y nr_descript.	12	1
81	2017-02-22 19:23:31.743871-05	1	Cliente: CMS	1		13	1
82	2017-02-22 19:23:35.007716-05	2	Cliente: CMS	1		13	1
83	2017-02-22 19:23:37.689276-05	3	Cliente: CMS	1		13	1
84	2017-02-22 19:23:40.563145-05	4	Cliente: CMS	1		13	1
85	2017-02-22 19:23:43.054161-05	5	Cliente: CMS	1		13	1
86	2017-02-22 19:23:47.111328-05	6	Cliente: CMS	1		13	1
87	2017-02-22 19:26:11.61331-05	1	Cliente: GlobPartners	1		15	1
88	2017-02-22 19:26:14.370741-05	2	Cliente: GlobPartners	1		15	1
89	2017-02-22 19:26:17.5442-05	3	Cliente: GlobPartners	1		15	1
90	2017-02-22 19:26:20.608557-05	4	Cliente: GlobPartners	1		15	1
91	2017-02-22 19:26:23.041055-05	5	Cliente: GlobPartners	1		15	1
92	2017-02-22 19:26:25.661516-05	6	Cliente: GlobPartners	1		15	1
93	2017-02-22 19:41:14.189483-05	38	Chile	2	Modificado/a active y img.	16	1
94	2017-02-22 19:42:11.421326-05	41	Colombia	2	Modificado/a active y img.	16	1
95	2017-02-22 19:43:58.199559-05	119	México	2	Modificado/a active y img.	16	1
96	2017-02-22 19:52:50.27235-05	142	Perú	2	Modificado/a active y img.	16	1
97	2017-02-22 20:08:49.10824-05	1	Diplomado	1		26	1
98	2017-02-22 20:14:02.579512-05	2	In House	1		26	1
99	2017-02-22 20:14:15.563776-05	3	Software	1		26	1
100	2017-02-22 20:14:43.194959-05	4	Certificaciones	1		26	1
101	2017-02-22 20:14:48.807494-05	5	Especialidades	1		26	1
102	2017-02-23 11:30:51.148691-05	1	admin	2	No ha cambiado ningún campo.	3	1
103	2017-02-23 11:30:59.85212-05	1	admin	2	Modificado/a is_superuser.	3	1
104	2017-02-23 11:39:38.564507-05	1	admin	2	No ha cambiado ningún campo.	3	2
105	2017-02-23 12:01:16.122609-05	1	admin	2	Modificado/a is_superuser.	3	2
106	2017-02-23 15:28:57.612197-05	1	Diplomado en Manejo de proyectos en rango z	1		28	1
107	2017-02-23 15:29:06.814115-05	2	Diplomado en Manejo de proyectos en rango z	1		28	1
108	2017-02-23 15:29:08.919987-05	3	Diplomado en Manejo de proyectos en rango z	1		28	1
109	2017-02-23 15:29:09.824306-05	4	Diplomado en Manejo de proyectos en rango z	1		28	1
110	2017-02-23 15:29:10.034708-05	5	Diplomado en Manejo de proyectos en rango z	1		28	1
111	2017-02-23 15:29:10.067129-05	6	Diplomado en Manejo de proyectos en rango z	1		28	1
112	2017-02-23 15:29:10.174237-05	7	Diplomado en Manejo de proyectos en rango z	1		28	1
113	2017-02-23 15:29:10.214345-05	8	Diplomado en Manejo de proyectos en rango z	1		28	1
114	2017-02-23 15:29:10.38784-05	9	Diplomado en Manejo de proyectos en rango z	1		28	1
115	2017-02-23 15:29:10.480017-05	10	Diplomado en Manejo de proyectos en rango z	1		28	1
116	2017-02-23 15:29:10.617504-05	11	Diplomado en Manejo de proyectos en rango z	1		28	1
117	2017-02-23 15:29:10.910363-05	12	Diplomado en Manejo de proyectos en rango z	1		28	1
118	2017-02-23 15:29:10.982522-05	13	Diplomado en Manejo de proyectos en rango z	1		28	1
119	2017-02-23 15:29:11.166146-05	14	Diplomado en Manejo de proyectos en rango z	1		28	1
120	2017-02-23 15:29:11.406194-05	15	Diplomado en Manejo de proyectos en rango z	1		28	1
121	2017-02-23 15:29:11.543786-05	16	Diplomado en Manejo de proyectos en rango z	1		28	1
122	2017-02-23 15:29:11.780746-05	17	Diplomado en Manejo de proyectos en rango z	1		28	1
123	2017-02-23 15:29:11.903658-05	18	Diplomado en Manejo de proyectos en rango z	1		28	1
124	2017-02-23 15:29:12.26818-05	19	Diplomado en Manejo de proyectos en rango z	1		28	1
125	2017-02-23 15:29:12.31165-05	20	Diplomado en Manejo de proyectos en rango z	1		28	1
126	2017-02-23 15:29:12.471204-05	21	Diplomado en Manejo de proyectos en rango z	1		28	1
127	2017-02-23 15:29:12.814032-05	22	Diplomado en Manejo de proyectos en rango z	1		28	1
128	2017-02-23 15:29:12.921569-05	23	Diplomado en Manejo de proyectos en rango z	1		28	1
129	2017-02-23 15:29:13.100925-05	24	Diplomado en Manejo de proyectos en rango z	1		28	1
130	2017-02-23 15:29:13.265892-05	25	Diplomado en Manejo de proyectos en rango z	1		28	1
131	2017-02-23 15:29:13.397484-05	26	Diplomado en Manejo de proyectos en rango z	1		28	1
132	2017-02-23 15:29:13.855988-05	27	Diplomado en Manejo de proyectos en rango z	1		28	1
133	2017-02-23 15:29:14.096707-05	28	Diplomado en Manejo de proyectos en rango z	1		28	1
134	2017-02-23 15:29:14.101139-05	29	Diplomado en Manejo de proyectos en rango z	1		28	1
135	2017-02-23 15:29:14.232746-05	30	Diplomado en Manejo de proyectos en rango z	1		28	1
136	2017-02-23 15:29:14.364058-05	31	Diplomado en Manejo de proyectos en rango z	1		28	1
137	2017-02-23 15:29:14.54937-05	32	Diplomado en Manejo de proyectos en rango z	1		28	1
138	2017-02-23 15:29:14.715218-05	33	Diplomado en Manejo de proyectos en rango z	1		28	1
139	2017-02-23 15:46:14.489832-05	1	Juan Arturo, Allccaco Quispe	1		31	1
140	2017-02-23 15:46:22.686309-05	2	Juan Arturo, Allccaco Quispe	1		31	1
141	2017-02-23 15:46:25.211568-05	3	Juan Arturo, Allccaco Quispe	1		31	1
142	2017-02-23 15:46:26.878468-05	4	Juan Arturo, Allccaco Quispe	1		31	1
143	2017-02-23 15:46:28.286922-05	5	Juan Arturo, Allccaco Quispe	1		31	1
144	2017-02-23 15:46:29.603584-05	6	Juan Arturo, Allccaco Quispe	1		31	1
145	2017-02-23 15:46:29.80291-05	7	Juan Arturo, Allccaco Quispe	1		31	1
146	2017-02-23 15:46:31.034445-05	8	Juan Arturo, Allccaco Quispe	1		31	1
147	2017-02-23 15:46:52.170407-05	9	Juan Arturo, Allccaco Quispe	1		31	1
148	2017-02-23 16:32:04.01874-05	1	Elvira Mora	1		44	2
149	2017-02-23 16:32:06.353797-05	2	Elvira Mora	1		44	2
150	2017-02-23 16:32:08.319963-05	3	Elvira Mora	1		44	2
151	2017-02-23 16:32:10.915637-05	4	Elvira Mora	1		44	2
152	2017-02-23 16:32:13.760293-05	5	Elvira Mora	1		44	2
153	2017-02-23 16:32:16.638522-05	6	Elvira Mora	1		44	2
154	2017-02-23 17:03:10.302143-05	1	Eventos Sección	2	Modificado/a cabecera, b_titulo y b_descript.	18	2
155	2017-02-23 17:03:33.115395-05	1	Noticias Sección	2	Modificado/a cabecera, b_titulo y b_descript.	20	2
156	2017-02-23 17:51:54.492988-05	17	R1 C2	3		27	2
157	2017-02-23 17:51:54.500168-05	13	R1 C3	3		27	2
158	2017-02-23 17:51:54.502436-05	9	R1 C4	3		27	2
159	2017-02-23 17:51:54.504575-05	5	R1 C5	3		27	2
160	2017-02-23 17:51:54.506939-05	1	R1 C1	3		27	2
161	2017-02-23 17:51:54.508797-05	18	R2 C2	3		27	2
162	2017-02-23 17:51:54.510619-05	14	R2 C3	3		27	2
163	2017-02-23 17:51:54.512241-05	10	R2 C4	3		27	2
164	2017-02-23 17:51:54.514336-05	6	R2 C5	3		27	2
165	2017-02-23 17:51:54.523804-05	2	R2 C1	3		27	2
166	2017-02-23 17:51:54.52526-05	19	R3 C2	3		27	2
167	2017-02-23 17:51:54.526141-05	15	R3 C3	3		27	2
168	2017-02-23 17:51:54.527081-05	11	R3 C4	3		27	2
169	2017-02-23 17:51:54.528541-05	7	R3 C5	3		27	2
170	2017-02-23 17:51:54.529653-05	3	R3 C1	3		27	2
171	2017-02-23 17:51:54.530783-05	20	R4 C2	3		27	2
172	2017-02-23 17:51:54.53193-05	16	R4 C3	3		27	2
173	2017-02-23 17:51:54.533067-05	12	R4 C4	3		27	2
174	2017-02-23 17:51:54.534797-05	8	R4 C5	3		27	2
175	2017-02-23 17:51:54.536645-05	4	R4 C1	3		27	2
176	2017-02-23 17:59:29.059237-05	21	Minería	1		27	2
177	2017-02-23 18:00:15.759623-05	21	Minería	2	No ha cambiado ningún campo.	27	2
178	2017-02-23 18:00:51.850747-05	22	Administración	1		27	2
179	2017-02-23 18:01:14.854025-05	23	Gestión	1		27	2
180	2017-02-23 18:01:47.976919-05	24	Producción	1		27	2
181	2017-02-23 18:02:47.101161-05	25	Maquinaria	1		27	2
182	2017-02-23 18:03:14.48473-05	26	Desarrollo	1		27	2
183	2017-02-23 18:07:40.515958-05	1	Aleman	1		48	2
184	2017-02-23 18:07:48.076148-05	2	Ingles	1		48	2
185	2017-02-23 18:07:57.762917-05	3	Español	1		48	2
186	2017-02-23 18:47:04.105458-05	1	Diplomado	2	Modificado/a img_s, img_i, rubros y idiomas.	26	2
187	2017-02-23 18:47:33.442434-05	5	Especialidades	2	Modificado/a img_s, img_i, rubros y idiomas.	26	2
188	2017-02-23 18:47:55.085794-05	4	Certificaciones	2	Modificado/a img_s, img_i, rubros y idiomas.	26	2
189	2017-02-23 18:48:16.936498-05	3	Software	2	Modificado/a img_s, img_i, rubros y idiomas.	26	2
190	2017-02-23 18:48:42.273935-05	2	In House	2	Modificado/a img_s, img_i, rubros y idiomas.	26	2
191	2017-02-23 19:02:11.366007-05	1	Diplomado	2	Modificado/a img_s, img_i y rubros.	26	2
192	2017-02-23 19:46:05.754562-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a rubro, idiomas, img y dm_video_id. Modificados descript para "Introducción a la certificación PSP" contenido. Modificados descript para "Introducción a la certificación PSP" contenido. Modificados descript para "Introducción a la certificación PSP" contenido.	28	2
193	2017-02-23 19:48:46.279317-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a img.	28	2
194	2017-02-23 19:49:32.664417-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a categoria y img.	28	2
195	2017-02-23 20:26:33.23027-05	6	Diplomado en Manejo de proyectos en rango z	2	Modificado/a img y webcast. Modificados descript para "Introducción a la certificación PSP" contenido. Modificados descript para "Introducción a la certificación PSP" contenido. Modificados descript para "Introducción a la certificación PSP" contenido.	28	2
196	2017-02-23 20:26:46.648702-05	29	Diplomado en Manejo de proyectos en rango z	2	Modificado/a img y webcast. Modificados descript para "Introducción a la certificación PSP" contenido. Modificados descript para "Introducción a la certificación PSP" contenido. Modificados descript para "Introducción a la certificación PSP" contenido.	28	2
197	2017-02-23 20:27:17.275295-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a categoria, img y webcast.	28	2
198	2017-02-23 20:27:42.870052-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a img, online y classroom.	28	2
199	2017-02-23 20:43:08.457302-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a img y online.	28	2
200	2017-02-23 20:43:23.415225-05	33	Diplomado en Manejo de proyectos en rango z	2	Modificado/a img y classroom.	28	2
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 200, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	login attempt	admin_honeypot	loginattempt
9	info site	web	infosite
10	item	web	sliders
11	item	web	porqueelegirnos
12	Conócenos	web	conocenos
13	cliente	web	clientes
15	cliente	web	respaldos
16	país	web	paises
17	Palabra	web	translaterdicc
18	Eventos Sección	eventos_noticias	homeeventosseccion
19	Evento	eventos_noticias	eventossociales
20	Noticias Sección	eventos_noticias	homenoticiasseccion
21	Noticia	eventos_noticias	noticias
22	Terminos Sección	terminos_preguntas	termsseccion
23	termino	terminos_preguntas	terms
24	Preguntas Sección	terminos_preguntas	questseccion
25	Pregunta frecuente	terminos_preguntas	quest
26	categoría	cursos	cursoscategorias
27	rubro	cursos	rubros
28	curso	cursos	cursos
30	contenido	cursos	contenidos
31	Profesor	cursos	profesores
32	Destinatarios	formularios	destinatarios
33	Contacto	formularios	contacto
34	Contacto Socio	formularios	socioscontacto
35	Contacto	formularios	contactotrabajo
36	suscriptor	formularios	suscript
37	Configuración General	seo	infoseo
38	url	seo	urlregister
39	Título y descripción	seo	seotags
40	redirección	seo	seoredirects
41	Beneficio	cursos	beneficios
43	Cusos de Interés	cursos	cursosdeinteres
44	persona	web	ellosopinan
45	Contacto Sección	web	contactoseccion
46	Lib. de Reclamaciones Sección	web	libroseccion
48	idioma	cursos	idiomas
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('django_content_type_id_seq', 48, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-02-16 11:56:14.739906-05
2	auth	0001_initial	2017-02-16 11:56:14.826054-05
3	admin	0001_initial	2017-02-16 11:56:14.870997-05
4	admin_honeypot	0001_initial	2017-02-16 11:56:14.884241-05
5	cursos	0001_initial	2017-02-16 11:56:15.112514-05
6	eventos_noticias	0001_initial	2017-02-16 11:56:15.16801-05
7	formularios	0001_initial	2017-02-16 11:56:15.22979-05
8	seo	0001_initial	2017-02-16 11:56:15.283571-05
9	sessions	0001_initial	2017-02-16 11:56:15.298817-05
10	sites	0001_initial	2017-02-16 11:56:15.30931-05
11	terminos_preguntas	0001_initial	2017-02-16 11:56:15.364477-05
12	web	0001_initial	2017-02-16 11:56:15.574052-05
13	cursos	0002_auto_20170216_1849	2017-02-16 18:49:10.560618-05
14	cursos	0003_auto_20170216_1959	2017-02-16 19:59:30.987361-05
15	web	0002_infosite_whatsapp	2017-02-21 10:11:53.862448-05
16	web	0003_auto_20170221_1023	2017-02-21 10:23:49.730535-05
17	cursos	0004_auto_20170221_1046	2017-02-21 10:47:00.793051-05
18	web	0004_auto_20170221_1125	2017-02-21 11:25:24.00879-05
19	eventos_noticias	0002_noticias_nombre_x	2017-02-21 11:48:46.214833-05
20	cursos	0005_profesores_descript_simple	2017-02-21 15:26:46.798074-05
21	web	0005_auto_20170221_1526	2017-02-21 15:26:46.97122-05
22	web	0006_contactoseccion	2017-02-21 15:43:45.234922-05
23	cursos	0006_cursos_nombre_complex	2017-02-21 16:52:01.82364-05
24	cursos	0007_auto_20170221_1824	2017-02-21 18:24:53.393822-05
25	cursos	0008_auto_20170221_1833	2017-02-21 18:33:49.114781-05
26	cursos	0009_auto_20170221_1930	2017-02-21 19:30:34.835359-05
27	seo	0002_auto_20170222_1821	2017-02-22 18:21:05.948183-05
28	web	0007_libroseccion	2017-02-22 18:21:06.159485-05
29	web	0008_auto_20170222_1922	2017-02-22 19:22:37.25022-05
30	web	0009_auto_20170222_2038	2017-02-22 20:38:22.152095-05
31	cursos	0010_auto_20170223_1742	2017-02-23 17:45:18.356874-05
32	cursos	0011_remove_cursos_rubro	2017-02-23 17:45:18.369565-05
33	web	0010_auto_20170223_1742	2017-02-23 17:45:18.37421-05
34	cursos	0012_remove_rubros_relacion	2017-02-23 17:46:47.581863-05
35	cursos	0013_rubros_relacion	2017-02-23 17:47:04.289816-05
36	cursos	0014_cursos_rubro	2017-02-23 17:47:17.792552-05
37	cursos	0015_auto_20170223_1753	2017-02-23 17:53:27.94159-05
38	cursos	0016_auto_20170223_1753	2017-02-23 17:53:47.252628-05
39	cursos	0017_auto_20170223_1822	2017-02-23 18:22:46.162498-05
40	cursos	0018_auto_20170223_1839	2017-02-23 18:39:16.099394-05
41	cursos	0019_auto_20170223_1845	2017-02-23 18:45:11.693087-05
42	cursos	0020_auto_20170223_1948	2017-02-23 19:48:16.450874-05
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('django_migrations_id_seq', 42, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
nq3ybf13jnk5mvbzunexmw16jez7tfc9	YzcwZDZmMGM5Y2YxNmVmNjhhMmU1YzYwZmIzMTFhMDg4YjZjOTgyODp7Il9hdXRoX3VzZXJfaGFzaCI6IjM1N2RjZjZlZGU5ZmQzNWE2MzM0NzhlN2FlNWNkYzY2Y2E0NzE4YWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2017-03-02 15:01:06.393745-05
zuyfiuk0p9ntt5d7b87bgtwjv7d983qn	YzcwZDZmMGM5Y2YxNmVmNjhhMmU1YzYwZmIzMTFhMDg4YjZjOTgyODp7Il9hdXRoX3VzZXJfaGFzaCI6IjM1N2RjZjZlZGU5ZmQzNWE2MzM0NzhlN2FlNWNkYzY2Y2E0NzE4YWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2017-03-02 18:48:41.215207-05
5uilp2bquvmvi4cu1qgelqch86u51o3d	YzcwZDZmMGM5Y2YxNmVmNjhhMmU1YzYwZmIzMTFhMDg4YjZjOTgyODp7Il9hdXRoX3VzZXJfaGFzaCI6IjM1N2RjZjZlZGU5ZmQzNWE2MzM0NzhlN2FlNWNkYzY2Y2E0NzE4YWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2017-03-08 15:31:01.400905-05
9bpxq9qsqor2af0y73ftdmheromrh6ul	OTRjMmIxZTJhM2FhODMxOTBkMGJhNzIyZWZlM2I5NDdjZWEwYTJiZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjU0YWJhMmE2OGI5YTQ3NDRlM2RmNDY4NzEwNDNjZTRmMzU1NzI1Y2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-03-09 11:37:43.815791-05
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY django_site (id, domain, name) FROM stdin;
1	127.0.0.1:8000	EPCM
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: eventos_noticias_eventossociales; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY eventos_noticias_eventossociales (id, active, created, modified, created_by, modified_by, slug, nombre, fecha, img, descript) FROM stdin;
1	t	2017-02-22 16:21:48.901206-05	2017-02-22 16:21:48.90127-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
2	t	2017-02-22 16:21:53.238379-05	2017-02-22 16:21:53.23842-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-1	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
3	t	2017-02-22 16:21:54.791215-05	2017-02-22 16:21:54.791276-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-2	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
4	t	2017-02-22 16:21:55.755141-05	2017-02-22 16:21:55.755183-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-3	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
5	t	2017-02-22 16:21:55.872223-05	2017-02-22 16:21:55.872271-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-4	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
6	t	2017-02-22 16:21:55.929334-05	2017-02-22 16:21:55.929399-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-5	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
7	t	2017-02-22 16:21:55.951333-05	2017-02-22 16:21:55.951386-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-6	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
8	t	2017-02-22 16:21:56.105256-05	2017-02-22 16:21:56.105295-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-7	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
9	t	2017-02-22 16:21:56.279145-05	2017-02-22 16:21:56.279193-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-8	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
10	t	2017-02-22 16:21:56.472855-05	2017-02-22 16:21:56.472893-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-9	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
11	t	2017-02-22 16:21:56.827248-05	2017-02-22 16:21:56.827291-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-10	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
12	t	2017-02-22 16:21:57.534898-05	2017-02-22 16:21:57.534941-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-11	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
13	t	2017-02-22 16:21:57.732972-05	2017-02-22 16:21:57.733015-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-12	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
14	t	2017-02-22 16:21:57.736934-05	2017-02-22 16:21:57.736971-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-12	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
15	t	2017-02-22 16:21:57.758639-05	2017-02-22 16:21:57.758687-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-13	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
16	t	2017-02-22 16:21:57.82501-05	2017-02-22 16:21:57.825064-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-14	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
17	t	2017-02-22 16:21:57.900538-05	2017-02-22 16:21:57.900601-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-15	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
18	t	2017-02-22 16:21:58.033131-05	2017-02-22 16:21:58.033203-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-16	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
19	t	2017-02-22 16:21:58.19656-05	2017-02-22 16:21:58.196597-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-17	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
20	t	2017-02-22 16:22:05.476131-05	2017-02-22 16:22:05.476167-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-18	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
21	t	2017-02-22 16:22:07.394332-05	2017-02-22 16:22:07.394387-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-19	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
22	t	2017-02-22 16:22:08.862224-05	2017-02-22 16:22:08.862273-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-20	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
23	t	2017-02-22 16:22:10.585891-05	2017-02-22 16:22:10.585926-05	0	0	evento-epcm-conferencia-internacional-de-cursos-multidioma-21	Evento EPCM  conferencia internacional de cursos multidioma	2017-02-22	uploads/eventos_imgs/b31-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
24	t	2017-02-22 16:50:23.108516-05	2017-02-22 16:50:23.108565-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	2017-02-22	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>
\.


--
-- Name: eventos_noticias_eventossociales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('eventos_noticias_eventossociales_id_seq', 24, true);


--
-- Data for Name: eventos_noticias_homeeventosseccion; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY eventos_noticias_homeeventosseccion (id, cabecera, b_titulo, b_descript) FROM stdin;
1	Eventos	Nuestros Eventos	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quae explicabo odit inventore placeat, laboriosam qui expedita quibusdam, voluptas quia numquam provident nam rem quam hic eum repudiandae quisquam quod totam autem consequatur officiis possimus quasi iusto aut. Dignissimos eos recusandae veniam eius, cupiditate consectetur suscipit explicabo, tenetur, tempore quod ea.</p>\r\n
\.


--
-- Name: eventos_noticias_homeeventosseccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('eventos_noticias_homeeventosseccion_id_seq', 1, false);


--
-- Data for Name: eventos_noticias_homenoticiasseccion; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY eventos_noticias_homenoticiasseccion (id, cabecera, b_titulo, b_descript) FROM stdin;
1	Noticias	Nuestras Noticias	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quae explicabo odit inventore placeat, laboriosam qui expedita quibusdam, voluptas quia numquam provident nam rem quam hic eum repudiandae quisquam quod totam autem consequatur officiis possimus quasi iusto aut. Dignissimos eos recusandae veniam eius, cupiditate consectetur suscipit explicabo, tenetur, tempore quod ea.</p>\r\n
\.


--
-- Name: eventos_noticias_homenoticiasseccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('eventos_noticias_homenoticiasseccion_id_seq', 1, false);


--
-- Data for Name: eventos_noticias_noticias; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY eventos_noticias_noticias (id, active, created, modified, created_by, modified_by, slug, fecha, nombre, img, descript, nombre_x) FROM stdin;
2	t	2017-02-22 16:50:40.723706-05	2017-02-22 17:54:26.548997-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-1	2017-02-21	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
4	t	2017-02-22 16:50:44.784598-05	2017-02-22 17:54:26.559103-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-3	2017-02-19	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
3	t	2017-02-22 16:50:43.846314-05	2017-02-22 17:54:26.553598-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2	2017-02-20	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
8	t	2017-02-22 16:50:48.973214-05	2017-02-22 17:54:26.586704-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-7	2017-02-15	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
6	t	2017-02-22 16:50:47.051265-05	2017-02-22 17:54:26.571323-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-5	2017-02-17	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
7	t	2017-02-22 16:50:47.51224-05	2017-02-22 17:54:26.578607-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-6	2017-02-16	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
12	t	2017-02-22 16:50:53.279363-05	2017-02-22 17:54:26.627265-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-11	2017-02-11	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
10	t	2017-02-22 16:50:50.995777-05	2017-02-22 17:54:26.606317-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-9	2017-02-13	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
11	t	2017-02-22 16:50:51.937216-05	2017-02-22 17:54:26.617096-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-10	2017-02-12	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
16	t	2017-02-22 16:50:57.445139-05	2017-02-22 17:54:26.676367-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-15	2017-02-07	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
14	t	2017-02-22 16:50:55.590373-05	2017-02-22 17:54:26.648149-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-13	2017-02-09	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
15	t	2017-02-22 16:50:55.907379-05	2017-02-22 17:54:26.66647-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-14	2017-02-08	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
20	t	2017-02-22 16:51:01.73737-05	2017-02-22 17:54:26.735683-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-19	2017-02-03	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
18	t	2017-02-22 16:50:59.640216-05	2017-02-22 17:54:26.702947-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-17	2017-02-05	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
19	t	2017-02-22 16:51:00.310148-05	2017-02-22 17:54:26.719177-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-18	2017-02-04	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
22	t	2017-02-22 16:51:03.924126-05	2017-02-22 17:54:26.772082-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-21	2017-02-01	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
24	t	2017-02-22 16:51:05.80097-05	2017-02-22 17:54:26.811463-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-23	2017-01-30	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
23	t	2017-02-22 16:51:05.37271-05	2017-02-22 17:54:26.791737-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-22	2017-01-31	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
28	t	2017-02-22 16:51:10.635122-05	2017-02-22 17:54:26.899095-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-27	2017-01-26	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
26	t	2017-02-22 16:51:08.652403-05	2017-02-22 17:54:26.851335-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-25	2017-01-28	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
27	t	2017-02-22 16:51:09.626004-05	2017-02-22 17:54:26.876815-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-26	2017-01-27	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
32	t	2017-02-22 16:51:13.378694-05	2017-02-22 17:54:26.995691-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-31	2017-01-22	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
30	t	2017-02-22 16:51:11.782916-05	2017-02-22 17:54:26.941994-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-29	2017-01-24	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
31	t	2017-02-22 16:51:13.107863-05	2017-02-22 17:54:26.966803-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-30	2017-01-23	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
36	t	2017-02-22 16:51:15.551834-05	2017-02-22 17:54:27.110666-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-35	2017-01-18	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
34	t	2017-02-22 16:51:15.176422-05	2017-02-22 17:54:27.053872-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-33	2017-01-20	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
35	t	2017-02-22 16:51:15.313439-05	2017-02-22 17:54:27.081318-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-34	2017-01-19	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
40	t	2017-02-22 16:51:19.960193-05	2017-02-22 17:54:27.246872-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-39	2017-01-14	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
38	t	2017-02-22 16:51:16.872349-05	2017-02-22 17:54:27.186843-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-37	2017-01-16	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
39	t	2017-02-22 16:51:17.050746-05	2017-02-22 17:54:27.218026-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-38	2017-01-15	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
9	t	2017-02-22 16:50:50.019272-05	2017-02-22 17:54:26.596266-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-8	2017-02-14	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
13	t	2017-02-22 16:50:54.213032-05	2017-02-22 17:54:26.636711-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-12	2017-02-10	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
5	t	2017-02-22 16:50:45.715534-05	2017-02-22 17:54:26.564994-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-4	2017-02-18	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
25	t	2017-02-22 16:51:07.525137-05	2017-02-22 17:54:26.831941-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-24	2017-01-29	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
29	t	2017-02-22 16:51:10.77693-05	2017-02-22 17:54:26.921976-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-28	2017-01-25	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
21	t	2017-02-22 16:51:02.719589-05	2017-02-22 17:54:26.755169-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-20	2017-02-02	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
1	t	2017-02-22 16:50:35.465127-05	2017-02-22 17:54:26.538898-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit	2017-02-22	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
17	t	2017-02-22 16:50:58.547883-05	2017-02-22 17:54:26.687313-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-16	2017-02-06	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
37	t	2017-02-22 16:51:16.670867-05	2017-02-22 17:54:27.150117-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-36	2017-01-17	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
33	t	2017-02-22 16:51:13.884493-05	2017-02-22 17:54:27.023641-05	0	0	lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-32	2017-01-21	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT CONSECTETUR ADIPISCING ELIT.	uploads/noticias_imgs/b20-img.jpg	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque eros, non volutpat metus fringilla eu. Etiam consectetur ante augue, non finibus est accumsan iaculis. Suspendisse a orci efficitur urna condimentum tempor. Vivamus luctus rhoncus risus. Praesent id blandit lorem. Sed sed lorem sed arcu bibendum laoreet ut et ante. In hac habitasse platea dictumst. Morbi varius massa nec erat interdum, semper rutrum risus fringilla. Etiam fermentum ut ligula pharetra sollicitudin. Duis semper ligula metus, quis ultrices sapien accumsan ut. Phasellus a neque pellentesque, porta nunc ac, interdum nisl. Quisque id lacus eu eros fringilla tincidunt. Sed maximus nunc ut orci pretium, vitae iaculis odio facilisis. Proin vel turpis eu tortor porta rutrum at sed turpis. Donec blandit cursus urna et cursus.</p><p>Suspendisse mollis gravida urna, sed pulvinar sem imperdiet ut. Integer lobortis ultricies urna. Pellentesque erat eros, blandit quis nisl vel, varius tempor sem. Nullam placerat augue felis, at sodales quam finibus ut. Nam felis purus, viverra a neque at, commodo fermentum felis. Fusce eget sagittis ex. Cras vulputate lectus metus, nec efficitur risus venenatis et. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum euismod justo vitae aliquet dapibus. Suspendisse luctus faucibus metus. Nunc dictum libero ante, a interdum dolor rutrum sit amet. Aliquam lacus nunc, sagittis in orci eu, dapibus viverra mauris. Fusce efficitur blandit ipsum, a bibendum eros gravida a. Pellentesque nulla diam, viverra a tincidunt eget, lacinia nec sem.</p>	LOREM IPSUM DOLOR SIT AMET, ONSSSECTUT//CONSECTETUR ADIPISCING ELIT.
\.


--
-- Name: eventos_noticias_noticias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('eventos_noticias_noticias_id_seq', 40, true);


--
-- Data for Name: formularios_contacto; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY formularios_contacto (id, fecha, nombres, email, telefono, empresa, mensaje) FROM stdin;
1	2017-02-16 18:53:04.456725-05	Yelson	chevarrias@gmail.com	930664519	CcapuDev	Rawr :v
2	2017-02-16 18:55:08.180142-05	Yelson	chevarrias@gmail.com	930664519	CcapuDev	Desde Zoho :v
3	2017-02-16 18:58:53.469834-05	Yelson	chevarrias@gmail.com	930664519	CcapuDev	Desde Zoho SSL :v
4	2017-02-16 19:07:46.204829-05	Yelson	chevarrias@gmail.com	930664519	CcapuDev	Prueba DKIM :v
5	2017-02-16 19:10:37.502978-05	Yelson	chevarrias@gmail.com	930664519	CcapuDev	Prueba DKIM :v
6	2017-02-16 19:25:40.11925-05	Yzelson	chevarrxias@gmail.comx	+51930664519	CcapuxDev	Test DKIM
\.


--
-- Name: formularios_contacto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('formularios_contacto_id_seq', 6, true);


--
-- Data for Name: formularios_contactotrabajo; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY formularios_contactotrabajo (id, fecha, telefono, nombres, email, adjunto) FROM stdin;
\.


--
-- Name: formularios_contactotrabajo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('formularios_contactotrabajo_id_seq', 1, false);


--
-- Data for Name: formularios_destinatarios; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY formularios_destinatarios (id, form_contacto, form_suscript, form_trabajo, form_socios) FROM stdin;
1	chevarrias@gmail.com			
\.


--
-- Name: formularios_destinatarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('formularios_destinatarios_id_seq', 1, true);


--
-- Data for Name: formularios_socioscontacto; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY formularios_socioscontacto (id, fecha, nombres, email, telefono, empresa, mensaje) FROM stdin;
\.


--
-- Name: formularios_socioscontacto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('formularios_socioscontacto_id_seq', 1, false);


--
-- Data for Name: formularios_suscript; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY formularios_suscript (id, fecha, nombres, email) FROM stdin;
\.


--
-- Name: formularios_suscript_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('formularios_suscript_id_seq', 1, false);


--
-- Data for Name: seo_infoseo; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY seo_infoseo (id, seo_alerts, emails_support) FROM stdin;
1	f	seo@staffcreativa.com
\.


--
-- Name: seo_infoseo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('seo_infoseo_id_seq', 1, false);


--
-- Data for Name: seo_seoredirects; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY seo_seoredirects (id, active, created, modified, created_by, modified_by, url_in, url_out, code_type) FROM stdin;
1	t	2017-02-21 19:30:21.957546-05	2017-02-21 19:30:21.965479-05	0	0	/es/cursos/categoria/	/es/	302
2	t	2017-02-22 18:59:48.860525-05	2017-02-22 18:59:48.870223-05	0	0	/en/event/evento-epcm-conferencia-internacional-de-cursos-multidioma-2/	/es/	302
\.


--
-- Name: seo_seoredirects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('seo_seoredirects_id_seq', 2, true);


--
-- Data for Name: seo_seotags; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY seo_seotags (id, active, created, modified, created_by, modified_by, url_seo, title, descript, extend) FROM stdin;
1	t	2017-02-16 12:10:20.483545-05	2017-02-16 12:10:20.483601-05	0	0	/pt/			
2	t	2017-02-16 12:10:24.332399-05	2017-02-16 12:10:24.332453-05	0	0	/en/			
3	t	2017-02-16 12:10:28.035965-05	2017-02-16 12:10:28.036025-05	0	0	/es/			
4	t	2017-02-17 19:58:50.095577-05	2017-02-17 19:58:50.095625-05	0	0	/pt/programas.html			
5	t	2017-02-17 20:01:57.178584-05	2017-02-17 20:01:57.17863-05	0	0	/pt/home.html			
6	t	2017-02-17 20:02:51.614199-05	2017-02-17 20:02:51.614247-05	0	0	/pt/iniciar-sesion.html			
7	t	2017-02-17 20:02:57.079983-05	2017-02-17 20:02:57.080033-05	0	0	/pt/producto-elegido.html			
8	t	2017-02-21 11:21:56.842671-05	2017-02-21 11:21:56.842732-05	0	0	/es/conocenos/			
9	t	2017-02-21 11:35:13.310831-05	2017-02-21 11:35:13.310885-05	0	0	/es/noticias/			
10	t	2017-02-21 14:20:23.714095-05	2017-02-21 14:20:23.714155-05	0	0	/es/cursos/categoria/			
11	t	2017-02-21 15:08:51.585461-05	2017-02-21 15:08:51.585507-05	0	0	/es/curso/gestion-de-formatos/			
12	t	2017-02-21 15:43:51.773982-05	2017-02-21 15:43:51.774018-05	0	0	/es/contacto/			
13	t	2017-02-22 10:19:55.217736-05	2017-02-22 10:19:55.217858-05	0	0	/es/preguntas-frecuentes/			
14	t	2017-02-22 10:20:02.514908-05	2017-02-22 10:20:02.514948-05	0	0	/es/terminos-y-condiciones/			
15	t	2017-02-22 10:27:55.522549-05	2017-02-22 10:27:55.52259-05	0	0	/pt/contacto/			
16	t	2017-02-22 10:27:56.935258-05	2017-02-22 10:27:56.935302-05	0	0	/en/contacto/			
17	t	2017-02-22 11:37:58.691668-05	2017-02-22 11:37:58.691734-05	0	0	/pt/datos-envio.html			
18	t	2017-02-22 11:47:29.282038-05	2017-02-22 11:47:29.282095-05	0	0	/pt/terminos-y-condiciones/			
19	t	2017-02-22 11:53:09.788077-05	2017-02-22 11:53:09.78812-05	0	0	/en/datos-envio.html			
20	t	2017-02-22 11:53:18.067374-05	2017-02-22 11:53:18.067437-05	0	0	/es/datos-envio.html			
21	t	2017-02-22 16:22:38.757207-05	2017-02-22 16:22:38.757258-05	0	0	/es/evento/evento-epcm-conferencia-internacional-de-cursos-multidioma-1/			
22	t	2017-02-22 16:25:44.632122-05	2017-02-22 16:25:44.632184-05	0	0	/es/eventos/			
23	t	2017-02-22 16:54:57.520592-05	2017-02-22 16:54:57.520662-05	0	0	/es/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit/			
24	t	2017-02-22 18:15:40.735616-05	2017-02-22 18:15:40.735679-05	0	0	/es/libro-reclamaciones.html			
25	t	2017-02-22 18:21:33.646735-05	2017-02-22 18:21:33.646798-05	0	0	/es/libro-de-reclamaciones/			
26	t	2017-02-22 18:23:11.770511-05	2017-02-22 18:23:11.770557-05	0	0	/en/libro-de-reclamaciones/			
27	t	2017-02-22 18:23:14.776224-05	2017-02-22 18:23:14.776263-05	0	0	/pt/libro-de-reclamaciones/			
28	t	2017-02-22 18:58:02.672171-05	2017-02-22 18:58:02.672244-05	0	0	/en/events/			
29	t	2017-02-22 18:58:39.860804-05	2017-02-22 18:58:39.860866-05	0	0	/en/event/evento-epcm-conferencia-internacional-de-cursos-multidioma-2/			
30	t	2017-02-22 18:59:59.886222-05	2017-02-22 18:59:59.886275-05	0	0	/en/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2/			
31	t	2017-02-22 19:00:09.747569-05	2017-02-22 19:00:09.747607-05	0	0	/pt/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2/			
32	t	2017-02-22 19:00:11.779407-05	2017-02-22 19:00:11.779464-05	0	0	/es/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2/			
33	t	2017-02-22 19:08:21.351157-05	2017-02-22 19:08:21.351197-05	0	0	/pt/conocenos/			
34	t	2017-02-22 20:15:45.521619-05	2017-02-22 20:15:45.52166-05	0	0	/pt/cursos/diplomado/			
35	t	2017-02-22 20:19:33.425476-05	2017-02-22 20:19:33.425529-05	0	0	/pt/cursos/especialidades/			
36	t	2017-02-22 20:19:35.843705-05	2017-02-22 20:19:35.843761-05	0	0	/pt/cursos/certificaciones/			
37	t	2017-02-22 20:19:38.332199-05	2017-02-22 20:19:38.332279-05	0	0	/pt/cursos/software/			
38	t	2017-02-22 20:19:40.371232-05	2017-02-22 20:19:40.371275-05	0	0	/pt/cursos/in-house/			
39	t	2017-02-22 20:19:46.370994-05	2017-02-22 20:19:46.371045-05	0	0	/es/cursos/in-house/			
40	t	2017-02-23 16:34:38.91052-05	2017-02-23 16:34:38.910572-05	0	0	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-10/			
41	t	2017-02-23 18:48:54.566237-05	2017-02-23 18:48:54.566341-05	0	0	/es/cursos/diplomado/			
42	t	2017-02-23 18:52:05.76205-05	2017-02-23 18:52:05.762093-05	0	0	/es/cursos/especialidades/			
43	t	2017-02-23 19:01:20.910729-05	2017-02-23 19:01:20.910784-05	0	0	/es/cursos/certificaciones/			
44	t	2017-02-23 19:01:27.401879-05	2017-02-23 19:01:27.401916-05	0	0	/es/cursos/software/			
45	t	2017-02-23 19:02:22.738572-05	2017-02-23 19:02:22.738621-05	0	0	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-9/			
46	t	2017-02-23 20:03:34.114907-05	2017-02-23 20:03:34.114969-05	0	0	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-4/			
47	t	2017-02-24 13:37:49.169928-05	2017-02-24 13:37:49.169989-05	0	0	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-5/			
48	t	2017-02-24 13:38:00.216881-05	2017-02-24 13:38:00.216917-05	0	0	/es/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-1/			
\.


--
-- Name: seo_seotags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('seo_seotags_id_seq', 48, true);


--
-- Data for Name: seo_urlregister; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY seo_urlregister (id, url) FROM stdin;
1	/pt/
2	/en/
3	/es/
4	/pt/programas.html
5	/pt/home.html
6	/pt/iniciar-sesion.html
7	/pt/producto-elegido.html
8	/es/conocenos/
9	/es/noticias/
10	/es/cursos/categoria/
11	/es/curso/gestion-de-formatos/
12	/es/contacto/
13	/es/preguntas-frecuentes/
14	/es/terminos-y-condiciones/
15	/pt/contacto/
16	/en/contacto/
17	/pt/datos-envio.html
18	/pt/terminos-y-condiciones/
19	/en/datos-envio.html
20	/es/datos-envio.html
21	/es/evento/evento-epcm-conferencia-internacional-de-cursos-multidioma-1/
22	/es/eventos/
23	/es/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit/
24	/es/libro-reclamaciones.html
25	/es/libro-de-reclamaciones/
26	/en/libro-de-reclamaciones/
27	/pt/libro-de-reclamaciones/
28	/en/events/
29	/en/event/evento-epcm-conferencia-internacional-de-cursos-multidioma-2/
30	/en/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2/
31	/pt/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2/
32	/es/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-2/
33	/pt/conocenos/
34	/pt/cursos/diplomado/
35	/pt/cursos/especialidades/
36	/pt/cursos/certificaciones/
37	/pt/cursos/software/
38	/pt/cursos/in-house/
39	/es/cursos/in-house/
40	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-10/
41	/es/cursos/diplomado/
42	/es/cursos/especialidades/
43	/es/cursos/certificaciones/
44	/es/cursos/software/
45	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-9/
46	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-4/
47	/es/curso/diplomado-en-manejo-de-proyectos-en-rango-z-5/
48	/es/noticia/lorem-ipsum-dolor-sit-amet-onsssectut-consectetur-adipiscing-elit-1/
\.


--
-- Name: seo_urlregister_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('seo_urlregister_id_seq', 48, true);


--
-- Data for Name: terminos_preguntas_quest; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY terminos_preguntas_quest (id, active, created, modified, created_by, modified_by, slug, nombre, descript, posicion) FROM stdin;
\.


--
-- Name: terminos_preguntas_quest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('terminos_preguntas_quest_id_seq', 1, false);


--
-- Data for Name: terminos_preguntas_questseccion; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY terminos_preguntas_questseccion (id, cabecera, b_titulo) FROM stdin;
\.


--
-- Name: terminos_preguntas_questseccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('terminos_preguntas_questseccion_id_seq', 1, false);


--
-- Data for Name: terminos_preguntas_terms; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY terminos_preguntas_terms (id, active, created, modified, created_by, modified_by, slug, nombre, descript, posicion) FROM stdin;
\.


--
-- Name: terminos_preguntas_terms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('terminos_preguntas_terms_id_seq', 1, false);


--
-- Data for Name: terminos_preguntas_termsseccion; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY terminos_preguntas_termsseccion (id, cabecera, b_titulo) FROM stdin;
\.


--
-- Name: terminos_preguntas_termsseccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('terminos_preguntas_termsseccion_id_seq', 1, false);


--
-- Data for Name: web_clientes; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_clientes (id, active, created, modified, created_by, modified_by, img, nombre, posicion) FROM stdin;
1	t	2017-02-22 19:23:31.735647-05	2017-02-22 19:23:31.735696-05	0	0	uploads/clientes/b8-left-img-1.jpg	CMS	1
2	t	2017-02-22 19:23:35.005116-05	2017-02-22 19:23:35.005237-05	0	0	uploads/clientes/b8-left-img-1.jpg	CMS	1
3	t	2017-02-22 19:23:37.687646-05	2017-02-22 19:23:37.687684-05	0	0	uploads/clientes/b8-left-img-1.jpg	CMS	1
4	t	2017-02-22 19:23:40.561452-05	2017-02-22 19:23:40.561501-05	0	0	uploads/clientes/b8-left-img-1.jpg	CMS	1
5	t	2017-02-22 19:23:43.052026-05	2017-02-22 19:23:43.05207-05	0	0	uploads/clientes/b8-left-img-1.jpg	CMS	1
6	t	2017-02-22 19:23:47.10933-05	2017-02-22 19:23:47.109368-05	0	0	uploads/clientes/b8-left-img-1.jpg	CMS	1
\.


--
-- Name: web_clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_clientes_id_seq', 6, true);


--
-- Data for Name: web_conocenos; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_conocenos (id, cabecera, img, qs, pa, ms, vs, bg_titulo, bg_img, bg_vid, bg_vid_id, cf_descript, cf_img, cf_vid, cf_vid_id, ns_titulo, ns_descript, nr_titulo, nr_descript) FROM stdin;
1	CONÓCENOS	uploads/conocenos/b10-img.jpg	<p>1 Somos &ldquo;CMS Project Consulting&rdquo;, profesionales especialistas en Planificar, Gestionar y Controlar Proyectos de Ingenier&iacute;a, EPC, EPCM. En &ldquo;EPCM Project Academy&rdquo; brindamos servicios de entrenamiento en certificaciones internacionales del AACE International, PMI con el fin de mejorar la calificaci&oacute;n t&eacute;cnicas de nuestro alumnos as&iacute; como contribuir en generar resultados exitosos en los negocios y proyectos de nuestros clientes.</p>\r\n\r\n<p>Ofrecemos servicios de consultor&iacute;a para gestionar proyectos basados en reconocidas pr&aacute;cticas y est&aacute;ndares internacionales, as&iacute; como filosof&iacute;as de gesti&oacute;n que conducen al &eacute;xito de los proyectos (PMI, AACE, Lean Construction).</p>\r\n\r\n<p>Ayudamos a nuestros Clientes a crear cultura de proyectos e implementar su Oficina de Proyectos (PMO) para que puedan lograr sus objetivos estrat&eacute;gicos.</p>\r\n	<p>1 Somos &ldquo;CMS Project Consulting&rdquo;, profesionales especialistas en Planificar, Gestionar y Controlar Proyectos de Ingenier&iacute;a, EPC, EPCM. En &ldquo;EPCM Project Academy&rdquo; brindamos servicios de entrenamiento en certificaciones internacionales del AACE International, PMI con el fin de mejorar la calificaci&oacute;n t&eacute;cnicas de nuestro alumnos as&iacute; como contribuir en generar resultados exitosos en los negocios y proyectos de nuestros clientes.</p>\r\n\r\n<p>Ofrecemos servicios de consultor&iacute;a para gestionar proyectos basados en reconocidas pr&aacute;cticas y est&aacute;ndares internacionales, as&iacute; como filosof&iacute;as de gesti&oacute;n que conducen al &eacute;xito de los proyectos (PMI, AACE, Lean Construction).</p>\r\n\r\n<p>Ayudamos a nuestros Clientes a crear cultura de proyectos e implementar su Oficina de Proyectos (PMO) para que puedan lograr sus objetivos estrat&eacute;gicos.</p>\r\n	<p>1 Somos &ldquo;CMS Project Consulting&rdquo;, profesionales especialistas en Planificar, Gestionar y Controlar Proyectos de Ingenier&iacute;a, EPC, EPCM. En &ldquo;EPCM Project Academy&rdquo; brindamos servicios de entrenamiento en certificaciones internacionales del AACE International, PMI con el fin de mejorar la calificaci&oacute;n t&eacute;cnicas de nuestro alumnos as&iacute; como contribuir en generar resultados exitosos en los negocios y proyectos de nuestros clientes.</p>\r\n\r\n<p>Ofrecemos servicios de consultor&iacute;a para gestionar proyectos basados en reconocidas pr&aacute;cticas y est&aacute;ndares internacionales, as&iacute; como filosof&iacute;as de gesti&oacute;n que conducen al &eacute;xito de los proyectos (PMI, AACE, Lean Construction).</p>\r\n\r\n<p>Ayudamos a nuestros Clientes a crear cultura de proyectos e implementar su Oficina de Proyectos (PMO) para que puedan lograr sus objetivos estrat&eacute;gicos.</p>\r\n	<p>1 Somos &ldquo;CMS Project Consulting&rdquo;, profesionales especialistas en Planificar, Gestionar y Controlar Proyectos de Ingenier&iacute;a, EPC, EPCM. En &ldquo;EPCM Project Academy&rdquo; brindamos servicios de entrenamiento en certificaciones internacionales del AACE International, PMI con el fin de mejorar la calificaci&oacute;n t&eacute;cnicas de nuestro alumnos as&iacute; como contribuir en generar resultados exitosos en los negocios y proyectos de nuestros clientes.</p>\r\n\r\n<p>Ofrecemos servicios de consultor&iacute;a para gestionar proyectos basados en reconocidas pr&aacute;cticas y est&aacute;ndares internacionales, as&iacute; como filosof&iacute;as de gesti&oacute;n que conducen al &eacute;xito de los proyectos (PMI, AACE, Lean Construction).</p>\r\n\r\n<p>Ayudamos a nuestros Clientes a crear cultura de proyectos e implementar su Oficina de Proyectos (PMO) para que puedan lograr sus objetivos estrat&eacute;gicos.</p>\r\n	Profesionales//ESPECIALIDADES	uploads/bg_fondo/b11-bg.jpg	https://www.youtube.com/watch?v=meBbDqAXago	meBbDqAXago	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sagittis in mi imperdiet scelerisque. In sed accumsan.commodo sapien. Morbi egestas arcu quis velit facilisis, at pulvinar nulla congue.</p>\r\n\r\n<p>Praesent dapibus, orci eget varius eleifend, odio risus sodales tortor, sed gravida felis elit at odio. Mauris auctor ut sapien consectetur efficitur. Suspendisse posuere justo vel finibus</p>\r\n	uploads/comofun/b4-img.jpg	https://www.youtube.com/watch?v=SwlQFK_1C8k	SwlQFK_1C8k	NUESTRO STAFF	<p>Nuestro staff cuenta con experiencia certificada a nivel internacional y han sido parte de equipos clave en proyectos estrat&eacute;gicos, multiculturales y de gran envergadura.</p>\r\n	ELLOS NOS RESPALDAN	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Expedita, consequatur?</p>\r\n
\.


--
-- Name: web_conocenos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_conocenos_id_seq', 1, false);


--
-- Data for Name: web_contactoseccion; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_contactoseccion (id, cabecera, titulo, descript) FROM stdin;
1			
\.


--
-- Name: web_contactoseccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_contactoseccion_id_seq', 1, false);


--
-- Data for Name: web_ellosopinan; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_ellosopinan (id, active, created, modified, created_by, modified_by, img, nombre, cargo, descript, posicion) FROM stdin;
1	t	2017-02-23 16:32:04.010872-05	2017-02-23 16:32:04.010926-05	0	0	uploads/opiniones/ellos_opinan.png	Elvira Mora	Empresaria Dueña de ConstruCorp	Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500	1
2	t	2017-02-23 16:32:06.351858-05	2017-02-23 16:32:06.351898-05	0	0	uploads/opiniones/ellos_opinan.png	Elvira Mora	Empresaria Dueña de ConstruCorp	Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500	1
3	t	2017-02-23 16:32:08.317095-05	2017-02-23 16:32:08.317149-05	0	0	uploads/opiniones/ellos_opinan.png	Elvira Mora	Empresaria Dueña de ConstruCorp	Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500	1
4	t	2017-02-23 16:32:10.912783-05	2017-02-23 16:32:10.912826-05	0	0	uploads/opiniones/ellos_opinan.png	Elvira Mora	Empresaria Dueña de ConstruCorp	Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500	1
5	t	2017-02-23 16:32:13.755954-05	2017-02-23 16:32:13.756001-05	0	0	uploads/opiniones/ellos_opinan.png	Elvira Mora	Empresaria Dueña de ConstruCorp	Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500	1
6	t	2017-02-23 16:32:16.636799-05	2017-02-23 16:32:16.636847-05	0	0	uploads/opiniones/ellos_opinan.png	Elvira Mora	Empresaria Dueña de ConstruCorp	Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500	1
\.


--
-- Data for Name: web_infosite; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_infosite (id, active, created, modified, created_by, modified_by, email, telefono, direccion, site, facebook, twitter, youtube, instagram, linkedin, pinterest, titulo, ga, coordenadas, favi57, favi72, favi114, favi256, whatsapp, footer_inf) FROM stdin;
1	t	2017-02-16 12:10:20.45924-05	2017-02-16 12:10:20.459309-05	0	0	chevarrias@gmail.com	5555555	Av. Sin Nombre #123	http://127.0.0.1:8000	http://facebook.com/						EPCM		None						
\.


--
-- Name: web_infosite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_infosite_id_seq', 1, true);


--
-- Data for Name: web_libroseccion; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_libroseccion (id, cabecera, descript, pie) FROM stdin;
1			
\.


--
-- Name: web_libroseccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_libroseccion_id_seq', 1, false);


--
-- Data for Name: web_paises; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_paises (id, active, created, modified, created_by, modified_by, posicion, img, nombre) FROM stdin;
2	f	2017-02-22 19:33:11.904394-05	2017-02-22 19:35:00.981899-05	0	0	1		Albania
3	f	2017-02-22 19:33:11.910637-05	2017-02-22 19:35:00.983578-05	0	0	1		Alemania
4	f	2017-02-22 19:33:11.913001-05	2017-02-22 19:35:00.984509-05	0	0	1		Andorra
5	f	2017-02-22 19:33:11.914974-05	2017-02-22 19:35:00.985446-05	0	0	1		Angola
6	f	2017-02-22 19:33:11.919099-05	2017-02-22 19:35:00.986674-05	0	0	1		Antigua y Barbuda
7	f	2017-02-22 19:33:11.921117-05	2017-02-22 19:35:00.987981-05	0	0	1		Arabia Saudita
8	f	2017-02-22 19:33:11.923034-05	2017-02-22 19:35:00.988973-05	0	0	1		Argelia
9	f	2017-02-22 19:33:11.92494-05	2017-02-22 19:35:00.990672-05	0	0	1		Argentina
10	f	2017-02-22 19:33:11.926703-05	2017-02-22 19:35:00.991659-05	0	0	1		Armenia
12	f	2017-02-22 19:33:11.930766-05	2017-02-22 19:35:00.993464-05	0	0	1		Austria
13	f	2017-02-22 19:33:11.932974-05	2017-02-22 19:35:00.994698-05	0	0	1		Azerbaiyán
14	f	2017-02-22 19:33:11.93572-05	2017-02-22 19:35:00.995979-05	0	0	1		Bahamas
15	f	2017-02-22 19:33:11.938156-05	2017-02-22 19:35:00.997114-05	0	0	1		Bangladés
16	f	2017-02-22 19:33:11.939666-05	2017-02-22 19:35:00.998386-05	0	0	1		Barbados
17	f	2017-02-22 19:33:11.941082-05	2017-02-22 19:35:00.999323-05	0	0	1		Baréin
18	f	2017-02-22 19:33:11.942555-05	2017-02-22 19:35:01.000234-05	0	0	1		Bélgica
19	f	2017-02-22 19:33:11.944025-05	2017-02-22 19:35:01.001596-05	0	0	1		Belice
20	f	2017-02-22 19:33:11.945513-05	2017-02-22 19:35:01.002881-05	0	0	1		Benín
21	f	2017-02-22 19:33:11.94699-05	2017-02-22 19:35:01.004174-05	0	0	1		Bielorrusia
22	f	2017-02-22 19:33:11.948341-05	2017-02-22 19:35:01.005658-05	0	0	1		Birmania
23	f	2017-02-22 19:33:11.949766-05	2017-02-22 19:35:01.007308-05	0	0	1		Bolivia
24	f	2017-02-22 19:33:11.95195-05	2017-02-22 19:35:01.008839-05	0	0	1		Bosnia-Herzegovina
25	f	2017-02-22 19:33:11.953898-05	2017-02-22 19:35:01.010327-05	0	0	1		Botsuana
26	f	2017-02-22 19:33:11.955371-05	2017-02-22 19:35:01.011988-05	0	0	1		Brasil
27	f	2017-02-22 19:33:11.956751-05	2017-02-22 19:35:01.013704-05	0	0	1		Brunéi
28	f	2017-02-22 19:33:11.958171-05	2017-02-22 19:35:01.015326-05	0	0	1		Bulgaria
30	f	2017-02-22 19:33:11.961419-05	2017-02-22 19:35:01.018482-05	0	0	1		Burundi
31	f	2017-02-22 19:33:11.964076-05	2017-02-22 19:35:01.020118-05	0	0	1		Bután
32	f	2017-02-22 19:33:11.9661-05	2017-02-22 19:35:01.021662-05	0	0	1		Cabo Verde
33	f	2017-02-22 19:33:11.968216-05	2017-02-22 19:35:01.024116-05	0	0	1		Camboya
34	f	2017-02-22 19:33:11.970004-05	2017-02-22 19:35:01.026616-05	0	0	1		Camerún
35	f	2017-02-22 19:33:11.972847-05	2017-02-22 19:35:01.028307-05	0	0	1		Canadá
36	f	2017-02-22 19:33:11.975037-05	2017-02-22 19:35:01.029955-05	0	0	1		Catar
37	f	2017-02-22 19:33:11.977227-05	2017-02-22 19:35:01.030966-05	0	0	1		Chad
41	t	2017-02-22 19:33:11.986481-05	2017-02-22 19:42:11.419523-05	0	0	1	uploads/banderas/b8-right-img-2.jpg	Colombia
39	f	2017-02-22 19:33:11.981403-05	2017-02-22 19:35:01.033495-05	0	0	1		China
40	f	2017-02-22 19:33:11.983708-05	2017-02-22 19:35:01.034852-05	0	0	1		Chipre
42	f	2017-02-22 19:33:11.988866-05	2017-02-22 19:35:01.037746-05	0	0	1		Comoras
43	f	2017-02-22 19:33:11.991357-05	2017-02-22 19:35:01.039984-05	0	0	1		Congo
44	f	2017-02-22 19:33:11.994217-05	2017-02-22 19:35:01.041812-05	0	0	1		Corea del Norte
45	f	2017-02-22 19:33:11.997345-05	2017-02-22 19:35:01.042727-05	0	0	1		Corea del Sur
46	f	2017-02-22 19:33:12.000514-05	2017-02-22 19:35:01.043587-05	0	0	1		Costa de Marfil
47	f	2017-02-22 19:33:12.002585-05	2017-02-22 19:35:01.044473-05	0	0	1		Costa Rica
48	f	2017-02-22 19:33:12.004559-05	2017-02-22 19:35:01.045357-05	0	0	1		Croacia
49	f	2017-02-22 19:33:12.008553-05	2017-02-22 19:35:01.046396-05	0	0	1		Cuba
50	f	2017-02-22 19:33:12.011417-05	2017-02-22 19:35:01.04735-05	0	0	1		Dinamarca
52	f	2017-02-22 19:33:12.016032-05	2017-02-22 19:35:01.049938-05	0	0	1		Ecuador
53	f	2017-02-22 19:33:12.01812-05	2017-02-22 19:35:01.050849-05	0	0	1		Egipto
54	f	2017-02-22 19:33:12.019719-05	2017-02-22 19:35:01.052036-05	0	0	1		El Salvador
55	f	2017-02-22 19:33:12.020934-05	2017-02-22 19:35:01.053902-05	0	0	1		Emiratos Árabes Unidos
56	f	2017-02-22 19:33:12.022466-05	2017-02-22 19:35:01.0555-05	0	0	1		Eritrea
57	f	2017-02-22 19:33:12.023872-05	2017-02-22 19:35:01.058108-05	0	0	1		Eslovaquia
58	f	2017-02-22 19:33:12.025744-05	2017-02-22 19:35:01.059972-05	0	0	1		Eslovenia
59	f	2017-02-22 19:33:12.028947-05	2017-02-22 19:35:01.06147-05	0	0	1		España
60	f	2017-02-22 19:33:12.031217-05	2017-02-22 19:35:01.062941-05	0	0	1		Estados Unidos
61	f	2017-02-22 19:33:12.034077-05	2017-02-22 19:35:01.064352-05	0	0	1		Estonia
62	f	2017-02-22 19:33:12.039582-05	2017-02-22 19:35:01.065617-05	0	0	1		Etiopía
63	f	2017-02-22 19:33:12.04241-05	2017-02-22 19:35:01.066993-05	0	0	1		Filipinas
64	f	2017-02-22 19:33:12.045246-05	2017-02-22 19:35:01.068255-05	0	0	1		Finlandia
65	f	2017-02-22 19:33:12.047906-05	2017-02-22 19:35:01.069102-05	0	0	1		Fiyi
66	f	2017-02-22 19:33:12.049985-05	2017-02-22 19:35:01.069955-05	0	0	1		Francia
67	f	2017-02-22 19:33:12.052471-05	2017-02-22 19:35:01.07078-05	0	0	1		Gabón
68	f	2017-02-22 19:33:12.054765-05	2017-02-22 19:35:01.071654-05	0	0	1		Gambia
69	f	2017-02-22 19:33:12.057282-05	2017-02-22 19:35:01.072574-05	0	0	1		Georgia
71	f	2017-02-22 19:33:12.061883-05	2017-02-22 19:35:01.075311-05	0	0	1		Granada
72	f	2017-02-22 19:33:12.063526-05	2017-02-22 19:35:01.076072-05	0	0	1		Grecia
73	f	2017-02-22 19:33:12.065669-05	2017-02-22 19:35:01.076795-05	0	0	1		Guatemala
74	f	2017-02-22 19:33:12.067489-05	2017-02-22 19:35:01.079358-05	0	0	1		Guinea
75	f	2017-02-22 19:33:12.070006-05	2017-02-22 19:35:01.080512-05	0	0	1		Guinea Ecuatorial
76	f	2017-02-22 19:33:12.07241-05	2017-02-22 19:35:01.08137-05	0	0	1		Guinea-Bisáu
77	f	2017-02-22 19:33:12.074917-05	2017-02-22 19:35:01.082426-05	0	0	1		Guyana
78	f	2017-02-22 19:33:12.079107-05	2017-02-22 19:35:01.083957-05	0	0	1		Haití
79	f	2017-02-22 19:33:12.081209-05	2017-02-22 19:35:01.085711-05	0	0	1		Honduras
80	f	2017-02-22 19:33:12.083091-05	2017-02-22 19:35:01.087168-05	0	0	1		Hungría
81	f	2017-02-22 19:33:12.084866-05	2017-02-22 19:35:01.088335-05	0	0	1		India
82	f	2017-02-22 19:33:12.086769-05	2017-02-22 19:35:01.08959-05	0	0	1		Indonesia
83	f	2017-02-22 19:33:12.088566-05	2017-02-22 19:35:01.090787-05	0	0	1		Irak
84	f	2017-02-22 19:33:12.090381-05	2017-02-22 19:35:01.091981-05	0	0	1		Irán
85	f	2017-02-22 19:33:12.092305-05	2017-02-22 19:35:01.093231-05	0	0	1		Irlanda
86	f	2017-02-22 19:33:12.094343-05	2017-02-22 19:35:01.094605-05	0	0	1		Islandia
88	f	2017-02-22 19:33:12.100069-05	2017-02-22 19:35:01.098267-05	0	0	1		Islas Salomón
89	f	2017-02-22 19:33:12.102342-05	2017-02-22 19:35:01.099651-05	0	0	1		Israel
90	f	2017-02-22 19:33:12.105494-05	2017-02-22 19:35:01.10071-05	0	0	1		Italia
91	f	2017-02-22 19:33:12.10803-05	2017-02-22 19:35:01.101805-05	0	0	1		Jamaica
92	f	2017-02-22 19:33:12.109613-05	2017-02-22 19:35:01.102806-05	0	0	1		Japón
93	f	2017-02-22 19:33:12.11113-05	2017-02-22 19:35:01.10381-05	0	0	1		Jordania
94	f	2017-02-22 19:33:12.112646-05	2017-02-22 19:35:01.104772-05	0	0	1		Kazajistán
95	f	2017-02-22 19:33:12.115005-05	2017-02-22 19:35:01.105808-05	0	0	1		Kenia
96	f	2017-02-22 19:33:12.118038-05	2017-02-22 19:35:01.106699-05	0	0	1		Kirguistán
97	f	2017-02-22 19:33:12.120731-05	2017-02-22 19:35:01.107525-05	0	0	1		Kiribati
98	f	2017-02-22 19:33:12.122893-05	2017-02-22 19:35:01.108337-05	0	0	1		Kosovo
99	f	2017-02-22 19:33:12.124916-05	2017-02-22 19:35:01.109139-05	0	0	1		Kuwait
100	f	2017-02-22 19:33:12.127215-05	2017-02-22 19:35:01.109967-05	0	0	1		Laos
101	f	2017-02-22 19:33:12.129621-05	2017-02-22 19:35:01.110778-05	0	0	1		Lesoto
102	f	2017-02-22 19:33:12.131962-05	2017-02-22 19:35:01.111574-05	0	0	1		Letonia
103	f	2017-02-22 19:33:12.135069-05	2017-02-22 19:35:01.112371-05	0	0	1		Líbano
104	f	2017-02-22 19:33:12.138596-05	2017-02-22 19:35:01.113216-05	0	0	1		Liberia
105	f	2017-02-22 19:33:12.140551-05	2017-02-22 19:35:01.113989-05	0	0	1		Libia
1	f	2017-02-22 19:33:11.891516-05	2017-02-22 19:35:00.973614-05	0	0	1		Afganistán
11	f	2017-02-22 19:33:11.928148-05	2017-02-22 19:35:00.99249-05	0	0	1		Australia
29	f	2017-02-22 19:33:11.959544-05	2017-02-22 19:35:01.016908-05	0	0	1		Burkina Faso
51	f	2017-02-22 19:33:12.014136-05	2017-02-22 19:35:01.04898-05	0	0	1		Dominica
70	f	2017-02-22 19:33:12.059916-05	2017-02-22 19:35:01.074066-05	0	0	1		Ghana
87	f	2017-02-22 19:33:12.098235-05	2017-02-22 19:35:01.096702-05	0	0	1		Islas Marshall
106	f	2017-02-22 19:33:12.142372-05	2017-02-22 19:35:01.115235-05	0	0	1		Liechtenstein
107	f	2017-02-22 19:33:12.144675-05	2017-02-22 19:35:01.116214-05	0	0	1		Lituania
108	f	2017-02-22 19:33:12.14685-05	2017-02-22 19:35:01.116964-05	0	0	1		Luxemburgo
109	f	2017-02-22 19:33:12.148578-05	2017-02-22 19:35:01.117814-05	0	0	1		Macedonia
110	f	2017-02-22 19:33:12.151678-05	2017-02-22 19:35:01.118645-05	0	0	1		Madagascar
111	f	2017-02-22 19:33:12.154193-05	2017-02-22 19:35:01.119435-05	0	0	1		Malasia
112	f	2017-02-22 19:33:12.156443-05	2017-02-22 19:35:01.12021-05	0	0	1		Malaui
113	f	2017-02-22 19:33:12.159069-05	2017-02-22 19:35:01.120965-05	0	0	1		Maldivas
114	f	2017-02-22 19:33:12.16196-05	2017-02-22 19:35:01.121747-05	0	0	1		Malí
115	f	2017-02-22 19:33:12.164622-05	2017-02-22 19:35:01.122497-05	0	0	1		Malta
116	f	2017-02-22 19:33:12.166915-05	2017-02-22 19:35:01.123238-05	0	0	1		Marruecos
117	f	2017-02-22 19:33:12.169746-05	2017-02-22 19:35:01.123976-05	0	0	1		Mauricio
118	f	2017-02-22 19:33:12.172273-05	2017-02-22 19:35:01.124724-05	0	0	1		Mauritania
142	t	2017-02-22 19:33:12.230941-05	2017-02-22 19:52:50.268424-05	0	0	1	uploads/banderas/peru_flag.png	Perú
120	f	2017-02-22 19:33:12.176691-05	2017-02-22 19:35:01.126467-05	0	0	1		Micronesia
121	f	2017-02-22 19:33:12.180041-05	2017-02-22 19:35:01.12739-05	0	0	1		Moldavia
122	f	2017-02-22 19:33:12.182371-05	2017-02-22 19:35:01.12828-05	0	0	1		Mónaco
123	f	2017-02-22 19:33:12.183803-05	2017-02-22 19:35:01.129123-05	0	0	1		Mongolia
124	f	2017-02-22 19:33:12.185627-05	2017-02-22 19:35:01.13-05	0	0	1		Montenegro
125	f	2017-02-22 19:33:12.187555-05	2017-02-22 19:35:01.130851-05	0	0	1		Mozambique
126	f	2017-02-22 19:33:12.189054-05	2017-02-22 19:35:01.131765-05	0	0	1		Namibia
127	f	2017-02-22 19:33:12.190714-05	2017-02-22 19:35:01.13275-05	0	0	1		Nauru
128	f	2017-02-22 19:33:12.192632-05	2017-02-22 19:35:01.134205-05	0	0	1		Nepal
129	f	2017-02-22 19:33:12.197059-05	2017-02-22 19:35:01.136793-05	0	0	1		Nicaragua
130	f	2017-02-22 19:33:12.19933-05	2017-02-22 19:35:01.13865-05	0	0	1		Níger
131	f	2017-02-22 19:33:12.203447-05	2017-02-22 19:35:01.140236-05	0	0	1		Nigeria
132	f	2017-02-22 19:33:12.20779-05	2017-02-22 19:35:01.14194-05	0	0	1		Noruega
133	f	2017-02-22 19:33:12.210557-05	2017-02-22 19:35:01.143708-05	0	0	1		Nueva Zelanda
134	f	2017-02-22 19:33:12.213006-05	2017-02-22 19:35:01.145474-05	0	0	1		Omán
135	f	2017-02-22 19:33:12.215589-05	2017-02-22 19:35:01.147265-05	0	0	1		Países Bajos
136	f	2017-02-22 19:33:12.218245-05	2017-02-22 19:35:01.14902-05	0	0	1		Pakistán
137	f	2017-02-22 19:33:12.220609-05	2017-02-22 19:35:01.150809-05	0	0	1		Palaos
138	f	2017-02-22 19:33:12.223171-05	2017-02-22 19:35:01.15221-05	0	0	1		Palestina
139	f	2017-02-22 19:33:12.224551-05	2017-02-22 19:35:01.152994-05	0	0	1		Panamá
140	f	2017-02-22 19:33:12.22624-05	2017-02-22 19:35:01.154051-05	0	0	1		Papúa Nueva Guinea
141	f	2017-02-22 19:33:12.228588-05	2017-02-22 19:35:01.155019-05	0	0	1		Paraguay
143	f	2017-02-22 19:33:12.23276-05	2017-02-22 19:35:01.157031-05	0	0	1		Polonia
144	f	2017-02-22 19:33:12.234524-05	2017-02-22 19:35:01.158156-05	0	0	1		Portugal
145	f	2017-02-22 19:33:12.236809-05	2017-02-22 19:35:01.159227-05	0	0	1		Reino Unido
146	f	2017-02-22 19:33:12.241208-05	2017-02-22 19:35:01.159947-05	0	0	1		República Centroafricana
147	f	2017-02-22 19:33:12.243909-05	2017-02-22 19:35:01.160665-05	0	0	1		República Checa
148	f	2017-02-22 19:33:12.245795-05	2017-02-22 19:35:01.16155-05	0	0	1		República Democrática del Congo
149	f	2017-02-22 19:33:12.247284-05	2017-02-22 19:35:01.162464-05	0	0	1		República Dominicana
150	f	2017-02-22 19:33:12.248744-05	2017-02-22 19:35:01.163341-05	0	0	1		Ruanda
151	f	2017-02-22 19:33:12.250345-05	2017-02-22 19:35:01.164224-05	0	0	1		Rumania
152	f	2017-02-22 19:33:12.25238-05	2017-02-22 19:35:01.165102-05	0	0	1		Rusia
153	f	2017-02-22 19:33:12.255085-05	2017-02-22 19:35:01.166028-05	0	0	1		Samoa
154	f	2017-02-22 19:33:12.257572-05	2017-02-22 19:35:01.166906-05	0	0	1		San Cristóbal y Nieves
155	f	2017-02-22 19:33:12.259277-05	2017-02-22 19:35:01.168314-05	0	0	1		San Marino
156	f	2017-02-22 19:33:12.260751-05	2017-02-22 19:35:01.169766-05	0	0	1		San Vicente y las Granadinas
157	f	2017-02-22 19:33:12.262755-05	2017-02-22 19:35:01.171036-05	0	0	1		Santa Lucía
158	f	2017-02-22 19:33:12.26579-05	2017-02-22 19:35:01.172584-05	0	0	1		Santo Tomé y Príncipe
159	f	2017-02-22 19:33:12.268219-05	2017-02-22 19:35:01.174128-05	0	0	1		Senegal
160	f	2017-02-22 19:33:12.270561-05	2017-02-22 19:35:01.175298-05	0	0	1		Serbia
161	f	2017-02-22 19:33:12.272827-05	2017-02-22 19:35:01.176156-05	0	0	1		Seychelles
162	f	2017-02-22 19:33:12.275096-05	2017-02-22 19:35:01.177177-05	0	0	1		Sierra Leona
163	f	2017-02-22 19:33:12.276854-05	2017-02-22 19:35:01.179492-05	0	0	1		Singapur
164	f	2017-02-22 19:33:12.27854-05	2017-02-22 19:35:01.180779-05	0	0	1		Siria
165	f	2017-02-22 19:33:12.280809-05	2017-02-22 19:35:01.182477-05	0	0	1		Somalia
166	f	2017-02-22 19:33:12.283043-05	2017-02-22 19:35:01.184203-05	0	0	1		Sri Lanka
167	f	2017-02-22 19:33:12.285504-05	2017-02-22 19:35:01.185953-05	0	0	1		Suazilandia
168	f	2017-02-22 19:33:12.290882-05	2017-02-22 19:35:01.187488-05	0	0	1		Sudáfrica
169	f	2017-02-22 19:33:12.293479-05	2017-02-22 19:35:01.18906-05	0	0	1		Sudán
170	f	2017-02-22 19:33:12.297345-05	2017-02-22 19:35:01.190612-05	0	0	1		Sudán del Sur
171	f	2017-02-22 19:33:12.299011-05	2017-02-22 19:35:01.191798-05	0	0	1		Suecia
172	f	2017-02-22 19:33:12.30057-05	2017-02-22 19:35:01.192641-05	0	0	1		Suiza
173	f	2017-02-22 19:33:12.303199-05	2017-02-22 19:35:01.193599-05	0	0	1		Surinam
174	f	2017-02-22 19:33:12.307994-05	2017-02-22 19:35:01.194489-05	0	0	1		Tailandia
175	f	2017-02-22 19:33:12.310828-05	2017-02-22 19:35:01.195507-05	0	0	1		Taiwán
176	f	2017-02-22 19:33:12.312384-05	2017-02-22 19:35:01.196393-05	0	0	1		Tanzania
177	f	2017-02-22 19:33:12.314352-05	2017-02-22 19:35:01.201868-05	0	0	1		Tayikistán
178	f	2017-02-22 19:33:12.316649-05	2017-02-22 19:35:01.203371-05	0	0	1		Timor Oriental
179	f	2017-02-22 19:33:12.319543-05	2017-02-22 19:35:01.204375-05	0	0	1		Togo
180	f	2017-02-22 19:33:12.322088-05	2017-02-22 19:35:01.20528-05	0	0	1		Tonga
181	f	2017-02-22 19:33:12.324765-05	2017-02-22 19:35:01.20619-05	0	0	1		Trinidad y Tobago
182	f	2017-02-22 19:33:12.327981-05	2017-02-22 19:35:01.207074-05	0	0	1		Túnez
183	f	2017-02-22 19:33:12.330527-05	2017-02-22 19:35:01.207953-05	0	0	1		Turkmenistán
184	f	2017-02-22 19:33:12.333286-05	2017-02-22 19:35:01.208841-05	0	0	1		Turquía
185	f	2017-02-22 19:33:12.335653-05	2017-02-22 19:35:01.209786-05	0	0	1		Tuvalu
186	f	2017-02-22 19:33:12.338303-05	2017-02-22 19:35:01.210659-05	0	0	1		Ucrania
187	f	2017-02-22 19:33:12.341208-05	2017-02-22 19:35:01.211488-05	0	0	1		Uganda
188	f	2017-02-22 19:33:12.343234-05	2017-02-22 19:35:01.212297-05	0	0	1		Uruguay
189	f	2017-02-22 19:33:12.345434-05	2017-02-22 19:35:01.213096-05	0	0	1		Uzbekistán
190	f	2017-02-22 19:33:12.347867-05	2017-02-22 19:35:01.213935-05	0	0	1		Vanuatu
191	f	2017-02-22 19:33:12.349928-05	2017-02-22 19:35:01.214738-05	0	0	1		Vaticano
192	f	2017-02-22 19:33:12.352109-05	2017-02-22 19:35:01.215547-05	0	0	1		Venezuela
193	f	2017-02-22 19:33:12.354652-05	2017-02-22 19:35:01.216351-05	0	0	1		Vietnam
194	f	2017-02-22 19:33:12.357736-05	2017-02-22 19:35:01.217172-05	0	0	1		Yemen
195	f	2017-02-22 19:33:12.359696-05	2017-02-22 19:35:01.218049-05	0	0	1		Yibuti
196	f	2017-02-22 19:33:12.361333-05	2017-02-22 19:35:01.21896-05	0	0	1		Zambia
197	f	2017-02-22 19:33:12.36294-05	2017-02-22 19:35:01.220443-05	0	0	1		Zimbabue
38	t	2017-02-22 19:33:11.979343-05	2017-02-22 19:41:14.18759-05	0	0	1	uploads/banderas/b8-right-img-1.jpg	Chile
119	t	2017-02-22 19:33:12.174393-05	2017-02-22 19:43:58.19763-05	0	0	1	uploads/banderas/b8-right-img-3.jpg	México
\.


--
-- Name: web_paises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_paises_id_seq', 197, true);


--
-- Data for Name: web_porqueelegirnos; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_porqueelegirnos (id, active, created, modified, created_by, modified_by, icon, icon_h, nombre, descript, posicion, enlace) FROM stdin;
1	t	2017-02-22 19:06:04.331887-05	2017-02-22 19:06:04.331928-05	0	0	uploads/xqe_icons/b2-img-1a.png	uploads/xqe_icons_h/b2-img-1b.png	MIXED MODE	Lorem ipsum dolor sit amet, sagittis in mi imperdiet dolor sit amet,	6	/conocenos/
2	t	2017-02-22 19:06:08.185961-05	2017-02-22 19:06:08.18605-05	0	0	uploads/xqe_icons/b2-img-1a.png	uploads/xqe_icons_h/b2-img-1b.png	MIXED MODE	Lorem ipsum dolor sit amet, sagittis in mi imperdiet dolor sit amet,	5	/conocenos/
3	t	2017-02-22 19:06:10.484791-05	2017-02-22 19:06:10.484831-05	0	0	uploads/xqe_icons/b2-img-1a.png	uploads/xqe_icons_h/b2-img-1b.png	MIXED MODE	Lorem ipsum dolor sit amet, sagittis in mi imperdiet dolor sit amet,	4	/conocenos/
4	t	2017-02-22 19:06:12.891199-05	2017-02-22 19:06:12.89124-05	0	0	uploads/xqe_icons/b2-img-1a.png	uploads/xqe_icons_h/b2-img-1b.png	MIXED MODE	Lorem ipsum dolor sit amet, sagittis in mi imperdiet dolor sit amet,	3	/conocenos/
5	t	2017-02-22 19:06:15.308593-05	2017-02-22 19:06:15.308644-05	0	0	uploads/xqe_icons/b2-img-1a.png	uploads/xqe_icons_h/b2-img-1b.png	MIXED MODE	Lorem ipsum dolor sit amet, sagittis in mi imperdiet dolor sit amet,	2	/conocenos/
6	t	2017-02-22 19:06:18.132936-05	2017-02-22 19:06:18.132989-05	0	0	uploads/xqe_icons/b2-img-1a.png	uploads/xqe_icons_h/b2-img-1b.png	MIXED MODE	Lorem ipsum dolor sit amet, sagittis in mi imperdiet dolor sit amet,	1	/conocenos/
\.


--
-- Name: web_porqueelegirnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_porqueelegirnos_id_seq', 6, true);


--
-- Data for Name: web_respaldos; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_respaldos (id, active, created, modified, created_by, modified_by, img, nombre, posicion) FROM stdin;
1	t	2017-02-22 19:26:11.605778-05	2017-02-22 19:26:11.605824-05	0	0	uploads/partners/b14-img.jpg	GlobPartners	1
2	t	2017-02-22 19:26:14.368789-05	2017-02-22 19:26:14.368834-05	0	0	uploads/partners/b14-img.jpg	GlobPartners	1
3	t	2017-02-22 19:26:17.539771-05	2017-02-22 19:26:17.53982-05	0	0	uploads/partners/b14-img.jpg	GlobPartners	1
4	t	2017-02-22 19:26:20.606809-05	2017-02-22 19:26:20.606858-05	0	0	uploads/partners/b14-img.jpg	GlobPartners	1
5	t	2017-02-22 19:26:23.0397-05	2017-02-22 19:26:23.039739-05	0	0	uploads/partners/b14-img.jpg	GlobPartners	1
6	t	2017-02-22 19:26:25.659038-05	2017-02-22 19:26:25.659078-05	0	0	uploads/partners/b14-img.jpg	GlobPartners	1
\.


--
-- Name: web_respaldos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_respaldos_id_seq', 6, true);


--
-- Data for Name: web_sliders; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_sliders (id, active, created, modified, created_by, modified_by, posicion, titulo, fondo, enlace, enlace_text) FROM stdin;
1	t	2017-02-22 18:50:45.996415-05	2017-02-22 18:50:45.996463-05	0	0	1	<POTENCIA TUS CONOCIMIENTOS> y conviertete en un expero Exitoso	uploads/sliders/b1-img.jpg	/conocenos/	Conóce Más
2	t	2017-02-22 18:50:50.44628-05	2017-02-22 19:03:10.083617-05	0	0	2	<POTENCIA TUS CONOCIMIENTOS> y conviertete en un expero Exitoso	uploads/sliders/b1-img.jpg	/conocenos/	Conóce Más
3	t	2017-02-22 18:50:52.864567-05	2017-02-22 19:03:17.363651-05	0	0	3	<POTENCIA TUS CONOCIMIENTOS> y conviertete en un expero Exitoso	uploads/sliders/b1-img.jpg	/conocenos/	Conóce Más
\.


--
-- Name: web_sliders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_sliders_id_seq', 3, true);


--
-- Name: web_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_staff_id_seq', 6, true);


--
-- Data for Name: web_translaterdicc; Type: TABLE DATA; Schema: public; Owner: ccapu
--

COPY web_translaterdicc (id, active, created, modified, created_by, modified_by, variable, nombre, nombre_es, nombre_en, nombre_pt) FROM stdin;
58	t	2017-02-21 15:55:17.568875-05	2017-02-21 15:55:17.568921-05	0	0	Escribe tu correo	Escribe tu correo	Escribe tu correo	\N	\N
1	t	2017-02-16 12:10:20.551757-05	2017-02-16 12:10:28.055773-05	0	0	Nombres	Nombres	Nombres	Nombres	Nombres
2	t	2017-02-21 10:47:17.014137-05	2017-02-21 10:47:17.014202-05	0	0	PORQUÉ ELEGIRNOS	PORQUÉ ELEGIRNOS	PORQUÉ ELEGIRNOS	\N	\N
3	t	2017-02-21 11:29:52.600233-05	2017-02-21 11:29:52.600321-05	0	0	COMO FUNCIONA	COMO FUNCIONA	COMO FUNCIONA	\N	\N
4	t	2017-02-21 11:29:52.614981-05	2017-02-21 11:29:52.615014-05	0	0	VER MÁS	VER MÁS	VER MÁS	\N	\N
5	t	2017-02-21 11:48:31.996815-05	2017-02-21 11:48:31.996888-05	0	0	MANTENTE</strong> INFORMADO	MANTENTE</strong> INFORMADO	MANTENTE</strong> INFORMADO	\N	\N
6	t	2017-02-21 11:54:20.856152-05	2017-02-21 11:54:20.856196-05	0	0	NUESTROS</strong> EVENTOS	NUESTROS</strong> EVENTOS	NUESTROS</strong> EVENTOS	\N	\N
7	t	2017-02-21 12:04:53.602879-05	2017-02-21 12:04:53.602942-05	0	0	¡suscribete ahora!<strong>e informate más	¡suscribete ahora!<strong>e informate más	¡suscribete ahora!<strong>e informate más	\N	\N
8	t	2017-02-21 12:04:53.614908-05	2017-02-21 12:04:53.614945-05	0	0	ENVIAR	ENVIAR	ENVIAR	\N	\N
9	t	2017-02-21 12:04:53.619437-05	2017-02-21 12:04:53.619476-05	0	0	Nuestros <strong>CLIENTES:	Nuestros <strong>CLIENTES:	Nuestros <strong>CLIENTES:	\N	\N
10	t	2017-02-21 12:04:53.627578-05	2017-02-21 12:04:53.627614-05	0	0	Nuestros alumnos<strong>PROVIENEN DE:	Nuestros alumnos<strong>PROVIENEN DE:	Nuestros alumnos<strong>PROVIENEN DE:	\N	\N
11	t	2017-02-21 14:41:32.709845-05	2017-02-21 14:41:32.709907-05	0	0	CONÓCENOS	CONÓCENOS	CONÓCENOS	\N	\N
12	t	2017-02-21 15:32:41.835377-05	2017-02-21 15:32:41.835431-05	0	0	Inicia Sesión	Inicia Sesión	Inicia Sesión	\N	\N
13	t	2017-02-21 15:32:41.84421-05	2017-02-21 15:32:41.84427-05	0	0	Registrate	Registrate	Registrate	\N	\N
14	t	2017-02-21 15:32:41.848913-05	2017-02-21 15:32:41.848954-05	0	0	Mi Carrito	Mi Carrito	Mi Carrito	\N	\N
15	t	2017-02-21 15:32:41.884476-05	2017-02-21 15:32:41.884512-05	0	0	Conócenos	Conócenos	Conócenos	\N	\N
16	t	2017-02-21 15:32:41.89019-05	2017-02-21 15:32:41.890353-05	0	0	Terminos y Condiciones	Terminos y Condiciones	Terminos y Condiciones	\N	\N
17	t	2017-02-21 15:32:41.896952-05	2017-02-21 15:32:41.896991-05	0	0	Preguntas Frecuentes	Preguntas Frecuentes	Preguntas Frecuentes	\N	\N
18	t	2017-02-21 15:32:41.902962-05	2017-02-21 15:32:41.902998-05	0	0	Noticias	Noticias	Noticias	\N	\N
19	t	2017-02-21 15:32:41.910856-05	2017-02-21 15:32:41.910923-05	0	0	Eventos	Eventos	Eventos	\N	\N
20	t	2017-02-21 15:32:41.916307-05	2017-02-21 15:32:41.916344-05	0	0	Contáctanos	Contáctanos	Contáctanos	\N	\N
21	t	2017-02-21 15:32:41.919784-05	2017-02-21 15:32:41.919818-05	0	0	Síguenos en:	Síguenos en:	Síguenos en:	\N	\N
22	t	2017-02-21 15:32:41.923757-05	2017-02-21 15:32:41.923795-05	0	0	IR A CAMPUS ONLINE	IR A CAMPUS ONLINE	IR A CAMPUS ONLINE	\N	\N
23	t	2017-02-21 15:42:36.351482-05	2017-02-21 15:42:36.351527-05	0	0	Quienes somos	Quienes somos	Quienes somos	\N	\N
24	t	2017-02-21 15:42:36.355143-05	2017-02-21 15:42:36.355175-05	0	0	Project Academy	Project Academy	Project Academy	\N	\N
25	t	2017-02-21 15:42:36.358473-05	2017-02-21 15:42:36.358508-05	0	0	Misión	Misión	Misión	\N	\N
26	t	2017-02-21 15:42:36.361869-05	2017-02-21 15:42:36.361904-05	0	0	Visión	Visión	Visión	\N	\N
27	t	2017-02-21 15:42:36.366021-05	2017-02-21 15:42:36.366057-05	0	0	por qué <strong>elegirnos	por qué <strong>elegirnos	por qué <strong>elegirnos	\N	\N
28	t	2017-02-21 15:43:51.779879-05	2017-02-21 15:43:51.779919-05	0	0	Contactanos	Contactanos	Contactanos	\N	\N
29	t	2017-02-21 15:46:42.85037-05	2017-02-21 15:46:42.850431-05	0	0	Apellidos	Apellidos	Apellidos	\N	\N
30	t	2017-02-21 15:46:42.857168-05	2017-02-21 15:46:42.857207-05	0	0	Correo Electrónico	Correo Electrónico	Correo Electrónico	\N	\N
31	t	2017-02-21 15:46:42.862195-05	2017-02-21 15:46:42.862278-05	0	0	Teléfono/Celular	Teléfono/Celular	Teléfono/Celular	\N	\N
32	t	2017-02-21 15:46:42.865951-05	2017-02-21 15:46:42.865987-05	0	0	Deja tu mensaje	Deja tu mensaje	Deja tu mensaje	\N	\N
33	t	2017-02-21 15:46:42.870092-05	2017-02-21 15:46:42.870125-05	0	0	Escríbenos	Escríbenos	Escríbenos	\N	\N
34	t	2017-02-21 15:46:42.876354-05	2017-02-21 15:46:42.876402-05	0	0	Llamanos	Llamanos	Llamanos	\N	\N
35	t	2017-02-21 15:55:17.434404-05	2017-02-21 15:55:17.434461-05	0	0	sobre nosostros	sobre nosostros	sobre nosostros	\N	\N
36	t	2017-02-21 15:55:17.454898-05	2017-02-21 15:55:17.454942-05	0	0	Siguenos en	Siguenos en	Siguenos en	\N	\N
37	t	2017-02-21 15:55:17.45882-05	2017-02-21 15:55:17.458855-05	0	0	Te Ofrecemos	Te Ofrecemos	Te Ofrecemos	\N	\N
38	t	2017-02-21 15:55:17.463267-05	2017-02-21 15:55:17.463302-05	0	0	Servicio al cliente	Servicio al cliente	Servicio al cliente	\N	\N
39	t	2017-02-21 15:55:17.467624-05	2017-02-21 15:55:17.467677-05	0	0	Terminos y condiciones	Terminos y condiciones	Terminos y condiciones	\N	\N
40	t	2017-02-21 15:55:17.472106-05	2017-02-21 15:55:17.472141-05	0	0	Libro de reclamaciones	Libro de reclamaciones	Libro de reclamaciones	\N	\N
41	t	2017-02-21 15:55:17.477219-05	2017-02-21 15:55:17.477256-05	0	0	Contacto	Contacto	Contacto	\N	\N
42	t	2017-02-21 15:55:17.481454-05	2017-02-21 15:55:17.481516-05	0	0	Mi cuenta	Mi cuenta	Mi cuenta	\N	\N
43	t	2017-02-21 15:55:17.489634-05	2017-02-21 15:55:17.489676-05	0	0	Olvidaste tu contraseña	Olvidaste tu contraseña	Olvidaste tu contraseña	\N	\N
44	t	2017-02-21 15:55:17.493723-05	2017-02-21 15:55:17.493759-05	0	0	Contactanos al:	Contactanos al:	Contactanos al:	\N	\N
45	t	2017-02-21 15:55:17.498731-05	2017-02-21 15:55:17.498768-05	0	0	Metodos de pago	Metodos de pago	Metodos de pago	\N	\N
46	t	2017-02-21 15:55:17.503765-05	2017-02-21 15:55:17.503811-05	0	0	Todos los Derechos Reservados	Todos los Derechos Reservados	Todos los Derechos Reservados	\N	\N
47	t	2017-02-21 15:55:17.508881-05	2017-02-21 15:55:17.508917-05	0	0	Diseño Página Web	Diseño Página Web	Diseño Página Web	\N	\N
48	t	2017-02-21 15:55:17.516976-05	2017-02-21 15:55:17.517031-05	0	0	¡Registrate</strong> ahora!	¡Registrate</strong> ahora!	¡Registrate</strong> ahora!	\N	\N
49	t	2017-02-21 15:55:17.522556-05	2017-02-21 15:55:17.52262-05	0	0	¡Si no tienes una cuenta registrate y empieza ya.	¡Si no tienes una cuenta registrate y empieza ya.	¡Si no tienes una cuenta registrate y empieza ya.	\N	\N
50	t	2017-02-21 15:55:17.526703-05	2017-02-21 15:55:17.526737-05	0	0	Nombre	Nombre	Nombre	\N	\N
51	t	2017-02-21 15:55:17.530737-05	2017-02-21 15:55:17.530777-05	0	0	Telefono / Celular	Telefono / Celular	Telefono / Celular	\N	\N
52	t	2017-02-21 15:55:17.536947-05	2017-02-21 15:55:17.536993-05	0	0	Correo Electónico	Correo Electónico	Correo Electónico	\N	\N
53	t	2017-02-21 15:55:17.544583-05	2017-02-21 15:55:17.544631-05	0	0	Nueva Contraseña	Nueva Contraseña	Nueva Contraseña	\N	\N
54	t	2017-02-21 15:55:17.548041-05	2017-02-21 15:55:17.548079-05	0	0	Repetir Contraseña	Repetir Contraseña	Repetir Contraseña	\N	\N
55	t	2017-02-21 15:55:17.552461-05	2017-02-21 15:55:17.552503-05	0	0	Iniciar Sesión	Iniciar Sesión	Iniciar Sesión	\N	\N
56	t	2017-02-21 15:55:17.557102-05	2017-02-21 15:55:17.557137-05	0	0	Olvidaste tu</strong> contraseña	Olvidaste tu</strong> contraseña	Olvidaste tu</strong> contraseña	\N	\N
57	t	2017-02-21 15:55:17.563342-05	2017-02-21 15:55:17.563387-05	0	0	Escribe tu dirección de correo electrónico.<br>Le enviaremos un enlace para que pueda cambiar su contraseña.	Escribe tu dirección de correo electrónico.<br>Le enviaremos un enlace para que pueda cambiar su contraseña.	Escribe tu dirección de correo electrónico.<br>Le enviaremos un enlace para que pueda cambiar su contraseña.	\N	\N
59	t	2017-02-21 15:55:17.575279-05	2017-02-21 15:55:17.575332-05	0	0	Enviar	Enviar	Enviar	\N	\N
60	t	2017-02-21 18:17:26.899469-05	2017-02-21 18:17:26.899515-05	0	0	Modalidad	Modalidad	Modalidad	\N	\N
61	t	2017-02-21 18:17:26.912157-05	2017-02-21 18:17:26.912195-05	0	0	Idioma	Idioma	Idioma	\N	\N
62	t	2017-02-21 18:17:26.917155-05	2017-02-21 18:17:26.917199-05	0	0	Rubro	Rubro	Rubro	\N	\N
63	t	2017-02-21 18:17:26.92285-05	2017-02-21 18:17:26.922907-05	0	0	Descripción	Descripción	Descripción	\N	\N
64	t	2017-02-21 18:17:26.928191-05	2017-02-21 18:17:26.928225-05	0	0	DETALLES Y MODALIDADES:	DETALLES Y MODALIDADES:	DETALLES Y MODALIDADES:	\N	\N
65	t	2017-02-21 18:17:26.932588-05	2017-02-21 18:17:26.932626-05	0	0	Fechas:	Fechas:	Fechas:	\N	\N
66	t	2017-02-21 18:17:26.937496-05	2017-02-21 18:17:26.937538-05	0	0	Horarios:	Horarios:	Horarios:	\N	\N
67	t	2017-02-21 18:17:26.944554-05	2017-02-21 18:17:26.944602-05	0	0	Lugar:	Lugar:	Lugar:	\N	\N
68	t	2017-02-21 18:17:26.949883-05	2017-02-21 18:17:26.949921-05	0	0	Inversión:	Inversión:	Inversión:	\N	\N
69	t	2017-02-21 18:17:26.953827-05	2017-02-21 18:17:26.953864-05	0	0	contáctanos	contáctanos	contáctanos	\N	\N
70	t	2017-02-21 18:17:26.957649-05	2017-02-21 18:17:26.957676-05	0	0	comprar curso	comprar curso	comprar curso	\N	\N
71	t	2017-02-21 18:17:26.960537-05	2017-02-21 18:17:26.960569-05	0	0	metodología	metodología	metodología	\N	\N
72	t	2017-02-21 18:17:26.966015-05	2017-02-21 18:17:26.966068-05	0	0	contenidos	contenidos	contenidos	\N	\N
73	t	2017-02-21 18:17:26.970654-05	2017-02-21 18:17:26.9707-05	0	0	docentes	docentes	docentes	\N	\N
74	t	2017-02-21 18:17:26.975968-05	2017-02-21 18:17:26.976012-05	0	0	beneficios	beneficios	beneficios	\N	\N
75	t	2017-02-21 18:17:26.979971-05	2017-02-21 18:17:26.980008-05	0	0	inversión	inversión	inversión	\N	\N
76	t	2017-02-21 18:51:57.931865-05	2017-02-21 18:51:57.931928-05	0	0	metología	metología	metología	\N	\N
77	t	2017-02-21 18:51:57.941762-05	2017-02-21 18:51:57.941807-05	0	0	NUESTRO <strong>CONTENIDO DETALLADO :	NUESTRO <strong>CONTENIDO DETALLADO :	NUESTRO <strong>CONTENIDO DETALLADO :	\N	\N
78	t	2017-02-21 18:51:57.949151-05	2017-02-21 18:51:57.949212-05	0	0	contenido	contenido	contenido	\N	\N
79	t	2017-02-21 18:51:57.956695-05	2017-02-21 18:51:57.956738-05	0	0	CONÓCE NUESTROS <strong>BENEFICIOS	CONÓCE NUESTROS <strong>BENEFICIOS	CONÓCE NUESTROS <strong>BENEFICIOS	\N	\N
80	t	2017-02-21 18:51:57.962804-05	2017-02-21 18:51:57.962854-05	0	0	objetivo	objetivo	objetivo	\N	\N
81	t	2017-02-21 18:51:57.968942-05	2017-02-21 18:51:57.96898-05	0	0	CONÓCE LA <strong>INVERSIÓN	CONÓCE LA <strong>INVERSIÓN	CONÓCE LA <strong>INVERSIÓN	\N	\N
82	t	2017-02-21 18:51:57.973094-05	2017-02-21 18:51:57.973131-05	0	0	Inversión	Inversión	Inversión	\N	\N
83	t	2017-02-21 18:51:57.977217-05	2017-02-21 18:51:57.977267-05	0	0	SOLICITA INFORMACIÓN	SOLICITA INFORMACIÓN	SOLICITA INFORMACIÓN	\N	\N
84	t	2017-02-21 18:51:57.981636-05	2017-02-21 18:51:57.98168-05	0	0	Para más información llena tus datos y nos estaremos comunicando contigo<br> a la brevedad.	Para más información llena tus datos y nos estaremos comunicando contigo<br> a la brevedad.	Para más información llena tus datos y nos estaremos comunicando contigo<br> a la brevedad.	\N	\N
85	t	2017-02-21 18:52:33.339052-05	2017-02-21 18:52:33.339094-05	0	0	Correo	Correo	Correo	\N	\N
86	t	2017-02-21 18:52:33.351418-05	2017-02-21 18:52:33.351466-05	0	0	Empresa	Empresa	Empresa	\N	\N
87	t	2017-02-21 18:52:33.355838-05	2017-02-21 18:52:33.355888-05	0	0	Ciudad	Ciudad	Ciudad	\N	\N
88	t	2017-02-21 18:52:33.36047-05	2017-02-21 18:52:33.360511-05	0	0	Deje su duda aqui:	Deje su duda aqui:	Deje su duda aqui:	\N	\N
89	t	2017-02-21 18:52:33.364134-05	2017-02-21 18:52:33.364169-05	0	0	Acepto Las condiciones de tratamiento para mis datos personales	Acepto Las condiciones de tratamiento para mis datos personales	Acepto Las condiciones de tratamiento para mis datos personales	\N	\N
90	t	2017-02-21 18:52:49.288133-05	2017-02-21 18:52:49.288179-05	0	0	Pais	Pais	Pais	\N	\N
91	t	2017-02-22 11:47:20.894802-05	2017-02-22 11:47:20.894846-05	0	0	INFORMACIÓN DE PAGO	INFORMACIÓN DE PAGO	\N	\N	INFORMACIÓN DE PAGO
95	t	2017-02-22 11:47:20.921674-05	2017-02-22 11:53:18.118808-05	0	0	MEDIO DE PAGO:	MEDIO DE PAGO:	MEDIO DE PAGO:	MEDIO DE PAGO:	MEDIO DE PAGO:
96	t	2017-02-22 11:47:20.925974-05	2017-02-22 11:53:18.123926-05	0	0	Nombres:	Nombres:	Nombres:	Nombres:	Nombres:
97	t	2017-02-22 11:47:20.929312-05	2017-02-22 11:53:18.128634-05	0	0	Apellidos:	Apellidos:	Apellidos:	Apellidos:	Apellidos:
98	t	2017-02-22 11:47:20.934823-05	2017-02-22 11:53:18.13387-05	0	0	Correo Electónico:	Correo Electónico:	Correo Electónico:	Correo Electónico:	Correo Electónico:
100	t	2017-02-22 11:47:20.944444-05	2017-02-22 11:53:18.144265-05	0	0	Tipo de documento:	Tipo de documento:	Tipo de documento:	Tipo de documento:	Tipo de documento:
101	t	2017-02-22 11:47:20.94875-05	2017-02-22 11:53:18.149763-05	0	0	DNI	DNI	DNI	DNI	DNI
102	t	2017-02-22 11:47:20.953503-05	2017-02-22 11:53:18.154594-05	0	0	Pasaporte	Pasaporte	Pasaporte	Pasaporte	Pasaporte
103	t	2017-02-22 11:47:20.957854-05	2017-02-22 11:53:18.159852-05	0	0	Licencia	Licencia	Licencia	Licencia	Licencia
104	t	2017-02-22 11:47:20.961112-05	2017-02-22 11:53:18.165088-05	0	0	Libreta	Libreta	Libreta	Libreta	Libreta
105	t	2017-02-22 11:47:20.964777-05	2017-02-22 11:53:18.170267-05	0	0	Número de Documento:	Número de Documento:	Número de Documento:	Número de Documento:	Número de Documento:
106	t	2017-02-22 11:47:20.970969-05	2017-02-22 11:53:18.176533-05	0	0	País:	País:	País:	País:	País:
107	t	2017-02-22 11:47:20.976283-05	2017-02-22 11:53:18.182666-05	0	0	DESEO FACTURA	DESEO FACTURA	DESEO FACTURA	DESEO FACTURA	DESEO FACTURA
108	t	2017-02-22 11:47:20.980006-05	2017-02-22 11:53:18.188885-05	0	0	RAZÓN SOCIAL:	RAZÓN SOCIAL:	RAZÓN SOCIAL:	RAZÓN SOCIAL:	RAZÓN SOCIAL:
109	t	2017-02-22 11:47:20.983842-05	2017-02-22 11:53:18.19562-05	0	0	RUC:	RUC:	RUC:	RUC:	RUC:
110	t	2017-02-22 11:47:20.98831-05	2017-02-22 11:53:18.200226-05	0	0	SELECCIONE SU MÉTODO DE PAGO:	SELECCIONE SU MÉTODO DE PAGO:	SELECCIONE SU MÉTODO DE PAGO:	SELECCIONE SU MÉTODO DE PAGO:	SELECCIONE SU MÉTODO DE PAGO:
111	t	2017-02-22 11:47:20.992778-05	2017-02-22 11:53:18.205137-05	0	0	Acepto los <a>Terminos y condiciones</a>, declarados por EPCM Project Academy	Acepto los <a>Terminos y condiciones</a>, declarados por EPCM Project Academy	Acepto los <a>Terminos y condiciones</a>, declarados por EPCM Project Academy	Acepto los <a>Terminos y condiciones</a>, declarados por EPCM Project Academy	Acepto los <a>Terminos y condiciones</a>, declarados por EPCM Project Academy
113	t	2017-02-22 11:51:46.206805-05	2017-02-22 11:53:18.212913-05	0	0	COMPRAR	COMPRAR	COMPRAR	COMPRAR	COMPRAR
114	t	2017-02-22 16:22:38.782829-05	2017-02-22 16:22:38.78289-05	0	0	Compartir en:	Compartir en:	Compartir en:	\N	\N
115	t	2017-02-22 16:25:44.638139-05	2017-02-22 16:25:44.638178-05	0	0	NUESTROS EVENTOS	NUESTROS EVENTOS	NUESTROS EVENTOS	\N	\N
116	t	2017-02-22 16:51:25.118869-05	2017-02-22 16:51:25.118908-05	0	0	LEER MÁS	LEER MÁS	LEER MÁS	\N	\N
117	t	2017-02-22 16:51:25.138808-05	2017-02-22 16:51:25.138847-05	0	0	< Ant.	< Ant.	< Ant.	\N	\N
118	t	2017-02-22 16:51:25.144418-05	2017-02-22 16:51:25.14446-05	0	0	Sig. >	Sig. >	Sig. >	\N	\N
112	t	2017-02-22 11:51:46.178426-05	2017-02-22 11:53:18.082422-05	0	0	INFORMACIÓN DE COMPRA	INFORMACIÓN DE COMPRA	INFORMACIÓN DE COMPRA	INFORMACIÓN DE COMPRA	INFORMACIÓN DE COMPRA
92	t	2017-02-22 11:47:20.907263-05	2017-02-22 11:53:18.102072-05	0	0	DATO <strong>DE PAGO	DATO <strong>DE PAGO	DATO <strong>DE PAGO	DATO <strong>DE PAGO	DATO <strong>DE PAGO
93	t	2017-02-22 11:47:20.911793-05	2017-02-22 11:53:18.107864-05	0	0	CUSOS ELEGIDOS	CUSOS ELEGIDOS	CUSOS ELEGIDOS	CUSOS ELEGIDOS	CUSOS ELEGIDOS
94	t	2017-02-22 11:47:20.91611-05	2017-02-22 11:53:18.113364-05	0	0	DATOS PAGO	DATOS PAGO	DATOS PAGO	DATOS PAGO	DATOS PAGO
99	t	2017-02-22 11:47:20.939666-05	2017-02-22 11:53:18.139611-05	0	0	Teléfono / Celular:	Teléfono / Celular:	Teléfono / Celular:	Teléfono / Celular:	Teléfono / Celular:
119	t	2017-02-22 16:54:57.598211-05	2017-02-22 16:54:57.598246-05	0	0	Regresar	Regresar	Regresar	\N	\N
120	t	2017-02-22 18:15:40.815715-05	2017-02-22 18:15:40.815761-05	0	0	Identificación del </strong>consumidor reclamante	Identificación del </strong>consumidor reclamante	Identificación del </strong>consumidor reclamante	\N	\N
121	t	2017-02-22 18:15:40.836982-05	2017-02-22 18:15:40.837032-05	0	0	Teléfono/Celular:	Teléfono/Celular:	Teléfono/Celular:	\N	\N
122	t	2017-02-22 18:15:40.845999-05	2017-02-22 18:15:40.846041-05	0	0	DOCUMENTO	DOCUMENTO	DOCUMENTO	\N	\N
123	t	2017-02-22 18:15:40.870516-05	2017-02-22 18:15:40.870557-05	0	0	Número de documento:	Número de documento:	Número de documento:	\N	\N
124	t	2017-02-22 18:15:40.874396-05	2017-02-22 18:15:40.874429-05	0	0	Identificación del </strong>bien contratado	Identificación del </strong>bien contratado	Identificación del </strong>bien contratado	\N	\N
125	t	2017-02-22 18:15:40.878061-05	2017-02-22 18:15:40.878094-05	0	0	Tipo:	Tipo:	Tipo:	\N	\N
126	t	2017-02-22 18:15:40.881425-05	2017-02-22 18:15:40.88146-05	0	0	Monto de reclamo:	Monto de reclamo:	Monto de reclamo:	\N	\N
127	t	2017-02-22 18:15:40.884896-05	2017-02-22 18:15:40.884928-05	0	0	Descripción:	Descripción:	Descripción:	\N	\N
128	t	2017-02-22 18:15:40.88881-05	2017-02-22 18:15:40.888856-05	0	0	Limpiar	Limpiar	Limpiar	\N	\N
129	t	2017-02-22 18:44:34.479681-05	2017-02-22 18:44:34.479739-05	0	0	Ver más.	Ver más.	Ver más.	\N	\N
130	t	2017-02-22 20:15:45.550372-05	2017-02-22 20:19:46.430521-05	0	0	programas <strong>dirigidos a:	programas <strong>dirigidos a:	programas <strong>dirigidos a:	\N	programas <strong>dirigidos a:
131	t	2017-02-22 20:15:45.556514-05	2017-02-22 20:19:46.440283-05	0	0	Filtrar	Filtrar	Filtrar	\N	Filtrar
132	t	2017-02-22 20:15:45.561526-05	2017-02-22 20:19:46.451122-05	0	0	Filtrar por:	Filtrar por:	Filtrar por:	\N	Filtrar por:
133	t	2017-02-22 20:15:45.568945-05	2017-02-22 20:19:46.462653-05	0	0	Idiomas	Idiomas	Idiomas	\N	Idiomas
134	t	2017-02-22 20:15:45.5728-05	2017-02-22 20:19:46.470253-05	0	0	Portugues	Portugues	Portugues	\N	Portugues
135	t	2017-02-22 20:15:45.577472-05	2017-02-22 20:19:46.477865-05	0	0	Español	Español	Español	\N	Español
136	t	2017-02-22 20:15:45.582274-05	2017-02-22 20:19:46.485876-05	0	0	Aleman	Aleman	Aleman	\N	Aleman
137	t	2017-02-22 20:15:45.589212-05	2017-02-22 20:19:46.509329-05	0	0	conóce todos <strong>nuestros programas	conóce todos <strong>nuestros programas	conóce todos <strong>nuestros programas	\N	conóce todos <strong>nuestros programas
138	t	2017-02-23 15:39:20.986162-05	2017-02-23 15:39:20.986204-05	0	0	Inicio:	Inicio:	Inicio:	\N	\N
139	t	2017-02-23 15:39:20.993749-05	2017-02-23 15:39:20.993848-05	0	0	Nuevo	Nuevo	Nuevo	\N	\N
140	t	2017-02-23 16:32:24.172249-05	2017-02-23 16:32:24.172343-05	0	0	ellos opinan	ellos opinan	ellos opinan	\N	\N
141	t	2017-02-23 16:35:19.223482-05	2017-02-23 16:35:19.223564-05	0	0	Sígueme en:	Sígueme en:	Sígueme en:	\N	\N
142	t	2017-02-23 18:52:01.819449-05	2017-02-23 18:52:01.819518-05	0	0	Inicio	Inicio	Inicio	\N	\N
\.


--
-- Name: web_translaterdicc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ccapu
--

SELECT pg_catalog.setval('web_translaterdicc_id_seq', 142, true);


--
-- Name: admin_honeypot_loginattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY admin_honeypot_loginattempt
    ADD CONSTRAINT admin_honeypot_loginattempt_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: cache_table_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cache_table
    ADD CONSTRAINT cache_table_pkey PRIMARY KEY (cache_key);


--
-- Name: cursos_beneficios_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_beneficios
    ADD CONSTRAINT cursos_beneficios_pkey PRIMARY KEY (id);


--
-- Name: cursos_contenidos_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_contenidos
    ADD CONSTRAINT cursos_contenidos_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursos_idiomas_cursos_id_idiomas_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_idiomas
    ADD CONSTRAINT cursos_cursos_idiomas_cursos_id_idiomas_id_key UNIQUE (cursos_id, idiomas_id);


--
-- Name: cursos_cursos_idiomas_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_idiomas
    ADD CONSTRAINT cursos_cursos_idiomas_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos
    ADD CONSTRAINT cursos_cursos_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursos_rubro_cursos_id_rubros_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_rubro
    ADD CONSTRAINT cursos_cursos_rubro_cursos_id_rubros_id_key UNIQUE (cursos_id, rubros_id);


--
-- Name: cursos_cursos_rubro_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_rubro
    ADD CONSTRAINT cursos_cursos_rubro_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursoscategorias_idiom_cursoscategorias_id_idiomas_i_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_idiomas
    ADD CONSTRAINT cursos_cursoscategorias_idiom_cursoscategorias_id_idiomas_i_key UNIQUE (cursoscategorias_id, idiomas_id);


--
-- Name: cursos_cursoscategorias_idiomas_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_idiomas
    ADD CONSTRAINT cursos_cursoscategorias_idiomas_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursoscategorias_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias
    ADD CONSTRAINT cursos_cursoscategorias_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursoscategorias_rubro_cursoscategorias_id_rubros_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_rubros
    ADD CONSTRAINT cursos_cursoscategorias_rubro_cursoscategorias_id_rubros_id_key UNIQUE (cursoscategorias_id, rubros_id);


--
-- Name: cursos_cursoscategorias_rubro_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_rubros
    ADD CONSTRAINT cursos_cursoscategorias_rubro_pkey PRIMARY KEY (id);


--
-- Name: cursos_cursosdeinteres_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursosdeinteres
    ADD CONSTRAINT cursos_cursosdeinteres_pkey PRIMARY KEY (id);


--
-- Name: cursos_idiomas_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_idiomas
    ADD CONSTRAINT cursos_idiomas_pkey PRIMARY KEY (id);


--
-- Name: cursos_profesores_cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores_cursos
    ADD CONSTRAINT cursos_profesores_cursos_pkey PRIMARY KEY (id);


--
-- Name: cursos_profesores_cursos_profesores_id_cursos_id_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores_cursos
    ADD CONSTRAINT cursos_profesores_cursos_profesores_id_cursos_id_key UNIQUE (profesores_id, cursos_id);


--
-- Name: cursos_profesores_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores
    ADD CONSTRAINT cursos_profesores_pkey PRIMARY KEY (id);


--
-- Name: cursos_rubros_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_rubros
    ADD CONSTRAINT cursos_rubros_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: eventos_noticias_eventossociales_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_eventossociales
    ADD CONSTRAINT eventos_noticias_eventossociales_pkey PRIMARY KEY (id);


--
-- Name: eventos_noticias_homeeventosseccion_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_homeeventosseccion
    ADD CONSTRAINT eventos_noticias_homeeventosseccion_pkey PRIMARY KEY (id);


--
-- Name: eventos_noticias_homenoticiasseccion_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_homenoticiasseccion
    ADD CONSTRAINT eventos_noticias_homenoticiasseccion_pkey PRIMARY KEY (id);


--
-- Name: eventos_noticias_noticias_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY eventos_noticias_noticias
    ADD CONSTRAINT eventos_noticias_noticias_pkey PRIMARY KEY (id);


--
-- Name: formularios_contacto_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_contacto
    ADD CONSTRAINT formularios_contacto_pkey PRIMARY KEY (id);


--
-- Name: formularios_contactotrabajo_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_contactotrabajo
    ADD CONSTRAINT formularios_contactotrabajo_pkey PRIMARY KEY (id);


--
-- Name: formularios_destinatarios_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_destinatarios
    ADD CONSTRAINT formularios_destinatarios_pkey PRIMARY KEY (id);


--
-- Name: formularios_socioscontacto_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_socioscontacto
    ADD CONSTRAINT formularios_socioscontacto_pkey PRIMARY KEY (id);


--
-- Name: formularios_suscript_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY formularios_suscript
    ADD CONSTRAINT formularios_suscript_pkey PRIMARY KEY (id);


--
-- Name: seo_infoseo_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_infoseo
    ADD CONSTRAINT seo_infoseo_pkey PRIMARY KEY (id);


--
-- Name: seo_seoredirects_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_seoredirects
    ADD CONSTRAINT seo_seoredirects_pkey PRIMARY KEY (id);


--
-- Name: seo_seoredirects_url_in_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_seoredirects
    ADD CONSTRAINT seo_seoredirects_url_in_key UNIQUE (url_in);


--
-- Name: seo_seotags_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_seotags
    ADD CONSTRAINT seo_seotags_pkey PRIMARY KEY (id);


--
-- Name: seo_seotags_url_seo_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_seotags
    ADD CONSTRAINT seo_seotags_url_seo_key UNIQUE (url_seo);


--
-- Name: seo_urlregister_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_urlregister
    ADD CONSTRAINT seo_urlregister_pkey PRIMARY KEY (id);


--
-- Name: seo_urlregister_url_key; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY seo_urlregister
    ADD CONSTRAINT seo_urlregister_url_key UNIQUE (url);


--
-- Name: terminos_preguntas_quest_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_quest
    ADD CONSTRAINT terminos_preguntas_quest_pkey PRIMARY KEY (id);


--
-- Name: terminos_preguntas_questseccion_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_questseccion
    ADD CONSTRAINT terminos_preguntas_questseccion_pkey PRIMARY KEY (id);


--
-- Name: terminos_preguntas_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_terms
    ADD CONSTRAINT terminos_preguntas_terms_pkey PRIMARY KEY (id);


--
-- Name: terminos_preguntas_termsseccion_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY terminos_preguntas_termsseccion
    ADD CONSTRAINT terminos_preguntas_termsseccion_pkey PRIMARY KEY (id);


--
-- Name: web_clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_clientes
    ADD CONSTRAINT web_clientes_pkey PRIMARY KEY (id);


--
-- Name: web_conocenos_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_conocenos
    ADD CONSTRAINT web_conocenos_pkey PRIMARY KEY (id);


--
-- Name: web_contactoseccion_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_contactoseccion
    ADD CONSTRAINT web_contactoseccion_pkey PRIMARY KEY (id);


--
-- Name: web_infosite_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_infosite
    ADD CONSTRAINT web_infosite_pkey PRIMARY KEY (id);


--
-- Name: web_libroseccion_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_libroseccion
    ADD CONSTRAINT web_libroseccion_pkey PRIMARY KEY (id);


--
-- Name: web_paises_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_paises
    ADD CONSTRAINT web_paises_pkey PRIMARY KEY (id);


--
-- Name: web_porqueelegirnos_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_porqueelegirnos
    ADD CONSTRAINT web_porqueelegirnos_pkey PRIMARY KEY (id);


--
-- Name: web_respaldos_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_respaldos
    ADD CONSTRAINT web_respaldos_pkey PRIMARY KEY (id);


--
-- Name: web_sliders_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_sliders
    ADD CONSTRAINT web_sliders_pkey PRIMARY KEY (id);


--
-- Name: web_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_ellosopinan
    ADD CONSTRAINT web_staff_pkey PRIMARY KEY (id);


--
-- Name: web_translaterdicc_pkey; Type: CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY web_translaterdicc
    ADD CONSTRAINT web_translaterdicc_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_253ae2a6331666e8_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_group_name_253ae2a6331666e8_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_51b3b110094b8aae_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX auth_user_username_51b3b110094b8aae_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: cache_table_expires; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cache_table_expires ON cache_table USING btree (expires);


--
-- Name: cursos_beneficios_6f899f0d; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_beneficios_6f899f0d ON cursos_beneficios USING btree (curso_id);


--
-- Name: cursos_contenidos_6f899f0d; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_contenidos_6f899f0d ON cursos_contenidos USING btree (curso_id);


--
-- Name: cursos_cursos_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_2dbcba41 ON cursos_cursos USING btree (slug);


--
-- Name: cursos_cursos_daf3833b; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_daf3833b ON cursos_cursos USING btree (categoria_id);


--
-- Name: cursos_cursos_idiomas_14fd2b6c; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_idiomas_14fd2b6c ON cursos_cursos_idiomas USING btree (idiomas_id);


--
-- Name: cursos_cursos_idiomas_a4c10983; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_idiomas_a4c10983 ON cursos_cursos_idiomas USING btree (cursos_id);


--
-- Name: cursos_cursos_rubro_4ff760eb; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_rubro_4ff760eb ON cursos_cursos_rubro USING btree (rubros_id);


--
-- Name: cursos_cursos_rubro_a4c10983; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_rubro_a4c10983 ON cursos_cursos_rubro USING btree (cursos_id);


--
-- Name: cursos_cursos_slug_2fb848bdeae3ccc_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursos_slug_2fb848bdeae3ccc_like ON cursos_cursos USING btree (slug varchar_pattern_ops);


--
-- Name: cursos_cursoscategorias_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursoscategorias_2dbcba41 ON cursos_cursoscategorias USING btree (slug);


--
-- Name: cursos_cursoscategorias_idiomas_14fd2b6c; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursoscategorias_idiomas_14fd2b6c ON cursos_cursoscategorias_idiomas USING btree (idiomas_id);


--
-- Name: cursos_cursoscategorias_idiomas_32456a21; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursoscategorias_idiomas_32456a21 ON cursos_cursoscategorias_idiomas USING btree (cursoscategorias_id);


--
-- Name: cursos_cursoscategorias_rubro_32456a21; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursoscategorias_rubro_32456a21 ON cursos_cursoscategorias_rubros USING btree (cursoscategorias_id);


--
-- Name: cursos_cursoscategorias_rubro_4ff760eb; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursoscategorias_rubro_4ff760eb ON cursos_cursoscategorias_rubros USING btree (rubros_id);


--
-- Name: cursos_cursoscategorias_slug_53a98c9ec3ae494e_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_cursoscategorias_slug_53a98c9ec3ae494e_like ON cursos_cursoscategorias USING btree (slug varchar_pattern_ops);


--
-- Name: cursos_idiomas_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_idiomas_2dbcba41 ON cursos_idiomas USING btree (slug);


--
-- Name: cursos_idiomas_slug_216bf822542fea98_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_idiomas_slug_216bf822542fea98_like ON cursos_idiomas USING btree (slug varchar_pattern_ops);


--
-- Name: cursos_profesores_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_profesores_2dbcba41 ON cursos_profesores USING btree (slug);


--
-- Name: cursos_profesores_cursos_9bdf454a; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_profesores_cursos_9bdf454a ON cursos_profesores_cursos USING btree (profesores_id);


--
-- Name: cursos_profesores_cursos_a4c10983; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_profesores_cursos_a4c10983 ON cursos_profesores_cursos USING btree (cursos_id);


--
-- Name: cursos_profesores_slug_662aa8562c4f1ec7_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_profesores_slug_662aa8562c4f1ec7_like ON cursos_profesores USING btree (slug varchar_pattern_ops);


--
-- Name: cursos_rubros_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_rubros_2dbcba41 ON cursos_rubros USING btree (slug);


--
-- Name: cursos_rubros_slug_1eb6db4af33c54c6_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX cursos_rubros_slug_1eb6db4af33c54c6_like ON cursos_rubros USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_461cfeaa630ca218_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: eventos_noticias_eventossociales_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX eventos_noticias_eventossociales_2dbcba41 ON eventos_noticias_eventossociales USING btree (slug);


--
-- Name: eventos_noticias_eventossociales_slug_299747e3777887e3_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX eventos_noticias_eventossociales_slug_299747e3777887e3_like ON eventos_noticias_eventossociales USING btree (slug varchar_pattern_ops);


--
-- Name: eventos_noticias_noticias_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX eventos_noticias_noticias_2dbcba41 ON eventos_noticias_noticias USING btree (slug);


--
-- Name: eventos_noticias_noticias_slug_39ea992850d580cf_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX eventos_noticias_noticias_slug_39ea992850d580cf_like ON eventos_noticias_noticias USING btree (slug varchar_pattern_ops);


--
-- Name: seo_seoredirects_url_in_122c442dc528ccc_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX seo_seoredirects_url_in_122c442dc528ccc_like ON seo_seoredirects USING btree (url_in varchar_pattern_ops);


--
-- Name: seo_seotags_url_seo_5f412a81758297c4_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX seo_seotags_url_seo_5f412a81758297c4_like ON seo_seotags USING btree (url_seo varchar_pattern_ops);


--
-- Name: seo_urlregister_url_eb3b6306e8f6646_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX seo_urlregister_url_eb3b6306e8f6646_like ON seo_urlregister USING btree (url varchar_pattern_ops);


--
-- Name: terminos_preguntas_quest_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX terminos_preguntas_quest_2dbcba41 ON terminos_preguntas_quest USING btree (slug);


--
-- Name: terminos_preguntas_quest_slug_2dc183886aeb40da_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX terminos_preguntas_quest_slug_2dc183886aeb40da_like ON terminos_preguntas_quest USING btree (slug varchar_pattern_ops);


--
-- Name: terminos_preguntas_terms_2dbcba41; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX terminos_preguntas_terms_2dbcba41 ON terminos_preguntas_terms USING btree (slug);


--
-- Name: terminos_preguntas_terms_slug_6a0808fda6e12533_like; Type: INDEX; Schema: public; Owner: ccapu
--

CREATE INDEX terminos_preguntas_terms_slug_6a0808fda6e12533_like ON terminos_preguntas_terms USING btree (slug varchar_pattern_ops);


--
-- Name: D396224057864db9ec0d532efbb3b052; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_idiomas
    ADD CONSTRAINT "D396224057864db9ec0d532efbb3b052" FOREIGN KEY (cursoscategorias_id) REFERENCES cursos_cursoscategorias(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cur_categoria_id_364e8bdbb9fbcad6_fk_cursos_cursoscategorias_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos
    ADD CONSTRAINT cur_categoria_id_364e8bdbb9fbcad6_fk_cursos_cursoscategorias_id FOREIGN KEY (categoria_id) REFERENCES cursos_cursoscategorias(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_beneficios_curso_id_f520239702e51c1_fk_cursos_cursos_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_beneficios
    ADD CONSTRAINT cursos_beneficios_curso_id_f520239702e51c1_fk_cursos_cursos_id FOREIGN KEY (curso_id) REFERENCES cursos_cursos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_contenidos_curso_id_58946bf0f2dac63c_fk_cursos_cursos_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_contenidos
    ADD CONSTRAINT cursos_contenidos_curso_id_58946bf0f2dac63c_fk_cursos_cursos_id FOREIGN KEY (curso_id) REFERENCES cursos_cursos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_cursos_i_idiomas_id_349f74e926ba0fc_fk_cursos_idiomas_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_idiomas
    ADD CONSTRAINT cursos_cursos_i_idiomas_id_349f74e926ba0fc_fk_cursos_idiomas_id FOREIGN KEY (idiomas_id) REFERENCES cursos_idiomas(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_cursos_id_cursos_id_40d6519e16ccb2e2_fk_cursos_cursos_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_idiomas
    ADD CONSTRAINT cursos_cursos_id_cursos_id_40d6519e16ccb2e2_fk_cursos_cursos_id FOREIGN KEY (cursos_id) REFERENCES cursos_cursos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_cursos_ru_cursos_id_55ba6430a270b842_fk_cursos_cursos_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_rubro
    ADD CONSTRAINT cursos_cursos_ru_cursos_id_55ba6430a270b842_fk_cursos_cursos_id FOREIGN KEY (cursos_id) REFERENCES cursos_cursos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_cursos_ru_rubros_id_75e9b892d3f2a8ac_fk_cursos_rubros_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursos_rubro
    ADD CONSTRAINT cursos_cursos_ru_rubros_id_75e9b892d3f2a8ac_fk_cursos_rubros_id FOREIGN KEY (rubros_id) REFERENCES cursos_rubros(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_cursosc_idiomas_id_1a3eff9b2746c686_fk_cursos_idiomas_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_idiomas
    ADD CONSTRAINT cursos_cursosc_idiomas_id_1a3eff9b2746c686_fk_cursos_idiomas_id FOREIGN KEY (idiomas_id) REFERENCES cursos_idiomas(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_cursoscat_rubros_id_6965d8f96a9ed6a2_fk_cursos_rubros_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_rubros
    ADD CONSTRAINT cursos_cursoscat_rubros_id_6965d8f96a9ed6a2_fk_cursos_rubros_id FOREIGN KEY (rubros_id) REFERENCES cursos_rubros(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_p_profesores_id_31d789be42fdb962_fk_cursos_profesores_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores_cursos
    ADD CONSTRAINT cursos_p_profesores_id_31d789be42fdb962_fk_cursos_profesores_id FOREIGN KEY (profesores_id) REFERENCES cursos_profesores(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cursos_profesore_cursos_id_220295321e28a3b9_fk_cursos_cursos_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_profesores_cursos
    ADD CONSTRAINT cursos_profesore_cursos_id_220295321e28a3b9_fk_cursos_cursos_id FOREIGN KEY (cursos_id) REFERENCES cursos_cursos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: f5a296e06be80065d0fa14e8448d14d1; Type: FK CONSTRAINT; Schema: public; Owner: ccapu
--

ALTER TABLE ONLY cursos_cursoscategorias_rubros
    ADD CONSTRAINT f5a296e06be80065d0fa14e8448d14d1 FOREIGN KEY (cursoscategorias_id) REFERENCES cursos_cursoscategorias(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

