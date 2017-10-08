#/bin/bash

echo "installing prerequisites..."
echo "...prerequisites to azure cli"
sudo apt-get update
sudo apt-get install -y libssl-dev libffi-dev python-dev build-essential

echo "...jq"
sudo apt-get install jq

echo "...strongswann"
sudo apt-get install strongswan

echo "... Azure command line"
curl -L https://aka.ms/InstallAzureCli | bash

