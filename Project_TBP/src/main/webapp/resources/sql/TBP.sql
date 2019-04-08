/* Drop Tables */

DROP TABLE administrator CASCADE CONSTRAINTS;
DROP TABLE allNotice CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE notices CASCADE CONSTRAINTS;
DROP TABLE orderReview CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE productImages CASCADE CONSTRAINTS;
DROP TABLE questionRecomment CASCADE CONSTRAINTS;
DROP TABLE productQuestion CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE categorys CASCADE CONSTRAINTS;
DROP TABLE customerRecomment CASCADE CONSTRAINTS;
DROP TABLE customerQuestion CASCADE CONSTRAINTS;
DROP TABLE myDelivery CASCADE CONSTRAINTS;
DROP TABLE shop CASCADE CONSTRAINTS;
DROP TABLE tbptalk_content CASCADE CONSTRAINTS;
DROP TABLE tbptalk_list CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE productState CASCADE CONSTRAINTS;
DROP TABLE salesWay CASCADE CONSTRAINTS;

/* Create Tables */

CREATE TABLE administrator
(
	adminNo number NOT NULL,
	adminId varchar2(30) NOT NULL,
	adminPw varchar2(30),
	adminAuth varchar2(30) NOT NULL,
	enabled number DEFAULT 1,
	PRIMARY KEY (adminNo)
);

CREATE TABLE allNotice
(
	allNoticeNo number NOT NULL,
	allNoticeSubject varchar2(300) NOT NULL,
	allNoticeContent clob NOT NULL,
	allNoticeType number DEFAULT 1,
	allNoticeRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (allNoticeNo)
);

CREATE TABLE cart
(
	cartNo number NOT NULL,
	memberNo number NOT NULL,
	productNo number NOT NULL,
	cartStock number NOT NULL,
	cartStatus number DEFAULT 0,
	PRIMARY KEY (cartNo)
);

CREATE TABLE categorys
(
	categoryId number NOT NULL,
	categoryName varchar2(50) NOT NULL UNIQUE,
	categoryDepth number NOT NULL,
	categoryParent number,
	PRIMARY KEY (categoryId)
);

CREATE TABLE customerQuestion
(
	cQuestionNo number NOT NULL,
	memberNo number NOT NULL,
	cQuestionSubject varchar2(150) NOT NULL,
	cQuestionContent clob NOT NULL,
	cQuestionStatus number DEFAULT 1,
	cQuestionRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (cQuestionNo)
);

CREATE TABLE customerRecomment
(
	cRecommentNo number NOT NULL,
	cQuestionNo number NOT NULL,
	cRecommentContent clob NOT NULL,
	cRecommentRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (cRecommentNo)
);

CREATE TABLE members
(
	memberNo number NOT NULL,
	memberId varchar2(15) NOT NULL UNIQUE,
	memberPw varchar2(20) NOT NULL,
	memberName varchar2(30) NOT NULL,
	memberBirth date NOT NULL,
	memberGender number NOT NULL,
	memberPnum varchar2(15) NOT NULL,
	memberEmail varchar2(30) NOT NULL,
	memberStatus number DEFAULT 0,
	memberBgrade number DEFAULT 0,
	memberSgrade number DEFAULT 0,
	memberMoney number DEFAULT 0,
	memberRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (memberNo)
);

CREATE TABLE myDelivery
(
	deliveryNo number NOT NULL,
	memberNo number NOT NULL,
	deliveryName varchar2(30),
	deliveryAddr varchar2(300),
	deliveryTel varchar2(15),
	deliveryRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (deliveryNo)
);

CREATE TABLE notices
(
	noticeNo number NOT NULL,
	memberNo number NOT NULL,
	productNo number,
	noticeWay number NOT NULL,
	noticeStatus number(1) DEFAULT 0,
	noticeRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (noticeNo)
);

CREATE TABLE orderReview
(
	reviewNo number NOT NULL,
	orderNo number NOT NULL,
	memberNo number NOT NULL,
	productScore number NOT NULL,
	reviewContent varchar2(300) NOT NULL,
	reviewRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (reviewNo)
);

CREATE TABLE orders
(
	orderNo number NOT NULL,
	memberNo number NOT NULL,
	productNo number NOT NULL,
	orderName varchar2(150),
	orderSubject varchar2(150) NOT NULL,
	productThumb varchar2(300) NOT NULL,
	orderAddr varchar2(300),
	orderTel varchar2(15),
	orderStock number NOT NULL,
	orderStatus number NOT NULL,
	orderPrice number NOT NULL,
	orderRegDate timestamp DEFAULT SYSDATE,
	orderReviewCheck number NOT NULL,
	PRIMARY KEY (orderNo)
);

CREATE TABLE product
(
	productNo number NOT NULL,
	memberNo number NOT NULL,
	productThumb varchar2(300) NOT NULL,
	productSubject varchar2(150) NOT NULL,
	productContext clob NOT NULL,
	productAddr varchar2(300),
	productStateId number NOT NULL,
	salesWayId number NOT NULL,
	productPrice number NOT NULL,
	productScore number NOT NULL,
	productStock number NOT NULL,
	productRegDate timestamp DEFAULT SYSDATE,
	productViewcnt number DEFAULT 0,
	productStatus number DEFAULT 0,
	categoryId number NOT NULL,
	hasOption varchar2(10) NOT NULL,
	beginningStock number NOT NULL,
	PRIMARY KEY (productNo)
);

CREATE TABLE productImages
(
	productImgNo number NOT NULL,
	productNo number NOT NULL,
	productImgOriginalName varchar2(300) NOT NULL,
	productImgFileSystemName varchar2(300) NOT NULL,
	PRIMARY KEY (productImgNo)
);

CREATE TABLE productQuestion
(
	questionNo number NOT NULL,
	productNo number NOT NULL,
	memberNo number NOT NULL,
	questionContent varchar2(300) NOT NULL,
	questionRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (questionNo)
);

CREATE TABLE productState
(
	productStateId number NOT NULL,
	productStateName varchar2(50) NOT NULL,
	PRIMARY KEY (productStateId)
);

CREATE TABLE questionRecomment
(
	qRecommentNo number NOT NULL,
	questionNo number NOT NULL,
	productNo number NOT NULL,
	memberNo number NOT NULL,
	qRecommentContent varchar2(300) NOT NULL,
	qRecommentRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (qRecommentNo)
);

CREATE TABLE salesWay
(
	salesWayId number NOT NULL,
	salesWayName varchar2(50) NOT NULL,
	PRIMARY KEY (salesWayId)
);

CREATE TABLE shop
(
	shopNo number NOT NULL,
	memberNo number NOT NULL,
	shopName varchar2(50),
	shopIntroduction varchar2(300),
	shopStatus number DEFAULT 0,
	shopVisitcnt number DEFAULT 0,
	shopRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (shopNo)
);

CREATE TABLE tbptalk_content
(
	tbptalkNo number NOT NULL,
	memberNo number NOT NULL,
	tbptalkViewcnt number(10) DEFAULT 1,
	tbptalkContent varchar2(500) NOT NULL,
	tbptalkRegDate timestamp DEFAULT SYSDATE
);

CREATE TABLE tbptalk_list
(
	tbptalkNo number NOT NULL,
	memberNo1 number NOT NULL,
	memberNo2 number NOT NULL,
	tbptalkRegDate timestamp DEFAULT SYSDATE,
	PRIMARY KEY (tbptalkNo)
);

/* Create Foreign Keys */

ALTER TABLE product
	ADD FOREIGN KEY (categoryId)
	REFERENCES categorys (categoryId)
;

ALTER TABLE customerRecomment
	ADD FOREIGN KEY (cQuestionNo)
	REFERENCES customerQuestion (cQuestionNo)
;

ALTER TABLE cart
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE customerQuestion
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE myDelivery
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE notices
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE orderReview
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE orders
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE product
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE productQuestion
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE questionRecomment
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE shop
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE tbptalk_content
	ADD FOREIGN KEY (memberNo)
	REFERENCES members (memberNo)
;

ALTER TABLE tbptalk_list
	ADD FOREIGN KEY (memberNo1)
	REFERENCES members (memberNo)
;

ALTER TABLE tbptalk_list
	ADD FOREIGN KEY (memberNo2)
	REFERENCES members (memberNo)
;

ALTER TABLE orderReview
	ADD FOREIGN KEY (orderNo)
	REFERENCES orders (orderNo)
;

ALTER TABLE cart
	ADD FOREIGN KEY (productNo)
	REFERENCES product (productNo)
;

ALTER TABLE orders
	ADD FOREIGN KEY (productNo)
	REFERENCES product (productNo)
;

ALTER TABLE productImages
	ADD FOREIGN KEY (productNo)
	REFERENCES product (productNo)
;

ALTER TABLE productQuestion
	ADD FOREIGN KEY (productNo)
	REFERENCES product (productNo)
;

ALTER TABLE questionRecomment
	ADD FOREIGN KEY (productNo)
	REFERENCES product (productNo)
;

ALTER TABLE questionRecomment
	ADD FOREIGN KEY (questionNo)
	REFERENCES productQuestion (questionNo)
;

ALTER TABLE product
	ADD FOREIGN KEY (productStateId)
	REFERENCES productState (productStateId)
;

ALTER TABLE product
	ADD FOREIGN KEY (salesWayId)
	REFERENCES salesWay (salesWayId)
;

ALTER TABLE tbptalk_content
	ADD FOREIGN KEY (tbptalkNo)
	REFERENCES tbptalk_list (tbptalkNo)
;

/* Create Sequence */

CREATE SEQUENCE member_seq start with 1 increment by 1;
CREATE SEQUENCE product_seq start with 1 increment by 1;
CREATE SEQUENCE productImages_seq start with 1 increment by 1;
CREATE SEQUENCE shop_seq start with 1 increment by 1;
CREATE SEQUENCE myDelivery_seq start with 1 increment by 1;
CREATE SEQUENCE order_seq start with 1 increment by 1;
CREATE SEQUENCE cart_seq start with 1 increment by 1;
CREATE SEQUENCE review_seq start with 1 increment by 1;
CREATE SEQUENCE question_seq start with 1 increment by 1;
CREATE SEQUENCE qRecomment_seq start with 1 increment by 1;
CREATE SEQUENCE notice_seq start with 1 increment by 1;
CREATE SEQUENCE cQuestion_seq start with 1 increment by 1;
CREATE SEQUENCE cRecomment_seq start with 1 increment by 1;
CREATE SEQUENCE admin_seq start with 1 increment by 1;
CREATE SEQUENCE allNotice_seq start with 1 increment by 1;
CREATE SEQUENCE tbptalk_seq start with 1 increment by 1;

/* Drop Sequence */

DROP SEQUENCE member_seq;
DROP SEQUENCE product_seq;
DROP SEQUENCE productImages_seq;
DROP SEQUENCE shop_seq;
DROP SEQUENCE myDelivery_seq;
DROP SEQUENCE order_seq;
DROP SEQUENCE cart_seq;
DROP SEQUENCE review_seq;
DROP SEQUENCE question_seq;
DROP SEQUENCE qRecomment_seq;
DROP SEQUENCE notice_seq;
DROP SEQUENCE cQuestion_seq;
DROP SEQUENCE cRecomment_seq;
DROP SEQUENCE admin_seq;
DROP SEQUENCE allNotice_seq;
DROP SEQUENCE tbptalk_seq;

/* Sample Data */

INSERT INTO CATEGORYS VALUES(100, '디지털/가전', 1, 0);
INSERT INTO CATEGORYS VALUES(110, '모바일', 2, 100);
INSERT INTO CATEGORYS VALUES(111, '스마트폰', 3, 110);
INSERT INTO CATEGORYS VALUES(112, '태블릿', 3, 110);
INSERT INTO CATEGORYS VALUES(113, '웨어러블', 3, 110);
INSERT INTO CATEGORYS VALUES(114, '케이스/범퍼', 3, 110);
INSERT INTO CATEGORYS VALUES(115, '보호필름/액세서리', 3, 110);
INSERT INTO CATEGORYS VALUES(116, '배터리/충전기', 3, 110);
INSERT INTO CATEGORYS VALUES(120, '노트북/넷북', 2, 100);
INSERT INTO CATEGORYS VALUES(121, '노트북', 3, 120);
INSERT INTO CATEGORYS VALUES(122, '넷북', 3, 120);
INSERT INTO CATEGORYS VALUES(123, '노트북 가방/액세서리', 3, 120);
INSERT INTO CATEGORYS VALUES(124, '노트북 주변기기', 3, 120);
INSERT INTO CATEGORYS VALUES(130, 'PC/모니터/주변기기', 2, 100);
INSERT INTO CATEGORYS VALUES(131, '데스크탑/본체', 3, 130);
INSERT INTO CATEGORYS VALUES(132, '모니터', 3, 130);
INSERT INTO CATEGORYS VALUES(133, 'CPU/메인보드', 3, 130);
INSERT INTO CATEGORYS VALUES(134, 'HDD/ODD/SDD', 3, 130);
INSERT INTO CATEGORYS VALUES(135, '메모리/VGA', 3, 130);
INSERT INTO CATEGORYS VALUES(136, '복합기/프린터', 3, 130);
INSERT INTO CATEGORYS VALUES(140, '카메라/DSLR', 2, 100);
INSERT INTO CATEGORYS VALUES(141, '일반디카/토이카메라', 3, 140);
INSERT INTO CATEGORYS VALUES(142, '필름/중형카메라', 3, 140);
INSERT INTO CATEGORYS VALUES(143, 'DSLR/미러리스', 3, 140);
INSERT INTO CATEGORYS VALUES(144, '렌즈/필터/컨버터', 3, 140);
INSERT INTO CATEGORYS VALUES(145, '디지털 캠코더', 3, 140);
INSERT INTO CATEGORYS VALUES(150, '가전제품', 2, 100);
INSERT INTO CATEGORYS VALUES(151, 'TV', 3, 150);
INSERT INTO CATEGORYS VALUES(152, '대형가전', 3, 150);
INSERT INTO CATEGORYS VALUES(153, '소형가전', 3, 150);
INSERT INTO CATEGORYS VALUES(160, '게임/타이틀', 2, 100);
INSERT INTO CATEGORYS VALUES(161, '닌텐도/NDS/Will', 3, 160);
INSERT INTO CATEGORYS VALUES(162, '플레이스테이션', 3, 160);
INSERT INTO CATEGORYS VALUES(163, 'XBOX', 3, 160);
INSERT INTO CATEGORYS VALUES(164, '게임 타이틀', 3, 160);
INSERT INTO CATEGORYS VALUES(165, 'PC게임', 3, 160);

INSERT INTO CATEGORYS VALUES(200, '의류/잡화', 1, 0);
INSERT INTO CATEGORYS VALUES(210, '남성의류', 2, 200);
INSERT INTO CATEGORYS VALUES(211, '긴팔 티셔츠', 3, 210);
INSERT INTO CATEGORYS VALUES(212, '반팔 티셔츠', 3, 210);
INSERT INTO CATEGORYS VALUES(213, '맨투맨/후드티', 3, 210);
INSERT INTO CATEGORYS VALUES(214, '셔츠/남방', 3, 210);
INSERT INTO CATEGORYS VALUES(215, '니트/스웨터', 3, 210);
INSERT INTO CATEGORYS VALUES(216, '가디건', 3, 210);
INSERT INTO CATEGORYS VALUES(217, '점퍼/야상/패딩', 3, 210);
INSERT INTO CATEGORYS VALUES(218, '코트', 3, 210);
INSERT INTO CATEGORYS VALUES(219, '비즈니스 정장', 3, 210);
INSERT INTO CATEGORYS VALUES(220, '여성의류', 2, 200);
INSERT INTO CATEGORYS VALUES(221, '원피스', 3, 220);
INSERT INTO CATEGORYS VALUES(222, '블라우스', 3, 220);
INSERT INTO CATEGORYS VALUES(223, '스커트/치마', 3, 220);
INSERT INTO CATEGORYS VALUES(224, '청바지/스키니', 3, 220);
INSERT INTO CATEGORYS VALUES(230, '가방', 2, 200);
INSERT INTO CATEGORYS VALUES(231, '백팩', 3, 230);
INSERT INTO CATEGORYS VALUES(232, '크로스백', 3, 230);
INSERT INTO CATEGORYS VALUES(233, '숄더백', 3, 230);
INSERT INTO CATEGORYS VALUES(234, '비즈니스 가방', 3, 230);
INSERT INTO CATEGORYS VALUES(235, '클러치백', 3, 230);
INSERT INTO CATEGORYS VALUES(240, '운동화/캐주얼화', 2, 200);
INSERT INTO CATEGORYS VALUES(241, '런닝화/워킹화', 3, 240);
INSERT INTO CATEGORYS VALUES(242, '농구화', 3, 240);
INSERT INTO CATEGORYS VALUES(243, '캐주얼화', 3, 240);
INSERT INTO CATEGORYS VALUES(250, '모자', 2, 200);
INSERT INTO CATEGORYS VALUES(251, '야구모자/군모', 3, 250);
INSERT INTO CATEGORYS VALUES(252, '스냅백/힙합', 3, 250);
INSERT INTO CATEGORYS VALUES(253, '패션모자', 3, 250);
INSERT INTO CATEGORYS VALUES(254, '왕골/바캉스', 3, 250);
INSERT INTO CATEGORYS VALUES(255, '비니', 3, 250);
INSERT INTO CATEGORYS VALUES(260, '지갑', 2, 200);
INSERT INTO CATEGORYS VALUES(261, '장지갑', 3, 260);
INSERT INTO CATEGORYS VALUES(262, '중/반지갑', 3, 260);
INSERT INTO CATEGORYS VALUES(263, '카드/명함 지갑', 3, 260);
INSERT INTO CATEGORYS VALUES(270, '안경/선글라스', 2, 200);
INSERT INTO CATEGORYS VALUES(271, '뿔테', 3, 270);
INSERT INTO CATEGORYS VALUES(272, '금속테', 3, 270);
INSERT INTO CATEGORYS VALUES(273, '선글라스', 3, 270);
INSERT INTO CATEGORYS VALUES(280, '시계', 2, 200);
INSERT INTO CATEGORYS VALUES(281, '메탈', 3, 280);
INSERT INTO CATEGORYS VALUES(282, '가죽', 3, 280);
INSERT INTO CATEGORYS VALUES(283, '스포츠/방수', 3, 280);
INSERT INTO CATEGORYS VALUES(284, '젤리/우레탄', 3, 280);
INSERT INTO CATEGORYS VALUES(290, '주얼리/액세서리', 2, 200);
INSERT INTO CATEGORYS VALUES(291, '반지', 3, 290);
INSERT INTO CATEGORYS VALUES(292, '귀걸이/피어싱', 3, 290);
INSERT INTO CATEGORYS VALUES(293, '목걸이/펜던트', 3, 290);
INSERT INTO CATEGORYS VALUES(294, '팔찌/발찌', 3, 290);
INSERT INTO CATEGORYS VALUES(295, '헤어 액세서리', 3, 290);

INSERT INTO CATEGORYS VALUES(300, '레저/자동차', 1, 0);
INSERT INTO CATEGORYS VALUES(310, '자전거/MTB', 2, 300);
INSERT INTO CATEGORYS VALUES(311, '클래식/픽시', 3, 310);
INSERT INTO CATEGORYS VALUES(312, '하이브리드', 3, 310);
INSERT INTO CATEGORYS VALUES(313, 'MTB/산악', 3, 310);
INSERT INTO CATEGORYS VALUES(314, '미니벨로', 3, 310);
INSERT INTO CATEGORYS VALUES(315, '로드/BMX', 3, 310);
INSERT INTO CATEGORYS VALUES(316, '전동 자전거', 3, 310);
INSERT INTO CATEGORYS VALUES(320, '축구/야구/농구', 2, 300);
INSERT INTO CATEGORYS VALUES(321, '축구 용품', 3, 320);
INSERT INTO CATEGORYS VALUES(322, '야구 용품', 3, 320);
INSERT INTO CATEGORYS VALUES(323, '농구 용품', 3, 320);
INSERT INTO CATEGORYS VALUES(330, '헬스/요가/골프', 2, 300);
INSERT INTO CATEGORYS VALUES(331, '헬스/요가 용품', 3, 330);
INSERT INTO CATEGORYS VALUES(332, '골프 용품', 3, 330);
INSERT INTO CATEGORYS VALUES(333, '골프 의류/잡화', 3, 330);
INSERT INTO CATEGORYS VALUES(340, '수영', 2, 300);
INSERT INTO CATEGORYS VALUES(341, '여성 수영복', 3, 340);
INSERT INTO CATEGORYS VALUES(342, '남성 수영복', 3, 340);
INSERT INTO CATEGORYS VALUES(343, '수영 용품', 3, 340);
INSERT INTO CATEGORYS VALUES(344, '물놀이 용품', 3, 340);
INSERT INTO CATEGORYS VALUES(350, '스키/보드', 2, 300);
INSERT INTO CATEGORYS VALUES(351, '스키 용품', 3, 350);
INSERT INTO CATEGORYS VALUES(352, '스키 의류/잡화', 3, 350);
INSERT INTO CATEGORYS VALUES(360, '등산', 2, 300);
INSERT INTO CATEGORYS VALUES(361, '남성 등산복', 3, 360);
INSERT INTO CATEGORYS VALUES(362, '여성 등산복', 3, 360);
INSERT INTO CATEGORYS VALUES(363, '등산 배낭', 3, 360);
INSERT INTO CATEGORYS VALUES(364, '등산/트레킹화', 3, 360);
INSERT INTO CATEGORYS VALUES(365, '등산 용품', 3, 360);
INSERT INTO CATEGORYS VALUES(366, '등산 잡화', 3, 360);
INSERT INTO CATEGORYS VALUES(367, '암벽/클라이밍', 3, 360);
INSERT INTO CATEGORYS VALUES(370, '자동차기기', 2, 300);
INSERT INTO CATEGORYS VALUES(371, '블랙박스', 3, 370);
INSERT INTO CATEGORYS VALUES(372, '후방카메라', 3, 370);
INSERT INTO CATEGORYS VALUES(373, '내비게이션', 3, 370);
INSERT INTO CATEGORYS VALUES(374, '하이패스', 3, 370);
INSERT INTO CATEGORYS VALUES(375, '시동경보기', 3, 370);
INSERT INTO CATEGORYS VALUES(376, '카AV', 3, 370);
INSERT INTO CATEGORYS VALUES(377, '음향기기', 3, 370);
INSERT INTO CATEGORYS VALUES(380, '자동차용품', 2, 300);
INSERT INTO CATEGORYS VALUES(381, '타이어', 3, 380);
INSERT INTO CATEGORYS VALUES(382, '휠', 3, 380);
INSERT INTO CATEGORYS VALUES(383, '램프', 3, 380);
INSERT INTO CATEGORYS VALUES(384, '세차/관리용품', 3, 380);
INSERT INTO CATEGORYS VALUES(385, '스노우체인', 3, 380);
INSERT INTO CATEGORYS VALUES(386, '안전용품', 3, 380);
INSERT INTO CATEGORYS VALUES(387, '엔진용품', 3, 380);
INSERT INTO CATEGORYS VALUES(390, '기타 스포츠', 2, 300);
INSERT INTO CATEGORYS VALUES(391, '사격용품', 3, 390);
INSERT INTO CATEGORYS VALUES(392, '사냥용품', 3, 390);
INSERT INTO CATEGORYS VALUES(393, '숭마용품', 3, 390);

INSERT INTO CATEGORYS VALUES(400, '뷰티', 1, 0);
INSERT INTO CATEGORYS VALUES(410, '스킨케어', 2, 400);
INSERT INTO CATEGORYS VALUES(411, '스킨/토너', 3, 410);
INSERT INTO CATEGORYS VALUES(412, '로션/에멀젼', 3, 410);
INSERT INTO CATEGORYS VALUES(413, '에센스/크림', 3, 410);
INSERT INTO CATEGORYS VALUES(414, '클렌징/스크림', 3, 410);
INSERT INTO CATEGORYS VALUES(415, '팩/마스크', 3, 410);
INSERT INTO CATEGORYS VALUES(420, '썬케어', 2, 400);
INSERT INTO CATEGORYS VALUES(421, '썬크림/썬로션', 3, 420);
INSERT INTO CATEGORYS VALUES(422, '썬스프레이', 3, 420);
INSERT INTO CATEGORYS VALUES(423, '썬파우더', 3, 420);
INSERT INTO CATEGORYS VALUES(430, '메이크업', 2, 400);
INSERT INTO CATEGORYS VALUES(431, '파운데이션', 3, 430);
INSERT INTO CATEGORYS VALUES(432, 'BB/CC크림', 3, 430);
INSERT INTO CATEGORYS VALUES(433, '파우더/팩트', 3, 430);
INSERT INTO CATEGORYS VALUES(434, '쿠션팩트', 3, 430);
INSERT INTO CATEGORYS VALUES(435, '립틴트', 3, 430);
INSERT INTO CATEGORYS VALUES(436, '립스틱', 3, 430);
INSERT INTO CATEGORYS VALUES(437, '아이섀도우', 3, 430);
INSERT INTO CATEGORYS VALUES(438, '마스카라', 3, 430);
INSERT INTO CATEGORYS VALUES(440, '향수/아로마', 2, 400);
INSERT INTO CATEGORYS VALUES(441, '향수', 3, 440);
INSERT INTO CATEGORYS VALUES(442, '남여공용 함수', 3, 440);
INSERT INTO CATEGORYS VALUES(450, '헤어/바디', 2, 400);
INSERT INTO CATEGORYS VALUES(451, '샴푸/린스', 3, 450);
INSERT INTO CATEGORYS VALUES(452, '헤어에센스', 3, 450);
INSERT INTO CATEGORYS VALUES(453, '트리트먼트', 3, 450);
INSERT INTO CATEGORYS VALUES(454, '헤어컬러', 3, 450);
INSERT INTO CATEGORYS VALUES(455, '헤어스타일링', 3, 450);
INSERT INTO CATEGORYS VALUES(456, '바디클렌저', 3, 450);
INSERT INTO CATEGORYS VALUES(457, '핸드/풋케어', 3, 450);
INSERT INTO CATEGORYS VALUES(458, '발모제/탈모', 3, 450);
INSERT INTO CATEGORYS VALUES(460, '네일아트', 2, 400);
INSERT INTO CATEGORYS VALUES(461, '매니큐어', 3, 460);
INSERT INTO CATEGORYS VALUES(462, '페디큐어', 3, 460);
INSERT INTO CATEGORYS VALUES(463, '네일리무버', 3, 460);
INSERT INTO CATEGORYS VALUES(464, '네일케어도구', 3, 460);
INSERT INTO CATEGORYS VALUES(470, '미용 기기', 2, 400);
INSERT INTO CATEGORYS VALUES(471, '뷰티소품', 3, 470);
INSERT INTO CATEGORYS VALUES(472, '파우치', 3, 470);
INSERT INTO CATEGORYS VALUES(473, '피부케어', 3, 470);
INSERT INTO CATEGORYS VALUES(474, '미용가전', 3, 470);
INSERT INTO CATEGORYS VALUES(480, '다이어트', 2, 400);
INSERT INTO CATEGORYS VALUES(481, '여성용품', 3, 480);
INSERT INTO CATEGORYS VALUES(482, '이색뷰티', 3, 480);
INSERT INTO CATEGORYS VALUES(490, '남성 화장품', 2, 400);
INSERT INTO CATEGORYS VALUES(491, '올인원', 3, 490);
INSERT INTO CATEGORYS VALUES(492, '남성스킨', 3, 490);
INSERT INTO CATEGORYS VALUES(493, '남성로션', 3, 490);
INSERT INTO CATEGORYS VALUES(494, '남성에센스', 3, 490);
INSERT INTO CATEGORYS VALUES(495, '남성크림', 3, 490);
INSERT INTO CATEGORYS VALUES(496, '남성BB크림', 3, 490);
INSERT INTO CATEGORYS VALUES(497, '남성클렌징', 3, 490);
INSERT INTO CATEGORYS VALUES(498, '남성마스크팩', 3, 490);

INSERT INTO CATEGORYS VALUES(500, '도서/취미', 1, 0);
INSERT INTO CATEGORYS VALUES(510, '도서/책', 2, 500);
INSERT INTO CATEGORYS VALUES(511, '교양/인문', 3, 510);
INSERT INTO CATEGORYS VALUES(512, '사회/정치', 3, 510);
INSERT INTO CATEGORYS VALUES(513, '경영/경제', 3, 510);
INSERT INTO CATEGORYS VALUES(514, '월간/계간', 3, 510);
INSERT INTO CATEGORYS VALUES(515, '예술/디자인', 3, 510);
INSERT INTO CATEGORYS VALUES(516, '아동/어린이', 3, 510);
INSERT INTO CATEGORYS VALUES(517, '만화', 3, 510);
INSERT INTO CATEGORYS VALUES(520, '취미/키덜트', 2, 500);
INSERT INTO CATEGORYS VALUES(521, '피규어/인형', 3, 520);
INSERT INTO CATEGORYS VALUES(522, '프라모델', 3, 520);
INSERT INTO CATEGORYS VALUES(523, 'RC/무선조종', 3, 520);
INSERT INTO CATEGORYS VALUES(524, 'BB탄총', 3, 520);
INSERT INTO CATEGORYS VALUES(525, '보드게임', 3, 520);
INSERT INTO CATEGORYS VALUES(526, '레고/블럭', 3, 520);
INSERT INTO CATEGORYS VALUES(527, '꽃/원예/팬시', 3, 520);
INSERT INTO CATEGORYS VALUES(530, '희귀/수집품', 2, 500);
INSERT INTO CATEGORYS VALUES(531, '희귀품', 3, 530);
INSERT INTO CATEGORYS VALUES(532, '골동품', 3, 530);
INSERT INTO CATEGORYS VALUES(533, '수집품', 3, 530);
INSERT INTO CATEGORYS VALUES(540, '티켓/항공권', 2, 500);
INSERT INTO CATEGORYS VALUES(541, '콘서트', 3, 540);
INSERT INTO CATEGORYS VALUES(542, '뮤지컬/연극', 3, 540);
INSERT INTO CATEGORYS VALUES(543, '공연/전시', 3, 540);
INSERT INTO CATEGORYS VALUES(544, '영화(예메)', 3, 540);
INSERT INTO CATEGORYS VALUES(545, '테마파크', 3, 540);
INSERT INTO CATEGORYS VALUES(546, '여행/숙박', 3, 540);
INSERT INTO CATEGORYS VALUES(550, '기프티콘', 2, 500);
INSERT INTO CATEGORYS VALUES(551, '커피(음료)', 3, 550);
INSERT INTO CATEGORYS VALUES(552, '베이커리', 3, 550);
INSERT INTO CATEGORYS VALUES(553, '치킨/피자', 3, 550);
INSERT INTO CATEGORYS VALUES(554, '편의점', 3, 550);
INSERT INTO CATEGORYS VALUES(555, '생활(마트)', 3, 550);
INSERT INTO CATEGORYS VALUES(556, '데이터/문자', 3, 550);
INSERT INTO CATEGORYS VALUES(560, '상품권', 2, 500);
INSERT INTO CATEGORYS VALUES(561, '백화점', 3, 560);
INSERT INTO CATEGORYS VALUES(562, '문화/도서', 3, 560);
INSERT INTO CATEGORYS VALUES(563, '외식', 3, 560);
INSERT INTO CATEGORYS VALUES(570, '예술/악기', 2, 500);
INSERT INTO CATEGORYS VALUES(571, '예술/미술', 3, 570);
INSERT INTO CATEGORYS VALUES(572, '재료/도구', 3, 570);
INSERT INTO CATEGORYS VALUES(573, '관악기', 3, 570);
INSERT INTO CATEGORYS VALUES(574, '현악기', 3, 570);
INSERT INTO CATEGORYS VALUES(575, '타악기', 3, 570);
INSERT INTO CATEGORYS VALUES(576, '수공예품', 3, 570);
INSERT INTO CATEGORYS VALUES(580, '교육', 2, 500);
INSERT INTO CATEGORYS VALUES(581, '어학', 3, 580);
INSERT INTO CATEGORYS VALUES(582, '일반', 3, 580);
INSERT INTO CATEGORYS VALUES(583, '교과학습', 3, 580);
INSERT INTO CATEGORYS VALUES(584, '기획세트', 3, 580);
INSERT INTO CATEGORYS VALUES(590, '비즈니스', 2, 500);
INSERT INTO CATEGORYS VALUES(591, '경영', 3, 590);
INSERT INTO CATEGORYS VALUES(592, '총람/연감', 3, 590);
INSERT INTO CATEGORYS VALUES(593, '경제', 3, 590);
INSERT INTO CATEGORYS VALUES(594, '마케팅', 3, 590);
INSERT INTO CATEGORYS VALUES(595, '투자/재테크', 3, 590);
INSERT INTO CATEGORYS VALUES(596, '정부간행물', 3, 590);

INSERT INTO salesWay VALUES (1, '직접거래');
INSERT INTO salesWay VALUES (2, '택배거래');

INSERT INTO productState VALUES (1, '미개봉 새제품');
INSERT INTO productState VALUES (2, '새제품');
INSERT INTO productState VALUES (3, '중고');
INSERT INTO productState VALUES (4, '중고(하자있음)');
INSERT INTO productState VALUES (5, '중고(하자심함)');