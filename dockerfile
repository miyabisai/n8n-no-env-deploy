
FROM mcr.microsoft.com/azure-cli:latest

WORKDIR /home

COPY fetch_secret.sh .

RUN chmod +x fetch_secret.sh

CMD ["/bin/sh", "-c", "az login --identity && sh fetch_secret.sh"]