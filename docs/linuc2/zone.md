レコード

|フィールド| 説明|
|---|---|
| ドメイン要素| ドメイン名、ホスト名、アドレスなど|
| 生存期間| TTL |
| オブジェクトアドレスタイプ| IN |
| レコードタイプ　| SOA, NS, A, PTR, MX, CNAME, AAAA|
| データ | レコードタイプに応じたデータを記述 |

レコードタイプ

| レコードタイプ| 説明| ドメイン要素名 |データ |
|---|---|--- |---|
|SOA| 管理権限の定義| mylinuc.com.|ns.mylinuc.com. root.mylinuc.com.|
|NS| ネームサーバ| mylinuc.com.|ns.mylinuc.com.|
|A| ホスト名からIPアドレスへの対応付けの定義| ns.mylinuc.com.| 192.168.1.1|
|PTR| IPアドレスからホスト名への対応付けを定義| 1.1.168.192.in-addr.arpa.| ns.mylinuc.com.|
|MX| ドメイン名からメールサーバ名への対応付けを定義| mylinuc.com.|10 mail.mylinuc.com.|
|CNAME| 別名から正規名への対応付けを定義| www.mylinuc.com.| ns.mylinuc.com.|


zoneファイルの例 (TTL省略)

```
$ORIGIN myliunc.com. ; zoneの起点。省略したら 設定ファイルのzoneステートメントのドメイン名。@も。
mylinuc.com.  IN SOA ns.mylinuc.com. root.mylinuc.com. (
                     2021030101; serial
                     10800; refresh
                     3600; retry 
                     604800; expire
                    3600; minimum


                     )
              NS ns.mylinuc.com. ; ドメイン要素を省略したら 現在のドメイン要素のmylinuc.com.になる
              MX 10 mail.mylinuc.com. ; IN は省略できる。
ns            A  192.168.1.2 ; ns は 補完され、ns.mylinuc.com.　になる
mail          A  192.168.1.2
www           CNAME ns.mylinuc.com.

```

## サブドメイン

zoneファイルの例

```
mylinuc.com IN SOA ns.mylinuc.com. ()
               NS ns.mylinuc.com.
ns.mylinuc.com. A 172.16.1.1
sub.mylinuc.com. NS ns.sub.mylinuc.com. ; サブドメインのネームサーバー
ns.sub.mylinuc.com. A 172.17.2.1; glueレコード これがないと、クライアントはサブドメインのネームサーバーのIPがわからない。
```

## コマンド

- rndc
- dig
- host
- nslookup

### rndc

- 設定再読込 rndc reload 
- zone再読込 rndc reload {zone}

### dig