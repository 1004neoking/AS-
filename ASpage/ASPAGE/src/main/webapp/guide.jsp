<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스스로해결</title>
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
    <link href="/css/sb-admin-2.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <style>
      a { text-decoration:none }
      a { color: black};
    </style>

</head>
	<body style="padding-bottom: 70px;">
    <%	// 로그인을 했는지 확인하는 구문
		String userID = null;
		if(session.getAttribute("userID") != null){ //만약 세션값이 null이 아니라면 
			userID = (String) session.getAttribute("userID"); //스트링으로 형변환을 한다
			// userID 변수에 세션값을 String으로 변환해서 넣어둔다	
		}
	%>
	
    <!-- 네비게이션 바 -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="main.jsp">AS 서비스</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">

                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="self.jsp">스스로해결</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="guide.jsp">요금안내</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">서비스예약</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="bbs.jsp">고객의소리</a>
                    </li>
                </ul>
                
                
                <%
                	if(userID == null) { 
                	//만약 userID가 null이라면 로그인이 안되어있는 것이다. 로그인,회원가입을 드랍다운으로 표시함
                %>
                <div class="collapse navbar-collapse justify-content-end">
                  <li class="nav dropdown">
                    <a style="color: black;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      접속하기
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
                      <li><a class="dropdown-item" href="register.jsp">회원가입</a></li>
                    </ul>
                  </li>
                </div>
                
                <%
                	}else { //null이 아니라면 로그인이 되어있는 것이다. 드랍다운으로 로그아웃을 표시
                %>
                <div class="collapse navbar-collapse justify-content-end">
                  <li class="nav dropdown">
                    <a style="color: black;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      회원관리
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                  </li>
                </div>
                <%
                	}
                %>
               
            </div>
        </div>
    </nav>
    
    <div class="container" style="padding-top: 80px;">
        <h1 style="padding-bottom: 20px;">요금안내</h1><hr>
        <h3 style="padding-bottom: 20px;">서비스요금 산정기준</h3>
        <div class="alert alert-secondary" role="alert" >
            서비스 요금은 출장비,부품비,수리비(기술료)의 합계액으로 구성되며 각 요금의 결정은 다음과 같습니다.<br>
            출장 수리시 출장비 외 정확한 비용은 엔지니어가 제품 점검 후 설명 받으실 수 있는 점 양해 부탁드립니다.
        </div>
        <div style="text-align : center; padding-top: 80px;">
        <img src="img/guide.png" alt="">
        </div>

        <div class="row" style="padding-top: 80px;">
            <div class="col-4">
                <h3>출장비</h3><hr>
                <h6>[유상수리] 대상으로 엔지니어 출장 시, 제품 수리 여부와 상관없이 출장비는 18,000원입니다. 단, 평일 18시 이후나 휴일(토/일/공휴일/대체휴일)출장비는 22,000원 청구됩니다.</h6>
            </div>
            <div class="col-4">
                <h3>부품비</h3><hr>
                <h6>수리 시 부품 교체를 할 경우 소요되는 부품가격을 말합니다. 부품비는 부가세 10 % 가 포함된 가격입니다.</h6>
            </div>
            <div class="col-4">
                <h3>수리비(기술료)</h3><hr>
                <h6>수리비는 유료 수리 시 부품비를 제외한 기술료를 말하며 수리 시 소요시간, 난이도 등을 감안하여 산정한 수리비 기준표를 따릅니다.</h6>
            </div>


            <h3 style="padding-top: 60px;">유무상 수리 기준</h3><hr>
            <div class="row"></div>
                <div class="col-3">
                    <h4>1. 무상수리 대상</h4>
                </div>
                <div class="col-9">
                    <h6>품질보증 기간 이내에 정상적인 사용 상태에서 발생한 성능, 기능상의 고장인 경우<br></h6>
                    <h6>엔지니어가 수리한 후 정상적으로 제품을 사용하는 과정에서 12개월 이내에 동일한 부품이 재고장 발생 시 <br>
                        단, 무상수리 기간이 기본으로 연장 적용되는 핵심부품은 제외<br>
                        (제품 구입 기준 핵심부품의 무상수리 기간 종료 시 유상수리 적용)</h6>
                </div><hr>
                <div class="col-3">
                    <h4>2. 유상수리 대상</h4>
                </div>
                <div class="col-9">
                    <div class="alert alert-secondary" role="alert" >
                        무상보증 기간이 경과된 제품
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        제품 고장이 아닌 고객 요청에 의한 제품 점검 (보증기간 내라도 유상 수리)
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        제품의 점검(분해하지 않고 진행한 점검 포함) 및 조정 또는 사용 설명을 요청하는 경우<br>
                        제품 내부의 먼지 및 이물 제거(세척/청소)를 요청하는 경우
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        신제품 초기 설치 후, 추가로 제품을 연결하거나 재설치를 요청하는 경우<br>
                        홈쇼핑, 인터넷 등에서 자가 구입 후 제품 설치를 요청하는 경우<br>
                        제품의 이동, 이사 등으로 인해 설치/연결을 요청하는 경우
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        제품 자체의 문제가 아니고 외부 환경(인터넷, 안테나, 유선 신호 등)에 의해 고장이 발생한 경우<br>
                        타사 제품 (소프트웨어 포함)으로 인해 고장이 발생한 경우
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        떨어뜨림 등 외부 충격에 의해 손상, 고장이 발생한 경우<br>
                        사용설명서에 명시된 올바른 제품 사용 주의사항을 지키지 않아 고장이 발생한 경우<br>
                        제품에 명시된 전기 용량을 틀리게 사용하여 고장이 발생한 경우<br>
                        서비스센터(엔지니어) 외 임의로 수리/개조에 의해 고장이 발생한 경우
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        소모성 부품의 보증기간 및 수명이 다한 경우 (배터리, 형광등, 헤드, 필터류, 램프류, 토너, 잉크 등)<br>
                        지정하지 않은 소모품이나 옵션품을 사용하여 고장이 발생한 경우
                    </div>
                    <div class="alert alert-secondary" role="alert" >
                        천재 지변(낙뢰, 화재, 지진, 풍수해, 해일 등)으로 인해 고장이 발생한 경우
                    </div>
                </div>
                <hr>
            </div>
        </div>
    </div>
</body>
</html>