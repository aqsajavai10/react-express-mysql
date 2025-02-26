# React-Express-MySQL Application

## **Project Overview**
This project is a **full-stack web application** using **React (Frontend), Express.js (Backend), and MySQL (Database)**. It is fully containerized using **Docker** and features a **CI/CD pipeline** with GitHub Actions.

---
## **Setup Instructions**
### **1. Clone the Repository**
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/react-express-mysql.git
cd react-express-mysql
```

### **2. Configure Environment Variables**
Create a `.env` file for the backend in `node-express-server/`:
```bash
DB_HOST=db
DB_USER=root
DB_PASSWORD=rootpassword
DB_NAME=testdb
```

### **3. Start the Application Using Docker**
Run the following command to build and start all services:
```bash
docker compose up --build
```

Once running:
- **Frontend**: [http://localhost:3000](http://localhost:3000)
- **Backend**: [http://localhost:8080](http://localhost:8080)
- **Database**: MySQL running on port `3306`

To stop the application:
```bash
docker compose down
```

---
## **Docker Optimizations**
✅ **Multi-stage builds** for smaller, optimized images.  
✅ **Non-root user** in containers for security.  
✅ **Bind mounts** for hot-reloading in development.  
✅ **Environment variables** for flexible configuration.  

---
## **Local Development Setup** (Without Docker)
### **Backend**
```bash
cd node-express-server
npm install
npm start
```
### **Frontend**
```bash
cd react-client
npm install
npm start
```
### **Database Setup (MySQL Locally)**
1. Install MySQL.
2. Create a database `testdb`.
3. Update `node-express-server/app/config/db.config.js` with your credentials.

---
## **CI/CD Pipeline Configuration**
### **GitHub Actions Workflow (`.github/workflows/ci.yml`)**
The pipeline performs:
✅ **Build & Test**: Builds backend and frontend Docker images.  
✅ **Lint & Security**: Runs ESLint and CodeQL security scans.  
✅ **Push to DockerHub**: Publishes Docker images on successful tests.  

#### **Trigger Events:**
- On every commit to `main`.
- On every pull request.

#### **Secrets Required:**
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

---
## **Best Practices**
✅ Use `.dockerignore` to reduce build context.  
✅ Run containers in **least-privileged mode** for security.  
✅ Use **GitHub Actions caching** to speed up builds.  
✅ Log analysis & health checks using `health_check.sh` & `log_analysis.sh`.  

---
## **Contributing**
Feel free to open issues or submit PRs to improve the project. 🚀

