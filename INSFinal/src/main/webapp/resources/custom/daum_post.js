
function execDaumPostcode() { // ���� �ּ� API
    new daum.Postcode({
        oncomplete: function (data) {
            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

            // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
            // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
            var fullAddr = ''; // ���� �ּ� ����
            var extraAddr = ''; // ������ �ּ� ����

            // ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
            if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                fullAddr = data.roadAddress;

            } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                fullAddr = data.jibunAddress;
            }

            // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
            if (data.userSelectedType === 'R') {
                //���������� ���� ��� �߰��Ѵ�.
                if (data.bname !== '') {
                    extraAddr += data.bname;
                }
                // �ǹ����� ���� ��� �߰��Ѵ�.
                if (data.buildingName !== '') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
                fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
            }

            // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
            document.getElementById('postcode').value = data.zonecode; //5�ڸ� �������ȣ ���
            document.getElementById('address1').value = fullAddr;

            // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
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
               for�������� continue; �� ������ ����� �ϴ°��� 
               each(); �������� return true; �̰�,
               for�������� break; �� ������ ����� �ϴ°��� 
               each(); �������� return false; �̴�.
            */
        }
    });

    if (flagBool) {
        alert("�ʼ��Է¶��� ��� �Է��ϼž� �մϴ�.");
        event.preventDefault(); // click event �� �۵�ġ ���ϵ��� �Ѵ�.
        return;
    }
    else if (!$("#agree").is(":checked")) {
        /* $("#agree").is(":checked") �� 
           $("#agree") �� üũ�� �Ǿ����� true,
           $("#agree") �� üũ�� �ȵǾ����� false �� ��Ÿ����. 
        */
        alert("�̿����� �����ϼž� �մϴ�.");
        event.preventDefault(); // click event �� �۵�ġ ���ϵ��� �Ѵ�.
        return;
    }
    else {
        var frm = document.registerFrm;
        frm.method = "post";
        frm.action = "memberRegisterEnd.do";
        frm.submit();
    }

}// end of goRegister(event)------------------
