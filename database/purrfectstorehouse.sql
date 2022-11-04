-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2022 at 09:24 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `purrfectstorehouse`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `password`) VALUES
(1, 'admin@gmail.com', '1234'),
(2, 'admin2@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ordered_items`
--

CREATE TABLE `ordered_items` (
  `id` int(11) NOT NULL,
  `user_order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ordered_price` int(11) DEFAULT NULL,
  `ordered_quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ordered_items`
--

INSERT INTO `ordered_items` (`id`, `user_order_id`, `product_id`, `ordered_price`, `ordered_quantity`) VALUES
(1, 1, 10, 200, 1),
(2, 2, 1, 100, 1),
(3, 3, 28, 12, 1),
(4, 4, 42, 5, 1),
(5, 5, 2, 600, 1),
(6, 5, 45, 32, 1),
(7, 5, 52, 29, 2),
(8, 6, 1, 100, 1),
(9, 6, 49, 32, 1),
(11, 7, 7, 1, 2),
(12, 7, 38, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `pid` int(11) NOT NULL,
  `pname` varchar(255) NOT NULL,
  `pprice` float(8,2) UNSIGNED NOT NULL,
  `pdiscription` varchar(255) NOT NULL,
  `pimage` varchar(255) NOT NULL,
  `pcategory` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`pid`, `pname`, `pprice`, `pdiscription`, `pimage`, `pcategory`) VALUES
(1, 'dog bed', 100.00, '     comfy bed for dogs to sleep properly', 'assets/uploads/37c3c3c6c591cc1764704de13dca3cef', 'dog'),
(2, 'dog belt', 600.00, 'high quality belt for dogs ', 'assets/uploads/9745796309cf55caa25fd685fb3e1375', 'dog'),
(3, 'pet nail cutter', 300.00, 'trim your dog nails so it wont hurt you', 'assets/uploads/c63f50d1ae14b1b08535b6ab5cdd2c35', 'dog'),
(4, 'brush', 450.00, ' detangle your dog\'s hair before shower for smooth silky hair', 'assets/uploads/c0cbc5712bc1fdf9e83e3521de38951c', 'dog'),
(5, 'dog shoes', 720.00, 'shoes for you dog to go for walk without dirty feet', 'assets/uploads/5c20de9ffdf3ae28820e4ddf3882772d', 'dog'),
(6, 'leash', 700.00, ' take your dog anywhere comfortably in this leash J&J', 'assets/uploads/cf9047a27714bdd8e5dc4083b8cb3a04', 'dog'),
(7, 'dog bottle ', 1.00, ' feed your puppies when they get hungry ', 'assets/uploads/5dbb008c25ca5994ba6dd87d96a394c3', 'dog'),
(8, 'pet nail cutter (blue)', 350.00, 'trim your pet nails', 'assets/uploads/c5c8ae9bee8b5798deeb9bf194d3071f', 'dog'),
(9, 'leash size-xl color purple', 900.00, 'dog leash is made using 1/2-inch wide biothane with a high quality brass bolt snap. J&j biothane is a unique PVC coated nylon and is known for its durability under extreme conditions. Biothane is a great alternative to leather, is easy to grip,', 'assets/uploads/17c894836b9c9eb0e4d684508365183f', 'dog'),
(10, 'brush size-small ', 200.00, 'dfgfd', 'assets/uploads/16482e944cfb425a399d919ae637f1f7', 'dog'),
(28, 'Koller Products BettaView 1.5-Gallon Aquarium', 12.00, 'Tetra has been revolutionizing and improving fish nutrition since the company’s birth in Germany in 1951. Since that time, Tetra has developed one of the most comprehensive bodies of flake fish food knowledge in the world. A full team of biologists, chemi', 'assets/uploads/4aa6e238cdadd0afdeb916e8625d9525', 'fish'),
(29, 'Tetra Pond Food', 255.00, '  Tetra has been revolutionizing and improving fish nutrition since the company’s birth in Germany in 1951. Since that time, Tetra has developed one of the most comprehensive bodies of flake fish food knowledge in the world. A full team of biologists, che', 'assets/uploads/0253292848e556bc7f3e020632ac5ec6', 'fish'),
(30, 'API Water Test Kit', 213.00, 'Most water problems are invisible to the eye. Quickly measure and modify the six aquarium levels that are most important to the health of your freshwater fish with the API FRESHWATER MASTER TEST KIT. To stay healthy and thrive, fish need properly balanced', 'assets/uploads/a7acea38c00acbfad3d7eb673390912c', 'fish'),
(31, 'Tetra Pond Pond Sticks', 477.00, ' For 50 years, fishkeeping enthusiasts have looked to the Tetra name for products and solutions that add ease and beauty to their home. Whether you\'re an experienced hobbyist or just starting out, Tetra has everything you need–-from a large variety of qua', 'assets/uploads/9e8cc1545cc2d236509fd50e0ceb48cc', 'fish'),
(32, 'Koller Products Replacement Filter Cartridges ', 200.00, ' Koller Products replacement filter cartridge fits Koller Products aquariums and Hawkeye aquariums with power filters using filter cartridges size XS. Keeps water crystal-clear and fish healthy by removing organic pollutants and other fish waste. ', 'assets/uploads/ae5466aff3781991b0575787475ca096', 'fish'),
(33, 'API Quick Start Nitrifying Bacteria or for Saltwater Aquarium', 70.00, '  Koller Products replacement filter cartridge fits Koller Products aquariums and Hawkeye aquariums with power filters using filter cartridges size XS. Keeps water crystal-clear and fish healthy by removing organic pollutants and other fish waste.', 'assets/uploads/096096123010a0b3dd306f2df50d8d78', 'fish'),
(34, 'koller Products 5V Power Adapter Aquarium LED Lights', 26.00, 'USB Micro-B connector 6.85 by 1.8 mm (0.270 by 0.071 in)\r\nEnables aquarium\'s LED lights to be plugged into 110V household electrical outlet', 'assets/uploads/018e839d8ed32194db8c7caad30c6891', 'fish'),
(35, 'Flake Tetra min  Food', 12.00, 'Tetra Min Tropical Flakes are a nutritionally balanced, complete diet for optimal health in top- and mid-feeding aquarium fish. These crisps leave up to 35 percent less waste behind than competing flakes for more usable food, clearer water and healthy fit', 'assets/uploads/406a75ebb7deb249eb64069cebc8bb85', 'fish'),
(36, ' Aquarium Water Conditioner or Tetra EasyBalance 8.45 Ounces', 45.00, ' Keeping a clean and healthy aquarium can be a challenge, but with Tetra(R) EasyBalance(R) a simple action every 30 days can be the first step. Tetra(R) EasyBalance(R) helps you maintain a healthy aquarium with regular use by reducing phosphates and water', 'assets/uploads/f97a0f76ed105086d7208ecd5a808759', 'fish'),
(37, ' Aquarium Koller Products Smart Tank 7 Gallon with LED Lighting', 37.00, ' When starting out it is best to add one or two fish and wait 2 weeks as the aquarium becomes established and beneficial bacteria begin growing, unless you add products that can speed up this process. ', 'assets/uploads/d32f4f67d7955cb067a8265b2ccac076', 'fish'),
(38, 'Tetra Tropical Flakes for Aquarium Fish (77005)', 8.00, ' For 50 year, fishkeeping enthusiasts have looked to the Tetra name for products and solutions that add ease and beauty to their home. Whether you\'re an experienced hobbyist or just starting out.', 'assets/uploads/f8ed544932d68b39628255a7e2b062fa', 'fish'),
(39, 'API Aquarium salt freshwater', 12.00, '   A lack of electrolytes in aquarium freshwater may cause serious health problems for freshwater fish. API AQUARIUM SALT supplies electrolytes to improve fish respiration. ', 'assets/uploads/68bcb9cc7a89edcb550136ad2cd2e9ac', 'fish'),
(40, ' Tetra Algae Wafers', 6.00, ' Tetra PRO PlecoWafers are a nutritionally balanced, complete daily diet for herbivore bottom feeders such as plecos. ', 'assets/uploads/22fd9b0375aabcf9018bf3018959983c', 'fish'),
(41, 'Tropical Aini Spirulina 330gm Fish  Dry Flake New Born Fish Food by API', 18.00, '  It is a balanced staple diet for all tropical fish. It is scientifically developed to meet the basic dietary needs for healthy growth and lustrous skin. It helps to reduce water pollution with digestible ingredients.', 'assets/uploads/05e453b3c7c601bfdd73b56e92e75948', 'fish'),
(42, 'Flakes for Small to Medium Sized Fish By API', 5.00, 'Aquatic Food\'s Vegetable Intense Flakes contain high amounts of Dried Vegetables, Ideal for All Tropical Fish, both Freshwater and Saltwater Fish', 'assets/uploads/616578e57de2096de0d39edd9bf63f8a', 'fish'),
(43, 'Koller Products BettaTank 1 gallon Scalloped Fish Bowl', 43.00, ' One-piece construction providing superior strength and durability, unlike glass tanks glued together with silicone, this stylish shaped tank puts to rest any worries or concerns about possible leaks.', 'assets/uploads/05e0deb1ed9e0a11ca85d83a4eca8b4c', 'fish'),
(44, ' Aquarium with LED by  Cube 30 koller', 15.00, '  CUBE 30 Aquarium offers a new approach to a traditional shape. With its clean lines it provides an unobstructed view of your aquarium inhabitants and an open space to set your creativity free with the endless combinations of biOrb aquarium sculptures.', 'assets/uploads/88e47ea78c223ac20cb48336983bfae1', 'fish'),
(45, 'Tetra Weekend Tropical Slow Release Feeder Fish Food', 32.00, ' Tetra has been revolutionizing and improving fish nutrition since the company’s birth in Germany in 1951. Since that time, Tetra has developed one of the most comprehensive bodies of fish food knowledge in the world. ', 'assets/uploads/5e05f4102d06797200cf5e6e6a0b7660', 'fish'),
(46, 'Flakes For Tropical Fish 30g', 13.00, ' High in protein and a rich assortment of vitamins and minerals\r\nFortified with garlic guard, chlorella algae, and vitamin C for your gold fish', 'assets/uploads/7d5d550f32838d731c51139ef76796c5', 'fish'),
(47, ' Tropical Flakes with Color Enhancing TetraColor PLUS', 17.00, 'Highly digestible flake formula for use as staple food for all tropical fish.', 'assets/uploads/b588eab24965ba69811278e190bd2851', 'fish'),
(48, 'Cat House Collection -Indoor Bed with Removable Foam Cushion', 24.00, ' Give your furry friend the soft comfort, support, and protection of the Dog Bed by PETMAKER. The enclosed cat bed is designed to cradle your pet to achieve maximum privacy and soothing security for cats, kittens, bunnies, guinea pigs, ferrets, hedgehogs.', 'assets/uploads/bfbd953654e5e434736835fb63062a55', 'cat'),
(49, 'Cat Large Tunnel Bed, Cat Toys', 32.00, '  It’s an all-round HQ for almost everything your cat loves. The tunnel cat bed combines a soft-but-structured tunnel with entry and exit points, a hanging toy to play with and a cozy plush Bed in the middle.', 'assets/uploads/decaf81bfbb32a9be6abe50ce7984a55', 'cat'),
(50, 'Litter box , forever fresh', 43.00, ' ARM & HAMMER ™ FOREVER FRESH Clumping Litter provides long-lasting odor control and lasting freshness. This pet-friendly formula is an instant odor destroyer with a fresh cedarwood scent plus ARM & HAMMER Baking Soda to help neutralize odors.\r\n\r\n', 'assets/uploads/e806d63e8e5a017d7436b083a48ef308', 'cat'),
(51, 'Cat Scratching Post - Carpeted Base Play Area and Perch', 54.00, ' Help your kitty stretch their paws and claws safely with this Cat Scratching Post Tower by PETMAKER. This 19.25-inch-tall 3-post cat scratcher helps provide protection for your couch and other furniture by giving your favorite feline a healthy and safe.', 'assets/uploads/5e662371e171821d510193bd92e0aaa6', 'cat'),
(52, 'Food Bowl Collection_Stress Free Pet Feeder', 29.00, ' Your clever, agile cat is your constant companion. So why not do him a favor and keep dinnertime from being a literal pain in the neck? Unlike average floor dishes, Kitty City elevated bowls reduce neck tension and create a natural eating posture for pet', 'assets/uploads/ea1d4084c25e54ed3cfa75dd4740606f', 'cat'),
(53, 'Cats Pet Feeders  ', 231.00, ' Flexible Timed Feeding,Suitable Capacity,Dual Power Supply: Use the 5V DC adapter while sustaining the auto cat feeders power via 3 alkaline.', 'assets/uploads/b25d7240fc53ac7530ec962a0c60b713', 'cat'),
(54, 'Food Feeding Mat Combo', 25.00, ' Non-skid mat keeps bowls in place and mat secure to the floor.', 'assets/uploads/2138288541b4c35756e92d1ae8fa47f3', 'cat'),
(55, ' Litter Box , petmate Open cat litter box', 26.00, '  The Petmate open litter pan gives cats room to shake off litter inside, keeping floors mess-free. The pan\'s wide base keeps litter contained and ensures comfortable access for a wide range of cats. Unlike covered cat pans.', 'assets/uploads/ca5b01f90509bd1646d96b7399bf7494', 'cat'),
(56, 'Petmate Litter Pan', 10.00, ' The Petmate Open Litter Pan gives cats room to shake off litter inside, keeping floors mess-free. The pan\'s wide base keeps litter contained and ensures comfortable access for a wide range of cats. ', 'assets/uploads/e3ad48f48fcf92b2f37b0f923f8c4b75', 'cat'),
(57, 'Petmate Giant Litter Box', 4.00, '  The Pet mate Giant Litter box gives large cats room to shake off litter inside, keeping floors mess-free. The extra large litter box features a sloping design that helps keep litter contained in the back and a lowered front that allows comfortable .', 'assets/uploads/912b1e8694817df7a4e0012c4546a24d', 'cat'),
(58, 'SmartyKat Electronic Light Toys for Cats & Kittens, Fun & Interactive Play - Multiple Styles', 23.00, ' SmartyKat Flicker Balls Set of 2 Electronic Light Ball Cat Toys activate the thrill of the chase! An intriguing spin on the ever-popular cat ball, this motion-activated light up ball will roll on carpeting as well as hard surfaces .', 'assets/uploads/6193276f6c16440367be429c79012be0', 'cat'),
(59, ' Toy For cat, Petlinks Catnip', 15.00, ' etlinks Playful Popper Pop-Up Spring HappyNip is Cat Toy puts the fun in your hands and provides high flying fun for your cat. The lightweight bouncy mesh acts as a spring to launch the soft plush ball. ', 'assets/uploads/77da91f402ed30f71b985d435269da6c', 'cat'),
(60, 'Food Bowls,Catit Cat Food Bowls', 43.00, ' Cat bowl has a shallow design to keep your cat’s whiskers untouched,Cat bowl has a shallow design to keep your cat’s whiskers untouched,Durable food bowl holder with non-skid feet.', 'assets/uploads/53431b9fab8db8eca9dca0d12c7cd709', 'cat'),
(61, 'smartyKat Electronic Motion/Moving Toys for Cats & Kittens', 322.00, ' Smarty Kat hot pursuit electronic concealed motion toy mesmerizes cats by replicating the erratic movements of hidden prey with moving lights and a teasing tail.', 'assets/uploads/0ab224cf90311434502aafffc9dd77d2', 'cat'),
(62, 'Petmate ScoopFree Self-Cleaning Cat Litter Box', 432.00, ' The PetSafe ScoopFree 2nd generation cat litter box is an innovative, automatic litter box that stays fresh and clean without the hassle. Instead of scooping every day, the litter box does all the work for you Cleanup is as easy as placing the lid .', 'assets/uploads/b948d292399a3eec1087c8c2fc9932e4', 'cat'),
(63, 'Cat Food Bowl Collection_Stress Free Pet Feeder and Waterer', 70.00, ' Includes 1 teal and 1 light pink dishes – Each holds 6.5 ounces\r\nModern pedestal design promotes natural, healthy eating posture and looks great in your home.', 'assets/uploads/e925b527eaafef3289ec09ace43256e5', 'cat'),
(64, 'SmartyKat Hideout, Tunnels, & Playmat Toys for Cats', 165.00, ' MULTI-TEXTURED TOYS MIMIC THE FEEL OF REAL PREY: Fabric, feathers and rustling sounds. Available in blue and gray, or green and orange, color will be randomly selected and cannot be chosen at this time.', 'assets/uploads/ff8d38c3b8548eea464cec37bf04e683', 'cat'),
(65, 'Toy for cat , Treat Dispensing Toys', 234.00, '  Your smarty cats will love the challenge of the Melon Madness Puzzle & Play by Nina Ottosson. Cats bat at the pegs and swivel the seeds to uncover the 12 hidden treat compartments. ', 'assets/uploads/0f4ac2361984113a68e8e08a4e17f026', 'cat'),
(66, 'Toy for cat , Petmate FATCAT Big Mama\'s Scratchy Box/Ramp', 321.00, ' Petmate\'s FAT CAT Big Mama\'s Scratchy Box works as a cat scratch deterrent, providing a fun place for cats to satisfy their scratching needs while also saving your furniture. \r\n\r\n', 'assets/uploads/98bbd49a330bc46a1eb601600be65444', 'cat'),
(67, 'Petmate Litter Catcher Mat 1/2 CIRCLE , Ice Blue', 30.00, '  Captures litter dust & scatter to keep floors clean Durable & easy to clean: shake, vacuum or rinse Soft material, easy on paws Best selling size (consumer dims): 23.5\" x 14\" .', 'assets/uploads/2dbb8a5a4357261922d5039ae4d87f84', 'cat'),
(68, 'dog leash rope, Premium Quality Training Slip Lead', 13.00, 'Our premium quality dog rope leash is built with heavy-duty mountain climbing grade rope. It is extremely durable and comfortable. Great for crate transfer, potty breaks and dog training.\r\n\r\n', 'assets/uploads/c243cc2054cd155debe1c1c652acfd7e', 'dog'),
(69, 'Dog Leash,ThunderLeash No-Pull ', 19.00, 'No training required,\r\nSoft touch padded handle for your hand’s comfort,\r\nNo complicated harnesses\r\nCompatible with all standard collars', 'assets/uploads/081ac7cdb7a2e9a907f0f28577e555c4', 'dog'),
(70, 'leash ,J&J Dog Supplies Biothane  ', 23.00, 'Waterproof – the PVC coated webbing won’t absorb water, odors or dirt.\r\nAbrasion resistant.\r\nHigh quality, corrosion resistant, brass bolt snaps.', 'assets/uploads/8078667844f937547978729b3f3dac1a', 'dog');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_address`
--

CREATE TABLE `shipping_address` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shipping_address`
--

INSERT INTO `shipping_address` (`id`, `full_name`, `email`, `phone`, `street_address`, `city`) VALUES
(1, 'ww', 'e@gmail.com', '1238988766', 'jeiiisisisiisisisisis', 'eheeh'),
(2, 'Bradley Ewing', 'reji@mailinator.com', '+1 (259) 7', 'Dolor mollit dolore ', 'lydapynevu@mailinator.com'),
(3, 'Beatrice Salas', 'lasubusowe@mailinator.com', '+1 (259) 1', 'Laboriosam doloribu', 'myvel@mailinator.com'),
(4, 'Zia Padilla', 'vineqakaj@mailinator.com', '+1 (313) 1', 'Quidem suscipit repe', 'sytadig@mailinator.com'),
(5, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(6, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(7, 'Bradley Ewing', 'tulsi@gmail.com', '1238988766', 'Laboriosam doloribu', 'myvel@mailinator.com'),
(8, 'Bradley Ewing', 'tulsi@gmail.com', '1238988766', 'Laboriosam doloribu', 'myvel@mailinator.com'),
(9, 'Philip Greene', 'labic@mailinator.com', '+1 (333) 2', 'Aut velit qui nostru', 'buvam@mailinator.com'),
(10, 'Indigo Booker', 'huji@mailinator.com', '+1 (574) 5', 'Ut sed quia autem au', 'divym@mailinator.com'),
(11, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(12, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(13, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(14, 'Lunea Peck', 'dyqajuwek@mailinator.com', '+1 (736) 6', 'Esse ipsam incididu', 'cuwuginomailinator'),
(15, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(16, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(17, 'aayusha', 'aayusha@gmail.com', '67909990', 'yt67', 'ktm'),
(18, 'aayusha', 'aayusha@gmail.com', '8998987', 'yt67', 'ktm'),
(19, 'ipsha ghimire', 'ipsha@gmail.com', '9853465012', 'ktm', 'ktm'),
(20, 'anisha bastakoti', 'anisha@gmail.com', '9812345687', 'pepsicola', 'kathmandu'),
(21, 'tulsi', 'tulsigautam05@gmail.com', '9843175898', 'ktm', 'ktm'),
(22, 'aayushi', 'ayushi@gmail.com', '9845667123', 'balkumari', 'lalitpur');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `name`, `user_password`, `user_email`) VALUES
(1, 'ipsha', '$2a$08$3Y315ioCN7MNqRDuCvzmxuE/s6vKVj5K6CT6CUu/yh9ev5pn6VPLO', 'ipsha@gmail.com'),
(2, 'tulsi', '$2a$08$6TERci2gSIYu1JDQLnQ9luC9sSqbk.5g9o9yElTUL4vFaOH9f/d5u', 'tulsi@gmail.com'),
(3, 'barsa', '$2a$08$Z6yLChszjMkRX3L8pwoC8uINm8hp40b1k.Q6sUEQ.0JsOTYfhZ9Oq', 'barsa@gmail.com'),
(4, 'anisha', '$2a$08$d9SPyhyP8.g8oHlJkGlLl.a2q5jH/pvTHaU.Y9UNIUs4u8B3zgMR.', 'anisha@gmail.com'),
(5, 'ipshatest', '$2a$08$jlYytuoNzfEYIfCPjUQxHusTdn9hpXc8sbkcBLuwhM0.ds/6nS9Du', 'ipshatest@gmail.com'),
(6, 'sample', '$2a$08$F7M4zBIsgeT5qy.k6UejtuYhkD7Aof8pBCKK7m.kndyid/C9lQtg6', 'sample@gmail.com'),
(10, '', '$2a$08$ZxrteFD8oXyW8BwgJa642uxqccf1HnS4NVFeqx29MWmvK5aHnSQgC', 'admin@gmail.com'),
(11, 'aayusha', '$2a$08$5LBCM...GfHJWwmTVXjqcehEAEAGKqDIPPjQEclEYjwR16RTOyULC', 'aaysha@gmail.com'),
(12, 'aayusha', '$2a$08$m2v/2qtM/uJnB1ZmikyHzOIuRo.PwDSoCMP/2lMiQVyXqO5u54Elm', 'aayusha@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user_order`
--

CREATE TABLE `user_order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `shipping_address_id` int(11) NOT NULL,
  `order_status` varchar(15) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_order`
--

INSERT INTO `user_order` (`id`, `user_id`, `shipping_address_id`, `order_status`, `order_date`) VALUES
(1, 2, 16, 'completed', '2022-11-03 13:32:57'),
(2, 12, 17, 'pending', '2022-11-04 07:22:37'),
(3, 12, 18, 'completed', '2022-11-04 07:24:28'),
(4, 1, 19, 'completed', '2022-11-04 07:44:27'),
(5, 1, 20, 'pending', '2022-11-04 08:03:40'),
(6, 1, 21, 'pending', '2022-11-04 08:08:00'),
(7, 1, 22, 'pending', '2022-11-04 08:19:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `ordered_items`
--
ALTER TABLE `ordered_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_order_id` (`user_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `shipping_address`
--
ALTER TABLE `shipping_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- Indexes for table `user_order`
--
ALTER TABLE `user_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `shipping_address_id` (`shipping_address_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `ordered_items`
--
ALTER TABLE `ordered_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `shipping_address`
--
ALTER TABLE `shipping_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_order`
--
ALTER TABLE `user_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
