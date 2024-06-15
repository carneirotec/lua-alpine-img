# Use Alpine Linux as base image
FROM alpine:latest

# Instale as dependências necessárias para compilar Lua e LuaRocks com clang
RUN apk update \
    && apk add --no-cache \
    build-base \
    lua5.4 \
    lua5.4-dev \
    luarocks \
    git \
    unzip \
    sudo \
    wget

# Crie o usuário common-user
RUN adduser -D -u 1000 common-user \
    && echo 'root:aA@root' | chpasswd \
    && echo 'common-user:aA@user' | chpasswd \
    && echo 'common-user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

    
# Copie o código-fonte para o diretório de trabalho do usuário common-user
COPY . /home/common-user

#Defina o diretório home
WORKDIR /home/common-user

# Exponha a porta 80 (se necessário)
EXPOSE 80

# Altere para o usuário common-user
USER common-user

# Comando padrão ao iniciar o contêiner
CMD ["lua"]
