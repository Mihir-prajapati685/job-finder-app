# 🧿 Job Finder App

A complete full-stack job portal application where users can register, view job listings, and apply for jobs. Built using **Flutter** for the frontend and **Spring Boot** for the backend.

---

## 🛠 Technologies Used

### 📱 Frontend
- Flutter
- Dart
- HTTP (for API calls)

### 💻 Backend
- Spring Boot
- Spring Security with JWT
- MySQL
- Spring Data JPA
- MVC Pattern

---

## ✅ Features

- User registration and login
- View all job listings
- View job details
- Apply for a job
- Secure login using JWT
- Backend CRUD operations for posts
- Backend CRUD operations for user's Profile

---

## 📁 Project Structure

### Frontend (`/frontend`)

lib/
├── main.dart # Entry point
├── models/ # Dart models (Job, User)
├── Providers/ # For Statement Management
├── screens/ # UI Screens (Home, Login, JobDetail,profileScreen)
└── widgets/ # Reusable UI components 

### Backend (`/backend`)
src/main/java/
├── controller/ # REST API controllers
├── service/ # Business logic
├── repository/ # Data access layer (JPA)
├── model/ # Java entities (User, Job)
├── security/ # JWT filter, provider, config
└── BackendApplication.java # Main class


## 🔐 Authentication Flow (Spring Security + JWT)

1. User/Admin logs in → receives JWT token
2. JWT stored in frontend (e.g., `shared_preferences`)
3. For every secure request, token is added in `Authorization` header
4. Backend verifies token and checks user.

---

## 🧪 Running the Project

### 🔧 Backend

1. Create a MySQL database (e.g., `job_finder`)
2. Update `application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/job_finder
spring.datasource.username=your_db_user
spring.datasource.password=your_db_password
jwt.secret=your_secret_key


📦 Installation
git clone https://github.com/Mihir-prajapati685/flutterEcommerceApp.git
cd ecommerce-clothes-app
flutter pub get
flutter run

