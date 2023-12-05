<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal.realMember" var="authMember"/>

<!--====================== 프로젝트 생성 모달 창 ======================-->
<div class="modal fade" id="projectInsertModal" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
		<div class="modal-content" id="projectWorkSelectDetailDisp">
			<div class="modal-header">
				<h5 class="modal-title">프로젝트 생성하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body row">
				<div class="col-md-12 col-xl-12">
					<!--=========== 프로젝트 추가 Form  ==========-->
					<form class="projectWorkAddForm" action="${pageContext.request.contextPath}/project/projectInsert" method="post">
						<input type="hidden" name="proCode" value="${project.proCode }">
						<table class="table table-bordered">
							<tr>
								<th>
									프로젝트 제목
								</th>
								<td>
									<input type="text" name="proTitle" Class="form-control" placeholder="프로젝트 제목을 입력하세요." />
								</td>
							</tr>	
							<tr>
								<th>프로젝트 종류</th>
								<td>
									<select name="proClsCd" class="form-control">
										<option value="PC006" selected>기타</option>
										<option value="PC001">디자인</option>
										<option value="PC002">마케팅</option>
										<option value="PC003">엔지니어링</option>
										<option value="PC004">웹개발</option>
										<option value="PC005">앱개발</option>
									</select>
								</td>
							</tr>

							<input type="hidden" name="memEmail" Class="form-control" value="${authMember.memEmail }" readonly="readonly"/>
					
							<tr>
								<th>프로젝트 시작 날짜</th>
								<td>
									<input type="date" name="proSdate" class="form-control"/>
								</td>
							</tr>
							<tr>
								<th>프로젝트 종료 날짜</th>
								<td>
									<input type="date" name="proEdate" class="form-control"/>
								</td>
							</tr>

							<tr>
								<th>프로젝트 소개</th>
								<td>
								    <textarea name="proDetail" rows="10" cols="80"></textarea>
								</td>
							</tr>
						</table>
						<div class="modal-footer d-flex justify-content-end align-items-center">
							<button type="submit" class="btn btn-primary" data-bs-dismiss="modal">프로젝트 생성</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						</div>
						<security:csrfInput/>
					</form>
				</div>

			</div>
		</div>
	</div>
</div>	
