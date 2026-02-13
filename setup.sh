# create durable directory
[ -d durable ] || mkdir ./durable

# modify permission
sudo chown -R 51773:51773 durable
sudo chmod -R 775 durable