
FROM dart:2.18.2 AS builder

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get


COPY . .
RUN dart compile exe bin/auth_service.dart -o bin/build

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=builder /runtime/ /
COPY --from=builder /app/bin/build /app/bin/



ENTRYPOINT [ "/app/bin/build" ]
