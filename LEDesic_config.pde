/*
This will allow you to configure the processing client.

1. Put this file in your Processing project.
2. Find the size( call near the top and change the height and width to 450
	size(450, 450<there might be another arg here>)
3. Find the line: opc = new OPC(this, "127.0.0.1", 7890);
4. Find and remove any following LED initialization code. They look like:
	opc.led<something ...>
	opc.ledGrid(0, width/2, height/2, spacing, 0, true);
5. Replace the initilization section you removed with:
*/

opc.led(0, 235, 219);
opc.led(1, 250, 215);
opc.led(2, 264, 210);
opc.led(3, 279, 206);
opc.led(4, 279, 191);
opc.led(5, 264, 181);
opc.led(6, 250, 171);
opc.led(7, 235, 161);
opc.led(8, 307, 197);
opc.led(9, 321, 192);
opc.led(10, 335, 187);
opc.led(11, 349, 182);
opc.led(12, 296, 182);
opc.led(13, 299, 163);
opc.led(14, 301, 143);
opc.led(15, 304, 124);
opc.led(16, 238, 141);
opc.led(17, 255, 132);
opc.led(18, 272, 123);
opc.led(19, 289, 114);
opc.led(20, 351, 163);
opc.led(21, 340, 148);
opc.led(22, 329, 134);
opc.led(23, 318, 119);
opc.led(24, 289, 99);
opc.led(25, 272, 93);
opc.led(26, 255, 87);
opc.led(27, 238, 81);
opc.led(28, 377, 173);
opc.led(29, 391, 168);
opc.led(30, 405, 163);
opc.led(31, 419, 158);
opc.led(32, 368, 157);
opc.led(33, 373, 136);
opc.led(34, 378, 115);
opc.led(35, 383, 94);
opc.led(36, 323, 98);
opc.led(37, 339, 92);
opc.led(38, 355, 86);
opc.led(39, 371, 80);
opc.led(40, 307, 88);
opc.led(41, 308, 71);
opc.led(42, 309, 53);
opc.led(43, 310, 37);
opc.led(44, 239, 64);
opc.led(45, 257, 53);
opc.led(46, 275, 42);
opc.led(47, 293, 31);
opc.led(48, 424, 138);
opc.led(49, 415, 122);
opc.led(50, 406, 106);
opc.led(51, 397, 90);
opc.led(52, 372, 63);
opc.led(53, 357, 52);
opc.led(54, 341, 41);
opc.led(55, 326, 30);
opc.led(56, 293, 16);
opc.led(57, 275, 13);
opc.led(58, 258, 9);
opc.led(59, 240, 6);
opc.led(64, 230, 235);
opc.led(65, 240, 247);
opc.led(66, 249, 259);
opc.led(67, 259, 271);
opc.led(68, 274, 266);
opc.led(69, 279, 249);
opc.led(70, 285, 233);
opc.led(71, 290, 216);
opc.led(72, 278, 295);
opc.led(73, 287, 307);
opc.led(74, 296, 319);
opc.led(75, 305, 331);
opc.led(76, 288, 280);
opc.led(77, 307, 277);
opc.led(78, 326, 274);
opc.led(79, 345, 271);
opc.led(80, 309, 213);
opc.led(81, 323, 227);
opc.led(82, 337, 240);
opc.led(83, 351, 254);
opc.led(84, 324, 328);
opc.led(85, 334, 313);
opc.led(86, 344, 298);
opc.led(87, 354, 283);
opc.led(88, 365, 249);
opc.led(89, 365, 231);
opc.led(90, 365, 212);
opc.led(91, 365, 194);
opc.led(92, 322, 355);
opc.led(93, 330, 367);
opc.led(94, 339, 379);
opc.led(95, 347, 391);
opc.led(96, 335, 341);
opc.led(97, 356, 339);
opc.led(98, 377, 338);
opc.led(99, 398, 336);
opc.led(100, 375, 281);
opc.led(101, 386, 294);
opc.led(102, 397, 308);
opc.led(103, 408, 321);
opc.led(104, 381, 263);
opc.led(105, 397, 258);
opc.led(106, 413, 253);
opc.led(107, 429, 248);
opc.led(108, 382, 189);
opc.led(109, 398, 202);
opc.led(110, 414, 216);
opc.led(111, 430, 229);
opc.led(112, 368, 390);
opc.led(113, 381, 376);
opc.led(114, 393, 362);
opc.led(115, 406, 348);
opc.led(116, 424, 316);
opc.led(117, 429, 298);
opc.led(118, 435, 279);
opc.led(119, 440, 261);
opc.led(120, 444, 225);
opc.led(121, 442, 207);
opc.led(122, 440, 189);
opc.led(123, 438, 171);
opc.led(128, 212, 236);
opc.led(129, 203, 248);
opc.led(130, 194, 261);
opc.led(131, 185, 273);
opc.led(132, 194, 285);
opc.led(133, 213, 285);
opc.led(134, 231, 284);
opc.led(135, 250, 284);
opc.led(136, 167, 298);
opc.led(137, 158, 310);
opc.led(138, 149, 322);
opc.led(139, 140, 334);
opc.led(140, 184, 303);
opc.led(141, 193, 320);
opc.led(142, 202, 337);
opc.led(143, 211, 354);
opc.led(144, 259, 301);
opc.led(145, 249, 318);
opc.led(146, 239, 336);
opc.led(147, 229, 353);
opc.led(148, 148, 351);
opc.led(149, 166, 356);
opc.led(150, 184, 361);
opc.led(151, 202, 366);
opc.led(152, 238, 365);
opc.led(153, 257, 359);
opc.led(154, 275, 354);
opc.led(155, 294, 348);
opc.led(156, 122, 358);
opc.led(157, 113, 370);
opc.led(158, 104, 382);
opc.led(159, 95, 394);
opc.led(160, 139, 365);
opc.led(161, 147, 385);
opc.led(162, 156, 404);
opc.led(163, 164, 424);
opc.led(164, 210, 385);
opc.led(165, 201, 400);
opc.led(166, 191, 414);
opc.led(167, 182, 429);
opc.led(168, 229, 385);
opc.led(169, 238, 399);
opc.led(170, 247, 413);
opc.led(171, 256, 427);
opc.led(172, 303, 362);
opc.led(173, 294, 382);
opc.led(174, 284, 402);
opc.led(175, 275, 422);
opc.led(176, 103, 413);
opc.led(177, 120, 421);
opc.led(178, 138, 428);
opc.led(179, 155, 436);
opc.led(180, 192, 443);
opc.led(181, 211, 443);
opc.led(182, 230, 442);
opc.led(183, 249, 442);
opc.led(184, 284, 434);
opc.led(185, 302, 426);
opc.led(186, 320, 418);
opc.led(187, 338, 410);
