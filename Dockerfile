FROM ubuntu

RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
RUN apt update -y && apt install python3 -y
ENV DEBIAN_FRONTEND=noninteractive
RUN wget https://drive.google.com/uc?export=view&id=1YY9o8kw31eiDRArivzXhGSern31YtrNn
