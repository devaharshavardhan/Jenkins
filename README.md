# Running Jenkins Pipeline using GitHub SCM

## Prerequisites
- AWS EC2 instance (Ubuntu) with Jenkins installed
- Open port 8080 in the security group inbound rules
- GitHub repository with a `Jenkinsfile`
- Installed Jenkins plugins:
  - Dockerpipeline
  - Pipeline
  - GitHub Integration
  - Git Plugin

---

## Install Java (if not installed)
```sh
sudo apt update
sudo apt install openjdk-17-jre
```
### Verify Java Installation
```sh
java -version
```

---

## Install Jenkins (if not installed)
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

## Configure Jenkins Pipeline with GitHub SCM

### Step 1: Install Required Plugins
1. Go to **Jenkins Dashboard** → **Manage Jenkins** → **Manage Plugins**.
2. Install:
   -**Dockerpipeline** plugin
   - **Pipeline** plugin
   - **GitHub Integration** plugin
   - **Git** plugin

### Step 2: Create a Jenkins Pipeline Job
1. Go to **Jenkins Dashboard** → Click on **New Item**.
2. Enter a **Calculator Pipeline** and select **Pipeline**.
3. Click **OK**.

### Step 3: Configure GitHub Repository
1. In the **Pipeline** job configuration:
   - Scroll to **Pipeline** → **Definition** → Select **Pipeline script from SCM**.
   - Under **SCM**, select **Git**.
   - In **Repository URL**, enter your GitHub repo URL:  
     ```
     https://github.com/devaharshavardhan/Jenkins
     ```
   - Choose the appropriate **credentials** (if private repo).
   - In **Branches to build**, enter your branch name (`main`, `develop`, etc.).
   - (Optional) In **Script Path**, enter `Jenkinsfile` (if your pipeline script is stored as a `Jenkinsfile`).

### Step 4: Add Jenkinsfile to GitHub Repository
Ensure your GitHub repo contains a **Jenkinsfile** in the root directory.

Example **Jenkinsfile**:
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

### Step 5: Trigger Pipeline Automatically (Optional)
To run the pipeline automatically on GitHub commits:
1. Go to **GitHub Repository** → **Settings** → **Webhooks** → **Add Webhook**.
2. In **Payload URL**, enter:  
   ```
   http://<JENKINS_URL>/github-webhook/
   ```
3. Select **Just the push event**.
4. Click **Add Webhook**.

### Step 6: Run the Pipeline
1. Click **Build Now** in Jenkins.
2. Jenkins will fetch the code from GitHub and execute the pipeline.

---

## Deploying the Application using Docker

### Clone the Repository
```sh
git clone https://github.com/devaharshavardhan/Jenkins
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

## Access the Application
```
http://<EC2-PUBLIC-IP>:8080
```

Now, your application is successfully deployed using Jenkins and Docker!

