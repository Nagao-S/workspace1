-- エピソードごとの視聴数をまとめる
-- SELECT h.episode_id, h.program_id,COUNT(h.history_id) AS view_count
-- FROM histories h
-- GROUP BY h.episode_id,h.program_id;

-- 各ジャンルの番組ごとのトップ平均視聴数をまとめる
-- WITH episode_view_counts AS (
-- SELECT h.episode_id, h.program_id,COUNT(h.history_id) AS view_count
-- FROM histories h
-- GROUP BY h.episode_id,h.program_id)
-- SELECT g.genre_name, p.program_title, AVG(evc.view_count) AS average_views
-- FROM genres g
-- LEFT JOIN program_genres pg ON g.genre_id = pg.genre_id
-- LEFT JOIN programs p ON p.program_id = pg.program_id
-- LEFT JOIN episode_view_counts evc ON evc.program_id = p.program_id
-- GROUP BY g.genre_id, p.program_id;

-- 各ジャンルの番組ごとの平均視聴率の高いものとその平均視聴率をまとめる
-- WITH episode_view_counts AS (
-- SELECT h.episode_id, h.program_id,COUNT(h.history_id) AS view_count
-- FROM histories h
-- GROUP BY h.episode_id,h.program_id),
-- genre_avg_programs AS (
-- SELECT g.genre_name, p.program_title, AVG(evc.view_count) AS average_views
-- FROM genres g
-- LEFT JOIN program_genres pg ON g.genre_id = pg.genre_id
-- LEFT JOIN programs p ON p.program_id = pg.program_id
-- LEFT JOIN episode_view_counts evc ON evc.program_id = p.program_id
-- GROUP BY g.genre_id, p.program_id)
-- SELECT genre_name, MAX(average_views) AS max_views
-- FROM genre_avg_programs
-- GROUP BY genre_name


-- ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。
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