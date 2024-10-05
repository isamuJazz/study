# BIND概要

DNSサーバのスタンダード。zoneファイルなど、考え方はAWS ROUTE53に通ずる。

サービス名は named, 主な設定ファイルは /etc/named.conf とそこに記述されるゾーンファイル

サーバーの役割として、権威サーバー、再帰ネームサーバー、キャッシュオンリーサーバー
キャッシュサーバーはフルリゾルバーとも呼ばれる。

DNSクライアントはスタブリゾルバーともよばれる。

## 設定ファイルとサービス

設定は /etc/named.conf  
サービスは named  

通常スタートは ``` systemctl start namd ``` だが、 ``` /usr/sbin/named -u namde -t /var/named/chroot ``` にて、非特権ユーザで、chroot jail環境で実行できる。

## 設定ファイル、ゾーンファイル



### /etc/named.conf

named-checkconfコマンドで構文チェックできる

設定例

```conf

options {
    directory "/var/named"; //zone ステートメントで指定した fileを置くディレクトリ
};

zone "." IN {
    type hint; // type とは
    file "named.ca"
};

zone "mylinuc.com" IN {
    type master; // zoneのマスターサーバになる。masterとslaveがある。
    file "zone.mylinuc.com";
};


```

- option ... namedの全体のさまざまな設定ができる
- zone ... domainのゾーン
- type ... master そのzoneのマスタ, slaveそのzone のスレーブ, hint 検索の起点
- file ... zoneファイルの場所 

### option

### zone とは


### ゾーンファイルとは



### コマンド

<b>named-checkconf</b> ... /etc/named.conf の構文チェックができる

named-checkconf [オプション] [ファイル名]


# クライアント関連

## クライアント の関連ファイル

- /etc/resolv.conf

## 用語

- 正引きはドメインネームからIP
- 逆引き IPからドメイン