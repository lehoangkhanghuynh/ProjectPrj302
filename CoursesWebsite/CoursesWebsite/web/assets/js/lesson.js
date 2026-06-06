/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


            /* ===== FILE UPLOAD ===== */
            function onFileChange(input) {
                var label = document.getElementById('fileLabelText');
                if (input.files && input.files[0]) {
                    label.textContent = input.files[0].name +
                        ' (' + (input.files[0].size / 1024 / 1024).toFixed(1) + ' MB)';
                }
            }

            /* ===== REVIEW EDIT ===== */
            function showEditForm() {
                document.getElementById('myReviewBlock').style.display = 'none';
                document.getElementById('editReviewForm').style.display = 'block';
            }
            function hideEditForm() {
                document.getElementById('editReviewForm').style.display = 'none';
                document.getElementById('myReviewBlock').style.display = 'block';
            }

            /* ===== COMMENT INLINE EDIT ===== */
            function showCmEdit(id) {
                document.getElementById('cmText_' + id).style.display = 'none';
                document.getElementById('cmEditForm_' + id).style.display = 'block';
                // Focus vào textarea
                var ta = document.getElementById('cmEditTA_' + id);
                if (ta) { ta.focus(); ta.setSelectionRange(ta.value.length, ta.value.length); }
            }
            function hideCmEdit(id) {
                document.getElementById('cmEditForm_' + id).style.display = 'none';
                document.getElementById('cmText_' + id).style.display = 'block';
            }

            /* ===== AUTOPLAY VIDEO ===== */
            window.addEventListener('load', function () {
                var video = document.getElementById('lessonVideo');
                if (!video) return;
                var playPromise = video.play();
                if (playPromise !== undefined) {
                    playPromise.catch(function () {
                        document.addEventListener('click', function () {
                            video.play();
                        }, { once: true });
                    });
                }
            });