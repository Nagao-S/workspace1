<!-- ステップ1
テーブル設計をしてください。

テーブルごとにテーブル名、カラム名、データ型、NULL(NULL OK の場合のみ YES と記載)、キー（キーが存在する場合、PRIMARY/INDEX のどちらかを記載）、初期値（ある場合のみ記載）、AUTO INCREMENT（ある場合のみ YES と記載）を記載してください。また、外部キー制約、ユニークキー制約に関しても記載してください。

その際に、少なくとも次のことは満たしてください。

・アプリケーションとして成立すること(プログラムを組んだ際に仕様を満たして動作すること)
・正規化されていること -->

## テーブル設計
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
|episode_number|INT|NO|NO|NULL|
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
|start_date|DATE|NO|NULL|NULL|NO|
|start_time|TIME|NO|NULL|NULL|NO|
|end_time|TIME|NO|NULL|NULL|NO|
・外部キー制約：episode_id, channel_id

historiesテーブル（視聴履歴）
|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|:--|:--|:--|:--|:--|:--|
|history_id|INT|NO|PRIMARY|NULL|YES|
|user_id|INT|NO|NULL|FOREIGN|NO|
|program_id|INT|NO|FOREIGN|NULL|NO|
|episode_id|INT|NO|FOREIGN|NULL|NO|
|channel_id|INT|NO|FOREIGN|NULL|NO|
|view_date|DATE|NO|NULL|NULL|NO|
・外部キー制約：user_id, program_id, episode_id,channel_id


