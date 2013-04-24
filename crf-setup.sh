sudo apt-get update
sudo apt-get install gcc g++ make unzip
wget https://crfpp.googlecode.com/files/CRF%2B%2B-0.58.tar.gz
tar xf CRF++-0.58.tar.gz
cd CRF++-0.58
./configure
./make
./make install
cd -
wget http://opensource.osu.edu/~jfriedly/G2P.zip
unzip G2P.zip
cd G2P
echo "Change the template, open tmux, export LD_LIBRARY_PATH=/usr/local/lib and go!"
