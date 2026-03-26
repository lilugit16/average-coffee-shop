# ☕ Average Coffee Shop - Smart Management System

A robust, secure Backend system for a modern coffee shop, built with **Spring Boot 3** and **MySQL**. 
This project was developed as part of the **Wix KickstartX 2026** challenge.

## 🚀 Key Features
- **Secure Authentication:** User registration and login using **BCrypt** password hashing (no plain-text passwords).
- **Role-Based Access:** Distinction between `CUSTOMER` and `ADMIN` roles.
- **Military Reserve Benefit:** Built-in logic to identify military reserve members (`isMilitaryReserve`) for automatic discounts.
- **RESTful API:** Clean and documented endpoints for user management and profiles.
- **Data Integrity:** Implementation of **JPA/Hibernate** with **MySQL** for persistent and structured data.

## 🛠️ Tech Stack
- **Backend:** Java 17+, Spring Boot 3.x
- **Security:** Spring Security (Stateless, CSRF disabled for API)
- **Database:** MySQL 8.0
- **Build Tool:** Maven/Gradle

## 📂 Architecture & Best Practices
- **Layered Architecture:** Clear separation between Controllers, Services, Repositories, and Models.
- **Clean Code:** Use of **Java Optional** to prevent `NullPointerException`.
- **Dependency Injection:** Following SOLID principles for better testability.
- **Security-by-Design:** Sanitizing API responses to avoid leaking sensitive data (like password hashes).

## 🔌 API Endpoints (Current)
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| POST | `/api/users/register` | Register a new user | Public |
| POST | `/api/users/login` | Login and get user status | Public |
| GET | `/api/users/{id}` | Fetch user profile data | Public |

## 🏗️ How to Run
1. Clone the repository.
2. Configure your MySQL credentials in `src/main/resources/application.properties`.
3. Run `mvn spring-boot:run`.
4. Use PowerShell or Postman to interact with the API.
