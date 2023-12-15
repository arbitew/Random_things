toc.dat                                                                                             0000600 0004000 0002000 00000040467 14531365346 0014464 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                       
    {            postgres    14.9    14.9 0    '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         *           1262    13754    postgres    DATABASE     e   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false         +           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3370                     3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false         ,           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2         �            1255    16528    all_obj_stat()    FUNCTION     1  CREATE FUNCTION public.all_obj_stat() RETURNS TABLE(max_con integer, min_con integer, avg_con integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select cast(max("Concentration") as int), cast(min("Concentration") as int), cast(avg("Concentration")  as int)
			  from "Acid_production");
end; $$;
 %   DROP FUNCTION public.all_obj_stat();
       public          postgres    false         �            1255    16540    alter_del()    FUNCTION     �   CREATE FUNCTION public.alter_del() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
delete from "Acid_production" where "Acid_production"."City" = OLD."ID_city";
return OLD;
END;
$$;
 "   DROP FUNCTION public.alter_del();
       public          postgres    false         �            1255    16554    before_del()    FUNCTION       CREATE FUNCTION public.before_del() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare parent_name text;
BEGIN
select "City" into parent_name from "Cities" where "Cities"."ID_city" = OLD."City";
raise notice 'Deleting %', parent_name;
return OLD;
END;$$;
 #   DROP FUNCTION public.before_del();
       public          postgres    false         �            1255    16549    before_update_val()    FUNCTION     �   CREATE FUNCTION public.before_update_val() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
NEW."Concentration" = Cast(NEW."Concentration"*(1.1) as int);
return NEW;
END;
$$;
 *   DROP FUNCTION public.before_update_val();
       public          postgres    false         �            1255    16533    city_itog(character)    FUNCTION     �  CREATE FUNCTION public.city_itog(that_city character) RETURNS character
    LANGUAGE plpgsql
    AS $$
begin
  if(CAST((select count(*)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city) as int) <= 2)
			  then return 'minor city';
	 end if;
	if(CAST((select count(*)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city) as int) = 3)
	 then return 'normal city';
	 end if;
	 if(CAST((select count(*)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city) as int) > 3)
	 then return 'significant city';
	 end if;
end; $$;
 5   DROP FUNCTION public.city_itog(that_city character);
       public          postgres    false         �            1255    16556 	   int_sum()    FUNCTION     �   CREATE FUNCTION public.int_sum() RETURNS trigger
    LANGUAGE plpgsql
    AS $$declare parent_name int;
BEGIN
raise notice 'inserted %', COUNT(*) + 1 From "Acid_production";
return NEW;
END;$$;
     DROP FUNCTION public.int_sum();
       public          postgres    false         �            1255    16524    my_row_count(date, date)    FUNCTION     �   CREATE FUNCTION public.my_row_count(a date, b date) RETURNS TABLE(data_count integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select CAST(COUNT(*) as int) FROM period(a, b));
end; $$;
 3   DROP FUNCTION public.my_row_count(a date, b date);
       public          postgres    false         �            1255    16520    period(date, date)    FUNCTION       CREATE FUNCTION public.period(a date, b date) RETURNS TABLE(mydate date, concentration integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select "Date", "Concentration" from "Acid_production" where "Acid_production"."Date" > a
 and "Acid_production"."Date" < b);
end; $$;
 -   DROP FUNCTION public.period(a date, b date);
       public          postgres    false         �            1255    16522    sum_obj(integer)    FUNCTION     �  CREATE FUNCTION public.sum_obj(a integer) RETURNS TABLE(city character, sum_con integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select "City", (select CAST(sum("Concentration") as int) from "Acid_production" 
								 where "Cities"."ID_city" = "Acid_production"."City") as sum_conc
				from "Cities"
				where (select sum("Concentration") from "Acid_production" 
								 where "Cities"."ID_city" = "Acid_production"."City") > a);
end; $$;
 )   DROP FUNCTION public.sum_obj(a integer);
       public          postgres    false         �            1255    16527    that_obj_stat(character)    FUNCTION     �  CREATE FUNCTION public.that_obj_stat(that_city character) RETURNS TABLE(max_con integer, min_con integer, avg_con integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select cast(max("Concentration") as int), cast(min("Concentration") as int), cast(avg("Concentration")  as int)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city);
end; $$;
 9   DROP FUNCTION public.that_obj_stat(that_city character);
       public          postgres    false         �            1259    16433    Acid_production    TABLE     �   CREATE TABLE public."Acid_production" (
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
       public          postgres    false    215         -           0    0    Acid_production_ID_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Acid_production_ID_seq" OWNED BY public."Acid_production"."ID";
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
       public          postgres    false    211         .           0    0    Cities_ID_city_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Cities_ID_city_seq" OWNED BY public."Cities"."ID_city";
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
       public          postgres    false    213         /           0    0    Reactors_ID_reactor_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."Reactors_ID_reactor_seq" OWNED BY public."Reactors"."ID_reactor";
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
       public          postgres    false    215    215    215    215    215    213    213    211    211         �            1259    16494    my_query_option    VIEW     �   CREATE VIEW public.my_query_option AS
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
       public          postgres    false    215    215    215    215    215    215    215         �           2604    16436    Acid_production ID    DEFAULT     ~   ALTER TABLE ONLY public."Acid_production" ALTER COLUMN "ID" SET DEFAULT nextval('public."Acid_production_ID_seq"'::regclass);
 E   ALTER TABLE public."Acid_production" ALTER COLUMN "ID" DROP DEFAULT;
       public          postgres    false    214    215    215         �           2604    16422    Cities ID_city    DEFAULT     v   ALTER TABLE ONLY public."Cities" ALTER COLUMN "ID_city" SET DEFAULT nextval('public."Cities_ID_city_seq"'::regclass);
 A   ALTER TABLE public."Cities" ALTER COLUMN "ID_city" DROP DEFAULT;
       public          postgres    false    211    210    211         �           2604    16429    Reactors ID_reactor    DEFAULT     �   ALTER TABLE ONLY public."Reactors" ALTER COLUMN "ID_reactor" SET DEFAULT nextval('public."Reactors_ID_reactor_seq"'::regclass);
 F   ALTER TABLE public."Reactors" ALTER COLUMN "ID_reactor" DROP DEFAULT;
       public          postgres    false    213    212    213         $          0    16433    Acid_production 
   TABLE DATA              COPY public."Acid_production" ("ID", "Date", "Concentration", "Product_value", "Reactor", "Reactor_value", "City") FROM stdin;
    public          postgres    false    215       3364.dat            0    16419    Cities 
   TABLE DATA           5   COPY public."Cities" ("ID_city", "City") FROM stdin;
    public          postgres    false    211       3360.dat "          0    16426    Reactors 
   TABLE DATA           =   COPY public."Reactors" ("ID_reactor", "Reactor") FROM stdin;
    public          postgres    false    213       3362.dat 0           0    0    Acid_production_ID_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Acid_production_ID_seq"', 23, true);
          public          postgres    false    214         1           0    0    Cities_ID_city_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Cities_ID_city_seq"', 7, true);
          public          postgres    false    210         2           0    0    Reactors_ID_reactor_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Reactors_ID_reactor_seq"', 3, true);
          public          postgres    false    212         �           2606    16438 $   Acid_production Acid_production_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "Acid_production_pkey" PRIMARY KEY ("ID");
 R   ALTER TABLE ONLY public."Acid_production" DROP CONSTRAINT "Acid_production_pkey";
       public            postgres    false    215         �           2606    16424    Cities Cities_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Cities"
    ADD CONSTRAINT "Cities_pkey" PRIMARY KEY ("ID_city");
 @   ALTER TABLE ONLY public."Cities" DROP CONSTRAINT "Cities_pkey";
       public            postgres    false    211         �           2606    16431    Reactors Reactors_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."Reactors"
    ADD CONSTRAINT "Reactors_pkey" PRIMARY KEY ("ID_reactor");
 D   ALTER TABLE ONLY public."Reactors" DROP CONSTRAINT "Reactors_pkey";
       public            postgres    false    213         �           2620    16541    Cities alterdel_tr    TRIGGER     n   CREATE TRIGGER alterdel_tr BEFORE DELETE ON public."Cities" FOR EACH ROW EXECUTE FUNCTION public.alter_del();
 -   DROP TRIGGER alterdel_tr ON public."Cities";
       public          postgres    false    211    234         �           2620    16555    Acid_production befordel_tr    TRIGGER     x   CREATE TRIGGER befordel_tr BEFORE DELETE ON public."Acid_production" FOR EACH ROW EXECUTE FUNCTION public.before_del();
 6   DROP TRIGGER befordel_tr ON public."Acid_production";
       public          postgres    false    226    215         �           2620    16550    Acid_production beforeupdate_tr    TRIGGER     �   CREATE TRIGGER beforeupdate_tr BEFORE UPDATE ON public."Acid_production" FOR EACH ROW EXECUTE FUNCTION public.before_update_val();
 :   DROP TRIGGER beforeupdate_tr ON public."Acid_production";
       public          postgres    false    215    240         �           2620    16558    Acid_production int_sum_tr    TRIGGER     t   CREATE TRIGGER int_sum_tr BEFORE INSERT ON public."Acid_production" FOR EACH ROW EXECUTE FUNCTION public.int_sum();
 5   DROP TRIGGER int_sum_tr ON public."Acid_production";
       public          postgres    false    227    215         �           2606    16447    Acid_production ID_city    FK CONSTRAINT     �   ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "ID_city" FOREIGN KEY ("City") REFERENCES public."Cities"("ID_city") NOT VALID;
 E   ALTER TABLE ONLY public."Acid_production" DROP CONSTRAINT "ID_city";
       public          postgres    false    211    3205    215         �           2606    16456    Acid_production ID_reactor    FK CONSTRAINT     �   ALTER TABLE ONLY public."Acid_production"
    ADD CONSTRAINT "ID_reactor" FOREIGN KEY ("Reactor") REFERENCES public."Reactors"("ID_reactor") NOT VALID;
 H   ALTER TABLE ONLY public."Acid_production" DROP CONSTRAINT "ID_reactor";
       public          postgres    false    3207    213    215                                                                                                                                                                                                                 3364.dat                                                                                            0000600 0004000 0002000 00000000252 14531365346 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3	1992-02-02	97	13	2	1.3	2
5	1991-02-14	99	13	3	1.3	3
8	1940-01-08	99	\N	3	\N	\N
7	1992-01-03	102	\N	\N	\N	5
6	1991-04-04	102	14	2	1.4	4
23	1992-05-22	96	13	2	1.3	4
\.


                                                                                                                                                                                                                                                                                                                                                      3360.dat                                                                                            0000600 0004000 0002000 00000000136 14531365346 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	Курск               
4	Тула                
3	Казань              
5	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                  3362.dat                                                                                            0000600 0004000 0002000 00000000137 14531365346 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Реактор1            
2	Реактор2            
3	Реактор3            
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                 restore.sql                                                                                         0000600 0004000 0002000 00000033773 14531365346 0015413 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
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


--
-- Name: all_obj_stat(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.all_obj_stat() RETURNS TABLE(max_con integer, min_con integer, avg_con integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select cast(max("Concentration") as int), cast(min("Concentration") as int), cast(avg("Concentration")  as int)
			  from "Acid_production");
end; $$;


ALTER FUNCTION public.all_obj_stat() OWNER TO postgres;

--
-- Name: alter_del(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.alter_del() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
delete from "Acid_production" where "Acid_production"."City" = OLD."ID_city";
return OLD;
END;
$$;


ALTER FUNCTION public.alter_del() OWNER TO postgres;

--
-- Name: before_del(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.before_del() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare parent_name text;
BEGIN
select "City" into parent_name from "Cities" where "Cities"."ID_city" = OLD."City";
raise notice 'Deleting %', parent_name;
return OLD;
END;$$;


ALTER FUNCTION public.before_del() OWNER TO postgres;

--
-- Name: before_update_val(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.before_update_val() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
NEW."Concentration" = Cast(NEW."Concentration"*(1.1) as int);
return NEW;
END;
$$;


ALTER FUNCTION public.before_update_val() OWNER TO postgres;

--
-- Name: city_itog(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.city_itog(that_city character) RETURNS character
    LANGUAGE plpgsql
    AS $$
begin
  if(CAST((select count(*)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city) as int) <= 2)
			  then return 'minor city';
	 end if;
	if(CAST((select count(*)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city) as int) = 3)
	 then return 'normal city';
	 end if;
	 if(CAST((select count(*)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city) as int) > 3)
	 then return 'significant city';
	 end if;
end; $$;


ALTER FUNCTION public.city_itog(that_city character) OWNER TO postgres;

--
-- Name: int_sum(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.int_sum() RETURNS trigger
    LANGUAGE plpgsql
    AS $$declare parent_name int;
BEGIN
raise notice 'inserted %', COUNT(*) + 1 From "Acid_production";
return NEW;
END;$$;


ALTER FUNCTION public.int_sum() OWNER TO postgres;

--
-- Name: my_row_count(date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.my_row_count(a date, b date) RETURNS TABLE(data_count integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select CAST(COUNT(*) as int) FROM period(a, b));
end; $$;


ALTER FUNCTION public.my_row_count(a date, b date) OWNER TO postgres;

--
-- Name: period(date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.period(a date, b date) RETURNS TABLE(mydate date, concentration integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select "Date", "Concentration" from "Acid_production" where "Acid_production"."Date" > a
 and "Acid_production"."Date" < b);
end; $$;


ALTER FUNCTION public.period(a date, b date) OWNER TO postgres;

--
-- Name: sum_obj(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sum_obj(a integer) RETURNS TABLE(city character, sum_con integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select "City", (select CAST(sum("Concentration") as int) from "Acid_production" 
								 where "Cities"."ID_city" = "Acid_production"."City") as sum_conc
				from "Cities"
				where (select sum("Concentration") from "Acid_production" 
								 where "Cities"."ID_city" = "Acid_production"."City") > a);
end; $$;


ALTER FUNCTION public.sum_obj(a integer) OWNER TO postgres;

--
-- Name: that_obj_stat(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.that_obj_stat(that_city character) RETURNS TABLE(max_con integer, min_con integer, avg_con integer)
    LANGUAGE plpgsql
    AS $$
begin
 return QUERY(select cast(max("Concentration") as int), cast(min("Concentration") as int), cast(avg("Concentration")  as int)
			  from "Acid_production", "Cities" where "Cities"."ID_city" = "Acid_production"."City"
			  and "Cities"."City" = that_city);
end; $$;


ALTER FUNCTION public.that_obj_stat(that_city character) OWNER TO postgres;

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
COPY public."Acid_production" ("ID", "Date", "Concentration", "Product_value", "Reactor", "Reactor_value", "City") FROM '$$PATH$$/3364.dat';

--
-- Data for Name: Cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cities" ("ID_city", "City") FROM stdin;
\.
COPY public."Cities" ("ID_city", "City") FROM '$$PATH$$/3360.dat';

--
-- Data for Name: Reactors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reactors" ("ID_reactor", "Reactor") FROM stdin;
\.
COPY public."Reactors" ("ID_reactor", "Reactor") FROM '$$PATH$$/3362.dat';

--
-- Name: Acid_production_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Acid_production_ID_seq"', 23, true);


--
-- Name: Cities_ID_city_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cities_ID_city_seq"', 7, true);


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
-- Name: Cities alterdel_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER alterdel_tr BEFORE DELETE ON public."Cities" FOR EACH ROW EXECUTE FUNCTION public.alter_del();


--
-- Name: Acid_production befordel_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER befordel_tr BEFORE DELETE ON public."Acid_production" FOR EACH ROW EXECUTE FUNCTION public.before_del();


--
-- Name: Acid_production beforeupdate_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER beforeupdate_tr BEFORE UPDATE ON public."Acid_production" FOR EACH ROW EXECUTE FUNCTION public.before_update_val();


--
-- Name: Acid_production int_sum_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER int_sum_tr BEFORE INSERT ON public."Acid_production" FOR EACH ROW EXECUTE FUNCTION public.int_sum();


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

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     