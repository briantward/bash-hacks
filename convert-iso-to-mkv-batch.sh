# setup required for running from containerized makemkv
ln -s /usr/bin/ccextractor /opt/makemkv/bin/mmccextr
./makemkv-set-key $MY_MKV_KEY /config/settings.conf
ln -s /config/.MakeMKV /root/.MakeMKV

# usage:
# ./convert-mk.sh /storage/iso /storage/mkv

readdir=$1
storbasedir=$2

for iso in $(ls $readdir)
do
  ftype=${iso:${#iso}-3:${#iso}}
  fname=$(basename $iso)
  dirname=${fname:0:${#fname}-4}
  stordir=$storbasedir/$dirname

  if [[ "$ftype" == "iso" ]] && [ ! -d $stordir ]; then
    mkdir ${stordir}
    /opt/makemkv/bin/makemkvcon mkv iso:$iso all $stordir > convert.log 2>&1
    for title in $(ls $stordir/title*)
    do
      mv $title $stordir/$dirname${title:${#title}-8:${#title}}
    done;
    for main in $(ls -S $stordir | head -1)
    do
      mv $stordir/$main $stordir/${main:0:${#main}-4}_main-feature.mkv
    done;
  fi
done;
