ソフトウェアベースのパケットフィルタリング。

- netfilter... モジュール
- iptables ... 管理ツール

iptablesはそのラッパーツールとして

- ufw ... 初心者にも使いやすいラッパー
- firewalld ... ゾーンベースの管理ができる

ものがある。どちらも内部でiptablesを使用する。

## 概念

- テーブル パケットフィルタを適用するものがどういうカテゴリか
- チェイン テーブルにおける経路。 INPUT, OUTPUT
- ルール チェインに適用するルール -p protocol -s source -sport source port など
- ターゲット ルールにマッチしたパケットに対する具体的な行動 ACCEPT, DROPなど

### テーブル

※ほかもあるが、テストに出なさそうなので割愛

|テーブル名|説明|含まれるチェイン |
|---|---| --- |
|filter| フィルタリングを行う| INPUT, FORWARD, OUTPUT|
|nat| アドレス変換を行う| PREROUTING, OUTPUT, POSTROUTING|

### チェイン

|チェイン名|説明|
|---|---|
|INPUT| ローカルホストへの入力パケットに適用するチェイン| 
|OUTPUT| ローカルホストからの出力パケットに適用するチェイン| 
|FORWARD| ローカルホストを経由するパケットに適用するチェイン| 
|PREROUTING| ルーティング決定前に適用するチェイン| 
|PORTROUTING| ルーティング決定後に適用するチェイン|

### ルール

※主要なもの

!頭につけると否定になる

|ルール名|説明|
|---|---|
|-p --protocol| ucp, udp, icmp, all のいずれかを指定する| 
|-s --source| 送信元アドレス。指定なしならすべてのアドレス| 
|-d --destination| 送信先アドレス。指定なしならすべて| 
|--sport| 送信元ポート。 指定なしならすべてのポート。-m multiportでカンマ区切りで複数のポートが可能. -m multiport --sports 20,21,25,53| 
|--dport|送信先ポート、指定なしならすべて| 
|-i --in-interface| INPUT FORWARD, PREROUTINGのいずれかで使用できる| 
|-o | FORWARD, OUTPUT, POSTROUTINGのいずれか| 

### ターゲット

-j, --jump で指定する。

|ルール名|使用できるテーブル| 使用できるチェイン| 説明 |
|---|---|---|---|
|★ACCEPT|すべて|すべて|許可|
|★DROP|すべて|すべて|破棄。ICMPエラーメッセージを返さない|
|★RETURN|すべて|すべて|実行中のチェインの処理を終了し、当チェインの呼び出し元のチェインに戻って次のルールを実行|
|REJECT|すべて|INPUT, OUTPUT, FORWARD, ユーザー定義チェイン|拒否。ICMPエラーメッセージを返す|
|REDIRECT|nat|PREROUTING, OUTPUT, ユーザー定義チェイン|送信先アドレスをマシン自身のIPアドレスにリダイレクト|
|DNAT|nat|PREROUTING, OUTPUT, |送信先アドレスの書き換え|
|SNATT|nat|POSTROUTING, INPUT, |送信元アドレスの書き換え|
|MASQUERADE|nat| POSTROUTING|送信元アドレスの書き換え。動的に設定されたアドレスの場合に使用する。|
|★LOG|すべて| すべて|ログを記録。終了せず次のルールへ進む|

### コマンドサンプル

```shell

iptables -A INPUT -p tcp --dport 22 -j ACCEPT

```

同様のものをufwなら

```shell

ufw allow ssh

```

## コマンド重要なもの

リストを出す
```

iptables -t filter -L

```

設定の読込と保存

```shell

iptables-save > iptables-save.txt
iptables-restore < iptables-save.txt

```

## firewalld

firewalldデーモンと、firewall-cmdからなるiptablesのラッパー。内部でiptablesを実行し、カーネル内部のNetfiletrを設定する。

※コマンドのオプションは多く覚えきれないので割愛

