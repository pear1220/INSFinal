
function execDaumPostcode() { // 다음 주소 API
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if (data.userSelectedType === 'R') {
                //법정동명이 있을 경우 추가한다.
                if (data.bname !== '') {
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if (data.buildingName !== '') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('address1').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('address2').focus();
        }
    }).open();

}// end of  function execDaumPostcode()------------------------------------

function goRegister(event) {

    var flagBool = false;

    $(".requiredInfo").each(function () {
        var data = $(this).val().trim();
        if (data == "") {
            flagBool = true;
            return false;
            /*
               for문에서의 continue; 와 동일한 기능을 하는것이 
               each(); 내에서는 return true; 이고,
               for문에서의 break; 와 동일한 기능을 하는것이 
               each(); 내에서는 return false; 이다.
            */
        }
    });

    if (flagBool) {
        alert("필수입력란은 모두 입력하셔야 합니다.");
        event.preventDefault(); // click event 를 작동치 못하도록 한다.
        return;
    }
    else if (!$("#agree").is(":checked")) {
        /* $("#agree").is(":checked") 은 
           $("#agree") 이 체크가 되었으면 true,
           $("#agree") 이 체크가 안되었으면 false 를 나타낸다. 
        */
        alert("이용약관에 동의하셔야 합니다.");
        event.preventDefault(); // click event 를 작동치 못하도록 한다.
        return;
    }
    else {
        var frm = document.registerFrm;
        frm.method = "post";
        frm.action = "memberRegisterEnd.do";
        frm.submit();
    }

}// end of goRegister(event)------------------
