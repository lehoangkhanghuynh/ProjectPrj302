/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DbiUtils;

/**
 *
 * @author HOANG KHANG PC
 */
public class CertificateDAO {

    public boolean createCertificate(CertificateDTO c) {

        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "INSERT INTO Certificate(userId, courseId, issueDate, code) VALUES(?,?,?,?)";

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

            String sql = "SELECT * FROM Certificate WHERE userId = ? AND courseId = ?";

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

}
