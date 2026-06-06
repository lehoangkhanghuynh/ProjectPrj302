package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import model.CourseDAO;
import model.CourseDTO;
import model.LessonDAO;
import model.UserDTO;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 500,
        maxRequestSize = 1024 * 1024 * 600
)
public class instructorController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (user.getRole() != 2 && user.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
            return;
        }

        String action = request.getParameter("action");
        String url = "/instructor/instructorDashboard.jsp";

        try {
            if (action == null) {
                action = "";
            }

            switch (action) {
                case "":
                case "dashboard":
                    url = viewDashboard(request, response);
                    break;
                case "viewMyCourses":
                    url = viewMyCourses(request, response);
                    break;
                case "createCourse":
                    url = createCourse(request, response);
                    break;
                case "updateCourse":
                    url = updateCourse(request, response);
                    break;
                case "deleteCourse":
                    deleteCourse(request, response);
                    return;
                case "addLesson":
                    url = addLesson(request, response);
                    break;
                case "deleteLesson":
                    url = deleteLesson(request, response);
                    break;
                case "viewReviews":
                    url = viewReviews(request, response);
                    break;
                case "uploadVideo":
                    uploadVideo(request, response);
                    return;
                case "editCourse":
                    url = editCourse(request, response);
                    break;
                case "toggleCourse":
                    toggleCourse(request, response);
                    return;
                case "showCreateForm":
                    url = showCreateForm(request, response);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (url != null) {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // ================= DASHBOARD =================
    private String viewDashboard(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        double[] stats = new CourseDAO().getInstructorStats(user.getUserId());
        request.setAttribute("TOTAL_COURSES", (int) stats[0]);
        request.setAttribute("TOTAL_STUDENTS", (int) stats[1]);
        request.setAttribute("TOTAL_REVENUE", stats[2]);
        request.setAttribute("AVG_RATING", stats[3]);

        List<CourseDTO> list = new CourseDAO().getCoursesByInstructor(user.getUserId());
        request.setAttribute("COURSE_LIST", list);

        // ✅ Đọc flash từ URL param → set vào request (tự mất sau 1 request, không bị lặp)
        String flash = request.getParameter("flash");
        if ("delete_ok".equals(flash)) {
            request.setAttribute("successMessage", "Đã xóa khóa học thành công.");
        } else if ("delete_fail".equals(flash)) {
            request.setAttribute("errorMessage", "Xóa khóa học thất bại. Vui lòng thử lại.");
        }

        return "/instructor/instructorDashboard.jsp";
    }

    // ================= VIEW MY COURSES =================
    private String viewMyCourses(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        List<CourseDTO> list = new CourseDAO().getCoursesByInstructor(user.getUserId());
        request.setAttribute("COURSE_LIST", list);
        return "/instructor/instructorCourses.jsp";
    }

    // ================= CREATE COURSE =================
    private String createCourse(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String topic = request.getParameter("topic");
        String courseName = request.getParameter("courseName");

        String feeStr = request.getParameter("fee");
        if (feeStr == null || feeStr.trim().isEmpty()) {
            feeStr = request.getParameter("feeHidden");
        }
        double fee = 0;
        try {
            fee = Double.parseDouble(feeStr.trim());
        } catch (Exception ignored) {
        }

        // ── Lấy categoryId từ form ────────────────────────────────
        int categoryId = 0;
        try {
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        } catch (Exception ignored) {
        }

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // Xử lý ảnh thumbnail
        String imgPath = null;
        try {
            Part filePart = request.getPart("thumbnailFile");
            if (filePart != null && filePart.getSize() > 0) {
                String originalName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = originalName.substring(originalName.lastIndexOf("."));
                String savedName = "course_" + System.currentTimeMillis() + ext;
                String uploadDir = getServletContext().getRealPath("") + java.io.File.separator + "img" + java.io.File.separator + "courses";
                new java.io.File(uploadDir).mkdirs();
                filePart.write(uploadDir + java.io.File.separator + savedName);
                imgPath = "img/courses/" + savedName;
            }
        } catch (Exception ignored) {
        }

        if (imgPath == null || imgPath.isEmpty()) {
            String thumbnailUrl = request.getParameter("thumbnail");
            if (thumbnailUrl != null && !thumbnailUrl.trim().isEmpty()) {
                imgPath = thumbnailUrl.trim();
            }
        }

        String statusParam = request.getParameter("status");
        String status = "1".equals(statusParam) ? "active" : "pending";

        CourseDAO courseDAO = new CourseDAO();
        boolean ok = courseDAO.createCourse(topic, courseName, fee, user.getUserId(), imgPath, status);

        // ── Sau khi tạo course, gán category ─────────────────────
        if (ok && categoryId > 0) {
            try {
                int newCourseId = courseDAO.getLastInsertedCourseId(user.getUserId());
                new model.CategoryDAO().assignToCourse(newCourseId, categoryId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (ok) {
            request.setAttribute("successMessage", "Tạo khóa học thành công!");
        } else {
            request.setAttribute("errorMessage", "Tạo khóa học thất bại. Vui lòng thử lại.");
        }

        request.setAttribute("CATEGORY_LIST", new model.CategoryDAO().getAll());
request.getRequestDispatcher("instructor/instructorCreateCourse.jsp").forward(request, response);
return null;
    }

    // ================= UPDATE COURSE =================
    private String updateCourse(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String topic = request.getParameter("topic");
        String courseName = request.getParameter("courseName");
        double fee = Double.parseDouble(request.getParameter("fee"));

        boolean ok = new CourseDAO().updateCourse(courseId, topic, courseName, fee);

        // ✅ Truyền kết quả qua URL param → editCourse sẽ đọc và set vào request
        String flash = ok ? "update_ok" : "update_fail";
        response.sendRedirect(request.getContextPath()
                + "/instructorController?action=editCourse&courseId=" + courseId
                + "&flash=" + flash);
        return null;
    }

    // ================= DELETE COURSE =================
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        String courseIdStr = request.getParameter("courseId");
        String flash = "delete_fail";

        if (user != null && courseIdStr != null && !courseIdStr.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdStr);
                // deleteCourseByInstructor có WHERE instructorId = ? → chỉ xóa được khóa của mình
                new CourseDAO().deleteCourseByInstructor(courseId, user.getUserId());
                flash = "delete_ok";
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ✅ Truyền kết quả qua URL param thay vì session — không bị lặp ở trang khác
        response.sendRedirect(request.getContextPath()
                + "/instructorController?action=dashboard&flash=" + flash);
    }

    // ================= ADD LESSON =================
    private String addLesson(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String lessonTitle = request.getParameter("lessonTitle");
        String videoUrl = request.getParameter("videoUrl");

        try {
            Part filePart = request.getPart("videoFile");
            if (filePart != null && filePart.getSize() > 0) {
                String originalName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = originalName.substring(originalName.lastIndexOf("."));
                String savedName = "lesson_" + System.currentTimeMillis() + ext;
                String uploadDir = getServletContext().getRealPath("") + java.io.File.separator + "videos" + java.io.File.separator + courseId;
                new java.io.File(uploadDir).mkdirs();
                filePart.write(uploadDir + java.io.File.separator + savedName);
                videoUrl = "videos/" + courseId + "/" + savedName;
            }
        } catch (Exception ignored) {
        }

        new LessonDAO().addLesson(courseId, lessonTitle, videoUrl);
        response.sendRedirect(request.getContextPath() + "/instructorController?action=viewMyCourses");
        return null;
    }

    // ================= DELETE LESSON =================
    private String deleteLesson(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        new LessonDAO().deleteLesson(lessonId);
        response.sendRedirect(request.getContextPath() + "/instructorController?action=viewMyCourses");
        return null;
    }

    // ================= VIEW REVIEWS =================
    private String viewReviews(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        List<model.ReviewDTO> reviews = model.ReviewDAO.getByCourse(courseId);
        request.setAttribute("REVIEWS", reviews);
        return "/course/courseReview.jsp";
    }

    // ================= UPLOAD VIDEO =================
    private void uploadVideo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));

            Part filePart = request.getPart("videoFile");
            if (filePart == null || filePart.getSize() == 0) {
                // OK dùng session ở đây vì redirect sang servlet khác (lesson)
                session.setAttribute("uploadError", "Vui lòng chọn file video.");
                response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId);
                return;
            }

            String originalName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = "";
            int dotIdx = originalName.lastIndexOf(".");
            if (dotIdx >= 0) {
                extension = originalName.substring(dotIdx);
            }

            String savedName = lessonId + "_" + System.currentTimeMillis() + extension;
            String appPath = getServletContext().getRealPath("");
            java.io.File videoDir = new java.io.File(appPath + java.io.File.separator + "videos" + java.io.File.separator + courseId);
            if (!videoDir.exists()) {
                videoDir.mkdirs();
            }

            filePart.write(new java.io.File(videoDir, savedName).getAbsolutePath());

            String relativePath = "videos/" + courseId + "/" + savedName;
            try ( java.sql.Connection con = utils.DbiUtils.getConnection();  java.sql.PreparedStatement ps = con.prepareStatement("UPDATE lessons SET video = ? WHERE lessonId = ?")) {
                ps.setString(1, relativePath);
                ps.setInt(2, lessonId);
                ps.executeUpdate();
            }

            // OK dùng session ở đây vì redirect sang servlet khác (lesson)
            session.setAttribute("uploadSuccess", "Upload video thành công!");
            response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("uploadError", "Lỗi upload: " + e.getMessage());
            response.sendRedirect("courseController?action=ExploreCourse");
        }
    }

    // ================= EDIT COURSE =================
    private String editCourse(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        CourseDTO course = new CourseDAO().searchByIDc(courseId);
        request.setAttribute("COURSE", course);

        // ✅ Đọc flash từ URL param → set vào request (tự mất sau 1 request, không bị lặp)
        String flash = request.getParameter("flash");
        if ("update_ok".equals(flash)) {
            request.setAttribute("successMessage", "Cập nhật khóa học thành công!");
        } else if ("update_fail".equals(flash)) {
            request.setAttribute("errorMessage", "Cập nhật thất bại. Vui lòng thử lại.");
        }

        return "/instructor/instructorEditCourse.jsp";
    }

    private void toggleCourse(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        String courseIdStr = request.getParameter("courseId");
        String currentStatus = request.getParameter("currentStatus");

        if (user != null && courseIdStr != null) {
            try {
                int courseId = Integer.parseInt(courseIdStr);
                // Nếu đang active → ẩn, nếu không → mở
                String newStatus = "active".equalsIgnoreCase(currentStatus) ? "deleted" : "active";
                new CourseDAO().updateCourseStatus(courseId, user.getUserId(), newStatus);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect về trang trước (courses hoặc dashboard)
        String from = request.getParameter("from");
        String flash = "dashboard".equals(from)
                ? request.getContextPath() + "/instructorController?action=dashboard"
                : request.getContextPath() + "/instructorController?action=viewMyCourses";
        response.sendRedirect(flash);
    }
// ================= SHOW CREATE FORM =================

    private String showCreateForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
    try {
        List<model.CategoryDTO> cats = new model.CategoryDAO().getAll();
        System.out.println("=== CATEGORY DEBUG ===");
        System.out.println("Size: " + cats.size());
        for (model.CategoryDTO c : cats) {
            System.out.println("  -> " + c.getCategoryId() + " | " + c.getCategoryName());
        }
        request.setAttribute("CATEGORY_LIST", cats);
    } catch (Exception e) {
        System.out.println("=== CATEGORY ERROR ===");
        e.printStackTrace();
    }
    return "/instructor/instructorCreateCourse.jsp";
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
