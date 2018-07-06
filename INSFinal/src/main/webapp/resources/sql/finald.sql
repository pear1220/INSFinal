show user;

-- ������̺� ����
create table ins_member 
( userid       varchar2(20)  not null --ȸ��ID
, pwd          varchar2(50)  not null --��й�ȣ
, name         varchar2(50)  not null --�̸�
, nickname     varchar2(50)  not null --�г���
, email        varchar2(50)  not null --�̸���
, tel1         number        not null --��ȭ��ȣ1
, tel2         number        not null --��ȭ��ȣ2
, tel3         number        not null --��ȭ��ȣ3
, leave_status number default 0 not null --0:Ż��x 1:Ż��
, job          varchar2(20) not null --������
, birthday     date         not null --����
, profilejpg   varchar2(100) not null --�����ʻ��� 
, constraint PK_Member_userid primary key(userid)
);

alter table ins_member add(profilejpg varchar2(100) default 'memberprofile_basic.jsp'); --������̺� �����ʻ��� �÷� default�߰�
alter table ins_member add constraint CK_leave_status check(leave_status in(0,1)); --������̺� leave_status�÷� üũ���� �߰�

--2018.07.04 ����
alter table ins_member drop column tel1;
alter table ins_member drop column tel2;
alter table ins_member drop column tel3; --������̺��� ���� ��ȭ��ȣ �÷� ����
alter table ins_member add tel1 varchar2(5);
alter table ins_member add tel2 varchar2(5);
alter table ins_member add tel3 varchar2(5); --varchar2�� Ÿ�� �ٲ㼭 ��ȭ��ȣ �÷� �����

update ins_member set tel1=010, tel2=1234, tel3=5678;
alter table ins_member modify tel1 not null;
alter table ins_member modify tel2 not null;
alter table ins_member modify tel3 not null; --��ȭ��ȣ�÷��� not null�������� �߰�

desc ins_member;
--2018.07.02 ����
insert into ins_member(userid, pwd, name, nickname, email, tel1, tel2, tel3, leave_status, job, birthday, profilejpg, ins_personal_alarm)
values('ddcat', 'qwer1234$', '�������', '�е���', 'ddcat@gmail.com', 010, 1234, 5678, default, 'IT', to_date('20170101', 'yyyy-mm-dd'), default, default);
select * from ins_member;

commit;

select *
from ins_member
where userid = 'ddcat' and pwd = 'qwer1234$';

--�÷� �����ϱ�ڡ� alter table ���̺�� drop column �������÷���;�ڡ�
--�÷� �߰��ϱ�ڡ� alter table ���̺�� add �߰����÷��� ������Ÿ��; �ڡ�
alter table ins_personal_alarm drop column personal_alarm_setting_status; --���ξ˶� ���̺��� �˶�Ȯ�ο��÷� ����
alter table ins_member add ins_personal_alarm number default 0; --������̺� ���ξ˶�Ȯ�ο��÷� �߰�
alter table ins_member modify ins_personal_alarm not null;
alter table ins_member add constraint CK_personal_alarm check(ins_personal_alarm in(0,1)); --������̺� ���ξ˶�Ȯ�ο��÷� üũ�������� �߰�
desc ins_member;

--�ڡڡ� alter table ���̺�� drop constraint �������Ǹ�; �ڡڡ�
alter table ins_project_record drop constraint FK_recode_card_idx; --������̺� ī��idx�ܷ�Ű ����
alter table ins_project_record drop column FK_CARD_IDX;
alter table ins_project_record add fk_card_idx number;
desc ins_project_record;

alter table ins_project_record add record_dml_status number default 0; --������̺� dml���п� �÷� �߰� 
alter table ins_project_record add constraint CK_record_dml_status check(record_dml_status in(0,1,2)); --������̺�dml�÷��� üũ���� �߰�
alter table ins_project_record add fk_list_idx number; --������̺� ����Ʈidx�÷� �߰�
alter table ins_project_record modify fk_list_idx not null; --������̺� ����Ʈ�÷��� not null���� �߰�
alter table ins_project_record modify fk_card_idx not null;
alter table ins_project_record modify record_dml_status not null;

--�� ���̺� ����
create table ins_team
( team_idx               number           not null --������ seq_team
, admin_userid           varchar2(20)     not null --��������ID
, team_name              varchar2(25)     not null --����
, team_delete_status     number default 1 not null --0:������ 1:������(�⺻) 
, team_visibility_status number default 0 not null --0: private 1:public 
, team_image             varchar2(100) default 'basic.jsp' not null --���������̹���
, constraint PK_team_team_idx primary key(team_idx)
, constraint FK_team_admin_userid foreign key(admin_userid)
             references ins_member(userid)             
);
alter table ins_team add constraint CK_team_delete_status check(team_delete_status in(0,1)); --�����̺� team_delete_status�÷� üũ���� �߰�
alter table ins_team add constraint CK_team_visibility_status check(team_visibility_status in(0,1)); --�����̺� team_visibility_status�÷� üũ���� �߰�

select * from ins_team;
insert into ins_team(team_idx, admin_userid, team_name, team_delete_status, team_visibility_status, team_image)
values(seq_team.nextval, 'ddcat', 'ũ���������!', default, 0, default);
update ins_team set team_visibility_status = 1 where team_idx = 2;
commit;
--��idx�� ������ ����
create sequence seq_team
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--����� ���̺� ����
create table ins_team_member
( team_member_idx          number not null --������ seq_team_member
, fk_team_idx              number not null --����ȣ
, team_userid              varchar2(20) not null --�����ID
, team_member_admin_status number default 2 not null --0:�Ϲ����� 1:�ΰ����� 2:������ --üũ�������� �߰��ؾ���
, constraint PK_team_member_idx primary key(team_member_idx)
, constraint FK_fk_team_idx foreign key(fk_team_idx)
             references ins_team(team_idx)
); 
alter table ins_team_member add constraint CK_team_member_admin_status check(team_member_admin_status in(0,1,2)); --��������̺� team_member_admin_status�÷� üũ���� �߰�


--�����idx�� ������ ����
create sequence seq_team_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--QnAī�װ� ���̺� ����
create table ins_QnA_category
( qna_category_idx number       not null --������seq_qna_category
, qna_category     varchar2(20) not null --QnAī�װ�
, constraint PK_qna_category_idx primary key(qna_category_idx)
);

--QnA ���̺� ����
create table ins_QnA
( qna_idx             number        not null --������ seq_qna
, fk_userid           varchar2(20)  not null --QnA�ۼ���ID
, fk_qna_category_idx number        not null --ī�װ�idx
, qna_title           varchar2(100) not null --��������
, qna_content         CLOB not null          --���ǳ���
, qna_date            date default sysdate not null --�����ۼ���
, qna_fk_idx          number default 0 not null --���۹�ȣ
, qna_depthno         number default 0 not null --��ۿ���
, qna_groupno         number default 0 not null --�׷��ȣ
, qna_filename        varchar2(255)          --÷�����ϸ�
, qna_orgfilename     varchar2(255)          --÷�����Ͽ�����
, qna_byte            number                 --÷�����ϻ�����
, constraint PK_qna_idx primary key(qna_idx)
, constraint FK_fk_userid foreign key(fk_userid)
             references ins_member(userid)
);

--QnA idx�� ������ ����
create sequence seq_qna
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--������Ʈ ���̺� ����
create table ins_project
( project_idx             number       not null --������ seq_project
, fk_team_idx             number       not null --����ȣ
, project_name            varchar2(50) not null --������Ʈ��
, project_visibility_st   number default 0 not null --0:team 1:private 2:public
, project_delete_status   number default 1 not null --0:������Ʈ���� 1:������Ʈ���
, project_favorite_status number default 0 not null --0:���ã��x 1:���ã�⼳��
, constraint PK_ins_project_idx primary key(project_idx)
, constraint FK_project_team_idx foreign key(fk_team_idx)
             references ins_team(team_idx)
, constraint CK_project_visibility_st check(project_visibility_st in(0,1,2))
, constraint CK_project_delete_status check(project_delete_status in(0,1))
, constraint CK_project_favorite_status check(project_favorite_status in(0,1))
);

alter table ins_project add(project_profilejpg varchar2(100) default 'project_profilejpg_basic.jsp'); --������Ʈ���̺� ������Ʈ������ �÷� �߰�
select * from ins_project;

--������Ʈidx�� ������ ����
create sequence seq_project
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--������Ʈ��� ���̺� ����
create table ins_project_member
( project_member_idx          number       not null --������ seq_project_member
, fk_project_idx              number       not null --������Ʈ��ȣ
, project_member_userid       varchar2(20) not null --������Ʈ���ID
, project_member_status       number default 0 not null --0:Ż��x 1:Ż��
, project_member_admin_status number default 0 not null --0:�Ϲ����� 1:������Ʈ������
, constraint PK_project_member_idx primary key(project_member_idx)
, constraint FK_fk_project_idx foreign key(fk_project_idx)
             references ins_project(project_idx)
, constraint CK_project_member_status check(project_member_status in(0,1))
, constraint CK_project_member_admin_status check(project_member_admin_status in(0,1))
);

--������Ʈ���idx�� ������ ����
create sequence seq_project_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--����Ʈ ���̺� ����
create table ins_list
( list_idx           number       not null --������ seq_list
, fk_project_idx     number       not null --������Ʈ��ȣ
, list_name          varchar2(50) not null --����Ʈ��
, list_delete_status number default 1 not null --0:����Ʈ������ 1:����Ʈ���
, constraint PK_list_idx primary key(list_idx)
, constraint FK_list_project_idx foreign key(fk_project_idx)
             references ins_project(project_idx)             
, constraint CK_list_delete_status check(list_delete_status in(0,1))
);

--����Ʈidx�� ������ ����
create sequence seq_list
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--����Ʈ������ ���̺� ����
create table ins_archive
( archive_idx           number not null --������ seq_archive
, fk_list_idx           number not null --����Ʈ��ȣ
, archive_insert_time   date default sysdate not null --��������� �ð�
, archive_delete_status number default 0 not null  --����Ʈ��������
, constraint PK_archive_idx primary key(archive_idx)
, constraint FK_archive_list_idx foreign key(fk_list_idx)
             references ins_list(list_idx)
);              

--������idx�� ������
create sequence seq_archive
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--ī�� ���̺� ����
create table ins_card
( card_idx           number        not null --������ seq_card
, fk_list_idx        number        not null --����Ʈ��ȣ
, card_userid        varchar2(20)  not null --ī���ۼ�����ID
, card_title         varchar2(400) not null --ī������
, card_commentCount  number default 0 not null --ī���ۼ�
, card_date          date   default sysdate not null --ī���ۼ���
, card_delete_status number default 1 not null --0:ī����� 1:ī����
, constraint PK_card_idx primary key(card_idx)
, constraint FK_card_list_idx foreign key(fk_list_idx)
             references ins_list(list_idx)
, constraint CK_card_delete_status check(card_delete_status in(0,1))
);

--ī��idx �� ������ ����
create sequence seq_card
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--������Ʈ��� ���̺� ���� 
create table ins_project_record
( project_record_idx  number       not null --������ seq_project_record
, fk_project_idx      number       not null --������Ʈ��ȣ
, fk_card_idx         number       not null --ī���ȣ
, record_userid       varchar2(20) not null --����ID
, project_record_time date default sysdate not null --��Ͻð�
, constraint PK_project_record_idx primary key(project_record_idx)
, constraint FK_recode_project_idx foreign key(fk_project_idx)
             references ins_project(project_idx)
, constraint FK_recode_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx) 
);

--������Ʈ���idx �� ������ ����
create sequence seq_project_record
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--���ξ˶� ���̺� ����
create table ins_personal_alarm
( personal_alarm_idx            number not null --������ seq_personal_alarm
, fk_project_record_idx         number not null --������Ʈ ��Ϲ�ȣ
, personal_alarm_read_status    number default 0 not null --0: �������� 1:����
, personal_alarm_setting_status number default 0 not null --0:�˶�on 1:�˶�off
, constraint PK_personal_alarm_idx primary key(personal_alarm_idx)
, constraint FK_alarm_record_idx foreign key(fk_project_record_idx)
             references ins_project_record(project_record_idx)
, constraint CK_alarm_setting_status check(personal_alarm_setting_status in(0,1)) 
, constraint CK_alarm_read_status check(personal_alarm_read_status in(0,1)) 
);

--���ξ˶�idx �� ������ ����
create sequence seq_personal_alarm
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--ī���ڸ�Ʈ ���̺� ����
create table ins_card_comment
( card_comment_idx      number       not null --������ seq_card_comment
, fk_card_idx           number       not null --ī���ȣ
, fk_project_member_idx number       not null --������Ʈ�����ȣ
, card_comment_userid   varchar2(20) not null --�ڸ�Ʈ�ۼ�����ID
, card_comment_content  CLOB         not null --�ڸ�Ʈ ����
, card_comment_date     date default sysdate not null --�ڸ�Ʈ �ۼ��ð�
, constraint PK_card_comment_idx primary key(card_comment_idx)
, constraint FK_comment_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
, constraint FK_comment_project_member_idx foreign key(fk_project_member_idx)
             references ins_project_member(project_member_idx)  
);

--ī���ڸ�Ʈidx �� ������ ����
create sequence seq_card_comment
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--ī��� ���̺� ����
create table ins_card_detail
( card_detail_idx  number not null --������ seq_card_detail
, fk_card_idx      number not null --ī���ȣ
, card_description CLOB            --ī��󼼳���
, card_filename    varchar2(255)   --ī��÷�������̸�
, card_orgfilename varchar2(255)   --÷�����Ͽ����̸�
, card_byte number                 --÷������ ������
, constraint PK_card_detail_idx primary key(card_detail_idx)
, constraint FK_fk_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
);   

--ī���idx �� ������ ����
create sequence seq_card_detail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--ī��duedate ���̺� ����
create table ins_card_duedate
( card_duedate_idx number not null --������ seq_card_duedate
, fk_card_idx      number not null --ī���ȣ
, card_duedate     date   not null --������¥   
, constraint PK_card_duedate_idx primary key(card_duedate_idx)
, constraint FK_duedate_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
);             

--ī��duedate idx�� ������ ����
create sequence seq_card_duedate
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--ī��� ���̺� ����
create table ins_card_label
( card_label_idx number not null --������ seq_card_label
, fk_card_idx    number not null --ī���ȣ
, card_label     number not null --��(��ȣ�� ���򱸺�)
, constraint PK_card_lable_idx primary key(card_label_idx)
, constraint FK_label_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx) 
);             

--ī���idx�� ������ ����
create sequence seq_card_label
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--ī��üũ����Ʈ ���̺� ����
create table ins_card_checklist
( card_checklist_idx   number       not null --������ seq_card_checklist
, fk_card_idx          number       not null --ī���ȣ
, card_checklist_title varchar2(50) not null --üũ����Ʈ ����
, constraint PK_card_checklist_idx primary key(card_checklist_idx)
, constraint FK_checklist_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
);             

--ī��üũ����Ʈidx �� ������ ����
create sequence seq_card_checklist
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--ī��üũ����Ʈ�� ���̺� ����
create table ins_card_checklist_detail
( card_checklist_detail_idx  number        not null --������ seq_checklist_detail
, fk_card_checklist_idx      number        not null --üũ����Ʈ ��ȣ
, card_checklist_todo        varchar2(200) not null --üũ����Ʈ ����
, card_checklist_todo_status number default 0 not null --0:üũ�� 1:üũ
, constraint PK_card_checklist_detail_idx primary key(card_checklist_detail_idx)
, constraint FK_checklist_detail_idx foreign key(fk_card_checklist_idx)
             references ins_card_checklist(card_checklist_idx) on delete cascade
, constraint CK_checklist_todo_status check(card_checklist_todo_status in(0,1))
);

--ī��üũ����Ʈ��idx �� ������ ����
create sequence seq_checklist_detail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

SELECT * FROM tab;

--2018.07.03 ����

--������Ʈ ���� �̹������̺� ����
create table ins_project_image
( project_image_idx number not null --������ seq_project_image
, proect_image_name varchar2(200) not null
, constraint PK_project_image_idx primary key(project_image_idx)
);

alter table ins_project add(fk_project_image_idx number not null); ----������Ʈ ���̺� ����̹����÷� �߰�
alter table ins_project add constraint FK_project_image_idx foreign key(fk_project_image_idx)      
                                  references ins_project_image(project_image_idx); --����̹����÷� �ܷ�Ű ���� �߰�
                                  
 
 --������Ʈ ���� ������ ����
create sequence seq_project_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;