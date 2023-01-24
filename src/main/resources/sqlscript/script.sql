create table songs
(
    id                 int auto_increment
        primary key,
    title              varchar(255)   not null,
    artist             varchar(255)   not null,
    album              varchar(255)   not null,
    genre              varchar(255)   not null,
    price              decimal(10, 2) not null,
    available_quantity int default 0  not null,
    constraint title
        unique (title)
);

create table users
(
    id       int auto_increment
        primary key,
    username varchar(255)                              not null,
    email    varchar(255)                              not null,
    password varchar(255)                              not null,
    role     enum ('admin', 'common') default 'common' not null,
    constraint username
        unique (username, email)
);

create table customers
(
    id      int auto_increment
        primary key,
    id_user int          not null,
    name    varchar(255) not null,
    address varchar(255) not null,
    constraint customers_ibfk_1
        foreign key (id_user) references users (id)
);

create index id_user
    on customers (id_user);

create table orders
(
    id             int auto_increment
        primary key,
    customer_id    int            not null,
    song_id        int            not null,
    purchase_date  date           not null,
    purchase_price decimal(10, 2) null,
    constraint orders_ibfk_1
        foreign key (customer_id) references customers (id),
    constraint orders_ibfk_2
        foreign key (song_id) references songs (id)
);

create index customer_id
    on orders (customer_id);

create index song_id
    on orders (song_id);

create
definer = root@localhost function password_validation(password varchar(255)) returns tinyint(1) deterministic
BEGIN
    DECLARE num_count INT DEFAULT 0;
    DECLARE upper_count INT DEFAULT 0;
    DECLARE special_count INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE password_length INT DEFAULT LENGTH(password);

    IF password_length < 8 THEN
        RETURN FALSE;
END IF;

    WHILE i <= password_length DO
        IF SUBSTRING(password, i, 1) REGEXP '[0-9]' THEN
            SET num_count = num_count + 1;
        ELSEIF SUBSTRING(password, i, 1) REGEXP '[A-Z]' THEN
            SET upper_count = upper_count + 1;
        ELSEIF SUBSTRING(password, i, 1) REGEXP '[!@#\$%^&\*\+-\.]' THEN
            SET special_count = special_count + 1;
END IF;
        SET i = i + 1;
END WHILE;

    IF num_count >= 1 AND upper_count >= 1 AND special_count >= 1 THEN
        RETURN TRUE;
ELSE
        RETURN FALSE;
END IF;
END;

create
definer = root@localhost procedure sp_order_create(IN input_id_user int, IN input_id_song int,
                                                       OUT unique_code varchar(255))
BEGIN
    DECLARE song_exists INT;
    DECLARE user_exists INT;
    DECLARE aviable_quantity INT;
    DECLARE reduce_quantity INT;
    DECLARE input_customer_id INT;
    DECLARE input_purchase_price DECIMAL(10,2);
    SET reduce_quantity = 1;

SELECT COUNT(*) INTO song_exists FROM songs WHERE id = input_id_song;
SELECT COUNT(*) INTO user_exists FROM users WHERE id = input_id_user;
SELECT id INTO input_customer_id FROM customers where id_user = input_id_user;

SELECT available_quantity, price INTO aviable_quantity, input_purchase_price FROM songs WHERE id = input_id_song;
IF song_exists > 0 AND user_exists > 0 AND reduce_quantity <= aviable_quantity THEN
        -- insert the order
        INSERT INTO orders (customer_id, song_id, purchase_date, purchase_price) VALUES (input_customer_id, input_id_song, NOW(), input_purchase_price);
        -- update the available quantity
UPDATE songs SET available_quantity = available_quantity - reduce_quantity WHERE id = input_id_song;
SET unique_code = 'SUCCESS';
    ELSEIF song_exists < 1 THEN
        SET unique_code = 'SONG_NOT_FOUND';
    ELSEIF user_exists < 1 THEN
        SET unique_code = 'USER_NOT_FOUND';
    ELSEIF reduce_quantity > aviable_quantity THEN
        SET unique_code = 'OUT_OF_STOCK';
END IF;
END;

create
definer = root@localhost procedure sp_order_get_all()
BEGIN
SELECT * FROM orders;
END;

create
definer = root@localhost procedure sp_order_get_all_with_song()
BEGIN
SELECT o.*, s.title, s.artist FROM orders o JOIN songs s ON o.song_id = s.id;
END;

create
definer = root@localhost procedure sp_song_creation(IN input_title varchar(255), IN input_artist varchar(255),
                                                        IN input_album varchar(255), IN input_genre varchar(255),
                                                        IN input_price decimal(10, 2), IN input_available_quantity int,
                                                        OUT unique_code varchar(255))
BEGIN
    DECLARE duplicate_title INT;
SELECT COUNT(*) INTO duplicate_title FROM songs WHERE title = input_title;
IF duplicate_title > 0 THEN
        SET unique_code = 'DUPLICATE_TITLE';
ELSE
        -- Insert the song
        INSERT INTO songs (title, artist, album, genre, price, available_quantity)
        VALUES (input_title, input_artist, input_album, input_genre, input_price, input_available_quantity);
        SET unique_code = 'SUCCESS';
END IF;
END;

create
definer = root@localhost procedure sp_song_delete_by_id(IN input_id int, OUT unique_code varchar(255))
BEGIN
    DECLARE song_exists INT;
SELECT COUNT(*) INTO song_exists FROM songs WHERE id = input_id;
IF song_exists > 0 THEN
DELETE FROM songs WHERE id = input_id;
SET unique_code = 'SUCCESS';
ELSE
        SET unique_code = 'SONG_NOT_FOUND';
END IF;
END;

create
definer = root@localhost procedure sp_song_get_all()
BEGIN
SELECT * FROM songs;
END;

create
definer = root@localhost procedure sp_song_update(IN input_id int, IN input_title varchar(255),
                                                      IN input_artist varchar(255), IN input_album varchar(255),
                                                      IN input_genre varchar(255), IN input_price decimal(10, 2),
                                                      IN input_available_quantity int, OUT unique_code varchar(255))
BEGIN
    DECLARE song_exists INT;
SELECT COUNT(*) INTO song_exists FROM songs WHERE id = input_id;
IF song_exists > 0 THEN
        -- Update the song information
UPDATE songs
SET title              = input_title,
    artist             = input_artist,
    album              = input_album,
    genre              = input_genre,
    price              = input_price,
    available_quantity = input_available_quantity
WHERE id = input_id;
SET unique_code = 'SUCCESS';
ELSE
        SET unique_code = 'SONG_NOT_FOUND';
END IF;
END;

create
definer = root@localhost procedure sp_user_creation(IN input_username varchar(255), IN input_email varchar(255),
                                                        IN input_password varchar(255), IN input_name varchar(255),
                                                        IN input_address varchar(255),
                                                        IN input_role enum ('admin', 'common'),
                                                        OUT unique_code varchar(255))
BEGIN
    DECLARE duplicate_username INT;
    DECLARE duplicate_email INT;
SELECT COUNT(*) INTO duplicate_username FROM users WHERE username = input_username;
SELECT COUNT(*) INTO duplicate_email FROM users WHERE email = input_email;
IF duplicate_username > 0 THEN
        SET unique_code = 'DUPLICATE_USERNAME';
    ELSEIF duplicate_email > 0 THEN
        SET unique_code = 'DUPLICATE_EMAIL';
ELSE
        IF password_validation(input_password) = TRUE THEN
            -- Insert the user and customer info
            INSERT INTO users (username, email, password, role)
            VALUES (input_username, input_email, input_password, input_role);
            SET @user_id = LAST_INSERT_ID();
INSERT INTO customers (id_user, name, address) VALUES (@user_id, input_name, input_address);
SET unique_code = 'SUCCESS';
ELSE
            SET unique_code = 'INVALID_PASSWORD';
END IF;
END IF;
END;

create
definer = root@localhost procedure sp_user_login_validation(IN input_username_email varchar(255),
                                                                IN input_password varchar(255),
                                                                OUT unique_code varchar(255))
BEGIN
    DECLARE duplicate_password VARCHAR(255);
    DECLARE user_role VARCHAR(255);
SELECT password, role INTO duplicate_password, user_role FROM users
WHERE username = input_username_email OR email = input_username_email;
IF input_password = duplicate_password THEN
        SET unique_code = 'VALID_USER';
        IF user_role = 'admin' THEN
          SET unique_code = 'ADMIN_USER';
END IF;
ELSE
        SET unique_code = 'INVALID_CREDENTIALS';
END IF;
END;

