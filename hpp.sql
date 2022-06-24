-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Jun 2022 pada 05.28
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hpp`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_akun`
--

CREATE TABLE `m_akun` (
  `id` varchar(100) NOT NULL,
  `kode_sub` varchar(100) DEFAULT NULL,
  `nama_akun` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  `sistem` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_akun`
--

INSERT INTO `m_akun` (`id`, `kode_sub`, `nama_akun`, `type`, `is_aktif`, `sistem`) VALUES
('33204f40-bc12-11ec-a7df-0994e4bee230', '5501-0001', 'HPP', 'Aktiva', 1, 1),
('3fb95260-bc12-11ec-81b9-891ac0a8faf0', '3301-0001', 'Modal', 'Passiva', 1, 1),
('55cf7760-f364-11ec-9462-7dc23847a622', '3301-0002', 'Inv - Food', 'Aktiva', 1, 0),
('6c787350-f364-11ec-8820-07f44fbfc3e1', '5501-0002', 'Out - Food', 'Passiva', 1, 0),
('7ddecf40-bc12-11ec-80d7-652d0c0589f8', '5502-0001', 'Biaya Gaji', 'Passiva', 1, 1),
('a03b48c0-bc12-11ec-ab4a-a978f9eb3bf0', '2201-0001', 'Kewajiban', 'Passiva', 1, 1),
('bc756dd0-f363-11ec-966c-61e7a284723a', '3301-0002', 'Inv-Food', 'Aktiva', 0, 0),
('e3ddb460-bc11-11ec-be0b-15fa23b08e4f', '1101-0001', 'Akun Kas', 'Aktiva', 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_barang`
--

CREATE TABLE `m_barang` (
  `id` varchar(100) NOT NULL,
  `kode` varchar(100) DEFAULT NULL,
  `jenis` tinyint(4) DEFAULT NULL,
  `nama_barang` varchar(100) DEFAULT NULL,
  `harga_beli` double DEFAULT NULL,
  `harga_jual` double DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `satuan_id` varchar(100) DEFAULT NULL,
  `last_purchase_price` int(11) DEFAULT NULL,
  `is_aktif` tinyint(4) NOT NULL DEFAULT 1,
  `foto` varchar(255) DEFAULT NULL,
  `subcategory_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_barang`
--

INSERT INTO `m_barang` (`id`, `kode`, `jenis`, `nama_barang`, `harga_beli`, `harga_jual`, `stock`, `satuan_id`, `last_purchase_price`, `is_aktif`, `foto`, `subcategory_id`) VALUES
('06983c90-f2e9-11ec-b869-07f726180bf5', '00013', 1, 'Tomato', 12000, 12000, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 12000, 1, NULL, '93409030-f2c7-11ec-8a5d-cd780d8246c6'),
('15aa6400-f2dc-11ec-b158-57e1a66cf9dc', '0005', 1, 'Carrot Import', 20000, 20000, 4, 'cb608360-f2da-11ec-9f73-1573fea93b58', 20000, 1, NULL, '6aa17700-f2c6-11ec-ba24-4194799fb70a'),
('17c2c4e0-f343-11ec-9274-97668ac14837', '00017', 1, 'WhiteToast', 30000, 0, 2, '085975a0-f343-11ec-bb57-bdcb2a2e77cc', 0, 1, NULL, 'b219c620-f2c7-11ec-99af-2386531a86e1'),
('2bdcb6f0-f2dd-11ec-8650-19707b47830a', '0008', 1, 'Saus Tiram', 22000, 0, 2, 'c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 22000, 1, NULL, '757bdca0-f2bf-11ec-8320-b79c8f9f85df'),
('3bf38c50-f2e9-11ec-b2be-b1daba6e8bef', '00015', 1, 'Lettuce Ice Berg', 32000, 32000, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 32000, 1, NULL, '5a984c70-f2c7-11ec-abb6-53665a15d176'),
('48969990-f2db-11ec-865a-015b3d50680e', '0001', 1, 'Beras 25 Kg', 250000, 250000, 2, 'cb608360-f2da-11ec-9f73-1573fea93b58', 250000, 1, NULL, '5239ece0-f2c1-11ec-ba55-b34b02c54762'),
('5c845050-f2e9-11ec-8c88-37538e92a68d', '00016', 1, 'Satl/Garam', 10000, 10000, 2, 'cb608360-f2da-11ec-9f73-1573fea93b58', 10000, 1, NULL, '60fa7d60-f2bd-11ec-a1f8-b5f40375fe02'),
('6341f050-f2dd-11ec-ae80-1349043bc4b5', '0009', 1, 'Shrimp Crackers', 35000, 0, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'f5c5f1f0-f2c0-11ec-be89-d3793cad14ff'),
('64e26be0-f343-11ec-8602-55c213827750', '00020', 1, 'Sweet Bread', 32000, 32000, 2, '085975a0-f343-11ec-bb57-bdcb2a2e77cc', 0, 1, NULL, 'c44833d0-f2c7-11ec-bd0b-576f9b2d699a'),
('7159e070-f2db-11ec-a083-3b83258ac0d8', '0002', 1, 'Chicken Egg', 2000, 0, 100, 'ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 2000, 1, NULL, '2dd17ba0-f2c1-11ec-b87c-e710714e96c8'),
('7d4543a0-f2dc-11ec-98cc-5d1ad2a33677', '0006', 1, 'Arak Masak Siau Hing', 60000, 0, 2, 'c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 60000, 1, NULL, '810c2960-f2c6-11ec-b062-5bd048b5cdc2'),
('800ad260-f2d7-11ec-93e7-690bd3f64354', '0001', 1, 'Arak Masak Siau Hing', 25000, 0, 3, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 0, NULL, '810c2960-f2c6-11ec-b062-5bd048b5cdc2'),
('a28e5ae0-f2e8-11ec-8cb5-a97acb07e5b9', '00010', 1, 'Papaya', 5000, 5000, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'f57c0380-f2c6-11ec-ac80-fd8fb328c3c3'),
('ac31bc60-f2db-11ec-b67f-cd8fa7d07ecb', '0003', 1, 'Garlic', 30000, 0, 2, 'cb608360-f2da-11ec-9f73-1573fea93b58', 30000, 1, NULL, '3c22c900-f2c6-11ec-bcbe-a57b262737dd'),
('b1e8c380-f348-11ec-a9d3-4b4f1cabf017', '00019', 1, 'Strawberry Jam', 18000, 18000, 1, 'ba889200-bc93-11ec-bda3-6dab5b7f946b', 0, 1, NULL, 'd2c31080-f2c7-11ec-b740-d1131d38c7f3'),
('c71bac40-f2db-11ec-884d-2347244fa750', '0004', 1, 'Caisim', 10000, 0, 2, 'cb608360-f2da-11ec-9f73-1573fea93b58', 10000, 1, NULL, '608de720-f2c6-11ec-b29d-653c43c71791'),
('ca2cbcf0-f2e8-11ec-92ba-d9687e92a680', '00011', 1, 'Watermelon', 7000, 7000, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'e9edf430-f2c6-11ec-9865-819d918916f3'),
('cb0b9f10-f2dc-11ec-bc70-4729144d759b', '0007', 1, 'Raja Rasa', 37000, 0, 2, 'c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 37000, 1, NULL, '13a7ee40-f2c0-11ec-96c7-8505be7e84c2'),
('cbbfb5e0-f353-11ec-bfab-79e98ebaf85b', '00014', 1, 'Unsalted Butter', 45000, 45000, 2, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, 'e12e6650-f2c7-11ec-8a31-efd16d930885'),
('e5bb77a0-f2e8-11ec-985a-c7533aff98d8', '00012', 1, 'Cucumber', 3000, 0, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 3000, 1, NULL, '065c8760-f2c7-11ec-a9ab-75f7482f93e0'),
('e5e780c0-f2eb-11ec-a5a5-81fc05cf97dd', '00018', 1, 'Orange Sunqick', 87000, 0, 2, 'c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 87000, 1, NULL, 'adbd7890-f2eb-11ec-9513-2398a4d15439'),
('fcb91560-f2da-11ec-bb06-6d676bb09c4c', '0002', 1, 'Beras 25 Kg', 250000, 0, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 0, NULL, '5239ece0-f2c1-11ec-ba55-b34b02c54762');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_category`
--

CREATE TABLE `m_category` (
  `id` varchar(100) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `is_aktif` tinyint(4) NOT NULL DEFAULT 1,
  `code_category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_category`
--

INSERT INTO `m_category` (`id`, `category_name`, `is_aktif`, `code_category`) VALUES
('230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Groceries', 1, '600'),
('6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Vegetable', 1, '100'),
('77286860-f2bb-11ec-927c-413cae5a5e1a', 'Fruit', 1, '200'),
('84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Dairy & Other', 1, '300'),
('90419c60-f2bb-11ec-9293-8f904418da23', 'Meat & Poultry', 1, '400'),
('b8eddcc0-f2bb-11ec-b40e-6f6adbbdadf0', 'Juices', 1, '500'),
('cd1b7300-f2bf-11ec-812d-c799c422603c', 'Leaf', 1, '700');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_satuan`
--

CREATE TABLE `m_satuan` (
  `id` varchar(100) NOT NULL,
  `nama_satuan` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_satuan`
--

INSERT INTO `m_satuan` (`id`, `nama_satuan`) VALUES
('085975a0-f343-11ec-bb57-bdcb2a2e77cc', 'Loaf'),
('93452c00-b763-11ec-bced-a3b4735de092', 'Can'),
('ba889200-bc93-11ec-bda3-6dab5b7f946b', 'Jar'),
('bdce2190-bc93-11ec-b1d8-0157e5fcf378', 'Ltr'),
('c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 'Gr'),
('c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 'Ml'),
('cb608360-f2da-11ec-9f73-1573fea93b58', 'Kg'),
('e3bdb7f0-f342-11ec-b012-fdf4803aba68', 'Loop'),
('e90dc410-b744-11ec-a535-f5e41b9e5fc2', 'Btl'),
('ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 'Pcs'),
('ef5347d0-b744-11ec-b273-91c50c645f0b', 'Pack');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_subcategory`
--

CREATE TABLE `m_subcategory` (
  `id` varchar(100) NOT NULL,
  `category_id` varchar(100) NOT NULL,
  `subcategory_name` varchar(100) NOT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  `code_subcategory` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_subcategory`
--

INSERT INTO `m_subcategory` (`id`, `category_id`, `subcategory_name`, `is_aktif`, `code_subcategory`) VALUES
('03297230-f2cf-11ec-9603-272129c844bd', '84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Cheddar Cheese', 1, '30003'),
('039679d0-f2ce-11ec-8e96-45e359ffb588', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Marinara Sauce', 1, '600017'),
('05628020-f2c1-11ec-8bcb-31b34667d37f', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Coffee', 1, '60002'),
('065c8760-f2c7-11ec-a9ab-75f7482f93e0', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Cucumber', 1, '10004'),
('0d5ccfa0-f2cd-11ec-b8b7-19d59f0a5156', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Bolognese Sauce', 1, '600015'),
('11359cd0-f2cc-11ec-a95f-33722921c309', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Sausage', 1, '40006'),
('13a7ee40-f2c0-11ec-96c7-8505be7e84c2', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Raja Rasa', 1, '60009'),
('13b782d0-f2cb-11ec-8e4a-d117d94bb3ff', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Capsicum Green', 1, '10009'),
('174205c0-f2c1-11ec-b2e4-27e86cf4bc17', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Tea', 1, '600021'),
('1a7efe10-f2cd-11ec-805e-f10c32a3911b', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Tomato Paste', 1, '600016'),
('1d644b20-f2ca-11ec-a577-8fbe2fefdb4b', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Mie Ayam Telor', 1, '600012'),
('23e7a9d0-f2ce-11ec-9b22-7d84cd13faff', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Pinapple', 1, '20005'),
('26eba220-f2cb-11ec-8f7e-17a93034c6dd', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Orange Sunkist', 1, '20003'),
('29bb8100-f2cd-11ec-a7ab-5544964c5b5c', '90419c60-f2bb-11ec-9293-8f904418da23', 'Dory Fish', 1, '400011'),
('2ae80330-f2cc-11ec-b38f-774c793db24f', '90419c60-f2bb-11ec-9293-8f904418da23', 'Pork Ribs Bacon', 1, '40009'),
('2d17ba70-f2c8-11ec-acd8-3f1b572ec4fa', '84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Milk', 1, '30008'),
('2d394d20-f2ca-11ec-9a66-99d569a9deca', 'cd1b7300-f2bf-11ec-812d-c799c422603c', 'Leek', 1, '70001'),
('2dd17ba0-f2c1-11ec-b87c-e710714e96c8', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Egg', 1, '40004'),
('2f20d1d0-f2cb-11ec-b1c4-6f81b35c0a75', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Grape', 1, '20004'),
('33435520-f2cf-11ec-b283-25734bf1d556', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Burger Bun', 1, '600022'),
('39e50e30-f2cc-11ec-9ba1-b7eb92342933', '90419c60-f2bb-11ec-9293-8f904418da23', 'Pork Belly', 1, '40008'),
('3c22c900-f2c6-11ec-bcbe-a57b262737dd', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Garlic', 1, '10001'),
('43863870-f2cb-11ec-afad-81495b005058', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Leg', 1, '40002'),
('4be86ec0-f2cc-11ec-9582-4d23fa1dc3ea', '90419c60-f2bb-11ec-9293-8f904418da23', 'Pork Streaky Bacon', 1, '40007'),
('50ca5ee0-f2bd-11ec-aa90-2979b107d5eb', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Saus Cabe', 1, '60003'),
('51bd4e40-f2cf-11ec-b97f-e557f7a52ebc', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'French Fries Straight Cut', 1, '600023'),
('5239ece0-f2c1-11ec-ba55-b34b02c54762', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Beras 25 Kg', 1, '600010'),
('551de420-f2bc-11ec-93f8-d7018db7698f', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Saus Tomat', 1, '60001'),
('565ed130-f2cb-11ec-ae26-a593db135ce9', '90419c60-f2bb-11ec-9293-8f904418da23', 'Whole Chicken', 1, '40004'),
('5a984c70-f2c7-11ec-abb6-53665a15d176', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Lettuce Ice Berg', 1, '10005'),
('5dd29010-f2ca-11ec-adbc-47338ba7cd27', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Breast', 1, '40001'),
('608de720-f2c6-11ec-b29d-653c43c71791', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Caisim', 1, '10002'),
('60fa7d60-f2bd-11ec-a1f8-b5f40375fe02', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Salt/Garam', 1, '60004'),
('62567e00-f2cc-11ec-a959-d5b7cc4ffeba', '90419c60-f2bb-11ec-9293-8f904418da23', 'Bacon Sausage', 1, '400010'),
('62987c20-f2ce-11ec-b514-79fdeb3c615f', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Banana', 1, '20006'),
('6aa17700-f2c6-11ec-ba24-4194799fb70a', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Carrot Import', 1, '10003'),
('6e04b490-f2bc-11ec-ac07-eb6c71a35fdc', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Kecap Manis', 1, '600018'),
('757bdca0-f2bf-11ec-8320-b79c8f9f85df', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Saus Tiram', 1, '60007'),
('810c2960-f2c6-11ec-b062-5bd048b5cdc2', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Arak Masak Siau Hing', 1, '600011'),
('82e33840-f2bf-11ec-a8ae-c9c8d267059e', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Saus Teriyaki', 1, '60008'),
('85058920-f2bd-11ec-8272-37444d04dadc', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Lada Hitam', 1, '60005'),
('8bccc440-f2bd-11ec-ab7b-11a76f59fec5', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Lada Putih', 1, '60006'),
('93409030-f2c7-11ec-8a5d-cd780d8246c6', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Tomato', 1, '10006'),
('96a95e00-f2dd-11ec-afbd-d7f18a9cf30e', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Sugar', 1, '600024'),
('adbd7890-f2eb-11ec-9513-2398a4d15439', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Orange Sunquick', 1, '600025'),
('b219c620-f2c7-11ec-99af-2386531a86e1', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'White Toast', 1, '600020'),
('bc149530-f2cb-11ec-b780-394e554f86f8', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Wing', 1, '40003'),
('c44833d0-f2c7-11ec-bd0b-576f9b2d699a', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Sweet Bread', 1, '600019'),
('d2c31080-f2c7-11ec-b740-d1131d38c7f3', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Strawberry Jam', 1, '600013'),
('dde025d0-f2cb-11ec-b460-c7da3f1ad3a4', '90419c60-f2bb-11ec-9293-8f904418da23', 'Drum Stick', 1, '40005'),
('e12e6650-f2c7-11ec-8a31-efd16d930885', '84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Unsalted Butter', 1, '30007'),
('e9edf430-f2c6-11ec-9865-819d918916f3', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Watermelon', 1, '20001'),
('ed5e3010-f2cc-11ec-a61e-a1b26fd8ed99', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Nasi Goreng Paste', 1, '600014'),
('ed916c60-f2ca-11ec-a3bd-d735e6e7001b', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Chilli Red', 1, '10007'),
('f57c0380-f2c6-11ec-ac80-fd8fb328c3c3', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Papaya', 1, '20002'),
('f5c5f1f0-f2c0-11ec-be89-d3793cad14ff', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Shrimp Crackers', 1, '60001'),
('fd1aef50-f2ca-11ec-a678-390b3e3a6703', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Chilli Green', 1, '10008');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_subklasifikasi`
--

CREATE TABLE `m_subklasifikasi` (
  `id` varchar(100) NOT NULL,
  `kode_subklasifikasi` varchar(20) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_subklasifikasi`
--

INSERT INTO `m_subklasifikasi` (`id`, `kode_subklasifikasi`, `is_aktif`) VALUES
('53b549b0-bc11-11ec-b3a0-5fd1c381e69b', '1101', 1),
('663a7f80-bc11-11ec-ad8b-a5a916e2b8e5', '1102', 1),
('6920bcc0-bc12-11ec-bb01-41be3740dacd', '5502', 1),
('6f3a2cf0-bc11-11ec-90a5-b7e08b8735aa', '1103', 1),
('880547a0-bc11-11ec-b7f9-bf76a9bf7ed4', '5501', 1),
('9b3634d0-bc12-11ec-996d-db6787f8d69c', '2201', 1),
('dde85010-bc11-11ec-b769-6dc3a377e005', '3301', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_supplier`
--

CREATE TABLE `m_supplier` (
  `id` varchar(100) NOT NULL,
  `kode_pemasok` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telp` varchar(20) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_supplier`
--

INSERT INTO `m_supplier` (`id`, `kode_pemasok`, `nama`, `alamat`, `telp`, `is_aktif`) VALUES
('5255f040-f2b0-11ec-a28c-3d9cc641042d', '01', 'PT. Andika Perkasa Sembako', 'Jalan Teuku Umar Barat', '0361 772233', 1),
('623b3810-f2b1-11ec-ba77-71e5ec9496db', '05', 'Toko 88 Seasoning', 'Jalan Sudirman', '0361 789061', 1),
('650a4bd0-f2b0-11ec-beed-d9a17303dd2e', '02', 'PT. Sindata Drink', 'Jalan Gatsu', '0361 645321', 1),
('79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', '03', 'CV. Primarasa Vegetable', 'Denpasar Timur', '0361 890324', 1),
('9a104840-f2b0-11ec-a9ff-0fc133e92817', '04', 'UD. Seafood Segar', 'Jalan Petitenget 1000x', '0361 8478587', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_user`
--

CREATE TABLE `m_user` (
  `id` varchar(100) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `hak_akses` tinyint(4) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_user`
--

INSERT INTO `m_user` (`id`, `nama`, `username`, `password`, `hak_akses`, `is_aktif`) VALUES
('281a8a70-bc7d-11ec-b82e-2fb35b3142b5', 'Ari', 'acounting', '$2y$10$zaz23jcP7KkJ644DQR0TL.xr7fxYj.yAjF3nva9hGt.RFJjbBZzrC', 2, 1),
('3a226dd0-bc7d-11ec-a046-bda343459b76', 'Tri', 'storekeeper', '$2y$10$dnuME5lf.Hj/Flce739y5.XvVrLVuamzAg5PM95BmXJ2XdsuvF01K', 1, 1),
('498cfae0-bc7d-11ec-8f77-8fc531650bee', 'Wahyudi', 'fbservice', '$2y$10$DmTB8vlSVPIqp4LJr6AgE.z2GTYOEBUcpC8L5LZ8Ngo.PD0sqlVSW', 3, 1),
('56d1c230-bc7d-11ec-9d9e-05aea8c391ce', 'Tya', 'fbproduct', '$2y$10$hQ0WUrlUwO3Fm/bTIjV8OeBoOMabXhV1xRsJuQkrd2ra4EUbWyGbq', 4, 1),
('9992c600-af5d-11ec-ae41-150f7c04192b', 'Administrator', 'admin', '$2y$10$qoybnadBKWVDEK7g2.o6.OaD3sPmiZHKcWZfwSD3oq5NxHSnoK.yK', 0, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', '9992c600-af5d-11ec-ae41-150f7c04192b', 'ApiToken', 'f29b4e88a05a73762776f88730de5e37ae5f38f81201dae598472158a48b190c', '[\"*\"]', NULL, '2022-06-24 00:24:37', '2022-06-24 00:24:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_jurnal_umum`
--

CREATE TABLE `t_jurnal_umum` (
  `id` varchar(100) NOT NULL,
  `akun` varchar(100) NOT NULL,
  `debet` double DEFAULT NULL,
  `kredit` double DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `link_id` varchar(100) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_jurnal_umum`
--

INSERT INTO `t_jurnal_umum` (`id`, `akun`, `debet`, `kredit`, `remark`, `link_id`, `date`) VALUES
('761a94b0-f364-11ec-90d7-95984725c646', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 250000, 'TP220600001 Chicken Egg', 'TP220600001', '2022-06-06 19:41:00'),
('8461dcd0-f364-11ec-bd3f-a1f061a2324c', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 40000, 'TP220600002 Caisim', 'TP220600002', '2022-06-01 19:46:00'),
('8a003630-f364-11ec-baa5-874a9233b558', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 40000, 'TP220600003 Carrot Import', 'TP220600003', '2022-06-02 19:48:00'),
('92aa6610-f364-11ec-80bc-39e417ac6997', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 119000, 'TP220600004 Saus Tiram', 'TP220600004', '2022-06-03 19:52:00'),
('9b02f1f0-f364-11ec-92f1-e9903abd1691', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 50000, 'TP220600006 Lettuce Ice Berg', 'TP220600006', '2022-06-05 20:01:00'),
('a6ebd440-f364-11ec-bd21-4bc4627c95be', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 10000, 'TP220600007 Slat/Garam', 'TP220600007', '2022-06-07 06:09:00'),
('ad1da020-f364-11ec-85d1-3b1f1a85da06', '55cf7760-f364-11ec-9462-7dc23847a622', 0, 87000, 'TP220600005 Orange Sunquick', 'TP220600005', '2022-06-23 20:01:10'),
('f2ff2600-f366-11ec-bdaa-a78174a2a071', '6c787350-f364-11ec-8820-07f44fbfc3e1', 250000, 0, 'TS220600001 Nasi Goreng', 'TS220600001', '2022-06-24 10:39:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_pembelian`
--

CREATE TABLE `t_pembelian` (
  `id` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL,
  `akun_id` varchar(100) NOT NULL,
  `supplier_id` varchar(100) NOT NULL,
  `jumlah_trx` int(11) NOT NULL,
  `desc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_pembelian`
--

INSERT INTO `t_pembelian` (`id`, `tanggal`, `akun_id`, `supplier_id`, `jumlah_trx`, `desc`) VALUES
('TP220600001', '2022-06-06 19:41:00', '55cf7760-f364-11ec-9462-7dc23847a622', '5255f040-f2b0-11ec-a28c-3d9cc641042d', 250000, 'Chicken Egg'),
('TP220600002', '2022-06-01 19:46:00', '55cf7760-f364-11ec-9462-7dc23847a622', '79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', 40000, 'Caisim'),
('TP220600003', '2022-06-02 19:48:00', '55cf7760-f364-11ec-9462-7dc23847a622', '79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', 40000, 'Carrot Import'),
('TP220600004', '2022-06-03 19:52:00', '55cf7760-f364-11ec-9462-7dc23847a622', '623b3810-f2b1-11ec-ba77-71e5ec9496db', 119000, 'Saus Tiram'),
('TP220600005', '2022-06-23 20:01:10', '55cf7760-f364-11ec-9462-7dc23847a622', '650a4bd0-f2b0-11ec-beed-d9a17303dd2e', 87000, 'Orange Sunquick'),
('TP220600006', '2022-06-05 20:01:00', '55cf7760-f364-11ec-9462-7dc23847a622', '79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', 50000, 'Lettuce Ice Berg'),
('TP220600007', '2022-06-07 06:09:00', '55cf7760-f364-11ec-9462-7dc23847a622', '623b3810-f2b1-11ec-ba77-71e5ec9496db', 10000, 'Slat/Garam');

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_pembelian_detail`
--

CREATE TABLE `t_pembelian_detail` (
  `id` varchar(100) NOT NULL,
  `pembelian_id` varchar(100) NOT NULL,
  `barang_id` varchar(100) NOT NULL,
  `qty` double NOT NULL,
  `harga` double NOT NULL,
  `harga_terakhir` double NOT NULL,
  `unit` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_pembelian_detail`
--

INSERT INTO `t_pembelian_detail` (`id`, `pembelian_id`, `barang_id`, `qty`, `harga`, `harga_terakhir`, `unit`) VALUES
('7609bbc0-f364-11ec-8326-0fa0fbc79502', 'TP220600001', '48969990-f2db-11ec-865a-015b3d50680e', 1, 250000, 250000, 'Kg'),
('846169e0-f364-11ec-b260-418feb1d7191', 'TP220600002', 'ac31bc60-f2db-11ec-b67f-cd8fa7d07ecb', 1, 30000, 30000, 'Kg'),
('8461a4c0-f364-11ec-8117-7d54dc0f2981', 'TP220600002', 'c71bac40-f2db-11ec-884d-2347244fa750', 1, 10000, 10000, 'Kg'),
('89fffc50-f364-11ec-9816-a523eb5fad32', 'TP220600003', '15aa6400-f2dc-11ec-b158-57e1a66cf9dc', 2, 20000, 20000, 'Kg'),
('929c4f90-f364-11ec-b754-e3620e65dd67', 'TP220600004', '7d4543a0-f2dc-11ec-98cc-5d1ad2a33677', 1, 60000, 60000, 'Ml'),
('92a9f540-f364-11ec-a107-c1e8904af079', 'TP220600004', 'cb0b9f10-f2dc-11ec-bc70-4729144d759b', 1, 37000, 37000, 'Ml'),
('92aa3110-f364-11ec-a511-cde50b7ebcb4', 'TP220600004', '2bdcb6f0-f2dd-11ec-8650-19707b47830a', 1, 22000, 22000, 'Ml'),
('9b026680-f364-11ec-ac87-a1e92884f15a', 'TP220600006', 'e5bb77a0-f2e8-11ec-985a-c7533aff98d8', 2, 3000, 3000, 'Gr'),
('9b0296e0-f364-11ec-ae20-c163f7ae0744', 'TP220600006', '06983c90-f2e9-11ec-b869-07f726180bf5', 1, 12000, 12000, 'Kg'),
('9b02c3a0-f364-11ec-b450-4f0bc38cae3c', 'TP220600006', '3bf38c50-f2e9-11ec-b2be-b1daba6e8bef', 1, 32000, 32000, 'Kg'),
('a6eb9700-f364-11ec-8a61-85678fad4c76', 'TP220600007', '5c845050-f2e9-11ec-8c88-37538e92a68d', 1, 10000, 10000, 'Kg'),
('ad10edf0-f364-11ec-a3f2-31a2addb95d2', 'TP220600005', 'e5e780c0-f2eb-11ec-a5a5-81fc05cf97dd', 1, 87000, 87000, 'Ml');

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_penjualan`
--

CREATE TABLE `t_penjualan` (
  `id` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL,
  `akun_id` varchar(100) NOT NULL,
  `jumlah_trx` int(11) NOT NULL,
  `desc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_penjualan`
--

INSERT INTO `t_penjualan` (`id`, `tanggal`, `akun_id`, `jumlah_trx`, `desc`) VALUES
('TS220600001', '2022-06-24 10:39:25', '6c787350-f364-11ec-8820-07f44fbfc3e1', 250000, 'Nasi Goreng');

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_penjualan_detail`
--

CREATE TABLE `t_penjualan_detail` (
  `id` varchar(100) NOT NULL,
  `penjualan_id` varchar(100) NOT NULL,
  `barang_id` varchar(100) NOT NULL,
  `qty` double NOT NULL,
  `harga` double NOT NULL,
  `unit` varchar(50) NOT NULL,
  `total` double DEFAULT NULL,
  `actual_harga` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_penjualan_detail`
--

INSERT INTO `t_penjualan_detail` (`id`, `penjualan_id`, `barang_id`, `qty`, `harga`, `unit`, `total`, `actual_harga`) VALUES
('f2fec490-f366-11ec-b11d-2360f9e2aa0b', 'TS220600001', '48969990-f2db-11ec-865a-015b3d50680e', 1, 250000, 'Kg', 250000, 250000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_produksi`
--

CREATE TABLE `t_produksi` (
  `id` varchar(100) NOT NULL,
  `bahan_cost` double NOT NULL,
  `overhead_cost` double(20,2) NOT NULL,
  `desired_cost` double NOT NULL,
  `project_sell` double NOT NULL,
  `tax_cost` double(20,2) NOT NULL,
  `sell_price` double NOT NULL,
  `key_ing` text NOT NULL,
  `preparation` text NOT NULL,
  `barang_id` varchar(100) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  `stock_produksi` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_produksi_detail`
--

CREATE TABLE `t_produksi_detail` (
  `id` varchar(100) NOT NULL,
  `produksi_id` varchar(100) NOT NULL,
  `bahan_id` varchar(100) NOT NULL,
  `qty` double DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_akun`
--
ALTER TABLE `m_akun`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_barang`
--
ALTER TABLE `m_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_category`
--
ALTER TABLE `m_category`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_satuan`
--
ALTER TABLE `m_satuan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_subcategory`
--
ALTER TABLE `m_subcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_subklasifikasi`
--
ALTER TABLE `m_subklasifikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_supplier`
--
ALTER TABLE `m_supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_user`
--
ALTER TABLE `m_user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `t_pembelian`
--
ALTER TABLE `t_pembelian`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_pembelian_detail`
--
ALTER TABLE `t_pembelian_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_penjualan`
--
ALTER TABLE `t_penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_penjualan_detail`
--
ALTER TABLE `t_penjualan_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_produksi`
--
ALTER TABLE `t_produksi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_produksi_detail`
--
ALTER TABLE `t_produksi_detail`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
