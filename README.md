# Manual for creation of VM on AWS with PgSQL instance and admin interface
Author: David Salac

## Scope
This is mainly for teaching purposes. It describes how to create a VM on AWS that can be later use for hosting of pgAdmin (as a web app accessible online through browser) and PostgreSQL instance (accessed through pgAdmin).

## What VM to create?
- Standard Ubuntu based instance with open ports 80 and 443.
- Machine type: `t3a.small`

## Connect via SSH into the VM:
- Open a terminal on your local machine.
- Change the permissions of your key file to be read-only: chmod 400 /path/to/your-key-pair.pem.
- Connect to your instance using SSH: ssh -i /path/to/your-key-pair.pem ubuntu@your_instance_public_dns.

## How to install requirements
Update repo list:
```bash
sudo apt update
```

Remove existing installations:
```bash
 for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

Install Docker:
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# Installation itself
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Enable Docker
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Install Docker Compose:
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Add your user to the docker group (optional, for convenience):
```bash
sudo usermod -a -G docker $USER
```

**Important:** Reboot afterwards!

## How to activate firewall
**WARNING:** Be careful to enable ssh connection!
```bash
sudo ufw status
sudo ufw enable
sudo ufw allow 80/tcp
sudo ufw allow ssh
```
To check the status
```bash
sudo ufw status
```

## How to run the script
Create some folder and add (using `nano`) a `docker-compose.yml` file inside. Content is in this repo and logic is clear.

First, create a folder for PostgreSQL database data and link it in the file. Default one is called `dbdata`.

Second, modify all passwords and usernames in the `docker-compose.yml` to the desired value.

Then run:
```bash
sudo docker-compose up -d
```

## How to get inside once everything is ready?
Go to the DNS suggested on AWS (or use the IP directly) in your browser.

Log inside the PgAdmin instance using credentials in your `docker-compose.yml` file. 

Then, click to `Add New Server` and use credentials:
Host: postgres
Username: postgres
Password: _One you have set_
