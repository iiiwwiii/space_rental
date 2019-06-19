<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%-- JSTL의 함수를 제공하는 taglib --%>
<c:set var="title" value="공간 상세 페이지" scope="request"/>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<style>
.datepick {
	position: relative;
	border: 0;
	background-color: #704de4;
}

.calender {
	margin: auto;
	border: 1px solid #ccccff;
	width: -webkit-fill-available;
}
</style>
<div class="site-loader"></div>

<div class="site-wrap">
	<div class="site-mobile-menu">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close mt-3">
				<span class="icon-close2 js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>
</div>

<div class="site-blocks-cover inner-page-cover overlay" data-aos="fade" data-stellar-background-ratio="0.5"
	style="background-image: url(/spacerental/resources/space/images/hero_bg_2.jpg);"></div>

<!-- 디테일 박스 -->
<div class="site-section site-section-sm container">
	<div class="row">
		<div class="col-lg-8">
			<!-- 제목 -->
			<div class="bg-white property-body border-bottom border-left border-right border-top">
				<div class="row mb-5">
					<div class="col-md-6">
						<h1 class="text-black"><b>${ space.spaceName }</b></h1>
					</div>
				</div>
				<!-- 공간 이미지 -->
				<div>
					<div class="slide-one-item home-slider owl-carousel">
						<c:forEach var="file" items="${ host.files }">
							<img src="/spacerental/resources/files/space-files/${ file.savedFileName }" class="img-fluid">
						</c:forEach>
					</div>
				</div>

				<div class="my-4">
					<h4 class="text-black"><b>공간 소개</b></h4>
<%-- 줄바꿈 문자열을 저장하고 있는 변수 만들기 --%>
<c:set var="enter" value="
" />
					<p class="container">${ fn:replace(space.content, enter, '<br>') }</p>
					<ul class="py-3" style="list-style: none; padding-left: 0px;">
						<li><span class="pr-3 text-black">빔프로젝터</span> <span>${ space.bim }</span></li>
						<li><span class="pr-3 text-black">인터넷/와이파이</span> <span>${ space.wifi }</span></li>
						<li><span class="pr-3 text-black">컴퓨터</span> <span>${ space.computer }</span></li>
					</ul>
				</div>
				
				<!-- 갤러리 -->
				<div class="row no-gutters mt-5">
					<div class="col-12">
						<h4 class="text-black mb-3"><b>Gallery</b></h4>
					</div>
					<c:forEach var="file" items="${ host.files }">
					<div class="col-sm-6 col-md-4 col-lg-3">
						<a href="/spacerental/resources/files/space-files/${ file.savedFileName }" class="image-popup gal-item">
							<img src="/spacerental/resources/files/space-files/${ file.savedFileName }" class="img-fluid">
						</a>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="col-lg-4">
			<div class="bg-white widget border rounded">
				<form action="rent" method="post">
					<input type="hidden" name="spaceNo", id="spaceNo" value="${ space.spaceNo }">
					<h4>${ nowYear }년 ${ nowMonth }월 일정</h4>
					<select name="year" id="year" onchange="change()">
						<c:forEach var="year" begin="2019" end="2020" varStatus="y_status">
							<c:if test="${ year eq nowYear}">
								<option selected>${ y_status.index }</option>
							</c:if>
							<c:if test="${ year ne nowYear}">
								<option >${ y_status.index }</option>
							</c:if>
						</c:forEach>
					</select>년도&nbsp;&nbsp;&nbsp; 
					<select name="month" id="month" onchange="change()">
						<c:forEach var="month" begin="1" end="12" varStatus="m_status">
							<c:if test="${ month eq nowMonth}">
								<option selected>${ m_status.index }</option>
							</c:if>
							<c:if test="${ month ne nowMonth}">
								<option>${ m_status.index }</option>
							</c:if>
						</c:forEach>
					</select>월
					
					<!-- // 요일출력 start -->
					<table class="calender">
						<tr bgcolor="#ccccff">
							<c:forEach var="week" varStatus="i" items="${ strWeek }">
								<c:choose>
									<c:when test="${ i.index eq 0 }">
										<c:set var="color" value="red"/>
									</c:when>
									<c:when test="${ i.index eq 6 }">
										<c:set var="color" value="blue"/>
									</c:when>
									<c:otherwise>
										<c:set var="color" value="black"/>
									</c:otherwise>
								</c:choose>
								<td class="text-center py-1 px-2"><font color="${ color }"><b>${ week }</b></font></td>
							</c:forEach>
						</tr>

					
						<c:forEach var="i" begin="1" end="${ lastDay }">
						<c:if test="${ i eq 1 }">
							<tr>
							<c:forEach begin="0" end="${ week-1 }">
								<td >&nbsp;</td>
							</c:forEach>
						</c:if>
						
							<td class="text-center py-1 px-2" style="cursor: pointer;">
								<input type="radio" id="day${i}" name="day" value="${i}" hidden="hidden" onclick="javascript:dayCheck(${ i })">
								<label for="day${i}"class="date">${i}</label>
							</td>
								<c:set var="week" value="${week+1}"/>
							<c:if test="${ week > 6 }">
								<c:set var="week" value="0"/>
						</tr>
						<tr>
							</c:if>
						</c:forEach>
						</tr>
					</table>
					<h4>시간 선택</h4>
					<div class="row">
						<div class="select col-sm-5">
							<select name="startTime" class="col-12">
								<option>9</option>
								<option>10</option>
								<option>11</option>
								<option>12</option>
								<option>13</option>
								<option>14</option>
							</select>
						</div>
							<font size="6" style="vertical-align: center">~</font>
						<div class="select col-sm-5">
							<select name="endTime" class="col-12">
								<option>20</option>
								<option>21</option>
								<option>22</option>
								<option>23</option>
								<option>24</option>
								<option>1</option>
							</select>
						</div>
					</div>
					<h4>인원 선택</h4>
					<div class="row">
						<input class="col-12 form-control" type="text" name="headCount">
					</div>
					<div class="row justify-content-end">
						<input class="btn btn-primary" type="submit" value="예약">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
	
	
<footer class="site-footer">
	<div class="container">
		<div class="row">
			<div class="col-lg-4">
				<div class="mb-5">
					<h3 class="footer-heading mb-4">About Homeland</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Saepe pariatur reprehenderit vero atque, consequatur id ratione,
						et non dignissimos culpa? Ut veritatis, quos illum totam quis
						blanditiis, minima minus odio!</p>
				</div>
			</div>
			<div class="col-lg-4 mb-5 mb-lg-0">
				<div class="row mb-5">
					<div class="col-md-12">
						<h3 class="footer-heading mb-4">Navigations</h3>
					</div>
					<div class="col-md-6 col-lg-6">
						<ul class="list-unstyled">
							<li><a href="#">Home</a></li>
							<li><a href="#">Buy</a></li>
							<li><a href="#">Rent</a></li>
							<li><a href="#">Properties</a></li>
						</ul>
					</div>
					<div class="col-md-6 col-lg-6">
						<ul class="list-unstyled">
							<li><a href="#">About Us</a></li>
							<li><a href="#">Privacy Policy</a></li>
							<li><a href="#">Contact Us</a></li>
							<li><a href="#">Terms</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-lg-4 mb-5 mb-lg-0">
				<h3 class="footer-heading mb-4">Follow Us</h3>
				<div>
					<a href="#" class="pl-0 pr-3"><span class="icon-facebook"></span></a>
					<a href="#" class="pl-3 pr-3"><span class="icon-twitter"></span></a>
					<a href="#" class="pl-3 pr-3"><span class="icon-instagram"></span></a>
					<a href="#" class="pl-3 pr-3"><span class="icon-linkedin"></span></a>
				</div>
			</div>
		</div>
		<div class="row pt-5 mt-5 text-center">
			<div class="col-md-12">
				<p>
					Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. Copyright &copy;
					<script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
					<script>document.write(new Date().getFullYear());</script>
					All rights reserved | This template is made with 
					<i class="icon-heart text-danger" aria-hidden="true"></i> by 
					<a href="https://colorlib.com" target="_blank">Colorlib</a> Link
					back to Colorlib can't be removed. Template is licensed under CC BY 3.0.
				</p>
			</div>
		</div>
	</div>
</footer>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />