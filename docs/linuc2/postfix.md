## mailの概念

- MTA, MDA, MUA がある。
- - MTA mail transfer agent. メール転送、受信
- - MDA mail derivary agent. メール受信、/var/spool/postfix にメールを送る。
- - MUA mail user agent. ユーザーが使うagent. firefox, outlook等



## 主要サービス

- Postfix...MTA 
- - デーモン master, postdrop, pickup, cleanup, qmgr, local, smtpd, smtp
- - 設定ファイル /etc/postfix/master.cf デーモンの構成の設定. /etc/postfix/main.cf 設定のパラメータなど。
- Dovecot...IMAP, POP3. MDAとしても機能する。リモートからの要請でメールを配信する。
- - 設定ファイル /etc/dovecot/dovecot.conf, その中で呼び出される /etc/dovecot/conf.d の設定ファイル群

## 送信、受信のデーモンの動き

### 送信

postdrop -> maildrop que -> pickup -> clenup -> imcoming que active que -> qmgr ->  
ローカルなら ->local -> /var/spool/mail  
リモートなら -> smtp

### 受信

smtpd -> cleanup -> imcoming que active que -> qmgr -> local -> /var/spool/mail

