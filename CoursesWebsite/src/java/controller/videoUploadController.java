package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.UserDTO;
import utils.DbiUtils;

/**
 * Servlet xử lý upload video cho bài học.
 * Lưu file vào: {webapp}/videos/{courseId}/{lessonId_filename}
 * Cập nhật cột video trong bảng lessons.
 *
 * URL: POST /uploadVideo
 * Params: courseId, lessonId, videoFile (multipart)
 */
@WebServlet("/uploadVideo")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 10,  // 10 MB — bắt đầu ghi file
    maxFileSize       = 1024 * 1024 * 500, // 500 MB mỗi file
    maxRequestSize    = 1024 * 1024 * 600  // 600 MB tổng request
)
public class videoUploadController extends HttpServlet {

    // Thư mục gốc lưu video (tương đối với webapp root)
    private static final String VIDEO_DIR = "videos";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // Phải đăng nhập (và nên kiểm tra role admin/instructor tùy hệ thống)
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int courseId  = Integer.parseInt(request.getParameter("courseId"));
            int lessonId  = Integer.parseInt(request.getParameter("lessonId"));
            Part filePart = request.getPart("videoFile");

            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("uploadError", "Vui lòng chọn file video.");
                response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId);
                return;
            }

            // Lấy tên file gốc
            String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension    = "";
            int dotIdx = originalName.lastIndexOf('.');
            if (dotIdx >= 0) extension = originalName.substring(dotIdx); // ".mp4"

            // Tên file lưu: lessonId_timestamp.ext  →  tránh trùng
            String savedName = lessonId + "_" + System.currentTimeMillis() + extension;

            // Tạo thư mục videos/courseId/ nếu chưa có
            String appPath  = getServletContext().getRealPath("");
            File   videoDir = new File(appPath + File.separator + VIDEO_DIR
                                     + File.separator + courseId);
            if (!videoDir.exists()) videoDir.mkdirs();

            // Ghi file
            File destFile = new File(videoDir, savedName);
            filePart.write(destFile.getAbsolutePath());

            // Đường dẫn tương đối lưu vào DB: videos/courseId/savedName
            String relativePath = VIDEO_DIR + "/" + courseId + "/" + savedName;

            // Cập nhật DB
            try (Connection con = DbiUtils.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                         "UPDATE lessons SET video = ? WHERE lessonId = ?")) {
                ps.setString(1, relativePath);
                ps.setInt(2, lessonId);
                ps.executeUpdate();
            }

            session.setAttribute("uploadSuccess", "Upload video thành công!");
            response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("uploadError", "Lỗi upload: " + e.getMessage());
            response.sendRedirect("courseController?action=ExploreCourse");
        }
    }
}
