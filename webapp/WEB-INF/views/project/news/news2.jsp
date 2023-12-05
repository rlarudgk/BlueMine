<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<link
   href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>

<main class="content">
<div class="container-fluid p-0">
   <h1 class="h3 mb-3">내 프로젝트</h1>
   <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
         <li class="breadcrumb-item"><a href="#">프로젝트</a></li>
         <li class="breadcrumb-item active">뉴스</li>
      </ol>
   </nav>
   <hr>
   <div class="row" id="projectNewsListView" style="display:block;">
	   <div class="card">
			<div class="card-header">
				<div class="row">
			    	<div class="col-sm-12 col-md-7">
				       <div class="d-flex justify-content-start"></div>
				    </div>
				    <div class="col-sm-12 col-md-5">
				       <div id="searchUI" class="d-flex justify-content-end">
				          <select name="searchOption" class="form-control" style="width: 20%;">
				             <option value="total">전체</option>
				             <option value="title">제목</option>
				             <option value="writer">생성자</option>
				          </select> <input class="bg-light" type="text" name="searchWord" placeholder="검색어를입력" /> <input class="btn btn-primary" type="button" value="검색" id="searchProjectBtn" />
				       </div>
				    </div>
				</div>
			</div>
			<div class="card-body">
				<div class="row" id="newsAllDisp"></div>
			</div>
			<div class="card-footer">
				<div id="proTotalDisp" class="row" ></div>
				<!-- paging  -->
				<div class="row" id="projectNewsListPagingDisp" style="display:block;">
					<div class="col-sm-12 col-md-12">
						<div class="pagingArea d-flex justify-content-center"></div>
					</div>
					<form id="searchForm" >
					 <input type="text" name="page" /> 
					</form>
				</div>
			</div>
		</div>
   </div>
   
   <div class="row" style="display:none;" id="projectNewsDetailView">
   		<div class="card">
   			<div class="card-header"></div>
   			<div class="card-body" id="projectNewsDetailDisp"></div>
   			<<div class="card-footer">
   		</div>
   </div>
</div>
</main>




<%--  	   <div class="card">
	      <div class="card-header">
				<div class="row">
				    <div class="col-sm-12 col-md-7">
				       <div class="d-flex justify-content-start"></div>
				    </div>
				    <div class="col-sm-12 col-md-5">
				       <div id="searchUI" class="d-flex justify-content-end">
				          <select name="searchOption" class="form-control" style="width: 20%;">
				             <option value="total">전체</option>
				             <option value="title">제목</option>
				             <option value="writer">생성자</option>
				          </select> <input class="bg-light" type="text" name="searchWord" placeholder="검색어를입력" /> <input class="btn btn-primary" type="button" value="검색" id="searchProjectBtn" />
				       </div>
				    </div>
				</div>
	      </div>
	      <div class="card-body">
				
	      </div>
	      <div class="card-footer">
				<div id="proTotalDisp" class="row" ></div>
				<!-- paging  -->
				<div class="row" id="projectNewsListPagingDisp" style="display:block;">
				   <div class="col-sm-12 col-md-12">
				      <div class="pagingArea d-flex justify-content-center"></div>
				   </div>
				</div>
				<!-- 임시 확인용 -->
				<form id="searchForm" ></form>
	      </div>
	   </div> --%>



<!------------------ 뉴스 작성 모달창 --------------------------------->
<button type="button" class="btn btn-primary" data-bs-toggle="modal"
   data-bs-target="#newsModal" style="width: 10%; height: 10%;">뉴스작성</button>

<div class="modal fade" id="newsModal" tabindex="-1"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog  modal-lg">

      <div class="modal-content" id="newswrite">
         <div class="modal-header">

            <h1 class="modal-title fs-5" id="exampleModalLabel">뉴스 추가</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <form id="newsForm" enctype="multipart/form-data">
               <div class="form-group">
                  <label for="news-title-input" class="col-form-label">뉴스 제목</label>
                  <input type="text" class="form-control" name="newsTitle">
               </div>

               <!-- 불러와야함 -->
               <div class="form-group">
                  <input type="hidden" value="${project.memEmail }" name="memEmail">
               </div>

               <div class="form-group">
                  <input type="hidden" value="${project.proCode }" name="proCode">
               </div>

               <th>뉴스내용</th>
               <td><input type="text" name="newsCont" id="editor1" cssClass="form-control" /></td>

               <div class="form-group">
                  <th>비밀번호</th> <input type="text" class="form-control" name="newsPass">
               </div>
               <!------ modal-footer ---------->
               <div class="modal-footer">
                  <input type="file" name="newsfile" accept="image/*">
               </div>

               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
               <button id="newsSaveBtn" type="submit" class="btn btn-success">저장</button>

            </form>
         </div>
      </div>
   </div>
</div>

<!------------------ 뉴스  수정 모달창 --------------------------------->
<div class="modal fade" id="newsUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog  modal-lg">

      <div class="modal-content" id="newsupdatewrite">
         <div class="modal-header">

            <h1 class="modal-title fs-5" id="exampleModalLabel">뉴스 추가</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <form id="newsUpdateForm" enctype="multipart/form-data">
               <div class="form-group">
                  <label for="news-title-input" class="col-form-label">뉴스 제목</label>
                  <input type="text" class="form-control" name="newsTitle" value="${news.newsTitle}"  >
               </div>

               <!-- 불러와야함 -->
               <div class="form-group">
                  <input type="hidden" value="${project.memEmail }" name="memEmail">
               </div>

               <div class="form-group">
                  <input type="hidden" value="${project.proCode }" name="proCode">
               </div>

               <th>뉴스내용</th>
               <td><input type="text" name="newsCont" id="editor2" cssClass="form-control" /></td>
               <script>
                     CKEDITOR.replace('editor2');
               </script>

               <div class="form-group">
                  <th>비밀번호</th> <input type="text" class="form-control"    name="newsPass" >
               </div>
               <!------ modal-footer ---------->
               <div class="modal-footer">
                  <input type="file" name="newsfile" accept="image/*">
               </div>

               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
               <button id="newsUpdateBtn" type="submit" class="btn btn-success">수정완료</button>

            </form>
         </div>
      </div>
   </div>
</div>

<!----------- 삭제확인 모달창   ----------->

<div class="modal fade" id="passConfirmModal" tabindex="-1"
   style="display: none;" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">

         <form id="newsDeleteForm">
            <div class="modal-header">
               <h5 class="modal-title">한번 삭제하면 복구 불가 정말삭제?</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal"
                  aria-label="Close"></button>
            </div>
            <div class="modal-body m-3">
               <div class="mb-3">
                  <label class="form-label">비번을 입력하세요</label> 
                  <input type="text" class="form-control md-3" name="newsPassW" value=""> 
                  <input type="hidden" value="${project.proCode }" name="proCode">
                  <input type="hidden" value="" name="newsNo">
               </div>

            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary "
                  data-bs-dismiss="modal">닫기</button>
               <button id="deleteBtn" type="button" class="btn btn-primary"
                  data-bs-dismiss="modal">삭제</button>
            </div>
         </form>

      </div>
   </div>
</div>

<script>
   CKEDITOR.replace('editor1');
</script>

<script type="text/javascript">

   let newsAllDisp = $("#newsAllDisp");
   let proTotalDisp = $("#proTotalDisp");

   
   
// 뉴스  토탈 템플릿 html
function f_MakeProjectNewsListHtml(newsList){
	let makeprojectNewsListHtml = "";
				for(let i=0; i<newsList.length; i++){
	makeprojectNewsListHtml += ` 
					<div class="col-12 col-md-6 col-lg-4">
					   <div class="card">
					      <div class="card-header">
					         <class="card-title mb-0">글번호 [\${newsList[i].newsNo}] <h2> \${newsList[i].newsTitle }</h2>
					      </div>
					      <img class="card-img-top" src="${pageContext.request.contextPath }/resources/images/pms/800.png" alt="뉴스1">
					      
					      <div class="card-body">
					         <p class="card-text">\${newsList[i].newsCont }</p>
					         
					          <button id="detailBtn" class="btn btn-primary detailBtn" data-news-no="\${newsList[i].newsNo}">자세히보기</button>
					         <h6 class="date">작성일: \${newsList[i].newsDate}</h6>                     
					      </div>
					   </div>
					</div>
					`
				};

	
	return makeprojectNewsListHtml;
}
   
 /////뉴스리스트 Html
   let makeListHtml = function(newsList){
      let ListHtml = "";
      for(let i=0; i < newsList.length; i++){
         ListHtml += `
         <div class="col-12 col-md-6 col-lg-4">
            <div class="card">
               <div class="card-header">
                  <class="card-title mb-0">글번호 [\${newsList[i].newsNo}] <h2> \${newsList[i].newsTitle }</h2>
               </div>
               <img class="card-img-top" src="${pageContext.request.contextPath }/resources/images/pms/800.png" alt="뉴스1">
               
               <div class="card-body">
                  <p class="card-text">\${newsList[i].newsCont }</p>
                  
                   <button id="detailBtn" class="btn btn-primary" data-news-no="\${newsList[i].newsNo}">자세히보기</button>
                  <h6 class="date">작성일: \${newsList[i].newsDate}</h6>                     
               </div>
            </div>
         </div>
         `;
      }
      
      return ListHtml;
   }



/////뉴스리스트 Html
/*    let makeListHtml = function(newsList){
      let ListHtml = "";
         ListHtml += `
         <div class="col-12 col-md-6 col-lg-4">
            <div class="card">
               <div class="card-header">
                  <class="card-title mb-0">글번호 [\${newsList.newsNo}] <h2> \${newsList.newsTitle}</h2>
               </div>
               <img class="card-img-top" src="${pageContext.request.contextPath }/resources/images/pms/800.png" alt="뉴스1">
               
               <div class="card-body">
                  <p class="card-text">\${newsList.newsCont }</p>
                  
                   <button id="detailBtn" class="btn btn-primary" data-news-no="\${newsList.newsNo}">자세히보기</button>
                  <h6 class="date">작성일: \${newsList.newsDate}</h6>                     
               </div>
            </div>
         </div>`;
      return ListHtml;
   } */

///// 뉴스가 없는경우 html
   let NotHtml = function(){
      let ListHtml = "";
      ListHtml += `
      <div class="col-12 col-md-6 col-lg-4">
         <div class="card">
            <p>뉴스가 없어용!!</p>
         </div>
      </div>`;
      return ListHtml;
   }
   
   // paging html
   let pagingArea = $(".pagingArea").on("click", "a.paging", function(event){
      console.log("페이징1");
      event.preventDefault();
      let page = $(this).data("page");
      console.log("page",page);
      if(!page) return false;
      searchForm.find("[name=page]").val(page);
      searchForm.submit();
      return false; 
   });
   
////////상세보기 html
       let makeDetailHtml = function(news){
         let DatailHtml = "";
            DatailHtml += `
            <div class="mb-4">
               [\${news.newsNo}]<h4>
               <h3><strong> \${news.newsTitle}</strong><h3><br>
            <div> 
            <div style="text-align:right"> 조회수: \${news.newsHit} </div>
            <div class="row mb-4">
            
            <div class="col-md-10">
               <div class="text-muted">내용</div>
               <img class="card-img-top" src="${pageContext.request.contextPath }/resources/images/pms/800.png" alt="뉴스1">
               <p>\${news.newsCont}</p>
               <p>비번 : \${news.newsPass}</p>
            </div>
            <div>
            <button id="TryUpdateBtn" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#newsUpdateModal">수정하기 </button>
            <button id="TryDeleteBtn" class="btn btn-danger btn-xs" data-bs-toggle="modal" data-bs-target="#passConfirmModal">삭제하기 </button>
            <button id="GotoList" class="btn btn-primary">목록으로 </button>
            </div>
            
            </div>
            <div class="card">
            <div class="card-header">
               <h5 class="card-title">댓글 작성</h5>
            </div>
            
            <div class="card-body">
               <form>
               
                  <div class="row">
                     <div class="col-md-12">
                        <div class="mb-3">
                           <label class="form-label" for="inputUsername">작성자</label>
                           <input type="text" class="form-control" id="inputUsername" placeholder="작성자">
                        </div>
                        <div class="mb-3">
                           <label class="form-label" for="inputUsername">댓글</label>
                           <textarea rows="2" class="form-control" id="inputBio" placeholder="댓글작성"></textarea>
                        </div>
                     </div>
                  </div>
                  <button type="submit" class="btn btn-primary">댓글작성</button>
               </form>
            </div>
         </div>
      </div>`;
      return DatailHtml;
   }
    


   ////목록으로가기
    $(document).on("click","#GotoList",function(){
       newslist();
    });
   
   //////삭제하기위해
/*    $(document).on("click","#TryDeleteBtn",function(){
      let data = $(this).data('newsNo');
      console.log(data);
      $("#passConfirmModal").find($("input[name='newsNo']")).val(data);
      console.log("ㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈ",$("#passConfirmModal").find($("input[name='newsNo']")).val());
   });
    */
   
//////////// 전체 내 뉴스목록 첫 UI////////////////
   $.ajax({
      url :"${pageContext.request.contextPath }/project/project/news/${project.proCode}",
      method : "get",
      success : function(resp) {
         console.log("ui만뿌림");
         
      },
      error : function(jqXHR, status, error) {
         console.log(jqXHR);
         console.log(status);
         console.log(error);
      }
   });
   
///////////목록 보여주기 /////////////////////
    newslist();
   function newslist(){ 
      $.ajax({
         url : "${pageContext.request.contextPath }/project/project/news/${project.proCode}",
         method : "get",
         dataType : "json",
         success : function(resp) {
            proTotalDisp.empty();
            pagingArea.empty();
            
            console.log("목록뿌림!!!",resp);
            let dataList = resp.pagingVO.dataList;
            console.log("dataList뿌림!-------",dataList);
            document.getElementById("projectNewsListView").style.display = 'block'; 
            document.getElementById("projectNewsDetailView").style.display = 'none'; 
            if(dataList){
               console.log("있음1");
               /* newsAllDisp.html(makeListHtml(dataList)); */
               newsAllDisp.html(f_MakeProjectNewsListHtml(dataList));
               
            }else{
               newsAllDisp.html(NotHtml(dataList));
            }
            
            proTotalDisp.html(dataList);
            
            if(resp.pagingHTML)
               console.log("머딩?");
               pagingArea.html(resp.pagingHTML);      
            
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
    }; 

/////////// 뉴스등록 
   $("#newsSaveBtn").on("click",function(event){
      //let data = $("#newsForm").serialize();   
      event.preventDefault();
      console.log("등록시작합니당");
      let news = {
         newsTitle : $("input[name=newsTitle]").val(),
         memEmail : $("input[name=memEmail]").val(),
         proCode : $("[name=proCode]").val(),
         newsCont: CKEDITOR.instances.editor1.getData(),
         newsPass : $("input[name=newsPass]").val()
      }
       $.ajax({
         url : "${pageContext.request.contextPath }/project/project/newsInsert/${project.proCode}",
         type : "post",
         data : news,
         dataType : "json",
         success : function(resp) {
            console.log(resp);
             $("#newsModal").hide();
             newslist();
            
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
         }
      });
   });
   
////////글 상세 보기 
   $(document).on("click",".detailBtn",function(news){
      let data = this.dataset['newsNo'];
      console.log("상세보기글번호",data);
      
      /* 페이징 안보이게 하는 방법 */
      /* document.getElementById("projectNewsListPagingDisp").style.display = 'none'; */
      
    $.ajax({
         url : "${pageContext.request.contextPath}/project/project/newsDetail/"+data,
         method : "get",
         dataType : "json",
         success : function(resp) {
            console.log("상세보기할꺼얌",resp)
            console.log("ressssssssp",resp)
            /* newsAllDisp.html(makeDetailHtml(resp)); */
            document.getElementById("projectNewsListView").style.display = 'none'; 
            document.getElementById("projectNewsDetailView").style.display = 'block'; 
            $("#projectNewsDetailDisp").html(makeDetailHtml(resp));
         },
         error : function(jqXHR, status, error) {
            console.log(jqXHR);   console.log(status); console.log(error);
         }

      });
   });
          
      // 프로젝트 검색
       let searchForm = $("#searchForm").on("submit", function(event){
         event.preventDefault();
         
         let method = this.method;
         let queryString = $(this).serialize();

         $.ajax({
            
            url : "${pageContext.request.contextPath }/project/project/news/${project.proCode}",
            method : method,
            data : queryString ,
            dataType : "json",
            success : function(resp) {
               console.log(resp);
               
               proTotalDisp.empty();
               pagingArea.empty();
               
               pagingArea.empty();
               searchForm[0].page.value="";
               
               let dataList = resp.pagingVO.dataList;
               
               console.log(dataList);
               
               if(dataList){
                  console.log("있음1");
                  newsAllDisp.html(f_MakeProjectNewsListHtml(dataList));
                  /* newsAllDisp.html(makeListHtml(dataList)); */
               }else{
                  newsAllDisp.html(NotHtml(dataList));
               }
               
               proTotalDisp.html(dataList);
               
               if(resp.pagingHTML)
                  pagingArea.html(resp.pagingHTML);
         
            },
            error : function(jqXHR, status, error) {
               console.log(jqXHR);
               console.log(status);
               console.log(error);
            }
         });
         return false;
      });
      
      // 검색 Form 보내기
      let searchUI = $("#searchUI").on("click", "#searchProjectBtn", function(){
         let inputs = searchUI.find(":input[name]");
         $.each(inputs, function(index, input){
            let name = this.name;
            let value = $(this).val();
            searchForm[0][name].value = value;
         });
         searchForm.submit();
      }); 
 
       
</script>



