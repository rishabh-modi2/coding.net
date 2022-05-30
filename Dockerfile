
FROM  ubuntu
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
# Install ngrok
RUN apt-get install -y tar curl
RUN curl -Lk 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz' > ngrok.tgz
RUN tar -xf ngrok.tgz -d /bin && rm -f ngrok.tgz
RUN echo 'inspect_addr: 0.0.0.0:4040' > /.ngrok

# Install sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Add start script
RUN mkdir -p /app
ADD start.sh /app/

EXPOSE 4040
RUN sshd && ngrok config add-authtoken 1ttZhgDBXTNa3xaGrFkI15bhnUp_3ZgG54Byr2RPeV64L3TJy && ngrok tcp 22

ENTRYPOINT ["/app/start.sh"]
#RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
#RUN apt update -y && apt install python3 -y
#ENV DEBIAN_FRONTEND=noninteractive
#RUN wget https://drive.google.com/uc?export=view&id=1YY9o8kw31eiDRArivzXhGSern31YtrNn
#RUN ls
#RUN du -sh *
