#!/bin/bash
exec > /tmp/user_data.log 2>&1
set -x

mkdir -p /data
# mkfs.ext4 /dev/xvdb
# echo "/dev/xvdb /data ext4 defaults,nofail 0 2" >> /etc/fstab
# mount -a

echo "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAkye4IhYOxCKL0z38e01dM33iffbyA7ALMSgPE6c8PbMG6Wab
Wi1mTl2R3y8TBLXH/uTTRFR7m/8O15OzcQDib3/JZRyGmxpCn1lo+dxmYxNTrMBG
6paIT8Kw+AKIRnuzT11uumaFclKkFoJyYFTZ7vD9XzAd384A2Jje1FBdgyNhRzoQ
KEfrmkJif3kX8N1TaXf9bN5Jvyqidf5mZkF+VJz30tqn78OBDRx7DS04KPDLhWgQ
RnZk6fPS/rGFpdliQivYxB6/lut0bY2zSWY3OB7Bnd/jlwQyYdHLLHsPxdFt4Ink
QDyxf6Fq+r+k5svbSk+wIKMPd/Z9t5hvlboGZQIDAQABAoIBAHRpVoQ4mOPWRHEP
N14/vHxQmM13fssmCCSSASNWCBTzPIOFtV4oTieuZAiAD/aI67ccRHlosASfSJmH
8ctynK8CE0tWvrGSm6O9sor/LUwxbN9bmH5aKWmXpjH8ptvDXf1p93+kPOtMrxxT
g7HrTiB1KquTv/5d1FOE07p3/RIQwFIAmQH/QcXYahIdUcIs9X5Zk8E1obbLZExf
+9lSnAfvXhdHhdFIJ21I5vkj2McXnzFZGAILcNiVRa8rm4+a4LuynGPTrQNg34Qr
KdHh0jJ4Gv9w96eOtOq3gIgc47MBMH97iFHoDAe9DXRe6PEBJhiAye78MCzfIIXA
2rwI3EECgYEA7vW6x6QIn704AIjtn4/srtl7W5usqS5SJDHlfkLJsZ6EYhmQuAgt
Pv4ILoUMZf2crtq/CL5KuGD49fbJFvWM9t9jqizSMEtYP+1HqMeFzNHhWyXJgjEz
qq3YsAiT7r2VkkMaj3kaQLWxLs0PJ4MW+Cd81DnhBJm7PoEG8B3xg5ECgYEAnaYS
eVVpNF0s6HxaKXrqCaXAloaFyZEw2EDn9RL1alkFhRhUFri7ewdt1GyzG8b7D/d+
8qEp235PC+sCsWHmIuVsqNa6yrioCwiDjmA47h5amuLSrszM5gIEjjer9JZsUeG5
dVShU9Hgw5XmWER+jR8RCx4ifx5Jt7h8HWdhw5UCgYBvpWfrNvzAhYvQ1CkR0BDp
cLtuBcIaGYZPWvC6mUHbNxDrNL6k/U0GjXINKiSs0l2OZK20zBPlKYmogfFaRMfj
4GOUcvSRk+Jbm+VLOk2NcNI13+XSamKVcDw5owhbF0D24VtbhV16tmleUHiwIVNu
BiUQkypLF/igL3CqZ5MbwQKBgCsqoxpYGcN90+Mg0atT/auAmFhfI1kLCX3dX+ZK
N6rUD1/fRn8mPCe25ArrbKupc2tu0HLtUEHKtyhDRGx/qv1ZJsSgb2s83r6OqT8d
99iztQl+HERCzcQZP1gVxF7npWdSUG7hKn+CE3JapET9FE3d+NO7f6ShDXxh5pJC
kZF1AoGBAL39Eioe7GOLSSJk49EIAG4ofBQH9VignZfg+3FTwJh21JC3IqsyrUSD
XUNASyvPjm5X5NG7Uxrq4fFqc0WSbbMcltWprzN37Xr84DjHhpFWbhStw5gc77zB
AlI/39ZnzvXU6LT2oMk3UjaCNWBGv4wPF4YvsoIGQcFSUwi7ZOep
-----END RSA PRIVATE KEY-----" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

yum update -y

usermod -a -G docker ec2-user

# install git
yum install git make -y

# Create a folder
sudo -u ec2-user mkdir /home/ec2-user/actions-runner
cd /home/ec2-user/actions-runner/
sudo -u ec2-user curl -o actions-runner-linux-x64-2.294.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.294.0/actions-runner-linux-x64-2.294.0.tar.gz
yum install perl-Digest-SHA -y
echo "a19a09f4eda5716e5d48ba86b6b78fc014880c5619b9dba4a059eaf65e131780  actions-runner-linux-x64-2.294.0.tar.gz" | shasum -a 256 -c
sudo -u ec2-user tar xzf ./actions-runner-linux-x64-2.294.0.tar.gz
sudo -u ec2-user ./config.sh --url ${github_repo_url} --token ${github_repo_pat_token} --name ${runner_name} --work _work --labels ${labels} --runasservice --unattended
./svc.sh install
sleep 5
./svc.sh start
sudo chown ec2-user -R /home/ec2-user/actions-runner
# runner 삭제 : ./config.sh remove --token <token> (current token: AXKWCVG5RB7FODCXOTLZO5TCZ3KOS)