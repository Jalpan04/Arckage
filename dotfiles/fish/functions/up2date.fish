function up2date
    echo "👺 KAGE UPDATE SEQUENCE INITIATED..."
    cd ~/arckage/dotfiles
    git pull
    ./install_kage_lite.sh
end
