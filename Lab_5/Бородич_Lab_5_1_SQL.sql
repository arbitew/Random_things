toc.dat                                                                                             0000600 0004000 0002000 00000024136 14524662066 0014460 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       %                
    {            postgres    14.9    14.9 "               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                    0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                    0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                    1262    13754    postgres    DATABASE     e   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false                    0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3356                     3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false                    0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2         �            1259    16433    Acid_production    TABLE     �   CREATE TABLE public."Acid_production" (
    "ID" integer NOT NULL,
    "Date" date NOT NULL,
    "Concentration" integer NOT NULL,
    "Product_value" integer,
    "Reactor" integer,
    "Reactor_value" real,
    "City" integer
);
 %   DROP TABLE public."Acid_production";
       public         heap    postgres    false         �            1259    16432    Acid_production_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Acid_production_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."Acid_production_ID_seq";
       public          postgres    false    215                    0    0    Acid_production_ID_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Acid_production_ID_seq" OWNED BY public."Acid_production"."ID";
          public          postgres    false    214         �            1259    16419    Cities    TABLE     [   CREATE TABLE public."Cities" (
    "ID_city" integer NOT NULL,
    "City" character(20)
);
    DROP TABLE public."Cities";
       public         heap    postgres    false         �            1259    16418    Cities_ID_city_seq    SEQUENCE     �   CREATE SEQUENCE public."Cities_ID_city_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Cities_ID_city_seq";
       public          postgres    false    211                     0    0    Cities_ID_city_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Cities_ID_city_seq" OWNED BY public."Cities"."ID_city";
          public          postgres    false    210         �            1259    16426    Reactors    TABLE     l   CREATE TABLE public."Reactors" (
    "ID_reactor" integer NOT NULL,
    "Reactor" character(20) NOT NULL
);
    DROP TABLE public."Reactors";
       public         heap    postgres    false         �            1259    16425    Reactors_ID_reactor_seq    SEQUENCE     �   CREATE SEQUENCE public."Reactors_ID_reactor_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Reactors_ID_reactor_seq";
       public          postgres    false    213         !           0    0    Reactors_ID_reactor_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."Reactors_ID_reactor_seq" OWNED BY public."Reactors"."ID_reactor";
          public          postgres    false    212         �            1259    16506    avg_sum    VIEW     ,  CREATE VIEW public.avg_sum AS
 SELECT "Cities"."City",
    "Acid_production"."Concentration",
    avg("Acid_production"."Concentration") OVER (PARTITION BY "Acid_production"."City") AS avg
   FROM public."Acid_production",
    public."Cities"
  WHERE ("Acid_production"."City" = "Cities"."ID_city");
    DROP VIEW public.avg_sum;
       public          postgres    false    211    215    215    211         �            1259    16502 
   itog_query    VIEW     �  CREATE VIEW public.itog_query AS
 SELECT "Acid_production"."Date",
    "Acid_production"."Concentration",
    "Acid_production"."Product_value",
    "Reactors"."Reactor",
    "Acid_production"."Reactor_value",
    "Cities"."City"
   FROM public."Acid_production",
    public."Reactors",
    public."Cities"
  WHERE (("Acid_production"."Reactor" = "Reactors"."ID_reactor") AND ("Acid_production"."Reactor" = "Cities"."ID_city"));
    DROP VIEW public.itog_query;
       public          postgres    false    215    215    213    211    211    215    213    215    215         �            1259    16494    my_query_option    VIEW     �   CREATE VIEW public.my_query_option AS
 SELECT "Acid_production"."Date",
    "Acid_production"."Concentration",
    "Acid_production"."Product_value"
   FROM public."Acid_production"
  WITH CASCADED CHECK OPTION;
 "   DROP VIEW public.my_query_option;
       public          postgres    false    215    215    215         �            1259    16474    over90    VIEW     ~  CREATE VIEW public.over90 AS
 SELECT "Acid_production"."ID",
    "Acid_production"."Date",
    "Acid_production"."Concentration",
    "Acid_production"."Product_value",
    "Acid_production"."Reactor",
    "Acid_production"."Reactor_value",
    "Acid_production"."City"
   FROM public."Acid_production"
  WHERE ("Acid_production"."Concentration" > 90)
  WITH CASCADED CHECK OPTION;
    DROP VIEW public.over90;
       public          postgres    false    215    215    215    215    215    215    215         y           2604    16436    Acid_production ID    DEFAULT     ~   ALTER TABLE ONLY public."Acid_production" ALTER COLUMN "ID" SET DEFAULT nextval('public."Acid_production_ID_seq"'::regclass);
 E   ALTER TABLE public."Acid_production" ALTER COLUMN "ID" DROP DEFAULT;
       public          postgres    false    214    215    215         w           2604    16422    Cities ID_city    DEFAULT     v   ALTER TABLE ONLY public."Cities" ALTER COLUMN "ID_city" SET DEFAULT nextval('public."Cities_ID_city_seq"'::regclass);
 A   ALTER TABLE public."Cities" ALTER COLUMN "ID_city" DROP DEFAULT;
       public          postgres    false    211    210    211         x           2604    16429    Reactors ID_reactor    DEFAULT     �   ALTER TABLE ONLY public."Reactors" ALTER COLUMN "ID_reactor" SET DEFAULT nextval('public."Reactors_ID_reactor_seq"'::regclass);
 F   ALTER TABLE public."Reactors" ALTER COLUMN "ID_reactor" DROP DEFAULT;
       public          postgres    false    213    212    213                   0    16433    Acid_production 
   TABLE DATA              COPY public."Acid_production" ("ID", "Date", "Concentration", "Product_value", "Reactor", "Reactor_value", "City") FROM stdin;
    public          postgres    false    215       3350.dat           0    16419    Cities 
   TABLE DATA           5   COPY public."Cities" ("ID_city", "City") FROM stdin;
    public          postgres    false    211       3346.dat           0    16426    Reactors 
   TABLE DATA           =   COPY public."Reactors" ("ID_reactor", "Reactor") FROM stdin;
    public          postgres    false    213       3348.dat "           0    0    Acid_production_ID_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."Acid_production_ID_seq"', 9, true);
          public          postgres    false    214         #           0    0    Cities_ID_city_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Cities_ID_city_seq"', 5, true);
          public          postgres    false    210         $           0    0    Reactors_ID_reactor_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Reactors_ID_reactor_seq"', 3, true);
          public          postgres    false    212                    2606    16438 $   Acid_production Acid_production_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "Acid_production_pkey" PRIMARY KEY ("ID");
 R   ALTER TABLE ONLY public."Acid_production" DROP CONSTRAINT "Acid_production_pkey";
       public            postgres    false    215         {           2606    16424    Cities Cities_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Cities"
    ADD CONSTRAINT "Cities_pkey" PRIMARY KEY ("ID_city");
 @   ALTER TABLE ONLY public."Cities" DROP CONSTRAINT "Cities_pkey";
       public            postgres    false    211         }           2606    16431    Reactors Reactors_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."Reactors"
    ADD CONSTRAINT "Reactors_pkey" PRIMARY KEY ("ID_reactor");
 D   ALTER TABLE ONLY public."Reactors" DROP CONSTRAINT "Reactors_pkey";
       public            postgres    false    213         �           2606    16447    Acid_production ID_city    FK CONSTRAINT     �   ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "ID_city" FOREIGN KEY ("City") REFERENCES public."Cities"("ID_city") NOT VALID;
 E   ALTER TABLE ONLY public."Acid_production" DROP CONSTRAINT "ID_city";
       public          postgres    false    215    211    3195         �           2606    16456    Acid_production ID_reactor    FK CONSTRAINT     �   ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "ID_reactor" FOREIGN KEY ("Reactor") REFERENCES public."Reactors"("ID_reactor") NOT VALID;
 H   ALTER TABLE ONLY public."Acid_production" DROP CONSTRAINT "ID_reactor";
       public          postgres    false    215    3197    213                                                                                                                                                                                                                                                                                                                                                                                                                                          3350.dat                                                                                            0000600 0004000 0002000 00000000335 14524662066 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1991-01-03	89	15	1	1.5	1
2	1993-01-15	95	14	2	1.4	1
3	1992-02-02	97	13	2	1.3	2
4	1991-03-02	92	15	3	1.5	1
5	1991-02-14	99	13	3	1.3	3
6	1991-04-04	96	14	2	1.4	4
8	1940-01-08	99	\N	3	\N	\N
7	1992-01-03	99	\N	\N	\N	5
\.


                                                                                                                                                                                                                                                                                                   3346.dat                                                                                            0000600 0004000 0002000 00000000173 14524662066 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	Курск               
4	Тула                
1	Москва              
3	Казань              
5	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                     3348.dat                                                                                            0000600 0004000 0002000 00000000137 14524662066 0014267 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Реактор1            
2	Реактор2            
3	Реактор3            
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                 restore.sql                                                                                         0000600 0004000 0002000 00000021122 14524662066 0015375 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9
-- Dumped by pg_dump version 14.9

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Acid_production; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Acid_production" (
    "ID" integer NOT NULL,
    "Date" date NOT NULL,
    "Concentration" integer NOT NULL,
    "Product_value" integer,
    "Reactor" integer,
    "Reactor_value" real,
    "City" integer
);


ALTER TABLE public."Acid_production" OWNER TO postgres;

--
-- Name: Acid_production_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Acid_production_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Acid_production_ID_seq" OWNER TO postgres;

--
-- Name: Acid_production_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Acid_production_ID_seq" OWNED BY public."Acid_production"."ID";


--
-- Name: Cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cities" (
    "ID_city" integer NOT NULL,
    "City" character(20)
);


ALTER TABLE public."Cities" OWNER TO postgres;

--
-- Name: Cities_ID_city_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cities_ID_city_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cities_ID_city_seq" OWNER TO postgres;

--
-- Name: Cities_ID_city_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cities_ID_city_seq" OWNED BY public."Cities"."ID_city";


--
-- Name: Reactors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reactors" (
    "ID_reactor" integer NOT NULL,
    "Reactor" character(20) NOT NULL
);


ALTER TABLE public."Reactors" OWNER TO postgres;

--
-- Name: Reactors_ID_reactor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Reactors_ID_reactor_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Reactors_ID_reactor_seq" OWNER TO postgres;

--
-- Name: Reactors_ID_reactor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Reactors_ID_reactor_seq" OWNED BY public."Reactors"."ID_reactor";


--
-- Name: avg_sum; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.avg_sum AS
 SELECT "Cities"."City",
    "Acid_production"."Concentration",
    avg("Acid_production"."Concentration") OVER (PARTITION BY "Acid_production"."City") AS avg
   FROM public."Acid_production",
    public."Cities"
  WHERE ("Acid_production"."City" = "Cities"."ID_city");


ALTER TABLE public.avg_sum OWNER TO postgres;

--
-- Name: itog_query; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.itog_query AS
 SELECT "Acid_production"."Date",
    "Acid_production"."Concentration",
    "Acid_production"."Product_value",
    "Reactors"."Reactor",
    "Acid_production"."Reactor_value",
    "Cities"."City"
   FROM public."Acid_production",
    public."Reactors",
    public."Cities"
  WHERE (("Acid_production"."Reactor" = "Reactors"."ID_reactor") AND ("Acid_production"."Reactor" = "Cities"."ID_city"));


ALTER TABLE public.itog_query OWNER TO postgres;

--
-- Name: my_query_option; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.my_query_option AS
 SELECT "Acid_production"."Date",
    "Acid_production"."Concentration",
    "Acid_production"."Product_value"
   FROM public."Acid_production"
  WITH CASCADED CHECK OPTION;


ALTER TABLE public.my_query_option OWNER TO postgres;

--
-- Name: over90; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.over90 AS
 SELECT "Acid_production"."ID",
    "Acid_production"."Date",
    "Acid_production"."Concentration",
    "Acid_production"."Product_value",
    "Acid_production"."Reactor",
    "Acid_production"."Reactor_value",
    "Acid_production"."City"
   FROM public."Acid_production"
  WHERE ("Acid_production"."Concentration" > 90)
  WITH CASCADED CHECK OPTION;


ALTER TABLE public.over90 OWNER TO postgres;

--
-- Name: Acid_production ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Acid_production" ALTER COLUMN "ID" SET DEFAULT nextval('public."Acid_production_ID_seq"'::regclass);


--
-- Name: Cities ID_city; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cities" ALTER COLUMN "ID_city" SET DEFAULT nextval('public."Cities_ID_city_seq"'::regclass);


--
-- Name: Reactors ID_reactor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactors" ALTER COLUMN "ID_reactor" SET DEFAULT nextval('public."Reactors_ID_reactor_seq"'::regclass);


--
-- Data for Name: Acid_production; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Acid_production" ("ID", "Date", "Concentration", "Product_value", "Reactor", "Reactor_value", "City") FROM stdin;
\.
COPY public."Acid_production" ("ID", "Date", "Concentration", "Product_value", "Reactor", "Reactor_value", "City") FROM '$$PATH$$/3350.dat';

--
-- Data for Name: Cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cities" ("ID_city", "City") FROM stdin;
\.
COPY public."Cities" ("ID_city", "City") FROM '$$PATH$$/3346.dat';

--
-- Data for Name: Reactors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reactors" ("ID_reactor", "Reactor") FROM stdin;
\.
COPY public."Reactors" ("ID_reactor", "Reactor") FROM '$$PATH$$/3348.dat';

--
-- Name: Acid_production_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Acid_production_ID_seq"', 9, true);


--
-- Name: Cities_ID_city_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cities_ID_city_seq"', 5, true);


--
-- Name: Reactors_ID_reactor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Reactors_ID_reactor_seq"', 3, true);


--
-- Name: Acid_production Acid_production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "Acid_production_pkey" PRIMARY KEY ("ID");


--
-- Name: Cities Cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cities"
    ADD CONSTRAINT "Cities_pkey" PRIMARY KEY ("ID_city");


--
-- Name: Reactors Reactors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactors"
    ADD CONSTRAINT "Reactors_pkey" PRIMARY KEY ("ID_reactor");


--
-- Name: Acid_production ID_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "ID_city" FOREIGN KEY ("City") REFERENCES public."Cities"("ID_city") NOT VALID;


--
-- Name: Acid_production ID_reactor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "ID_reactor" FOREIGN KEY ("Reactor") REFERENCES public."Reactors"("ID_reactor") NOT VALID;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              