set -e

. $DOT_DIR/install_scripts/util.sh

ROOT_DIR=${HOME}
mkdir -p $ROOT_DIR

# Deps
sudo apt-get install libtool m4 automake

cd ${ROOT_DIR}
INSTALL_DIR=${ROOT_DIR}/.local/tmux


# Clean up
rm -rf libevent-2.1.12-stable.tar.gz
rm -rf ncurses-6.2.tar.gz
rm -rf tmux-3.2-rc4.tar.gz

wget "https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz"
wget "https://invisible-mirror.net/archives/ncurses/ncurses-6.2.tar.gz"
wget "https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"


tar xvf "libevent-2.1.12-stable.tar.gz"
tar xvf "ncurses-6.2.tar.gz"
tar xvf "tmux-3.3a.tar.gz"

# Install libevent
cd libevent-2.1.12-stable
./autogen.sh
./configure --prefix=${INSTALL_DIR}
make
make install
cd ..

# Install ncurses
cd ncurses-6.2
./configure --prefix=${INSTALL_DIR}
make
make install
cd ..

# Install tmux
cd tmux-3.3a
./configure --prefix=${INSTALL_DIR} \
    CFLAGS="-I${ROOT_DIR}/.local/include -I${INSTALL_DIR}/include/ncurses" \
    LDFLAGS="-L${ROOT_DIR}/.local/include -L${INSTALL_DIR}/include/ncurses -L${INSTALL_DIR}/lib"
make
make install
cd ..

# Clean up
rm -rf libevent-2.1.12-stable*
rm -rf ncurses-6.2*
rm -rf tmux-3.3*

echo "[SUCCESS] ${INSTALL_DIR}/bin/tmux is now available"
ln -sf ${INSTALL_DIR}/bin/tmux $MY_BIN_LOC/tmux
