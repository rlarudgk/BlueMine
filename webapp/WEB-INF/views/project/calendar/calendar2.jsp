<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src="${pageContext.request.contextPath}/resources/calendar/index.global.js"></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<!-- moment lib -->
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<script class="cssdesk" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.0/moment.min.js" type="text/javascript"></script>

<main class="content" style="padding-top:0px;">
	<div class="container-fluid p-0">
		<div class="row">
			<!--====================== 캘린더 상단 바 ======================-->
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<div class="d-flex flex-column justify-content-between">
							<h3>캘린더</h3>
						</div>
						<hr>
						<div class="d-flex flex-column justify-content-between">
							<nav aria-label="breadcrumb">
								<ol class="breadcrumb" style="margin: 0px;">
									<li class="breadcrumb-item"><a href="#">프로젝트 홈</a></li>
									<li class="breadcrumb-item active">캘린더</li>
								</ol>
							</nav>
							<div role="tablist" class="d-flex flex-row justify-content-end">
								<button id='dropdownMenuButton' class="nav-link dropdown-toggle btn btn-primary" role="button" data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style="margin-right:1rem;">분류 </button>
			                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			                       <a class="dropdown-item">전체 작업</a>
			                       <a class="dropdown-item">내 작업</a> 
			                     </div>
								<button class="btn btn-primary projectWorkInsertBtn" data-bs-toggle="modal" data-bs-target="#projectWorkInsertModal" data-work-no="\${data.workNo}" style="margin-right:1rem;">작업 추가</button>
								<button type="button" class="btn btn-secondary">작업 삭제</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="row">
			<div class="tab-content">
				<!--====================== 캘린더 컨텐츠 ======================-->
				<div class="tab-pane fade active show" id="tab-1" role="tabpanel">
					<div class="row">
						<div class="col-12">
							<div class="card-header">
								<div id='calendar'></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>


<script>

	// 캘린더
	let calendar = null;
	document.addEventListener('DOMContentLoaded', function() {

		var calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar( calendarEl,
			{
				locale        : 'ko',
				timezone      : "local",
				defaultDate   : new Date(),

				headerToolbar : {
					left      : 'prev,next today',
					center    : 'title',
					right     : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
				},
				initialView   : 'dayGridMonth',
/* 				initialDate   : '2023-01-12', */ // 캘린저 로딩시 처음에 보여질 날짜
				navLinks      : true,
				editable      : true,
				selectable    : true,
				nowIndicator  : true,
				dayMaxEvents  : true,
				dateClick 	  : function(info){
					console.log("hi")
				},
				eventDrop: function( event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view ) {
	                console.log(event.event._instance.range.start);
	                console.log(event.event._instance.range.end);
	                console.log(event);
	            },
				drop: function(date, allDay, event) {
	                alert(date.format());
	            },
				views         : {
				month         : {
									columnFormat : 'dddd'
								},
				agendaWeek    : {
									columnFormat : 'M/D ddd',
									titleFormat : 'YYYY년 M월 D일',
									eventLimit : false
								},
				agendaDay 	  : {
									columnFormat : 'dddd',
									eventLimit : false
								},
				listWeek      : {
									columnFormat : ''
								}
								},
				events		  : function(info, successCallback,failureCallback) {
									$.ajax({
										type : "get",
										url : "${pageContext.request.contextPath}/project/project/workListView/${project.proCode}",
										data : {
										// 화면이 바뀌면 Date 객체인 start, end 가 들어옴
										// startDate : moment(start).format('YYYY-MM-DD'),
										// endDate   : moment(end).format('YYYY-MM-DD')
										},
										beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
								            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								        },
										success : function(data) {
											var events = [];
											console.log("data",
													data);
											for (let i = 0; i < data.length; i++) {
												events.push({
													title : data[i].workTitle,
													color : "#" + Math.round(Math.random() * 0xffffff).toString(16),
													workNo : data[i].workNo,
													start : data[i].workSdate,
													end : data[i].workEdate
												});
											}
											console.log("data2",events);
											successCallback(events);
										}
									});
								},
				eventContent  : function(info) {
					let italicEl = document.createElement('div')
					italicEl.innerHTML = '<div class="calender-droped-event projectWorkDetailBtn" data-bs-toggle="modal" data-bs-target="#projectWorkDetailModal" data-work-no="'+info.event._def.extendedProps.workNo+'">'+ info.event.title + '</div>';
					let arrayOfDomNodes = [ italicEl ]
					return {
						domNodes : arrayOfDomNodes
					}
				},
				

				  //일정 드래그앤드롭
				  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
				    $('.popover.fade.top').remove();
				    console.log(event.view.getCurrentData());
	
				    console.log("insoo",event['event']['_def']['extendedProps']['workNo']);
				    var newDates = calDateWhenDragnDrop(event);
				    newDates['workNo'] = event['event']['_def']['extendedProps']['workNo'];
				    console.log(newDates);

				    $.ajax({
				      url: "${pageContext.request.contextPath}/project/project/calendar/workDateUpdate",
				      method : "post",
						data : JSON.stringify(newDates),
						contentType : "application/json;charset=utf-8;",
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				        },
				      success: function (response) {
				    	  if(response>0){
					        alert('수정 완료: ' + newDates.workSdate + ' ~ ' + newDates.workEdate);
				    		  
				    	  }
				      }
				    });

				  },


			  //일정 리사이즈
			  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
			    $('.popover.fade.top').remove();

			    /** 리사이즈시 수정된 날짜반영
			     * 하루를 빼야 정상적으로 반영됨. */
			    var newDates = calDateWhenDragnDrop(event);
			    newDates['workNo'] = event['event']['_def']['extendedProps']['workNo'];
			    console.log("newDatesss",newDates)
			    //리사이즈한 일정 업데이트
			    $.ajax({
				      url: "${pageContext.request.contextPath}/project/project/calendar/workDateUpdate",
				      method : "post",
						data : JSON.stringify(newDates),
						contentType : "application/json;charset=utf-8;",
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				        },
				      success: function (response) {
				    	  if(response>0){
					        alert('수정 완료: ' + newDates.workSdate + ' ~ ' + newDates.workEdate);
				    		  
				    	  }
				      }
				    });
			  },
			  
				
				
			});
		calendar.render();
	});
	
	
	
	
	// 드랍시 수정된 날짜반영
	function calDateWhenDragnDrop(event) {
		var newDates = {
			workSdate: '',
			workEdate: ''
		}
		console.log("event",event)
		console.log("event2",event['event']['_instance']['range']['start']);
		console.log("event2",event['event']['_instance']['range']['end']);
		
		newDates.workSdate = moment(event['event']['_instance']['range']['start']).format('YYYY-MM-DD');
		newDates.workEdate = moment(event['event']['_instance']['range']['end']).format('YYYY-MM-DD');
		
		return newDates;
	};
	


</script>