<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 

<!-- JStree -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jstree-bootstrap-theme@1.0.1/dist/themes/proton/style.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>




<main class="content" style="padding-top:0px;">
	<div class="container-fluid p-0">
		<div class="row">
				<!--====================== 상단 바 ======================-->
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<div class="d-flex flex-column justify-content-between">
							<h3>파일 관리</h3>
						</div>
						<hr>
						<div class="d-flex flex-column justify-content-between">
							<nav aria-label="breadcrumb">
								<ol class="breadcrumb" style="margin:0px;">
									<li class="breadcrumb-item"><a href="#">프로젝트 홈</a></li>
									<li class="breadcrumb-item active">파일</li>
									
									
								</ol>
							</nav>
							<div role="tablist" class="d-flex flex-row justify-content-end">							
								<div class="list-group list-group-flush d-flex flex-row justify-content-end" role="tablist">
									<form id="ajaxForm">
									    <input type="hidden" name="proCode" value="${proCode }"/>
									    <!-- display:none으로 화면상에서 파일 확인 창을 숨겨둔다 -->
									    <input type="file" id="ajaxFile" name="files" onChange="ajaxFileTransmit();" style="display:none;" multiple="multiple"/>
										<security:csrfInput/>
									</form>
									
									<button type="button" class="btn btn-primary fileUploadBtn" style="margin-right:1rem;" onclick="ajaxFileUpload();">
										파일 등록
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	
			<div class="col-md-5 col-xl-3">
				<div class="card mb-3">
							<div class=" col-md-7">
								<div class="d-flex justify-content-start"></div>
							</div>
					<!-- 검색 폼 -->
								<div id="searchUI" class="d-flex">
									<select name="searchOption" class="form-control" style="width:20%;">
										<option value="total">전체</option>
										<option value="title">제목</option>
										<option value="writer">생성자</option>
									</select>
										<input class="bg-light" type="text" name="searchWord" placeholder="  파일명을 입력하세요" style="width:80%;"/>
									<input class="btn btn-primary" type="button" value="검색" id="searchProjectBtn"  /> 
								</div>
					<!-- 검색 폼 -->
					<div class="card-header">
						<h5 class="card-title mb-0">파일 디렉토리</h5>
					</div>
					<!-- jstree -->
					<div id="jstree" class="m-3">
					</div>
					
				</div>
			</div>
			<div class="col-md-7 col-xl-9">
				<div class="card">
					<div class="card-header">

						<h5 class="card-title mb-0">파일 목록</h5>
					</div>
					<div class="card-body h-100">
						<div class="row row-cols-1 row-cols-md-5 g-4" id="fileListDisp">
							
						</div>
					</div>
				</div>
			</div>
			<!-- 임시 확인용 -->
			<form id="searchForm" style="display:none;">
				<input type="text" name="page" />	
				<input type="text" name="searchOption" placeholder="선택"/>
				<input type="text" name="searchWord" placeholder="검색"/>
				<security:csrfInput/>
			</form>
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="pagingArea d-flex justify-content-center align-items-center"></div>
				</div>
			</div>
		</div>
	</div>
</main>
<script>
let proCode ="${proCode}";
let selectedText = "";
console.log("selectedText",selectedText);
let fileListDisp = $("#fileListDisp");
let makeFileListHtml = function(files){
	let fileListHtml = "";
	for(let i = 0; i<files.length; i++){
		fileListHtml += 
		`
			<div class="col">
				<div class="card">
					<div class="text-end"> <button type="button" id="delBtn" class="btn btn-square" style="" data-att-no="\${files[i].attNo}">X</button> </div>
		`
		if(files[i].attMime.includes("text")){
			fileListHtml += "<img src='/resources/images/icon/textImage.png' class='card-img-top' alt='이미지 없음' style='width:100px; height:100px; display: block; margin: 0px auto;'>"
		}else if(files[i].attMime.includes("image")){
			fileListHtml += "<img src="+files[i].attPath+files[i].attSavename+" class='card-img-top' alt='이미지 없음' style='width:100px; height:100px; display: block; margin: 0px auto;'>"
		}else if(files[i].attMime.includes("x-zip")){
			fileListHtml += "<img src='/resources/images/icon/zipMime.png' class='card-img-top' alt='이미지 없음' style='width:100px; height:100px; display: block; margin: 0px auto;'>"
		}else if(files[i].attMime.includes("pdf")){
			fileListHtml += "<img src='/resources/images/icon/pdfMime.png' class='card-img-top' alt='이미지 없음' style='width:100px; height:100px; display: block; margin: 0px auto;'>"
		}else if(files[i].attMime.includes("xls")){
			fileListHtml += "<img src='/resources/images/icon/xlsMime.png' class='card-img-top' alt='이미지 없음' style='width:100px; height:100px; display: block; margin: 0px auto;'>"
		}else {
			fileListHtml += "<img src='/resources/images/icon/imgMime.jpg' class='card-img-top' alt='이미지 없음' style='width:100px; height:100px; display: block; margin: 0px auto;'>"
		}
			fileListHtml += 
		`
					<div class="card-body pb-0">
						<a href="\${files[i].attPath}\${files[i].attSavename}" download="\${files[i].attFilename}">
							
							<h5 class="card-title" style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
							
							\${files[i].attFilename}</h5>
						</a>
						<p class="text-end" style="font-size:12px; float: right;">\${files[i].attFancysize}</p>
					</div>
				</div>
			</div>
		`
	}
	return fileListHtml;
}

// 페이지 로딩시 트리 로딩
function treeLoad(){
	$.ajax({
		url : "/project/project/fileTree",
		method : "post",
		data : proCode, // JSON.stringify() 쓰면 ""로 묶여감
		dataType : "json", // 안써도 됨
		contentType : "application/json;charset=utf-8", // 안쓰면 P202302150077= 로 감
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
	    success: function(data){
	    	$('#jstree').jstree({ 
				'core' : {
					'data' : data,
					"check_callback" : true
				},
				"plugins": ["contextmenu", "dnd", "search", "state", "types", "cookies"],
				"search" : {
				    "show_only_matches" : true,
				    "show_only_matches_children" : true,
				}
			})
	        .bind('loaded.jstree', function(event, data){ //트리 로딩 완료 이벤트
		       	console.log("트리 로딩");
	        
	        })
	        .bind('select_node.jstree', function(event, data){ // 노드 선택 이벤트
		       	console.log("노드 선택");
		       	selectedText = data.node.text;
		       	
		        let treeData = {
	            		"text" : data.node.text,
	            		"proCode" : proCode
	            }
		       	$(document).on(fileTextLoad(treeData));
	        })
	        .bind("move_node.jstree", function (event, data) { // 노드가 이동한 뒤 처리할 이벤트
		       	console.log("노드 이동");
		       	
	        	let treeData = {
	            		"id" : data.node.id,
	            		"parent" : data.node.parent,
	            		"proCode" : proCode
	            }
	            
	            console.log("트리데이타: ",treeData);	
	            $.ajax({
	        		url : "${pageContext.request.contextPath }/project/project/treeUpdate",
	        		method : "post",
	        		data : JSON.stringify(treeData),
	        		dataType : "json",
	        		contentType : "application/json;charset=utf-8",
	        		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        	    },
	        		success : function(resp) {
	        			console.log("성공? ",resp);
	        	
	        		},
	        		error : function(jqXHR, status, error) {
	        			console.log(jqXHR);
	        			console.log(status);
	        			console.log(error);
	        		}
	        	})
	        })
	        .bind("create_node.jstree", function (event, data) { // node가 create 될때 처리될 event를 적어줍니다.​​
		       	console.log("노드 생성");
	        	
	            
	            let treeData = {
	            		"id" : data.node.id,
	            		"parent" : data.node.parent,
	            		"text" : data.node.text,
	            		"proCode" : proCode
	            }
	            
	            console.log("트리데이타: ",treeData);	
	            $.ajax({
	        		url : "${pageContext.request.contextPath }/project/project/treeInsert",
	        		method : "post",
	        		data : JSON.stringify(treeData),
	        		dataType : "json",
	        		contentType : "application/json;charset=utf-8",
	        		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        	    },
	        		success : function(resp) {
	        			console.log("성공? ",resp);
	        	
	        		},
	        		error : function(jqXHR, status, error) {
	        			console.log(jqXHR);
	        			console.log(status);
	        			console.log(error);
	        		}
	        	})
	        
	        
	       	})
	       	.bind("delete_node.jstree", function (event, data) { // node가 remove 될때 처리될 event를 적어줍니다.​​
	       		console.log("노드 삭제");
	       		
	       		let treeData = {
	            		"id" : data.node.id,
	            		"proCode" : proCode
	            }
	            
	            console.log("트리데이타: ",treeData);	
	            $.ajax({
	        		url : "${pageContext.request.contextPath }/project/project/treeDelete",
	        		method : "post",
	        		data : JSON.stringify(treeData),
	        		dataType : "json",
	        		contentType : "application/json;charset=utf-8",
	        		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        	    },
	        		success : function(resp) {
	        			console.log("성공? ",resp);
	        	
	        		},
	        		error : function(jqXHR, status, error) {
	        			console.log(jqXHR);
	        			console.log(status);
	        			console.log(error);
	        		}
	        	})
	      	})
	
	      	.bind("rename_node.jstree", function (event, data) { // node가 rename 될때 처리될 event를 적어줍니다.
	       		console.log("이름 변경");
	      	
	       	 	let treeData = {
	            		"id" : data.node.id,
	            		"text" : data.node.text,
	            		"proCode" : proCode
	            }
	            
	            console.log("트리데이타: ",treeData);	
	            $.ajax({
	        		url : "${pageContext.request.contextPath }/project/project/treeUpdate",
	        		method : "post",
	        		data : JSON.stringify(treeData),
	        		dataType : "json",
	        		contentType : "application/json;charset=utf-8",
	        		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        	    },
	        		success : function(resp) {
	        			console.log("성공? ",resp);
	        	
	        		},
	        		error : function(jqXHR, status, error) {
	        			console.log(jqXHR);
	        			console.log(status);
	        			console.log(error);
	        		}
	        	})
	    	})
	    },
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		}
	});
}

// 파일 텍스트 목록 불러오기
function fileTextLoad(treeData){
	$.ajax({
		url : "/project/project/fileTextList",
		method : "post",
		data : JSON.stringify(treeData),
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
		success : function(resp) {
			let trTags = [];
			trTags.push(makeFileListHtml(resp));
			fileListDisp.html(trTags);
	
		},
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		}
	})
}

// 파일 전체 목록 로드
function fileLoad(){
	$.ajax({
		url : "/project/project/fileList",
		method : "post",
		data : proCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
		success : function(resp) {
			let trTags = [];
			trTags.push(makeFileListHtml(resp));
			fileListDisp.html(trTags);
	
		},
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		}
	})
}

$(document).on(treeLoad());

// 업로드 버튼이 클릭되면 파일 찾기 창을 띄운다.
function ajaxFileUpload() {
       $("#ajaxFile").click();
   }

// 파일 업로드
function ajaxFileTransmit() {
	let formData = new FormData($("#ajaxForm")[0]);
	formData.append("text", selectedText);
	console.log("formdata[files] : ",formData.getAll("files"));
	console.log("formdata[text] : ",formData.getAll("text"));
    $.ajax({
          url : "${pageContext.request.contextPath }/project/project/fileUpload"
        , method : "POST"
        , processData : false
        , contentType : false
        , data : formData
        , beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        }
        , success:function(resp) {
            console.log("등록된 파일 번호 = ",resp);
            if(resp==0) return;
            let treeData = {
            		"text" : selectedText,
            		"proCode" : proCode
            }
			fileTextLoad(treeData);
        }
    	, error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		}
    });
}

$(document).on("click","#delBtn",function(){
	let attNo = $(this).data("attNo");
	console.log("첨부파일 번호",attNo);
	Swal.fire({
		   title: '삭제 하시겠습니까?',
		   text: '',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: false, // 버튼 순서 거꾸로
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   fileDelete()
		       Swal.fire('삭제 완료되었습니다.', '', 'success');
		   }
		   else{
// 			   Swal.fire('', '삭제 취소하였습니다.', "failed");
			   return;
		   }
		});				
	function fileDelete(){
		$.ajax({
			url : "${pageContext.request.contextPath }/project/project/fileDelete",
			method : "post",
			data : JSON.stringify(attNo),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
			success : function(resp) {
				console.log("성공했니?",resp);
				let treeData = {
	            		"text" : selectedText,
	            		"proCode" : proCode
	            }
				fileTextLoad(treeData);
				
			},
			error : function(jqXHR, status, error) {
				console.log(jqXHR);
				console.log(status);
				console.log(error);
			}
		})
	}
})




</script>