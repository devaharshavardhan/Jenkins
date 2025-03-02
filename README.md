# Calculator App - Jenkins & Docker Setup

## Prerequisites
- AWS EC2 instance (Ubuntu)
- Open port 8080 in the security group inbound rules

---

## Install Java
```sh
sudo apt update
sudo apt install openjdk-17-jre
```
### Verify Java Installation
```sh
java -version
```

---

## Install Jenkins
```sh
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

### Start & Enable Jenkins
```sh
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

### Retrieve Jenkins Admin Password
```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Access Jenkins
```
http://<EC2-PUBLIC-IP>:8080
```

---

## Install Docker
```sh
sudo apt update
sudo apt install docker.io
```

### Grant Permissions to Jenkins & Ubuntu Users
```sh
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
```

---

## Install Docker Pipeline Plugin in Jenkins
1. Log in to Jenkins.
2. Navigate to **Manage Jenkins** > **Manage Plugins**.
3. Go to the **Available** tab and search for "Docker Pipeline".
4. Select the plugin and click **Install**.
5. Restart Jenkins after installation.

---

## Deploying the Calculator App

### Clone the Repository
```sh
git clone https://github.com/devaharshavardhan/Jenkins.git
cd Jenkins
```

### Build the Docker Image
```sh
docker build -t calculator-app:1.0 .
```

### Run the Container
```sh
docker run -d --name calculator-container calculator-app:1.0
```

### Check Running Containers
```sh
docker ps
```

### Stop & Remove the Container (if needed)
```sh
docker stop calculator-container
docker rm calculator-container
```

---

## Jenkins Pipeline Configuration

### I have created a pipeline through a pipeline script and built it successfully

### Add the Following Pipeline Script in Jenkins
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t calculator-app:1.0 .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run -d --name calculator-container calculator-app:1.0'
            }
        }
    }
}
```

---

## Access the Application
```
http://<EC2-PUBLIC-IP>:8080
```

Now, your Calculator app is successfully deployed using Jenkins and Docker!

