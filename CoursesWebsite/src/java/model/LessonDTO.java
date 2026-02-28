package model;

public class LessonDTO {

    private int lessonId;
    private int courseId;
    private String title;
    private String video;
    private int duration;
    private String content;

    public LessonDTO() {
    }

    public LessonDTO(int lessonId, int courseId, String title, String video, int duration, String content) {
        this.lessonId = lessonId;
        this.courseId = courseId;
        this.title = title;
        this.video = video;
        this.duration = duration;
        this.content = content;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int v) {
        this.lessonId = v;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int v) {
        this.courseId = v;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String v) {
        this.title = v;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String v) {
        this.video = v;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int v) {
        this.duration = v;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String v) {
        this.content = v;
    }
}
