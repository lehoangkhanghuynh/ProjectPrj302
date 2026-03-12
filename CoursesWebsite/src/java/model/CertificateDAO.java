package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import utils.DbiUtils;

public class CertificateDAO {

    public boolean createCertificate(CertificateDTO c) {

        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "INSERT INTO Certificates(userId, courseId, issueDate, code) VALUES(?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, c.getUserId());
            ps.setInt(2, c.getCourseId());
            ps.setTimestamp(3, c.getIssueDate());
            ps.setString(4, c.getCode());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public CertificateDTO getCertificate(String userId, int courseId) {

        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "SELECT * FROM Certificates WHERE userId = ? AND courseId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userId);
            ps.setInt(2, courseId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return new CertificateDTO(
                        rs.getInt("certificateId"),
                        rs.getString("userId"),
                        rs.getInt("courseId"),
                        rs.getTimestamp("issueDate"),
                        rs.getString("code")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<CertificateDTO> getCertificatesByUser(String userId) {

        List<CertificateDTO> list = new ArrayList<>();

        try {

            Connection conn = DbiUtils.getConnection();

            String sql = "SELECT * FROM Certificates WHERE userId = ? ORDER BY issueDate DESC";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CertificateDTO cert = new CertificateDTO(
                        rs.getInt("certificateId"),
                        rs.getString("userId"),
                        rs.getInt("courseId"),
                        rs.getTimestamp("issueDate"),
                        rs.getString("code")
                );

                list.add(cert);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
