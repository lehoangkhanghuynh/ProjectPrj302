package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import model.*;

@MultipartConfig(maxFileSize = 500 * 1024 * 1024)
public class courseController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "ExploreCourse";
        }

        try {
            switch (action) {
                case "ExploreCourse":
                    exploreCourse(request, response);
                    break;
                case "detail":
                    courseDetail(request, response);
                    break;
                case "lesson":
                    loadLesson(request, response);
                    break;
                case "addComment":
                    addComment(request, response);
                    break;
                case "updateComment":           // <-- MỚI
                    updateComment(request, response);
                    break;
                case "deleteComment":
                    deleteComment(request, response);
                    break;
                case "finishCourse":
                    finishCourse(request, response);
                    break;
                case "courseComplete":
                    courseComplete(request, response);
                    break;
                case "enroll":
                    enrollCourse(request, response);
                    break;
                case "myCourses":
                    myCourses(request, response);
                    break;
                case "deleteCourse":
                    deleteCourse(request, response);
                    break;
                case "uploadVideo":
                    uploadVideo(request, response);
                    break;
                default:
                    exploreCourse(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // UPDATE COMMENT (MỚI)
    // ════════════════════════════════════════════════════════════════════════
    private void updateComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            int lessonId  = Integer.parseInt(request.getParameter("lessonId"));
            int courseId  = Integer.parseInt(request.getParameter("courseId"));
            String content = request.getParameter("commentContent");

            if (content != null && !content.trim().isEmpty()) {
                new CommentDAO().updateComment(commentId, user.getUserId(), content.trim());
            }

            response.sendRedirect("courseController?action=lesson&courseId=" + courseId
                    + "&lessonId=" + lessonId + "#comments");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("courseController?action=lesson"
                    + "&courseId=" + request.getParameter("courseId")
                    + "&lessonId=" + request.getParameter("lessonId") + "#comments");
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // MỚI THÊM: Khóa học của tôi
    // ════════════════════════════════════════════════════════════════════════
    private void myCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<CourseDTO> myCourses = new EnrollDAO().getMyCourses(user.getUserId());
            request.setAttribute("MY_COURSES", myCourses);

            WishlistDAO wDao = new WishlistDAO();
            session.setAttribute("WISHLIST_IDS", wDao.getWishlistIds(user.getUserId()));
            session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(user.getUserId()));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("MY_COURSES", new ArrayList<>());
        }

        request.getRequestDispatcher("/course/myCourses.jsp").forward(request, response);
    }

    // ════════════════════════════════════════════════════════════════════════
    // CÁC METHOD CŨ — GIỮ NGUYÊN
    // ════════════════════════════════════════════════════════════════════════
    private void exploreCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        CourseDAO dao = new CourseDAO();
        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim();
        }

        List<CourseDTO> list;
        if (keyword != null && !keyword.isEmpty()) {
            list = dao.searchByKeyword(keyword);
        } else {
            list = dao.getAll();
            keyword = "";
        }

        request.setAttribute("COURSE_LIST", list);
        request.setAttribute("KEYWORD", keyword);

        Map<Integer, double[]> courseStats = ReviewDAO.getAllCourseStats();
        Map<Integer, Double> avgRatingMap = new HashMap<>();
        Map<Integer, Integer> reviewCountMap = new HashMap<>();
        for (Map.Entry<Integer, double[]> e : courseStats.entrySet()) {
            avgRatingMap.put(e.getKey(), e.getValue()[0]);
            reviewCountMap.put(e.getKey(), (int) e.getValue()[1]);
        }
        request.setAttribute("AVG_RATING_MAP", avgRatingMap);
        request.setAttribute("REVIEW_COUNT_MAP", reviewCountMap);

        CategoryDAO catDAO = new CategoryDAO();
        request.setAttribute("CATEGORY_LIST", catDAO.getAll());
        request.setAttribute("COURSE_CATEGORY_MAP", catDAO.getCourseCategoryMap());

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user != null) {
            String userId = user.getUserId();
            EnrollDAO enrollDAO = new EnrollDAO();
            request.setAttribute("ENROLLED_IDS", enrollDAO.getEnrolledCourseIds(userId));
            request.setAttribute("COMPLETED_IDS", enrollDAO.getCompletedCourseIds(userId));
            WishlistDAO wDao = new WishlistDAO();
            session.setAttribute("WISHLIST_IDS", wDao.getWishlistIds(userId));
            session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(userId));
        }

        request.getRequestDispatcher("/course/listCourse.jsp").forward(request, response);
    }

    private void uploadVideo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            Part filePart = request.getPart("videoFile");
            if (filePart == null || filePart.getSize() == 0) {
                request.getSession().setAttribute("uploadError", "Vui lòng chọn file video!");
                response.sendRedirect("courseController?action=lesson&courseId=" + courseId + "&lessonId=" + lessonId);
                return;
            }

            String fileName = "lesson_" + lessonId + ".mp4";
            String savePath = getServletContext().getRealPath("/video/courses/")
                    + java.io.File.separator + fileName;

            java.io.File dir = new java.io.File(getServletContext().getRealPath("/video/courses/"));
            if (!dir.exists()) {
                dir.mkdirs();
            }

            filePart.write(savePath);
            new LessonDAO().updateVideo(lessonId, "video/courses/" + fileName);

            request.getSession().setAttribute("uploadSuccess", "Upload video thành công!");
            response.sendRedirect("courseController?action=lesson&courseId=" + courseId + "&lessonId=" + lessonId);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("uploadError", "Upload thất bại: " + e.getMessage());
            response.sendRedirect("courseController?action=lesson&courseId="
                    + request.getParameter("courseId") + "&lessonId=" + request.getParameter("lessonId"));
        }
    }

    private void courseDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        CourseDAO dao = new CourseDAO();
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        CourseDTO course = dao.searchByIDc(courseId);

        List<ReviewDTO> reviews = ReviewDAO.getByCourse(courseId);
        double avgRating = ReviewDAO.getAvgRating(courseId);
        int reviewCount = ReviewDAO.countByCourse(courseId);
        Map<Integer, Integer> dist = ReviewDAO.getRatingDistribution(courseId);

        List<Map<String, Object>> distList = new ArrayList<>();
        for (int i = 5; i >= 1; i--) {
            Map<String, Object> row = new HashMap<>();
            int count = (dist != null && dist.containsKey(i)) ? dist.get(i) : 0;
            double pct = reviewCount > 0 ? count * 100.0 / reviewCount : 0;
            row.put("star", i);
            row.put("count", count);
            row.put("pct", pct);
            distList.add(row);
        }

        request.setAttribute("COURSE", course);
        request.setAttribute("REVIEWS", reviews);
        request.setAttribute("AVG_RATING", avgRating);
        request.setAttribute("REVIEW_COUNT", reviewCount);
        request.setAttribute("DIST_LIST", distList);

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user != null) {
            EnrollDAO enrollDAO = new EnrollDAO();
            List<Integer> enrolled = enrollDAO.getEnrolledCourseIds(user.getUserId());
            List<Integer> completed = enrollDAO.getCompletedCourseIds(user.getUserId());
            request.setAttribute("IS_ENROLLED", enrolled.contains(courseId));
            request.setAttribute("IS_COMPLETED", completed.contains(courseId));
        }

        request.getRequestDispatcher("/course/courseDetail.jsp").forward(request, response);
    }

    private void loadLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            LessonDAO lessonDAO = new LessonDAO();
            CourseDAO courseDAO = new CourseDAO();

            List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
            CourseDTO course = courseDAO.searchByIDc(courseId);

            LessonDTO currentLesson = null;
            String lessonIdParam = request.getParameter("lessonId");
            if (lessonIdParam != null) {
                currentLesson = lessonDAO.getLessonById(Integer.parseInt(lessonIdParam));
            } else if (!lessons.isEmpty()) {
                currentLesson = lessons.get(0);
            }

            int currentIndex = 1;
            if (currentLesson != null) {
                for (int i = 0; i < lessons.size(); i++) {
                    if (lessons.get(i).getLessonId() == currentLesson.getLessonId()) {
                        currentIndex = i + 1;
                        break;
                    }
                }
            }

            List<CommentDTO> comments = null;
            if (currentLesson != null) {
                comments = new CommentDAO().getCommentsByLesson(currentLesson.getLessonId());
            }

            request.setAttribute("currentIndex", currentIndex);
            request.setAttribute("courseId", courseId);
            request.setAttribute("course", course);
            request.setAttribute("lessons", lessons);
            request.setAttribute("currentLesson", currentLesson);
            request.setAttribute("comments", comments);

            request.getRequestDispatcher("/course/lesson.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String content = request.getParameter("commentContent");

            if (content != null && !content.trim().isEmpty()) {
                new CommentDAO().addComment(lessonId, user.getUserId(), content.trim());
            }
            response.sendRedirect("courseController?action=lesson&courseId=" + courseId
                    + "&lessonId=" + lessonId + "#comments");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        try {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            int lessonId  = Integer.parseInt(request.getParameter("lessonId"));
            int courseId  = Integer.parseInt(request.getParameter("courseId"));

            new CommentDAO().deleteComment(commentId, user.getUserId());

            response.sendRedirect("courseController?action=lesson&courseId=" + courseId
                    + "&lessonId=" + lessonId + "#comments");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void finishCourse(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            new EnrollDAO().updateStatusDone(user.getUserId(), courseId);
            response.sendRedirect("courseController?action=courseComplete&courseId=" + courseId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void courseComplete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            CourseDTO course = new CourseDAO().searchByIDc(courseId);
            ReviewDTO myReview = new ReviewDAO().getByUserAndCourse(user.getUserId(), courseId);

            request.setAttribute("course", course);
            request.setAttribute("courseId", courseId);
            request.setAttribute("MY_REVIEW", myReview);

            request.getRequestDispatcher("/course/completeCourse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void enrollCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = user.getUserId();
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        EnrollDAO enrollDAO = new EnrollDAO();
        UserDAO userDAO = new UserDAO();
        LessonDAO lessonDAO = new LessonDAO();

        try {
            double fee = enrollDAO.getCourseFee(courseId);
            double balance = userDAO.getBalance(userId);

            if (enrollDAO.isEnrolled(userId, courseId)) {
                int status = enrollDAO.getEnrollStatus(userId, courseId);
                if (status >= 1) {
                    response.sendRedirect(buildLessonUrl(lessonDAO, courseId));
                    return;
                }
            }

            if (balance < fee) {
                request.setAttribute("enrollmessage", "Số dư không đủ!");
                request.getRequestDispatcher("courseController?action=ExploreCourse")
                        .forward(request, response);
                return;
            }

            if (!enrollDAO.isEnrolled(userId, courseId)) {
                enrollDAO.enrollCourse(userId, courseId);
            }

            boolean deducted = userDAO.deductBalance(userId, fee);
            if (!deducted) {
                request.setAttribute("enrollmessage", "Số dư không đủ!");
                request.getRequestDispatcher("courseController?action=ExploreCourse")
                        .forward(request, response);
                return;
            }

            enrollDAO.updateStatus(userId, courseId, 1);
            user.setBalance(balance - fee);
            session.setAttribute("user", user);

            response.sendRedirect(buildLessonUrl(lessonDAO, courseId));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private String buildLessonUrl(LessonDAO lessonDAO, int courseId) {
        try {
            List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
            if (lessons != null && !lessons.isEmpty()) {
                return "courseController?action=lesson&courseId="
                        + courseId + "&lessonId=" + lessons.get(0).getLessonId();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "courseController?action=lesson&courseId=" + courseId;
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        new CourseDAO().deleteCourseByInstructor(courseId, user.getUserId());
        response.sendRedirect(request.getContextPath() + "/instructorController?action=viewMyCourses");
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