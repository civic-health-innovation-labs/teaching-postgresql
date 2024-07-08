# Manual for creation of VM on AWS with PgSQL instance and admin interface
Author: David Salac

## Scope
This is mainly for teaching purposes. It describes how to create a VM on AWS that can be later use for hosting of pgAdmin (as a web app accessible online through browser) and PostgreSQL instance (accessed through pgAdmin).

## What VM to create?
- Standard Ubuntu based instance with open ports 80 and 443.

## Connect via SSH into the VM:
- Open a terminal on your local machine.
- Change the permissions of your key file to be read-only: chmod 400 /path/to/your-key-pair.pem.
- Connect to your instance using SSH: ssh -i /path/to/your-key-pair.pem ubuntu@your_instance_public_dns.

## How to install requirements
Update repo list:
```bash
sudo apt update
```

Install Docker:
```bash
sudo apt install -y docker.io
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
sudo usermod -aG docker $USER
```

## How to activate firewall
```bash
sudo ufw status
sudo ufw enable
sudo ufw allow 80/tcp
```
To check the status
```bash
sudo ufw status
```

## How to run the script
Create some folder and add (using `nano`) a `docker-compose.yml` file inside. Content is in this repo and logic is clear.

Then run:
```bash
sudo docker-compose up
```
