show user;



-- 멤버테이블 생성
create table ins_member 
( userid       varchar2(20)  not null --회원ID
, pwd          varchar2(50)  not null --비밀번호
, name         varchar2(50)  not null --이름
, nickname     varchar2(50)  not null --닉네임
, email        varchar2(50)  not null --이메일
, tel1         number        not null --전화번호1
, tel2         number        not null --전화번호2
, tel3         number        not null --전화번호3
, leave_status number default 0 not null --0:탈퇴x 1:탈퇴
, job          varchar2(20) not null --직업군
, birthday     date         not null --생일
, profilejpg   varchar2(100) not null --프로필사진 
, constraint PK_Member_userid primary key(userid)
);

alter table ins_member add(profilejpg varchar2(100) default 'memberprofile_basic.jsp'); --멤버테이블 프로필사진 컬럼 default추가
alter table ins_member add constraint CK_leave_status check(leave_status in(0,1)); --멤버테이블 leave_status컬럼 체크제약 추가

--2018.07.02 수정
insert into ins_member(userid, pwd, name, nickname, email, tel1, tel2, tel3, leave_status, job, birthday, profilejpg, ins_personal_alarm)
values('ddcat', 'qwer1234$', '디디고양이', '둔둔이', 'ddcat@gmail.com', 010, 1234, 5678, default, 'IT', to_date('20170101', 'yyyy-mm-dd'), default, default);




select * from ins_member;
commit;

-- 로그인한 유저의 개인정보 불러오기 
select userid, pwd, name, nickname, email, tel1, tel2, tel3, leave_status, job, , profilejpg, ins_personal_alarm
from ins_member
where userid = ''


select *
from ins_member
where userid = 'ddcat' and pwd = 'qwer1234$';

--컬럼 삭제하기★★ alter table 테이블명 drop column 삭제할컬럼명;★★
--컬럼 추가하기★★ alter table 테이블명 add 추가할컬럼명 데이터타입; ★★
alter table ins_personal_alarm drop column personal_alarm_setting_status; --개인알람 테이블에서 알람확인용컬럼 삭제
alter table ins_member add ins_personal_alarm number default 0; --멤버테이블에 개인알람확인용컬럼 추가
alter table ins_member modify ins_personal_alarm not null;
alter table ins_member add constraint CK_personal_alarm check(ins_personal_alarm in(0,1)); --멤버테이블에 개인알람확인용컬럼 체크제약조건 추가
desc ins_member;

--★★★ alter table 테이블명 drop constraint 제약조건명; ★★★
alter table ins_project_record drop constraint FK_recode_card_idx; --기록테이블에 카드idx외래키 삭제
alter table ins_project_record drop column FK_CARD_IDX;
alter table ins_project_record add fk_card_idx number;
desc ins_project_record;

alter table ins_project_record add record_dml_status number default 0; --기록테이블에 dml구분용 컬럼 추가 
alter table ins_project_record add constraint CK_record_dml_status check(record_dml_status in(0,1,2)); --기록테이블dml컬럼에 체크제약 추가
alter table ins_project_record add fk_list_idx number; --기록테이블에 리스트idx컬럼 추가
alter table ins_project_record modify fk_list_idx not null; --기록테이블 리스트컬럼에 not null조건 추가
alter table ins_project_record modify fk_card_idx not null;
alter table ins_project_record modify record_dml_status not null;

--팀 테이블 생성
create table ins_team
( team_idx               number           not null --시퀀스 seq_team
, admin_userid           varchar2(20)     not null --팀관리자ID
, team_name              varchar2(25)     not null --팀명
, team_delete_status     number default 1 not null --0:팀삭제 1:팀생성(기본) 
, team_visibility_status number default 0 not null --0: private 1:public 
, team_image             varchar2(100) default 'basic.jsp' not null --팀프로필이미지
, constraint PK_team_team_idx primary key(team_idx)
, constraint FK_team_admin_userid foreign key(admin_userid)
             references ins_member(userid)             
);
alter table ins_team add constraint CK_team_delete_status check(team_delete_status in(0,1)); --팀테이블 team_delete_status컬럼 체크제약 추가
alter table ins_team add constraint CK_team_visibility_status check(team_visibility_status in(0,1)); --팀테이블 team_visibility_status컬럼 체크제약 추가

select * from ins_team;
insert into ins_team(team_idx, admin_userid, team_name, team_delete_status, team_visibility_status, team_image)
values(seq_team.nextval, 'ddcat', '크림히어로즈!', default, 0, default);
update ins_team set team_visibility_status = 1 where team_idx = 2;
commit;
--팀idx용 시퀀스 생성
create sequence seq_team
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--팀멤버 테이블 생성
create table ins_team_member
( team_member_idx          number not null --시퀀스 seq_team_member
, fk_team_idx              number not null --팀번호
, team_userid              varchar2(20) not null --팀멤버ID
, team_member_admin_status number default 2 not null --0:일반유저 1:부관리자 2:관리자 --체크제약조건 추가해야함
, constraint PK_team_member_idx primary key(team_member_idx)
, constraint FK_fk_team_idx foreign key(fk_team_idx)
             references ins_team(team_idx)
); 
alter table ins_team_member add constraint CK_team_member_admin_status check(team_member_admin_status in(0,1,2)); --팀멤버테이블 team_member_admin_status컬럼 체크제약 추가


--팀멤버idx용 시퀀스 생성
create sequence seq_team_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--QnA카테고리 테이블 생성
create table ins_QnA_category
( qna_category_idx number       not null --시퀀스seq_qna_category
, qna_category     varchar2(20) not null --QnA카테고리
, constraint PK_qna_category_idx primary key(qna_category_idx)
);

--QnA카테고리 idx용 시퀀스 생성
create sequence seq_qna_category
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--QnA 테이블 생성
create table ins_QnA
( qna_idx             number        not null --시퀀스 seq_qna
, fk_userid           varchar2(20)  not null --QnA작성자ID
, fk_qna_category_idx number        not null --카테고리idx
, qna_title           varchar2(100) not null --문의제목
, qna_content         CLOB not null          --문의내용
, qna_date            date default sysdate not null --문의작성일
, qna_fk_idx          number default 0 not null --원글번호
, qna_depthno         number default 0 not null --답글여부
, qna_groupno         number default 0 not null --그룹번호
, qna_filename        varchar2(255)          --첨부파일명
, qna_orgfilename     varchar2(255)          --첨부파일원본명
, qna_byte            number                 --첨부파일사이즈
, constraint PK_qna_idx primary key(qna_idx)
, constraint FK_fk_userid foreign key(fk_userid)
             references ins_member(userid)
);

--QnA idx용 시퀀스 생성
create sequence seq_qna
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--프로젝트 테이블 생성
create table ins_project
( project_idx             number       not null --시퀀스 seq_project
, fk_team_idx             number       not null --팀번호
, project_name            varchar2(50) not null --프로젝트명
, project_visibility_st   number default 0 not null --0:team 1:private 2:public
, project_delete_status   number default 1 not null --0:프로젝트삭제 1:프로젝트사용
, project_favorite_status number default 0 not null --0:즐겨찾기x 1:즐겨찾기설정
, constraint PK_ins_project_idx primary key(project_idx)
, constraint FK_project_team_idx foreign key(fk_team_idx)
             references ins_team(team_idx)
, constraint CK_project_visibility_st check(project_visibility_st in(0,1,2))
, constraint CK_project_delete_status check(project_delete_status in(0,1))
, constraint CK_project_favorite_status check(project_favorite_status in(0,1))
);

alter table ins_project add(project_profilejpg varchar2(100) default 'project_profilejpg_basic.jsp'); --프로젝트테이블에 프로젝트배경사진 컬럼 추가
select * from ins_project;

--프로젝트idx용 시퀀스 생성
create sequence seq_project
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--프로젝트멤버 테이블 생성
create table ins_project_member
( project_member_idx          number       not null --시퀀스 seq_project_member
, fk_project_idx              number       not null --프로젝트번호
, project_member_userid       varchar2(20) not null --프로젝트멤버ID
, project_member_status       number default 0 not null --0:탈퇴x 1:탈퇴
, project_member_admin_status number default 0 not null --0:일반유저 1:프로젝트관리자
, constraint PK_project_member_idx primary key(project_member_idx)
, constraint FK_fk_project_idx foreign key(fk_project_idx)
             references ins_project(project_idx)
, constraint CK_project_member_status check(project_member_status in(0,1))
, constraint CK_project_member_admin_status check(project_member_admin_status in(0,1))
);

--프로젝트멤버idx용 시퀀스 생성
create sequence seq_project_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--리스트 테이블 생성
create table ins_list
( list_idx           number       not null --시퀀스 seq_list
, fk_project_idx     number       not null --프로젝트번호
, list_name          varchar2(50) not null --리스트명
, list_delete_status number default 1 not null --0:리스트휴지통 1:리스트사용
, constraint PK_list_idx primary key(list_idx)
, constraint FK_list_project_idx foreign key(fk_project_idx)
             references ins_project(project_idx)             
, constraint CK_list_delete_status check(list_delete_status in(0,1))
);

--리스트idx용 시퀀스 생성
create sequence seq_list
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--리스트휴지통 테이블 생성
create table ins_archive
( archive_idx           number not null --시퀀스 seq_archive
, fk_list_idx           number not null --리스트번호
, archive_insert_time   date default sysdate not null --휴지통들어온 시간
, archive_delete_status number default 0 not null  --리스트삭제여부
, constraint PK_archive_idx primary key(archive_idx)
, constraint FK_archive_list_idx foreign key(fk_list_idx)
             references ins_list(list_idx)
);              

--휴지통idx용 시퀀스
create sequence seq_archive
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--카드 테이블 생성
create table ins_card
( card_idx           number        not null --시퀀스 seq_card
, fk_list_idx        number        not null --리스트번호
, card_userid        varchar2(20)  not null --카드작성유저ID
, card_title         varchar2(400) not null --카드제목
, card_commentCount  number default 0 not null --카드댓글수
, card_date          date   default sysdate not null --카드작성일
, card_delete_status number default 1 not null --0:카드삭제 1:카드사용
, constraint PK_card_idx primary key(card_idx)
, constraint FK_card_list_idx foreign key(fk_list_idx)
             references ins_list(list_idx)
, constraint CK_card_delete_status check(card_delete_status in(0,1))
);

--카드idx 용 시퀀스 생성
create sequence seq_card
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--프로젝트기록 테이블 생성 
create table ins_project_record
( project_record_idx  number       not null --시퀀스 seq_project_record
, fk_project_idx      number       not null --프로젝트번호
, fk_card_idx         number       not null --카드번호
, record_userid       varchar2(20) not null --유저ID
, project_record_time date default sysdate not null --기록시간
, constraint PK_project_record_idx primary key(project_record_idx)
, constraint FK_recode_project_idx foreign key(fk_project_idx)
             references ins_project(project_idx)
, constraint FK_recode_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx) 
);

--프로젝트기록idx 용 시퀀스 생성
create sequence seq_project_record
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--개인알람 테이블 생성
create table ins_personal_alarm
( personal_alarm_idx            number not null --시퀀스 seq_personal_alarm
, fk_project_record_idx         number not null --프로젝트 기록번호
, personal_alarm_read_status    number default 0 not null --0: 읽지않음 1:읽음
, personal_alarm_setting_status number default 0 not null --0:알람on 1:알람off
, constraint PK_personal_alarm_idx primary key(personal_alarm_idx)
, constraint FK_alarm_record_idx foreign key(fk_project_record_idx)
             references ins_project_record(project_record_idx)
, constraint CK_alarm_setting_status check(personal_alarm_setting_status in(0,1)) 
, constraint CK_alarm_read_status check(personal_alarm_read_status in(0,1)) 
);

--개인알람idx 용 시퀀스 생성
create sequence seq_personal_alarm
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--카드코멘트 테이블 생성
create table ins_card_comment
( card_comment_idx      number       not null --시퀀스 seq_card_comment
, fk_card_idx           number       not null --카드번호
, fk_project_member_idx number       not null --프로젝트멤버번호
, card_comment_userid   varchar2(20) not null --코멘트작성유저ID
, card_comment_content  CLOB         not null --코멘트 내용
, card_comment_date     date default sysdate not null --코멘트 작성시간
, constraint PK_card_comment_idx primary key(card_comment_idx)
, constraint FK_comment_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
, constraint FK_comment_project_member_idx foreign key(fk_project_member_idx)
             references ins_project_member(project_member_idx)  
);

--카드코멘트idx 용 시퀀스 생성
create sequence seq_card_comment
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--카드상세 테이블 생성
create table ins_card_detail
( card_detail_idx  number not null --시퀀스 seq_card_detail
, fk_card_idx      number not null --카드번호
, card_description CLOB            --카드상세내용
, card_filename    varchar2(255)   --카드첨부파일이름
, card_orgfilename varchar2(255)   --첨부파일원본이름
, card_byte number                 --첨부파일 사이즈
, constraint PK_card_detail_idx primary key(card_detail_idx)
, constraint FK_fk_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
);   

--카드상세idx 용 시퀀스 생성
create sequence seq_card_detail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--카드duedate 테이블 생성
create table ins_card_duedate
( card_duedate_idx number not null --시퀀스 seq_card_duedate
, fk_card_idx      number not null --카드번호
, card_duedate     date   not null --지정날짜   
, constraint PK_card_duedate_idx primary key(card_duedate_idx)
, constraint FK_duedate_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
);             

--카드duedate idx용 시퀀스 생성
create sequence seq_card_duedate
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--카드라벨 테이블 생성
create table ins_card_label
( card_label_idx number not null --시퀀스 seq_card_label
, fk_card_idx    number not null --카드번호
, card_label     number not null --라벨(번호로 색깔구분)
, constraint PK_card_lable_idx primary key(card_label_idx)
, constraint FK_label_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx) 
);             

--카드라벨idx용 시퀀스 생성
create sequence seq_card_label
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--카드체크리스트 테이블 생성
create table ins_card_checklist
( card_checklist_idx   number       not null --시퀀스 seq_card_checklist
, fk_card_idx          number       not null --카드번호
, card_checklist_title varchar2(50) not null --체크리스트 제목
, constraint PK_card_checklist_idx primary key(card_checklist_idx)
, constraint FK_checklist_card_idx foreign key(fk_card_idx)
             references ins_card(card_idx)
);             

--카드체크리스트idx 용 시퀀스 생성
create sequence seq_card_checklist
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

--카드체크리스트상세 테이블 생성
create table ins_card_checklist_detail
( card_checklist_detail_idx  number        not null --시퀀스 seq_checklist_detail
, fk_card_checklist_idx      number        not null --체크리스트 번호
, card_checklist_todo        varchar2(200) not null --체크리스트 할일
, card_checklist_todo_status number default 0 not null --0:체크전 1:체크
, constraint PK_card_checklist_detail_idx primary key(card_checklist_detail_idx)
, constraint FK_checklist_detail_idx foreign key(fk_card_checklist_idx)
             references ins_card_checklist(card_checklist_idx) on delete cascade
, constraint CK_checklist_todo_status check(card_checklist_todo_status in(0,1))
);

--카드체크리스트상세idx 용 시퀀스 생성
create sequence seq_checklist_detail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

SELECT * FROM tab;

--2018.07.03 수정

--프로젝트 배경용 이미지테이블 생성
create table ins_project_image
( project_image_idx number not null --시퀀스 seq_project_image
, proect_image_name varchar2(200) not null
, constraint PK_project_image_idx primary key(project_image_idx)
);

alter table ins_project add(fk_project_image_idx number not null); ----프로젝트 테이블에 배경이미지컬럼 추가
alter table ins_project add constraint FK_project_image_idx foreign key(fk_project_image_idx)      
                                  references ins_project_image(project_image_idx); --배경이미지컬럼 외래키 제약 추가
                                  
                                  
select *                                                     
from ins_member


----------------------------------------------------------------------------------
               안지혜  SQL문 시작
-----------------------------------------------------------------------------------

-- 안지혜 생성
insert into ins_member(userid, pwd, name, nickname, email, tel1, tel2, tel3, leave_status, job, birthday, profilejpg, ins_personal_alarm)
values('jihye', 'qwer1234$', '안지혜', '지혜', 'jihye86@gmail.com', 010, 5640, 6983, default, 'IT', to_date('19860301', 'yyyy-mm-dd'), default, default);


-- 개인정보 업데이트
update ins_member set pwd='asdf1234$', nickname='lg그램', tel1='010',tel2='1111', tel3='1111',job='기타'
where userid = 'jihye'

select *
from ins_member
where userid = 'jihye'

commit;

-- 회원 탈퇴여부에 따른 페이지 접근 확인을 위해 leave_status값 업데이트하기
update ins_member set leave_status = 0
where userid = 'jihye';

commit;

-- qna 테이블 삭제했다 다시 생성하기
drop sequence seq_qna_category;
drop table ins_QnA_category purge;


drop sequence seq_qna;
drop table ins_QnA purge;

-- qna 게시판을 위해 데이터 생성
-- qna 카테고리 데이터 생성
insert into ins_QnA_category(qna_category_idx,qna_category)
values(seq_qna_category.nextval, '문의');

insert into ins_QnA_category(qna_category_idx,qna_category)
values(seq_qna_category.nextval, '기타');

commit;

-- qna  글 목록
insert into ins_QnA(qna_idx, fk_userid, fk_qna_category_idx, qna_title, qna_content, qna_date, qna_fk_idx, qna_depthno,  qna_filename, qna_orgfilename, qna_byte)
values(seq_qna.nextval, 'jihye', 1, 'qna 테스트입니다.', 'qna 테스트 내용물입니다.' , default, seq_qna.nextval, default, default, default, 0 );

select *
from ins_QnA_category

select *
from ins_QnA

commit;

-- qna 목록 불러오기
select qna_idx, fk_userid, fk_qna_category_idx, qna_title, qna_content, qna_date, qna_fk_idx, qna_depthno,  qna_filename, qna_orgfilename, qna_byte
from ins_QnA
where fk_userid = 'jihye';









