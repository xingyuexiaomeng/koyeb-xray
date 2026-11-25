FROM alpine:3.20
RUN apk add --no-cache ca-certificates curl unzip
ENV B_A=aHR0cHM6Ly9naXRodWIuY29tL1hUTFMvWHJheS1jb3JlL3JlbGVhc2VzL2Rvd25sb2FkL3YyNi4xMS45L1hyYXktbGludXgtYXJtNjQtdjhhLnppcA==
ENV B_B=aHR0cHM6Ly9naXRodWIuY29tL1hUTFMvWHJheS1jb3JlL3JlbGVhc2VzL2Rvd25sb2FkL3YyNi4xMS45L1hyYXktbGludXgtNjQuemlw
RUN set -eux; \
    A=$(echo "$B_A" | base64 -d); \
    Bt=$(echo "$B_B" | base64 -d); \
    curl -fsSL -o /tmp/p.zip "$A" || curl -fsSL -o /tmp/p.zip "$Bt"; \
    mkdir -p /opt/svc; \
    unzip -q -o /tmp/p.zip -d /opt/svc; \
    rm -f /tmp/p.zip; \
    F=$(find /opt/svc -maxdepth 1 -type f -perm -u+x | head -1); \
    mv "$F" /opt/svc/app; \
    chmod +x /opt/svc/app; \
    find /opt/svc -maxdepth 1 -type f ! -name app -delete
RUN echo 'eyJsb2ciOnsibG9nbGV2ZWwiOiJ3YXJuaW5nIn0sImluYm91bmRzIjpbeyJsaXN0ZW4iOiIwLjAuMC4wIiwicG9ydCI6ODAwMCwicHJvdG9jb2wiOiJ2bGVzcyIsInNldHRpbmdzIjp7ImNsaWVudHMiOlt7ImlkIjoiZWYyODUzNjctZDhiNi00YzcxLTg4NjctNTMyMzRhMmEzNWExIiwibGV2ZWwiOjB9XSwiZGVjcnlwdGlvbiI6Im5vbmUifSwic3RyZWFtU2V0dGluZ3MiOnsibmV0d29yayI6InhodHRwIiwieGh0dHBTZXR0aW5ncyI6eyJwYXRoIjoiL3dzIiwibW9kZSI6ImF1dG8ifX0sInNuaWZmaW5nIjp7ImVuYWJsZWQiOnRydWUsImRlc3RPdmVycmlkZSI6WyJodHRwIiwidGxzIiwicXVpYyJdfX1dLCJvdXRib3VuZHMiOlt7InByb3RvY29sIjoiZnJlZWRvbSIsInNldHRpbmdzIjp7fX1dfQ==' | base64 -d > /opt/svc/c.json
EXPOSE 8000
CMD ["/opt/svc/app","-c","/opt/svc/c.json"]