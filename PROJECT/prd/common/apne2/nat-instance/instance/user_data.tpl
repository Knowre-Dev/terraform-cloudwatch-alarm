#!/bin/bash
exec > /tmp/user_data.log 2>&1
set -x

# mkfs.ext4 /dev/xvdb
# echo "/dev/xvdb /data ext4 defaults,nofail 0 2" >> /etc/fstab
# mount -a

yum update -y

echo "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEArqZ963nH7fJiHoyAuFCuUFejhE9dLV09pbpIYOhl40VpXBXs
YIwuYjTliv6WCr0pWnVwqYJ21GMzTRx8VTGn7n6APkVhRWW0roGNLZJPr8NPg3GZ
ftr2ag75aTKFf+JpCVqbg3vT6WyuJb7nqQ+7o0qfPHD3w34D8ONWgkZnXTSUe5h4
J6ExWGhxolixdjcViKX7PnKahR3EiDf6At8Lhx3G9hM8GI2XlDC8tgOIvhrEpCMv
pJWhHpiqYpszQrShjouDZ026x1Qw+iAITKAY5IftZb1CEBOxIYiN5/7TodjNkH78
kxBXhe4Mx1NakaXU9XCJ1XgxCHupBt0VWfrIsQIDAQABAoIBAEuIxjzpVoaapcUA
j0sn2bv1q0q16F6OTPM4NcVzvV0l0AN7l9fJyOXAauZKZSoP1arB0A//1NTWcoGP
KFbQOwjyvRQxfXg+HH68mQp0lPI3TlRS9Uff+2KzRzswFnzQtwzMmyWqkGQMFOVO
Q3Li0ww0YdoKIZ3zClFMgUWmnV25fxpf+3JEZzJ8HiRtyXqwpGIJhFgaIG54jeVB
5CGcDPVb+SfpjSc7SZpyLvD5KCNa2eNUt9Re7ORwRXYZeLq6r1JCRcTnlyQT8+RX
BEpk11AUQ7pWnZnDDYm+Kd0BceEut78g20Ir4X8f0ua9CfWxxqh3kPWpHb5E0kXW
NSWsIeECgYEA89+LyAje6JOW2IFXv/DzGMVLDEr/x4LthMmMWPApLVPz0zV8mC5y
RdFUGa6rO+32ib+cNnkUe38KCoLjHzHDx5TuX2LZv2+paRTz54HqsgimJJakzKKz
bDoK7aM51DSRexsEkpbMrIrpEorneI2ButxQnXPdTLM2zIjoVdM6L7cCgYEAt1XA
6XhtzgRyEjk+9Q6H/OInpZjtODuM1zYcMK9JIwvZQa42D8jLCU9Kqzy9l3vv8TV3
MXJl5TarE2yy0Hg8H3CaigyRyWGJwrCwWW1YP95zapnShCn0woM9SVEq4zk/3xY9
jblvo13aQaMYtfz0Os85RaQ0nsHF53NnB2Kc+tcCgYEA3b1j9nUCYUxY+vDYHaDz
GJHDRCEpYnnMh1FO+Esd1aYg6+kVKbYJlyvXISbtcSdUZDlBy1HaatO/CIGsC2AP
WHg1KavSuzrHOdGgV96LzGcK0ffbTmmdZIl+CEbCvQ0zPlD5nmPZJAWGGKMOBlH8
JDBQaGnCTQwihmTxg5/0pw8CgYEAl8kcnW9CYcXWd3YDxLnSJrFKp9ST2fGbqnY3
IquM/sIJjlJgmfLg/oUySdFRGoDW57ofQ8X1zK7VNpDQ/r388P62Q8MiVDs35gOJ
DZD09nQC1GgkHZ3q8bvcWr4jpto4Ikf0kEjNv9CtKZiRleKmhaYZQaowkpvVcMlf
rIKdeyMCgYEA4YRRa6CmTdT3DihcxPUIQjwDe3r+KNKFxOACWpdh2Q+OuT886Trk
8Zb8VkH6zwPycjYSJWv4RtR9oap8XApzHmXifuigzo2ObRCBST/IHkawoEgjoqGF
XqKWf/rvwh3mxj2ZCLCnGJ9XToWrB38L1jVKSwjTILuJwwz3lggsiYI=
-----END RSA PRIVATE KEY-----" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

mkdir ~/.aws
echo "[default]
region = ${aws_region}" > ~/.aws/config

mkdir /tmp/ansible-repo
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
git clone -b main git@github.com:pascal-h-kim/ansible-repo.git /tmp/ansible-repo
cd /tmp/ansible-repo
/usr/local/bin/ansible-playbook /tmp/ansible-repo/nat-provision.yml -c local