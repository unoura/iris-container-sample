# iris-container-sample

Container で InterSystems IRIS for Health ( **製品版** )を動作させるサンプルです。

※ WebサーバとしてApacheを利用していますが、Nginxを利用したい場合は 下記より[Nginxを利用する場合](#nginxを利用する場合)を参照してください。

## 起動手順

- 1. シェルを実行します。 
    このシェルは
    [永続ボリューム(./durable)](./durable/)のディレクトリがなければ作成し、Permissionを変更します。

    ※ docker-compose.ymlにより、ホストの[durableディレクトリ](./durable/)をコンテナの/durable ディレクトリにボリュームマウントしています。

    ```
    # シェルを実行可能にする
    chmod +x setup.sh
    # シェル実行
    ./setup.sh
    ```

- 2. キーを準備します。

    コンテナ用キーを　iris.key　として./licenses/iris.keyに配置してください。
    

- 3. コンテナを開始します。

    ```
    # 初回または Dockerfile を変更した場合
    docker compose up -d --build
    # 2回目以降
    docker compose up -d
    ```
- 管理ポータルへのアクセス確認

   [アクセス情報](#アクセス情報) を参照してください。

## 停止手順


- コンテナを停止する場合

    ※コンテナを止めるだけなので作成した内容は消えません。

    ```
    docker compose stop
    ```
- コンテナを停止+削除する場合

    ※コンテナは削除されますが、durable に保存されたデータは残ります。

    ```
    docker compose down
    
- コンテナ停止+コンテナ削除+永続ボリューム削除

    ※コンテナを削除し、durable に保存されたデータも削除します。

    ```
    docker compose down -v
    ```

## その他の操作

- ログをみる
    ```
    # すべてのコンテナのログを表示
    docker compose logs
    # ログをリアルタイムで表示
    docker compose logs -f
    # IRISコンテナのログを表示する
    docker compose logs iris
    # WebGatewayコンテナのログを表示する
    docker compose logs webgw
    ```
- IRISコンテナに接続する
    ```
    docker compose exec -it iris bash
    ```
- IRISセッションに接続する
    ```
    docker compose exec iris iris session iris
    ```
## アクセス情報

- 管理ポータルトップ

    http://localhost/csp/sys/UtilHome.csp

    ユーザ名：SuperUser
    
    パスワード：SYS


- WebGateway管理画面

  http://localhost/csp/bin/systems/module.cxw

----
## プロジェクト構成

[docker-compose.yml](./docker-compose.yml)

* コンテナのPortやVolumeなどの設定を行います。
* ボリュームの永続化を行っています(ISC_DATA_DIRECTORY)。

[Dockerfile](./Dockerfile)
* イメージ作成時にiris.script を実行します。

[merge/merge.cpf](merge/merge.cpf)    
* 各種設定を行います。
* 例として、(コメントアウトしていますが)スーパーサーバーPortの設定が記載されています

[iris.script](./iris.script)
* ロケールの設定などを行います。

[webgateway/CSP.conf](webgateway/CSP.conf)

[webgateway/CSP.ini](webgateway/CSP.ini)

* Webゲートウェイの設定を行います。

[durable/iscdata](./durable/iscdata)
* IRISのデータが保存されます。


## Nginxを利用する場合
[docker-compose.yml](docker-compose.yml)

webgwのimage： NginxのWebゲートウェイイメージを利用するように修正してください。

```
image: containers.intersystems.com/intersystems/webgateway-nginx:latest-em
```
[webgateway/CSP.conf](webgateway/CSP.conf)
このファイルを下記の内容に書き換えてください。

```
location /csp/bin/Systems {
    CSPFileTypes cxw;
    CSPNSD_pass 127.0.0.1:7038;
    CSPNSD_response_headers_maxsize 8k;
    CSPNSD_connect_timeout 300s;
    CSPNSD_send_timeout 300s;
    CSPNSD_read_timeout 300s;
}
location /csp/bin/RunTime {
    CSPFileTypes cxw;
    CSPNSD_pass 127.0.0.1:7038;
    CSPNSD_response_headers_maxsize 8k;
    CSPNSD_connect_timeout 300s;
    CSPNSD_send_timeout 300s;
    CSPNSD_read_timeout 300s;
}
location /api {
    CSP ON;
    CSPNSD_pass 127.0.0.1:7038;
    CSPNSD_response_headers_maxsize 8k;
    CSPNSD_connect_timeout 300s;
    CSPNSD_send_timeout 300s;
    CSPNSD_read_timeout 300s;
}
location /csp/sys {
    CSP ON;
    CSPNSD_pass 127.0.0.1:7038;
    CSPNSD_response_headers_maxsize 8k;
    CSPNSD_connect_timeout 300s;
    CSPNSD_send_timeout 300s;
    CSPNSD_read_timeout 300s;
}
location /csp/healthshare {
    CSP ON;
    CSPNSD_pass 127.0.0.1:7038;
    CSPNSD_response_headers_maxsize 8k;
    CSPNSD_connect_timeout 300s;
    CSPNSD_send_timeout 300s;
    CSPNSD_read_timeout 300s;
}
```


## Acknowledgements
このリポジトリは下記のリポジトリをベースに作成しています (Special thanks to @iijimam !)

https://github.com/iijimam/IRISforHealthTraining

