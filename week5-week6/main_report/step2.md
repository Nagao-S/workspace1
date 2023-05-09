<!-- ステップ2
実際にテーブルを構築し、データを入れましょう。その手順をドキュメントとしてまとめてください（アウトプットは手順のドキュメントです）。

具体的には、以下のことを行う手順のドキュメントを作成してください。

データベースを構築します
ステップ1で設計したテーブルを構築します
サンプルデータを入れます。サンプルデータはご自身で作成ください（ChatGPTを利用すると比較的簡単に生成できます）
手順のドキュメントは、他の人が見た時にその手順通りに実施すればテーブル作成及びサンプルデータ格納が行えるように記載してください。

なお、ステップ2は以下のことを狙っています。

データを実際に入れることでステップ3でデータ抽出クエリを試せるようにすること
手順をドキュメントにまとめることで、自身がやり直したい時にすぐやり直せること
手順を人が同じように行えるようにまとめることで、ドキュメントコミュニケーション力を上げること -->

# データベースの作成

 ```sql
   CREATE DATABASE internet_tv;

 ```

# データベースの選択

   ```sql
     USE internet_tv;
   ```

# 各種テーブルの作成

usersテーブル
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|user_id|INT|NO|PRIMARY|NULL|YES|
|user_name|VARCHAR(255)|NO|NULL|NULL|NO|
|email|VARCHAR(255)|NO|NULL|NULL|NO|
|password|VARCHAR(255)|NO|NULL|NULL|NO|
|created_at|TIMESTAMP|NO|NULL|NULL|NO|

channelsテーブル（各チャンネルの詳細）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|channel_id|INT|NO|PRIMARY|NULL|YES|
|channel_name|VARCHAR(255)|NO|NULL|NULL|NO|


programsテーブル（各番組の詳細）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|program_id|INT|NO|PRIMARY|NULL|YES|
|program_title|VARCHAR(255)|NO|NULL|NULL|NO|
|program_detail|TEXT|NO|NULL|NULL|NO|

episodesテーブル（各エピソードの詳細）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|episode_id|INT|NO|PRIMARY|NULL|YES|
|program_id|INT|NO|FOREIGN|NULL|NO|
|season_id|INT|NO|FOREIGN|NULL|NO|
|episode_name|VARCHAR(255)|NO|NULL|NULL|NO|
|episode_detail|TEXT|NO|NULL|NULL|NO|
・外部キー制約：program_id, season_id

program_genresテーブル（番組とジャンルの中間テーブル）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|program_genre_id|INT|NO|PRIMARY|NULL|YES|
|program_id|INT|NO|FOREIGN|NULL|NO|
|genre_id|INT|NO|FOREIGN|NULL|NO|
・外部キー制約：program_id, genre_id

genresテーブル（ジャンル）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|genre_id|INT|NO|PRIMARY|NULL|YES|
|genre_name|VARCHAR(255)|NO|NULL|NULL|NO|


seasonsテーブル（各シーズンの詳細）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|season_id|INT|NO|PRIMARY|NULL|YES|
|program_id|INT|NO|FOREIGN|NULL|NO|
|season_number|INT|NO|NULL|NULL|NO|
・外部キー制約：program_id

broadcastsテーブル（時間帯）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|broadcast_id|INT|NO|PRIMARY|NULL|YES|
|episode_id|INT|NO|FOREIGN|NULL|NO|
|channel_id|INT|NO|FOREIGN|NULL|NO|
|start_time|TIME|NO|NULL|NULL|NO|
|end_time|TIME|NO|NULL|NULL|NO|
・外部キー制約：episode_id, channel_id

historiesテーブル（視聴履歴）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|history_id|INT|NO|PRIMARY|NULL|YES|
|user_id|INT|NO|NULL|FOREIGN|NO|
|program_id|INT|NO|FOREIGN|NULL|NO|
|channel_id|INT|NO|FOREIGN|NULL|NO|
|view_date|DATE|NO|NULL|NULL|NO|
・外部キー制約：user_id, program_id, channel_id

# テーブル作成

## テーブルの作成

   ```sql
CREATE TABLE users (
  user_id INT NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE channels (
  channel_id INT NOT NULL AUTO_INCREMENT,
  channel_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (channel_id)
);

CREATE TABLE programs (
  program_id INT NOT NULL AUTO_INCREMENT,
  program_title VARCHAR(255) NOT NULL,
  program_detail TEXT NOT NULL,
  PRIMARY KEY (program_id)
);

CREATE TABLE seasons (
  season_id INT NOT NULL AUTO_INCREMENT,
  program_id INT NOT NULL,
  season_number INT NOT NULL,
  PRIMARY KEY (season_id),
  FOREIGN KEY (program_id) REFERENCES programs(program_id)
);

CREATE TABLE episodes (
  episode_id INT NOT NULL AUTO_INCREMENT,
  program_id INT NOT NULL,
  season_id INT NOT NULL,
  episode_name VARCHAR(255) NOT NULL,
  episode_number INT NOT NULL,
  episode_detail TEXT NOT NULL,
  PRIMARY KEY (episode_id),
  FOREIGN KEY (program_id) REFERENCES programs(program_id),
  FOREIGN KEY (season_id) REFERENCES seasons(season_id)
);

CREATE TABLE genres (
  genre_id INT NOT NULL AUTO_INCREMENT,
  genre_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (genre_id)
);

CREATE TABLE program_genres (
  program_genre_id INT NOT NULL AUTO_INCREMENT,
  program_id INT NOT NULL,
  genre_id INT NOT NULL,
  PRIMARY KEY (program_genre_id),
  FOREIGN KEY (program_id) REFERENCES programs(program_id),
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);



CREATE TABLE broadcasts (
  broadcast_id INT NOT NULL AUTO_INCREMENT,
  episode_id INT NOT NULL,
  channel_id INT NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  PRIMARY KEY (broadcast_id),
  FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

CREATE TABLE histories (
  history_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  program_id INT NOT NULL,
  episode_id INT NOT NULL,
  channel_id INT NOT NULL,
  view_date DATE NOT NULL,
  PRIMARY KEY (history_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (program_id) REFERENCES programs(program_id),
  FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

   ```


## サンプルデータ

```sql
INSERT INTO users (user_name, email, password, created_at)
VALUES
('John Doe', 'john.doe@example.com', 'password1', NOW()),
('Jane Smith', 'jane.smith@example.com', 'password2', NOW()),
('Alice Brown', 'alice.brown@example.com', 'password3', NOW()),
('Bob Johnson', 'bob.johnson@example.com', 'password4', NOW()),
('Charlie White', 'charlie.white@example.com', 'password5', NOW()),
('Daniel Harris', 'daniel.harris@example.com', 'password6', NOW()),
('Eva Clark', 'eva.clark@example.com', 'password7', NOW()),
('Frank Lewis', 'frank.lewis@example.com', 'password8', NOW()),
('Grace Walker', 'grace.walker@example.com', 'password9', NOW()),
('Henry Hall', 'henry.hall@example.com', 'password10', NOW());

INSERT INTO genres (genre_name)
VALUES
('Action'),
('Adventure'),
('Comedy'),
('Drama'),
('Fantasy'),
('Horror'),
('Mystery'),
('Romance'),
('Sci-Fi'),
('Thriller');

INSERT INTO channels (channel_name)
VALUES
('Channel 1'),
('Channel 2'),
('Channel 3'),
('Channel 4'),
('Channel 5'),
('Channel 6'),
('Channel 7'),
('Channel 8'),
('Channel 9'),
('Channel 10');

INSERT INTO programs (program_title, program_detail)
VALUES
('Program A', 'This is a detail of Program A'),
('Program B', 'This is a detail of Program B'),
('Program C', 'This is a detail of Program C'),
('Program D', 'This is a detail of Program D'),
('Program E', 'This is a detail of Program E'),
('Program F', 'This is a detail of Program F'),
('Program G', 'This is a detail of Program G'),
('Program H', 'This is a detail of Program H'),
('Program I', 'This is a detail of Program I'),
('Program J', 'This is a detail of Program J');

INSERT INTO seasons (program_id, season_number)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 1),
(5, 2);

INSERT INTO episodes (program_id, season_id, episode_name,episode_number, episode_detail)
VALUES
(1, 1, 'はじまり', 1, 'This is a detail of Episode 1'),
(1, 1, '別れ', 2, 'This is a detail of Episode 2'),
(1, 1, '奇跡', 3, 'This is a detail of Episode 3'),
(1, 1, '悪夢', 4, 'This is a detail of Episode 4'),
(1, 1, '誕生日', 5, 'This is a detail of Episode 5'),
(2, 3, 'タバスコ', 1, 'This is a detail of Episode 1'),
(2, 3, '３度寝',2, 'This is a detail of Episode 2'),
(2, 3, '朝ごはん', 3, 'This is a detail of Episode 3'),
(2, 3, '土葬', 4, 'This is a detail of Episode 4'),
(2, 3, 'あたた', 5, 'This is a detail of Episode 5');

INSERT INTO broadcasts (episode_id, channel_id, start_time, end_time)
VALUES
(1, 1, '18:00:00', '19:00:00'),
(2, 1, '19:00:00', '20:00:00'),
(3, 2, '20:00:00', '21:00:00'),
(4, 3, '21:00:00', '22:00:00'),
(5, 4, '22:00:00', '23:00:00'),
(6, 5, '23:00:00', '00:00:00'),
(7, 6, '00:00:00', '01:00:00'),
(8, 7, '01:00:00', '02:00:00'),
(9, 8, '02:00:00', '03:00:00'),
(10, 9, '03:00:00', '04:00:00');

INSERT INTO histories (user_id, program_id, episode_id,channel_id, view_date)
VALUES
(1, 1, 1, 1, '2023-01-01'),
(1, 2, 2, 2, '2023-01-02'),
(2, 3, 2, 3, '2023-01-03'),
(2, 4, 5, 4, '2023-01-04'),
(3, 5, 7, 5, '2023-01-05'),
(3, 6, 5, 6, '2023-01-06'),
(4, 7, 3, 7, '2023-01-07'),
(4, 8, 4, 8, '2023-01-08'),
(5, 9, 6, 9, '2023-01-09'),
(5, 10, 3, 10, '2023-01-10');

INSERT INTO histories (user_id, program_id, episode_id,channel_id, view_date)
VALUES
(1, 1, 1, 1, '2023-01-01'),
(1, 2, 2, 2, '2023-01-02'),
(1, 3, 2, 3, '2023-01-03'),
(8, 4, 5, 4, '2023-01-04'),
(3, 5, 7, 5, '2023-01-05'),
(3, 6, 5, 6, '2023-01-06'),
(3, 7, 3, 7, '2023-01-07'),
(4, 4, 2, 8, '2023-01-08'),
(7, 3, 4, 9, '2023-01-09'),
(5, 2,2, 10, '2023-01-10');

INSERT INTO program_genres (program_id, genre_id)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9);
```