$(document).ready(function () {

  go_page(1);

  $("input:submit").click(function (e) {
    var length = $('input[name=length]').val(); //문제 길이
    var empty_check = {};
    for (let i = 0; i < length; i++) {
      empty_check[i + 1] = $(`input[name=radio${i + 1}]:checked`).val(); //체크된 보기 번호
    }
    for (key in empty_check) {
      if (!empty_check[key]) {
        alert('답을 체크하세요.');
        e.preventDefault();
        return;
      } else {
        $("form").attr("action", "/-");
      }
    }
  })

  $(".filter .quiz-filter").on("change", function (e) {
    let params = (new URL(document.location)).searchParams;
    let currentPage = parseInt(params.get('page')) || 1;
    go_page(currentPage);
  })
})
  function go_page(pageNum) {
    let limit = $(".filter .quiz-filter").val();
    window.ajax.request(
        `${window.location.pathname}/list?page=${pageNum}&perPageNum=${limit}`,
        {}, success)
  }

  function clickAnswerButton(event, index, answer_data) {
    // let index = $(event.currentTarget).attr("id").split('-')[1];
    // let userChoice = $(`input[name=radio${index}]:checked`).val();
    // let answer = list[index].answer;
    // let isRight = userChoice == answer ? 1 :0;
    // let str = isRight ? "정답입니다" : "틀렸습니다";

    // let index = $(event.currentTarget).attr("id").split('-')[1];
    answer_data = answer_data;
    let userChoice = $(`input[name=radio${index}]:checked`).val();
    // let answer = list[index].answer;
    let isRight = userChoice == answer_data.answer ? 1 :0;
    let str = isRight ? "정답입니다" : "틀렸습니다";

    if (userChoice) {
      $(`#${index} tbody .answer-check`).html(`
      <tr><td><div>
	      	  <br><b>정답: ${answer_data.answer }</b><br>
	      		<br><b>내가 입력한 답: ${userChoice}</b><br>
            ${str}<br>
            ${answer_data.commentary}
	    </div></td></tr> 
    `)
    }

    window.ajax.request('/quiz/wrong/answer/1',{
      "type" : "PUT",
      "data" : {
        "userChoice": userChoice,
        "isRight" : isRight,
        "userSeq" :answer_data.userSeq,
        "quizSeq" :answer_data.quizSeq
      }
    },()=>{},(error)=>{alert(error.responseJSON.errorMessage);})
  }

  let success = (result) => {
    let list = result.quizList;
    let answer = {};
    let detail = {};
    $("#quizForm").html("");
    for (let i = 0; i < list.length; i++) {
      // answer[i] = list[i].answer;
      // detail[i] = list[i].detail;
      $("#quizForm").append(`
            <input type="hidden" value="${result.userSeq}" name="userSeq">
            <table id="${i}">
              <tr id="quizListTbl">
                 <td id="num"><br><br><br>
                 <div class="badge bg-secondary text-decoration-none link-light">선택한 답: ${list[i].userChoice}</div>  
                 <br><br> Q. ${list[i].quizSeq}번<br>
                      <br>${list[i].question}<br><br>       
                 </td>
              </tr>
            </table>`)
      // 보기화면
      $("#" + i + " tbody").append(`
            <tr>
                <td><input type="radio" value="1" id="radio1"
                            name="radio${i}" class="radio"> 1. ${list[i].choice1}</td>
            </tr>
            <tr>
                <td><input type="radio" value="2" id="radio2"
                            name="radio${i}" class="radio"> 2. ${list[i].choice2}</td>
            </tr>`)
      if (list[i].choice3 != '') {
        $("#" + i + " tbody").append(`
                <tr>
                    <td><input type="radio" value="3" id="radio3"
                               name="radio${i}" class="radio"> 3. ${list[i].choice3}
                    </td>
                </tr>`)
      }
      if (list[i].choice4 != '') {
        $("#" + i + " tbody").append(`
              <tr>
                <td><input type="radio" value="4" id="radio4"
                       name="radio${i}" class="radio"> 4. ${list[i].choice4}
                </td>
            </tr>`)
      }
      let str = JSON.stringify(list[i]);
      $("#" + i + " tbody").append(`
            <tr>
              <td><input type="button" class="checkAnswer" id="answer-${i}" onclick='clickAnswerButton(event, ${i}, ${str})' value="정답 확인"></td>
            </tr>
            
            <tr class='answer-check'></tr>
      `)
    }
    pageSetting(result);
  }

  let pageSetting = (result) => {
    let paging = result.paging;
    let maxPage = result.maxPage;
    let pagingTag = `
            <nav aria-label="Page navigation example" style="margin: 10px;">
              <ul class="pagination justify-content-center">
                <li class="page-item"><div onclick="go_page(1); return false;" class="page-link">처음</div></li>`

    if(paging.prev)
      pagingTag += `<li class="page-item"><div onclick="go_page(${paging.startPage-1})" class="page-link">이전</div></li>`

    for(let i = paging.startPage; i<= paging.endPage; i++)
    {
      pagingTag +=`<li class="page-item" style="pagination-bg: #91ACCC"><span><div onclick="go_page(${i})" class="page-link">${i}</div></span></li>`
    }

    if(paging.next)
      pagingTag += `<li class="page-item"><div onclick="go_page(${paging.endPage+1})" class="page-link">다음</div></li>`

    pagingTag += `<li class="page-item"><div onclick="go_page(${maxPage})" class="page-link">끝</div></li></ul></nav>`

    $('.paging').html(pagingTag);
  }
