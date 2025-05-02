## Amazon Rekognition 

[Amazon Rekoginitionとは](https://docs.aws.amazon.com/rekognition/latest/dg/what-is.html)

- 画像・映像の分析サービス

### ユースケース

- 顔認識・認証など
- 文字認識
- 安全でない映像の検知
- 人の認識、映像から特定の人物を探すなど


## Amazon Persona

[Amazon Personalizeとは](https://docs.aws.amazon.com/personalize/latest/dg/what-is-personalize.html)

個人に対してレコメンデーションや、特化した情報を表示する

### ユースケース

- ターゲット広告
- 検索の個人最適化
- personalizeされたメール
- 商品のレコメンデーション

## Amazon Inspector

[Amazon Inspectorとは](https://docs.aws.amazon.com/inspector/latest/user/what-is-inspector.html)

EC2, ECR imageないの脆弱性検知サービス

### ユースケース

- 環境の脆弱性を継続的にスキャンし、 ネットワークへの露出

## Bedrock ガードレール

[Amazon Bedrock Guardrails を使用して有害なコンテンツを検出してフィルタリングする](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails.html)

入力のフィルタリングなど

### ユースケース

- チャットボットで有害な入力のフィルタリング
- ユーザーのクエリをブロックする
- 有害なコンテンツのフィルター、有害な言葉のフィルター、機密情報のマスク


## Amazon Macie

[Amazon Macieとは](https://docs.aws.amazon.com/macie/latest/user/what-is-macie.html)

機械学習を用いて機密データを発見するデータセキュリティサービス

## ユースケース

- S3に保存されたデータに対し、機密データ発見の自動化

## Amazon Comprehend

[Amazon Comprehendとは何ですか?](https://docs.aws.amazon.com/comprehend/latest/dg/what-is.html)

### ユースケース

>次の例は、Amazon Comprehend オペレーションを アプリケーション。

>例 1: 主題に関するドキュメントを検索する
Amazon Comprehend トピックモデリングを使用して、特定のテーマに関するドキュメントを検索します。スキャン 議論されたトピックを特定し、ドキュメントを見つけるための一連のドキュメント 各トピックに関連付けられています。Amazon Comprehend が指定するトピックの数を指定できます ドキュメントセットから戻ります。


>例 2: お客様が商品についてどのように感じているかを調べる
あなたの会社がカタログを発行している場合は、Amazon Comprehend に顧客が何を考えているかを教えてもらいます あなたの製品。各顧客のコメントを操作に送信すると、顧客が肯定的、否定的、中立的、 または製品について混合します。DetectSentiment


>例 3: 顧客にとって重要なことを発見する
Amazon Comprehend トピックモデリングを使用して、顧客がフォーラムで話しているトピックを発見します とメッセージボードを使用して、エンティティ検出を使用して、関連付ける人、場所、物を特定します をトピックに置き換えます。センチメント分析を使用して、顧客がトピックについてどのように感じているかを判断します。