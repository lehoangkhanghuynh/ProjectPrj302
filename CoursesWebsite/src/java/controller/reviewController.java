package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ReviewDAO;
import model.ReviewDTO;
import model.UserDTO;

public class reviewController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        try {
            switch (action == null ? "" : action) {
                case "add":
                    handleAdd(req, resp, user);
                    break;
                case "edit":
                    handleEdit(req, resp, user);
                    break;
                case "delete":
                    handleDelete(req, resp, user);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("reviewError", "Có lỗi xảy ra: " + e.getMessage());
            String courseId = req.getParameter("courseId");
            String redirect = req.getParameter("redirect");
            resp.sendRedirect(redirect != null ? redirect : "lesson?courseId=" + courseId + "#reviews");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp, UserDTO user)
            throws Exception {
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int rating   = Integer.parseInt(req.getParameter("rating"));
        String comment = trim(req.getParameter("comment"), 1000);
        String redirect = getRedirect(req, courseId);

        if (rating < 1 || rating > 5) {
            setError(req, "Rating phải từ 1 đến 5 sao.");
            resp.sendRedirect(redirect);
            return;
        }

        if (!ReviewDAO.isCompleted(user.getUserId(), courseId)) {
            setError(req, "Bạn cần hoàn thành khóa học mới có thể đánh giá.");
            resp.sendRedirect(redirect);
            return;
        }

        if (ReviewDAO.getByUserAndCourse(user.getUserId(), courseId) != null) {
            setError(req, "Bạn đã đánh giá khóa học này rồi.");
            resp.sendRedirect(redirect);
            return;
        }

        ReviewDAO.create(new ReviewDTO(courseId, user.getUserId(), rating, comment));
        setSuccess(req, "Đánh giá của bạn đã được ghi nhận!");
        resp.sendRedirect(redirect);
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp, UserDTO user)
            throws Exception {
        int reviewId = Integer.parseInt(req.getParameter("reviewId"));
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int rating   = Integer.parseInt(req.getParameter("rating"));
        String comment = trim(req.getParameter("comment"), 1000);
        String redirect = getRedirect(req, courseId);

        if (rating < 1 || rating > 5) {
            setError(req, "Rating phải từ 1 đến 5 sao.");
            resp.sendRedirect(redirect);
            return;
        }

        if (ReviewDAO.update(reviewId, user.getUserId(), rating, comment)) {
            setSuccess(req, "Đã cập nhật đánh giá.");
        } else {
            setError(req, "Không thể cập nhật. Bạn có thể không phải chủ review này.");
        }
        resp.sendRedirect(redirect);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, UserDTO user)
            throws Exception {
        int reviewId = Integer.parseInt(req.getParameter("reviewId"));
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        String redirect = getRedirect(req, courseId);

        boolean ok = (user.getRole() == 1)
                ? ReviewDAO.deleteByAdmin(reviewId)
                : ReviewDAO.delete(reviewId, user.getUserId());

        if (ok) setSuccess(req, "Đã xoá đánh giá.");
        else    setError(req, "Không thể xoá review này.");

        resp.sendRedirect(redirect);
    }

    // Lấy redirect URL: ưu tiên param "redirect", fallback về lesson#reviews
    private String getRedirect(HttpServletRequest req, int courseId) {
        String r = req.getParameter("redirect");
        return (r != null && !r.trim().isEmpty()) ? r : "lesson?courseId=" + courseId + "#reviews";
    }

    private void setError(HttpServletRequest req, String msg) {
        req.getSession().setAttribute("reviewError", msg);
    }

    private void setSuccess(HttpServletRequest req, String msg) {
        req.getSession().setAttribute("reviewSuccess", msg);
    }

    private String trim(String s, int maxLen) {
        if (s == null) return "";
        s = s.trim();
        return s.length() > maxLen ? s.substring(0, maxLen) : s;
    }
}