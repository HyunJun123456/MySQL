select user(); -- 현재 MySQL 사용자 표시
show databases; -- 현재 데이터베이스 목록 표시

-- 데이터베이스 생성
drop database if exists univDB;
create database if not exists univDB;

-- SQL 명령어를 실행할 대상인 기본 데이터베이스를 univDB로 지정
use univDB;

-- 학생 테이블 생성
create table 학생
	(학번 char(4) not null,
	이름 varchar(20) not null,
    주소 varchar(50) null default '미정',
    학년 int not null,
    나이 int null,
    성별 char(1) not null,
    휴대폰번호 char(14) null,
    소속학과 varchar(20) null,
    primary key(학번));
    
-- 과목 테이블 생성
create table 과목
	(과목번호 char(4) not null primary key,
    이름 varchar(20) not null,
    강의실 char(3) not null,
    개설학과 varchar(20) not null,
    시수 int not null);
    
-- 수강 테이블 생성
create table 수강
	(학번 char(6) not null,
    과목번호 char(4) not null,
    신청날짜 date not null,
    중간성적 int null default 0,
    기말성적 int null default 0,
    평가학점 char(1) null,
    primary key(학번, 과목번호));
    
-- 학생 테이블 입력
insert into 학생
values('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터');
insert into 학생
values('s002', '홍길동', default, 1, 26, '남', null, '통계');
insert into 학생
values('s003', '이승엽', null, 3, 30, '남', null, '정보통신');
insert into 학생
values('s004', '이영애', '경기 분당', 2, null, '여', '010-4444-5555', '정보통신');
insert into 학생
values('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터');
insert into 학생
values('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터');
insert into 학생
values('s007', '이은진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영');



-- 과목 테이블 입력
insert into 과목
values('c001', '데이터베이스', '126', '컴퓨터', 3);
insert into 과목
values('c002', '정보보호', '137', '정보통신', 3);
insert into 과목
values('c003', '모바일웹', '128', '컴퓨터', 3);
insert into 과목
values('c004', '철학개론', '117', '철학', 2);
insert into 과목
values('c005', '전공글쓰기', '120', '교양학부', 1);

-- 수강 테이블 입력
insert into 수강
values('s001', 'c002','2019-09-03', 93, 98,'A');
insert into 수강
values('s004', 'c005','2019-03-03', 72, 78,'C');
insert into 수강
values('s003', 'c002','2017-09-06', 85, 82,'B');
insert into 수강
values('s002', 'c001','2018-03-10', 31, 50,'F');
insert into 수강
values('s001', 'c004','2019-03-05', 82, 89,'B');
insert into 수강
values('s004', 'c003','2020-09-03', 91, 94,'A');
insert into 수강
values('s001', 'c005','2020-09-03', 74, 79,'C');
insert into 수강
values('s003', 'c001','2019-03-03', 81, 82,'B');
insert into 수강
values('s004', 'c002','2018-03-05', 92, 95,'A');

use univDB; -- 작업 대상 데이터베이스 변경
select database(); -- 현재 사용 데이터베이스 확인
show tables; -- univDB 안의 생성 테이블 목록 확인
desc 학생; -- 학생 테이블 생성 정보 확인

/*
	SQL 명령어와 구별이 쉽도록 테이블 이름과 열 이름을 한글로 표기함!
*/

-- 전체 학생의 이름과 주소를 검색하시오.    
select 이름, 주소 from 학생;

-- 전체 학생의 정보를 검색하시오.
select 학번, 이름, 주소, 학년, 나이, 성별, 휴대폰번호, 소속학과
from 학생;
select *
from 학생;

-- 전체 학생의 소속학과 정보를 중복 없이 검색하시오.
select distinct 소속학과
from 학생;

-- 학생 중에서 2학년 이상인 '컴퓨터'학과 학생의 이름, 학년, 소속학과, 휴대폰번호 정보를 검색하시오.
select 이름, 학년, 소속학과, 휴대폰번호
from 학생
where 학년>=2 and 소속학과='컴퓨터';

-- 1, 2, 3학년 학생이거나 '컴퓨터'학과에 소속되지 않은 학생의 이름, 학년, 소속학과, 휴대폰번호 정보를 검색하시오.
select 이름, 학년, 소속학과, 휴대폰번호
from 학생
where (학년 between 1 and 3) or not (소속학과='컴퓨터');

-- '컴퓨터'학과나 '정보통신'학과의 학생의 이름과 학년, 소속학과 정보를 학년의 오름차순으로 검색하시오.
select 이름, 학년, 소속학과
from 학생
where 소속학과='컴퓨터' or 소속학과='정보통신'
order by 학년 asc;

-- 전체 학생의 모든 정보를 검색하되 학년을 기준으로 먼저 1차 오름차순 정렬하고, 학년이 같은 경우에는 이름을 기준으로 2차 내림차순 정렬하여 검색하시오.
select *
from 학생
order by 학년 asc, 이름 desc;

-- 전체 학생수를 검색하시오.
select count(*)
from 학생;

-- '여'학생의 평균 나이를 검색하시오.
select avg(나이) '여학생 평균나이'
from 학생
where 성별='여';

-- 전체 학생의 성별 최고 나이와 최저 나이를 검색하시오.
select 성별, max(나이) as '최고 나이', min(나이) as '최저 나이'
from 학생
group by 성별;

-- 20대 학생만을 대상으로 나이별 학생수를 검색하시오.
select 나이, count(*) as '나이별 학생수'
from 학생
where 나이>20 and 나이<30
group by 나이;

-- 각 학년별로 2명 이상의 학생을 갖는 학년에 대해서만 학년별 학생수를 검색하시오.
select 학년, count(*) as '학년별 학생수'
from 학생
group by 학년
having count(*)>=2;

-- '이'씨 성을 가진 학생들의 학번과 학생 이름을 검색하시오.
select 학번, 이름
from 학생
where 이름 like '이__';

-- 주소지가 '서울'인 학생의 이름, 주소, 학년을 학년 순(내림차순)으로 검색하시오.
select 이름, 주소, 학년
from 학생
where 주소 like '%서울%'
order by 학년 desc;

-- 휴대폰번호가 등록되지 않은(널 값을 갖는) 학생의 이름과 휴대폰번호를 검색하시오.
select 이름, 휴대폰번호
from 학생
where 휴대폰번호 is null;

-- '여'학생이거나 'A'학점을 받은 학생의 학번을 검색하시오.
select 학번
from 학생
where 성별='여'
union 
select 학번 
from 수강 
where 평가학점='A';

-- 과목번호가 'c002'인 과목을 수강한 학생의 이름을 검색하시오.
select 이름 
from 학생 
where 학번 in (select 학번 
				from 수강 
                where 과목번호='c002');
                
-- '정보보호' 과목을 수강한 학생의 이름을 검색하시오.
select 이름 
from 학생 
where 학번 in (select 학번 
				from 수강 
                where 과목번호=(select 과목번호 
								from 과목 
                                where 이름='정보보호'));
					
-- 과목번호가 'c002'인 과목을 수강한 학생의 이름을 검색하시오.
select 이름
from 학생 
where exists (select * 
				from 수강 
                where 수강.학번 = 학생.학번 and 과목번호='c002');
                
-- 학생 중에서 한 과목도 수강하지 않은 학생의 이름을 검색하시오.
select 이름 
from 학생 
where not exists (select * 
					from 수강 
                    where 수강.학번 = 학생.학번);
                    
-- 전체 학생의 기본 정보와 모든 수강 정보를 검색하시오.
select * 
from 학생, 수강
where 학생.학번=수강.학번;
select *
from 학생 join 수강 on 학생.학번=수강.학번;

-- 학생 중에서 과목번호가 'c002'인 과목을 수강한 학생의 학번과 이름, 과목번호 그리고 변환중간성적을 검색하시오.
select 학생.학번, 이름, 과목번호, 중간성적+(중간성적*0.1) as 변환중간성적
from 학생 join 수강 on 학생.학번=수강.학번
where 과목번호='c002';

-- 학생 중에서 '정보보호' 과목을 수강한 학생의 학번과 이름, 과목번호를 검색하시오.
select 학생.학번, 학생.이름, 수강.과목번호
from (학생 join 수강 on 학생.학번=수강.학번) join 과목 on 수강.과목번호=과목.과목번호 
where 과목.이름='정보보호';

-- 학생 중에서 과목번호가 'c002'인 과목을 수강한 학생의 이름, 과목번호를 검색하시오.
select 이름, 과목번호 
from 학생 as s, 수강 e
where s.학번=e.학번 and 과목번호='c002';

-- 주소가 같은 학생들의 이름을 쌍으로 검색하시오. 이때, 검색되는 첫 번째 학생이 두 번째 학생보다 학년이 높도록 하시오.
select s1.이름, s2.이름
from 학생 s1 join 학생 s2 on s1.주소=s2.주소
where s1.학년>s2.학년;

-- 과목을 수강하지 않은 학생을 포함하여 모든 학생의 학번, 이름과 학생이 수강한 교과의 평가학점을 검색하시오. 
select 학생.학번, 이름, 평가학점
from 학생 left outer join 수강 on 학생.학번=수강.학번;

create table 학생1 as (select * from 학생);
create table 과목1 as (select * from 과목);
create table 수강1 as (select * from 수강);

-- '학생1' 테이블에 학번 'g001' 이름 '김연아2', 주소 '서울 서초', 학년 4, 나이 23, 성별 '여', 휴대폰번호'010-1111-2222', 소속학과 '컴퓨터'인 학생 정보를 삽입하시오.
insert into 학생1
values('g001', '김연아2', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터');

-- 학번 'g002', 이름 '홍길동2', 주소 '미정', 학년 1, 나이 26, 성별 '남', 휴대폰번호 'NULL', 소속학과 '통계'인 학생 정보를 삽입하시오.
insert into 학생1(이름, 주소, 학년, 나이, 성별, 휴대폰번호, 소속학과, 학번)
values ('홍길동2', default, 1, 26, '남', null, '통계', 'g002');

-- 학번 'g003', 이름 '이승엽2', 주소 '미정', 학년 3, 나이 30, 성별 '남', 휴대폰번호 'NULL', 소속학과 '정보통신'인 학생 정보를 삽입하시오.
insert into 학생1(학년, 나이, 성별, 소속학과, 학번, 이름)
values(3, 30, '남', '정보통신', 'g003', '이승엽2');

select * from 학생1 where 학번 like 'g%';

set sql_safe_updates=0;

-- 이은진 학생의 학년을 3학년으로 수정하시오
update 학생1 
set 학년=3 
where 이름='이은진';

select * from 학생1 where 이름='이은진';

-- 모든 학생의 학년을 1씩 증가시키고 소속학과를 자유전공학부로 변경하시오.
update 학생1
set 학년=학년+1, 소속학과='자유전공학부' 
where 학년=4;

select * from 학생1;

-- 수강 내용이 없는 학생의 소속학과를 널 값으로 수정하시오.
update 학생1
set 소속학과=null
where 학번 not in(select 학번
				from 수강1);
                
select * from 학생1;

-- 학번이 s003인 학생의 수강 내용을 이은진 학생이 수강한 것으로 수정하시오.
update 수강1 
set 학번=(select 학번 
		from 학생1 
        where 이름='이은진') 
where 학번='s003';

select * from 수강1 where 학번='s003' or 학번='s007';

-- 송윤아 학생의 모든 정보를 삭제하시오
delete from 학생1
where 이름='송윤아';

select * from 학생1;

-- 3학년 모든 학생 정보를 삭제하시오
delete from 학생1
where 학년=3;

select * from 학생1;

-- 수강자가 2명 미만인 과목에 대한 과목 정보를 모두 삭제하시오.
delete from 과목1
where 과목번호 in 
		(select 과목번호
        from 수강1 
        group by 과목번호 
        having count(*)<2);
        
select * from 과목1;

-- 모든 학생 정보를 삭제하시오.
delete from 학생1;

select * from 학생1;

drop table 학생;
drop table 과목;
drop table 수강;

-- 학생 테이블 생성
create table 학생
	(학번 char(4) not null,
	이름 varchar(20) not null,
    주소 varchar(50) null default '미정',
    학년 int not null,
    나이 int null,
    성별 char(1) not null,
    휴대폰번호 char(14) null,
    소속학과 varchar(20) null,
    primary key(학번));
    
-- 과목 테이블 생성
create table 과목
	(과목번호 char(4) not null primary key,
    이름 varchar(20) not null,
    강의실 char(3) not null,
    개설학과 varchar(20) not null,
    시수 int not null);
    
-- 수강 테이블 생성
create table 수강
	(학번 char(6) not null,
    과목번호 char(4) not null,
    신청날짜 date not null,
    중간성적 int null default 0,
    기말성적 int null default 0,
    평가학점 char(1) null,
    primary key(학번, 과목번호));
    
-- 학생 테이블 입력
insert into 학생
values('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터');
insert into 학생
values('s002', '홍길동', default, 1, 26, '남', null, '통계');
insert into 학생
values('s003', '이승엽', null, 3, 30, '남', null, '정보통신');
insert into 학생
values('s004', '이영애', '경기 분당', 2, null, '여', '010-4444-5555', '정보통신');
insert into 학생
values('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터');
insert into 학생
values('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터');
insert into 학생
values('s007', '이은진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영');



-- 과목 테이블 입력
insert into 과목
values('c001', '데이터베이스', '126', '컴퓨터', 3);
insert into 과목
values('c002', '정보보호', '137', '정보통신', 3);
insert into 과목
values('c003', '모바일웹', '128', '컴퓨터', 3);
insert into 과목
values('c004', '철학개론', '117', '철학', 2);
insert into 과목
values('c005', '전공글쓰기', '120', '교양학부', 1);

-- 수강 테이블 입력
insert into 수강
values('s001', 'c002','2019-09-03', 93, 98,'A');
insert into 수강
values('s004', 'c005','2019-03-03', 72, 78,'C');
insert into 수강
values('s003', 'c002','2017-09-06', 85, 82,'B');
insert into 수강
values('s002', 'c001','2018-03-10', 31, 50,'F');
insert into 수강
values('s001', 'c004','2019-03-05', 82, 89,'B');
insert into 수강
values('s004', 'c003','2020-09-03', 91, 94,'A');
insert into 수강
values('s001', 'c005','2020-09-03', 74, 79,'C');
insert into 수강
values('s003', 'c001','2019-03-03', 81, 82,'B');
insert into 수강
values('s004', 'c002','2018-03-05', 92, 95,'A');

use univDB;
select database();
show tables;
desc 학생;

select 이름, 주소
from 학생;

select * 
from 학생;

select distinct 소속학과
from 학생;

select all 소속학과
from 학생;

select 이름, 학년, 소속학과, 휴대폰번호
from 학생
where 학년>=2 and 소속학과='컴퓨터';

select 이름, 학년, 소속학과, 휴대폰번호
from 학생
where (학년>=1 and 학년<=3) or not(소속학과='컴퓨터');

select 이름, 학년, 소속학과
from 학생
where 소속학과='컴퓨터' or 소속학과='정보통신'
order by 학년 asc;

select * 
from 학생
order by 학년 asc, 이름 desc;

select *
from 수강
order by 중간성적 desc
limit 3;

select *
from 수강 
order by 중간성적 desc 
limit 5, 3;
/* 파라미터가 0부터 시작함 */

select count(*)
from 학생;

select count(학번)
from 학생;

select count(*) as 학생수1, count(주소) as 학생수2, count(distinct 주소) as 학생수3
from 학생;
/*count는 null과 중복을 포함시킴*/

select avg(나이) '여학생 평균나이'
from 학생
where 성별='여';

select 성별, max(나이) as '최고 나이', min(나이) as '최저 나이'
from 학생
group by 성별;

select 나이, count(*) as '나이별 학생수'
from 학생
where 나이>=20 and 나이<30
group by 나이;

select 학년, count(*) as '학년별 학생수'
from 학생
group by 학년
having count(*)>=2
order by 학년;

select 학번,이름
from 학생
where 이름 like '이__';

select 이름,주소,학년
from 학생
where 주소 like '%서울%'
order by 학년 desc;

select 이름, 휴대폰번호
from 학생
where 휴대폰번호 is null;

select 학번
from 학생
where 성별='여'
union
select 학번
from 수강
where 평가학점='A';

select 이름
from 학생
where 학번 in (select 학번 from 수강 where 과목번호='c002');

select 이름 from 학생 where 학번 in (select 학번 from 수강 where 과목번호= (select 과목번호 from 과목 where 이름='정보보호'));

select 이름 from 학생 where exists(select * from 수강 where 수강.학번=학생.학번 and 과목번호='c002');

select 이름 from 학생 where not exists (select * from 수강 where 수강.학번=학생.학번);

select * from 학생 cross join 수강;

select * from 학생 join 수강 on 학생.학번=수강.학번;

create table 과목2
(과목번호 char(4) not null primary key,
이름 varchar(20) not null,
강의실 char(5) not null,
개설학과 varchar(20) not null,
시수 int not null);

create table 학생2
(학번 char(4) not null,
이름 varchar(20) not null,
주소 varchar(50) null default '미정',
학년 int not null,
나이 int null,
성별 char(1) not null,
휴대폰번호 char(13) null,
소속학과 varchar(20) null,
primary key(학번),
unique(휴대폰번호)
);

desc 학생2;

show create table 학생2;

create table 수강2 
(학번 char(6) not null,
과목번호 char(4) not null,
신청날짜 date not null,
중간성적 int null default 0,
기말성적 int null default 0,
평가학점 char(1) null,
primary key(학번, 과목번호),
foreign key(학번) references 학생2(학번),
foreign key(과목번호) references 과목2(과목번호));

insert into 과목2(과목번호, 이름, 강의실, 개설학과)
values('c111', 'database', A-123, '산업공학');
-- char(5) 유형 오류(강의실 열의 문자열 유형에 불일치함)

insert into 과목2(과목번호, 이름, 강의실, 개설학과, 시수)
values('c111', 'database', 'A-123', '산업공학');
-- null 제약 조건 오류(시수 열이 null을 허용하지 않음)

insert into 과목2(과목번호, 이름, 강의실, 개설학과, 시수)
values('c111', 'database', 'A-123', '산업공학', 3);
-- 정상 수행

insert into 학생2(학번,이름,학년,나이,성별,휴대폰번호,소속학과)
values ('s111','박태환',4,null,'남','010-1111-1111','산업공학');
-- 정상 수행

insert into 학생2(학번,이름,학년,나이,성별,휴대폰번호,소속학과)
values ('s222','박태환',2,null,'남','010-1111-1111','산업공학');
-- unique 제약 조건 오류(휴대폰번호 열 값이 중복됨)

insert into 학생2(학번,이름,학년,나이,성별,휴대폰번호,소속학과)
values ('s222','박태환',2,null,'남','010-2222-2222','산업공학');
-- 정상 수행

insert into 수강2(학번,과목번호,신청날짜)
values('s111','c111','2019-12-31');
-- 정상 수행

insert into 수강2(학번,과목번호,신청날짜,중간성적,기말성적,평가학점)
values('s111','c222','2019-12-31', 93, 98, 'A');
-- 외래키 제약 조건 오류(입력 과목번호 값이 과목2 테이블에 존재하지 않음)

insert into 수강2(학번,과목번호,신청날짜,중간성적,기말성적,평가학점)
values('s111','c111','2019-12-31', 93, 98, 'A');
-- 기본키 제약 조건 오류(기본키 학번과 과목번호 열의 조합이 중복 값이 존재함)

insert into 수강2(학번,과목번호,신청날짜,중간성적,기말성적,평가학점)
values('s222','c111','2019-12-31', 93, 98, 'A');
-- 정상 수행



















