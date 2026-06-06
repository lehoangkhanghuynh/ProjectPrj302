package service;

import model.*;
import java.util.*;

/**
 * CourseService — tầng Business Logic (MVC2).
 *
 * Controller KHÔNG gọi DAO trực tiếp nữa.
 * Mọi nghiệp vụ (validate balance, check enroll, build trending list…)
 * đều nằm ở đây.
 */
public class CourseService {

    private final CourseDAO   courseDAO   = new CourseDAO();
    private final EnrollDAO   enrollDAO   = new EnrollDAO();
    private final UserDAO     userDAO     = new UserDAO();
    private final LessonDAO   lessonDAO   = new LessonDAO();
    private final ReviewDAO   reviewDAO   = new ReviewDAO();   // instance (bên dưới DAO đã fix)
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final WishlistDAO wishlistDAO = new WishlistDAO();
    private final CommentDAO  commentDAO  = new CommentDAO();

    // ──────────────────────────────────────────────────────────────────────
    // EXPLORE / SEARCH
    // ──────────────────────────────────────────────────────────────────────

    /**
     * Trả về toàn bộ dữ liệu cần thiết cho trang danh sách khóa học.
     * Controller chỉ cần gọi method này rồi setAttribute vào request.
     */
    public ExploreCourseResult buildExplorePage(String keyword, String userId) throws Exception {

        // 1. Danh sách khóa học
        List<CourseDTO> allCourses = (keyword != null && !keyword.trim().isEmpty())
                ? courseDAO.searchByKeyword(keyword.trim())
                : courseDAO.getAll();

        // 2. Rating map
        Map<Integer, double[]> stats    = ReviewDAO.getAllCourseStats();
        Map<Integer, Double>   avgMap   = new HashMap<>();
        Map<Integer, Integer>  cntMap   = new HashMap<>();
        for (Map.Entry<Integer, double[]> e : stats.entrySet()) {
            avgMap.put(e.getKey(), e.getValue()[0]);
            cntMap.put(e.getKey(), (int) e.getValue()[1]);
        }

        // 3. Category
        List<CategoryDTO>      categories   = categoryDAO.getAll();

        // 4. Trending — Controller KHÔNG cần slice index, JSP chỉ forEach
        List<CourseDTO> trendingPopular = allCourses.size() >= 3
                ? allCourses.subList(0, 3) : allCourses;
        List<CourseDTO> trendingNew     = allCourses.size() >= 6
                ? allCourses.subList(3, 6)
                : (allCourses.size() > 3 ? allCourses.subList(3, allCourses.size()) : Collections.emptyList());
        List<CourseDTO> trendingAI      = allCourses.size() >= 9
                ? allCourses.subList(6, 9)
                : (allCourses.size() > 6 ? allCourses.subList(6, allCourses.size()) : Collections.emptyList());

        // 5. Dữ liệu user (nếu đã đăng nhập)
        List<Integer> enrolledIds  = Collections.emptyList();
        List<Integer> completedIds = Collections.emptyList();
        List<Integer> wishlistIds  = Collections.emptyList();
        List<CourseDTO> wishlistCourses = Collections.emptyList();

        if (userId != null && !userId.isEmpty()) {
            enrolledIds     = enrollDAO.getEnrolledCourseIds(userId);
            completedIds    = enrollDAO.getCompletedCourseIds(userId);
            wishlistIds     = wishlistDAO.getWishlistIds(userId);
            wishlistCourses = wishlistDAO.getWishlistCourses(userId);
        }

        return null;
    }

    // ──────────────────────────────────────────────────────────────────────
    // ENROLL
    // ──────────────────────────────────────────────────────────────────────

    public enum EnrollResult { SUCCESS, ALREADY_ENROLLED, INSUFFICIENT_BALANCE, ERROR }

    public EnrollResult enroll(String userId, int courseId) {
        try {
            double fee     = enrollDAO.getCourseFee(courseId);
            double balance = userDAO.getBalance(userId);

            if (enrollDAO.isEnrolled(userId, courseId)) {
                int status = enrollDAO.getEnrollStatus(userId, courseId);
                return (status >= 1) ? EnrollResult.ALREADY_ENROLLED : EnrollResult.ERROR;
            }

            if (balance < fee) {
                return EnrollResult.INSUFFICIENT_BALANCE;
            }

            enrollDAO.enrollCourse(userId, courseId);
            boolean deducted = userDAO.deductBalance(userId, fee);
            if (!deducted) return EnrollResult.INSUFFICIENT_BALANCE;

            enrollDAO.updateStatus(userId, courseId, 1);
            return EnrollResult.SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return EnrollResult.ERROR;
        }
    }

    /** Lấy số dư mới nhất từ DB để cập nhật session sau enroll. */
    public double getBalance(String userId) throws Exception {
        return userDAO.getBalance(userId);
    }

    // ──────────────────────────────────────────────────────────────────────
    // LESSON
    // ──────────────────────────────────────────────────────────────────────

    public LessonPageResult buildLessonPage(int courseId, String lessonIdParam) throws Exception {
        List<LessonDTO> lessons    = lessonDAO.getLessonsByCourse(courseId);
        CourseDTO       course     = courseDAO.searchByIDc(courseId);

        LessonDTO currentLesson = null;
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

        List<CommentDTO> comments = (currentLesson != null)
                ? commentDAO.getCommentsByLesson(currentLesson.getLessonId())
                : Collections.emptyList();

        return new LessonPageResult(course, lessons, currentLesson, currentIndex, comments);
    }

    public String buildLessonUrl(int courseId) throws Exception {
        List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
        String base = "courseController?action=lesson&courseId=" + courseId;
        return (lessons != null && !lessons.isEmpty())
                ? base + "&lessonId=" + lessons.get(0).getLessonId()
                : base;
    }

    // ──────────────────────────────────────────────────────────────────────
    // DETAIL
    // ──────────────────────────────────────────────────────────────────────

    public CourseDetailResult buildDetailPage(int courseId, String userId) throws Exception {
        CourseDTO         course      = courseDAO.searchByIDc(courseId);
        List<ReviewDTO>   reviews     = ReviewDAO.getByCourse(courseId);
        double            avgRating   = ReviewDAO.getAvgRating(courseId);
        int               reviewCount = ReviewDAO.countByCourse(courseId);
        Map<Integer,Integer> dist     = ReviewDAO.getRatingDistribution(courseId);

        List<Map<String, Object>> distList = new ArrayList<>();
        for (int i = 5; i >= 1; i--) {
            Map<String, Object> row = new HashMap<>();
            int count = (dist != null && dist.containsKey(i)) ? dist.get(i) : 0;
            double pct = reviewCount > 0 ? count * 100.0 / reviewCount : 0;
            row.put("star", i); row.put("count", count); row.put("pct", pct);
            distList.add(row);
        }

        boolean isEnrolled  = false;
        boolean isCompleted = false;
        if (userId != null) {
            isEnrolled  = enrollDAO.getEnrolledCourseIds(userId).contains(courseId);
            isCompleted = enrollDAO.getCompletedCourseIds(userId).contains(courseId);
        }

        return new CourseDetailResult(course, reviews, avgRating, reviewCount, distList, isEnrolled, isCompleted);
    }

    // ──────────────────────────────────────────────────────────────────────
    // MY COURSES
    // ──────────────────────────────────────────────────────────────────────

    public List<CourseDTO> getMyCourses(String userId) throws Exception {
        return enrollDAO.getMyCourses(userId);
    }

    // ──────────────────────────────────────────────────────────────────────
    // COMMENT
    // ──────────────────────────────────────────────────────────────────────

    public void addComment(int lessonId, String userId, String content) throws Exception {
        if (content != null && !content.trim().isEmpty()) {
            commentDAO.addComment(lessonId, userId, content.trim());
        }
    }

    public void updateComment(int commentId, String userId, String content) throws Exception {
        if (content != null && !content.trim().isEmpty()) {
            commentDAO.updateComment(commentId, userId, content.trim());
        }
    }

    public void deleteComment(int commentId, String userId) throws Exception {
        commentDAO.deleteComment(commentId, userId);
    }

    // ──────────────────────────────────────────────────────────────────────
    // FINISH / COMPLETE
    // ──────────────────────────────────────────────────────────────────────

    public void finishCourse(String userId, int courseId) throws Exception {
        enrollDAO.updateStatusDone(userId, courseId);
    }

    public CourseCompleteResult buildCompletePage(int courseId, String userId) throws Exception {
        CourseDTO course   = courseDAO.searchByIDc(courseId);
        ReviewDTO myReview = new ReviewDAO().getByUserAndCourse(userId, courseId);
        return new CourseCompleteResult(course, myReview);
    }

    // ──────────────────────────────────────────────────────────────────────
    // WISHLIST (dùng bởi WishlistController — để ở đây cho tiện tham khảo)
    // ──────────────────────────────────────────────────────────────────────

    public void refreshWishlistInSession(String userId, javax.servlet.http.HttpSession session) throws Exception {
        session.setAttribute("WISHLIST_IDS",    wishlistDAO.getWishlistIds(userId));
        session.setAttribute("WISHLIST_COURSES", wishlistDAO.getWishlistCourses(userId));
    }

    // ──────────────────────────────────────────────────────────────────────
    // DELETE COURSE (instructor)
    // ──────────────────────────────────────────────────────────────────────

    public boolean deleteCourse(int courseId, String userId) {
        return courseDAO.deleteCourseByInstructor(courseId, userId);
    }

    // ══════════════════════════════════════════════════════════════════════
    // INNER RESULT CLASSES  (thay vì trả Map lộn xộn)
    // ══════════════════════════════════════════════════════════════════════

    public static class ExploreCourseResult {
        public final List<CourseDTO>       courseList;
        public final String                keyword;
        public final Map<Integer, Double>  avgRatingMap;
        public final Map<Integer, Integer> reviewCountMap;
        public final List<CategoryDTO>     categoryList;
        public final Map<Integer, String>  courseCategoryMap;
        public final List<CourseDTO>       trendingPopular;
        public final List<CourseDTO>       trendingNew;
        public final List<CourseDTO>       trendingAI;
        public final List<Integer>         enrolledIds;
        public final List<Integer>         completedIds;
        public final List<Integer>         wishlistIds;
        public final List<CourseDTO>       wishlistCourses;

        public ExploreCourseResult(
                List<CourseDTO> courseList, String keyword,
                Map<Integer, Double> avgRatingMap, Map<Integer, Integer> reviewCountMap,
                List<CategoryDTO> categoryList, Map<Integer, String> courseCategoryMap,
                List<CourseDTO> trendingPopular, List<CourseDTO> trendingNew, List<CourseDTO> trendingAI,
                List<Integer> enrolledIds, List<Integer> completedIds,
                List<Integer> wishlistIds, List<CourseDTO> wishlistCourses) {
            this.courseList        = courseList;
            this.keyword           = keyword;
            this.avgRatingMap      = avgRatingMap;
            this.reviewCountMap    = reviewCountMap;
            this.categoryList      = categoryList;
            this.courseCategoryMap = courseCategoryMap;
            this.trendingPopular   = trendingPopular;
            this.trendingNew       = trendingNew;
            this.trendingAI        = trendingAI;
            this.enrolledIds       = enrolledIds;
            this.completedIds      = completedIds;
            this.wishlistIds       = wishlistIds;
            this.wishlistCourses   = wishlistCourses;
        }
    }

    public static class LessonPageResult {
        public final CourseDTO       course;
        public final List<LessonDTO> lessons;
        public final LessonDTO       currentLesson;
        public final int             currentIndex;
        public final List<CommentDTO> comments;

        public LessonPageResult(CourseDTO course, List<LessonDTO> lessons,
                                LessonDTO currentLesson, int currentIndex,
                                List<CommentDTO> comments) {
            this.course        = course;
            this.lessons       = lessons;
            this.currentLesson = currentLesson;
            this.currentIndex  = currentIndex;
            this.comments      = comments;
        }
    }

    public static class CourseDetailResult {
        public final CourseDTO              course;
        public final List<ReviewDTO>        reviews;
        public final double                 avgRating;
        public final int                    reviewCount;
        public final List<Map<String,Object>> distList;
        public final boolean                isEnrolled;
        public final boolean                isCompleted;

        public CourseDetailResult(CourseDTO course, List<ReviewDTO> reviews,
                                  double avgRating, int reviewCount,
                                  List<Map<String,Object>> distList,
                                  boolean isEnrolled, boolean isCompleted) {
            this.course      = course;
            this.reviews     = reviews;
            this.avgRating   = avgRating;
            this.reviewCount = reviewCount;
            this.distList    = distList;
            this.isEnrolled  = isEnrolled;
            this.isCompleted = isCompleted;
        }
    }

    public static class CourseCompleteResult {
        public final CourseDTO course;
        public final ReviewDTO myReview;
        public CourseCompleteResult(CourseDTO course, ReviewDTO myReview) {
            this.course    = course;
            this.myReview  = myReview;
        }
    }
}