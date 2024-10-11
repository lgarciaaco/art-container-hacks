FROM local/doozer-dev
LABEL name="lgarciaac-workspace"

ARG ART_TOOLS=/tmp/art-tools
ARG BREW_LATEST=https://gist.githubusercontent.com/joepvd/f8079df5098608acf9021cae824a20ea/raw/31495635c9155814d8c457db313c19637524f942/brew-latest

WORKDIR /home/dev

COPY configs/home .
COPY configs/doozer .config
COPY configs/system/brewkoji.conf /etc/koji.conf.d/brewkoji.conf

# Install amix/vimrc configs and own vim configs
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && /bin/bash ~/.vim_runtime/install_awesome_vimrc.sh \
    && mv my_configs.vim  ~/.vim_runtime/my_configs.vim

# Install doozer
RUN git clone https://github.com/openshift-eng/art-tools ${ART_TOOLS} \
	&& cd ${ART_TOOLS} && git pull \
	&& pip3 install --user -e ./artcommon -e ./doozer -e ./elliott -e ./pyartcd \
	&& cd ~ && rm -rf ${ART_TOOLS}

# Install table
RUN git clone https://github.com/joepvd/table.git && cd table\
    && make ngetopt.awk \
    && sudo cp ngetopt.awk libtable.awk /usr/share/awk/ \
    && cp table ~/.local/bin/ \
    && cd ~ && rm -rf table

# Install brew-latest
RUN curl -o .local/bin/brew-latest ${BREW_LATEST} \
    && chmod +x .local/bin/brew-latest