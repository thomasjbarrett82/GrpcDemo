/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

TRUNCATE TABLE [Names];
GO

DBCC CHECKIDENT ('[Names]', RESEED, 1);
GO


INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Vincent','Cervantes'),
  ('Ginger','Dawson'),
  ('Nathan','Reed'),
  ('Debra','Moore'),
  ('Ulla','Lindsey'),
  ('Irene','Farrell'),
  ('Shelley','House'),
  ('May','Sanchez'),
  ('Jacqueline','Collier'),
  ('Lev','Davenport');
  GO
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Venus','Young'),
  ('Sopoline','Hardy'),
  ('Abra','Harvey'),
  ('Thaddeus','Patton'),
  ('Gwendolyn','Atkins'),
  ('Philip','Cabrera'),
  ('Zia','Wallace'),
  ('Kiara','Lambert'),
  ('Graham','Dejesus'),
  ('Vernon','Mueller');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Sierra','Blake'),
  ('Dara','Ballard'),
  ('Hector','Casey'),
  ('Ocean','Conrad'),
  ('Russell','Luna'),
  ('Lance','Becker'),
  ('Scott','Ford'),
  ('Hermione','Alston'),
  ('Keaton','Estrada'),
  ('Hermione','Lee');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Imogene','Mccoy'),
  ('Lawrence','Cunningham'),
  ('Dahlia','Pace'),
  ('Ainsley','Morgan'),
  ('Dana','Gilliam'),
  ('Tad','Riley'),
  ('Tyler','Burns'),
  ('Blake','Everett'),
  ('Myles','Barr'),
  ('Germaine','Combs');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Silas','Wolf'),
  ('Theodore','Estrada'),
  ('Bruce','Gentry'),
  ('Hammett','Gillespie'),
  ('Denton','Head'),
  ('Jack','Vega'),
  ('Nolan','Tyler'),
  ('April','Stanton'),
  ('Kelly','Kirkland'),
  ('George','Clay');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Gregory','Lang'),
  ('Akeem','Perkins'),
  ('Alfreda','Lynch'),
  ('Cherokee','Velasquez'),
  ('Gavin','Rojas'),
  ('Ina','Hopper'),
  ('Kaitlin','Christian'),
  ('Zachary','Frank'),
  ('Allistair','Mercer'),
  ('Breanna','Marshall');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Elton','Page'),
  ('Riley','Wallace'),
  ('Noel','Freeman'),
  ('Asher','Ortega'),
  ('Raya','Nash'),
  ('Ingrid','Blair'),
  ('Odette','Hendrix'),
  ('Eaton','Schultz'),
  ('Trevor','Schroeder'),
  ('Nadine','Wolf');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Hedy','Sawyer'),
  ('Chastity','Reid'),
  ('Gavin','Conner'),
  ('Cheryl','Gilliam'),
  ('Coby','Willis'),
  ('Lani','Aguilar'),
  ('Marvin','Kerr'),
  ('Hasad','Combs'),
  ('Kylee','Vang'),
  ('Adele','Whitley');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Malcolm','Myers'),
  ('Leila','David'),
  ('Myles','Riddle'),
  ('Heather','Bentley'),
  ('Joy','Finley'),
  ('Julian','Parker'),
  ('Stephanie','Davidson'),
  ('Quinn','Gillespie'),
  ('Tanner','Lindsey'),
  ('Margaret','Sears');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Larissa','Craig'),
  ('Colton','Wolf'),
  ('Larissa','Paul'),
  ('TaShya','Pitts'),
  ('Shafira','Hubbard'),
  ('Jack','Cardenas'),
  ('Ramona','Vasquez'),
  ('Savannah','Carr'),
  ('Baxter','Hester'),
  ('Judah','Quinn');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Lionel','Snow'),
  ('Stone','Sutton'),
  ('Illana','Keller'),
  ('Nash','Boone'),
  ('Sybil','Macdonald'),
  ('Catherine','Edwards'),
  ('Linus','Shannon'),
  ('Ila','Macias'),
  ('Connor','Lang'),
  ('Aurelia','Bullock');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Hilda','Ferrell'),
  ('Lydia','Kennedy'),
  ('Jason','Le'),
  ('Laith','Klein'),
  ('Yvonne','Hardy'),
  ('Ivy','Rios'),
  ('Danielle','Wagner'),
  ('Jenna','White'),
  ('Zenaida','Solomon'),
  ('Lester','Thompson');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Fiona','Boyle'),
  ('Cora','Cummings'),
  ('Sarah','Sandoval'),
  ('Ramona','Cote'),
  ('Nora','Mckay'),
  ('Haviva','Freeman'),
  ('Xantha','Horne'),
  ('Aidan','Douglas'),
  ('Adena','Mcguire'),
  ('Breanna','Russo');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Akeem','Kent'),
  ('Maryam','Sexton'),
  ('Elvis','Lucas'),
  ('Allen','Waters'),
  ('Elton','Gallegos'),
  ('Odette','Battle'),
  ('Jael','Ballard'),
  ('Wanda','Moore'),
  ('Damon','Curry'),
  ('Kimberly','Richards');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Juliet','Vinson'),
  ('Gil','Rosales'),
  ('Lee','Singleton'),
  ('Yolanda','Joseph'),
  ('Branden','Payne'),
  ('Lacey','Calhoun'),
  ('Daquan','Holder'),
  ('Geoffrey','Bates'),
  ('Kai','Richard'),
  ('Martena','Mclean');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Raya','Dale'),
  ('Jesse','Pace'),
  ('Latifah','Snow'),
  ('Mariko','Franco'),
  ('Kelly','Castro'),
  ('Gail','Keith'),
  ('Rhea','Cameron'),
  ('Eaton','Mayo'),
  ('Kennan','Carney'),
  ('Beatrice','Daniel');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Britanni','Acevedo'),
  ('Jacob','Santana'),
  ('Serena','Mckenzie'),
  ('Nathaniel','Summers'),
  ('Ayanna','Hodges'),
  ('Wendy','Mosley'),
  ('Dexter','Gould'),
  ('Charity','Cherry'),
  ('Dieter','Whitney'),
  ('Hyatt','Good');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Daphne','Baker'),
  ('Knox','Davidson'),
  ('Tarik','Pena'),
  ('Plato','Bruce'),
  ('Desiree','Meyers'),
  ('Sarah','Kim'),
  ('Benedict','Hart'),
  ('Jelani','Heath'),
  ('Cody','Villarreal'),
  ('Leo','Jimenez');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Alyssa','Austin'),
  ('Inga','Rodriquez'),
  ('Diana','Wiggins'),
  ('Forrest','Brown'),
  ('Wyatt','Chen'),
  ('Kay','Flores'),
  ('Kitra','Henderson'),
  ('Aretha','Santiago'),
  ('Shoshana','Gamble'),
  ('Ashton','Delacruz');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Jamal','Wright'),
  ('Jermaine','Zimmerman'),
  ('Demetria','Carter'),
  ('Lila','Gardner'),
  ('Yuri','Hansen'),
  ('Joelle','Pollard'),
  ('Macon','Baldwin'),
  ('Cheryl','Mcleod'),
  ('Stacey','Christian'),
  ('Yen','Espinoza');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Pearl','Ramos'),
  ('Aidan','Glover'),
  ('Noble','Mitchell'),
  ('Chancellor','Callahan'),
  ('Keely','Patterson'),
  ('Dexter','Tucker'),
  ('Kirk','Bolton'),
  ('Addison','Freeman'),
  ('Phelan','Snow'),
  ('Lev','Hunter');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Macaulay','Carver'),
  ('Phelan','Carver'),
  ('Colby','Parsons'),
  ('Daniel','Bishop'),
  ('Xanthus','Gonzales'),
  ('Garth','Robertson'),
  ('Cameran','Chang'),
  ('Magee','O''connor'),
  ('Aphrodite','Kemp'),
  ('Jescie','Erickson');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Kaseem','Adkins'),
  ('Quentin','Fernandez'),
  ('Candace','Blair'),
  ('Wayne','Murray'),
  ('Ivory','Hyde'),
  ('Aurora','Wilkerson'),
  ('Alexandra','Ramirez'),
  ('Eugenia','Scott'),
  ('Allegra','Monroe'),
  ('Sheila','Jones');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Herman','Gutierrez'),
  ('Barrett','Hamilton'),
  ('Dexter','Atkinson'),
  ('Rinah','Farmer'),
  ('Eagan','Baird'),
  ('Roth','Woods'),
  ('Baxter','Pollard'),
  ('Steven','Gilmore'),
  ('Haley','Davenport'),
  ('Meghan','Shaffer');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Caleb','Tyler'),
  ('Vladimir','Welch'),
  ('Vance','Valenzuela'),
  ('Jolene','Beasley'),
  ('Aidan','Monroe'),
  ('Pamela','Boone'),
  ('Kitra','Kirby'),
  ('Melinda','George'),
  ('Paki','Donaldson'),
  ('Cain','Thompson');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Jonah','Dale'),
  ('Kibo','Zimmerman'),
  ('Maisie','Silva'),
  ('Chaim','Wilkinson'),
  ('Beatrice','Howell'),
  ('Ian','Lowe'),
  ('Miranda','Jordan'),
  ('Guinevere','Hall'),
  ('Freya','Fuller'),
  ('Maisie','Gates');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Tarik','Stuart'),
  ('Alec','Gay'),
  ('Lee','Sandoval'),
  ('Kylie','Blanchard'),
  ('Yoshio','Arnold'),
  ('Shay','Stephens'),
  ('Wing','Avila'),
  ('Lawrence','Baxter'),
  ('Branden','Justice'),
  ('Althea','Yates');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Caesar','Ochoa'),
  ('Lawrence','Nixon'),
  ('Dai','Lester'),
  ('Mikayla','Glass'),
  ('Ivana','Fleming'),
  ('Ezra','O''donnell'),
  ('Cherokee','Mayer'),
  ('Kamal','Abbott'),
  ('Addison','Gates'),
  ('Xyla','Webster');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Jocelyn','Rodriquez'),
  ('Nevada','Sosa'),
  ('Tyrone','Higgins'),
  ('Brennan','Spence'),
  ('John','Vance'),
  ('Iona','Sutton'),
  ('Kirsten','Chan'),
  ('Stephanie','Walker'),
  ('Brynne','O''brien'),
  ('Macaulay','Meyer');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Alea','Duffy'),
  ('Rafael','Hutchinson'),
  ('Danielle','Mcintosh'),
  ('Henry','Mckinney'),
  ('Stephen','Pittman'),
  ('Austin','Coleman'),
  ('Fletcher','Burris'),
  ('Thaddeus','Gates'),
  ('Isabelle','Flores'),
  ('Serina','Moore');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Sydney','Mcfarland'),
  ('Solomon','Merritt'),
  ('Ferdinand','Mccullough'),
  ('Daniel','Rollins'),
  ('Darrel','Harrington'),
  ('Nigel','Farmer'),
  ('Zenia','Leonard'),
  ('Flynn','Byers'),
  ('Miranda','Mckenzie'),
  ('Quentin','Galloway');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Rylee','Massey'),
  ('Aladdin','Goff'),
  ('Kieran','Wilkins'),
  ('Kerry','Carlson'),
  ('Arsenio','Jimenez'),
  ('Quamar','Glover'),
  ('Kirby','Blankenship'),
  ('Ashton','Joyner'),
  ('Hammett','Huff'),
  ('Jacob','Carrillo');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Isabelle','Mathews'),
  ('Ignacia','Frye'),
  ('Callum','Kerr'),
  ('Bert','Le'),
  ('Quyn','Marshall'),
  ('Keely','Maldonado'),
  ('Austin','Lynn'),
  ('Ishmael','Guerra'),
  ('Calvin','Maldonado'),
  ('Mikayla','Jennings');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Stuart','Acosta'),
  ('Noelle','Kelly'),
  ('Kareem','Wiggins'),
  ('Finn','Cotton'),
  ('Chadwick','Marquez'),
  ('Inez','Ball'),
  ('Armand','Nixon'),
  ('Eric','Rodriquez'),
  ('Hilda','Velasquez'),
  ('Fitzgerald','Gillespie');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Jonas','Irwin'),
  ('Hashim','Ratliff'),
  ('Guinevere','Gallegos'),
  ('Myra','Mcintyre'),
  ('Damon','Lancaster'),
  ('Kalia','Petty'),
  ('Jakeem','Nieves'),
  ('Sheila','Kerr'),
  ('Lucius','Campbell'),
  ('Abel','Bauer');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Nolan','Mckenzie'),
  ('Jaime','Saunders'),
  ('Wang','Key'),
  ('Ima','Warner'),
  ('Beverly','Charles'),
  ('Olga','Burton'),
  ('Cara','Richmond'),
  ('Geraldine','Bright'),
  ('Jennifer','Reilly'),
  ('Vincent','Berry');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Damon','Cooke'),
  ('Ivor','Pearson'),
  ('Sacha','Wilkins'),
  ('Adrian','Briggs'),
  ('Odysseus','Fleming'),
  ('Declan','Jimenez'),
  ('Buckminster','Bernard'),
  ('Briar','Coleman'),
  ('Sean','Ewing'),
  ('Tate','Spears');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Kenneth','Bird'),
  ('Fiona','Larson'),
  ('Martha','Harrell'),
  ('Christen','Moreno'),
  ('Ezekiel','Hyde'),
  ('Nehru','Glass'),
  ('Macon','O''Neill'),
  ('Raphael','Cherry'),
  ('Rana','Sloan'),
  ('Caldwell','Anthony');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Dalton','O''Neill'),
  ('Cherokee','Gould'),
  ('Chaney','Gonzalez'),
  ('Kasper','Delaney'),
  ('Aphrodite','Allison'),
  ('Yeo','Alford'),
  ('Luke','Martinez'),
  ('Jane','Cline'),
  ('Tatum','Lester'),
  ('Kameko','Cohen');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Louis','Hensley'),
  ('Kay','Lane'),
  ('Odysseus','James'),
  ('Harriet','Floyd'),
  ('Flynn','Cote'),
  ('Shelly','Flowers'),
  ('Elaine','Miller'),
  ('Thane','Haney'),
  ('Nell','Atkinson'),
  ('Fredericka','Chang');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Vaughan','Ochoa'),
  ('Emerson','Gay'),
  ('Zelenia','Blankenship'),
  ('Scarlett','Murray'),
  ('Duncan','Page'),
  ('Kameko','Medina'),
  ('Hector','Pugh'),
  ('Barrett','Conley'),
  ('Hu','Barlow'),
  ('Debra','Mosley');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Cora','Spence'),
  ('Clinton','Giles'),
  ('Portia','Stewart'),
  ('Dante','Mcguire'),
  ('Herrod','Solis'),
  ('Rhona','Sanford'),
  ('Shea','Herman'),
  ('Jennifer','Oliver'),
  ('Stella','Newton'),
  ('Lev','Hopkins');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Wyatt','Manning'),
  ('Amela','Long'),
  ('Brock','Mack'),
  ('Kareem','Blankenship'),
  ('Rafael','Keith'),
  ('Tarik','Bailey'),
  ('Caldwell','Peterson'),
  ('Madonna','Park'),
  ('Myles','Finch'),
  ('Macon','Hernandez');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Selma','Norman'),
  ('Jenna','Ward'),
  ('Lars','Bean'),
  ('Tucker','Pate'),
  ('Eliana','Doyle'),
  ('Blake','Clark'),
  ('Quinn','Newman'),
  ('Hedwig','Padilla'),
  ('Emmanuel','Foster'),
  ('Rhona','Sharpe');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Austin','Harvey'),
  ('Willa','Webb'),
  ('Ivy','Sweet'),
  ('Barry','Beck'),
  ('Patrick','Webster'),
  ('Teegan','Hensley'),
  ('Cheyenne','Mccarty'),
  ('Cameron','Woodard'),
  ('Ryder','Conway'),
  ('Maile','Walsh');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Lev','Whitaker'),
  ('Ima','Workman'),
  ('Bevis','Briggs'),
  ('Galena','Baxter'),
  ('Jakeem','Walls'),
  ('Brady','Browning'),
  ('Quamar','Cortez'),
  ('Chadwick','Velazquez'),
  ('Byron','Holloway'),
  ('Harriet','Dudley');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Venus','Bradshaw'),
  ('Justin','Dale'),
  ('Hedy','Walker'),
  ('Buffy','Peterson'),
  ('Ali','Guerra'),
  ('Byron','Mckinney'),
  ('Blake','Ferguson'),
  ('Keefe','Turner'),
  ('Lesley','Castro'),
  ('Mia','Pope');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Jonah','Duran'),
  ('Ralph','Crosby'),
  ('Martha','Klein'),
  ('Farrah','Reese'),
  ('Jordan','Weber'),
  ('Howard','Bates'),
  ('Willow','Barron'),
  ('Harlan','Berg'),
  ('Lenore','Anthony'),
  ('Mira','Cotton');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Amber','Mcgowan'),
  ('Norman','Noble'),
  ('Irma','Mann'),
  ('Ivor','Montgomery'),
  ('Lydia','Gonzales'),
  ('Lacey','Castillo'),
  ('Rebecca','Cobb'),
  ('Madaline','Morales'),
  ('Raymond','Hale'),
  ('Moana','Hunter');
INSERT INTO [Names] (FirstName,LastName)
VALUES
  ('Ainsley','Dominguez'),
  ('Linus','Bender'),
  ('Sharon','Mclean'),
  ('Nyssa','Goodwin'),
  ('Jakeem','Winters'),
  ('Danielle','Phelps'),
  ('Hedy','Stephenson'),
  ('Flavia','Meyer'),
  ('Shay','Drake'),
  ('Mary','Finley');
