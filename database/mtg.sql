BEGIN TRANSACTION;

DROP TABLE IF EXISTS card_supertype, card_type, card_subtype, card_ability, card_mana_cost, 
					ability_mana_cost, deck_card, account_card;
DROP TABLE IF EXISTS mtg_user, account, card, supertype, type, subtype, ability, mana_cost,
					deck;

CREATE TABLE mtg_user (
	user_id serial primary key,
	username varchar(50) UNIQUE NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(20),
	CONSTRAINT UQ_username UNIQUE (username)
);

CREATE TABLE account (
	account_id serial primary key,
	user_id int NOT NULL,
	phasewalker_name varchar(20) NOT NULL,
	CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES mtg_user (user_id)
);

CREATE TABLE card (
	card_id serial primary key,
	card_name varchar(50) NOT NULL,
	card_text varchar(256),
	card_power bigint,
	card_toughness bigint
);

CREATE TABLE deck (
	deck_id serial PRIMARY KEY,
	deck_name varchar(20) NOT NULL,
	account_id bigint NOT NULL,
	CONSTRAINT FK_account FOREIGN KEY (account_id) REFERENCES account (account_id)
);

CREATE TABLE deck_card (
	deck_card_id serial PRIMARY KEY,
	deck_id bigint NOT NULL,
	card_id bigint NOT NULL,
	CONSTRAINT FK_deck FOREIGN KEY (deck_id) REFERENCES deck (deck_id),
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id)
);

CREATE TABLE account_card (
	account_card_id serial PRIMARY KEY,
	account_id bigint NOT NULL,
	card_id bigint NOT NULL,
	CONSTRAINT FK_account FOREIGN KEY (account_id) REFERENCES account (account_id),
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id)
);

CREATE TABLE supertype (
	supertype_id serial PRIMARY KEY,
	supertype_name varchar(20) NOT NULL
);

CREATE TABLE card_supertype (
	card_supertype_id serial PRIMARY KEY,
	card_id bigint NOT NULL,
	supertype_id bigint NOT NULL,
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id),
	CONSTRAINT FK_supertype FOREIGN KEY (supertype_id) REFERENCES supertype (supertype_id)
);

CREATE TABLE type (
	type_id serial PRIMARY KEY,
	type_name varchar(20) NOT NULL
);

CREATE TABLE card_type (
	card_type_id serial PRIMARY KEY,
	card_id bigint NOT NULL,
	type_id bigint NOT NULL,
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id),
	CONSTRAINT FK_type FOREIGN KEY (type_id) REFERENCES type (type_id)
);

CREATE TABLE subtype (
	subtype_id serial PRIMARY KEY,
	subtype_name varchar(20) NOT NULL
);

CREATE TABLE card_subtype (
	card_subtype_id serial PRIMARY KEY,
	card_id bigint NOT NULL,
	subtype_id bigint NOT NULL,
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id),
	CONSTRAINT FK_subtype FOREIGN KEY (subtype_id) REFERENCES subtype (subtype_id)
);

CREATE TABLE ability (
	ability_id serial PRIMARY KEY,
	ability_name varchar(20) NOT NULL,
	ability_text varchar(256) NOT NULL
);

CREATE TABLE card_ability (
	card_ability_id serial PRIMARY KEY,
	card_id bigint NOT NULL,
	ability_id bigint NOT NULL,
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id),
	CONSTRAINT FK_ability FOREIGN KEY (ability_id) REFERENCES ability (ability_id)
);

CREATE TABLE mana_cost (
	mana_cost_id serial PRIMARY KEY,
	mana_cost_name varchar(20) NOT NULL,
	mana_cost_color varchar(20) NOT NULL
);

CREATE TABLE card_mana_cost(
	card_mana_cost_id serial PRIMARY KEY,
	card_id bigint NOT NULL,
	mana_cost_id bigint NOT NULL,
	CONSTRAINT FK_card FOREIGN KEY (card_id) REFERENCES card (card_id),
	CONSTRAINT FK_mana_cost FOREIGN KEY (mana_cost_id) REFERENCES mana_cost (mana_cost_id)
);

CREATE TABLE ability_mana_cost(
	ability_mana_cost_id serial PRIMARY KEY,
	ability_id bigint NOT NULL,
	mana_cost_id bigint NOT NULL,
	CONSTRAINT FK_ability FOREIGN KEY (ability_id) REFERENCES ability (ability_id),
	CONSTRAINT FK_mana_cost FOREIGN KEY (mana_cost_id) REFERENCES mana_cost (mana_cost_id)
);


INSERT INTO mana_cost(mana_cost_name, mana_cost_color) VALUES
('Plains', 'White'), ('Island', 'Blue'), ('Swamp', 'Black'),
('Mountain', 'Red'), ('Forest', 'Green'), ('Wastes', 'Colorless');

INSERT INTO type(type_name) VALUES 
('Planeswalker'), ('Creature'), ('Instant'), ('Sorcery'), ('Enchantment'), 
('Artifact'), ('Land'), ('Tribal'), ('Consipiracy'), ('Phenomenom'), ('Plane'),
('Scheme'), ('Vanguard'), ('Dungeon'), ('Battle');

INSERT INTO supertype(supertype_name) VALUES
('Basic'), ('Legendary'), ('Snow'), ('World'), ('Ongoing'); 

INSERT INTO subtype(subtype_name) VALUES
('Human'), ('Wizard'), ('Warrior'), ('Soldier'), 
('Spirit'), ('Zombie'), ('Cleric'), ('Elf'),
('Elemental'), ('Shaman'), ('Dragon'), ('Dinosaur');

COMMIT;