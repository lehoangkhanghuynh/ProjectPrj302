package filter;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import model.UserDTO;

public class RoleFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String uri = req.getServletPath();

        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        int role = (user != null) ? user.getRole() : -1;
        // role: 1=ADMIN, 2=INSTRUCTOR, 0=USER, -1=chưa đăng nhập

        // Chặn JSP admin
        if (uri.startsWith("/admin/") || uri.equals("/adminController")) {
            if (role != 1) {
                res.sendRedirect(req.getContextPath() + "/homePage.jsp");
                return;
            }
        }

        // Chặn JSP instructor
        if (uri.startsWith("/instructor/") || uri.equals("/instructorController")) {
            if (role != 1 && role != 2) {
                res.sendRedirect(req.getContextPath() + "/homePage.jsp");
                return;
            }
        }

        // Chặn JSP user (myprofile, wishlist,...)
        if (uri.startsWith("/user/")) {
            if (role == -1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
        }

        // Các action admin trong userController
        if (uri.equals("/userController")) {
            String action = req.getParameter("action");
            boolean isAdminAction = "getAllUsers".equals(action)
                    || "blockUser".equals(action)
                    || "unblockUser".equals(action)
                    || "searchUser".equals(action);
            if (isAdminAction && role != 1) {
                res.sendRedirect(req.getContextPath() + "/homePage.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}