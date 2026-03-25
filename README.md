# ☕ Average Coffee Shop - Fullstack System

![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.5.x-brightgreen)
![Java](https://img.shields.io/badge/Java-21-orange)
![MySQL](https://img.shields.io/badge/MySQL-9.0-blue)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue)

מערכת ניהול מקצה לקצה לבית קפה מודרני, המדגימה יכולות **Fullstack** תוך שימוש בארכיטקטורה מתקדמת וסטנדרטים של התעשייה. הפרויקט פותח כחלק מהגשת מועמדות לתוכנית **Wix KickstartX**.

---

## 🚀 טכנולוגיות וכלים (Tech Stack)

* **Backend:** Java 21 & **Spring Boot 3**
* **Database:** MySQL 9.0 הרץ בתוך **Docker Container**
* **ORM:** Spring Data JPA / Hibernate
* **API:** RESTful Services (JSON)
* **Infrastructure:** Maven & Docker Desktop

---

## 🏗️ ארכיטקטורה (Project Structure)

הפרויקט בנוי לפי תבנית **MVC** (Model-View-Controller) להפרדה מלאה בין שכבת הנתונים לשכבת הלוגיקה:

* **`controller/`** - ניהול בקשות HTTP (Endpoints) וחשיפת ה-API לעולם.
* **`model/`** - הגדרת הישויות (Entities) ומיפוי הטבלאות לבסיס הנתונים.
* **`repository/`** - ממשקי גישה לנתונים המשתמשים ב-JPA לביצוע שאילתות.

---

## ✅ מה בוצע עד כה?

- [x] **Infrastracture:** הקמת תשתית Docker למסד נתונים MySQL.
- [x] **Spring Integration:** חיבור מלא בין האפליקציה למסד הנתונים.
- [x] **REST API:** פיתוח נקודות קצה לשליפה ומחיקה של פולי קפה (`CoffeeBean`).
- [x] **Schema Design:** תכנון מסד נתונים הכולל טבלאות מלאי, הזמנות, משתמשים ומערכת מדבקות (Gamification).
- [x] **Clean Code:** חלוקה ל-Packages ושמירה על קוד קריא ופשוט לתחזוקה.

---

## 🛠️ איך להריץ את הפרויקט?

1.  **בסיס הנתונים:** וודא ש-Docker Desktop רץ והפעל את הקונטיינר של MySQL.
2.  **הגדרות:** וודא שפרטי הגישה מעודכנים ב-`src/main/resources/application.properties`.
3.  **הרצה:** הפעל את `AverageCoffeeShopApplication.java` מה-IDE שלך (VS Code / IntelliJ).
4.  **בדיקה:** גלוש לכתובת:
    `http://localhost:8080/api/beans`

---

## 📂 מבנה התיקיות (Packages)
```text
src/main/java/com/coffeeshop/average_coffee_shop/
├── controller/  # API Endpoints
├── model/       # JPA Entities
├── repository/  # Data Access Layer
└── AverageCoffeeShopApplication.java