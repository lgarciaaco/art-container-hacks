FROM local/doozer-dev
LABEL name="lgarciaac-workspace"

ENV OTEL_EXPORTER_OTLP_ENDPOINT="http://host.docker.internal:4317"
ARG ART_TOOLS=/tmp/art-tools
ARG BREW_LATEST=https://gist.githubusercontent.com/joepvd/f8079df5098608acf9021cae824a20ea/raw/31495635c9155814d8c457db313c19637524f942/brew-latest

WORKDIR /home/dev

COPY configs/home .
COPY configs/doozer .config
COPY configs/system/brewkoji.conf /etc/koji.conf.d/brewkoji.conf

RUN sudo chown -R dev:dev /home/dev

# Install amix/vimrc configs and own vim configs.
# Also add fzf search to own installed plugins
# Remove unused plugins from amix/vimrc like ctrlp which is replaced by fzf
RUN sudo dnf upgrade -y && sudo dnf install -y fzf ripgrep \
    && git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && rm -rf ~/.vim_runtime/sources_non_forked/{ctrlp.vim,ack.vim} \
    && /bin/bash ~/.vim_runtime/install_awesome_vimrc.sh \
    && mv my_configs.vim  ~/.vim_runtime/my_configs.vim \
    && git clone https://github.com/junegunn/fzf.vim.git .vim_runtime/my_plugins/fzf.vim \
    && git clone https://github.com/junegunn/fzf.git .vim_runtime/my_plugins/fzf \
    && git clone https://github.com/vimwiki/vimwiki.git .vim_runtime/my_plugins/vimwiki \
    && git clone https://github.com/michal-h21/vim-zettel.git .vim_runtime/my_plugins/vim-zettel

# Install uv, doozer
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && source ~/.bashrc \
    && uv venv --python 3.11 --system-site-packages /home/dev/art-venv \
    && source /home/dev/art-venv/bin/activate \
    && git clone https://github.com/openshift-eng/art-tools ${ART_TOOLS} \
	&& cd ${ART_TOOLS} && git pull \
	&& bash ./install.sh \
	&& cd ~ && rm -rf ${ART_TOOLS}

# Install otel-cli, a command-line tool for sending OpenTelemetry traces
# https://blog.howardjohn.info/posts/shell-tracing/
RUN go install github.com/equinix-labs/otel-cli@latest \
    && go install github.com/CtrlSpice/otel-desktop-viewer@latest

# Install table
RUN git clone https://github.com/joepvd/table.git && cd table\
    && make ngetopt.awk \
    && sudo cp ngetopt.awk libtable.awk /usr/share/awk/ \
    && cp table ~/.local/bin/ \
    && cd ~ && rm -rf table

# Install brew-latest
RUN curl -o .local/bin/brew-latest ${BREW_LATEST} \
    && chmod +x .local/bin/brew-latest
