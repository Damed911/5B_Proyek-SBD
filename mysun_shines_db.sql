--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: banktf; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.banktf AS ENUM (
    'BNI',
    'BCA',
    'Mandiri'
);


ALTER TYPE public.banktf OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: akun_p; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.akun_p (
    nama_acc character varying(60) NOT NULL,
    nama_cust text NOT NULL,
    email character varying(60),
    nomor_telfon text NOT NULL,
    alamat_rumah text NOT NULL
);


ALTER TABLE public.akun_p OWNER TO postgres;

--
-- Name: produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produk (
    id_p bigint NOT NULL,
    nama_prod text NOT NULL,
    jumlah_stok integer,
    harga integer NOT NULL,
    deskripsi text,
    gambar character varying(25)
);


ALTER TABLE public.produk OWNER TO postgres;

--
-- Name: produk_id_p_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produk_id_p_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produk_id_p_seq OWNER TO postgres;

--
-- Name: produk_id_p_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produk_id_p_seq OWNED BY public.produk.id_p;


--
-- Name: transaksi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaksi (
    id_t bigint NOT NULL,
    id_p bigint NOT NULL,
    nama_acc text NOT NULL,
    nama_prod text NOT NULL,
    nama_cust text NOT NULL,
    jumlah integer NOT NULL,
    harga_prod integer NOT NULL,
    total_harga bigint GENERATED ALWAYS AS ((jumlah * harga_prod)) STORED,
    metode_transaksi public.banktf NOT NULL
);


ALTER TABLE public.transaksi OWNER TO postgres;

--
-- Name: transaksi_id_t_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaksi_id_t_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaksi_id_t_seq OWNER TO postgres;

--
-- Name: transaksi_id_t_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaksi_id_t_seq OWNED BY public.transaksi.id_t;


--
-- Name: produk id_p; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk ALTER COLUMN id_p SET DEFAULT nextval('public.produk_id_p_seq'::regclass);


--
-- Name: transaksi id_t; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi ALTER COLUMN id_t SET DEFAULT nextval('public.transaksi_id_t_seq'::regclass);


--
-- Data for Name: akun_p; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.akun_p (nama_acc, nama_cust, email, nomor_telfon, alamat_rumah) FROM stdin;
AfghanAF	Afghan	afghan123@gmail.com	8111243512	Jalan Pondok Ranji
DistiraY	Yudhistira	yudhis123@gmail.com	8111243512	Jalan Kebayoran Lama
Kalulalulaa	Kalula	kalula123@gmail.com	8111243512	Jalan Menteng
Abu2Sasha	Sasha	sasha123@gmail.com	8111243512	Jalan Pondok Labu
Yohans	Yohan	yohan123@gmail.com	8111243512	Jalan Kriweng
\.


--
-- Data for Name: produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk (id_p, nama_prod, jumlah_stok, harga, deskripsi, gambar) FROM stdin;
32	Kaos Dinosaurus	30	60000	Kaos casual untuk anak, bermotif dinosaurus, warna baju ada putih, hitam, dan biru	dinoshirt.jpg
33	Mainan Truk	50	82000	Mainan untuk anak berupa mobil truk berwarna merah	trucktoy.jpg
35	Fashion Set Perempuan (Bunga)	20	105000	Set pakaian untuk anak perempuan berupa kaos dan rok bermotif bunga	girlsetflower.jpg
36	Sepatu Sneakers	80	65000	Sepatu sneakers untuk anak dengan variasi warna putih, biru, merah, dan beige	sneakers1.jpg
34	Boneka Beruang	55	75000	Boneka beruang berwarna coklat yang terbuat dari bahan halus dan empuk	teddybear.jpg
\.


--
-- Data for Name: transaksi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaksi (id_t, id_p, nama_acc, nama_prod, nama_cust, jumlah, harga_prod, metode_transaksi) FROM stdin;
\.


--
-- Name: produk_id_p_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produk_id_p_seq', 37, true);


--
-- Name: transaksi_id_t_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaksi_id_t_seq', 7, true);


--
-- Name: akun_p akun_p_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.akun_p
    ADD CONSTRAINT akun_p_pkey PRIMARY KEY (nama_acc);


--
-- Name: produk produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk
    ADD CONSTRAINT produk_pkey PRIMARY KEY (id_p);


--
-- Name: transaksi transaksi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi
    ADD CONSTRAINT transaksi_pkey PRIMARY KEY (id_t);


--
-- Name: transaksi fk_akun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi
    ADD CONSTRAINT fk_akun FOREIGN KEY (nama_acc) REFERENCES public.akun_p(nama_acc);


--
-- Name: transaksi fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi
    ADD CONSTRAINT fk_prod FOREIGN KEY (id_p) REFERENCES public.produk(id_p);


--
-- PostgreSQL database dump complete
--

