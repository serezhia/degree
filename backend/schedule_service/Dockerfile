FROM dart:2.18.2-sdk
WORKDIR /service

ADD . /service/

RUN dart pub get


ENTRYPOINT ["dart", "bin/schedule_service.dart"]
