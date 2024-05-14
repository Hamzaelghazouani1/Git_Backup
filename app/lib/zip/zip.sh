zipFolder() {
    tar -czvf $2.tar.gz -C $1 . && mv $2.tar.gz /home/$USERNAME/Downloads/test

}

dezipeFolder(){
    mkdir -p $1/dezipe && tar -xzvf "$1/$2" -C $1/dezipe
}
