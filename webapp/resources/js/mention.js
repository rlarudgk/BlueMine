//<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify"></script>
//<link href="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
//<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>

let alContCd = $("#alarmCd").val();

// 회원 목록 띄우기
var whitelist = [];
$(document).ready(function(){
	let proCode = '${proCode}'
	
	$.ajax({ 
		url : "${pageContext.request.contextPath }/project/mentionMem/"+proCode,
		type : "get",
		dataType : "json",
		success : function(resp) {
// 			console.log("resp : ", resp);

			$.each(resp, function(i,v){
				if(v.partYn==1){
					let obj = {};
					obj["value"] = v.memEmail;
					obj["text"] = v.memName;
					whitelist.push(obj);
				}
			});
			console.log("whitelist",whitelist);
		},
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		}
	});
});

//true : 찾음
let flag = true;
var input = document.querySelector('.cke_contents'),
 tagify = new Tagify(input, {
     mode: 'mix',  
     pattern: /@/,  
     tagTextProp: 'text',  
     whitelist: whitelist.map(function(item){
         return typeof item == 'string' ? {value:item} : item
     }),
     dropdown : {
         enabled: 1,
         position: 'text', // <-- render the suggestions list next to the typed text ("caret")
         mapValueTo: 'text', // <-- similar to above "tagTextProp" setting, but for the dropdown items
         highlightFirst: true  // automatically highlights first sugegstion item in the dropdown
     },
     callbacks: {
         add: function(e){
        	 for(let i = 0; i<whitelist.length; i++){
        		 //찾으면 건너뜀. 못찾으면 if문 실행
	        	 if((whitelist[i].text).indexOf(e.detail.data.text) < 0){
	        			flag = false;
	        	 }else{
	        		    flag = true;
		        		 break;
		         }
	         }
        	 
        	 if(flag){//찾음
        		 console.log("찾음");
        	 }else{//못찾음
        		 console.log("못찾음");
        	 }
         }, 
         remove: function(e){
        	 for(let i = 0; i < mailList.length; i++) {
			  if(mailList[i] === e.detail.data.value)  {
				  mailList.splice(i, 1);
			      i--;
			  }
			}
// 			console.log("mailList", mailList)
        }   
     }
 });

// A good place to pull server suggestion list accoring to the prefix/value
tagify.on('input', function(e){
 	var prefix = e.detail.prefix;
	
	 if( prefix ){
	     if( prefix == '@' )
	         tagify.whitelist = whitelist;
	
	     if( e.detail.value.length > 1 )
	         tagify.dropdown.show(e.detail.value);
	 }
	 console.log( tagify.value )
	 console.log('mix-mode "input" event value: ', e.detail)
})

let mailList = [];	
tagify.on('add', function(e){
	if(flag==true){
		 mailList.push(e.detail.data.value);
// 		 console.log("mailList 찾기", mailList)
	}
});

$("#btnSend").on("click",function(){
	 let AlarmData = { 
			"memEmailList" : mailList, 
			"alContCd" : alContCd,			
	};
// 	console.log("AlarmData : " + JSON.stringify(AlarmData));
	 
	 $.ajax({
	        type: 'POST',
	        url: '${pageContext.request.contextPath}/project/alarmInsert',
	        data: JSON.stringify(AlarmData),
			contentType: "application/json; charset=utf-8",
	        dataType: 'text',
	        beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        success: function(data){    // db전송 성공시 실시간 알림 전송
				
	        	$.ajax({
	        		url : '${pageContext.request.contextPath}/project/alarmNo',
	        		type : 'GET',
	                dataType : 'text',
	        		success : function(resp) {
	        			var alNo=resp;
	        			console.log("alNo", alNo);
	        			
			            // 소켓에 전달되는 메시지
			            let socketMsg = "";
			            $.each(mailList,function(i,v){
			            	socketMsg += "!"+v;
			            });
		            	socketMsg += ","+alContCd+","+alNo;
		//             	console.log("socketMsg",socketMsg)
			            socket.send(socketMsg);	
	        			
	        		}
	        	 })
	        	
	        },
			error : function(err){
				console.log("err : " + JSON.stringify(err));
			}
	  });
});
	
