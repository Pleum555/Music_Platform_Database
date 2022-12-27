create database demo;
use demo;

CREATE TABLE User (
    id int NOT NULL AUTO_INCREMENT UNIQUE,
    username varchar(20) NOT NULL UNIQUE,
    email varchar(30) NOT NULL UNIQUE,
    bank_acc_no varchar(10),
    bank_acc varchar(30),
    password varchar(20) NOT NULL,
    token_amount int DEFAULT 0,
    premium_flag bool NOT NULL,
    artist_flag bool NOT NULL,
	premium_start_date timestamp,
    artist_name varchar(30),
    PRIMARY KEY (id)
);

CREATE TABLE Song (
    id int NOT NULL AUTO_INCREMENT UNIQUE,
    soundfile mediumblob NOT NULL,
    songName varchar(30) NOT NULL,
    views int NOT NULL DEFAULT 0,
    lyrics text NOT NULL,
    duration int NOT NULL default 0,
    artist_id int NOT NULL,
    status ENUM("Uploaded","Pending","Failed","Banned"),
    PRIMARY KEY (id),
    FOREIGN KEY(artist_id) REFERENCES User(id)
);

CREATE TABLE SongGenre(
	song_id int NOT NULL,
    genre varchar(20) NOT NULL,
    PRIMARY KEY (song_id,genre),
    FOREIGN KEY(song_id) references Song(id)
);

CREATE TABLE Report(
	report_id int NOT NULL AUTO_INCREMENT UNIQUE,
    report_date timestamp NOT NULL,
    user_id int NOT NULL,
    song_id int NOT NULL,
    reason text NOT NULL,
    PRIMARY KEY (report_id),
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (song_id) REFERENCES Song(id)
);

CREATE TABLE Playlist(
	playlist_id int NOT NULL AUTO_INCREMENT UNIQUE,
    playlist_name varchar(30) NOT NULL,
    PRIMARY KEY (playlist_id)
);

CREATE TABLE SongInPlaylist(
	playlist_id int NOT NULL,
    song_id int NOT NULL,
    PRIMARY KEY (playlist_id,song_id),
    FOREIGN KEY (playlist_id) references Playlist(playlist_id),
    FOREIGN KEY (song_id) references song(id)
);

CREATE TABLE Admin (
	id int NOT NULL AUTO_INCREMENT UNIQUE,
    username varchar(20) NOT NULL,
    password varchar(20) NOT NULL
);	

CREATE TABLE Advertisements(
	ad_id int NOT NULL AUTO_INCREMENT UNIQUE,
    companyName varchar(50) NOT NULL,
    admin_id int NOT NULL,
    length int DEFAULT 0,
    views int DEFAULT 0 NOT NULL,
    PRIMARY KEY (ad_id),
    FOREIGN KEY (admin_id) REFERENCES Admin(id)
);

CREATE TABLE Notification(
    notification_id int NOT NULL AUTO_INCREMENT UNIQUE,
    notification_type ENUM("User","Artist") NOT NULL,
    message text NOT NULL,
    user_id int NOT NULL,
    admin_id int NOT NULL,
    PRIMARY KEY (notification_id),
    FOREIGN KEY (user_id) references User(id),
    FOREIGN KEY (admin_id) references Admin(id)
);

CREATE TABLE Transaction (
	id int NOT NULL UNIQUE AUTO_INCREMENT,
    user_id int NOT NULL,
    exchangeType ENUM("MoneyToToken","TokenToMoney"),
    tokenAmount int NOT NULL,
    cashAmount int NOT NULL,
	timestamp timestamp NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

CREATE TABLE Donation (
	id int NOT NULL UNIQUE AUTO_INCREMENT,
    giver_id int NOT NULL,
    receiver_id int NOT NULL,
    tokenAmount int NOT NULL,
    timestamp timestamp NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (giver_id) REFERENCES User(id),
    FOREIGN KEY (receiver_id) REFERENCES User(id)
);

CREATE TABLE Subscription(
	user_id int NOT NULL,
    artist_id int NOT NULL,
    PRIMARY KEY(user_id,artist_id),
    FOREIGN KEY(user_id) REFERENCES USER(id) ON DELETE CASCADE,
    FOREIGN KEY(artist_id) REFERENCES USER(id) ON DELETE CASCADE
);

CREATE TABLE UserReport(
	id int NOT NULL UNIQUE AUTO_INCREMENT,
    timestamp timestamp NOT NULL,
    timeWatched int NOT NULL DEFAULT 0,
    user_id int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id),
    PRIMARY KEY(id)
);

CREATE TABLE UserReportRecommendation(
	user_report_id int NOT NULL,
    recommended_song_genre varchar(20) NOT NULL,
    FOREIGN KEY(User_report_id) References UserReport(id),
    PRIMARY KEY(user_report_id,recommended_song_genre)
);

CREATE TABLE ArtistReport(
	id int NOT NULL UNIQUE AUTO_INCREMENT,
    timestamp timestamp NOT NULL,
    viewsGained int NOT NULL DEFAULT 0,
    subscribersGained int NOT NULL DEFAULT 0,
    topTrends text NOT NULL,
    artist_id int NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (artist_id) references User(id)
);
