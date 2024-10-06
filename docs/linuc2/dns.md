# BIND概要

DNSサーバのスタンダード。zoneファイルなど、考え方はAWS ROUTE53に通ずる。

サービス名は named, 主な設定ファイルは /etc/named.conf とそこに記述されるゾーンファイル

サーバーの役割として、権威サーバー、再帰ネームサーバー、キャッシュオンリーサーバー
キャッシュサーバーはフルリゾルバーとも呼ばれる。

DNSクライアントはスタブリゾルバーともよばれる。

## スタブリゾルバー

サービスやデーモンではなく、ライブラリや、OSの機能。  
- linux glibc
- windows os
- mac os

## フルリゾルバー（キャッシュサーバー、参照サーバー）

問い合わせするサーバー。クライアントの受付をする。named。  
options として、問い合わせの設定をしてある。zoneは持たないことが多い。


```conf

options {
  type hint; 書かないことが多いらしい。
  recursion yes; 再帰問い合わせする
  allow-recursion { 127.0.0.1; }; どこからを許すか
  forward-first; まず、forwardersに問い合わせて、結果がなければ自分で再帰問い合わせする。
  forwarders { 8.8.8.8;};

}
```

## 権威サーバー

自分のzoneを管理する。  

type master, slave などになる。
自分のゾーンを管理するのが目的なのでrecursionはない。

### フルリゾルバーと権威サーバーの兼用

基本的に分けているが、兼ね備える場合は両方の特徴を設定する。

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

サーバの役割に関する設定を書く

### zone とは

ドメインのゾーン。 mulinuc.com など。 . は全世界

### ゾーンファイルとは

IPとdomainを紐づけるファイル。詳しくは別途

### コマンド

<b>named-checkconf</b> ... /etc/named.conf の構文チェックができる

named-checkconf [オプション] [ファイル名]

=================
## クライアント関連

## クライアント の関連ファイル

- /etc/resolv.conf

## 用語

- 正引きはドメインネームからIP
- 逆引き IPからドメイン