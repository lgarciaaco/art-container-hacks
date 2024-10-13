# Development environment for ART

This Dockerfile builds a development workspace based on a local version of `doozer-dev`. It is tailored for development with tools like `doozer`, `vim` configurations, and custom utilities for working with OpenShift ART (Automated Release Team) tools. Below is a summary of the key features and installation steps involved in the Docker image.

## Base Image

The Dockerfile starts with the base image:

```dockerfile
FROM local/doozer-dev
LABEL name="lgarciaac-workspace"
```

This base provides a pre-configured environment for OpenShift development, focusing on the `doozer` toolset.

## Key Components

### 1. **Environment Setup**

The Dockerfile defines several ARG variables for tool paths and resource locations, such as:

- `ART_TOOLS`: Directory where ART tools are installed (`/tmp/art-tools`).
- `BREW_LATEST`: URL for the latest version of `brew-latest`.

### 2. **Custom Configuration Files**

The workspace is customized with the following configuration files:

- `configs/home`: Copied to the user's home directory.
- `configs/doozer`: Copied to `.config` for doozer-related configurations.
- `configs/system/brewkoji.conf`: Sets up the Brew/Koji configuration in `/etc/koji.conf.d/`.

### 3. **Vim Configurations and Plugins**

The image installs **amix/vimrc** configurations, enhances them with custom settings, and includes the following Vim plugins:

- [amix/vimrc](https://github.com/amix/vimrc)
- [fzf](https://github.com/junegunn/fzf) and [fzf.vim](https://github.com/junegunn/fzf.vim)

Commands to install:

```dockerfile
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && /bin/bash ~/.vim_runtime/install_awesome_vimrc.sh \
    && mv my_configs.vim  ~/.vim_runtime/my_configs.vim \
    && sudo dnf upgrade -y && dnf install -y fzf ripgrep \
    && git clone https://github.com/junegunn/fzf.vim.git .vim_runtime/my_plugins/fzf.vim \
    && git clone https://github.com/junegunn/fzf.git .vim_runtime/my_plugins/fzf
```

### 4. **Installing ART Tools**

The image clones and installs the ART tools (`doozer`, `elliott`, `pyartcd`) from the [OpenShift ART tools repository](https://github.com/openshift-eng/art-tools).

```dockerfile
RUN git clone https://github.com/openshift-eng/art-tools ${ART_TOOLS} \
    && cd ${ART_TOOLS} && git pull \
    && pip3 install --user -e ./artcommon -e ./doozer -e ./elliott -e ./pyartcd \
    && cd ~ && rm -rf ${ART_TOOLS}
```

### 5. **Table Utility**

The image installs the **table** utility from [joepvd/table](https://github.com/joepvd/table).

```dockerfile
RUN git clone https://github.com/joepvd/table.git && cd table \
    && make ngetopt.awk \
    && sudo cp ngetopt.awk libtable.awk /usr/share/awk/ \
    && cp table ~/.local/bin/ \
    && cd ~ && rm -rf table
```

### 6. **brew-latest Script**

The `brew-latest` utility is downloaded and installed to manage the latest Brew packages.

```dockerfile
RUN curl -o .local/bin/brew-latest ${BREW_LATEST} \
    && chmod +x .local/bin/brew-latest
```

## Final Setup

The workspace is now fully configured with Vim, ART tools, and additional utilities like `fzf`, `ripgrep`, and `table`, making it a complete environment for OpenShift development and release engineering tasks.

## Usage

Build the Docker image using:

```bash
docker build -t lgarciaac-workspace .
```

Run the container with:

```bash
docker run -it lgarciaac-workspace
```

