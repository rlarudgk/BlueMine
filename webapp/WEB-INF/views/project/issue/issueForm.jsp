<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="modal fade" id="centeredModalPrimary" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg isCont" role="document">	
				
		<div class="modal-content">
			<div class="modal-body m-3">
				<form name="issue" id="issueForm" enctype="multipart/form-data" method="post">
					<div class="flexEnd">
						<div class="card-title mb-0" style="display: flex;">
							<div id="workNo" style="align-self:center;padding-right:10px;" class="workNo"></div>
							<div id="issLabelCd"></div>
							<div id="issEmerCd"></div>
						</div>
						<button type="button" class="btn-close float-end reSet" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					
					<div class="d-flex align-items-start" style="margin-top: 20px;">
						<div class="flex-grow-1">
							<table class="table table-bordered">
								<tr>
									<td colspan="2" style="height:400px">
										<div class="card-header">
											<div class="float-start card-title inline" id="issTitle"></div>
											<div class="float-end" id="issStatusCd"></div><br>
											<div class="float-end" id="issRdate"></div>
											<div class="card-title float-end paddingL5">등록일</div>
										</div>
										<div class="card-body">
											<div id="cont" style="height: 350px;padding-top: 100px;"></div>
											<div class="paddingTop">
												<!-- 멘션 -->
												<input id="mention" class="card-title inline menCont" placeholder="@ _ _ _" >
<!-- 															<input class="menCont" > -->
												<div class="flex float-end">
													<div class="card-title mb-0 paddingL5">작성자</div>
													<div class="card-title mb-0" id="memName"></div>
												</div>
												</div>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td style="width:50%">
												<div id="hidden"></div>
												<span class="mb-2 font-weight-bold" id="issSdate"></span>
												<span class="float-end" id="issEedate"></span>
												<div class="progress progress-sm" id="progress">
													<div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100">
													</div>
												</div>
									</td>
									<td>
										<div id="chargerMem" class="flexCenter"></div>
									</td>
								</tr>
							</table>
							<div>
								댓글
							</div>
						</div>
					</div>
					<input type="hidden" id="alarmCd" value="AC002">
				</form>
				<hr>
				<button type="button" id="delete" class="btn btn-secondary" data-bs-dismiss="modal">삭제</button>
				<button type=submit class="btn btn-primary issUpdate">수정</button>
			</div>
		</div>
	</div>	
</div>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<main class="content">
   <div class="container-fluid p-0">

      <a class="btn btn-primary float-end mt-n1 modalPop" id="issCreate">
      <button type="button" class="btn workList" data-bs-toggle="modal" data-bs-target="#centeredModalPrimary" style="padding: 0px; color: currentcolor;">
         New issue
      </button>
      </a>
      
      <div class="mb-3">
         <h1 class="h3 d-inline align-middle">ISSUE</h1>
      </div>
      
      <div class="row list">
      </div>
      
      <!-- BEGIN primary modal -->
         <div class="modal fade" id="centeredModalPrimary" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg isCont" role="document">   
                     
               <div class="modal-content">
                  <div class="modal-body m-3">
                     <form name="issue" id="issueForm" enctype="multipart/form-data" method="post">
                        <security:csrfInput/>
                        <div class="flexEnd">
                           <div class="card-title mb-0" style="display: flex;">
                              <div id="workNo" style="align-self:center;padding-right:10px;" class="workNo"></div>
                              <div id="issLabelCd"></div>
                              <div id="issEmerCd"></div>
                           </div>
                           <button type="button" class="btn-close float-end reSet" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        
                        <div class="d-flex align-items-start" style="margin-top: 20px;">
                           <div class="flex-grow-1">
                              <table class="table table-bordered">
                                 <tr>
                                    <td colspan="2" style="height:400px">
                                       <div class="card-header">
                                          <div class="float-start card-title inline" id="issTitle"></div>
                                          <div class="float-end" id="issStatusCd"></div><br>
                                          <div class="float-end" id="issRdate"></div>
                                          <div class="card-title float-end paddingL5">등록일</div>
                                       </div>
                                       <div class="card-body">
                                          <div id="cont" style="height: 350px;padding-top: 100px;"></div>
                                          <div class="paddingTop">
                                             <!-- 멘션 -->
                                             <input id="mention" class="card-title inline menCont" placeholder="@ _ _ _" >
<!--                                              <input class="menCont" > -->
                                             <div class="flex float-end">
                                                <div class="card-title mb-0 paddingL5">작성자</div>
                                                <div class="card-title mb-0" id="memName"></div>
                                             </div>
                                             </div>
                                          </div>
                                       </div>
                                    </td>
                                 </tr>
                                 <tr>
                                    <td style="width:50%">
                                             <div id="hidden"></div>
                                             <span class="mb-2 font-weight-bold" id="issSdate"></span>
                                             <span class="float-end" id="issEedate"></span>
                                             <div class="progress progress-sm" id="progress">
                                                <div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                                </div>
                                             </div>
                                    </td>
                                    <td>
                                       <div id="chargerMem" class="flexCenter"></div>
                                    </td>
                                 </tr>
                              </table>
                              <div>
                             		   댓글
                              </div>
                           </div>
                        </div>
                        <input type="hidden" id="alarmCd" value="AC002">
                     <hr>
                     <button type="button" id="delete" class="btn btn-secondary" data-bs-dismiss="modal">삭제</button>
                     <button type="button" class="btn btn-primary issUpdate">수정</button>
                     </form>
                  </div>
               </div>
            </div>   
         </div>
      <!-- END primary modal -->
   </div>
</main>
<script>
   //CK EDITOR
   CKEDITOR.replace( 'issCont' );
   let $hidden = $("#hidden");
   //project code
   let proCode = '${project.proCode}'
   // issue 선택자 생성
   let $progress = $("#progress");
   let $workNo = $("#workNo");
   let $issEmerCd = $("#issEmerCd");
   let $issTitle = $("#issTitle");
   let $issStatusCd = $("#issStatusCd");
   let $issRdate = $("#issRdate");
   let $issCont = $("#issCont");
   let $memName = $("#memName");
   let $issSdate = $("#issSdate");
   let $issEedate = $("#issEedate");
   let $chargerMem = $("#chargerMem");
   let $issLabelCd = $("#issLabelCd");
   let moIssNo = 0;
    var checkMem = [];
    
    //초기화
    $('#centeredModalPrimary').on('hidden.bs.modal', function (e) {
          console.log('modal close 및 centeredModalPrimary로 초기화');
          //무엇을 => centeredModalPrimary
          //어떤걸로  => generalModalPrimary
          
          //초기화
//           $("#centeredModalPrimary").html($("#generalModalPrimary").html());
   });

   
   // 모달 띄우기
   $(document).on("click", ".modalPop", function(){
      let modalPop = $(this).attr("id");
      moIssNo = $(this).children("input").text()
      if(modalPop=="issCreate"){
            
            
         // 라벨
         $issLabelCd.before($('<select id="issLabelCd" name="issLabelCd" class="">'
                   +'<option value="IL001">Question</option>'
                   +'<option value="IL002">Bug</option>'
                   +'<option value="IL003">Help</option>'
                   +'<option value="IL004" selected>Notice</option>'
                   +'</select>'));
          $issLabelCd.remove(); // 지우고
          
          $workNo.before($('<select id="workNo" name="workNo" class="workNo"></select>')); 
          $workNo.remove();
          
          // 긴급도
          $issEmerCd.before($('<select id="issEmerCd" name="issEmerCd" value="">'
                   +'<option value="IE001">긴급</option>'
                   +'<option value="IE002">보통</option>'
                   +'<option value="IE003" selected>낮음</option>'
                   +'</select>'));
          
          // 회원목록
          $chargerMem.before('<div id="charger" class="flexCenter"></div>');
          $chargerMem.remove();
          
          $memName.text("계정 주인");
          $issTitle.before( '<input name="issTitle" class="float-start card-title inline form-control" style="width: 50%;" value=""></input>' );
          $issTitle.remove();
          
          $issStatusCd.contents().unwrap().wrap( '<input type="text" class="float-end rtl" id="issStatusCd" name="issStatusCd" value="" readonly></input>');
            
          $("#cont").before('<textarea name="issCont" id="issCont" style="height: 350px;padding-top: 100px;"></textarea>');
          CKEDITOR.replace('issCont');
          $("#cont").remove();
          
          $issRdate.text(toDay());
          $issSdate.before( '<input type="date"  name="issSdate" id="issSdate" class="form-control dateForm" value=""></input>' );
          $issSdate.remove();
          
          $issEedate.before( '<input type="date"  name="issEedate" id="issEedate" class="form-control dateForm float-end" value=""></input>' );
          $issEedate.remove();
          $progress.contents().unwrap();
          $hidden.text("\u00A0시작일 \u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0  종료일");
          $hidden.after('<input type="hidden" name="issNo" id="issNo" value="'+moIssNo+'" </input>')
          $(".issUpdate").before('<button type="submit" id="submitBtn" class="btn btn-primary insert alarmSend">저장</button>');
          $(".issUpdate").remove();
         
          let no =  $("#workNoSelect option:selected").val(); 
//           $("#workNo option:eq(1)").val();
             
          console.log("$workNo", no)

             // 참여회원 목록 불러오기
//           memFnc($workNo.val()); // resp.issue.member.memName
      
      
      }else if(modalPop=="issDetail"){
         console.log("이슈 디테일 들어옴");
         // ================================================================== DETAIL ==================================================================
         $.ajax({
            url : '${pageContext.request.contextPath}/project/issueDetail/'+moIssNo,
            type : 'POST',
               dataType : 'json',
               beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                   xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
               },
            success : function(resp) {
                console.log("상세 issue : ", resp.issue);
                
                
                $workNo.attr('value',resp.issue.work.workNo).text(resp.issue.work.workTitle);
                $issLabelCd.text(LabelText(resp.issue.issLabelCd)).addClass(LabelTag(resp.issue.issLabelCd));
                $issTitle.text(resp.issue.issTitle);
                $issStatusCd.text(StateText(resp.issue.issStatusCd));
                $issRdate.text((resp.issue.issRdate).substring(0, 10));
                $("#cont").text(resp.issue.issCont);
                $memName.text(resp.issue.member.memName);
                $issSdate.text((resp.issue.issSdate).substring(0, 10));
                $issEedate.text((resp.issue.issEedate).substring(0, 10));
                $issEmerCd.html(EmerCdTag(resp.issue.issEmerCd));
                
                // 담당자들 생성
                let selectTag = [];
                 selectTag.push($("<div>").attr('class', 'card-title paddingL5 marBottom').html("담당자"));
                $.each(resp.member,function(i,v){
                    selectTag.push($("<div>").attr('class', 'paddingL5').html(v.MEM_NAME));
                });
                $chargerMem.html(selectTag);
                
                // 퍼센트 게이지 css추가
                $(".progress-bar").css('width', Progress(resp.issue.issSdate, resp.issue.issEedate))
                
               // ================================================================== 수정 페이지 로딩 ==================================================================
               $(".issUpdate").on("click", function(event){
                     
                     // 라벨
                     $issLabelCd.before($('<select id="issLabelCd" name="issLabelCd" class="'+LabelTag(resp.issue.issLabelCd)+'">'
                             +'<option value="IL001">Question</option>'
                             +'<option value="IL002">Bug</option>'
                             +'<option value="IL003">Help</option>'
                             +'<option value="IL004">Notice</option>'
                             +'</select>'));
                      $issLabelCd.remove(); // 지우고
                      $("#issLabelCd").val(resp.issue.issLabelCd).prop("selected", "true");
                      
                      // 회원목록
                      $chargerMem.before('<div id="charger" class="flexCenter"></div>');
                      $chargerMem.remove();

                       //수정페이지 클릭시 참여회원 불러오기
                      memFnc(resp.issue.work.workNo); // resp.issue.member.memName
                      
                      // 담당자 기본값 세팅(선택)위해서 전역변수에 담기
                      $.each(resp.member,function(i,v){
                         checkMem.push(v.MEM_EMAIL);
                      });
                      
                      // 긴급도
                      $issEmerCd.before($('<select id="issEmerCd" name="issEmerCd" value="'+resp.issue.issEmerCd+'">'
                             +'<option value="IE001">긴급</option>'
                             +'<option value="IE002">보통</option>'
                             +'<option value="IE003">낮음</option>'
                             +'</select>'));
                      $("#issEmerCd").val(resp.issue.issEmerCd).prop("selected", "true");
                      
                      
                      $workNo.contents().unwrap().wrap('<select id="workNo" name="workNo" class="workNo" value="'+resp.issue.work.workNo+'"></select>'); 
                      $memName.text(resp.issue.member.memName);
                      $issTitle.contents().unwrap().wrap( '<input name="issTitle" class="float-start card-title inline form-control" style="width: 50%;" value="'+resp.issue.issTitle+'"></input>' );
                      $issStatusCd.contents().unwrap().wrap( '<input type="text" class="float-end rtl" id="issStatusCd" name="issStatusCd" value="'+StateText(resp.issue.issStatusCd)+'" readonly></input>');
                        
                      $("#cont").contents().unwrap().wrap('<textarea name="issCont menCont" id="issCont" style="height: 350px;padding-top: 100px;"></textarea>');
                      // CK EDITOR
                      CKEDITOR.replace('issCont');
                     
                      $issSdate.contents().unwrap().wrap( '<input type="date"  name="issSdate" id="issSdate" class="form-control dateForm" value="'+resp.issue.issSdate+'"></input>' );
                      $issEedate.contents().unwrap().wrap( '<input type="date"  name="issEedate" id="issEedate" class="form-control dateForm float-end" value="'+resp.issue.issEedate+'"></input>' );
                      $progress.contents().unwrap();
                      $hidden.text("\u00A0시작일 \u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0  종료일");
                      $hidden.after('<input type="hidden" name="issNo" id="issNo" value="'+resp.issue.issNo+'" </input>')
                      $(".issUpdate").before('<button type="submit" class="btn btn-primary update">저장</button>');
                      $(".issUpdate").remove();
                  
               });

            },
            error : function(jqXHR, status, error) {
               console.log("jqXHR : " + jqXHR);
               console.log("status : " + status);
               console.log("error : " + error);
                }
           })
      }
      //작업목록 변경 이벤트 발생 시 처리(참여회원 불러오기)
      $(document).on("change",".workNo",function(){
         var workData = $(this).val();
         memFnc(workData);                  
      });
   });
   
   // ================================================================== ISSUE LIST ================================================================== 
//    $(document).ready(function(){
       $.ajax({
             url: '${pageContext.request.contextPath}/project/project/issue/'+proCode,
             method: 'GET',
             dataType : 'json',
             success: function (resp) {
                
//              console.log("resp.issueList : ", resp.issueList);
//              // ui 생성 함수 호출
             let selectTag = [];
             $.each(resp.issueList,function(i,v){
                selectTag.push(ListTag(i,v));
             });
             $(".list").html(selectTag);
             },
            error : function(jqXHR, status, error) {
               console.log(jqXHR);
               console.log(status);
               console.log(error);   
             }   
         })
//    });
   
   
      // ================================================================== INSERT ==================================================================
         
//          $(document).on("submit","#issueForm",function(event){
   $("#issueForm").on("submit",function(event){
      event.preventDefault();
      // 상태코드 수정
      $("[name=issStatusCd]").val(status);
      
      let issChargerList = [];
      let memEmails = $("input[type=checkbox]:checked");
      
      for(let i=0; i< memEmails.length; i++ ){
         let issChargeVO = {
            issNo: $("#issNo").val(),
            memEmail:memEmails[i].value
         }
         issChargerList.push(issChargeVO);
      }

      let issue = {
         issNo:$("#issNo").val(),
         issTitle:$("input[name=issTitle]").val(),
         issCont: CKEDITOR.instances.issCont.getData(),
         issRdate:"",
         issSdate:$("#issSdate").val(),
         issEedate:$("#issEedate").val(),
         issEdate:"",
         issEmerCd:$("#issEmerCd").val(),
         issStatusCd:$("#issStatusCd").val(),
         issLabelCd:$("#issLabelCd").val(),
         work: {
            workNo: $("#workNo").val()
         }, 
         member:{}, 
         issChargerList:issChargerList 
      };
      
      
//       // INSERT 작업
//       let data = $("#issueForm").serialize();
      console.log("data : ", issue);
      
      $.ajax({
         url : "${pageContext.request.contextPath }/project/issueInsert",
         type : "post",
         data :  JSON.stringify(issue),
         dataType : "json",
         contentType : "application/json;charset=utf-8",
         beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
         success : function(resp) {
            console.log("resp : ", resp);
            console.log("message", resp.message);
            // 모달 숨기기
            // $("#hideModal").trigger("click");
            
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
      $(".isCont").val('');
   });
            
   
   // ================================================================== UPDATE ==================================================================
   $(document).on("click",".update", function(event){
      event.preventDefault();
      
      // 상태코드 수정
      $("[name=issStatusCd]").val(status);
      
      
//       let data = $("#issueForm").serialize();
/*
      var data = $("#issueForm").serializeArray();
      data = changeSerialize(data, 'issCont', CKEDITOR.instances.issCont.getData());
      console.log("data : ", data);
      console.log("data : ", JSON.stringify(data));
*/   

      let issChargerList = [];
      let memEmails = $("input[type=checkbox]:checked");
      
      for(let i=0; i< memEmails.length; i++ ){
         let issChargeVO = {
            issNo: $("#issNo").val(),
            memEmail:memEmails[i].value
         }
         issChargerList.push(issChargeVO);
      }

      let data = {
         issNo:$("#issNo").val(),
         issTitle:$("input[name=issTitle]").val(),
         issCont: CKEDITOR.instances.issCont.getData(),
         issRdate:"",
         issSdate:$("#issSdate").val(),
         issEedate:$("#issEedate").val(),
         issEdate:"",
         issEmerCd:$("#issEmerCd").val(),
         issStatusCd:$("#issStatusCd").val(),
         issLabelCd:$("#issLabelCd").val(),
         work: {
            workNo: $("#workNo").val()
         }, 
         member:{}, 
         issChargerList:issChargerList 
      };

      $.ajax({
         url : '${pageContext.request.contextPath }/project/issueUpdate',
         type : "post",
         data :  JSON.stringify(data),
         dataType : "json",
         contentType : "application/json;charset=utf-8",
         beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
         success : function(resp) {
            
            
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
   });
   
   // ================================================================== DELETE ==================================================================
   $(document).on("click","#delete", function(event){
      console.log("issNo", moIssNo)
      
      $.ajax({
         url : '${pageContext.request.contextPath }/project/issueDelete/'+moIssNo,
         type : "post",
         dataType : "html",
         beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
         success : function(resp) {
            console.log(resp)
            
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
      
   });
   
//    function changeSerialize( values, k, v ) {
//        var found = false;
//        for (i = 0; i < values.length && !found; i++) {
//            if ( values[i].name == k ) { 
//                values[i].value = v;
//                found = true;
//            }
//        }
//        if (!found) {
//            values.push(
//                {
//                    name: k,
//                    value: v
//                }   
//            );
//        }
//        return values;
//    }
   
//     $("#workNo option:eq(1)").prop("selected", true);
    
   // 프로젝트 내 작업 목록 띄우기
   $(".issUpdate, .workList").click(function(){
      $.ajax({ 
         url : "${pageContext.request.contextPath }/project/issueWork",
         type : "get",
         dataType : "json",
         success : function(resp) {
//             console.log("resp : ", resp);
            
            let selectTag = [];
            $.each(resp, function(i,v){
               isSelected = false;
               
               if(i==3){
                  isSelected =  true;
               }               
               selectTag.push($("<option>").attr({"value": v.workNo}).attr("selected", isSelected).html(v.workTitle));
            });
            $("#workNo").html(selectTag);
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
   });
   
   // 이슈 담당자 회원 목록 띄우기 & 기본값 선택
   let optionMemTag = function(i, v){
      var result = $("<div>");
       result.append($("<input>").attr({
                  "value":v.memEmail
                  , "type":"checkbox"
                  , "name":"issChargerList.memEmail"
                  }).prop("checked", checkMem.includes(v.memEmail)));
      result.append($("<label>").attr({"for":v.memEmail, "class":"paddingL5"}).html(v.memName));
      return result;
   };
   let memFnc = function(data){
      $.ajax({ 
         url : "${pageContext.request.contextPath }/project/issueMemList",
         type : "get",
         data : {workNo:data},
         dataType : "json",
         success : function(resp) {
            let selectTag = [];
            selectTag.push($("<div>").attr("class","card-title marBottom paddingL5").html("담당자"));
            $.each(resp.memList, function(i,v){
               selectTag.push(optionMemTag(i, v));
            });
            $("#charger").html(selectTag);
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
   }
   

   // ================================================================== AJAX 구역 끝(일반 function) ==================================================================
   
   // 긴급도 생성
   let EmerCdTag = function(code){
//       console.log("code : ",code);
      if(code == "IE001"){
         return $('<div>').attr({'class':'btn btn-github', 'style':'margin-left: 5px'}).html('긴급');
      }else{
         return "&nbsp;";
      }
   }
   
   // 수정페이지 라벨 색상 변경
   $(document).on("change", "#issLabelCd", function(event){
      let color = $(this).find("option:selected").val();
//       console.log("event", event);
//        console.log(LabelTag(color));
         $("#issLabelCd").attr('class',LabelTag(color));
    });
   let toDay = function(){
      let today = new Date();
      let Stoday = today.getFullYear() +
            '-' + ( (today.getMonth()+1) < 9 ? "0" + (today.getMonth()+1) : (today.getMonth()+1) )+
            '-' + ( (today.getDate()) < 9 ? "0" + (today.getDate()) : (today.getDate()) );
      return Stoday;
   }
   let status = "";
   // issSdate 날짜 계산 후 issStatusCd 가공
   $(document).on("change","#issEedate", function(event){
      let issSdate = $("#issSdate").val();
      let issEedate = $("#issEedate").val();
      let Stoday = toDay();
      
       if(issSdate > Stoday){
         status = "IS002";
        }else if(issSdate < Stoday && issEedate > Stoday){
            status = "IS003";
       }
      $("#issStatusCd").attr('value', StateText(status));
    });
   // 상태 텍스트(issStatusCd) 설정
   let StateText= function(label){
      let text="";
      
      if(label == "IS001"){
         text = "종료";
      }else if(label == "IS002"){
         text = "시작 예정";
      }else {
         text = "진행중";
      }
      return text;
   }
   
   // 라벨 텍스트 설정
   let LabelText= function(label){
      let text="";
      
      if(label == "IL001"){
         text = "QUESTION";
      }else if(label == "IL002"){
         text = "BUG";
      }else if(label == "IL003"){
         text = "HELP";
      }else if(label == "IL004"){
         text = "NOTICE";
      }
      return text;
   }
   
   // 라벨 색 지정
   let LabelTag = function(label){
//       console.log("label : ",label);
      let color="";
      
      if(label == "IL001"){
         color = "btn btn-success";
      }else if(label == "IL002"){
         color = "btn btn-danger";
      }else if(label == "IL003"){
         color = "btn btn-warning";
      }else {
         color = "btn btn-primary";
      }
      return color;
   }
   
   // 년 / 월 / 일을 쪼갬 ex)20230301
   let dateCal = function(date){
      var result = date.substring(0, 4)+date.substring(5, 7)+date.substring(8, 10);
      return result;
   }
   
   // 마감기한 퍼센트 계산
   let Progress = function(start, end){
      
      let start_date= dateCal(start);
      let end_date = dateCal(end);
      
      var date = new Date();
      var today = date.getFullYear() +
      '' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
      '' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
      
//       console.log("start_date : ", start_date);
//       console.log("end_date : ", end_date);
//       console.log("today : ", today);

      var total = end_date-start_date;//전체 기간
      var day = end_date-today;//남은 기간
      
//       console.log("total : ", total);
//       console.log("day : ", day);

      var perc = 0;
      if(start_date>today){
         perc = 0;
      }else if(total<=0 || day<=0 || today>end_date){
         perc = 100;
      }else if(day>0 || total>0){
         perc = 100 - Math.floor(day/total*100);         
      }
      var result = perc;
//       console.log("result : ", result);
      
      return result+"%";
   }
   
   // 멤버 선택시 이름 div생성 
   $("#chargerMem").on("click", function(event){
//         let value = $(this).val();
      let name = $(this).find("option:checked").text();
//         let opName = $(this).data("opName")

      while(name){
         var names = $("<div>").html(name)
         $("#issNames").html(names).css('padding-top','12px');
         break;
//            let operator = {mail:value,name:name}
//            opName.push(operator)
//            console.log(opName);
      }
   })
//      .data("opName",[]);
   
   
   
   // issue list ui 생성 함수
   let ListTag = function(i,v){
      // console.log("v : ",v);
      return $("<div>").attr('class', 'col-12 col-md-6 col-lg-3')
            .append($("<div>").attr('class','card')
            .append($("<button>").attr({
                                'type' : 'button'
                              , 'class' : 'btn modalPop'
                              , 'data-bs-toggle' : 'modal'
                              , 'data-bs-target' : '#centeredModalPrimary'
                              , 'id':'issDetail'
            }).css('text-align', 'start')
            .append(
               $("<input>").attr({
                  "type" : "hidden"
               }).html(v.issNo),
               $("<div>").attr('class', 'card-header px-4 pt-4')
               .append(
                    $("<div>").attr('class', 'card-actions float-end').html(StateText(v.issStatusCd))
                  , $("<h5>").attr('class', 'card-title mb-0').html(v.issTitle)
                  , $("<div>").attr('class', LabelTag(v.issLabelCd)).html(LabelText(v.issLabelCd))
                  , EmerCdTag(v.issEmerCd)
                    )
               , $("<div>").attr('class', 'card-body px-4 pt-2')
                  .append(
                       $("<p>").html(v.issCont)
                     , $("<h5>").attr('class', 'rounded-circle me-1').html(v.memName))
               , $("<ul>").attr('class', 'list-group list-group-flush')
                  .append($("<li>").attr('class', 'list-group-item px-4 pb-4')
                     .append($("<p>").attr('class', 'mb-2 font-weight-bold').html("마감 기한")
                              .append($("<span>").attr('class', 'float-end').html(Progress(v.issSdate, v.issEedate)))
                              , $("<div>").attr('class', 'progress progress-sm')
                                 .append($("<div>").attr({
                                                   'class':'progress-bar'
                                                   , 'role':'progressbar'
                                                   , 'aria-valuenow':'100'
                                                   , 'aria-valuemin':'0'                        
                                                   , 'aria-valuemax':'100'
                                                   })
                                                   .css('width', Progress(v.issSdate, v.issEedate))
                        )
                     )
                  )
               )
            )
         )
      }
   
   
</script>