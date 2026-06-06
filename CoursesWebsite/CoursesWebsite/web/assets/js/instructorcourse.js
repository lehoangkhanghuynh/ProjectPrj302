/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// ── DELETE MODAL ────────────────────────────────────────────
function filterTable() {
    var q = document.getElementById('searchInput').value.toLowerCase();
    var rows = document.querySelectorAll('#courseTable tbody tr');
    var visible = 0;
    rows.forEach(function (row) {
        var name = row.dataset.name || '';
        var topic = row.dataset.topic || '';
        var match = name.includes(q) || topic.includes(q);
        row.style.display = match ? '' : 'none';
        if (match)
            visible++;
    });
    document.getElementById('countDisplay').textContent = visible;
}

function confirmDelete(id, name) {
    document.getElementById('delName').textContent = '"' + name + '"';
    document.getElementById('delBtn').href =
            document.getElementById('contextPath').value +
            '/courseController?action=deleteCourse&courseId=' + id;
    document.getElementById('delModal').classList.add('show');
}

function closeModal() {
    document.getElementById('delModal').classList.remove('show');
}

// ── ADD LESSON MODAL ─────────────────────────────────────────
var currentCourseId = null;
var lessonCount = 0;

function openAddLesson(courseId, courseName) {
    currentCourseId = courseId;
    document.getElementById('addLessonCourseName').textContent = 'Khóa học: ' + courseName;
    document.getElementById('lessonList').innerHTML = '';
    lessonCount = 0;
    addLessonRow();
    document.getElementById('addLessonModal').classList.add('show');
}

function closeAddLesson() {
    document.getElementById('addLessonModal').classList.remove('show');
}

function addLessonRow() {
    lessonCount++;
    var n = lessonCount;
    var div = document.createElement('div');
    div.className = 'lesson-item';
    div.id = 'lessonItem_' + n;

    var removeBtnHtml = '';
    if (n > 1) {
        removeBtnHtml =
                '<button class="btn-remove-lesson" onclick="removeLessonRow(' + n + ')">' +
                '<i class="bi bi-x"></i> Xóa bài này' +
                '</button>';
    }

    div.innerHTML =
            '<div class="lesson-item-header">' +
            '<span class="lesson-item-num">Bài ' + n + '</span>' +
            removeBtnHtml +
            '</div>' +
            '<div class="l-form-group">' +
            '<label class="l-form-label">Tên bài học <span style="color:red;">*</span></label>' +
            '<input type="text"' +
            ' id="lessonTitle_' + n + '"' +
            ' class="l-form-input"' +
            ' placeholder="VD: Bài ' + n + ' - Tên bài học..."' +
            ' required>' +
            '</div>' +
            '<div class="l-form-group">' +
            '<label class="l-form-label">Video <span>(chọn 1 trong 2 cách)</span></label>' +
            '<div class="video-upload-wrap">' +
            '<div class="video-tabs">' +
            '<button class="video-tab active" id="tabUrl_' + n + '"' +
            ' onclick="switchTab(' + n + ', \'url\')" type="button">' +
            '<i class="bi bi-link-45deg"></i> Nhập URL' +
            '</button>' +
            '<button class="video-tab" id="tabFile_' + n + '"' +
            ' onclick="switchTab(' + n + ', \'file\')" type="button">' +
            '<i class="bi bi-cloud-upload"></i> Upload file' +
            '</button>' +
            '</div>' +
            '<div class="video-panel active" id="panelUrl_' + n + '">' +
            '<input type="text"' +
            ' id="videoUrl_' + n + '"' +
            ' class="l-form-input"' +
            ' placeholder="https://youtube.com/watch?v=... hoặc link video khác">' +
            '</div>' +
            '<div class="video-panel" id="panelFile_' + n + '">' +
            '<div class="upload-zone-sm"' +
            ' onclick="document.getElementById(\'videoFile_' + n + '\').click()">' +
            '<i class="bi bi-cloud-arrow-up-fill"></i>' +
            '<span>Kéo thả hoặc <span class="browse">chọn file video</span></span>' +
            '<div style="font-size:0.68rem;color:var(--muted);margin-top:4px;">MP4, MOV, AVI — tối đa 500MB</div>' +
            '</div>' +
            '<input type="file"' +
            ' id="videoFile_' + n + '"' +
            ' accept="video/*"' +
            ' style="display:none;"' +
            ' onchange="showFileName(' + n + ', this)">' +
            '<div class="upload-file-name" id="fileName_' + n + '">' +
            '<i class="bi bi-check-circle-fill"></i>' +
            '<span id="fileNameText_' + n + '"></span>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';

    document.getElementById('lessonList').appendChild(div);
}

function removeLessonRow(n) {
    var item = document.getElementById('lessonItem_' + n);
    if (item)
        item.remove();
}

function switchTab(n, mode) {
    document.getElementById('tabUrl_' + n).classList.toggle('active', mode === 'url');
    document.getElementById('tabFile_' + n).classList.toggle('active', mode === 'file');
    document.getElementById('panelUrl_' + n).classList.toggle('active', mode === 'url');
    document.getElementById('panelFile_' + n).classList.toggle('active', mode === 'file');
}

function showFileName(n, input) {
    if (input.files && input.files[0]) {
        document.getElementById('fileNameText_' + n).textContent = input.files[0].name;
        var fn = document.getElementById('fileName_' + n);
        fn.style.display = 'flex';
        fn.style.alignItems = 'center';
        fn.style.gap = '6px';
    }
}

// ── Submit tất cả bài học tuần tự ────────────────────────────
// Thay async/await bằng Promise chain đệ quy
function submitAllLessons() {
    var items = document.querySelectorAll('.lesson-item');
    if (items.length === 0) {
        alert('Vui lòng thêm ít nhất 1 bài học!');
        return;
    }

    var lessons = [];
    var valid = true;

    for (var i = 1; i <= lessonCount; i++) {
        var titleEl = document.getElementById('lessonTitle_' + i);
        if (!titleEl)
            continue; // đã bị xóa

        var title = titleEl.value.trim();
        if (!title) {
            alert('Vui lòng nhập tên bài ' + i + '!');
            titleEl.focus();
            valid = false;
            break;
        }

        var panelUrl = document.getElementById('panelUrl_' + i);
        var isUrl = panelUrl && panelUrl.classList.contains('active');
        var urlEl = document.getElementById('videoUrl_' + i);
        var fileEl = document.getElementById('videoFile_' + i);

        lessons.push({
            index: i,
            title: title,
            isUrl: isUrl,
            urlVal: (isUrl && urlEl) ? urlEl.value.trim() : '',
            fileEl: (!isUrl && fileEl) ? fileEl : null
        });
    }

    if (!valid)
        return;

    var successCount = 0;
    var contextPath = document.getElementById('contextPath').value;

    function submitNext(idx) {
        if (idx >= lessons.length) {
            closeAddLesson();
            alert('Đã thêm ' + successCount + '/' + lessons.length + ' bài học thành công!');
            window.location.reload();
            return;
        }

        var lesson = lessons[idx];
        var fd = new FormData();
        fd.append('action', 'addLesson');
        fd.append('courseId', currentCourseId);
        fd.append('lessonTitle', lesson.title);

        if (lesson.isUrl) {
            fd.append('videoUrl', lesson.urlVal);
        } else if (lesson.fileEl && lesson.fileEl.files[0]) {
            fd.append('videoFile', lesson.fileEl.files[0]);
            fd.append('videoUrl', '');
        } else {
            fd.append('videoUrl', '');
        }

        fetch(contextPath + '/instructorController', {method: 'POST', body: fd})
                .then(function () {
                    successCount++;
                    submitNext(idx + 1);
                })
                .catch(function (e) {
                    console.error('Lỗi thêm bài ' + lesson.index, e);
                    submitNext(idx + 1);
                });
    }

    submitNext(0);
}