package filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;

public class LoggingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        long start = System.currentTimeMillis();

        System.out.println("[" + LocalDateTime.now() + "] >>> "
            + req.getMethod() + " " + req.getServletPath());

        chain.doFilter(request, response);

        long duration = System.currentTimeMillis() - start;
        System.out.println("[" + LocalDateTime.now() + "] <<< "
            + req.getServletPath() + " (" + duration + "ms)");
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}