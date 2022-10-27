FROM dart:2.18.2 

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get


COPY . .
RUN dart compile exe bin/task_service.dart -o bin/build

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.

ENTRYPOINT [ "/app/bin/build" ]