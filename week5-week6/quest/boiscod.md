<!-- 病院の管理システムのデータベースを設計してください。

要件は次の通りです。

患者と診療科が決まると担当医師も決まる(担当医師は一人のみ)
一人の医師は一つの診療科を担当する
一人の患者は複数の診療科を受診することがある
現在、次のテーブルが作成されています。

[担当医師テーブル]

患者
診療科
担当医師
プライマリーキー：患者,診療科

このテーブルはボイスコッド正規形になっていません。

このテーブルがボイスコッド正規形になるよう設計してください。テーブル名と、テーブルに紐づくカラム名とプライマリーキーを記載してください。なお、テーブル名とカラム名は日本語で大丈夫です。 -->
[患者テーブル]
・患者ID
プライマリーキー：患者ID

[診療科テーブル]
・診療科ID
プライマリーキー：診療科ID

[医師テーブル]
・医師ID
・診療科ID
プライマリーキー：医師ID

[患者診療科テーブル]
・患者ID
・診療科ID
・医師ID
プライマリーキー：患者ID, 診療科ID