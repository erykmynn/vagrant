PORT=`vagrant ssh-config | grep Port | grep -o '[0-9]\+'`
chmod 600 ~/.vagrant.d/insecure_private_key
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.vagrant.d/insecure_private_key vagrant@localhost -p $PORT