FROM tomcat:9.0

# xóa web mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# copy file war vào tomcat
COPY CoursesWebsite.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
