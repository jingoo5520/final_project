<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="/resources/assets/admin/" data-template="vertical-menu-template-free">
<head>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>Dashboard - Analytics | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/resources/assets/admin/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/css/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="/resources/assets/admin/vendor/css/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="/resources/assets/admin/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<link rel="stylesheet" href="/resources/assets/admin/vendor/libs/apex-charts/apex-charts.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="/resources/assets/admin/vendor/js/helpers.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-latest.min.js"></script> -->
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/assets/admin/js/config.js"></script>
<html>
<head>
<script>
let data;
function showToast(title, content) {
	$('#toastTitle').text(title); // 토스트 메시지 제목
    $('#toastBody').text(content); // 토스트 메시지 내용
    
    var toastElement = $('#toastMessage');
    toastElement.removeClass('hide').addClass('show');
	$("#modalToggle").modal('hide'); // 모달이름
	 setTimeout(function() {
		 toastElement.hide();
       }, 2000);
} 
	function showCancelList(pageNo) {
		console.log(pageNo);
		let pagingSize =10;
		let cancel_type = $('input[name="cancel_type"]:checked').map(function () {
			return $(this).val();
		}).get();
		let cancel_status = $('input[name="cancel_status"]:checked').map(function () {
			return $(this).val();
		}).get();
		let cancel_apply_date_start = $('input[name="cancel_apply_date_start"]').val();
		let cancel_apply_date_end = $('input[name="cancel_apply_date_end"]').val();
		if(data == null) {
		Pagingdata = {
		        pageNo: pageNo,
		        pagingSize: pagingSize,
		        cancel_type: cancel_type,
		        cancel_status: cancel_status,
		        cancel_apply_date_start: cancel_apply_date_start,
		        cancel_apply_date_end: cancel_apply_date_end
		    };
		} else {
			Pagingdata = {
			        pageNo: pageNo,
			        pagingSize: pagingSize,
			        cancel_type: data.cancel_type,
			        cancel_status: data.cancel_status,
			        cancel_apply_date_start: data.cancel_apply_date_start,
			        cancel_apply_date_end: data.cancel_apply_date_end
			    };
		}
		$.ajax({
			 url: '/admin/order/searchFilter',
		        type: 'POST',
		        contentType: 'application/json' ,
		        data: JSON.stringify(Pagingdata),
		    	success: function(data) {
		    	let output = "";
			    

		        $.each(data.CancelList, function(index, cancel) {
	
					let isDisabled = (cancel.cancel_status === '취소 완료' || cancel.cancel_status === '취소 철회') ? 'disabled' : '';
		            const formattedDate = new Date(cancel.cancel_apply_date).toISOString().slice(0, 10);
		            
		            output += '<tr>' +
		                
		                '<td>' + cancel.cancel_no + '</td>' +
		                '<td id="cancelOrderId">' + cancel.order_id + '</td>' +
		                '<td>' + cancel.order_product_no + '</td>' +
		                '<td>' + formattedDate + '</td>' +
		                '<td>' + cancel.cancel_complete_date + '</td>' +
		                '<td>' + cancel.cancel_retract_date + '</td>' +
		                '<td>' + cancel.cancel_type + '</td>' +
		                '<td>' + cancel.cancel_status + '</td>' +			          
		                '<td><div class="mt-3">' +
		                '<button type="button" class="btn rounded-pill btn-outline-primary" value="' + cancel.order_product_no + '" data-bs-toggle="modal" data-bs-target="#modifyCancel"'+isDisabled+'>환불</button>' +
		                '</div></td></tr>';
		        });

		        $("#cancelTableBody").html(output);

		        PageNation(data)
		    },
		    error: function(error) {
		        console.error(error); // 에러가 발생한 경우 콘솔에 에러 출력
		    }
		});
	  
	    
	 }
	function PageNation(data) {
	    if (data.CancelList && data.CancelList.length !== 0) {
	        let paginationOutput = "";
	        
	        if (data.PagingInfo.pageNo == 1) {
	            paginationOutput += `<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
	        } else {
	            paginationOutput += `<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="showCancelList(\${data.PagingInfo.pageNo - 1})"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
	        }

	        for (let i = data.PagingInfo.startPageNoCurBlock; i <= data.PagingInfo.endPageNoCurBlock; i++) {
	            console.log(i);
	            if (i == data.PagingInfo.pageNo) {
	                paginationOutput += `<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showCancelList(\${i})">\${i}</a></li>`;
	            } else {
	                paginationOutput += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showCancelList(\${i})">\${i}</a></li>`;
	            }
	        }

	        if (data.PagingInfo.pageNo == data.PagingInfo.totalPageCnt) {
	            paginationOutput += `<li class="page-item next disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
	        } else {
	            paginationOutput += `<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showCancelList(\${data.PagingInfo.pageNo + 1})"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
	        }

	        $('.pagination').html(paginationOutput);
	    } else {
	    	$('.pagination').html("");
	    }
	}
	function restractBtn(cancelNo,orderId) {
		console.log(cancelNo);
		console.log(orderId)
		 $.ajax({
			url : '/admin/order/restractCancelNo' ,
			type : 'POST',
			dataType : 'text' ,
			data : {
				cancelNo : cancelNo
			} ,
			 success: function(response) {
				 console.log(response);
				 $.ajax({
	                    url: '/admin/order/showListByOrderId', // 서버 URL
	                    type: 'POST',
	                    contentType: 'application/x-www-form-urlencoded',
	                    data: { orderId: orderId },
	                    success: function(data) {
	                        let cancelList = data.orderIdList; // 서버에서 받은 cancel 리스트
	                        let cancelListContainer = ""; // 모달의 리스트를 담을 요소
	                        
	                        cancelList.forEach(function (e) {
	                            cancelListContainer += 
	                                '<tr>' +
	                                    '<td class = "modalCancelNo">' + e.cancel_no + '</td>' +
	                                    '<td>' + e.order_id + '</td>' +
	                                    '<td class="modalOrderProductNo">' + e.order_product_no + '</td>' +
	                                    '<td>' + new Date(e.cancel_apply_date).toLocaleString() + '</td>' +
	                                    '<td>' + (e.cancel_complete_date ? new Date(e.cancel_complete_date).toLocaleString() : '없음') + '</td>' +
	                                    '<td>' + (e.cancel_retract_date ? new Date(e.cancel_retract_date).toLocaleString() : '없음') + '</td>' +
	                                    '<td>' + e.cancel_type + '</td>' +
	                                    '<td>' + e.cancel_status + '</td>' +
	                                    '<td>' + e.cancel_reason + '</td>' +
	                                    '<td><div class="mt-3">' +
	                                        '<button type="button" class="btn rounded-pill btn-outline-primary" onclick="restractBtn(' + e.cancel_no + ')">철회 처리</button>' +
	                                    '</div></td>' +
	                                '</tr>';
	                        });

	                        cancelListContainer = '<table class="table"><thead><tr>' +
	                                              '<th>취소 번호</th>' +
	                                              '<th>주문 아이디</th>' +
	                                              '<th>상품 번호</th>' +
	                                              '<th>취소 신청일</th>' +
	                                              '<th>취소 완료일</th>' +
	                                              '<th>취소 철회일</th>' +
	                                              '<th>취소 유형</th>' +
	                                              '<th>취소 상태</th>' +
	                                              '<th>취소 사유</th>' +
	                                              '</tr></thead><tbody class="table-border-bottom-0">' +
	                                              cancelListContainer + '</tbody></table>';

	                        // 모달에 새 리스트를 삽입
	                        $("#cancelListContainer").html(cancelListContainer);
	                      
	                        // 모달 다시 열기
	                        $("#modalToggle2").modal('show');
	                    },
	                    error: function(error) {
	                        console.error(error);  // 에러 시 콘솔에 에러 출력
	                    }
	                });
	       },
	         error: function(error) {
	              console.error(error);  // 에러 시 에러 출력
	       }
		}) 
	}
	function restractBtn2(cancelNo,orderId) {
			console.log(cancelNo);
			console.log(orderId)
			 $.ajax({
				url : '/admin/order/restractCancelNo' ,
				type : 'POST',
				dataType : 'text' ,
				data : {
					cancelNo : cancelNo
				} ,
				 success: function(response) {
					 console.log(response);
					 $.ajax({
		                    url: '/admin/order/showListByOrderId', // 서버 URL
		                    type: 'POST',
		                    contentType: 'application/x-www-form-urlencoded',
		                    data: { orderId: orderId },
		                    success: function(data) {
		                        let cancelList = data.orderIdList; // 서버에서 받은 cancel 리스트
		                        let cancelListContainer = ""; // 모달의 리스트를 담을 요소
		                        
		                        cancelList.forEach(function (e) {
		                            cancelListContainer += 
		                                '<tr>' +
		                                    '<td class = "modalCancelNo">' + e.cancel_no + '</td>' +
		                                    '<td>' + e.order_id + '</td>' +
		                                    '<td class="modalOrderProductNo">' + e.order_product_no + '</td>' +
		                                    '<td>' + new Date(e.cancel_apply_date).toLocaleString() + '</td>' +
		                                    '<td>' + (e.cancel_complete_date ? new Date(e.cancel_complete_date).toLocaleString() : '없음') + '</td>' +
		                                    '<td>' + (e.cancel_retract_date ? new Date(e.cancel_retract_date).toLocaleString() : '없음') + '</td>' +
		                                    '<td>' + e.cancel_type + '</td>' +
		                                    '<td>' + e.cancel_status + '</td>' +
		                                    '<td>' + e.cancel_reason + '</td>' +
		                                    '<td><div class="mt-3">' +
		                                        '<button type="button" class="btn rounded-pill btn-outline-primary" onclick="restractBtn(' + e.cancel_no + ')">철회 처리</button>' +
		                                    '</div></td>' +
		                                '</tr>';
		                        });

		                        cancelListContainer = '<table class="table"><thead><tr>' +
		                                              '<th>취소 번호</th>' +
		                                              '<th>주문 아이디</th>' +
		                                              '<th>상품 번호</th>' +
		                                              '<th>취소 신청일</th>' +
		                                              '<th>취소 완료일</th>' +
		                                              '<th>취소 철회일</th>' +
		                                              '<th>취소 유형</th>' +
		                                              '<th>취소 상태</th>' +
		                                              '<th>취소 사유</th>' +
		                                              '</tr></thead><tbody class="table-border-bottom-0">' +
		                                              cancelListContainer + '</tbody></table>';

		                        // 모달에 새 리스트를 삽입
		                        $("#ListContainer").html(cancelListContainer);
		                        $('#toastTitle').text("철회 완료"); // 토스트 메시지 제목
		                        $('#toastBody').text("철회가 성공했습니다~"); // 토스트 메시지 내용
		                        
		                        var toastElement = $('#toastMessage');
		                        toastElement.removeClass('hide').addClass('show');
		     
		                    	 setTimeout(function() {
		                    		 toastElement.hide();
		                           }, 2000);
		                        // 모달 다시 열기
		                        $("#modifyCancel").modal('show');
		                    },
		                    error: function(error) {
		                        console.error(error);  // 에러 시 콘솔에 에러 출력
		                    }
		                });
		       },
		         error: function(error) {
		              console.error(error);  // 에러 시 에러 출력
		       }
			}) 
		}
	
	$(document).ready(function() { 
			
		    function modifyCancelStatus(amount, cancelList, paymentNo,cancelType,assigned_point) {
		        let data = {
		            amount: amount,
		            cancelList: cancelList,
		            paymentNo: paymentNo,
		            cancelType: cancelType,
		            assigned_point : assigned_point
		        };
		        console.log(data);
		        $.ajax({
		            url: '/admin/order/modifyStatus',
		            type: 'POST',
		            dataType: 'json',
		            contentType: 'application/json',
		            data: JSON.stringify(data),  // data 객체를 JSON 형식으로 문자열화하여 전송
		            success: function(response) {
		               console.log(data);
		            },
		            error: function(error) {
		                console.error(error);  // 에러 시 에러 출력
		            }
		        });
		    }

		function tossCancelRequest(paymentKey, cancelReason, amount = 0, cancelList, paymentNo, cancelType, assigned_point) {
			let encodedSecretKey = null
			let cancelResponse = null
			
			// encodedSecretKey 취득
			$.ajax({
				async: false,
				url: '/order/tossSecretKey',
				type: 'GET',
				dataType: "json",
				success: function(response) {
					encodedSecretKey = response.encodedSecretKey
					console.log("encodedSecretKey : " + encodedSecretKey)
				},
				error: function(xhr, status, error) {
					console.error(`Error: , `);
				   console.error(xhr.responseText);
				}
			})
			
			if (cancelReason == null) {
				cancelReason = ''
			}
			let requestObj = {
				 cancelReason: cancelReason,
			}
			if (amount != null) {
				requestObj.cancelAmount = amount
			}
			
			$.ajax({
				 async: false,
				 url: `https://api.tosspayments.com/v1/payments/\${paymentKey}/cancel`,
				 method: 'POST',
				 headers: {
				   'Authorization': `Basic \${encodedSecretKey}`,
				   'Content-Type': 'application/json',
				 },
				 data: JSON.stringify(requestObj),
				 success: function(response) {
					 cancelResponse = response
					 console.log(response);
			
					modifyCancelStatus(amount,cancelList,paymentNo,cancelType,assigned_point);
				 },
				 error: function(xhr, status, error) {
				   console.error(`Error: , `);
				   console.error(xhr.responseText);
				   showToast("상품 환불","실패하였습니다");
				 }
			});
			return cancelResponse
		}
			
			function kakaopayCancelRequest(paymentId, cancelReason, amount,cancelList,paymentNo,cancelType,assigned_point) {
				let response = null
				$.ajax({
					async: false,
					url: "/order/KakaoPayCancel",
					type: "POST",
					contentType: "application/json",
					dataType: 'json',
					data: JSON.stringify({
						paymentId: paymentId,
						amount: "" + amount,
						cancelReason: cancelReason,
					}),
					success: function(res) {
						response = res.response
						console.log(res);
		
						modifyCancelStatus(amount,cancelList,paymentNo,cancelType,assigned_point);
					},
					error: function(xhr, status, error) {
						console.error(`Error: , `);
						console.error(xhr.responseText);
						showToast("상품 환불","실패하였습니다");
					}
				});
				return JSON.parse(response)
			}
		    function naverpayCancelRequest(paymentId, cancelReason, amount,cancelList,paymentNo,cancelType,assigned_point) {
				let response = null
				$.ajax({
					async: false,
					url: "/order/NaverPayCancel",
					type: "POST",
					contentType: "application/json",
					dataType: 'json',
					data: JSON.stringify({
						paymentId: paymentId,
						amount: "" + amount,
						cancelReason: cancelReason,
					}),
					success: function(res) {
						response = res.response
						console.log(res);
			
						modifyCancelStatus(amount,cancelList,paymentNo,cancelType,assigned_point);
					},
					error: function(xhr, status, error) {
						console.error(`Error: , `);
						console.error(xhr.responseText);
						showToast("상품 환불","실패하였습니다");
					}
				});
				return JSON.parse(response)
			}
			
		    $("#modifyCancel").on('show.bs.modal', function (event) {
		    	let button = $(event.relatedTarget); 

		        // 버튼의 부모 요소에서 #cancelOrderId 찾기
		        let cancelOrderId = button.closest('tr').find("#cancelOrderId").text();
		        $("#ListContainer").empty();
		        console.log(cancelOrderId);
				 $.ajax({
				        url: '/admin/order/showListByOrderId', // 서버 URL
				        type: 'POST',
				        contentType: 'application/x-www-form-urlencoded',
				        data: { orderId: cancelOrderId },
				        success: function(data) {
				            let cancelList = data.orderIdList; // 서버에서 z받은 cancel 리스트
				            let cancelListContainer = ""; // 모달의 리스트를 담을 요소
				            console.log(cancelList);

				            // 테이블 형식으로 데이터 표시
				           cancelListContainer +=  '<table class="table"><thead><tr>' +
				                        '<th>취소 번호</th>' +
				                        '<th>주문 아이디</th>' +
				                        '<th>상품 번호</th>' +
				                        '<th>취소 신청일</th>' +
				                        '<th>취소 완료일</th>' +
				                        '<th>취소 철회일</th>' +
				                        '<th>취소 유형</th>' +
				                        '<th>취소 상태</th>' +
				                        '<th>취소 사유</th>' +
				                    '</tr>' +
				                '</thead>';
				            
				                cancelListContainer += '<tbody class="table-border-bottom-0">';
				            cancelList.forEach(function (e) {
				                cancelListContainer += 
				                    '<tr>' +
				                        '<td class = "modalCancelNo">' + e.cancel_no + '</td>' +
				                        '<td>' + e.order_id + '</td>' +
				                        '<td class = "modalOrderProductNo">' + e.order_product_no + '</td>' +
				                        '<td>' + new Date(e.cancel_apply_date).toLocaleString() + '</td>' +
				                        '<td>' + (e.cancel_complete_date ? new Date(e.cancel_complete_date).toLocaleString() : '없음') + '</td>' +
				                        '<td>' + (e.cancel_retract_date ? new Date(e.cancel_retract_date).toLocaleString() : '없음') + '</td>' +
				                        '<td>' + e.cancel_type + '</td>' +
				                        '<td>' + e.cancel_status + '</td>' +
				                        '<td>' + e.cancel_reason + '</td>' +
				                        '<td><div class="mt-3">' +
						                '<button type="button" class="btn rounded-pill btn-outline-primary" onclick = "restractBtn2(' + e.cancel_no + ', \'' + e.order_id + '\')">철회 처리</button>' +
						                '</div></td>' +
				                    '</tr>';
				            });

				                cancelListContainer += '</tbody>';
				                cancelListContainer += '</table>'; 
				                $("#ListContainer").html(cancelListContainer);
				        },
				        error: function(error) {
				            console.error(error);
				        }
				    }); 
				 $("#confirmDeleteBtn2").off('click').on('click', function() {
					 let orderProductList = [];
					  let cancelList = [];
					  $(".modalOrderProductNo").each(function() {
						  orderProductList.push($(this).text());  
						});
					  
					  $(".modalCancelNo").each(function() {
						  cancelList.push($(this).text());  
						});
			        console.log(orderProductList);
			        console.log(cancelList);
				        $.ajax({
				            url: '/admin/order/cancelOrder', // 서버 URL
				            type: 'POST',
				            contentType: 'application/json' ,
				            data: JSON.stringify({
				            	list: orderProductList
				            }),
				            success: function(data) {
				            	console.log(typeof data.paid_amount);
				            	console.log(typeof data.payment_module_key);
				                console.log(data);
				                $('#toastTitle').text("환불이 성공!"); // 토스트 메시지 제목
				                $('#toastBody').text("환불 완료 되었습니다"); // 토스트 메시지 내용
				                
				                var toastElement = $('#toastMessage');
				                toastElement.removeClass('hide').addClass('show');
				            	 setTimeout(function() {
				            		 toastElement.hide();
				            		 $("#modifyCancel").modal('hide'); // 모달이름
				                   }, 2000);
				            	
				                let canelReason = data.cancel_reason.replace(" ", "").trim();
				                console.log(canelReason);
				                
				                  if(data.payment_method == 'T') {
				                	tossCancelRequest(data.payment_module_key, data.cancel_reason, data.paid_amount, cancelList,data.payment_no,data.cancel_type,data.assigned_point);
				                } else if (data.payment_method == 'K') {
				                	kakaopayCancelRequest(data.payment_module_key, data.canelReason, data.paid_amount,cancelList,data.payment_no,data.cancel_type,data.assigned_point);
				                } else if (data.payment_method == 'N') {
				                	naverpayCancelRequest(data.payment_module_key, data.cancel_reason, data.paid_amount,cancelList,data.payment_no,data.cancel_type,data.assigned_point);
				                }  
				            },
				            error: function(error) {
				                console.error(error); // 에러 시 콘솔에 에러 출력
				            }
				        });
				     });
		    });
		/*     $(".modifyCancelConfirm").on('click',function() {
		    	let cancelNo = parseInt($("#cancelsCancelNo").text().trim());
		    	
		    	  $.ajax({
			            url: '/admin/order/cancelOrder', // 서버 URL
			            type: 'POST',
			            contentType: 'application/json' ,
			            data: JSON.stringify({
			                cancelNo: cancelNo,
			            }),
			            success: function(data) {
			            	console.log(typeof data.paid_amount);
			            	console.log(typeof data.payment_module_key);
			                console.log(data);
			                let canelReason = data.cancel_reason.replace(" ", "").trim();
			                console.log(canelReason);
			                  if(data.payment_method == 'T') {
			                	tossCancelRequest(data.payment_module_key, data.cancel_reason, data.paid_amount = null,cancelNo,data.payment_no,data.cancel_type);
			                } else if (data.payment_method == 'K') {
			                	kakaopayCancelRequest(data.payment_module_key, canelReason, data.paid_amount,cancelNo,data.payment_no,data.cancel_type);
			                } else if (data.payment_method == 'N') {
			                	naverpayCancelRequest(data.payment_module_key, data.cancel_reason, data.paid_amount,cancelNo,data.payment_no,data.cancel_type);
			                }  
			            },
			            error: function(error) {
			                console.error(error); // 에러 시 콘솔에 에러 출력
			            }
			        });
		    }) */
	$('#modalToggle2').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget);
    let orderId = button.parent().find("#orderId").text().replace("주문 아이디 :", "").trim();
    console.log(orderId);
    $("#cancelListContainer").empty();
    $.ajax({
        url: '/admin/order/showListByOrderId', // 서버 URL
        type: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        data: { orderId: orderId },
        success: function(data) {
            let cancelList = data.orderIdList; // 서버에서 z받은 cancel 리스트
            
            let cancelListContainer = ""; // 모달의 리스트를 담을 요소
            console.log(cancelList);

            // 테이블 형식으로 데이터 표시
           cancelListContainer +=  '<table class="table"><thead><tr>' +
                        '<th>취소 번호</th>' +
                        '<th>주문 아이디</th>' +
                        '<th>상품 번호</th>' +
                        '<th>취소 신청일</th>' +
                        '<th>취소 완료일</th>' +
                        '<th>취소 철회일</th>' +
                        '<th>취소 유형</th>' +
                        '<th>취소 상태</th>' +
                        '<th>취소 사유</th>' +
                    '</tr>' +
                '</thead>';
            
                cancelListContainer += '<tbody class="table-border-bottom-0">';
            cancelList.forEach(function (e) {
                cancelListContainer += 
                    '<tr>' +
                        '<td class = "modalCancelNo">' + e.cancel_no + '</td>' +
                        '<td>' + e.order_id + '</td>' +
                        '<td class = "modalOrderProductNo">' + e.order_product_no + '</td>' +
                        '<td>' + new Date(e.cancel_apply_date).toLocaleString() + '</td>' +
                        '<td>' + (e.cancel_complete_date ? new Date(e.cancel_complete_date).toLocaleString() : '없음') + '</td>' +
                        '<td>' + (e.cancel_retract_date ? new Date(e.cancel_retract_date).toLocaleString() : '없음') + '</td>' +
                        '<td>' + e.cancel_type + '</td>' +
                        '<td>' + e.cancel_status + '</td>' +
                        '<td>' + e.cancel_reason + '</td>' +
                        '<td><div class="mt-3">' +
		                '<button type="button" class="btn rounded-pill btn-outline-primary" onclick = "restractBtn(' + e.cancel_no + ', \'' + e.order_id + '\')">철회 처리</button>' +
		                '</div></td>' +
                    '</tr>';
            });
                cancelListContainer += '</tbody>';
                cancelListContainer += '</table>'; 
            $("#cancelListContainer").html(cancelListContainer);
        },
        error: function(error) {
            console.error(error);
        }
    });

    $("#confirmDeleteBtn").off('click').on('click', function() {
			  let orderProductList = [];
			  let cancelList = [];
			  $(".modalOrderProductNo").each(function() {
				  orderProductList.push($(this).text());  
				});
			  
			  $(".modalCancelNo").each(function() {
				  cancelList.push($(this).text());  
				});
	        console.log(orderProductList);
	        console.log(cancelList);
		        $.ajax({
		            url: '/admin/order/cancelOrder', // 서버 URL
		            type: 'POST',
		            contentType: 'application/json' ,
		            data: JSON.stringify({
		            	list: orderProductList
		            }),
		            success: function(data) {
		            	$('#toastTitle').text("환불 성공!"); // 토스트 메시지 제목
		                $('#toastBody').text("환불이 완료되었습니다"); // 토스트 메시지 내용
		                console.log(data);
		                var toastElement = $('#toastMessage');
		                toastElement.removeClass('hide').addClass('show');
		            	$("#modalToggle2").modal('hide'); // 모달이름
		            	 setTimeout(function() {
		            		 toastElement.hide();
		                   }, 2000);
		            	
		                let canelReason = data.cancel_reason.replace(" ", "").trim();
		                console.log(canelReason);
		                 if(data.payment_method == 'T') {
		                	tossCancelRequest(data.payment_module_key, data.cancel_reason, data.paid_amount ,cancelList,data.payment_no,data.cancel_type,data.assigned_point);
		                } else if (data.payment_method == 'K') {
		                	kakaopayCancelRequest(data.payment_module_key, canelReason, data.paid_amount, cancelList,data.payment_no,data.cancel_type,data.assigned_point);
		                } else if (data.payment_method == 'N') {
		                	naverpayCancelRequest(data.payment_module_key, data.cancel_reason, data.paid_amount, cancelList,data.payment_no,data.cancel_type,data.assigned_point);
		                }  
		            },
		            error: function(error) {
		                console.error(error); // 에러 시 콘솔에 에러 출력
		            }
		        });
		     });
    }); 
		
		
		 $("#searchCancel").on('click', function() {
			 let pageNo = 1;
			 let pagingSize = 10;
			let cancel_type = $('input[name="cancel_type"]:checked').map(function () {
				return $(this).val();
			}).get();
			let cancel_status = $('input[name="cancel_status"]:checked').map(function () {
				return $(this).val();
			}).get();
			let cancel_apply_date_start = $('input[name="cancel_apply_date_start"]').val();
			let cancel_apply_date_end = $('input[name="cancel_apply_date_end"]').val();
			data = {
			        pageNo: pageNo,
			        pagingSize: pagingSize,
			        cancel_type: cancel_type,
			        cancel_status: cancel_status,
			        cancel_apply_date_start: cancel_apply_date_start,
			        cancel_apply_date_end: cancel_apply_date_end
			    };
			$.ajax({
				 url: '/admin/order/searchFilter',
			        type: 'POST',
			        contentType: 'application/json' ,
			        data: JSON.stringify(data),
			    	success: function(data) {
			    	let output = "";
				    

			        $.each(data.CancelList, function(index, cancel) {
			        	
 						let isDisabled = (cancel.cancel_status === '취소 완료' || cancel.cancel_status === '취소 철회') ? 'disabled' : '';
			            const formattedDate = new Date(cancel.cancel_apply_date).toISOString().slice(0, 10);
			            
			            output += '<tr>' +
			             
			                '<td>' + cancel.cancel_no + '</td>' +
			                '<td id="cancelOrderId">' + cancel.order_id + '</td>' +
			                '<td>' + cancel.order_product_no + '</td>' +
			                '<td>' + formattedDate + '</td>' +
			                '<td>' + cancel.cancel_complete_date + '</td>' +
			                '<td>' + cancel.cancel_retract_date + '</td>' +
			                '<td>' + cancel.cancel_type + '</td>' +
			                '<td>' + cancel.cancel_status + '</td>' +
			                '<td>' + cancel.cancel_reason + '</td>' +
			                '<td><div class="mt-3">' +
			                '<button type="button" class="btn rounded-pill btn-outline-primary" value="' + cancel.order_id + '" data-bs-toggle="modal" data-bs-target="#modifyCancel"'+ isDisabled +'>환불</button>' +
			                '</div></td></tr>';
			        });

			        $("#cancelTableBody").html(output);

			        PageNation(data)
			    },
			    error: function(error) {
			        console.error(error); // 에러가 발생한 경우 콘솔에 에러 출력
			    }
			});
	})
	});
</script>
</head>
<style>
.modal-body {
	max-height: 400px; /* 최대 높이를 설정 */
	overflow-y: auto; /* 테이블에 스크롤 추가 */
}

/* 테이블 스타일 */
.table {
	width: 100%; /* 테이블 너비를 100%로 설정 */
}
</style>
<body>

	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="adminordercancelview" />

			</jsp:include>
			<!-- / Layout wrapper -->

			<div class="layout-page">
				<!-- Navbar -->
				<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
					<div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
							<i class="bx bx-menu bx-sm"></i>
						</a>
					</div>
				</nav>
				<!-- / Navbar -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"></h4>

						<!-- Basic Layout -->
						<div class="row">
							<h5 class="fw-bold py-3 mb-4">신규 주문 취소 내역</h5>
							<div class="row">

								<c:forEach var="top" items="${TopCancleList}" varStatus="status">
									<c:if test="${status.index < 4}">
										<div class="col-xl">
											<div class="card mb-4">
												<div class="card h-100">
													<h5 class="card-title mt-3" align="center" id="orderNo">주문번호 : ${top.order_product_no}</h5>
													<div class="card-body">
														<p class="card-text" id="orderId">주문 아이디 :${top.order_id}</p>
														<p class="card-text">취소번호 : ${top.cancel_no}</p>
														<p class="card-text">
															신청날짜 :
															<fmt:formatDate value="${top.cancel_apply_date}" pattern="yyyy-MM-dd" />
														</p>
														<p class="card-text" id="cancelStatus">취소타입 : ${top.cancel_type}</p>
														<p class="card-text">취소상태 : ${top.cancel_status}</p>
														<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalToggle2" value="${top.cancel_no}">취소 처리</button>
													</div>
												</div>
											</div>
										</div>

									</c:if>
								</c:forEach>
							</div>
							<div class="row">

								<c:forEach var="top" items="${TopCancleList}" varStatus="status">
									<c:if test="${status.index < 8 && status.index>=4}">
										<div class="col-xl">
											<div class="card mb-4">

												<div class="card h-100">
													<h5 class="card-title mt-3" align="center" id="orderNo">주문번호 : ${top.order_product_no}</h5>
													<div class="card-body">
														<p class="card-text" id="orderId">주문 아이디 : ${top.order_id}</p>
														<p class="card-text">취소번호 : ${top.cancel_no}</p>
														<p class="card-text">
															신청날짜 :
															<fmt:formatDate value="${top.cancel_apply_date}" pattern="yyyy-MM-dd" />
														</p>
														<p class="card-text" id="cancelStatus">취소타입 : ${top.cancel_type}</p>
														<p class="card-text">취소상태 : ${top.cancel_status}</p>
														<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalToggle2" value="${top.cancel_no}">취소 처리</button>
													</div>
												</div>
											</div>
										</div>

									</c:if>
								</c:forEach>
							</div>

							<div class="card mb-4">
								<div class="container-xxl flex-grow-1 container-p-y mb-3">
									<div class="card accordion-item active mb-3">
										<h2 class="accordion-header" id="headingOne">
											<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#accordionOne" aria-expanded="false" aria-controls="accordionOne">
												<h5>검색</h5>
											</button>
										</h2>


										<div id="accordionOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
											<div class="accordion-body">

												<div class="row mb-3" style="border-top: 1px solid">
													<label class="col-sm-2 col-form-label" for="basic-default-name">취소 타입</label>
													<div class="col-sm-10 d-flex align-items-center">
														<div class="form-check-inline" id=>
															<input name="cancel_type" class="form-check-input" type="checkbox" value="cancel" id="cancel_type_c" checked="checked" /> <label class="form-check-label" for="product_m"> 취소 </label>
														</div>
														<div class="form-check-inline">
															<input name="cancel_type" class="form-check-input" type="checkbox" value="return" id="cancel_type_r" checked="checked" /> <label class="form-check-label" for="product_p"> 반품 </label>
														</div>

													</div>
												</div>
												<div class="row mb-3">
													<label class="col-sm-2 col-form-label" for="basic-default-name">취소 상태</label>
													<div class="col-sm-10 d-flex align-items-center">

														<div class="form-check-inline">
															<input name="cancel_status" class="form-check-input" type="checkbox" value="취소 요청" id="cancel_status_wait" checked="checked" /> <label class="form-check-label" for="product_p"> 취소 요청 </label>
														</div>
														<div class="form-check-inline">
															<input name="cancel_status" class="form-check-input" type="checkbox" value="취소 완료" id="cancel_status_comple" checked="checked" /> <label class="form-check-label" for="product_c"> 취소 완료 </label>
														</div>
														<div class="form-check-inline">
															<input name="cancel_status" class="form-check-input" type="checkbox" value="취소 철회" id="cancel_status_comple" checked="checked" /> <label class="form-check-label" for="product_c"> 취소 철회 </label>
														</div>
													</div>
												</div>

												<div class="row mb-3">
													<label class="col-sm-2 col-form-label" for="basic-default-name">취소 신청 날짜</label>
													<div class="col-sm-10 d-flex align-items-center">
														<div class="form-check-inline">
															<input name="cancel_apply_date_start" class="form-control" type="date" value="" id="html5-date-input">
														</div>
														<div class="form-check-inline">
															<span class="mx-2">-</span>
														</div>
														<div class="form-check-inline">
															<input name="cancel_apply_date_end" class="form-control" type="date" value="" id="html5-date-input">
														</div>
													</div>
												</div>
												<div class="row justify-content-end">
													<div class="col-sm-10">
														<button type="button" class="btn btn-primary" id="searchCancel">Search</button>
													</div>
												</div>

											</div>
										</div>
									</div>
									<h5 class="card-header">취소 내역</h5>
									<div class="table-responsive text-nowrap">
										<table class="table">
											<thead class="table-light">
												<tr>

													<th>취소 번호</th>
													<th>주문 번호</th>
													<th>주문 아이디 번호</th>
													<th>취소 신청 날짜</th>
													<th>취소 완료 날짜</th>
													<th>취소 철회 날짜</th>
													<th>취소 유형</th>
													<th>취소 상태</th>
													<th>취소 사유</th>

												</tr>
											</thead>
											<tbody id="cancelTableBody" class="table-border-bottom-0">
												<c:forEach var="cancle" items="${CancleList}">
													<tr>

														<td>${cancle.cancel_no }</td>
														<td>${cancle.order_product_no}</td>
														<td id="cancelOrderId">${cancle.order_id }</td>
														<td><fmt:formatDate value="${cancle.cancel_apply_date}" pattern="yyyy-MM-dd" /></td>
														<td><fmt:formatDate value="${cancle.cancel_complete_date}" pattern="yyyy-MM-dd" /></td>
														<td><fmt:formatDate value="${cancle.cancel_retract_date}" pattern="yyyy-MM-dd" /></td>
														<td>${cancle.cancel_type}</td>
														<td>${cancle.cancel_status}</td>
														<td>${cancle.cancel_reason}</td>
														<td><div class="mt-3">
																<button type="button" class="btn rounded-pill btn-outline-primary " value="${cancle.order_id }" data-bs-toggle="modal" data-bs-target="#modifyCancel" ${cancle.cancel_status == '취소 완료' || cancle.cancel_status == '취소 철회' ? 'disabled' : ''}>환불</button>
															</div></td>
														<td>
													</tr>
												</c:forEach>

											</tbody>
										</table>
									</div>
									<div class="mt-4">
										<nav aria-label="Page navigation">
											<ul class="pagination justify-content-center" id="paging">
												<c:choose>
													<c:when test="${PagingInfo.pageNo == 1}">
														<li class="page-item prev disabled">
															<a class="page-link" href="javascript:void(0);">
																<i class="tf-icon bx bx-chevrons-left"></i>
															</a>
														</li>
													</c:when>
													<c:otherwise>
														<li class="page-item prev">
															<a class="page-link" href="javascript:void(0);">
																<i class="tf-icon bx bx-chevrons-left"></i>
															</a>
														</li>
													</c:otherwise>
												</c:choose>

												<c:forEach var="i" begin="${PagingInfo.startPageNoCurBlock}" end="${PagingInfo.endPageNoCurBlock}">
													<c:choose>
														<c:when test="${PagingInfo.pageNo == i}">
															<li class="page-item active">
																<a class="page-link" href="javascript:void(0);" onclick="showCancelList(${PagingInfo.pageNo})">${i}</a>
															</li>
														</c:when>
														<c:otherwise>
															<li class="page-item">
																<a class="page-link" href="javascript:void(0);" onclick="showCancelList(${i})">${i}</a>
															</li>
														</c:otherwise>
													</c:choose>

												</c:forEach>

												<c:choose>
													<c:when test="${PagingInfo.pageNo == PagingInfo.totalPageCnt}">
														<li class="page-item disabled">
															<a class="page-link" href="javascript:void(0);">
																<i class="tf-icon bx bx-chevrons-right"></i>
															</a>
														</li>
													</c:when>
													<c:otherwise>
														<li class="page-item next">
															<a class="page-link" href="javascript:void(0);" onclick="showCancelList(${i+1})">
																<i class="tf-icon bx bx-chevrons-right"></i>
															</a>
														</li>
													</c:otherwise>
												</c:choose>

											</ul>
										</nav>
									</div>
								</div>



								<!-- Footer -->

							</div>
							<footer class="content-footer footer bg-footer-theme">
								<div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
									<div class="mb-2 mb-md-0">
										©
										<script>
										document
												.write(new Date().getFullYear());
									</script>
										, made with ❤️ by
										<a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
									</div>
									<div>
										<a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
										<a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a>
										<a href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/" target="_blank" class="footer-link me-4">Documentation</a>
										<a href="https://github.com/themeselection/sneat-html-admin-template-free/issues" target="_blank" class="footer-link me-4">Support</a>
									</div>
								</div>
							</footer>
						</div>

					</div>

				</div>
			</div>
			<div class="modal fade" id="modalToggle2" tabindex="-1" style="display: none;" aria-hidden="true">
				<div class="modal-dialog modal-xl" role="document">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalOrderNo">목록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<!-- 취소 항목 리스트가 동적으로 여기에 삽입됩니다 -->
							<div id="cancelListContainer"></div>
							<div>정말로 취소 완료하시겠습니까?</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" id="confirmDeleteBtn">확인</button>
							<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>




			<div class="modal fade" id="modifyCancel" tabindex="-1" style="display: none;" aria-hidden="true">
				<div class="modal-dialog modal-xl" role="document">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalOrderNo2">목록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<!-- 취소 항목 리스트가 동적으로 여기에 삽입됩니다 -->
							<div id="ListContainer"></div>
							<div>정말로 취소 완료하시겠습니까?</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" id="confirmDeleteBtn2">확인</button>
							<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			<div class="bs-toast toast toast-placement-ex m-2 fade bg-secondary top-0 end-0 hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000" id="toastMessage">
				<div class="toast-header">
					<i class="bx bx-bell me-2"></i>
					<div class="me-auto fw-semibold" id="toastTitle"></div>
					<small></small>
					<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body" id="toastBody"></div>
			</div>
			<script src="/resources/assets/admin/vendor/libs/jquery/jquery.js"></script>
			<script src="/resources/assets/admin/vendor/libs/popper/popper.js"></script>
			<script src="/resources/assets/admin/vendor/js/bootstrap.js"></script>
			<script src="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

			<script src="/resources/assets/admin/vendor/js/menu.js"></script>
			<!-- endbuild -->

			<!-- Vendors JS -->
			<script src="/resources/assets/admin/vendor/libs/apex-charts/apexcharts.js"></script>

			<!-- Main JS -->
			<script src="/resources/assets/admin/js/main.js"></script>

			<!-- Page JS -->
			<script src="/resources/assets/admin/js/dashboards-analytics.js"></script>

			<!-- Place this tag in your head or just before your close body tag. -->
			<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>
