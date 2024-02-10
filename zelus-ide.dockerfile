# Use an official Ubuntu as a parent image
FROM ubuntu:latest

### Environment variables 
# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
# Set timezone
ENV TZ=UTC
# Get python version from env file
ARG PY_VERSION

# Install essential packages and Neovim
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    cmake \
    curl \
    fzf \
    g++ \
    gettext \
    git \
    libtool \
    libtool-bin \
    ninja-build \
    nodejs \
    npm \
    pkg-config \
    python3-pip \
    ripgrep \
    sudo \
    software-properties-common \
    tree \
    tmux \
    tzdata \
    unzip \
    xclip \
    zip \
    zsh \
    && apt-get clean

# Set the locale to UTF-8
#RUN locale-gen en_US.UTF-8
#ENV LANG=en_US.UTF-8

# Install Neovim from source.
# Set the NVIM_CONFIG_DIR environment variable to your configuration directory
ENV NVIM_CONFIG_DIR=/home/devuser/.config/nvim
# Clone the Neovim repository
RUN git clone https://github.com/neovim/neovim.git /neovim

# Build and install Neovim
WORKDIR /neovim
RUN make CMAKE_BUILD_TYPE=Release
RUN make install

# Create a new user and set it as the default user
RUN useradd -ms /bin/zsh devuser
# Grant root privileges to devuser without password prompt
RUN echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Switch to the devuser context
USER devuser
# Set the working directory for the container
WORKDIR /home/devuser

# Install Oh My Zsh as devuser
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Zsh plugins as devuser
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /home/devuser/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/devuser/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-completions /home/devuser/.oh-my-zsh/custom/plugins/zsh-completions
# Set up Powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/devuser/.oh-my-zsh/custom/themes/powerlevel10k

### Python
# Install specific Python version
RUN sudo apt-get install -y python${PY_VERSION}

### Neovim
# Cooperate Neovim with Python 3.
RUN pip3 install pynvim

# Cooperate NodeJS with Neovim.
RUN sudo npm i -g neovim

# Create Neovim configuration directory
RUN mkdir -p /home/devuser/.config/nvim

# Copy your init.lua (or init.vim) and plugins.lua to the Neovim configuration directory
# Copy your Neovim configuration files
COPY ./simple-config/.config/nvim /home/devuser/.config/nvim
COPY ./simple-config/.fzf/ /home/devuser/
COPY ./simple-config/.config/.tmux.conf /home/devuser/.config/
# Install Packer.nvim as devuser
RUN git clone https://github.com/wbthomason/packer.nvim /home/devuser/.local/share/nvim/site/pack/packer/start/packer.nvim
# Run PackerInstall within Neovim to install plugins during the Docker image build
RUN nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

# Copy your .zshrc, .p10k.zsh, and init.vim (or init.lua) files into the user's home directory
COPY ./simple-config/.zshrc /home/devuser/
COPY ./simple-config/.p10k.zsh /home/devuser/

# Set up a default shell
CMD [ "zsh" ]
