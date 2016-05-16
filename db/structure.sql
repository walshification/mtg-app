--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: card_scrapers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE card_scrapers (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: card_scrapers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE card_scrapers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_scrapers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE card_scrapers_id_seq OWNED BY card_scrapers.id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cards (
    id integer NOT NULL,
    multiverse_id character varying NOT NULL,
    deck_id integer,
    name character varying NOT NULL,
    image_url character varying,
    card_type character varying,
    subtype character varying,
    layout character varying,
    cmc integer,
    rarity character varying,
    text text,
    flavor character varying,
    artist character varying,
    number character varying,
    power character varying,
    toughness character varying,
    loyalty integer,
    set_id integer,
    watermark character varying,
    border character varying,
    timeshifted boolean,
    hand character varying,
    life character varying,
    reserved boolean,
    release_date character varying,
    starter boolean,
    original_text text,
    original_type character varying,
    source character varying
);


--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cards_id_seq OWNED BY cards.id;


--
-- Name: deck_cards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deck_cards (
    id integer NOT NULL,
    deck_id integer,
    card_id integer
);


--
-- Name: deck_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deck_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deck_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deck_cards_id_seq OWNED BY deck_cards.id;


--
-- Name: decks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE decks (
    id integer NOT NULL,
    user_id integer,
    name character varying,
    legal_format character varying,
    deck_type character varying,
    color character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: decks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE decks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: decks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE decks_id_seq OWNED BY decks.id;


--
-- Name: magic_sets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE magic_sets (
    id integer NOT NULL,
    name character varying,
    code character varying,
    gatherer_code character varying,
    magiccards_info_code character varying,
    border character varying,
    set_type character varying,
    block character varying,
    release_date character varying,
    online_only boolean DEFAULT false
);


--
-- Name: magic_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE magic_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: magic_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE magic_sets_id_seq OWNED BY magic_sets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT email_must_be_valid_email CHECK (((email)::text ~* '[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+.[A-Za-z]+'::text))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY card_scrapers ALTER COLUMN id SET DEFAULT nextval('card_scrapers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cards ALTER COLUMN id SET DEFAULT nextval('cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deck_cards ALTER COLUMN id SET DEFAULT nextval('deck_cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY decks ALTER COLUMN id SET DEFAULT nextval('decks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY magic_sets ALTER COLUMN id SET DEFAULT nextval('magic_sets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: card_scrapers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY card_scrapers
    ADD CONSTRAINT card_scrapers_pkey PRIMARY KEY (id);


--
-- Name: cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: deck_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deck_cards
    ADD CONSTRAINT deck_cards_pkey PRIMARY KEY (id);


--
-- Name: decks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY decks
    ADD CONSTRAINT decks_pkey PRIMARY KEY (id);


--
-- Name: magic_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY magic_sets
    ADD CONSTRAINT magic_sets_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_cards_on_multiverse_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_cards_on_multiverse_id ON cards USING btree (multiverse_id);


--
-- Name: index_deck_cards_on_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_deck_cards_on_card_id ON deck_cards USING btree (card_id);


--
-- Name: index_deck_cards_on_deck_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_deck_cards_on_deck_id ON deck_cards USING btree (deck_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20141102212454');

INSERT INTO schema_migrations (version) VALUES ('20141102215824');

INSERT INTO schema_migrations (version) VALUES ('20141102223655');

INSERT INTO schema_migrations (version) VALUES ('20141102225343');

INSERT INTO schema_migrations (version) VALUES ('20141106030433');

INSERT INTO schema_migrations (version) VALUES ('20141106030436');

INSERT INTO schema_migrations (version) VALUES ('20141118013420');

INSERT INTO schema_migrations (version) VALUES ('20141121020046');

INSERT INTO schema_migrations (version) VALUES ('20141126023018');

INSERT INTO schema_migrations (version) VALUES ('20141207174119');

INSERT INTO schema_migrations (version) VALUES ('20160429125033');

INSERT INTO schema_migrations (version) VALUES ('20160501215136');

INSERT INTO schema_migrations (version) VALUES ('20160502014107');

INSERT INTO schema_migrations (version) VALUES ('20160503123814');

INSERT INTO schema_migrations (version) VALUES ('20160503130939');

INSERT INTO schema_migrations (version) VALUES ('20160506190027');

INSERT INTO schema_migrations (version) VALUES ('20160516103305');

INSERT INTO schema_migrations (version) VALUES ('20160516104915');

INSERT INTO schema_migrations (version) VALUES ('20160516124912');

INSERT INTO schema_migrations (version) VALUES ('20160516130848');

