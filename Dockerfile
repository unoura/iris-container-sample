# 必要に応じてベースイメージを変更してください
FROM containers.intersystems.com/intersystems/irishealth:latest-em

USER ${ISC_PACKAGE_MGRUSER}
COPY iris.script /tmp/iris.script

RUN iris start IRIS \
    && iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly

