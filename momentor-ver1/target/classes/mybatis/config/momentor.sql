DROP TABLE RECOMMEND_INFO;
DROP TABLE EXERCISE_CART;
DROP TABLE EXERCISE_PLANNER;
DROP TABLE MEMBER_IMG;
DROP TABLE MEMBER_REPLY;
DROP TABLE MEMBER_BOARD;
DROP TABLE EXERCISE_IMG;
DROP TABLE EXERCISE_BOARD;
DROP TABLE NOTICE_BOARD;
DROP TABLE MOMEMTOR_MEMBER_PHYSICAL;
DROP TABLE EXERCISE;
DROP TABLE MOMENTOR_MEMBER;

DROP SEQUENCE NOTICE_SEQ;
DROP SEQUENCE EXERCISE_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE REPLY_SEQ;
select * from MOMEMTOR_MEMBER_PHYSICAL
select * from MOMENTOR_MEMBER;
delete from MOMENTOR_MEMBER;
delete from MEMBER_BOARD
--운동
CREATE TABLE EXERCISE(
EXERCISENAME VARCHAR2(100) PRIMARY KEY,
EXERCISEBODY VARCHAR2(100) NOT NULL

);







select EXERCISENAME, EXERCISEBODY from EXERCISE;
insert into EXERCISE(EXERCISENAME, EXERCISEBODY)
values('윗몸일으키기', '상체');
insert into EXERCISE(EXERCISENAME, EXERCISEBODY)
values('팔굽혀펴기', '상체');
insert into EXERCISE(EXERCISENAME, EXERCISEBODY)
values('스쿼트', '하체');

--멤버
CREATE TABLE MOMENTOR_MEMBER(
MEMBERID VARCHAR2(100) PRIMARY KEY,
MEMBERPASSWORD VARCHAR2(100) NOT NULL,
MEMBERNAME VARCHAR2(100) NOT NULL,
BIRTHYEAR NUMBER NOT NULL,
BIRTHMONTH NUMBER NOT NULL,
BIRTHDAY NUMBER NOT NULL,
NICKNAME VARCHAR2(200) NOT NULL,
MEMBEREMAIL VARCHAR2(200) NOT NULL,
GENDER VARCHAR2(20) NOT NULL, 
MEMBERADDRESS VARCHAR2(1000) NOT NULL,
AUTH NUMBER DEFAULT 2  NOT NULL -- 1일때 관리자 2일때 일반유저
);

select * from MOMENTOR_MEMBER;

--멤버 신체 정보
CREATE TABLE MOMEMTOR_MEMBER_PHYSICAL(
MEMBERWEIGHT NUMBER NOT NULL,
MEMBERHEIGHT NUMBER NOT NULL,
AGE NUMBER NOT NULL,
BMI NUMBER NOT NULL,
MEMBERID VARCHAR2(100) PRIMARY KEY,
CONSTRAINT FK_ID_M_P FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)
);

select * from MOMEMTOR_MEMBER_PHYSICAL;

--관리자 공지사항 게시판 
CREATE TABLE NOTICE_BOARD(
NOTICE_NO NUMBER PRIMARY KEY,
MEMBERID VARCHAR2(100) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
NOTICE_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
CONSTRAINT FK_ID_M_NB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)
);

--공지사항 시퀀스
CREATE SEQUENCE NOTICE_SEQ NOCACHE;


--관리자 운동 게시판
CREATE TABLE EXERCISE_BOARD(
EXERCISENAME VARCHAR2(100) PRIMARY KEY,
EXERCISE_NO NUMBER NOT NULL,
MEMBERID VARCHAR2(100) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
EXERCISE_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
EXERCISE_HITS NUMBER DEFAULT 0,
CONSTRAINT FK_ID_M_EB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_ID_E_EB FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE(EXERCISENAME)

);

--관리자 운동 시퀀스
CREATE SEQUENCE EXERCISE_SEQ NOCACHE;

select EXERCISENAME, EXERCISE_NO, MEMBERID, TITLE, EXERCISE_DATE, CONTENT, EXERCISE_HITS from EXERCISE_BOARD;
insert into EXERCISE_BOARD(EXERCISENAME, EXERCISE_NO, MEMBERID, TITLE, EXERCISE_DATE, CONTENT)
values('윗몸일으키기', EXERCISE_SEQ.nextval, 'java', '윗몸일으키기의 정석', sysdate, '헛둘헛둘');
insert into EXERCISE_BOARD(EXERCISENAME, EXERCISE_NO, MEMBERID, TITLE, EXERCISE_DATE, CONTENT)
values('팔굽혀펴기', EXERCISE_SEQ.nextval, 'java', '팔굽혀펴기의 정석', sysdate, '헛둘셋넷');
insert into EXERCISE_BOARD(EXERCISENAME, EXERCISE_NO, MEMBERID, TITLE, EXERCISE_DATE, CONTENT)
values('스쿼트', EXERCISE_SEQ.nextval, 'java', '스쿼트의 정석', sysdate, '둘둘셋넷');



--관리자 운동 게시판 이미지
CREATE TABLE EXERCISE_IMG(
EXERCISENAME VARCHAR2(100) NOT NULL,
IMGNAME VARCHAR2(300) NOT NULL,
IMGPATH VARCHAR2(1000) NOT NULL,
CONSTRAINT FK_ID_E_EI FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE_BOARD(EXERCISENAME)

);

	SELECT MEMBER_NO,MEMBERID,TITLE,TO_CHAR(MEMBER_DATE,'YYYY.MM.DD') AS
	MEMBER_DATE, CONTENT,MEMBER_HITS,RECOMMEND,NOTRECOMMEND
	FROM MEMBER_BOARD WHERE MEMBER_NO =46

select * from MEMBER_BOARD
--멤버 커뮤니티 게시판
CREATE TABLE MEMBER_BOARD(
MEMBER_NO NUMBER PRIMARY KEY,
MEMBERID VARCHAR2(200) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
MEMBER_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
MEMBER_HITS NUMBER DEFAULT 0,
RECOMMEND NUMBER DEFAULT 0,
NOTRECOMMEND NUMBER DEFAULT 0,
CONSTRAINT FK_ID_M_MB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)--???
);
--멤버 커뮤니티 시퀀스
CREATE SEQUENCE MEMBER_SEQ NOCACHE;

--멤버 커뮤니티 게시판 답글
CREATE TABLE MEMBER_REPLY(
REPLY_NO NUMBER PRIMARY KEY,
Member_no NUMBER not null,
MEMBERID VARCHAR2(100) NOT NULL,
CONTENT CLOB NOT NULL,
REPLY_DATE DATE,
CONSTRAINT FK_ID_M_MR FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_NO_M_MR FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_BOARD(MEMBER_NO)
);

--멤버 커뮤니티 답글 시퀀스
CREATE SEQUENCE REPLY_SEQ NOCACHE;

--멤버 커뮤니티 이미지
CREATE TABLE MEMBER_IMG(
MEMBER_NO NUMBER NOT NULL,
IMGNAME VARCHAR2(300) NOT NULL,
IMGPATH VARCHAR2(1000) NOT NULL,
CONSTRAINT FK_NO_M_MB FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_BOARD(MEMBER_NO)

);

-- 멤버 플래너
CREATE TABLE EXERCISE_PLANNER(
MEMBERID VARCHAR2(100) NOT NULL,
EXERCISENAME VARCHAR2(100) NOT NULL,
PLANNER_DATE DATE NOT NULL,
TARGETSET NUMBER NOT NULL,
ACHIEVEMENT NUMBER DEFAULT 0,
CONSTRAINT FK_ID_M_EP FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_ID_E_EP FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE(EXERCISENAME)

);

select MEMBERID, EXERCISENAME, PLANNER_DATE, TARGETSET, ACHIEVEMENT
from EXERCISE_PLANNER where MEMBERID='java';

-- 수정 후 (조인)
SELECT m.MEMBERID, ep.EXERCISENAME, TO_CHAR(ep.PLANNER_DATE,'YYYY-MM-DD') AS PLANNER_DATE, ep.TARGETSET, ep.PLANNERCONTENT, ep.ACHIEVEMENT 
FROM  MOMENTOR_MEMBER m, EXERCISE_PLANNER ep,  EXERCISE e
WHERE m.MEMBERID=ep.MEMBERID AND e.EXERCISENAME=ep.EXERCISENAME AND m.MEMBERID = 'java'
AND TO_CHAR(ep.PLANNER_DATE,'YYYY-MM-DD') = '2015-11-28'
-- 수정 후
SELECT MEMBERID, EXERCISENAME, TO_CHAR(PLANNER_DATE,'YYYY-MM-DD') AS PLANNER_DATE, TARGETSET, PLANNERCONTENT, ACHIEVEMENT 
FROM  EXERCISE_PLANNER
WHERE MEMBERID = 'java'
AND TO_CHAR(PLANNER_DATE,'YYYY-MM-DD') = '2015-11-28'

-- 수정 전
SELECT m.MEMBERID, e.EXERCISEID, TO_CHAR(ep.PLANNER_DATE,'YYYY-MM-DD') AS PLANNER_DATE, ep.TARGETSET, ep.PLANNERCONTENT, ep.ACHIEVEMENT, e.EXERCISENAME 
FROM  MOMENTOR_MEMBER m, EXERCISE_PLANNER ep, EXERCISE e
WHERE e.EXERCISEID=ep.EXERCISEID AND m.MEMBERID=ep.MEMBERID AND m.MEMBERID = 'java'
AND TO_CHAR(ep.PLANNER_DATE,'YYYY-MM-DD') = '2015-11-27'

insert into EXERCISE_PLANNER(MEMBERID, EXERCISENAME, PLANNER_DATE, TARGETSET)
values('java', '윗몸일으키기', sysdate, '5');
insert into EXERCISE_PLANNER(MEMBERID, EXERCISENAME, PLANNER_DATE, TARGETSET)
values('java', '팔굽혀펴기', sysdate, '8');
insert into EXERCISE_PLANNER(MEMBERID, EXERCISENAME, PLANNER_DATE, TARGETSET)
values('java', '스쿼트', sysdate, '10');

UPDATE EXERCISE_PLANNER SET ACHIEVEMENT = 5
WHERE MEMBERID = 'java'
AND EXERCISENAME = '윗몸일으키기'
AND TO_CHAR(PLANNER_DATE,'YYYY-MM-DD') = '2015-11-28';

-- 멤버 플래너 코멘트
CREATE TABLE EXERCISE_PLANNERCONTENT(
MEMBERID VARCHAR2(100) NOT NULL,
PLANNER_DATE DATE NOT NULL,
PLANNERCONTENT CLOB,
CONSTRAINT FK_ID_M_EPC FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)

);
select MEMBERID, PLANNER_DATE, PLANNERCONTENT from EXERCISE_PLANNERCONTENT;
insert into EXERCISE_PLANNERCONTENT(MEMBERID, PLANNER_DATE, PLANNERCONTENT)
values('java', '2015-12-01', 'paradise');
UPDATE EXERCISE_PLANNERCONTENT SET PLANNERCONTENT = '한글되나?'
WHERE MEMBERID = 'java'
AND TO_CHAR(PLANNER_DATE,'YYYY-MM-DD') = '2015-12-01';
delete from EXERCISE_PLANNERCONTENT;

--찜하기
CREATE TABLE EXERCISE_CART(
MEMBERID VARCHAR2(100) NOT NULL,
EXERCISENAME VARCHAR2(100) NOT NULL,
CONSTRAINT FK_ID_M_EC FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_ID_E_EC FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE(EXERCISENAME)
);

select MEMBERID, EXERCISENAME from EXERCISE_CART;
insert into EXERCISE_CART(MEMBERID, EXERCISENAME)
values('javaking', '윗몸일으키기');
insert into EXERCISE_CART(MEMBERID, EXERCISENAME)
values('javaking', '팔굽혀펴기');
insert into EXERCISE_CART(MEMBERID, EXERCISENAME)
values('javaking', '스쿼트');

DELETE FROM EXERCISE_CART WHERE MEMBERID='java' AND EXERCISENAME='스쿼트';

select * from momentor_member;
-- 수정 후(조인)
select ec.MEMBERID, ec.EXERCISENAME
from MOMENTOR_MEMBER m, EXERCISE e, EXERCISE_CART ec
where e.EXERCISENAME=ec.EXERCISENAME and m.MEMBERID=ec.MEMBERID and ec.MEMBERID='java';
-- 수정 후
select MEMBERID, EXERCISENAME
from EXERCISE_CART
where MEMBERID='java';
-- 수정 전
select m.MEMBERID, e.EXERCISEID, e.EXERCISENAME
from MOMENTOR_MEMBER m, EXERCISE e, EXERCISE_CART ec
where e.EXERCISEID=ec.EXERCISEID and m.MEMBERID=ec.MEMBERID and ec.MEMBERID='java';


SELECT MEMBER_SEQ.CURRVAL FROM DUAL

 INSERT INTO MOMENTOR_MEMBER 
		(MEMBERID, MEMBERPASSWORD, MEMBERNAME, BIRTHYEAR,BIRTHMONTH, BIRTHDAY, NICKNAME, MEMBEREMAIL, GENDER, MEMBERADDRESS)
		VALUES ('java','12345a','김유정','1991','12','20','디버그여왕','	KimYooJung@naver,com','여자','판교 KOSTA')
		--페이징 빈
		select b.MEMBER_NO,b.MEMBERID,b.TITLE,b.MEMBER_DATE,b.MEMBER_HITS from (
        select MEMBER_NO,MEMBERID,TITLE,MEMBER_DATE,MEMBER_HITS,ceil(rownum/5) as page from (
               select MEMBER_NO,MEMBERID,TITLE,to_char(MEMBER_DATE,'YYYY.MM.DD') as MEMBER_DATE,
               MEMBER_HITS from MEMBER_BOARD  order by MEMBER_NO desc
           )
       ) b,MOMENTOR_MEMBER m where b.MEMBERID=m.MEMBERID and page='1'
       
       
       
       
--추천, 비추천 기록 테이블
CREATE TABLE RECOMMEND_INFO(
MEMBER_NO NUMBER NOT NULL,
MEMBERID VARCHAR2(100) NOT NULL,
RECOMMEND varchar2(10) DEFAULT 'N'  NOT NULL,
NOTRECOMMEND varchar2(10) DEFAULT 'N'  NOT NULL,
CONSTRAINT FK_ID_M_RI FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_NO_M_RI FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_BOARD(MEMBER_NO)
);
