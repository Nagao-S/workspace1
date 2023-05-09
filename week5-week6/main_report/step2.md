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
   CREATE DATABASE IF NOT EXISTS `internet_tv` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
 ```

# データベースの選択

   ```sql
     USE `internet_tv`;
   ```

# 各種テーブルの作成

## usersテーブル

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |user_id|INT|NO|PRIMARY|NULL|YES|
   |user_name|VARCHAR(255)|NO|NULL|NULL|NO|
   |email|VARCHAR(255)|NO|NULL|NULL|NO|
   |password|VARCHAR(255)|NO|NULL|NULL|NO|
   |created_at|TIMESTAMP|NO|NULL|NULL|NO|

## programsテーブル（各番組の詳細）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |program_id|INT|NO|PRIMARY|NULL|YES|
   |program_title|VARCHAR(255)|NO|NULL|NULL|NO|
   |program_detail|TEXT|NO|NULL|NULL|NO|
   |genre_id|INT|NO|FOREIGN|NULL|NO|
   ・外部キー制約：genre_id

## episodesテーブル（各エピソードの詳細）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |episode_id|INT|NO|PRIMARY|NULL|YES|
   |program_id|INT|NO|FOREIGN|NULL|NO|
   |season_id|INT|NO|FOREIGN|NULL|NO|
   |episode_name|VARCHAR(255)|NO|NULL|NULL|NO|
   |episode_detail|TEXT|NO|NULL|NULL|NO|
   ・外部キー制約：program_id, season_id

## seasonsテーブル（各シーズンの詳細）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |season_id|INT|NO|PRIMARY|NULL|YES|
   |season_number|INT|NO|NULL|NULL|NO|

## channelsテーブル（各チャンネルの詳細）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |channel_id|INT|NO|PRIMARY|NULL|YES|
   |channel_name|VARCHAR(255)|NO|NULL|NULL|NO|

## historiesテーブル（視聴履歴）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |history_id|INT|NO|PRIMARY|NULL|YES|
   |user_id|INT|NO|NULL|FOREIGN|NO|
   |program_id|INT|NO|FOREIGN|NULL|NO|
   |channel_id|INT|NO|FOREIGN|NULL|NO|
   ・外部キー制約：user_id, program_id, channel_id

## genresテーブル（ジャンル）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |genre_id|INT|NO|PRIMARY|NULL|YES|
   |genre_name|VARCHAR(255)|NO|NULL|NULL|NO|

## time_zonesテーブル（時間帯）

   |カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
   |:--|:--|:--|:--|:--|:--|
   |time_zone_id|INT|NO|PRIMARY|NULL|YES|
   |episode_id|INT|NO|FOREIGN|NULL|NO|
   |channel_id|INT|NO|FOREIGN|NULL|NO|
   |start_time|TIME|NO|NULL|NULL|NO|
   |end_time|TIME|NO|NULL|NULL|NO|
   ・外部キー制約：episode_id, channel_id

# テーブル作成

## usersテーブルの作成

   ```sql
  CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL
  );
   ```

## genresテーブルの作成

   ```sql
CREATE TABLE genres (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  genre_name VARCHAR(255) NOT NULL
);
  ```
## programsテーブルの作成

   ```sql
   CREATE TABLE programs (
  program_id INT AUTO_INCREMENT PRIMARY KEY,
  program_title VARCHAR(255) NOT NULL,
  program_detail TEXT NOT NULL,
  genre_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);
   ```
## seasonsテーブルの作成

   ```sql
CREATE TABLE seasons (
  season_id INT AUTO_INCREMENT PRIMARY KEY,
  season_number INT NOT NULL
);

   ```

## episodesテーブルの作成

   ```sql
CREATE TABLE episodes (
  episode_id INT AUTO_INCREMENT PRIMARY KEY,
  season_id INT NOT NULL,
  episode_name VARCHAR(255) NOT NULL,
  episode_detail TEXT NOT NULL,
  FOREIGN KEY (season_id) REFERENCES seasons(season_id)
);

   ```


## channelsテーブルの作成

   ```sql
CREATE TABLE channels (
  channel_id INT AUTO_INCREMENT PRIMARY KEY,
  channel_name VARCHAR(255) NOT NULL
);

   ```

## historiesテーブルの作成

   ```sql
CREATE TABLE histories (
  history_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  program_id INT NOT NULL,
  channel_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (program_id) REFERENCES programs(program_id),
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

   ```




## time_zonesテーブルの作成

   ```sql
CREATE TABLE time_zones (
  time_zone_id INT AUTO_INCREMENT PRIMARY KEY,
  episode_id INT NOT NULL,
  channel_id INT NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

   ```

## サンプルデータ
-- usersテーブル
```sql
INSERT INTO users (user_name, email, password, created_at)
VALUES ('Alice', 'alice@example.com', 'password123', NOW()),
       ('Bob', 'bob@example.com', 'password456', NOW()),
       ('Charlie', 'charlie@example.com', 'password789', NOW());
```

-- genresテーブル
```sql
INSERT INTO genres (genre_name)
VALUES ('ドラマ'), ('アニメ'), ('バラエティ'), ('ニュース'), ('ドキュメンタリー');
```

-- channelsテーブル
```sql
INSERT INTO channels (channel_name)
VALUES ('チャンネル1'), ('チャンネル2'), ('チャンネル3');
```

-- programsテーブル
```sql
INSERT INTO programs (program_title, program_detail, genre_id)
VALUES ('ドラマA', 'ドラマAの説明', 1),
       ('アニメA', 'アニメAの説明', 2),
       ('バラエティA', 'バラエティAの説明', 3),
       ('ニュースA', 'ニュースAの説明', 4),
       ('ドキュメンタリーA', 'ドキュメンタリーAの説明', 5);
```

-- seasonsテーブル
```sql
INSERT INTO seasons (season_number)
VALUES (1), (2);
```

-- episodesテーブル
```sql
INSERT INTO episodes (season_id, episode_name, episode_detail)
VALUES (1, 'ドラマA 第1話', 'ドラマA 第1話の説明'),
       (1, 'ドラマA 第2話', 'ドラマA 第2話の説明'),
       (2, 'アニメA 第1話', 'アニメA 第1話の説明'),
       (2, 'アニメA 第2話', 'アニメA 第2話の説明');
```

-- time_zonesテーブル
```sql
INSERT INTO time_zones (episode_id, channel_id, start_time, end_time)
VALUES (1, 1, '19:00:00', '19:30:00'),
       (2, 1, '19:30:00', '20:00:00'),
       (3, 2, '18:00:00', '18:30:00'),
       (4, 2, '18:30:00', '19:00:00');
```

-- historiesテーブル
```sql
INSERT INTO histories (user_id, program_id, channel_id)
VALUES (1, 1, 1),
       (2, 2, 1),
       (3, 3, 2);
```
