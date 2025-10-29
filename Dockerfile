FROM ubuntu:25.04

RUN <<EOT
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
add-apt-repository ppa:git-core/ppa
apt-get update
apt-get install -y --no-install-recommends \
    build-essential \
    clang \
    docker-ce-cli \
    docker-compose-plugin \
    git \
    less \
    libbsd-dev \
    openssh-client \
    python3 \
    python3-pip \
    tzdata \
    valgrind \
    wget \
    zsh \
    man-db \
    manpages \
    manpages-dev \
    language-pack-ja
pip3 install \
    norminette==3.3.55 \
    c-formatter-42
update-locale LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8
ln -sfn /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
update-alternatives --set cc /usr/bin/clang
update-alternatives --set c++ /usr/bin/clang++
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/local/bin
yes | unminimize
apt-get clean
rm -rf /var/lib/apt/lists/*
EOT

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
ENV STARSHIP_CONFIG="/etc/starship.toml"

CMD ["/bin/zsh"]

COPY <<EOT /root/.zshrc
alias ls='ls --color=auto'
alias la='ls -la'
alias ll='ls -l'
alias cc='cc -Wall -Wextra -Werror'
alias norm='norminette -R CheckForbiddenSourceHeader'
eval "$(starship init zsh)"
EOT

COPY <<EOT /etc/starship.toml
add_newline = false
format = """\$directory\$character"""
right_format = """\$all"""

[character]
success_symbol = "[>](bold green)"
error_symbol = "[x](bold red)"
vimcmd_symbol = "[<](bold green)"

[username]
disabled = true

[git_commit]
tag_symbol = " tag "

[git_status]
ahead = ">"
behind = "<"
diverged = "<>"
renamed = "r"
deleted = "x"

[aws]
symbol = "aws "

[azure]
symbol = "az "

[buf]
symbol = "buf "

[bun]
symbol = "bun "

[c]
symbol = "C "

[cobol]
symbol = "cobol "

[conda]
symbol = "conda "

[crystal]
symbol = "cr "

[cmake]
symbol = "cmake "

[daml]
symbol = "daml "

[dart]
symbol = "dart "

[deno]
symbol = "deno "

[dotnet]
symbol = ".NET "

[directory]
read_only = " ro"

[docker_context]
symbol = "docker "

[elixir]
symbol = "exs "

[elm]
symbol = "elm "

[fennel]
symbol = "fnl "

[fossil_branch]
symbol = "fossil "

[gcloud]
symbol = "gcp "

[git_branch]
symbol = "git "

[gleam]
symbol = "gleam "

[golang]
symbol = "go "

[gradle]
symbol = "gradle "

[guix_shell]
symbol = "guix "

[hg_branch]
symbol = "hg "

[java]
symbol = "java "

[julia]
symbol = "jl "

[kotlin]
symbol = "kt "

[lua]
symbol = "lua "

[nodejs]
symbol = "nodejs "

[memory_usage]
symbol = "memory "

[meson]
symbol = "meson "

[nats]
symbol = "nats "

[nim]
symbol = "nim "

[nix_shell]
symbol = "nix "

[ocaml]
symbol = "ml "

[opa]
symbol = "opa "

[os.symbols]
AIX = "aix "
Alpaquita = "alq "
AlmaLinux = "alma "
Alpine = "alp "
Amazon = "amz "
Android = "andr "
Arch = "rch "
Artix = "atx "
CachyOS = "cach "
CentOS = "cent "
Debian = "deb "
DragonFly = "dfbsd "
Emscripten = "emsc "
EndeavourOS = "ndev "
Fedora = "fed "
FreeBSD = "fbsd "
Garuda = "garu "
Gentoo = "gent "
HardenedBSD = "hbsd "
Illumos = "lum "
Kali = "kali "
Linux = "lnx "
Mabox = "mbox "
Macos = "mac "
Manjaro = "mjo "
Mariner = "mrn "
MidnightBSD = "mid "
Mint = "mint "
NetBSD = "nbsd "
NixOS = "nix "
Nobara = "nbra "
OpenBSD = "obsd "
OpenCloudOS = "ocos "
openEuler = "oeul "
openSUSE = "osuse "
OracleLinux = "orac "
Pop = "pop "
Raspbian = "rasp "
Redhat = "rhl "
RedHatEnterprise = "rhel "
RockyLinux = "rky "
Redox = "redox "
Solus = "sol "
SUSE = "suse "
Ubuntu = "ubnt "
Ultramarine = "ultm "
Unknown = "unk "
Uos = "uos "
Void = "void "
Windows = "win "

[package]
symbol = "pkg "

[perl]
symbol = "pl "

[php]
symbol = "php "

[pijul_channel]
symbol = "pijul "

[pulumi]
symbol = "pulumi "

[purescript]
symbol = "purs "

[python]
symbol = "py "

[quarto]
symbol = "quarto "

[raku]
symbol = "raku "

[ruby]
symbol = "rb "

[rust]
symbol = "rs "

[scala]
symbol = "scala "

[spack]
symbol = "spack "

[solidity]
symbol = "solidity "

[status]
symbol = "[x](bold red) "

[sudo]
symbol = "sudo "

[swift]
symbol = "swift "

[typst]
symbol = "typst "

[terraform]
symbol = "terraform "

[zig]
symbol = "zig "
EOT
