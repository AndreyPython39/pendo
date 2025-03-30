--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: chat_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.chat_status AS ENUM (
    'active',
    'blocked',
    'deleted'
);


--
-- Name: event_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.event_type AS ENUM (
    'match',
    'message',
    'gift',
    'story'
);


--
-- Name: gift_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gift_type AS ENUM (
    'flower',
    'heart',
    'star',
    'diamond'
);


--
-- Name: moderationaction; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.moderationaction AS ENUM (
    'approve',
    'reject',
    'block',
    'unblock',
    'warn'
);


--
-- Name: moderationobject; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.moderationobject AS ENUM (
    'user',
    'profile',
    'tribe',
    'message',
    'photo'
);


--
-- Name: swipe_action; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.swipe_action AS ENUM (
    'like',
    'dislike'
);


--
-- Name: triberole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.triberole AS ENUM (
    'MEMBER',
    'CHIEF'
);


--
-- Name: tribestatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.tribestatus AS ENUM (
    'pending',
    'active',
    'archived'
);


--
-- Name: check_tribe_creation_limit(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.check_tribe_creation_limit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF EXISTS (
            SELECT 1 FROM users 
            WHERE id = NEW.creator_id 
            AND last_tribe_created_at IS NOT NULL 
            AND last_tribe_created_at > NOW() - INTERVAL '30 days'
        ) THEN
            RAISE EXCEPTION 'Users can only create one tribe every 30 days';
        END IF;
        
        UPDATE users 
        SET last_tribe_created_at = NOW() 
        WHERE id = NEW.creator_id;
        
        RETURN NEW;
    END;
    $$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
    END;
    $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: chats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chats (
    id integer NOT NULL,
    user1_id integer,
    user2_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    status public.chat_status
);


--
-- Name: chats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chats_id_seq OWNED BY public.chats.id;


--
-- Name: gifts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gifts (
    id integer NOT NULL,
    from_id integer,
    to_id integer,
    created_at timestamp without time zone DEFAULT now(),
    gift_type public.gift_type
);


--
-- Name: gifts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gifts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gifts_id_seq OWNED BY public.gifts.id;


--
-- Name: icebreaker_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.icebreaker_answers (
    id integer NOT NULL,
    match_id integer NOT NULL,
    question_id integer NOT NULL,
    user_id integer NOT NULL,
    answer character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: icebreaker_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.icebreaker_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: icebreaker_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.icebreaker_answers_id_seq OWNED BY public.icebreaker_answers.id;


--
-- Name: icebreaker_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.icebreaker_questions (
    id integer NOT NULL,
    question character varying NOT NULL,
    category character varying,
    language character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: icebreaker_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.icebreaker_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: icebreaker_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.icebreaker_questions_id_seq OWNED BY public.icebreaker_questions.id;


--
-- Name: interests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interests (
    id integer NOT NULL,
    name character varying NOT NULL,
    category character varying,
    created_at timestamp without time zone
);


--
-- Name: interests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.interests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.interests_id_seq OWNED BY public.interests.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.likes (
    id integer NOT NULL,
    from_user_id integer,
    to_user_id integer,
    is_super_like boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.likes_id_seq OWNED BY public.likes.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    id integer NOT NULL,
    user1_id integer,
    user2_id integer,
    matched_at timestamp with time zone NOT NULL,
    is_active boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    match_id integer,
    sender_id integer,
    content character varying NOT NULL,
    is_read boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: moderation_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.moderation_logs (
    id integer NOT NULL,
    moderator_id integer NOT NULL,
    object_type public.moderationobject NOT NULL,
    object_id integer NOT NULL,
    action public.moderationaction NOT NULL,
    reason character varying,
    extra_data jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: moderation_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.moderation_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moderation_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.moderation_logs_id_seq OWNED BY public.moderation_logs.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.photos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    url character varying NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    moderation_status character varying DEFAULT 'pending'::character varying NOT NULL,
    moderated_by integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.photos_id_seq OWNED BY public.photos.id;


--
-- Name: stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stories (
    id integer NOT NULL,
    user_id integer NOT NULL,
    media_type character varying NOT NULL,
    media_url character varying NOT NULL,
    thumbnail_url character varying,
    caption character varying,
    views_count integer DEFAULT 0 NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT valid_story_media_type CHECK (((media_type)::text = ANY ((ARRAY['image'::character varying, 'video'::character varying])::text[])))
);


--
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- Name: story_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_views (
    id integer NOT NULL,
    story_id integer NOT NULL,
    viewer_id integer NOT NULL,
    viewed_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: story_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.story_views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: story_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.story_views_id_seq OWNED BY public.story_views.id;


--
-- Name: tribe_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tribe_members (
    id integer NOT NULL,
    tribe_id integer,
    user_id integer,
    joined_at timestamp with time zone NOT NULL
);


--
-- Name: tribe_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tribe_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tribe_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tribe_members_id_seq OWNED BY public.tribe_members.id;


--
-- Name: tribe_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tribe_votes (
    id integer NOT NULL,
    tribe_id integer,
    voter_id integer,
    candidate_id integer,
    voted_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: tribe_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tribe_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tribe_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tribe_votes_id_seq OWNED BY public.tribe_votes.id;


--
-- Name: tribes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tribes (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    creator_id integer,
    chief_id integer,
    extra_data json,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image_url character varying,
    status public.tribestatus,
    moderation_status character varying,
    moderated_by integer
);


--
-- Name: tribes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tribes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tribes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tribes_id_seq OWNED BY public.tribes.id;


--
-- Name: user_interests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_interests (
    user_profile_id integer NOT NULL,
    interest_id integer NOT NULL
);


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    id integer NOT NULL,
    user_id integer,
    bio character varying,
    extra_data json,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    distance double precision,
    location public.geography(Point,4326),
    birthdate date NOT NULL,
    gender character varying NOT NULL,
    looking_for character varying NOT NULL,
    temperament character varying,
    moderation_status character varying,
    moderated_by integer
);


--
-- Name: user_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;


--
-- Name: user_scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_scores (
    id integer NOT NULL,
    user_id integer,
    score integer,
    level character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: user_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_scores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_scores_id_seq OWNED BY public.user_scores.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255),
    phone character varying,
    hashed_password character varying(255) NOT NULL,
    is_active boolean,
    is_superuser boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_active timestamp without time zone,
    is_verified boolean,
    role character varying,
    last_tribe_created_at timestamp with time zone,
    name character varying(255),
    pendo_score integer DEFAULT 0,
    avatar_url text,
    CONSTRAINT check_pendo_score CHECK (((pendo_score >= 0) AND (pendo_score <= 100)))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: chats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats ALTER COLUMN id SET DEFAULT nextval('public.chats_id_seq'::regclass);


--
-- Name: gifts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gifts ALTER COLUMN id SET DEFAULT nextval('public.gifts_id_seq'::regclass);


--
-- Name: icebreaker_answers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_answers ALTER COLUMN id SET DEFAULT nextval('public.icebreaker_answers_id_seq'::regclass);


--
-- Name: icebreaker_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_questions ALTER COLUMN id SET DEFAULT nextval('public.icebreaker_questions_id_seq'::regclass);


--
-- Name: interests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interests ALTER COLUMN id SET DEFAULT nextval('public.interests_id_seq'::regclass);


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes ALTER COLUMN id SET DEFAULT nextval('public.likes_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: moderation_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderation_logs ALTER COLUMN id SET DEFAULT nextval('public.moderation_logs_id_seq'::regclass);


--
-- Name: photos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos ALTER COLUMN id SET DEFAULT nextval('public.photos_id_seq'::regclass);


--
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- Name: story_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_views ALTER COLUMN id SET DEFAULT nextval('public.story_views_id_seq'::regclass);


--
-- Name: tribe_members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_members ALTER COLUMN id SET DEFAULT nextval('public.tribe_members_id_seq'::regclass);


--
-- Name: tribe_votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_votes ALTER COLUMN id SET DEFAULT nextval('public.tribe_votes_id_seq'::regclass);


--
-- Name: tribes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribes ALTER COLUMN id SET DEFAULT nextval('public.tribes_id_seq'::regclass);


--
-- Name: user_profiles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);


--
-- Name: user_scores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_scores ALTER COLUMN id SET DEFAULT nextval('public.user_scores_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: gifts gifts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gifts
    ADD CONSTRAINT gifts_pkey PRIMARY KEY (id);


--
-- Name: icebreaker_answers icebreaker_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_answers
    ADD CONSTRAINT icebreaker_answers_pkey PRIMARY KEY (id);


--
-- Name: icebreaker_questions icebreaker_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_questions
    ADD CONSTRAINT icebreaker_questions_pkey PRIMARY KEY (id);


--
-- Name: interests interests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interests
    ADD CONSTRAINT interests_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: moderation_logs moderation_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderation_logs
    ADD CONSTRAINT moderation_logs_pkey PRIMARY KEY (id);


--
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- Name: story_views story_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_views
    ADD CONSTRAINT story_views_pkey PRIMARY KEY (id);


--
-- Name: tribe_members tribe_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_members
    ADD CONSTRAINT tribe_members_pkey PRIMARY KEY (id);


--
-- Name: tribe_votes tribe_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_votes
    ADD CONSTRAINT tribe_votes_pkey PRIMARY KEY (id);


--
-- Name: tribes tribes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribes
    ADD CONSTRAINT tribes_pkey PRIMARY KEY (id);


--
-- Name: story_views unique_story_view; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_views
    ADD CONSTRAINT unique_story_view UNIQUE (story_id, viewer_id);


--
-- Name: chats unique_users; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT unique_users UNIQUE (user1_id, user2_id);


--
-- Name: user_interests user_interests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_pkey PRIMARY KEY (user_profile_id, interest_id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_key UNIQUE (user_id);


--
-- Name: user_scores user_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_scores
    ADD CONSTRAINT user_scores_pkey PRIMARY KEY (id);


--
-- Name: user_scores user_scores_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_scores
    ADD CONSTRAINT user_scores_user_id_key UNIQUE (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_chats_users; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_chats_users ON public.chats USING btree (user1_id, user2_id);


--
-- Name: idx_gifts_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_gifts_created_at ON public.gifts USING btree (created_at);


--
-- Name: idx_icebreaker_answers_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_icebreaker_answers_user ON public.icebreaker_answers USING btree (user_id);


--
-- Name: idx_messages_match_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_match_created_at ON public.messages USING btree (match_id, created_at);


--
-- Name: idx_stories_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stories_expires_at ON public.stories USING btree (expires_at);


--
-- Name: idx_story_views_viewer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_story_views_viewer ON public.story_views USING btree (viewer_id);


--
-- Name: idx_tribe_members_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tribe_members_user ON public.tribe_members USING btree (user_id);


--
-- Name: idx_tribe_votes_voter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tribe_votes_voter ON public.tribe_votes USING btree (voter_id);


--
-- Name: idx_user_interests_profile; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_interests_profile ON public.user_interests USING btree (user_profile_id);


--
-- Name: idx_user_profiles_location; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profiles_location ON public.user_profiles USING gist (location);


--
-- Name: idx_user_profiles_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profiles_user ON public.user_profiles USING btree (user_id);


--
-- Name: idx_users_pendo_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_pendo_score ON public.users USING btree (pendo_score);


--
-- Name: ix_icebreaker_questions_language; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_icebreaker_questions_language ON public.icebreaker_questions USING btree (language);


--
-- Name: ix_interests_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_interests_category ON public.interests USING btree (category);


--
-- Name: ix_interests_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_interests_name ON public.interests USING btree (name);


--
-- Name: ix_likes_from_to_users; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_likes_from_to_users ON public.likes USING btree (from_user_id, to_user_id);


--
-- Name: ix_likes_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_likes_id ON public.likes USING btree (id);


--
-- Name: ix_matches_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_matches_id ON public.matches USING btree (id);


--
-- Name: ix_matches_users; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_matches_users ON public.matches USING btree (user1_id, user2_id);


--
-- Name: ix_messages_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_messages_id ON public.messages USING btree (id);


--
-- Name: ix_moderation_logs_object_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_moderation_logs_object_id ON public.moderation_logs USING btree (object_id);


--
-- Name: ix_moderation_logs_object_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_moderation_logs_object_type ON public.moderation_logs USING btree (object_type);


--
-- Name: ix_stories_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_stories_expires_at ON public.stories USING btree (expires_at);


--
-- Name: ix_stories_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_stories_user_id ON public.stories USING btree (user_id);


--
-- Name: ix_story_views_story_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_story_views_story_id ON public.story_views USING btree (story_id);


--
-- Name: ix_story_views_viewer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_story_views_viewer_id ON public.story_views USING btree (viewer_id);


--
-- Name: ix_tribes_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_tribes_id ON public.tribes USING btree (id);


--
-- Name: ix_user_profiles_distance; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_user_profiles_distance ON public.user_profiles USING btree (distance);


--
-- Name: ix_user_scores_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_user_scores_score ON public.user_scores USING btree (score DESC);


--
-- Name: ix_users_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_users_active ON public.users USING btree (id) WHERE (is_active = true);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_last_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_users_last_active ON public.users USING btree (last_active);


--
-- Name: ix_users_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_users_phone ON public.users USING btree (phone);


--
-- Name: tribes tribe_creation_limit; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tribe_creation_limit BEFORE INSERT ON public.tribes FOR EACH ROW EXECUTE FUNCTION public.check_tribe_creation_limit();


--
-- Name: icebreaker_questions update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_timestamp BEFORE UPDATE ON public.icebreaker_questions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: photos update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_timestamp BEFORE UPDATE ON public.photos FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: tribes update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_timestamp BEFORE UPDATE ON public.tribes FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: user_profiles update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_timestamp BEFORE UPDATE ON public.user_profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: users update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_timestamp BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: chats chats_user1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_user1_id_fkey FOREIGN KEY (user1_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: chats chats_user2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_user2_id_fkey FOREIGN KEY (user2_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: gifts gifts_from_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gifts
    ADD CONSTRAINT gifts_from_id_fkey FOREIGN KEY (from_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: gifts gifts_to_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gifts
    ADD CONSTRAINT gifts_to_id_fkey FOREIGN KEY (to_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: icebreaker_answers icebreaker_answers_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_answers
    ADD CONSTRAINT icebreaker_answers_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: icebreaker_answers icebreaker_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_answers
    ADD CONSTRAINT icebreaker_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.icebreaker_questions(id);


--
-- Name: icebreaker_answers icebreaker_answers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icebreaker_answers
    ADD CONSTRAINT icebreaker_answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: likes likes_from_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_from_user_id_fkey FOREIGN KEY (from_user_id) REFERENCES public.users(id);


--
-- Name: likes likes_to_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_to_user_id_fkey FOREIGN KEY (to_user_id) REFERENCES public.users(id);


--
-- Name: matches matches_user1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_user1_id_fkey FOREIGN KEY (user1_id) REFERENCES public.users(id);


--
-- Name: matches matches_user2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_user2_id_fkey FOREIGN KEY (user2_id) REFERENCES public.users(id);


--
-- Name: messages messages_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: moderation_logs moderation_logs_moderator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderation_logs
    ADD CONSTRAINT moderation_logs_moderator_id_fkey FOREIGN KEY (moderator_id) REFERENCES public.users(id);


--
-- Name: photos photos_moderated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(id);


--
-- Name: photos photos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: stories stories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: story_views story_views_story_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_views
    ADD CONSTRAINT story_views_story_id_fkey FOREIGN KEY (story_id) REFERENCES public.stories(id);


--
-- Name: story_views story_views_viewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_views
    ADD CONSTRAINT story_views_viewer_id_fkey FOREIGN KEY (viewer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tribe_members tribe_members_tribe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_members
    ADD CONSTRAINT tribe_members_tribe_id_fkey FOREIGN KEY (tribe_id) REFERENCES public.tribes(id);


--
-- Name: tribe_members tribe_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_members
    ADD CONSTRAINT tribe_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tribe_votes tribe_votes_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_votes
    ADD CONSTRAINT tribe_votes_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.users(id);


--
-- Name: tribe_votes tribe_votes_tribe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_votes
    ADD CONSTRAINT tribe_votes_tribe_id_fkey FOREIGN KEY (tribe_id) REFERENCES public.tribes(id);


--
-- Name: tribe_votes tribe_votes_voter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribe_votes
    ADD CONSTRAINT tribe_votes_voter_id_fkey FOREIGN KEY (voter_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tribes tribes_chief_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribes
    ADD CONSTRAINT tribes_chief_id_fkey FOREIGN KEY (chief_id) REFERENCES public.users(id);


--
-- Name: tribes tribes_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribes
    ADD CONSTRAINT tribes_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: tribes tribes_moderated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tribes
    ADD CONSTRAINT tribes_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(id);


--
-- Name: user_interests user_interests_interest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_interest_id_fkey FOREIGN KEY (interest_id) REFERENCES public.interests(id);


--
-- Name: user_interests user_interests_user_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_user_profile_id_fkey FOREIGN KEY (user_profile_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;


--
-- Name: user_profiles user_profiles_moderated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(id);


--
-- Name: user_profiles user_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_scores user_scores_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_scores
    ADD CONSTRAINT user_scores_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

