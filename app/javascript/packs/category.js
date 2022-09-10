$(function() {
  $("#large_category").change( function(e) {
    e.preventDefault();  // デフォルトのイベント(HTMLデータ送信など)を無効にする
    let large_category_id = $("#large_category").val();  // 大カテゴリの選択されたidを取得
    $.ajax({
      url: '/get_item_category',  // リクエストを送信するURLを指定
      type: "GET",  // HTTPメソッドを指定
      data: {  // 送信するデータをハッシュ形式で指定
        large_category_id: large_category_id
      },
      dataType: "json"  // レスポンスデータをjson形式と指定する
    })
    .done(function(data) {
      $("#item_category").empty()
      data.forEach(function(category){
        let op = document.createElement('option');
    		op.value = category.id
    		op.textContent = category.name
    		$("#item_category").append(op);
      })
    })
    .fail(function() {
      alert("通信エラーが発生しましたので大カテゴリーを選び直してください");  // 通信に失敗した場合はアラートを表示
    })
  });
});
