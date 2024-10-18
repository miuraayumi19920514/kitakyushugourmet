document.addEventListener('DOMContentLoaded', function() {
  var reviewFilter = document.getElementById('review_filter');
  if (reviewFilter != null){
  reviewFilter.addEventListener('change', function() {
    var selectedValue = this.value;
    var reviewRows = document.querySelectorAll('.poster');
    reviewRows.forEach(function(row) {
      if (selectedValue == '地元民' && row.textContent.trim() !== '地元民') {
        row.closest('tr').style.display = 'none';
      } else if (selectedValue == '旅行者' && row.textContent.trim() !== '旅行者') {
        row.closest('tr').style.display = 'none';
      } else {
        row.closest('tr').style.display = 'table-row';
      }
    });
  });
  }
});