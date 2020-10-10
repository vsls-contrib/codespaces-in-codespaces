FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
	&& rm -rf /var/lib/apt/lists/*


# RUN apt-get update && apt-get install -y --no-install-recommends libc6 libgcc1 libgssapi-krb5-2 libicu63 libssl1.1 libstdc++6 zlib1g && rm -rf /var/lib/apt/lists/*

# procps is very common in build systems, and is a reasonably small package
RUN apt-get update && apt-get install -y --no-install-recommends \
		bzr \
		git \
		mercurial \
		openssh-client \
		subversion \
		\
		procps \
	&& rm -rf /var/lib/apt/lists/*

# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libcurl4 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu60 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        libunwind8 \
        libuuid1 \
        libsecret-1-dev \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Sdk/3.1.200/dotnet-sdk-3.1.200-linux-x64.tar.gz

RUN curl -SL $DOTNET_SDK_DOWNLOAD_URL --output dotnet.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Enable detection of running in a container
ENV DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps perfomance
    NUGET_XMLDOC_MODE=skip

# Trigger the population of the local package cache
RUN mkdir warmup \
    && cd warmup \
    && dotnet new \
    && cd .. \
    && rm -rf warmup \
    && rm -rf /tmp/NuGetScratch

# Install NodeJS and Yarn
RUN NODE_VERSION=12.18.1 curl -sL https://deb.nodesource.com/setup_12.x -o ~/nodesource_setup.sh \
    && bash ~/nodesource_setup.sh \
    && apt-get install nodejs -y \
    && npm i -g yarn \
    && mkdir ~/.nuget \
    && wget -c https://github.com/microsoft/artifacts-credprovider/releases/download/v0.1.22/Microsoft.NuGet.CredentialProvider.tar.gz -O - | tar -xz -C ~/.nuget \
    && wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O - | sh -C

# Workaround for https://github.com/Microsoft/DockerTools/issues/87. This instructs NuGet to use 4.5 behavior in which
# all errors when attempting to restore a project are ignored and treated as warnings instead. This allows the VS
# tooling to use -nowarn:MSB3202 to ignore issues with the .dcproj project
ENV RestoreUseSkipNonexistentTargets false