-- ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。




WITH episode_view_counts AS (
    SELECT e.program_id, COUNT(h.history_id) AS view_count
    FROM episodes e
    JOIN histories h ON h.episode_id = e.episode_id
    GROUP BY e.program_id
),
genre_top_programs AS (
    SELECT g.genre_name, p.program_title, AVG(evc.view_count) AS average_views
    FROM genres g
    LEFT JOIN program_genres pg ON g.genre_id = pg.genre_id
    LEFT JOIN progepisode_view_countsrams p ON p.program_id = pg.program_id
    LEFT JOIN  evc ON evc.program_id = p.program_id
    GROUP BY g.genre_id, p.program_id
),
genre_max_views AS (
    SELECT genre_name, MAX(average_views) AS max_views
    FROM genre_top_programs
    GROUP BY genre_name
)
SELECT gm.genre_name, gtp.program_title AS top_program, gm.max_views AS top_average_views
FROM genre_max_views gm
JOIN genre_top_programs gtp ON gm.genre_name = gtp.genre_name AND gm.max_views = gtp.average_views;

SELECT * FROM histories;