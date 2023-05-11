<!-- ステップ3
以下のデータを抽出するクエリを書いてください。 -->

<!-- よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください -->
SELECT episode_name, COUNT(*) AS view_count
FROM histories
JOIN episodes  ON histories.episode_id = episodes.episode_id
GROUP BY episode_name
ORDER BY view_count DESC
LIMIT 3;

<!-- よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください -->
SELECT p.program_title,s.season_number,e.episode_number, e.episode_name, COUNT(*) AS view_count
FROM histories h
JOIN episodes  e ON h.episode_id = e.episode_id
JOIN seasons s ON e.season_id = s.season_id
JOIN programs p ON e.program_id = p.program_id
GROUP BY p.program_title,s.season_number,e.episode_number, e.episode_name
ORDER BY view_count DESC
LIMIT 3;


<!-- 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします -->
SELECT c.channel_name, b.start_date, b.start_time, b.end_time, s.season_number, e.episode_number, e.episode_name, e.episode_detail
FROM broadcasts b
JOIN episodes e ON b.episode_id = e.episode_id
JOIN seasons s ON e.season_id = s.season_id
JOIN channels c ON b.channel_id = c.channel_id
WHERE b.start_date = CURDATE();


<!-- ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください -->
SELECT b.start_date, b.start_time, b.end_time, s.season_number, e.episode_number, e.episode_name, e.episode_detail
FROM broadcasts b
JOIN episodes e ON b.episode_id = e.episode_id
JOIN seasons s ON e.season_id = s.season_id
JOIN channels c ON b.channel_id = c.channel_id
WHERE b.start_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
AND c.channel_name = 'Channel 2';

<!-- (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください -->
SELECT p.program_title, COUNT(*) AS view_count
FROM histories h
JOIN programs p ON h.program_id = p.program_id
WHERE h.view_date BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()
GROUP BY p.program_title
ORDER BY view_count DESC
LIMIT 2;


<!-- (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。 -->

WITH episode_view_counts AS (
SELECT h.episode_id, h.program_id,COUNT(h.history_id) AS view_count
FROM histories h
GROUP BY h.episode_id,h.program_id),
genre_avg_programs AS (
SELECT g.genre_name, p.program_title, AVG(evc.view_count) AS average_views
FROM genres g
LEFT JOIN program_genres pg ON g.genre_id = pg.genre_id
LEFT JOIN programs p ON p.program_id = pg.program_id
LEFT JOIN episode_view_counts evc ON evc.program_id = p.program_id
GROUP BY g.genre_id, p.program_id),
genre_max_views AS (
SELECT genre_name, MAX(average_views) AS max_views
FROM genre_avg_programs 
GROUP BY genre_name)
SELECT gap.genre_name,gap.program_title, gap.average_views
FROM genre_avg_programs gap
JOIN genre_max_views gmv ON gap.genre_name = gmv.genre_name AND gap.average_views = gmv.max_views;