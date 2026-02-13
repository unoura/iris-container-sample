# iris-container-sample

Container で InterSystems IRIS for Healthを動作させるサンプルです。

## 起動手順

- 1. [durableディレクトリ](./durable/)のディレクトリがなければ作成し、Permissionを変更します。

    ホストの[durableディレクトリ](./durable/)をコンテナの/durable ディレクトリにボリュームマウントしています。

    ```
    ./setup.sh
    ```

- 2. キーを準備します。

    コンテナ用キーを　iris.key　として./licenses/iris.keyに配置してください。
    

- 3. コンテナをビルドしながら開始します。

    ```
    docker compose up -d --build
    ```

- 4. コンテナへのログイン

    ```
    docker compose exec -it iris bash
    ```

- 5. コンテナを停止する場合

    ※コンテナを止めるだけなので作成した内容は消えません。

    ```
    docker compose stop
    ```
- 6. コンテナを停止+削除する場合

    ※コンテナは削除されますが、durable に保存されたデータは残ります。

    ```
    docker compose down
    
- 6. コンテナ破棄

    ※コンテナを削除するため作成した内容も全てなくなります。

    ```
    docker compose rm
    ```

## アクセス情報


- [管理ポータルトップ](http://localhost/csp/sys/UtilHome.csp)

    ユーザ名：SuperUser
    
    パスワード：SYS


- [WebGateway管理画面](http://localhost/csp/bin/systems/module.cxw)

----


[docker-compose.yml]

コンテナのPortやVolumeなどの設定を行います。
* ボリュームの永続化を行っています。
* ISC_DATA_DIRECTORY


[Dockerfile]
* イメージ作成時にiris.script を実行します。

[merge/merge.cpf]
* 各種設定を行います。
* 例として、(コメントアウトしていますが)スーパーサーバーPortの設定が記載されています

[iris.script]
* ロケールの設定などを行います。

[durable/iscdata]
* IRISのデータが保存されます。

[webgateway/CSP.conf, CSP.ini]
* Webゲートウェイの設定を行います。


## Acknowledgements
下記のリポジトリをベースに作成しています:

https://github.com/iijimam/IRISforHealthTraining

Special thanks to @ iijimam !