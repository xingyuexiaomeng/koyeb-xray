FROM alpine:3.20
RUN apk add --no-cache ca-certificates curl unzip file
RUN set -e; \
    U=$(echo 'aHR0cHM6Ly9naXRodWIuY29tL1hUTFMvWHJheS1jb3JlL3JlbGVhc2VzL2xhdGVzdC9kb3dubG9hZC9YcmF5LWxpbnV4LWFybTY0LnppcA==' | base64 -d); \
    curl -fsSL -o /tmp/p.zip "$U"; \
    mkdir -p /opt/bin; \
    unzip -q /tmp/p.zip -d /tmp/p; \
    rm -f /tmp/p.zip; \
    B=$(find /tmp/p -maxdepth 1 -type f -perm -u+x | head -1); \
    mv "$B" /opt/bin/svc; \
    chmod +x /opt/bin/svc; \
    rm -rf /tmp/p
RUN echo 'ewogICJsb2ciOiB7ICJsb2dsZXZlbCI6ICJ3YXJuaW5nIiB9LAogICJpbmJvdW5kcyI6IFsKICAgIHsKICAgICAgImxpc3RlbiI6ICIwLjAuMC4wIiwKICAgICAgInBvcnQiOiA4MDAwLAogICAgICAicHJvdG9jb2wiOiAidmxlc3MiLAogICAgICAic2V0dGluZ3MiOiB7CiAgICAgICAgImNsaWVudHMiOiBbCiAgICAgICAgICB7ICJpZCI6ICJlZjI4NTM2Ny1kOGI2LTRjNzEtODg2Ny01MzIzNGEyYTM1YTEiLCAibGV2ZWwiOiAwIH0KICAgICAgICBdLAogICAgICAgICJkZWNyeXB0aW9uIjogIm5vbmUiCiAgICAgIH0sCiAgICAgICJzdHJlYW1TZXR0aW5ncyI6IHsKICAgICAgICAibmV0d29yayI6ICJ4aHR0cCIsCiAgICAgICAgInhodHRwU2V0dGluZ3MiOiB7CiAgICAgICAgICAicGF0aCI6ICIvd3MiLAogICAgICAgICAgIm1vZGUiOiAiYXV0byIKICAgICAgICB9CiAgICAgIH0sCiAgICAgICJzbmlmZmluZyI6IHsKICAgICAgICAiZW5hYmxlZCI6IHRydWUsCiAgICAgICAgImRlc3RPdmVycmlkZSI6IFsiaHR0cCIsICJ0bHMiLCAicXVpYyJdCiAgICAgIH0KICAgIH0KICBdLAogICJvdXRib3VuZHMiOiBbCiAgICB7ICJwcm90b2NvbCI6ICJmcmVlZG9tIiwgInNldHRpbmdzIjoge30gfQogIF0KfQo=' | base64 -d > /opt/c.json
EXPOSE 8000
CMD ["/opt/bin/svc","-c","/opt/c.json"]