/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// ── IMAGE PREVIEW ──
function previewImage(input) {
    if (!input.files || !input.files[0])
        return;
    const file = input.files[0];
    if (file.size > 2 * 1024 * 1024) {
        alert('Ảnh quá lớn! Vui lòng chọn ảnh dưới 2MB.');
        input.value = '';
        return;
    }
    const reader = new FileReader();
    reader.onload = function (e) {
        showPreview(e.target.result);
        document.getElementById('thumbnailUrl').value = '';
    };
    reader.readAsDataURL(file);
}

function previewFromUrl(url) {
    if (url.trim() !== '') {
        showPreview(url);
        document.getElementById('thumbnailFile').value = '';
    } else {
        resetPreview();
    }
}

function showPreview(src) {
    const img = document.getElementById('previewImg');
    const placeholder = document.getElementById('uploadPlaceholder');
    img.src = src;
    img.style.display = 'block';
    placeholder.style.display = 'none';
}

function resetPreview() {
    const img = document.getElementById('previewImg');
    const placeholder = document.getElementById('uploadPlaceholder');
    img.src = '';
    img.style.display = 'none';
    placeholder.style.display = 'block';
    document.getElementById('thumbnailFile').value = '';
    document.getElementById('thumbnailUrl').value = '';
}

// Drag & drop
const zone = document.getElementById('uploadZone');
zone.addEventListener('dragover', e => {
    e.preventDefault();
    zone.classList.add('drag-over');
});
zone.addEventListener('dragleave', () => zone.classList.remove('drag-over'));
zone.addEventListener('drop', e => {
    e.preventDefault();
    zone.classList.remove('drag-over');
    const file = e.dataTransfer.files[0];
    if (file && file.type.startsWith('image/')) {
        const dt = new DataTransfer();
        dt.items.add(file);
        document.getElementById('thumbnailFile').files = dt.files;
        previewImage(document.getElementById('thumbnailFile'));
    }
});
// Fee toggle
function setFree() {
    document.getElementById('optFree').classList.add('selected');
    document.getElementById('optPaid').classList.remove('selected');
    document.getElementById('feeInputWrap').classList.remove('show');
    document.getElementById('feeInput').removeAttribute('required');
    document.getElementById('feeInput').value = '';
    document.getElementById('feeHidden').value = '0';
}
function setPaid() {
    document.getElementById('optPaid').classList.add('selected');
    document.getElementById('optFree').classList.remove('selected');
    document.getElementById('feeInputWrap').classList.add('show');
    document.getElementById('feeInput').setAttribute('required', 'required');
    document.getElementById('feeHidden').value = '';
}

// Sync fee value on submit
document.getElementById('createForm').addEventListener('submit', function () {
    const feeWrap = document.getElementById('feeInputWrap');
    if (!feeWrap.classList.contains('show')) {
        document.getElementById('feeInput').value = '0';
    }
});