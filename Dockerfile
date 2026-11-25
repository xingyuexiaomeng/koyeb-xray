FROM alpine:3.20
RUN apk add --no-cache ca-certificates curl unzip \
 && curl -fsSL -o /tmp/x.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && unzip -q /tmp/x.zip -d /usr/local/bin \
 && chmod +x /usr/local/bin/xray \
 && rm -f /tmp/x.zip
COPY config.json /etc/xray/config.json
EXPOSE 8000
CMD ["/usr/local/bin/xray","-c","/etc/xray/config.json"]