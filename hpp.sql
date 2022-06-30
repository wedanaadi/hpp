/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `m_akun`;
CREATE TABLE `m_akun` (
  `id` varchar(100) NOT NULL,
  `kode_sub` varchar(100) DEFAULT NULL,
  `nama_akun` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  `sistem` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_barang`;
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
  `subcategory_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_category`;
CREATE TABLE `m_category` (
  `id` varchar(100) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `is_aktif` tinyint(4) NOT NULL DEFAULT 1,
  `code_category` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_satuan`;
CREATE TABLE `m_satuan` (
  `id` varchar(100) NOT NULL,
  `nama_satuan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_subcategory`;
CREATE TABLE `m_subcategory` (
  `id` varchar(100) NOT NULL,
  `category_id` varchar(100) NOT NULL,
  `subcategory_name` varchar(100) NOT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  `code_subcategory` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_subklasifikasi`;
CREATE TABLE `m_subklasifikasi` (
  `id` varchar(100) NOT NULL,
  `kode_subklasifikasi` varchar(20) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_supplier`;
CREATE TABLE `m_supplier` (
  `id` varchar(100) NOT NULL,
  `kode_pemasok` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telp` varchar(20) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `m_user`;
CREATE TABLE `m_user` (
  `id` varchar(100) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `hak_akses` tinyint(4) DEFAULT NULL,
  `is_aktif` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_jurnal_umum`;
CREATE TABLE `t_jurnal_umum` (
  `id` varchar(100) NOT NULL,
  `akun` varchar(100) NOT NULL,
  `debet` double DEFAULT NULL,
  `kredit` double DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `link_id` varchar(100) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_pembelian`;
CREATE TABLE `t_pembelian` (
  `id` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL,
  `akun_id` varchar(100) NOT NULL,
  `supplier_id` varchar(100) NOT NULL,
  `jumlah_trx` int(11) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_pembelian_detail`;
CREATE TABLE `t_pembelian_detail` (
  `id` varchar(100) NOT NULL,
  `pembelian_id` varchar(100) NOT NULL,
  `barang_id` varchar(100) NOT NULL,
  `qty` double NOT NULL,
  `harga` double NOT NULL,
  `harga_terakhir` double NOT NULL,
  `unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_penjualan`;
CREATE TABLE `t_penjualan` (
  `id` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL,
  `akun_id` varchar(100) NOT NULL,
  `jumlah_trx` int(11) NOT NULL,
  `desc` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_penjualan_detail`;
CREATE TABLE `t_penjualan_detail` (
  `id` varchar(100) NOT NULL,
  `penjualan_id` varchar(100) NOT NULL,
  `barang_id` varchar(100) NOT NULL,
  `qty` double NOT NULL,
  `harga` double NOT NULL,
  `unit` varchar(50) NOT NULL,
  `total` double DEFAULT NULL,
  `actual_harga` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_produksi`;
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
  `stock_produksi` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_produksi_detail`;
CREATE TABLE `t_produksi_detail` (
  `id` varchar(100) NOT NULL,
  `produksi_id` varchar(100) NOT NULL,
  `bahan_id` varchar(100) NOT NULL,
  `qty` double DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `m_akun` (`id`, `kode_sub`, `nama_akun`, `type`, `is_aktif`, `sistem`) VALUES
('33204f40-bc12-11ec-a7df-0994e4bee230', '5501-0001', 'HPP', 'Aktiva', 1, 1);
INSERT INTO `m_akun` (`id`, `kode_sub`, `nama_akun`, `type`, `is_aktif`, `sistem`) VALUES
('3fb95260-bc12-11ec-81b9-891ac0a8faf0', '3301-0001', 'Modal', 'Passiva', 1, 1);
INSERT INTO `m_akun` (`id`, `kode_sub`, `nama_akun`, `type`, `is_aktif`, `sistem`) VALUES
('55cf7760-f364-11ec-9462-7dc23847a622', '3301-0002', 'Inv - Food', 'Aktiva', 1, 0);
INSERT INTO `m_akun` (`id`, `kode_sub`, `nama_akun`, `type`, `is_aktif`, `sistem`) VALUES
('6c787350-f364-11ec-8820-07f44fbfc3e1', '5501-0002', 'Out - Food', 'Passiva', 1, 0),
('7ddecf40-bc12-11ec-80d7-652d0c0589f8', '5502-0001', 'Biaya Gaji', 'Passiva', 1, 1),
('820b4810-f69d-11ec-b0d3-a7aef5108213', '2201-0003', 'Trade Creditors', 'Passiva', 1, 0),
('a03b48c0-bc12-11ec-ab4a-a978f9eb3bf0', '2201-0001', 'Kewajiban', 'Passiva', 1, 1),
('bc756dd0-f363-11ec-966c-61e7a284723a', '3301-0002', 'Inv-Food', 'Aktiva', 0, 0),
('e3ddb460-bc11-11ec-be0b-15fa23b08e4f', '1101-0001', 'Akun Kas', 'Aktiva', 1, 1);

INSERT INTO `m_barang` (`id`, `kode`, `jenis`, `nama_barang`, `harga_beli`, `harga_jual`, `stock`, `satuan_id`, `last_purchase_price`, `is_aktif`, `foto`, `subcategory_id`) VALUES
('00bac060-f50a-11ec-8fc8-dd3f3987eac2', '00030', 1, 'Lada Hitam', 50000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '85058920-f2bd-11ec-8272-37444d04dadc');
INSERT INTO `m_barang` (`id`, `kode`, `jenis`, `nama_barang`, `harga_beli`, `harga_jual`, `stock`, `satuan_id`, `last_purchase_price`, `is_aktif`, `foto`, `subcategory_id`) VALUES
('06983c90-f2e9-11ec-b869-07f726180bf5', '00013', 1, 'Tomato', 12000, 0, 1.975, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '93409030-f2c7-11ec-8a5d-cd780d8246c6');
INSERT INTO `m_barang` (`id`, `kode`, `jenis`, `nama_barang`, `harga_beli`, `harga_jual`, `stock`, `satuan_id`, `last_purchase_price`, `is_aktif`, `foto`, `subcategory_id`) VALUES
('080398a0-f50e-11ec-93e3-2d7af42510a4', '00049', 1, 'Drum Stick', 39000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'dde025d0-f2cb-11ec-b460-c7da3f1ad3a4');
INSERT INTO `m_barang` (`id`, `kode`, `jenis`, `nama_barang`, `harga_beli`, `harga_jual`, `stock`, `satuan_id`, `last_purchase_price`, `is_aktif`, `foto`, `subcategory_id`) VALUES
('10248a70-f50c-11ec-b4bb-b5b0c1400b4a', '00036', 1, 'Tomato Paste', 40000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '1a7efe10-f2cd-11ec-805e-f10c32a3911b'),
('15aa6400-f2dc-11ec-b158-57e1a66cf9dc', '0005', 1, 'Carrot Import', 20000, 0, 4, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '6aa17700-f2c6-11ec-ba24-4194799fb70a'),
('17c2c4e0-f343-11ec-9274-97668ac14837', '00017', 1, 'White Toast', 1500, 0, 0.833, 'ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 0, 1, NULL, 'b219c620-f2c7-11ec-99af-2386531a86e1'),
('1f7c9110-f50a-11ec-82fb-f9b032b90aa1', '00031', 1, 'Marinara Sauce', 90000, 0, 0, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '039679d0-f2ce-11ec-8e96-45e359ffb588'),
('29684900-f50e-11ec-80fa-e70525e4f869', '00050', 1, 'Pork Belly', 80000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '39e50e30-f2cc-11ec-9ba1-b7eb92342933'),
('2bdcb6f0-f2dd-11ec-8650-19707b47830a', '0008', 1, 'Saus Tiram', 55000, 0, 0.95, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '757bdca0-f2bf-11ec-8320-b79c8f9f85df'),
('2c324ff0-f509-11ec-b969-0b1d8806c052', '00025', 1, 'Bolognese Sauce', 70000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '0d5ccfa0-f2cd-11ec-b8b7-19d59f0a5156'),
('31e52b40-f50c-11ec-82dc-c19a677d3622', '00037', 1, 'Chilli Green', 75000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'fd1aef50-f2ca-11ec-a678-390b3e3a6703'),
('38e63290-f530-11ec-b4e9-6f78d2ef7116', '00064', 1, 'Tepung - Terigu', 12000, 12000, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 12000, 1, NULL, 'a7f03310-f52f-11ec-86e2-f108fd5a8b2b'),
('39622ce0-f50d-11ec-aa2c-b52ebf78a014', '00043', 1, 'Cheddar Cheese', 120000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '03297230-f2cf-11ec-9603-272129c844bd'),
('3bf38c50-f2e9-11ec-b2be-b1daba6e8bef', '00015', 1, 'Lettuce Ice Berg', 32000, 0, 2, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '5a984c70-f2c7-11ec-abb6-53665a15d176'),
('43d996b0-f50c-11ec-ab30-7f74d76736c5', '00038', 1, 'Chilli Red', 80000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'ed916c60-f2ca-11ec-a3bd-d735e6e7001b'),
('47be8ee0-f50f-11ec-8c3b-c155eae5d65a', '00055', 1, 'Saus Teriyaki', 64800, 0, 0, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '82e33840-f2bf-11ec-a8ae-c9c8d267059e'),
('48969990-f2db-11ec-865a-015b3d50680e', '0001', 1, 'Beras 25 Kg', 10000, 0, 24.85, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '5239ece0-f2c1-11ec-ba55-b34b02c54762'),
('4d806110-f52e-11ec-9e5f-f922d7689d8d', '00058', 1, 'White Cabbage/Kol Putih', 17000, 17000, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '8f582fb0-f52d-11ec-8c16-f35d404f590e'),
('4f79fab0-f50e-11ec-ba23-63d75fa9878d', '00051', 1, 'Pork Ribs Bacon', 180000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '2ae80330-f2cc-11ec-b38f-774c793db24f'),
('538bc360-f530-11ec-8289-75e16a0ca289', '00065', 1, 'Bread Crumbs', 10000, 10000, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 10000, 1, NULL, 'daac2890-f52f-11ec-968d-81e007bc1b96'),
('5697fa30-f509-11ec-93ec-afe08987be00', '00026', 1, 'Burger Bun', 2000, 0, 0, 'ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 0, 1, NULL, '33435520-f2cf-11ec-b283-25734bf1d556'),
('58367cf0-f475-11ec-ab89-4b601d5aecc6', 'P0000006', 2, 'Caesar Salad W/Chicken (Al\'a Carte)', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('58c605f0-f50d-11ec-8ef1-e114727bfa8d', '00044', 1, 'Milk', 14000, 0, 0.95, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '2d17ba70-f2c8-11ec-acd8-3f1b572ec4fa'),
('5a454020-f471-11ec-a044-b12a132ce8df', 'P0000003', 2, 'Lumbung Favorite ( Fried Rice )', 0, 21120.117857143, 0, NULL, 0, 1, NULL, NULL),
('5bfbb8a0-f536-11ec-81f7-4d6c10e441ed', '00079', 1, 'Red Cabbage/Kol Merah', 60000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '182c6ce0-f530-11ec-ab81-417e0d67f63c'),
('5c845050-f2e9-11ec-8c88-37538e92a68d', '00016', 1, 'Satl/Garam', 10000, 0, 1.005, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '60fa7d60-f2bd-11ec-a1f8-b5f40375fe02'),
('5f54e380-f50a-11ec-8ded-4f558fb11991', '00024', 1, 'Mie Ayam Telor', 4000, 0, 0, 'ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 0, 1, NULL, '1d644b20-f2ca-11ec-a577-8fbe2fefdb4b'),
('6341f050-f2dd-11ec-ae80-1349043bc4b5', '0009', 1, 'Shrimp Crackers', 35000, 0, 2, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'f5c5f1f0-f2c0-11ec-be89-d3793cad14ff'),
('64e26be0-f343-11ec-8602-55c213827750', '00020', 1, 'Sweet Bread', 32000, 0, 0.9, '085975a0-f343-11ec-bb57-bdcb2a2e77cc', 0, 1, NULL, 'c44833d0-f2c7-11ec-bd0b-576f9b2d699a'),
('65a330e0-f48b-11ec-ba2e-1d65953ac186', '00022', 1, 'Bacon Sausage', 140000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '62567e00-f2cc-11ec-a959-d5b7cc4ffeba'),
('7159e070-f2db-11ec-a083-3b83258ac0d8', '0002', 1, 'Chicken Egg', 22000, 0, 3.8, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '2dd17ba0-f2c1-11ec-b87c-e710714e96c8'),
('715cf330-f508-11ec-beb7-15c17a16499b', '00023', 1, 'Lada Putih', 5, 0, 0, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, '8bccc440-f2bd-11ec-ab7b-11a76f59fec5'),
('72f5a560-f52e-11ec-8686-45aba922460b', '00059', 1, 'Bean Sprout/Tauge', 20000, 20000, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'a8115700-f52d-11ec-b22c-71f54f1b2e35'),
('7ce51c90-f50e-11ec-9bbb-73534763db87', '00052', 1, 'Pork Streaky Bacon', 115000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '4be86ec0-f2cc-11ec-9582-4d23fa1dc3ea'),
('7d4543a0-f2dc-11ec-98cc-5d1ad2a33677', '0006', 1, 'Arak Masak Siau Hing', 60000, 0, 0.99, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '810c2960-f2c6-11ec-b062-5bd048b5cdc2'),
('7e8906f0-f50c-11ec-96aa-6b96dbe4e986', '00039', 1, 'Banana', 40000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '62987c20-f2ce-11ec-b514-79fdeb3c615f'),
('7eeb65f0-f530-11ec-9518-f5d295e56aea', '00066', 1, 'Corn Flakes', 50000, 50000, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 50000, 1, NULL, 'ebd64530-f52f-11ec-ad52-ad6559e2fa84'),
('800ad260-f2d7-11ec-93e7-690bd3f64354', '0001', 1, 'Arak Masak Siau Hing', 25000, 0, 3, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 0, NULL, '810c2960-f2c6-11ec-b062-5bd048b5cdc2'),
('823657f0-f474-11ec-913b-89f2314d3d56', 'P0000004', 2, 'Continental Breakfast', 0, 38064.926742857, 1, NULL, 0, 1, NULL, NULL),
('82a395f0-f509-11ec-9f0f-8bf26b1115a7', '00027', 1, 'Coffee', 10000, 0, 0.98, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '05628020-f2c1-11ec-8bcb-31b34667d37f'),
('8321ed70-f50d-11ec-80d9-573c4e87fe44', '00045', 1, 'Chicken Leg Boneless', 41000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '43863870-f2cb-11ec-afad-81495b005058'),
('845ce4e0-f50f-11ec-b804-7f692f37aa4d', '00056', 1, 'Capsicum Green', 52000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '13b782d0-f2cb-11ec-8e4a-d117d94bb3ff'),
('86674480-f475-11ec-b1e8-2f2fb6031ea9', 'P0000007', 2, 'Chicken Nachos', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('8dd8db50-f477-11ec-9ce1-0f7952412bb6', 'P00000011', 2, 'Grilled Pork Ribs', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('92b93ad0-f50a-11ec-8342-3fa6ddb29d38', '00032', 1, 'Nasi Goreng Paste', 7, 0, 0, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, 'ed5e3010-f2cc-11ec-a61e-a1b26fd8ed99'),
('932b8c20-f52e-11ec-8b00-4fdccf49df23', '00060', 1, 'Onion/Bawang Bombai', 26000, 26000, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'df0ea850-f52d-11ec-aaa9-995a92cd38ba'),
('956649f0-f474-11ec-9172-c3a5c998d71f', 'P0000005', 2, 'Classic Breakfast', 0, 28162.058571429, 2, NULL, 0, 1, NULL, NULL),
('9fc7a8a0-f50b-11ec-8b41-75894b06acaa', '00035', 1, 'Tea', 50, 0, 0, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, '174205c0-f2c1-11ec-b2e4-27e86cf4bc17'),
('a212fca0-f509-11ec-ade0-6fa6b1f8281e', '00028', 1, 'French Fries Straight Cut', 150000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '51bd4e40-f2cf-11ec-b97f-e557f7a52ebc'),
('a21fcea0-f477-11ec-99cb-09b5da5d0be0', 'P00000012', 2, 'Pan Roasted Chicken', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('a28e5ae0-f2e8-11ec-8cb5-a97acb07e5b9', '00010', 1, 'Papaya', 5000, 0, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'f57c0380-f2c6-11ec-ac80-fd8fb328c3c3'),
('a4a220f0-f50e-11ec-aace-adb6e1e7d45f', '00053', 1, 'Whole Chicken', 55000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 55000, 1, NULL, '565ed130-f2cb-11ec-ae26-a593db135ce9'),
('a4fe23f0-f52a-11ec-a5d1-8d2a3dc01563', '00057', 1, 'Chicken Breast', 40000, 40000, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '5dd29010-f2ca-11ec-adbc-47338ba7cd27'),
('ac12e2f0-f50d-11ec-a90a-c3a8a4af3a9a', '00046', 1, 'Chicken Sausage', 92000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '11359cd0-f2cc-11ec-a95f-33722921c309'),
('ac31bc60-f2db-11ec-b67f-cd8fa7d07ecb', '0003', 1, 'Garlic', 30000, 0, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '3c22c900-f2c6-11ec-bcbe-a57b262737dd'),
('b1e8c380-f348-11ec-a9d3-4b4f1cabf017', '00019', 1, 'Strawberry Jam', 18000, 0, 0.97, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'd2c31080-f2c7-11ec-b740-d1131d38c7f3'),
('b67153c0-f52e-11ec-9f9b-41f2701fdda5', '00061', 1, 'Sesame Oil', 150000, 150000, 0, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, 'fe7eaa20-f52d-11ec-847d-354f788a1cb0'),
('bd12ed20-f477-11ec-a8eb-5903c1397d79', 'P00000013', 2, 'Hawaiian Chicken Pizza', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('bd4111d0-f50c-11ec-aed8-398d17ab30e2', '00040', 1, 'Grape (Anggur Merah)', 45000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '2f20d1d0-f2cb-11ec-b1c4-6f81b35c0a75'),
('be2392e0-f475-11ec-9d4b-47d8ab5451b3', 'P0000008', 2, 'Lumbung Beef Burger', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('c71bac40-f2db-11ec-884d-2347244fa750', '0004', 1, 'Caisim', 10000, 0, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '608de720-f2c6-11ec-b29d-653c43c71791'),
('c8007350-f477-11ec-9f5c-7b3c08df6176', 'P00000014', 2, 'Chicken BBQ Pizza', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('ca2cbcf0-f2e8-11ec-92ba-d9687e92a680', '00011', 1, 'Watermelon', 7000, 0, 3, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'e9edf430-f2c6-11ec-9865-819d918916f3'),
('cae907a0-f50d-11ec-9e8a-595245f8dd80', '00047', 1, 'Chicken Wings', 34000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, 'bc149530-f2cb-11ec-b780-394e554f86f8'),
('cb0b9f10-f2dc-11ec-bc70-4729144d759b', '0007', 1, 'Raja Rasa', 60000, 0, 0.95, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '13a7ee40-f2c0-11ec-96c7-8505be7e84c2'),
('cbbfb5e0-f353-11ec-bfab-79e98ebaf85b', '00014', 1, 'Unsalted Butter', 56, 0, 1, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, 'e12e6650-f2c7-11ec-8a31-efd16d930885'),
('cfe11da0-f379-11ec-91cc-27017b4547b3', '00021', 1, 'Sugar', 12000, 0, 11.988, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '96a95e00-f2dd-11ec-afbd-d7f18a9cf30e'),
('d06b2960-f475-11ec-932d-33123228d7d4', 'P0000009', 2, 'Club Sandwich', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('d4f98830-f477-11ec-a689-b130b3a99ee3', 'P00000015', 2, 'Margherita', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('d55bc400-f50c-11ec-a2d0-ad82c2b5a02a', '00041', 1, 'Orange Sunkist', 52000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '26eba220-f2cb-11ec-8f7e-17a93034c6dd'),
('d58dcf10-f474-11ec-9696-7d58c0b4536b', 'P0000001', 2, 'Spring Roll (Al\'a Carte)', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('d9380e70-f535-11ec-9765-51dee55652f3', '00067', 1, 'Mustard', 57000, 57000, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 57000, 1, NULL, 'fd7b4570-f52f-11ec-b60d-3b046697bd73'),
('db627ff0-f50a-11ec-ab1e-0be8a5100c38', '00033', 1, 'Saus Cabe', 35, 0, 0, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, '50ca5ee0-f2bd-11ec-aa90-2979b107d5eb'),
('dc144060-f52e-11ec-8d5a-75e061da0037', '00062', 1, 'Tepung - Maizena', 23000, 23000, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '0d5c16c0-f52e-11ec-b43f-8198b3c98e3c'),
('dc23e600-f536-11ec-bebd-0945de9e0e05', '00070', 1, 'Kulit Lumpia', 5, 5, 0, 'ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 0, 1, NULL, 'a7881620-f536-11ec-ab36-87b02c7e2f34'),
('e2e96a30-f509-11ec-afaf-c1831e278ed9', '00029', 1, 'Kecap Manis', 161000, 0, 0, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '6e04b490-f2bc-11ec-ac07-eb6c71a35fdc'),
('e5bb77a0-f2e8-11ec-985a-c7533aff98d8', '00012', 1, 'Cucumber', 250, 0, 85, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, '065c8760-f2c7-11ec-a9ab-75f7482f93e0'),
('e5e780c0-f2eb-11ec-a5a5-81fc05cf97dd', '00018', 1, 'Orange Sunquick', 87000, 0, 0.96, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, 'adbd7890-f2eb-11ec-9513-2398a4d15439'),
('e6c7ba30-f475-11ec-ab98-c5eae9a8f76a', 'P00000010', 2, 'Buritos', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('e7aa7ca0-f50d-11ec-bdcb-17c5167d8515', '00048', 1, 'Dory Fish', 45000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '29bb8100-f2cd-11ec-a7ab-5544964c5b5c'),
('e9ffe840-f474-11ec-a9b4-e16edf546cf7', 'P0000002', 2, 'Chicken Pop Corn (Al\'a Carte)', 0, 0, 0, NULL, 0, 1, NULL, NULL),
('edb623c0-f36e-11ec-bfb1-4542acc99a75', '00001', 2, 'Nasi Goreng', 60000, 60000, 1, 'c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 0, 0, NULL, '810c2960-f2c6-11ec-b062-5bd048b5cdc2'),
('ef1a4310-f535-11ec-965d-01cd7225058d', '00068', 1, 'Mayonaise', 29500, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 29500, 1, NULL, '061ba780-f530-11ec-a78d-075b5c053862'),
('f07eb240-f50e-11ec-91ba-417288efdfd5', '00054', 1, 'Leek', 24, 0, 0, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, '2d394d20-f2ca-11ec-9a66-99d569a9deca'),
('f0fa0540-f50c-11ec-a615-f93c72c99f5d', '00042', 1, 'Pinapple', 20000, 0, 0, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 1, NULL, '23e7a9d0-f2ce-11ec-9b22-7d84cd13faff'),
('f98d12b0-f50a-11ec-9570-874118e27450', '00034', 1, 'Saus Tomat', 35, 0, 0, 'c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 0, 1, NULL, '551de420-f2bc-11ec-93f8-d7018db7698f'),
('fcb91560-f2da-11ec-bb06-6d676bb09c4c', '0002', 1, 'Beras 25 Kg', 250000, 0, 1, 'cb608360-f2da-11ec-9f73-1573fea93b58', 0, 0, NULL, '5239ece0-f2c1-11ec-ba55-b34b02c54762'),
('fe1424a0-f52e-11ec-a7e4-9d26cf8bbb7d', '00063', 1, 'Sweet Chilli Sauce', 60000, 60000, 0, 'bdce2190-bc93-11ec-b1d8-0157e5fcf378', 0, 1, NULL, '20dcb140-f52e-11ec-91ff-a94f150eb29f');

INSERT INTO `m_category` (`id`, `category_name`, `is_aktif`, `code_category`) VALUES
('230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Groceries', 1, '600');
INSERT INTO `m_category` (`id`, `category_name`, `is_aktif`, `code_category`) VALUES
('6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Vegetable', 1, '100');
INSERT INTO `m_category` (`id`, `category_name`, `is_aktif`, `code_category`) VALUES
('77286860-f2bb-11ec-927c-413cae5a5e1a', 'Fruit', 1, '200');
INSERT INTO `m_category` (`id`, `category_name`, `is_aktif`, `code_category`) VALUES
('84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Dairy & Other', 1, '300'),
('90419c60-f2bb-11ec-9293-8f904418da23', 'Meat & Poultry', 1, '400'),
('b8eddcc0-f2bb-11ec-b40e-6f6adbbdadf0', 'Juices', 1, '500'),
('cd1b7300-f2bf-11ec-812d-c799c422603c', 'Leaf', 1, '700');

INSERT INTO `m_satuan` (`id`, `nama_satuan`) VALUES
('085975a0-f343-11ec-bb57-bdcb2a2e77cc', 'Loaf');
INSERT INTO `m_satuan` (`id`, `nama_satuan`) VALUES
('93452c00-b763-11ec-bced-a3b4735de092', 'Can');
INSERT INTO `m_satuan` (`id`, `nama_satuan`) VALUES
('ba889200-bc93-11ec-bda3-6dab5b7f946b', 'Jar');
INSERT INTO `m_satuan` (`id`, `nama_satuan`) VALUES
('bdce2190-bc93-11ec-b1d8-0157e5fcf378', 'Ltr'),
('c228a990-bbc2-11ec-a81c-a7ca6b359ee2', 'Gr'),
('c5d86cc0-bbc2-11ec-8b0a-bf5da412a7a1', 'Ml'),
('cb608360-f2da-11ec-9f73-1573fea93b58', 'Kg'),
('e3bdb7f0-f342-11ec-b012-fdf4803aba68', 'Loop'),
('e90dc410-b744-11ec-a535-f5e41b9e5fc2', 'Btl'),
('ec6b0b50-bbb6-11ec-b940-4bcbd3343879', 'Pcs'),
('ef5347d0-b744-11ec-b273-91c50c645f0b', 'Pack');

INSERT INTO `m_subcategory` (`id`, `category_id`, `subcategory_name`, `is_aktif`, `code_subcategory`) VALUES
('03297230-f2cf-11ec-9603-272129c844bd', '84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Cheddar Cheese', 1, '30003');
INSERT INTO `m_subcategory` (`id`, `category_id`, `subcategory_name`, `is_aktif`, `code_subcategory`) VALUES
('039679d0-f2ce-11ec-8e96-45e359ffb588', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Marinara Sauce', 1, '600017');
INSERT INTO `m_subcategory` (`id`, `category_id`, `subcategory_name`, `is_aktif`, `code_subcategory`) VALUES
('05628020-f2c1-11ec-8bcb-31b34667d37f', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Coffee', 1, '60002');
INSERT INTO `m_subcategory` (`id`, `category_id`, `subcategory_name`, `is_aktif`, `code_subcategory`) VALUES
('061ba780-f530-11ec-a78d-075b5c053862', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Mayonaise', 1, '600033'),
('065c8760-f2c7-11ec-a9ab-75f7482f93e0', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Cucumber', 1, '10004'),
('0d5c16c0-f52e-11ec-b43f-8198b3c98e3c', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Tepung - Maizena', 1, '600027'),
('0d5ccfa0-f2cd-11ec-b8b7-19d59f0a5156', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Bolognese Sauce', 1, '600015'),
('11359cd0-f2cc-11ec-a95f-33722921c309', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Sausage', 1, '40006'),
('13a7ee40-f2c0-11ec-96c7-8505be7e84c2', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Raja Rasa', 1, '60009'),
('13b782d0-f2cb-11ec-8e4a-d117d94bb3ff', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Capsicum Green', 1, '10009'),
('174205c0-f2c1-11ec-b2e4-27e86cf4bc17', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Tea', 1, '600021'),
('182c6ce0-f530-11ec-ab81-417e0d67f63c', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Red Cabbage/Kol Merah', 1, '100013'),
('1a7efe10-f2cd-11ec-805e-f10c32a3911b', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Tomato Paste', 1, '600016'),
('1d644b20-f2ca-11ec-a577-8fbe2fefdb4b', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Mie Ayam Telor', 1, '600012'),
('20dcb140-f52e-11ec-91ff-a94f150eb29f', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Sweet Chilli Sauce', 1, '600028'),
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
('8f582fb0-f52d-11ec-8c16-f35d404f590e', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'White Cabbage/Kol Putih', 1, '100010'),
('93409030-f2c7-11ec-8a5d-cd780d8246c6', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Tomato', 1, '10006'),
('96a95e00-f2dd-11ec-afbd-d7f18a9cf30e', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Sugar', 1, '600024'),
('a7881620-f536-11ec-ab36-87b02c7e2f34', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Kulit Lumpia', 1, '600034'),
('a7f03310-f52f-11ec-86e2-f108fd5a8b2b', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Tepung - Terigu', 1, '600029'),
('a8115700-f52d-11ec-b22c-71f54f1b2e35', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Bea Sprout/Tauge', 1, '100011'),
('adbd7890-f2eb-11ec-9513-2398a4d15439', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Orange Sunquick', 1, '600025'),
('b219c620-f2c7-11ec-99af-2386531a86e1', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'White Toast', 1, '600020'),
('bc149530-f2cb-11ec-b780-394e554f86f8', '90419c60-f2bb-11ec-9293-8f904418da23', 'Chicken Wing', 1, '40003'),
('c44833d0-f2c7-11ec-bd0b-576f9b2d699a', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Sweet Bread', 1, '600019'),
('d2c31080-f2c7-11ec-b740-d1131d38c7f3', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Strawberry Jam', 1, '600013'),
('daac2890-f52f-11ec-968d-81e007bc1b96', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Bread Crumbs', 1, '600030'),
('dde025d0-f2cb-11ec-b460-c7da3f1ad3a4', '90419c60-f2bb-11ec-9293-8f904418da23', 'Drum Stick', 1, '40005'),
('df0ea850-f52d-11ec-aaa9-995a92cd38ba', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Onion/Bawang Bombai', 1, '100012'),
('e12e6650-f2c7-11ec-8a31-efd16d930885', '84ddabb0-f2bb-11ec-a580-4f7865815ef7', 'Unsalted Butter', 1, '30007'),
('e9edf430-f2c6-11ec-9865-819d918916f3', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Watermelon', 1, '20001'),
('ebd64530-f52f-11ec-ad52-ad6559e2fa84', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Corn Flakes', 1, '600031'),
('ed5e3010-f2cc-11ec-a61e-a1b26fd8ed99', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Nasi Goreng Paste', 1, '600014'),
('ed916c60-f2ca-11ec-a3bd-d735e6e7001b', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Chilli Red', 1, '10007'),
('f57c0380-f2c6-11ec-ac80-fd8fb328c3c3', '77286860-f2bb-11ec-927c-413cae5a5e1a', 'Papaya', 1, '20002'),
('f5c5f1f0-f2c0-11ec-be89-d3793cad14ff', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Shrimp Crackers', 1, '60001'),
('fd1aef50-f2ca-11ec-a678-390b3e3a6703', '6514cf20-f2bb-11ec-9094-0f9882bea47e', 'Chilli Green', 1, '10008'),
('fd7b4570-f52f-11ec-b60d-3b046697bd73', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Mustard', 1, '600032'),
('fe7eaa20-f52d-11ec-847d-354f788a1cb0', '230b7f40-f2bf-11ec-a0cc-55e22051b6cd', 'Sesame Oil Fei Guan Heng', 1, '600026');

INSERT INTO `m_subklasifikasi` (`id`, `kode_subklasifikasi`, `is_aktif`) VALUES
('53b549b0-bc11-11ec-b3a0-5fd1c381e69b', '1101', 1);
INSERT INTO `m_subklasifikasi` (`id`, `kode_subklasifikasi`, `is_aktif`) VALUES
('663a7f80-bc11-11ec-ad8b-a5a916e2b8e5', '1102', 1);
INSERT INTO `m_subklasifikasi` (`id`, `kode_subklasifikasi`, `is_aktif`) VALUES
('6920bcc0-bc12-11ec-bb01-41be3740dacd', '5502', 1);
INSERT INTO `m_subklasifikasi` (`id`, `kode_subklasifikasi`, `is_aktif`) VALUES
('6f3a2cf0-bc11-11ec-90a5-b7e08b8735aa', '1103', 1),
('7bbb9120-f69d-11ec-a5a8-5d7843dceee5', '0002', 1),
('880547a0-bc11-11ec-b7f9-bf76a9bf7ed4', '5501', 1),
('9b3634d0-bc12-11ec-996d-db6787f8d69c', '2201', 1),
('dde85010-bc11-11ec-b769-6dc3a377e005', '3301', 1);

INSERT INTO `m_supplier` (`id`, `kode_pemasok`, `nama`, `alamat`, `telp`, `is_aktif`) VALUES
('5255f040-f2b0-11ec-a28c-3d9cc641042d', '01', 'PT. Andika Perkasa Sembako', 'Jalan Teuku Umar Barat', '0361 772233', 1);
INSERT INTO `m_supplier` (`id`, `kode_pemasok`, `nama`, `alamat`, `telp`, `is_aktif`) VALUES
('623b3810-f2b1-11ec-ba77-71e5ec9496db', '05', 'Toko 88 Seasoning', 'Jalan Sudirman', '0361 789061', 1);
INSERT INTO `m_supplier` (`id`, `kode_pemasok`, `nama`, `alamat`, `telp`, `is_aktif`) VALUES
('650a4bd0-f2b0-11ec-beed-d9a17303dd2e', '02', 'PT. Sindata Drink', 'Jalan Gatsu', '0361 645321', 1);
INSERT INTO `m_supplier` (`id`, `kode_pemasok`, `nama`, `alamat`, `telp`, `is_aktif`) VALUES
('79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', '03', 'UD. Primarasa Fruit & Vege', 'Denpasar Timur', '0361 890324', 1),
('9a104840-f2b0-11ec-a9ff-0fc133e92817', '04', 'UD. Daging & Seafood Segar', 'Jalan Petitenget 1000x', '0361 8478587', 1);

INSERT INTO `m_user` (`id`, `nama`, `username`, `password`, `hak_akses`, `is_aktif`) VALUES
('281a8a70-bc7d-11ec-b82e-2fb35b3142b5', 'Ari', 'acounting', '$2y$10$zaz23jcP7KkJ644DQR0TL.xr7fxYj.yAjF3nva9hGt.RFJjbBZzrC', 2, 1);
INSERT INTO `m_user` (`id`, `nama`, `username`, `password`, `hak_akses`, `is_aktif`) VALUES
('3a226dd0-bc7d-11ec-a046-bda343459b76', 'Tri', 'storekeeper', '$2y$10$dnuME5lf.Hj/Flce739y5.XvVrLVuamzAg5PM95BmXJ2XdsuvF01K', 1, 1);
INSERT INTO `m_user` (`id`, `nama`, `username`, `password`, `hak_akses`, `is_aktif`) VALUES
('498cfae0-bc7d-11ec-8f77-8fc531650bee', 'Wahyudi', 'fbservice', '$2y$10$DmTB8vlSVPIqp4LJr6AgE.z2GTYOEBUcpC8L5LZ8Ngo.PD0sqlVSW', 3, 1);
INSERT INTO `m_user` (`id`, `nama`, `username`, `password`, `hak_akses`, `is_aktif`) VALUES
('56d1c230-bc7d-11ec-9d9e-05aea8c391ce', 'Tya', 'fbproduct', '$2y$10$hQ0WUrlUwO3Fm/bTIjV8OeBoOMabXhV1xRsJuQkrd2ra4EUbWyGbq', 4, 1),
('9992c600-af5d-11ec-ae41-150f7c04192b', 'Administrator', 'admin', '$2y$10$qoybnadBKWVDEK7g2.o6.OaD3sPmiZHKcWZfwSD3oq5NxHSnoK.yK', 0, 1);

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1);


INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', '9992c600-af5d-11ec-ae41-150f7c04192b', 'ApiToken', 'c8fb069e54d40bac9ea94498035b142310b9cd141dfc36960ae391f13217d0ac', '[\"*\"]', NULL, '2022-06-28 03:00:49', '2022-06-28 03:00:49');


INSERT INTO `t_jurnal_umum` (`id`, `akun`, `debet`, `kredit`, `remark`, `link_id`, `date`) VALUES
('f22de2a0-f4f3-11ec-8928-2f49d1641011', '55cf7760-f364-11ec-9462-7dc23847a622', 370000, 0, 'TP220600008 Incoming Stock 08/06/2022', 'TP220600008', '2022-06-08 10:00:00');
INSERT INTO `t_jurnal_umum` (`id`, `akun`, `debet`, `kredit`, `remark`, `link_id`, `date`) VALUES
('acb094b0-f537-11ec-aff4-e9e2f941e7f3', '55cf7760-f364-11ec-9462-7dc23847a622', 129000, 0, 'TP220600002 Incoming Stock 04/06/2022', 'TP220600002', '2022-06-04 12:34:00');
INSERT INTO `t_jurnal_umum` (`id`, `akun`, `debet`, `kredit`, `remark`, `link_id`, `date`) VALUES
('f7a868c0-f69a-11ec-95dc-991ccf78af1e', '55cf7760-f364-11ec-9462-7dc23847a622', 118000, 0, 'TP220600004 Incoming Stock 11/06/2022', 'TP220600004', '2022-06-11 12:48:00');
INSERT INTO `t_jurnal_umum` (`id`, `akun`, `debet`, `kredit`, `remark`, `link_id`, `date`) VALUES
('12c28ee0-f69b-11ec-95c0-971e0844da40', '55cf7760-f364-11ec-9462-7dc23847a622', 80000, 0, 'TP220600005 Incoming Stock 14/06/2022', 'TP220600005', '2022-06-14 12:50:00'),
('5047ebf0-f69b-11ec-9f76-b159f2c55f84', '55cf7760-f364-11ec-9462-7dc23847a622', 36000, 0, 'TP220600006 Incoming Stock 17/06/2022', 'TP220600006', '2022-06-17 12:52:00'),
('5e8984c0-f69b-11ec-97c2-0f7e13ea7814', '55cf7760-f364-11ec-9462-7dc23847a622', 214000, 0, 'TP220600007 Incoming Stock 21/06/2022', 'TP220600007', '2022-06-21 12:55:00'),
('ed14fde0-f69b-11ec-8d57-59dc3afcb90f', '55cf7760-f364-11ec-9462-7dc23847a622', 347000, 0, 'TP220600001 Incoming Stock 01/06/2022', 'TP220600001', '2022-06-01 12:29:00'),
('c42f74e0-f69d-11ec-87aa-c19d9d6ffeb2', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 347000, 'TP220600001 Cash Advance Market List 01/06/2022', '0', '2022-06-01 12:52:00'),
('d01c7ca0-f6a1-11ec-ac7c-87473ce79480', '55cf7760-f364-11ec-9462-7dc23847a622', 66000, 0, 'TP220600003 Incoming Stock 24/06/2022', 'TP220600003', '2022-06-24 12:40:00'),
('eb1af800-f6a1-11ec-8e85-2526b813c2cc', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 129000, 'TP220600002 Cash Advance Market List 04/06/2022', '0', '2022-06-04 13:19:00'),
('26e08850-f6a2-11ec-9d14-196f8fa05ba4', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 370000, 'TP220600008 Cash Advance Market List 08/06/2022', '0', '2022-06-08 13:21:00'),
('5756df20-f6a2-11ec-927b-65886ce24dae', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 118000, 'TP220600004 Cash Advance Market List 08/06/2022', '0', '2022-06-11 13:22:00'),
('9fc9b1a0-f6a2-11ec-bb4e-d9dc6630a64e', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 80000, 'TP220600005 Cash Advance Market List 14/06/2022', '0', '2022-06-14 13:23:00'),
('d159e900-f6a2-11ec-8b04-ad8d2c06744a', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 36000, 'TP220600006 Cash Advance Market List 17/06/2022', '0', '2022-06-17 13:25:00'),
('27198b60-f6a4-11ec-8595-e784dbfc28fa', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 214000, 'TP220600007 Cash Advance Market List 21/06/2022', '0', '2022-06-21 13:35:00'),
('4650c2b0-f6a4-11ec-aeac-f5b834902495', '820b4810-f69d-11ec-b0d3-a7aef5108213', 0, 66000, 'TP220600003 Cash Advance Market List 24/06/2022', '0', '2022-06-24 13:36:00'),
('a72af6a0-f7b4-11ec-a6cc-5b66cc907efa', '6c787350-f364-11ec-8820-07f44fbfc3e1', 0, 30118, 'TS220600001 Outfood 09/06/2022', 'TS220600001', '2022-06-10 22:05:00');

INSERT INTO `t_pembelian` (`id`, `tanggal`, `akun_id`, `supplier_id`, `jumlah_trx`, `desc`) VALUES
('TP220600001', '2022-06-01 12:29:00', '55cf7760-f364-11ec-9462-7dc23847a622', '5255f040-f2b0-11ec-a28c-3d9cc641042d', 347000, 'Incoming Stock 01/06/2022');
INSERT INTO `t_pembelian` (`id`, `tanggal`, `akun_id`, `supplier_id`, `jumlah_trx`, `desc`) VALUES
('TP220600002', '2022-06-04 12:34:00', '55cf7760-f364-11ec-9462-7dc23847a622', '5255f040-f2b0-11ec-a28c-3d9cc641042d', 129000, 'Incoming Stock 04/06/2022');
INSERT INTO `t_pembelian` (`id`, `tanggal`, `akun_id`, `supplier_id`, `jumlah_trx`, `desc`) VALUES
('TP220600003', '2022-06-24 12:40:00', '55cf7760-f364-11ec-9462-7dc23847a622', '5255f040-f2b0-11ec-a28c-3d9cc641042d', 66000, 'Incoming Stock 24/06/2022');
INSERT INTO `t_pembelian` (`id`, `tanggal`, `akun_id`, `supplier_id`, `jumlah_trx`, `desc`) VALUES
('TP220600004', '2022-06-11 12:48:00', '55cf7760-f364-11ec-9462-7dc23847a622', '79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', 118000, 'Incoming Stock 11/06/2022'),
('TP220600005', '2022-06-14 12:50:00', '55cf7760-f364-11ec-9462-7dc23847a622', '79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', 80000, 'Incoming Stock 14/06/2022'),
('TP220600006', '2022-06-17 12:52:00', '55cf7760-f364-11ec-9462-7dc23847a622', '79a05e10-f2b0-11ec-827c-8d9e6ccfd21f', 36000, 'Incoming Stock 17/06/2022'),
('TP220600007', '2022-06-21 12:55:00', '55cf7760-f364-11ec-9462-7dc23847a622', '5255f040-f2b0-11ec-a28c-3d9cc641042d', 214000, 'Incoming Stock 21/06/2022'),
('TP220600008', '2022-06-08 10:00:00', '55cf7760-f364-11ec-9462-7dc23847a622', '5255f040-f2b0-11ec-a28c-3d9cc641042d', 370000, 'Incoming Stock 08/06/2022');

INSERT INTO `t_pembelian_detail` (`id`, `pembelian_id`, `barang_id`, `qty`, `harga`, `harga_terakhir`, `unit`) VALUES
('12b5ab50-f69b-11ec-b29d-8172d9120337', 'TP220600005', 'c71bac40-f2db-11ec-884d-2347244fa750', 2, 10000, 10000, 'Kg');
INSERT INTO `t_pembelian_detail` (`id`, `pembelian_id`, `barang_id`, `qty`, `harga`, `harga_terakhir`, `unit`) VALUES
('12c25440-f69b-11ec-8f6c-11320d4e352c', 'TP220600005', '15aa6400-f2dc-11ec-b158-57e1a66cf9dc', 3, 20000, 20000, 'Kg');
INSERT INTO `t_pembelian_detail` (`id`, `pembelian_id`, `barang_id`, `qty`, `harga`, `harga_terakhir`, `unit`) VALUES
('502ca680-f69b-11ec-8189-85656c278298', 'TP220600006', 'a28e5ae0-f2e8-11ec-8cb5-a97acb07e5b9', 3, 5000, 5000, 'Kg');
INSERT INTO `t_pembelian_detail` (`id`, `pembelian_id`, `barang_id`, `qty`, `harga`, `harga_terakhir`, `unit`) VALUES
('5047a750-f69b-11ec-ad21-315d6d3916fd', 'TP220600006', 'ca2cbcf0-f2e8-11ec-92ba-d9687e92a680', 3, 7000, 7000, 'Kg'),
('5e789350-f69b-11ec-9930-dd4c517330a1', 'TP220600007', '6341f050-f2dd-11ec-ae80-1349043bc4b5', 2, 35000, 35000, 'Kg'),
('5e8950e0-f69b-11ec-9d61-4b9fb7f08797', 'TP220600007', 'cfe11da0-f379-11ec-91cc-27017b4547b3', 12, 12000, 12000, 'Kg'),
('ac9ef740-f537-11ec-aae2-397c1486fc9f', 'TP220600002', '38e63290-f530-11ec-b4e9-6f78d2ef7116', 1, 12000, 12000, 'Kg'),
('acafe5d0-f537-11ec-b7ae-857e59ba772f', 'TP220600002', '538bc360-f530-11ec-8289-75e16a0ca289', 1, 10000, 10000, 'Kg'),
('acb020d0-f537-11ec-baad-09ff884c6125', 'TP220600002', '7eeb65f0-f530-11ec-9518-f5d295e56aea', 1, 50000, 50000, 'Kg'),
('acb05d10-f537-11ec-bd84-ddcac14bbe19', 'TP220600002', 'd9380e70-f535-11ec-9765-51dee55652f3', 1, 57000, 57000, 'Kg'),
('d01c3990-f6a1-11ec-8a43-554cc18bf028', 'TP220600003', '7159e070-f2db-11ec-a083-3b83258ac0d8', 3, 22000, 22000, 'Kg'),
('ed06cdd0-f69b-11ec-a1af-a3f5835774ac', 'TP220600001', '7159e070-f2db-11ec-a083-3b83258ac0d8', 1, 22000, 22000, 'Kg'),
('ed13ee90-f69b-11ec-82be-c304e77fb17b', 'TP220600001', 'c71bac40-f2db-11ec-884d-2347244fa750', 1, 10000, 10000, 'Kg'),
('ed142230-f69b-11ec-8aea-996e04fa8802', 'TP220600001', '15aa6400-f2dc-11ec-b158-57e1a66cf9dc', 1, 20000, 20000, 'Kg'),
('ed146000-f69b-11ec-8601-29596bf0ace0', 'TP220600001', '6341f050-f2dd-11ec-ae80-1349043bc4b5', 1, 35000, 35000, 'Kg'),
('ed1494c0-f69b-11ec-b22a-cb12480c355b', 'TP220600001', '5c845050-f2e9-11ec-8c88-37538e92a68d', 1, 10000, 10000, 'Kg'),
('ed14ca20-f69b-11ec-a04a-b75b54b96c64', 'TP220600001', '48969990-f2db-11ec-865a-015b3d50680e', 25, 10000, 10000, 'Kg'),
('f22d4a30-f4f3-11ec-b6c9-157ee8121104', 'TP220600008', '48969990-f2db-11ec-865a-015b3d50680e', 25, 10000, 10000, 'Kg'),
('f22da9b0-f4f3-11ec-8260-91728faf8dec', 'TP220600008', 'cfe11da0-f379-11ec-91cc-27017b4547b3', 10, 12000, 12000, 'Kg'),
('f7a311a0-f69a-11ec-9693-bd2ed4fbd2d1', 'TP220600004', 'e5bb77a0-f2e8-11ec-985a-c7533aff98d8', 120, 250, 250, 'Gr'),
('f7a7f7d0-f69a-11ec-9885-9f8b9b9ad251', 'TP220600004', '06983c90-f2e9-11ec-b869-07f726180bf5', 2, 12000, 12000, 'Kg'),
('f7a83050-f69a-11ec-90de-2d5d3e476d82', 'TP220600004', '3bf38c50-f2e9-11ec-b2be-b1daba6e8bef', 2, 32000, 32000, 'Kg');

INSERT INTO `t_penjualan` (`id`, `tanggal`, `akun_id`, `jumlah_trx`, `desc`) VALUES
('TS220600001', '2022-06-10 22:05:00', '6c787350-f364-11ec-8820-07f44fbfc3e1', 30118, 'Outfood 09/06/2022');


INSERT INTO `t_penjualan_detail` (`id`, `penjualan_id`, `barang_id`, `qty`, `harga`, `unit`, `total`, `actual_harga`) VALUES
('a7282b50-f7b4-11ec-b41c-cbe954c7d646', 'TS220600001', '5a454020-f471-11ec-a044-b12a132ce8df', 1, 30118.628571429, '-', 30118.628571429, 30118.628571429);


INSERT INTO `t_produksi` (`id`, `bahan_cost`, `overhead_cost`, `desired_cost`, `project_sell`, `tax_cost`, `sell_price`, `key_ing`, `preparation`, `barang_id`, `tanggal`, `stock_produksi`) VALUES
('P220600001', 5553.75, 555.38, 17454.642857143, 50000, 3665.47, 21120.117857143, 'Chicken Fried Rice, shrimp crackers, egg sunny side up, cucumber pickles, tropical fresh fruit', '1. Prepare and procces the fried rice					\n2. Friying egg to sunny side up					\n3. Frying shrimp crackers 					\n4. Set up fried rice on the plate, served with fried sunny side up on top, crackers and pickles					\n5. Trim & cut mixed fresh fruit, set up on the plate', '5a454020-f471-11ec-a044-b12a132ce8df', '2022-06-01 19:15:00', 1);
INSERT INTO `t_produksi` (`id`, `bahan_cost`, `overhead_cost`, `desired_cost`, `project_sell`, `tax_cost`, `sell_price`, `key_ing`, `preparation`, `barang_id`, `tanggal`, `stock_produksi`) VALUES
('P220600002', 10009.56, 1000.96, 31458.617142857, 50000, 6606.31, 38064.926742857, 'Toast bread, sweet bread of the day, juice of the day, Mixed tropical fresh fruit, bread condiment (jam & butter)', '1. Trim & cut mixed fresh fruit, set up on the plate				\n2. Toast the bread slice till golden brown, cut in diagonal,  set up on the plate, sweet bread, served with jam & Butter portion				\n3. Coordinate the beverage before send to the guest', '823657f0-f474-11ec-913b-89f2314d3d56', '2022-06-02 19:53:00', 1);
INSERT INTO `t_produksi` (`id`, `bahan_cost`, `overhead_cost`, `desired_cost`, `project_sell`, `tax_cost`, `sell_price`, `key_ing`, `preparation`, `barang_id`, `tanggal`, `stock_produksi`) VALUES
('P220600003', 7405.5, 740.55, 23274.428571429, 65000, 4887.63, 28162.058571429, 'Two egg any style, toasted bread, choice of pork bacon or breakfast sausage, coffee or tea, bread condiment, Mix tropical fresh fruit, orange juice', '1. Prepare and procces egg as request, grill bacon or sausage, arrange to plate				\n2. Trim & cut mixed fresh fruit, set up on the plate				\n3. Toast the bread slice till golden brown, cut in diagonal, set up on the plate, served with jam & Butter portion				\n4. Coordinate the beverage before send to the guest', '956649f0-f474-11ec-9172-c3a5c998d71f', '2022-06-03 21:33:00', 2);

INSERT INTO `t_produksi_detail` (`id`, `produksi_id`, `bahan_id`, `qty`, `unit`, `price`, `total`) VALUES
('6ee435e0-f803-11ec-a77b-e74819e1887d', 'P220600001', '48969990-f2db-11ec-865a-015b3d50680e', 150, 'Gr', 10, 1500);
INSERT INTO `t_produksi_detail` (`id`, `produksi_id`, `bahan_id`, `qty`, `unit`, `price`, `total`) VALUES
('6ee47230-f803-11ec-8979-e151c5b6d7b0', 'P220600001', '7159e070-f2db-11ec-a083-3b83258ac0d8', 100, 'Gr', 22, 2200);
INSERT INTO `t_produksi_detail` (`id`, `produksi_id`, `bahan_id`, `qty`, `unit`, `price`, `total`) VALUES
('6ee4a950-f803-11ec-9511-df59db4450a5', 'P220600001', 'ac31bc60-f2db-11ec-b67f-cd8fa7d07ecb', 15, 'Gr', 30, 450);
INSERT INTO `t_produksi_detail` (`id`, `produksi_id`, `bahan_id`, `qty`, `unit`, `price`, `total`) VALUES
('6ef26f50-f803-11ec-944a-b140011565df', 'P220600001', 'c71bac40-f2db-11ec-884d-2347244fa750', 50, 'Gr', 10, 500),
('6ef2a480-f803-11ec-9793-798ad69f2dab', 'P220600001', '15aa6400-f2dc-11ec-b158-57e1a66cf9dc', 40, 'Gr', 20, 800),
('6ef2d990-f803-11ec-8fe1-d55f7e150733', 'P220600001', '7d4543a0-f2dc-11ec-98cc-5d1ad2a33677', 10, 'Ml', 60, 600),
('6ef30b50-f803-11ec-b008-59d4bfddc551', 'P220600001', 'cb0b9f10-f2dc-11ec-bc70-4729144d759b', 5, 'Ml', 60, 300),
('6ef33710-f803-11ec-aa43-d19104f0eb25', 'P220600001', '2bdcb6f0-f2dd-11ec-8650-19707b47830a', 5, 'Ml', 55, 275),
('6ef367d0-f803-11ec-83aa-090062a6f963', 'P220600001', '6341f050-f2dd-11ec-ae80-1349043bc4b5', 10, 'Gr', 35, 350),
('6ef395e0-f803-11ec-8970-234ac324319f', 'P220600001', 'ca2cbcf0-f2e8-11ec-92ba-d9687e92a680', 300, 'Gr', 7, 2100),
('6ef3ca60-f803-11ec-bf9a-6320f96feaa8', 'P220600001', 'a28e5ae0-f2e8-11ec-8cb5-a97acb07e5b9', 250, 'Gr', 5, 1250),
('6ef421f0-f803-11ec-bb9d-cbd0c628ccee', 'P220600001', 'e5bb77a0-f2e8-11ec-985a-c7533aff98d8', 35, 'Gr', 0.25, 8.75),
('6ef46260-f803-11ec-9b5e-fbe126ce544d', 'P220600001', '06983c90-f2e9-11ec-b869-07f726180bf5', 25, 'Gr', 12, 300),
('6ef48dc0-f803-11ec-89c0-559e494d5f31', 'P220600001', '3bf38c50-f2e9-11ec-b2be-b1daba6e8bef', 10, 'Gr', 32, 320),
('6ef4bce0-f803-11ec-98fe-6764e3e82fa3', 'P220600001', '5c845050-f2e9-11ec-8c88-37538e92a68d', 5, 'Gr', 10, 50),
('be414c80-f805-11ec-9bd6-4767c0bbc55e', 'P220600002', '17c2c4e0-f343-11ec-9274-97668ac14837', 90, 'Gr', 1.5, 135),
('be418460-f805-11ec-8989-233b7e147a94', 'P220600002', '64e26be0-f343-11ec-8602-55c213827750', 100, 'Gr', 32, 3200),
('be41b190-f805-11ec-8b43-d9d7df2822dc', 'P220600002', 'ca2cbcf0-f2e8-11ec-92ba-d9687e92a680', 300, 'Gr', 7, 2100),
('be41dd40-f805-11ec-b4f7-33c53e7c989a', 'P220600002', 'a28e5ae0-f2e8-11ec-8cb5-a97acb07e5b9', 250, 'Gr', 5, 1250),
('be4205a0-f805-11ec-aea0-ddecfd7d1a3b', 'P220600002', 'e5e780c0-f2eb-11ec-a5a5-81fc05cf97dd', 20, 'Ml', 87, 1740),
('be423750-f805-11ec-b2e3-736341c61a15', 'P220600002', '82a395f0-f509-11ec-9f0f-8bf26b1115a7', 20, 'Gr', 10, 200),
('be426d10-f805-11ec-a93f-050317efd324', 'P220600002', '58c605f0-f50d-11ec-8ef1-e114727bfa8d', 50, 'Ml', 14, 700),
('be429b00-f805-11ec-897a-dfc05592438a', 'P220600002', 'b1e8c380-f348-11ec-a9d3-4b4f1cabf017', 30, 'Gr', 18, 540),
('be42c880-f805-11ec-b6c7-1794f92eb1f0', 'P220600002', 'cbbfb5e0-f353-11ec-bfab-79e98ebaf85b', 10, 'Gr', 0.056, 0.56),
('be42f7b0-f805-11ec-97e0-1160783b7f53', 'P220600002', 'cfe11da0-f379-11ec-91cc-27017b4547b3', 12, 'Gr', 12, 144),
('c0814810-f809-11ec-9895-d1755f16cb46', 'P220600003', '7159e070-f2db-11ec-a083-3b83258ac0d8', 100, 'Gr', 22, 2200),
('c08e6eb0-f809-11ec-afed-8f71362cf1ac', 'P220600003', '17c2c4e0-f343-11ec-9274-97668ac14837', 77, 'Gr', 1.5, 115.5),
('c08ee410-f809-11ec-9324-f7d263e4817c', 'P220600003', 'ca2cbcf0-f2e8-11ec-92ba-d9687e92a680', 300, 'Gr', 7, 2100),
('c08f2930-f809-11ec-8057-357845a0289e', 'P220600003', 'a28e5ae0-f2e8-11ec-8cb5-a97acb07e5b9', 250, 'Gr', 5, 1250),
('c08f6220-f809-11ec-90df-7bb9e5a03f92', 'P220600003', 'e5e780c0-f2eb-11ec-a5a5-81fc05cf97dd', 20, 'Ml', 87, 1740);


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;