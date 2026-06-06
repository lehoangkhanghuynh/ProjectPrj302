package filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getServletPath();
        String action = req.getParameter("action");

        // Các trang .jsp public (không cần đăng nhập)
        boolean isPublicJsp
                = uri.equals("/login.jsp")
                || uri.equals("/register.jsp")
                || uri.equals("/password/forgotPassword.jsp")
                || uri.equals("/password/resetPassword.jsp") 
                || uri.equals("/index.jsp");

        // Các servlet/resource public
        boolean isPublicResource
                = uri.equals("/mainController")
                || uri.equals("/courseController")
                || uri.equals("/auth")
                || uri.equals("/register")
                || uri.endsWith(".css")
                || uri.endsWith(".js")
                || uri.endsWith(".png")
                || uri.endsWith(".jpg")
                || uri.endsWith(".ico")
                || uri.endsWith(".woff")
                || uri.endsWith(".woff2")
                || uri.endsWith(".ttf")
                || (uri.equals("/paymentController") && "sepayWebhook".equals(action))
                || (uri.equals("/userController") && ("login".equals(action)
                || "register".equals(action)
                || uri.equals("/password/forgotPassword.jsp")
                || uri.equals("/password/resetPassword.jsp")
                || "updatePasswordByEmail".equals(action)));

        if (isPublicJsp || isPublicResource) {
            chain.doFilter(request, response);
            return;
        }

        // Tất cả .jsp còn lại + servlet cần đăng nhập → phải login
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig fc) {
    }

    @Override
    public void destroy() {
    }
}
