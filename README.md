# Online Course Platform

Ứng dụng web bán khóa học trực tuyến được xây dựng theo mô hình MVC2, sử dụng JSP/Servlet và SQL Server.

---

## Tech Stack

| Thành phần | Công nghệ |
|---|---|
| Frontend | JSP, HTML, CSS, Bootstrap, JavaScript |
| Backend | Java Servlet (MVC2 Pattern) |
| Database | Microsoft SQL Server |
| Server | Apache Tomcat |
| Build Tool | Maven |

---

## Tính năng

### Người dùng (Student)
- Đăng ký / Đăng nhập / Đặt lại mật khẩu
- Xem danh sách và chi tiết khóa học
- Mua khóa học & xem lịch sử thanh toán
- Xem video bài giảng sau khi đăng ký
- Đánh giá & nhận xét khóa học
- Thêm khóa học vào danh sách yêu thích

### 🎓 Giảng viên (Instructor)
- Tạo và quản lý khóa học
- Tải lên video bài giảng
- Xem thống kê học viên

### 🔧 Quản trị viên (Admin)
- Duyệt / từ chối khóa học
- Quản lý người dùng
- Xem báo cáo doanh thu

---

## Cấu trúc thư mục

```
CoursesWebsite/
├── Web Pages/
│   ├── META-INF/
│   ├── WEB-INF/
│   ├── admin/
│   │   ├── adminCourses.jsp
│   │   ├── adminPayments.jsp
│   │   ├── adminUsers.jsp
│   │   ├── adminViewPayment.jsp
│   │   └── administrator.jsp
│   ├── assets/
│   │   ├── css/
│   │   │   ├── admin/
│   │   │   ├── password/
│   │   │   ├── userCss/
│   │   │   ├── about.css
│   │   │   ├── homepage.css
│   │   │   ├── listCourse.css
│   │   │   ├── login.css
│   │   │   └── payment.css
│   │   └── js/
│   │       ├── admin/
│   │       ├── password/
│   │       ├── userJs/
│   │       ├── common.js
│   │       ├── homepage.js
│   │       ├── instructorcourse.js
│   │       ├── instructorcreate.js
│   │       ├── lesson.js
│   │       ├── listcourse.js
│   │       ├── mycourse.js
│   │       ├── myprofile.js
│   │       ├── payment.js
│   │       └── wishlist.js
│   ├── certificate/
│   │   ├── certificates.jsp
│   │   └── myCertificates.jsp
│   ├── course/
│   │   ├── completeCourse.jsp
│   │   ├── courseDetail.jsp
│   │   ├── courseReview.jsp
│   │   ├── lesson.jsp
│   │   ├── listCourse.jsp
│   │   └── myCourses.jsp
│   ├── img/
│   │   ├── courses/
│   │   ├── instructors/
│   │   ├── logo/
│   │   ├── page/
│   │   └── students/
│   ├── instructor/
│   │   ├── instructorCourses.jsp
│   │   ├── instructorCreateCourse.jsp
│   │   ├── instructorDashboard.jsp
│   │   └── instructorEditCourse.jsp
│   ├── password/
│   │   ├── forgotPassword.jsp
│   │   └── resetPassword.jsp
│   ├── user/
│   │   ├── myprofile.jsp
│   │   └── wishlist.jsp
│   ├── video/
│   │   └── courses/
│   ├── about.jsp
│   ├── homePage.jsp
│   ├── instructors.jsp
│   ├── login.jsp
│   └── payment.jsp
│
└── Source Packages/
    ├── controller/
    │   ├── UserController.java
    │   ├── adminController.java
    │   ├── certificateController.java
    │   ├── courseController.java
    │   ├── instructorController.java
    │   ├── mainController.java
    │   ├── myCoursesController.java
    │   ├── paymentController.java
    │   ├── reviewController.java
    │   └── wishlistController.java
    ├── filter/
    │   ├── AuthFilter.java
    │   ├── LoggingFilter.java
    │   └── RoleFilter.java
    ├── model/
    │   ├── CategoryDAO.java / CategoryDTO.java
    │   ├── CertificateDAO.java / CertificateDTO.java
    │   ├── CommentDAO.java / CommentDTO.java
    │   ├── CourseDAO.java / CourseDTO.java
    │   ├── EnrollDAO.java / EnrollDTO.java
    │   ├── LessonDAO.java / LessonDTO.java
    │   ├── LoginHistoryDAO.java / LoginHistoryDTO.java
    │   ├── PasswordResetDAO.java / PasswordResetDTO.java
    │   ├── PaymentDAO.java / PaymentDTO.java
    │   ├── ReviewDAO.java / ReviewDTO.java
    │   ├── UserDAO.java / UserDTO.java
    │   └── WishlistDAO.java / WishlistDTO.java
    ├── service/
    │   ├── CourseService.java
    │   └── EmailService.java
    └── utils/
        └── DbiUtils.java
```

---

## Cài đặt & Chạy dự án

### Yêu cầu hệ thống
- Java JDK 8+
- Apache Tomcat 9+
- Microsoft SQL Server 2019+
- Maven 3.6+

### Bước 1 — Clone repository
```bash
git clone https://github.com/your-username/online-course-platform.git
cd online-course-platform
```

### Bước 2 — Tạo database
Mở SQL Server Management Studio, chạy file:
```
database/schema.sql
```

### Bước 3 — Cấu hình kết nối database
Chỉnh sửa file `src/main/resources/db.properties`:
```properties
db.url=jdbc:sqlserver://localhost:1433;databaseName=CoursesWebsite
db.username=your_username
db.password=your_password
```

### Bước 4 — Build project
```bash
mvn clean package
```

### Bước 5 — Deploy lên Tomcat
Copy file `target/CoursesWebsite.war` vào thư mục `webapps/` của Tomcat, sau đó khởi động Tomcat.

### Bước 6 — Truy cập ứng dụng
```
http://localhost:8080/CoursesWebsite
```

**Tài khoản mặc định:**
| Role | Username | Password |
|---|---|---|
| stu1 | stu01@gmail.com | 123456 |

---
## 🤝 Đóng góp

Pull request và issues luôn được chào đón!

---

## 📄 License
MIT License
