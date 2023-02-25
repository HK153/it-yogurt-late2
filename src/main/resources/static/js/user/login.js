$(document).ready(function () {

  $(".sign_up").on("click", function () {
    window.document.location.href = "/user/1"
  })

  $(".sns_login_btn").on("click", function () {
    let ouathType = $(this).attr("id");
    window.document.location.href = `/auth/${ouathType}`
  })

  $("#login_form").on("submit", function (event) {
    event.preventDefault();

    let result;

    $('#login_form input:not([type=image],[type=button],[type=submit], [type=checkbox])')
    .each(
        function (index) {
          let target = $(this);
          result = window.util.emptyAlert(target);
          if (result != "") {
            return false;
          }
        });

    if (result != "") {
      alert(result);
      return;
    }

    let params = (new URL(document.location)).searchParams;
    let knowSeq = params.get('knowSeq');

    let fd = new FormData($('#login_form')[0]);
    if (knowSeq != null) {
      fd.append("knowSeq", knowSeq);
    }

    // 로그인 요청
    window.ajax.sendForm("/user", fd,
        loginSuceess, loginError)
  })
});

loginSuceess = (result) => {
  alert("로그인 되었습니다.");
  window.location.href = result;
}
loginError = (request) => {
  let str = request.responseJSON.errorMessage ? request.responseJSON.errorMessage
      : "요청을 처리하던 중 에러가 발생했습니다."
  alert(str);
}