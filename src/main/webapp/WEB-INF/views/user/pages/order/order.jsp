 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>ELOLIA</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
		 	// 값 출력을 위한 js
			
			let totalPrices = 0;
			let totalOriginalPrices = 0;
			let totalCount = $("div.product-list").length;
			let totalPoints = 0;
			let totalProductDcPrice = 0;
			let totalEarnedPoint = 0;
			let memberLevelPoint = "${orderMember.level_point}";
			let memberLevelDc = "${orderMember.level_dc}";
			
			if (memberLevelPoint == "") {memberLevelPoint = "0"}
			if (memberLevelDc == "") {memberLevelDc = "0"}
			
			console.log("==============뷰에 값 출력==================")
			console.log(`totalPrices : \${totalPrices}`)
			console.log(`totalOriginalPrices : \${totalOriginalPrices}`)
			console.log(`totalCount : \${totalCount}`)
			console.log(`totalPoints : \${totalPoints}`)
			console.log(`totalProductDcPrice : \${totalProductDcPrice}`)
			console.log(`totalEarnedPoint : \${totalEarnedPoint}`)
			console.log("typeof memberLevelPoint : " + typeof memberLevelPoint)
			console.log("typeof memberLevelDc : " + typeof memberLevelPoint)
			console.log(`memberLevelPoint : \${memberLevelPoint}`)
			console.log(`memberLevelDc : \${memberLevelDc}`)
			console.log("==============뷰에 값 출력 종료=============")
			
			console.log(memberLevelDc);
			$(".productPrice").each(function() {
				let productPriceText = parseInt($.trim($(this).text().replace(" 원", "").replace(/,/g, "")));
				totalPrices += productPriceText;
				console.log("totalPrices에 더해지는 값 :" + productPriceText)
			});
			
			$(".originalPrice").each(function() {
				let originalPriceText = parseInt($.trim($(this).text().replace(" 원", "").replace(/,/g, "")));
				totalOriginalPrices += originalPriceText;
				console.log("totalOriginalPrices에 더해지는 값 :" + originalPriceText)
			});

			$(".dcPrice").each(function() {
				let productDcPriceText = parseInt($.trim($(this).text().replace(" 원", "").replace(/,/g, "")));
				totalProductDcPrice += productDcPriceText;
				console.log("totalProductDcPrice에 더해지는 값 :" + productDcPriceText)
			});
			
			let levelDCPrice = Math.floor((totalOriginalPrices * parseFloat(memberLevelDc)) / 10) * 10;
			console.log("=============levelDCPrice 계산하는 곳=============")
			console.log("totalPrices : " + totalPrices)
			console.log("memberLevelDc : " + memberLevelDc)
			console.log("=============levelDCPrice 계산완료================")
			
			
			$("#totalProductCount").text(totalCount + " 개");
			$("#totalProductPrice").text(totalPrices.toLocaleString('ko-KR') + " 원");
			$("#totalDCPrices").text((totalProductDcPrice + levelDCPrice).toLocaleString('ko-KR') + " 원");
			$("#totalOriginalPrices").text(totalOriginalPrices.toLocaleString('ko-KR') + " 원");
			$(".totalProductCount").text(totalCount + " 개");
			$(".totalPrice").text((totalPrices + 2500 - levelDCPrice).toLocaleString('ko-KR') + " 원");
			console.log("=============totalPrice 계산하는 곳=============")
			console.log("totalPrices : " + totalPrices)
			console.log("totalProductDcPrice : " + totalProductDcPrice)
			console.log("levelDCPrice : " + levelDCPrice)
			console.log("배송료 : 2500")
			console.log("=============totalPrice 계산 끝=================")
			
			setTotalEarnedPoint();
			
			// 쿠폰 리스트 호출
			if ("${orderMember}" !== "") {
				console.log("login함 : ${orderMember.member_id}");
				let memberId = "${orderMember.member_id}";
				$.ajax({
					url: '/getCouponList',
					type: 'POST',
					dataType: "json",
					data: { memberId: memberId },
					success: function(data) {
						console.log(data);
						makeCouponListWithData(data);
					},
					error: function(data) {
						console.log(data);
					}
				});
			} else {
				console.log("login 안함 : ${orderMember.member_id}");
			}
			
			// css 및 input 태그 값 수정 js
			
			$('.deliveryOption').change(function() {
		        if ($(this).val() == 'userInput') {
		            $('.deliveryRequest').show();
		        } else {
		            $('.deliveryRequest').hide();
		        }
		    });
			
			$('#saveDeliveryCheck').change(function() {
				let deliveryType = $("#saveDeliveryType").val();
				
	            if ($(this).is(':checked')) {
	                $('.deliveryNameForm').show();
	                $('#deliveryName').val("${orderMember.member_name }님 배송지");
	                
	                if ($('#saveAddressCheck').is(':checked')) {
	                	 $("#saveDeliveryType").val("saveDelivery,saveAddress");
	                } else {
	                	$("#saveDeliveryType").val("saveDelivery");
	                }
	                
	            } else {
	                $('.deliveryNameForm').hide();
	                $('#deliveryName').val("");
	                
	                if ($('#saveAddressCheck').is(':checked')) {
	                	 $("#saveDeliveryType").val("saveAddress");
	                } else {
	                	$("#saveDeliveryType").val("none");
	                }
	            }
	            
	            console.log($("#saveDeliveryType").val());
	        });
			
			$('#saveAddressCheck').change(function() {
	            if ($(this).is(':checked')) {
	            	
	                if ($('#saveDeliveryCheck').is(':checked')) {
	                	 $("#saveDeliveryType").val("saveDelivery,saveAddress");
	                } else {
	                	$("#saveDeliveryType").val("saveAddress");
	                }
	                
	            } else {
	            	
	            	 if ($('#saveDeliveryCheck').is(':checked')) {
	                	 $("#saveDeliveryType").val("saveDelivery");
	                } else {
	                	$("#saveDeliveryType").val("none");
	                }
	            }
	            
	            console.log($("#saveDeliveryType").val());
	        });
			
			$('.deliveryOption').css('color', '#888888');
		    $('.deliveryOption').change(function() {
		        if ($(this).val() === 'default') {

		            $('.deliveryOption option').css('color', '#888888');
		            $('.deliveryOption').css('color', '#888888');
		        } else {

		            $('.deliveryOption option').css('color', 'black');
		            $('.deliveryOption').css('color', 'black');
		        }
		    });
		    
			$('input[name="phoneNumber"]').on('keyup', function() {

			    let inputVal = $(this).val().replace(/[^0-9]/g, '');

			    if (inputVal.length > 11) {
			        inputVal = inputVal.slice(0, 11);
			    }

			    if (inputVal.length > 3 && inputVal.length <= 7) {
			        inputVal = inputVal.replace(/(\d{3})(\d{1,4})/, '$1-$2');
			    } else if (inputVal.length > 7) {
			        inputVal = inputVal.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
			    }
			    
			    $(this).val(inputVal);
			});
			
			$('input[name="point"]').on('focus', function() {
			    // 처음 입력 시 기본값 0을 지웁니다.
			    if ($(this).val() === '0') {
			        $(this).val('');
			    }
			}).on('keyup', function() {

			    let inputVal = $(this).val().replace(/[^0-9]/g, '');
			    
			    console.log(inputVal);
			    
			    let totalPrice = parseInt($.trim($(".totalPrice").eq(0).text().replace(" 원", "").replace(/,/g, ""))) - 2500;
			    console.log(totalPrice);
			    
			    let memberPoint = parseInt($("#memberPoint").text().replace(/,/g, ""));

			    if (memberPoint != null && parseInt(inputVal) > memberPoint) {
			        inputVal = memberPoint;
			    }

			    if (Number(inputVal) > totalPrice) {
			        showOrderModal('포인트는 총 상품 금액을 초과할 수 없습니다.');
			        inputVal = Math.floor(totalPrice / 100) * 100;
			    }
			    
			    $(this).val(inputVal);
			}).on('blur', function() {
			    // 포커스를 잃었을 때 값이 비어 있다면 0으로 설정
			    let inputVal = $(this).val().replace(/[^0-9]/g, '');
			    if (inputVal === '') {
			        $(this).val('0');
			    } else {
			    	inputVal = inputVal === '' ? 0 : Math.floor(inputVal / 100) * 100;
			    	$(this).val(inputVal);
			    }
			});
			
			$('#allPointsUse').change(function() {
				let memberPoint = parseInt($.trim($("#memberPoint").text().replace(/,/g, "")));
				let totalPrice = parseInt($.trim($(".totalPrice").eq(0).text().replace(" 원", "").replace(/,/g, ""))) - 2500;
				
				console.log("memberPoint : " + memberPoint);
				console.log("totalPrice : " + totalPrice);
	            if ($(this).is(':checked')) {
	            	if (memberPoint > totalPrice) {
				    	$('input[name="point"]').val(Math.floor(totalPrice / 100) * 100);
				    } else {
				    	$('input[name="point"]').val(Math.floor(memberPoint / 100) * 100);
				    }
					
	            } else {
	            	$('input[name="point"]').val(0);
	            }
	        });

			$('#deliveryName').on('keyup', function() {
				
			    let inputVal = $(this).val();

			    $('input[name="deliveryName"]').val(inputVal);
			});
			
		})
		
		function setTotalEarnedPoint() {
			if ("${orderMember}".trim().length <= 0) {
				return 0
			}
			let memberLevelPoint = "${orderMember.level_point}";
			
			if (memberLevelPoint != "") {
				let totalPrice = (parseInt($.trim($(".totalPrice").eq(0).text().replace(" 원", "").replace(/,/g, ""))))
				totalEarnedPoint = parseFloat((memberLevelPoint) * (totalPrice - 2500));
				console.log(totalEarnedPoint);
				console.log("================총 적립예정 포인트 계산중================")
				console.log("memberLevelPoint : " + memberLevelPoint)
				console.log("totalPrice : " + totalPrice)
				console.log("totalEarnedPoint : " + totalEarnedPoint)
				console.log("================총 적립예정 포인트 계산완료================")
			}
			// 소수점 반올림
			totalEarnedPoint = Math.round(parseFloat(totalEarnedPoint)) + ""
			$("#totalEarnedPoints").text(totalEarnedPoint.toLocaleString('ko-KR') + " P");
		}
		
		function showDeliveryList() {
			document.getElementById('getMemeberAddress').checked = false;
		    document.getElementById('saveDeliveryCheck').checked = false;
		    document.getElementById('saveAddressCheck').checked = false;
		    $('.deliveryNameForm').hide();
		    $("#saveDeliveryType").val("none");
		    $("#postcodeNew").val("");
		    $("#addressNew").val("");
		    $("#detailAddressNew").val("");
		}
		
		function showInputNewAddress() {
		    $("#saveDeliveryType").val("none");
		    $("#postcodeList").val("");
		    $("#addressList").val("");
		    $("#detailAddressList").val("");
		    $("#deliveryName").val("");
		    $("#savedDeliveryName").val("");
		}
		
		function pointUse() {
			let totalProductDcPrice = parseInt($.trim($("#totalDCPrices").text().replace(" 원", "").replace(/,/g, "")));
			let totalOriginalProductPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			
			let usePoint = Number($('input[name="point"]').val());
			$("#pointDC").text(usePoint.toLocaleString('ko-KR'));
			$("#usePoint").val(usePoint);
			
			$("#totalDCPrices").text((totalProductDcPrice + usePoint).toLocaleString('ko-KR') + " 원");
			
			$(".totalPrice").text((totalOriginalProductPrice - (totalProductDcPrice + usePoint) + 2500).toLocaleString('ko-KR') + " 원");
			
			setTotalEarnedPoint();
			
			$('input[name="point"]').prop("readonly", true);
			$("#allPointsUse").prop('disabled', true);
			$('input[name="point"]').css('background-color', '#E6E6E6');
			
			let output = '<div class="btn" onclick="resetPoint();">취소</div>';
			$("#pointUseDiv").html(output);
		}
		
		function setPointUse(setPoint) {
			let totalProductDcPrice = parseInt($.trim($("#totalDCPrices").text().replace(" 원", "").replace(/,/g, "")));
			let totalOriginalProductPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			
			let usePoint = Number($('input[name="point"]').val());
			$("#usePoint").val(usePoint - setPoint);
			$("#pointDC").text((usePoint - setPoint).toLocaleString('ko-KR'));
			
			$("#totalDCPrices").text((totalProductDcPrice - setPoint).toLocaleString('ko-KR') + " 원");
			
			$(".totalPrice").text((totalOriginalProductPrice - (totalProductDcPrice - setPoint) + 2500).toLocaleString('ko-KR') + " 원");
		
			setTotalEarnedPoint();
			
			$('input[name="point"]').val(usePoint - setPoint);
		}
		
		function resetPoint() {
			let totalProductDcPrice = parseInt($.trim($("#totalDCPrices").text().replace(" 원", "").replace(/,/g, "")));
			let totalOriginalProductPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			
			let usePoint = Number($('input[name="point"]').val());
			$("#pointDC").text("0");
			$('input[name="point"]').val(0);
			$("#allPointsUse").prop('disabled', false);
			$("#allPointsUse").prop('checked', false);
			
			$("#totalDCPrices").text((totalProductDcPrice - usePoint).toLocaleString('ko-KR') + " 원");
			
			$(".totalPrice").text((totalOriginalProductPrice - (totalProductDcPrice) + usePoint + 2500).toLocaleString('ko-KR') + " 원");
			
			setTotalEarnedPoint();
			
			$('input[name="point"]').prop("readonly", false);
			$('input[name="point"]').css('background-color', '#FFFFFF');
			
			let output = '<div class="btn" onclick="pointUse();">사용</div>';
			$("#pointUseDiv").html(output);
		}
		
		function showCouponList(memberId) {
			$("#couponModal").modal("show");
		}
		
		function makeCouponListWithData(json) {
			console.log("coupon Json : " + JSON.stringify(json))
			let output = "";
			let allCoupon = "";
			let couponDCText = "";
			let couponApplyBtnText = "";
			let remainingDaysText = "";
			$.each(json.couponList, function (index, item) {
								
				if (item.member == "All") {
					if (item.coupon_dc_type == "R") {
						couponDCText = `\${item.coupon_dc_rate * 100} %`;
						couponApplyBtnText = `<div class='btn' onclick="applyCouponByRate('\${item.coupon_code}', '\${item.coupon_no}', '\${item.coupon_name}', '\${item.coupon_dc_rate}');">등록</div>`;
					} else if (item.coupon_dc_type == "A"){
						couponDCText = `\${item.coupon_dc_amount} 원`;
						couponApplyBtnText = `<div class='btn' onclick="applyCouponByAmount('\${item.coupon_code}', '\${item.coupon_no}', '\${item.coupon_name}', '\${item.coupon_dc_amount}');">등록</div>`;
					}
					if (item.remaining_days > 14) {
						remainingDaysText = `<span style="color: #0DCAF0">\${item.remaining_days} 일</span>`;
					} else if (item.remaining_days <= 14) {
						remainingDaysText = `<span style="color: #FD5A67">\${item.remaining_days} 일</span>`;
					}
					
					allCoupon += `<div class='couponCard card mb-20' id="\${item.coupon_no}_coupon">
									<div class='card-header'>전체 지급</div>
									<div class='card-body'>
										<h4>\${item.coupon_name}</h4>
										<div class="couponInfo mt-30">
											<p>남은 기한 : \${remainingDaysText}</p>
											<p>지급 날짜 : \${item.pay_date}</p>
										</div>
									</div>
									<div class='card-footer'>
										<div class='button'>
											<h3>\${couponDCText}</h3>
											\${couponApplyBtnText}
										</div>
									</div>
								</div>`;
				} else {
					if (item.coupon_dc_type == "R") {
						couponDCText = `\${item.coupon_dc_rate * 100} %`;
						couponApplyBtnText = `<div class='btn' onclick="applyCouponByRate('\${item.coupon_code}', '\${item.coupon_no}', '\${item.coupon_name}', '\${item.coupon_dc_rate}');">등록</div>`;
					} else if (item.coupon_dc_type == "A"){
						couponDCText = `\${item.coupon_dc_amount} 원`;
						couponApplyBtnText = `<div class='btn' onclick="applyCouponByAmount('\${item.coupon_code}', '\${item.coupon_no}', '\${item.coupon_name}', '\${item.coupon_dc_amount}');">등록</div>`;
					}
					if (item.remaining_days > 14) {
						remainingDaysText = `<span style="color: #0DCAF0">\${item.remaining_days} 일</span>`;
					} else if (item.remaining_days <= 14) {
						remainingDaysText = `<span style="color: #FD5A67">\${item.remaining_days} 일</span>`;
					}
					
					output += `<div class='couponCard card mb-20' id="\${item.coupon_no}_coupon">
								<div class='card-header'>특별 지급</div>
								<div class='card-body'>
									<h4>\${item.coupon_name}</h4>
									<div class="couponInfo mt-30">
										<p>남은 기한 : \${remainingDaysText}</p>
										<p>지급 날짜 : \${item.pay_date}</p>
									</div>
								</div>
								<div class='card-footer'>
									<div class='button'>
										<h3>\${couponDCText}</h3>
										\${couponApplyBtnText}
									</div>
								</div>
							</div>`;
				}
				
				
			});
			output = output + allCoupon;
			
			$("#couponModal .modal-body").html(output);
		}
		
		function applyCouponByRate(couponCode, couponNo, couponName, dcRate) {
			let originalPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			let couponDcPrice = originalPrice * parseFloat(dcRate);
			// 10원 단위 맞추기
			console.log("couponDCPrice in applyCouponByRate : " + couponDcPrice)
			couponDcPrice = Math.floor((Math.floor(couponDcPrice) / 10)) * 10
			console.log("couponDCPrice in applyCouponByRate : " + couponDcPrice)
			
			let output = `<h3>\${dcRate * 100} %</h3>
						<div class='btn' onclick="resetCouponByRate('\${couponCode}', '\${couponNo}', '\${couponName}', '\${dcRate}');">취소</div>`;
			
			applyCouponDc(couponDcPrice);
			applyCouponInfo(couponCode, couponName);
			console.log($("#" + couponNo + "_coupon .button").html());
			$("#" + couponNo + "_coupon .button").html(output);
			
			$('.couponCard').each(function() {
			    var $couponCard = $(this);
			    var id = $couponCard.attr('id');

			    if (id == couponNo + '_coupon') {
			    	$couponCard.css('border', '2px solid #a8a691');
			        $couponCard.find('.button .btn').css('pointer-events', 'auto');
			    } else {
			    	$couponCard.find('.button .btn').css('display', 'none');
			    }
			});
		}
		
		function applyCouponByAmount(couponCode, couponNo, couponName, dcAmount) {
			let couponDcPrice = parseInt(dcAmount);
			let output = `<h3>\${dcAmount} 원</h3>
						<div class='btn' onclick="resetCouponByAmount('\${couponCode}', '\${couponNo}', '\${couponName}', '\${dcAmount}');">취소</div>`;
			
			applyCouponDc(couponDcPrice);
			applyCouponInfo(couponCode, couponName);

			$("#" + couponNo + "_coupon .button").html(output);
			
			$('.couponCard').each(function() {
			    var $couponCard = $(this);
			    var id = $couponCard.attr('id');

			    if (id == couponNo + '_coupon') {
			    	$couponCard.css('border', '2px solid #a8a691');
			        $couponCard.find('.button .btn').css('pointer-events', 'auto');
			    } else {
			        $couponCard.find('.button .btn').css('display', 'none');
			    }
			});
		}
		
		function resetCouponByRate(couponCode, couponNo, couponName, dcRate) {
			let originalPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			let couponDcPrice = originalPrice * parseFloat(dcRate);
			let output = `<h3>\${dcRate * 100} %</h3>
						<div class='btn' onclick="applyCouponByRate('\${couponCode}', '\${couponNo}', '\${couponName}', '\${dcRate}');">등록</div>`;
			
			resetCouponDc(parseInt(couponDcPrice));
			resetCouponInfo(couponCode, couponName);
			$("#" + couponNo + "_coupon .button").html(output);
			
			$('.couponCard').each(function() {
			    var $couponCard = $(this);
			    $couponCard.css('border', '1px solid rgba(0, 0, 0, .125)');
			    $couponCard.find('.button .btn').show();
			});
		}
		
		function resetCouponByAmount(couponCode, couponNo, couponName, dcAmount) {
			let couponDcPrice = parseInt(dcAmount);
			let output = `<h3>\${dcAmount} 원</h3>
						<div class='btn' onclick="applyCouponByAmount('\${couponCode}', '\${couponNo}', '\${couponName}', '\${dcAmount}');">등록</div>`;
			
			resetCouponDc(parseInt(couponDcPrice));
			resetCouponInfo(couponCode, couponName);
			$("#" + couponNo + "_coupon .button").html(output);
			
			$('.couponCard').each(function() {
			    var $couponCard = $(this);
			    $couponCard.css('border', '1px solid rgba(0, 0, 0, .125)');
			    $couponCard.find('.button .btn').show();
			});
		}
		
		
		function applyCouponInfo(couponCode, couponName) {
			$("#couponUse").val(couponCode);
			$("#couponName").val(couponName);
			
			$("#couponModal").modal('hide');
		}
		
		function resetCouponInfo(couponCode, couponName) {
			$("#couponUse").val("");
			$("#couponName").val("");
		}
		
		function applyCouponDc(couponDcPrice) {
			let totalOriginalProductPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			let totalProductDcPrice = parseInt($.trim($("#totalDCPrices").text().replace(" 원", "").replace(/,/g, "")));
			$("#totalDCPrices").text((totalProductDcPrice + couponDcPrice).toLocaleString('ko-KR') + " 원");
			$(".totalPrice").text((totalOriginalProductPrice - (totalProductDcPrice + couponDcPrice) + 2500).toLocaleString('ko-KR') + " 원");
			console.log("=============totalPrice 계산하는 곳=============")
			console.log("totalOriginalProductPrice : " + totalOriginalProductPrice)
			console.log("totalProductDcPrice : " + totalProductDcPrice)
			console.log("couponDcPrice : " + couponDcPrice)
			console.log("배송료 : 2500")
			console.log("=============totalPrice 계산 끝=================")
			setTotalEarnedPoint();
			
			let totalPrice = parseInt($.trim($(".totalPrice").text().replace(" 원", "").replace(/,/g, "")));
            let usePoint = parseInt($("#pointDC").text().replace(/,/g, ''), 10);
			
			if (totalPrice < 2500 && usePoint > 0) {
				setPointUse(couponDcPrice);
			}
		}
		
		function resetCouponDc(couponDcPrice) {
			let totalOriginalProductPrice = parseInt($.trim($("#totalOriginalPrices").text().replace(" 원", "").replace(/,/g, "")));
			let totalProductDcPrice = parseInt($.trim($("#totalDCPrices").text().replace(" 원", "").replace(/,/g, "")));
			$("#totalDCPrices").text((totalProductDcPrice - couponDcPrice).toLocaleString('ko-KR') + " 원");
			console.log("=============totalPrice 계산하는 곳=============")
			console.log("totalOriginalProductPrice : " + totalOriginalProductPrice)
			console.log("totalProductDcPrice : " + totalProductDcPrice)
			console.log("couponDcPrice : " + couponDcPrice)
			console.log("배송료 : 2500")
			console.log("=============totalPrice 계산 끝=================")
			$(".totalPrice").text((totalOriginalProductPrice - (totalProductDcPrice) + couponDcPrice + 2500).toLocaleString('ko-KR') + " 원");
			
			setTotalEarnedPoint();
		}
		
		function handleDeliveryOptionChange() {
		    const select = document.querySelector(".deliveryOption");
		    const input = document.querySelector(".deliveryRequest");
		    const selectedValue = select.value;
		    const selectedText = select.options[select.selectedIndex].text;

		    // 기본 옵션이나 직접 입력이 아닌 경우에만 input에 텍스트 저장
		    if (selectedValue !== "default" && selectedValue !== "userInput") {
		        input.value = selectedText; // 선택된 텍스트 저장
		        input.readOnly = true; // 사용자가 수정할 수 없도록 설정
		        input.style.display = "block"; // 입력 필드 보이기
		    } else if (selectedValue === "userInput") {
		        input.style.display = "block"; // 직접 입력 시 입력 필드 보이기
		        input.value = ""; // 직접 입력 시 빈 값으로 초기화
		        input.readOnly = false; // 사용자가 입력할 수 있도록 설정
		        input.focus();
		    } else {
		        input.style.display = "none"; // 기본 옵션 선택 시 값 초기화
		        input.value = ""; // 입력 필드 초기화
		    }
		    
		    console.log(input);
		}
	</script>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function sample6_execDaumPostcode(type) {
			new daum.Postcode({
				oncomplete: function(data) {
					var addr = '';
					var extraAddr = '';
					
					if (data.userSelectedType === 'R') {
						addr = data.roadAddress;
					} else {
						addr = data.jibunAddress;
					}

					if (data.userSelectedType === 'R') {
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						if (extraAddr !== '') {
							extraAddr = ' (' + extraAddr + ')';
						}
					}

					if (type === 'List') {
						document.getElementById('postcodeList').value = data.zonecode;
						document.getElementById('addressList').value = addr + extraAddr;
						document.getElementById('detailAddressList').removeAttribute("readonly");
						document.getElementById('detailAddressList').focus();
						document.getElementById('detailAddressList').value = "";
						
						document.getElementById('deliveryAddressHidden').value = 
							document.getElementById('postcodeList').value + '/' + 
							document.getElementById('addressList').value + '/' + 
							document.getElementById('detailAddressList').value;
						
						document.getElementById('savedDeliveryName').value = "";
					} else if (type === 'New') {
						document.getElementById('postcodeNew').value = data.zonecode;
						document.getElementById('addressNew').value = addr + extraAddr;
						document.getElementById('detailAddressNew').removeAttribute("readonly");
						document.getElementById('detailAddressNew').focus();
						document.getElementById('detailAddressNew').value = "";
						
						document.getElementById('deliveryAddressHidden').value = 
							document.getElementById('postcodeNew').value + '/' + 
							document.getElementById('addressNew').value + '/' + 
							document.getElementById('detailAddressNew').value;
					}
				}
			}).open();
		}
		
		function getDeliveryList(memberId) {
			console.log(memberId);
			$.ajax({
				async: false,
				url: '/getDeliveryList',
				type: 'POST',
				dataType: "json",
				data: { memberId: memberId },
				success: function(data) {
					console.log(data);
					makeDeliveryListWithData(data);
					$('#deliveryModal').modal('show');
				},
				error: function(data) {
					console.log(data);
				}
			});
		
		}
		
		function makeDeliveryListWithData(json) {
			let mainDelivery = "";
			let output = "";
			$.each(json.deliveryList, function (index, item) {
				let postcode = item.delivery_address.split("/")[0];
				let address = item.delivery_address.split("/")[1];
				let detailAddress = item.delivery_address.split("/")[2];
				
				if (item.is_main == "M") {
					mainDelivery = `<div class='card delveryCard mb-20' id='\${item.delivery_no_delivery}'>
										<div class='card-header'><p class="cardDeliveryName">\${item.delivery_name} <span class="badge bg-danger mainHeadSpan">기본배송지</span></p></div>
										<div class='card-body'>
											<h5 class="mb-10">\${item.delivery_address.split("/")[1]}</h5>
											<h5>\${item.delivery_address.split("/")[2]} [\${item.delivery_address.split("/")[0]}]</h5>
										</div>
										<div class='card-footer'>
											<div class='button'>
												<div class='btn' onclick="applyAddress('\${item.delivery_address}', '\${item.delivery_name}')">등록</div>
											</div>
										</div>
									</div>`;
				} else {
					output += `<div class='card mb-30 delveryCard' id='\${item.delivery_no_delivery}'>
									<div class='card-header'><p class="cardDeliveryName">\${item.delivery_name} <span class="badge bg-danger headSpan">배송지</span></p></div>
									<div class='card-body'>
										<h5 class="mb-10">\${item.delivery_address.split("/")[1]}</h5>
										<h5>\${item.delivery_address.split("/")[2]} [\${item.delivery_address.split("/")[0]}]</h5>
									</div>
									<div class='card-footer'>
										<div class='button'>
											<div class='btn' onclick="applyAddress('\${item.delivery_address}', '\${item.delivery_name}')">등록</div>
										</div>
									</div>
							   </div>`;
				}
				
			});
			console.log(output);
			output = mainDelivery + output;
			
			$("#deliveryModal .modal-body").html(output);
		}
		
		function applyAddress(deliveryAddress, deliveryName) {
			console.log(deliveryAddress);
			let postcode = deliveryAddress.split("/")[0];
			let address = deliveryAddress.split("/")[1];
			let detailAddress = deliveryAddress.split("/")[2];
		    
		    $("#postcodeList").val(postcode);
		    $("#addressList").val(address);
		    $("#detailAddressList").val(detailAddress);
		    $("#savedDeliveryName").val(deliveryName);
		    $("#deliveryAddressHidden").val(deliveryAddress);
		    $("#deliveryName").val(deliveryName);
		    
		    $("#deliveryModal").modal('hide');
		    $("#deliveryModal .modal-body").html("");
		}
		
		function getMemberAddress() {
		    // orderMember 객체를 정의합니다. 실제 사용 환경에서는 서버에서 값을 받아오거나 변수로 설정합니다.
		    const orderMember = {
		        address: "${orderMember.address }" // 예시 데이터
		    };
		    
		    console.log(orderMember);

		    // 체크박스 요소와 주소 입력 필드를 가져옵니다.
		    const checkbox = document.getElementById("getMemeberAddress");
		    const postcode = document.getElementById("postcodeNew");
		    const address = document.getElementById("addressNew");
		    const detailAddress = document.getElementById("detailAddressNew");

		    // 체크 상태에 따라 값 설정
		    if (checkbox.checked) {
		        const [postcodeValue, addressValue, detailAddressValue] = orderMember.address.split("/");
		        postcode.value = postcodeValue;
		        address.value = addressValue;
		        detailAddress.value = detailAddressValue;
		        document.getElementById('deliveryAddressHidden').value = 
					document.getElementById('postcodeNew').value + '/' + 
					document.getElementById('addressNew').value + '/';
		    } else {
		        // 체크 해제 시 빈 문자열로 초기화
		        postcode.value = "";
		        address.value = "";
		        detailAddress.value = "";
		        document.getElementById('deliveryAddressHidden').value = "";
		    }
		}
		
		function getMainDelivery(mainDeliveryAddress, mainDeliveryName) {
			let postcode = mainDeliveryAddress.split("/")[0];
			let address = mainDeliveryAddress.split("/")[1];
			let detailAddress = mainDeliveryAddress.split("/")[2];
		    
		    $("#postcodeList").val(postcode);
		    $("#addressList").val(address);
		    $("#detailAddressList").val(detailAddress);
		    $("#savedDeliveryName").val(mainDeliveryName);
		    $("#deliveryAddressHidden").val(mainDeliveryAddress);
		    $("#deliveryName").val(mainDeliveryName);
		    
		    showOrderModal("기본 배송지가 입력되었습니다.");
		}
		
		function useCouponCode() {
			
			console.log($("#useCoupon").val());
		}
	</script>
	
	<style>
		#overlay {
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0, 0, 0, 0.5);
			z-index: 99999999; 
			display: none;
		}
		
		.ordererHeader {
			font-size: 15px;
			color: black !important;
		}
		
		.product-name {
			font-size: 15px !important;
			color: black !important;
		}
		
		.product-list-title div p{
			color: black !important;
		}
		.product-list-title {
			margin-top: 35px !important;
			margin-bottom: 35px !important;
			height: 50px !important;
			padding: 15px !important;
			border-bottom: 1px solid #E6E6E6;
		}
		.product-list div{
			margin-bottom: 35px !important;
			height: 50px !important;
		}
		.product-list {
			margin-bottom: 35px !important;
			padding-bottom: 20px !important;
			border-bottom: 1px solid #E6E6E6;
		}
		
		.productImage {
			width: 80px;
			height: 80px;
		}
		
		.right {
			text-align: right;
			font-size: 12px;
		}
		
		.right span{
			padding-right: 10px;
			padding-left: 10px;
			color: #888888;
		}
		
		.left {
			text-align: left;
		}
		
		.orderGuide {
			margin: 80px 0 120px 25px;
		}
		
		.orderGuide li{
			margin: 15px;
		}
		
		#accordionExample li {
			margin: 0 0 40px 0 !important;
		}
		
		#nav-tab {
			margin: 40px 0 40px 0;
			border-color: #A8A691;
		}
		
		#nav-tab button {
			width: 200px;
		}
		
		.nav-link.active {
			font-size: 16px;
			color: #A8A691 !important;
			font-weight:bold;
			border-color: #A8A691 !important;
			border-bottom: none !important;
		}
		.nav-link:not(.active) {
			font-size: 14px;
			color: #888888;
			border-color: #e6e6e6 !important;
			border-bottom: none !important;
		}
		
		.addressSearchArea {
			display: flex;
			flex-direction: row;
		}
		
		.addressForm input {
			margin: 10px 0 10px 0;
		}
		
		.deliveryRequest {
			margin: 10px 0 10px 0;
		}
		
		.deliveryOption {
			border-color: #e6e6e6 !important;
			height: 46px;
		}
		
		
		.deliveryOption:focus {
			border-color: #e6e6e6 !important;
			box-shadow: none !important; 
		}
		
		.form-check-input:focus {
			border-color: #a8a691 !important;
		}
		
		.form-check {
			margin: 10px 0 20px 0;
		}
		
		.deliveryNameForm {
			margin: 20px 0 40px 0;
		}
		
		.single-payment-option label {
			border: 1px solid #e6e6e6 !important;
		}
		
		input[name="paymentMethod"]:hover + label {
			background-color: #d1cfc0 !important;
		}
		
		input[name="paymentMethod"]:checked + label {
			background-color: #A8A691 !important;
		}
		
		input[name="paymentMethod"]:checked + label p {
			color: #FFFFFF !important;
		}
		
		#mainDelivery, #deliveryList {
			width: 150px !important;
		}
		
		.button.deliveryListTap {
			margin: 30px 0;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    width: 100%;
		}
		
		#deliveryModal .modal-body, #couponModal .modal-body{
		    max-height: 490px;
		    overflow-y: auto;
		}
		
		.delveryCard .card-header,
		.couponCard .card-header,
		.delveryCard .card-footer,
		.couponCard .card-footer {
			border: none;
			background-color: #FFFFFF;
		}
		
		.cardDeliveryName {
			text-align: center;
			display: flex;
			align-items: center;
			font-size: 16px;
			font-weight: bold;
			color: #FFFFFF;
		}
		
		.cardDeliveryName span{
			margin-left: 10px;
			text-align: center;
			display: flex;
			align-items: center;
		}
		
		.delveryCard .card-header .mainHeadSpan {
			background-color: #FD5A67 !important;
			width: 75px;
		}
		
		.delveryCard .card-header .headSpan {
			background-color: #0DCAF0 !important;
			width: 52px;
		}
		
		.delveryCard .card-header span {
			text-align: center;
			display: flex;
			align-items: center;
			margin-left: 10px;
		}
		
		.delveryCard .card-header {
			background-color: #a8a691;
			border-bottom: 1px solid #d8d7d6;
		}
		
		.delveryCard .card-footer .button {
			height: 25px;
			display: flex;
			justify-content: right;
		}
		
		.delveryCard .card-footer .btn {
			height: 25px !important;
			display: flex;
			align-items: center
		}
		
		.couponCard .card-footer .button {
			height: 38px;
			display: flex;
			justify-content: space-between;
		}
		
		.couponCard .card-footer .btn {
			height: 30px !important;
			display: flex;
			align-items: center
		}
		
		.couponCard .cart-body {
			padding: 0 16px !important;
		}
		
		.couponCard .couponInfo {
			display: flex;
			justify-content: space-between;
		}
		
		.couponCard .card-body {
			padding: 0 16px;
		}
		
		.couponCard .card-footer {
			padding: 5px 16px 8px 16px;
		}
		
    </style>
</head>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="preloader-inner">
            <div class="preloader-icon">
                <span></span>
                <span></span>
            </div>
        </div>
    </div>
    <!-- /End Preloader -->

	<jsp:include page="../header.jsp"></jsp:include>

    <!-- Start Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="breadcrumbs-content">
                        <h1 class="page-title">주문 결제</h1>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <ul class="breadcrumb-nav">
                        <li><a href="/"><i class="lni lni-home"></i> Home</a></li>
                        <li><a href="/product/jewelry/all">Shop</a></li>
                        <li>주문 / 결제</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!--====== Checkout Form Steps Part Start ======-->
	<section class="checkout-wrapper section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8">
				<!--====== 주문 정보 ======-->
					<div class="checkout-steps-form-style-1">
						<ul id="accordionExample">
						<!--====== 주문 상품 정보 ======-->
							<li>
								<h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
									<div class="row">
										<div class="left col-lg-6 col-md-6 col-12">
											<span>주문 상품</span>
										</div>
										<div class="right col-lg-6 col-md-6 col-12">
											<span class="totalProductCount"></span>
											<span id="totalProductPrice"></span>
										</div>
									</div>
								</h5>
								
								<section class="checkout-steps-form-content collapse" id="collapseThree" aria-labelledby="headingThree">
									<div class="row align-items-center product-list-title">
										<div class="col-lg-1 col-md-1 col-12">
											<p></p>
										</div>
										<div class="col-lg-5 col-md-5 col-12">
											<p>상품 / 수량 정보</p>
										</div>
										<div class="col-lg-3 col-md-3 col-12">
											<p>할인 금액</p>
										</div>
										<div class="col-lg-3 col-md-3 col-12">
											<p>결제금액</p>
										</div>
									</div>
                                    
								<c:forEach var="orderProduct" items="${orderProductList }">
								
									<div class="row align-items-center product-list">
										<div class="col-lg-1 col-md-1 col-12">
											<a href="/product/jewelry/detail?productNo=${orderProduct.product_no }">
												<img class="productImage" src="${empty orderProduct.image_url ? '/resources/images/noP_image.png' : orderProduct.image_url}" alt="productImage">
											</a>
										</div>
										<div class="col-lg-5 col-md-5 col-12">
											<h6 class="product-name">
												<a href="/product/jewelry/detail?productNo=${orderProduct.product_no }">${orderProduct.product_name }</a>
											</h6>
											<p>
												<span>수량: <span class="product_quantity" id="${orderProduct.product_no }_quantity">${orderProduct.quantity }</span> 개</span>
											</p>
										</div>
										<div class="col-lg-3 col-md-3 col-12">
											<p><span class="dcPrice">
												<fmt:formatNumber value="${orderProduct.product_price * orderProduct.quantity * orderProduct.dc_rate }" type="number" pattern="#,###" /> 원
											</span></p>
										</div>
										<div class="col-lg-3 col-md-3 col-12">
										
									<c:choose>
									
										<c:when test="${orderProduct.dc_rate != 0 }">
											<p><span class="originalPrice"><em><del style="color: #b7b7b7;">
												<fmt:formatNumber value="${orderProduct.product_price * orderProduct.quantity }" type="number" pattern="#,###" /> 원
											</del></em></span></p>
										</c:when>
										
										<c:otherwise>
											<p style="display: none;"><span class="originalPrice"><em><del style="color: #b7b7b7;">
												<fmt:formatNumber value="${orderProduct.product_price * orderProduct.quantity }" type="number" pattern="#,###" /> 원
											</del></em></span></p>
										</c:otherwise>
										
									</c:choose>
											<p><span class="productPrice">
												<fmt:formatNumber value="${orderProduct.product_price * orderProduct.quantity * (1 - orderProduct.dc_rate) }" type="number" pattern="#,###" /> 원
											</span></p>
										</div>
									</div>
									
								</c:forEach>
									<input type="hidden" name="productsInfo" id="productsInfo">
                                </section>
                            </li>
                            <!--====== 주문 상품 정보 끝 ======-->
					<c:choose>
						<c:when test="${not empty orderMember }">
						<!--====== 주문자 정보 (회원) ======-->
						
							<li>
								<h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
									<div class="row">
										<div class="left col-lg-6 col-md-6 col-12">
											<span>주문자 정보</span>
											<input type="hidden" name="ordererId" value="${orderMember.member_id }">
										</div>
										<div class="right col-lg-6 col-md-6 col-12">
											<span>${orderMember.member_name }</span>
											<span>${orderMember.phone_number }</span>
										</div>
									</div>
								</h5>
								
								<section class="checkout-steps-form-content collapse" id="collapseFour" aria-labelledby="headingFour">
								<!--====== 주문자 이름 (회원) ======-->
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-4 col-md-4 col-12">
													<h5 class="ordererHeader">이름</h5>
												</div>
												<div class="col-lg-8 col-md-8 col-12">
													<input type="text" placeholder="Name" name="ordererName" value="${orderMember.member_name }" readonly>
												</div>
											</div>
										</div>
									</div>
								<!--====== 주문자 이름 끝 (회원) ======-->
								
								<!--====== 주문자 휴대폰 번호 (회원) ======-->	
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-4 col-md-4 col-12">
													<h5 class="ordererHeader">휴대폰 번호</h5>
												</div>
												<div class="col-lg-8 col-md-8 col-12">
													<input type="text" placeholder="Phone Number" name="phoneNumber" value="${orderMember.phone_number }" readonly>
												</div>
											</div>
										</div>
									</div>
								<!--====== 주문자 휴대폰 번호 끝 (회원) ======-->
								
								<!--====== 주문자 이메일 (회원) ======-->
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-4 col-md-4 col-12">
													<h5 class="ordererHeader">이메일</h5>
												</div>
												<div class="col-lg-8 col-md-8 col-12">
													<input type="text" placeholder="Email Address" name="email" value="${orderMember.email }" readonly>
												</div>
											</div>
										</div>
									</div>
								<!--====== 주문자 이메일 끝 (회원) ======-->
									
								</section>
							</li>
							
							
						<!--====== 배송지 정보 (회원) ======-->
							<li>
								<h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapsefive" aria-expanded="false" aria-controls="collapsefive">배송지 정보</h5>
						<c:choose>
							<c:when test="${not empty orderMember.delivery_address and not empty orderMember.delivery_name }">
								<section class="checkout-steps-form-content collapse" id="collapsefive" aria-labelledby="headingfive">
								<!--====== 배송지 정보 헤더 (회원) ======-->
									<nav>
										<div class="nav nav-tabs" id="nav-tab" role="tablist">
											<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onclick="showDeliveryList()">배송지 목록</button>
											<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="showInputNewAddress()">신규입력</button>
										</div>
									</nav>
								<!--====== 배송지 정보 헤더 끝 (회원) ======-->
								
									<div class="col-md-6">
									
										<div class="tab-content" id="nav-tabContent">
									
											
										    <!--====== 배송지 목록 (회원) ======-->
										    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
										        <div class="single-form form-default">
										        	<div class="button deliveryListTap mb-30 row align-items-center">
										                <div class="btn col-lg-6 col-md-6 col-12" id="mainDelivery" onclick="getMainDelivery('${orderMember.delivery_address}', '${orderMember.delivery_name }')">기본배송지</div>
										                <div class="btn col-lg-6 col-md-6 col-12" id="deliveryList" onclick="getDeliveryList('${orderMember.member_id}')">배송지 목록</div>
								            		</div>
										            <div class="form-input form addressForm">
										                <h5 class="ordererHeader">주소</h5>
										                <div class="addressSearchArea">
										                    <input class="postNumber" type="text" id="postcodeList" placeholder="우편번호" readonly value="${orderMember.delivery_address.split('/')[0] }">
										                    <input class="searchPost" type="button" onclick="sample6_execDaumPostcode('List')" value="검색"><br>
										                </div>
										                <input type="text" id="addressList" placeholder="주소" value="${orderMember.delivery_address.split('/')[1] }" readonly><br>
										                <input type="text" id="detailAddressList" placeholder="상세주소" value="${orderMember.delivery_address.split('/')[2] }" readonly>
										            </div>
										        </div>
										        <div class="single-form form-default">
										            <div class="form-input form">
										                <h5 class="ordererHeader">배송지명</h5>
										                <input type="text" id="savedDeliveryName" value="${orderMember.delivery_name }" readonly>
										            </div>
										        </div>
										    </div>
										    <!--====== 배송지 목록 끝 (회원) ======-->
										    
										    <!--====== 배송지 신규입력 (회원) ======-->
										    <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
										        <div class="single-form form-default">
									        		<div class="form-check">
										                <div id="getMemeberAddressDiv">
										                    <input type="checkbox" class="form-check-input" id="getMemeberAddress" onclick="getMemberAddress();">
										                    <label for="getMemeberAddress">주문자 정보와 동일</label>
										                </div>
								            		</div>
										            <div class="form-input form addressForm">
										                <h5 class="ordererHeader">주소</h5>
										                <div class="addressSearchArea">
										                    <input class="postNumber" type="text" id="postcodeNew" placeholder="우편번호" readonly>
										                    <input class="searchPost" type="button" onclick="sample6_execDaumPostcode('New')" value="검색"><br>
										                </div>
										                <input type="text" id="addressNew" placeholder="주소" readonly><br>
										                <input type="text" id="detailAddressNew" placeholder="상세주소" readonly>
										            </div>
										            <div class="form-check">
										                <div id="saveDeliveryDiv">
										                    <input type="checkbox" class="form-check-input" id="saveDeliveryCheck">
										                    <label for="saveDeliveryCheck">기본배송지로 저장</label>
										                </div>
										                <div id="saveAddressDiv">
										                    <input type="checkbox" class="form-check-input" id="saveAddressCheck">
										                    <label for="saveAddressCheck">회원정보 주소로 저장</label>
										                </div>
										            </div>
										        </div>
										        <div class="single-form form-default deliveryNameForm" style="display: none;">
										            <div class="form-input form">
										                <h5 class="ordererHeader">배송지명</h5>
										                <input type="text" id="deliveryName" value="${orderMember.member_name }님 배송지">
										            </div>
										        </div>
										    </div>
										    <!--====== 배송지 신규입력 끝 (회원) ======-->
									    
											<input type="hidden" name="saveDeliveryType" id="saveDeliveryType" value="none">
										    <input type="hidden" name="delivery_address" id="deliveryAddressHidden" value="${orderMember.address }">
										</div>
										
										<!--====== 배송 요청사항 (회원) ======-->
										<div class="single-form form-default">
											<div class="form-input form">
												<h5 class="ordererHeader">배송 요청사항</h5>
												<select class="form-select deliveryOption" onchange="handleDeliveryOptionChange()">
													<option value="default" selected>선택해주세요</option>
													<option value="dr1">출발전에 전화 부탁드립니다.</option>
													<option value="dr2">부재시 경비실에 맡겨주세요.</option>
													<option value="dr3">부재시 문앞에 놓아주세요.</option>
													<option value="dr4">부재시 휴대폰으로 연락주세요.</option>
													<option value="dr5">부재시 문앞에 놓아주세요.</option>
													<option value="userInput">직접입력</option>
												</select>
												<input class="deliveryRequest" type="text" name="deliveryRequest" style="display: none;">
											</div>
										</div>
										<!--====== 배송 요청사항 끝 (회원) ======-->
									</div>
								<!--====== 배송지 정보 끝 (회원) ======-->
									
								</section>
							</c:when>
							<c:otherwise>
								<section class="checkout-steps-form-content collapse show" id="collapsefive" aria-labelledby="headingfive">
								<!--====== 배송지 정보 헤더 (비회원) ======-->
									<nav>
										<div class="nav nav-tabs" id="nav-tab" role="tablist">
											<button class="nav-link active" id="nav-addressInput-tab" data-bs-toggle="tab" data-bs-target="#nav-addressInput" type="button" role="tab" aria-controls="nav-addressInput" aria-selected="false" disabled>신규입력</button>
										</div>
									</nav>
								<!--====== 배송지 정보 헤더 끝 (비회원) ======-->
								
								<!--====== 배송지 정보 (비회원) ======-->
									<div class="col-md-6">
									<!--====== 배송지 주소 입력 (비회원) ======-->
										<div class="tab-content" id="nav-tabContent">
											<div class="tab-pane fade show active" id="nav-addressInput" role="tabpanel" aria-labelledby="nav-addressInput-tab" tabindex="0">
												<div class="single-form form-default">
									        		<div class="form-check">
										                <div id="getMemeberAddressDiv">
										                    <input type="checkbox" class="form-check-input" id="getMemeberAddress" onclick="getMemberAddress();">
										                    <label for="getMemeberAddress">주문자 정보와 동일</label>
										                </div>
								            		</div>
										            <div class="form-input form addressForm">
										                <h5 class="ordererHeader">주소</h5>
										                <div class="addressSearchArea">
										                    <input class="postNumber" type="text" id="postcodeNew" placeholder="우편번호">
										                    <input class="searchPost" type="button" onclick="sample6_execDaumPostcode('New')" value="검색"><br>
										                </div>
										                <input type="text" id="addressNew" placeholder="주소"><br>
										                <input type="text" id="detailAddressNew" placeholder="상세주소">
										            </div>
										            <div class="form-check">
										                <div id="saveDeliveryDiv">
										                    <input type="checkbox" class="form-check-input" id="saveDeliveryCheck">
										                    <label for="saveDeliveryCheck">기본배송지로 저장</label>
										                </div>
										                <div id="saveAddressDiv">
										                    <input type="checkbox" class="form-check-input" id="saveAddressCheck">
										                    <label for="saveAddressCheck">회원정보 주소로 저장</label>
										                </div>
										            </div>
										        </div>
										        <div class="single-form form-default deliveryNameForm" style="display: none;">
										            <div class="form-input form">
										                <h5 class="ordererHeader">배송지명</h5>
										                <input type="text" id="deliveryName" value="${orderMember.member_name }님 배송지">
										            </div>
										        </div>
											</div>
										</div>
									<!--====== 배송지 주소 입력 끝 (비회원) ======-->
									
									<!--====== 배송요청사항 입력 (비회원) ======-->
										<div class="single-form form-default">
											<div class="form-input form">
												<label>배송 요청사항</label>
												<select class="form-select deliveryOption" onchange="handleDeliveryOptionChange()">
													<option value="default" selected>선택해주세요</option>
													<option value="dr1">출발전에 전화 부탁드립니다.</option>
													<option value="dr2">부재시 경비실에 맡겨주세요.</option>
													<option value="dr3">부재시 문앞에 놓아주세요.</option>
													<option value="dr4">부재시 휴대폰으로 연락주세요.</option>
													<option value="dr5">부재시 문앞에 놓아주세요.</option>
													<option value="userInput">직접입력</option>
												</select>
												<input class="deliveryRequest" type="text" name="deliveryRequest" style="display: none;">
											</div>
										</div>
									<!--====== 배송요청사항 입력 끝(비회원) ======-->
									<input type="hidden" id="deliveryName" value="none">
									<input type="hidden" name="saveDeliveryType" id="saveDeliveryType" value="none">
									<input type="hidden" name="delivery_address" id="deliveryAddressHidden">
									</div>
								<!--====== 배송지 정보 끝(비회원) ======-->
									
								</section>
							</c:otherwise>
					    </c:choose>
							</li>
							
						<!--====== 포인트 정보 (회원) ======-->
							<li>
								<h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">포인트 정보</h5>
								
								<section class="checkout-steps-form-content collapse" id="collapseSix" aria-labelledby="headingSix">
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-2 col-md-2 col-12">
													<h5 class="ordererHeader">포인트</h5>
												</div>
												<div class="col-lg-6 col-md-6 col-12">
													<input type="text" placeholder="point" name="point" value="0">
												</div>
												<div class="button col-lg-4 col-md-4 col-12" id="pointUseDiv">
													<div class="btn" onclick="pointUse();">사용</div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-12">
										<div class="single-form form-default">
											<div class="form-check row">
												<div id="allPointsUseDiv" class="col-lg-4 col-md-4 col-12">
													<input type="checkbox" class="form-check-input" id="allPointsUse">
													<label for="allPointsUse">포인트 모두 사용</label>
												</div>
												<div class="form-input form col-lg-4 col-md-4 col-12">
													<label>(<span id="memberPoint"><fmt:formatNumber value="${orderMember.member_point }" type="number" pattern="#,###" /></span>P 보유)</label>
												</div>
											</div>
										</div>
										<div class="single-form form-default">
											<div class="form-input form">
												<label>할인 합계 : -<span id="pointDC">0</span>원</label>
											</div>
										</div>
									</div>
									
								</section>
							</li>
							
						<!--====== 포인트 정보 끝 (회원) ======-->
						</c:when>
						
						<c:otherwise>
						<!--====== 주문자 정보 (비회원) ======-->
							<li>
								<h5 class="title" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
									<div class="row">
										<div class="left col-lg-2 col-md-2 col-12">
											<span>주문자 정보</span>
											<input type="hidden" name="ordererId" value="non_member">
										</div>
										<div class="right col-lg-6 col-md-8 col-12">
											<span>주문자 정보에 입력하신 정보로 비회원 주문조회 하실 수 있습니다.</span>
										</div>
										<div class="right col-lg-4 col-md-2 col-12">
											<p></p>
										</div>
									</div>
								</h5>
								
								<section class="checkout-steps-form-content collapse show" id="collapseFour" aria-labelledby="headingFour">
								<!--====== 주문자 이름 (비회원) ======-->
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-4 col-md-4 col-12">
													<h5 class="ordererHeader">이름</h5>
												</div>
												<div class="col-lg-8 col-md-8 col-12">
													<input type="text" placeholder="이름을 입력해주세요" name="ordererName">
												</div>
											</div>
										</div>
									</div>
								<!--====== 주문자 이름 끝 (비회원) ======-->
								
								<!--====== 주문자 휴대폰 번호 (비회원) ======-->
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-4 col-md-4 col-12">
													<h5 class="ordererHeader">휴대폰 번호</h5>
												</div>
												<div class="col-lg-8 col-md-8 col-12">
													<input type="text" placeholder="휴대폰 번호를 입력해주세요" name="phoneNumber">
												</div>
											</div>
										</div>
									</div>
								<!--====== 주문자 휴대폰 번호 끝 (비회원) ======-->
								
								<!--====== 주문자 이메일 끝 (비회원) ======-->
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="row form-input form align-items-center">
												<div class="col-lg-4 col-md-4 col-12">
													<h5 class="ordererHeader">이메일</h5>
												</div>
												<div class="col-lg-8 col-md-8 col-12">
													<input type="text" placeholder="이메일을 입력해주세요" name="email">
												</div>
											</div>
										</div>
									</div>
								<!--====== 주문자 이메일 끝 (비회원) ======-->
									<div class="form-input form" style="display: none;">
										<label>할인 합계 : -<span id="pointDC">0</span>원</label>
									</div>
								</section>
							</li>
						<!--====== 주문자 정보 끝 (비회원) ======-->
						
						<!--====== 배송지 정보 (비회원) ======-->
							<li>
								<h5 class="title" data-bs-toggle="collapse" data-bs-target="#collapsefive" aria-expanded="true" aria-controls="collapsefive">배송지 정보</h5>
								
								<section class="checkout-steps-form-content collapse show" id="collapsefive" aria-labelledby="headingfive">
								<!--====== 배송지 정보 헤더 (비회원) ======-->
									<nav>
										<div class="nav nav-tabs" id="nav-tab" role="tablist">
											<button class="nav-link active" id="nav-addressInput-tab" data-bs-toggle="tab" data-bs-target="#nav-addressInput" type="button" role="tab" aria-controls="nav-addressInput" aria-selected="false" disabled>신규입력</button>
										</div>
									</nav>
								<!--====== 배송지 정보 헤더 끝 (비회원) ======-->
								
								<!--====== 배송지 정보 (비회원) ======-->
									<div class="col-md-6">
									<!--====== 배송지 주소 입력 (비회원) ======-->
										<div class="tab-content" id="nav-tabContent">
											<div class="tab-pane fade show active" id="nav-addressInput" role="tabpanel" aria-labelledby="nav-addressInput-tab" tabindex="0">
												<div class="single-form form-default">
													<div class="form-input form addressForm">
										                <h5 class="ordererHeader">주소</h5>
										                <div class="addressSearchArea">
										                    <input class="postNumber" type="text" id="postcodeNew" placeholder="우편번호">
										                    <input class="searchPost" type="button" onclick="sample6_execDaumPostcode('New')" value="검색"><br>
										                </div>
										                <input type="text" id="addressNew" placeholder="주소"><br>
										                <input type="text" id="detailAddressNew" placeholder="상세주소">
										            </div>
												</div>
											</div>
										</div>
									<!--====== 배송지 주소 입력 끝 (비회원) ======-->
									
									<!--====== 배송요청사항 입력 (비회원) ======-->
										<div class="single-form form-default">
											<div class="form-input form">
												<label>배송 요청사항</label>
												<select class="form-select deliveryOption" onchange="handleDeliveryOptionChange()">
													<option value="default" selected>선택해주세요</option>
													<option value="dr1">출발전에 전화 부탁드립니다.</option>
													<option value="dr2">부재시 경비실에 맡겨주세요.</option>
													<option value="dr3">부재시 문앞에 놓아주세요.</option>
													<option value="dr4">부재시 휴대폰으로 연락주세요.</option>
													<option value="dr5">부재시 문앞에 놓아주세요.</option>
													<option value="userInput">직접입력</option>
												</select>
												<input class="deliveryRequest" type="text" name="deliveryRequest" style="display: none;">
											</div>
										</div>
									<!--====== 배송요청사항 입력 끝(비회원) ======-->
									<input type="hidden" id="deliveryName" value="none">
									<input type="hidden" name="saveDeliveryType" id="saveDeliveryType" value="none">
									<input type="hidden" name="delivery_address" id="deliveryAddressHidden">
									</div>
								<!--====== 배송지 정보 끝(비회원) ======-->
									
								</section>
							</li>
							
						</c:otherwise>
					</c:choose>
                            
							<li>
								<h6 class="title" data-bs-toggle="collapse" data-bs-target="#collapseSeven" aria-expanded="true" aria-controls="collapseFour">결제 수단</h6>
								<section class="checkout-steps-form-content collapse show" id="collapseSeven" aria-labelledby="headingSeven">
									<div class="row">
										<div class="col-md-12">
											<div class="checkout-payment-option">
												<h6 class="heading-6 font-weight-400 payment-title">결제 수단을 선택해주세요.</h6>
												<div class="payment-option-wrapper">
													<div class="single-payment-option">
														<input type="radio" name="paymentMethod" id="paymentMethod-1" onclick="selectPaymentMethod('CARD')" checked>
														<label for="paymentMethod-1">
															<p>카드 결제</p>
														</label>
													</div>
													<!--
													<div class="single-payment-option">
														<input type="radio" name="paymentMethod" id="paymentMethod-2" onclick="selectPaymentMethod('VIRTUAL_ACCOUNT')">
														<label for="paymentMethod-2">
															<p>무통장 입금</p>
														</label>
													</div>
													-->
													<div class="single-payment-option">
														<input type="radio" name="paymentMethod" id="paymentMethod-3" onclick="selectPaymentMethod('TRANSFER')">
														<label for="paymentMethod-3">
															<p>계좌 이체</p>
														</label>
													</div>
													<div class="single-payment-option">
														<input type="radio" name="paymentMethod" id="paymentMethod-4" onclick="selectPaymentMethod('NAVER_PAY')">
														<label for="paymentMethod-4">
															<p>네이버 페이</p><!--TODO : 네이버 페이 로고로 바꾸기-->
														</label>
													</div>
													<div class="single-payment-option">
														<input type="radio" name="paymentMethod" id="paymentMethod-5" onclick="selectPaymentMethod('KAKAO_PAY')">
														<label for="paymentMethod-5">
															<p>카카오 페이</p><!--TODO : 카카오 페이 로고로 바꾸기-->
														</label>
													</div>                        
												</div>
											</div>
										</div>
									</div>
						
									<input type="hidden" name="payment_type" id="payment_type" value="CARD">
								</section>
							</li>
						</ul>
					</div>
					
					<div class="orderGuide">
						<ul>
							<li><h6>주문/결제 이용안내</h6></li>
							<li><span>상품 구매후 교환 및 환불은 수령 후 7일이내 가능합니다.</span></li>
							<li><span>주문 취소는 배송시작 전 단계에서만 가능합니다. 이후에는 반품으로 진행되며, 반품배송비가 추가발생 할 수 있습니다.</span></li>
							<li><span>23시 이후에는 은행 별 이용 가능 시간을 확인하시고 결제를 진행해 주시기 바랍니다.</span></li>
							<li><span>구매 적립 포인트는 구매확정 시 적립됩니다.</span></li>
						</ul>
					</div>
				</div>
				
				<div class="col-lg-4">
    				<div class="checkout-sidebar">
    				
				<c:choose>
					<c:when test="${not empty orderMember }">
						<div class="checkout-sidebar-coupon">
							<p>쿠폰 입력</p>
							<div class="single-form form-default">
								<div class="form-input form">
									<input type="text" placeholder="쿠폰을 등록하세요" name="couponName" id="couponName" onclick="showCouponList('${orderMember.member_id}')" readonly>
									<input type="hidden" name="couponUse" id="couponUse">
								</div>
								<div class="button">
									<button class="btn" onclick="showCouponList('${orderMember.member_id}')">쿠폰 조회</button>
								</div>
							</div>
						</div>
						<div class="checkout-sidebar-price-table mt-30">
							<div class="sub-total-price" style="color: black;">
								<div class="total-price">
									<p class="value">총 상품금액</p>
									<p class="price" id="totalOriginalPrices">0 원</p>
								</div>
								<div class="total-price discount">
									<p class="value">총 할인금액</p>
									<p class="price">- <span id="totalDCPrices">0 원</span></p>
								</div>
								<div class="total-price shipping">
									<p class="value">총 배송비</p>
									<p class="price" id="deliveryCost">2500 원</p>
								</div>
							</div>

							<div class="total-payable">
								<div class="payable-price">
									<h6 class="value bold" style="color: black;">총 결제금액</h6>
									<h6 class="price totalPrice" style="color: red;">0 원</h6>
								</div>
								<div class="sub-total-price">
									<div class="total-price point mb-30">
										<p class="value">총 적립예정 포인트</p>
										<p class="price" id="totalEarnedPoints">0 P</p>
									</div>
								</div>
							</div>
							<div class="price-table-btn button">
								<a href="javascript:void(0)" class="btn" onclick="requestPayment()">(총 <span class="totalProductCount"></span>) <span class="price totalPrice">0 원</span> 결제하기</a>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="checkout-sidebar-coupon" style="display: none;">
							<div class="single-form form-default">
								<div class="form-input form">
									<input type="text" placeholder="쿠폰을 등록하세요" name="couponName" id="couponName" readonly>
									<input type="hidden" name="couponUse" id="couponUse">
								</div>
								<div class="button">
									<button class="btn" onclick="useCouponCode()">쿠폰 적용</button>
								</div>
							</div>
						</div>
						<div class="checkout-sidebar-price-table">
							<div class="sub-total-price" style="color: black;">
								<div class="total-price">
									<p class="value">총 상품금액</p>
									<p class="price" id="totalOriginalPrices">0 원</p>
								</div>
								<div class="total-price discount">
									<p class="value">총 할인금액</p>
									<p class="price">- <span id="totalDCPrices">0 원</span></p>
								</div>
								<div class="total-price shipping">
									<p class="value">총 배송비</p>
									<p class="price">2500 원</p>
								</div>
							</div>

							<div class="total-payable">
								<div class="payable-price">
									<h6 class="value bold" style="color: black;">총 결제금액</h6>
									<h6 class="price totalPrice" style="color: red;">0 원</h6>
								</div>
								<div class="sub-total-price">
									<div class="total-price point mb-30">
										<p class="value">총 적립예정 포인트</p>
										<p class="price">0 P</p>
									</div>
								</div>
							</div>
							<div class="price-table-btn button">
								<a href="javascript:void(0)" class="btn" onclick="requestPayment()">(총 <span class="totalProductCount"></span>) <span class="price totalPrice">0 원</span> 결제하기</a>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

                    </div>
                </div>
            </div>
        </div>
        
        <div id="overlay"></div>
    </section>
    <!--====== Checkout Form Steps Part Ends ======-->
	
	<jsp:include page="deliveryModal.jsp"></jsp:include>
	<jsp:include page="couponModal.jsp"></jsp:include>
	<jsp:include page="orderModal.jsp"></jsp:include>
	
    <jsp:include page="../footer.jsp"></jsp:include>
    
    <!-- ========================= scroll-top ========================= -->
    <a href="#" class="scroll-top">
        <i class="lni lni-chevron-up"></i>
    </a>

    <!-- ========================= JS here ========================= -->
    <script src="/resources/assets/user/js/bootstrap.min.js"></script>
    <script src="/resources/assets/user/js/tiny-slider.js"></script>
    <script src="/resources/assets/user/js/glightbox.min.js"></script>
    <script src="/resources/assets/user/js/main.js"></script>
    
    <!--toss 결제 API-->
    <script src="https://js.tosspayments.com/v2/standard"></script>

    <!-- 결제 처리(toss) -->
    <script>
        // ------  SDK 초기화 ------
        // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
        const clientKey = "test_ck_6BYq7GWPVv2PGpoD9mdaVNE5vbo1"; // TODO : 내 클라이언트 키, 나중에 서버에 저장해야 함
        const customerKey = "whygari4321"; // 구매자의 고유 아이디
        const tossPayments = TossPayments(clientKey);
        // 결제창 초기화
        const payment = tossPayments.payment({ customerKey });
        // TODO : 현재 페이지에서 총 결제금액 읽어서 갱신하기, 지금은 100원 결제
        const amount = {
            currency: "KRW",
            value: 100,
        };
    </script>

    <!-- 네이버페이 결제 API -->
    <script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>    

    <!-- 결제 처리(네이버페이) -->
    <script>
        var oPay = Naver.Pay.create({
             "mode" : "development", // development or production
             "clientId": "HN3GGCMDdTgGUfl0kFCo", // clientId
             "chainId": "S2VnY2NSaHlhb3V", // chainId
             // "openType" : "popup",
        });
    </script>
    	  
  	<!-- 결제 처리(카카오페이) -->
	<script>
	var kakaopay = {
		ref: null,
	};
	
	function showKakaopayPaymentWindow(url) {
		kakaopay.ref = window.open('', 'paypopup', 'width=426,height=510,toolbar=no');
		const overlay = document.getElementById("overlay");
		
		if (kakaopay.ref) {
			// 팝업 창이 열렸을 때, 배경을 반투명 검은색으로 변경하고 입력을 막는다.
			overlay.style.display = "block"; 
			// NOTE : 왠지는 모르겠는데 이걸로 입력 차단 안됨
			// overlay.style.pointerEvents = 'none';
			$(".container").css("pointerEvents", "none")
			console.log("카카오페이 URL : " + url)
			
			setTimeout(function(){
				kakaopay.ref.location.href=url
			}, 0);
			
	        // 팝업 창이 닫혔는지 주기적으로 확인
	        const checkPopupClosed = setInterval(function() {
	            if (kakaopay.ref.closed) {
	                // 팝업 창이 닫혔을 때 배경을 원래대로 되돌리고 입력을 허용
	                overlay.style.display = "none";
	                $(".container").css("pointerEvents", "auto");
	                clearInterval(checkPopupClosed);
	                console.log("카카오페이 창이 닫혔습니다.");
	            }
	        }, 500); // 0.5초마다 팝업 상태 확인
			
		} else {
			throw new Error("popup을 열 수 없습니다!(cannot open popup)");
		}
		// TODO : 창이 띄워진 동안에는 배경 반투명 검은색으로 가리고 입력 막아야 할 것 같음
	}
	
	function releaseInputBlock() {
		const overlay = document.getElementById("overlay");
		overlay.style.display = "none"
		$(".container").css("pointerEvents", "auto")
	}
	</script>
  
  <!-- 결제 이벤트 핸들러(toss, 네이버페이, 카카오페이) -->
  <script>
	  function validateEmail(email) {
	 	 const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		 return emailPattern.test(email);
	  }
	  
	  function validateData(data) {
	 	 if (data == null || data == undefined || data == "") {
	 		 return false;
	 	 }
		 return true;
	  }
	  
	  function showOrderModal(message) {
		  $("#orderModal").modal("show");
			$("#orderModal .modal-text").text(message);
			
			setTimeout(function() {
			$('#orderModal').modal('hide');
			}, 750);
 	  }
	  
	  let selectedPaymentMethod = 'CARD';

	  function selectPaymentMethod(method) {
		selectedPaymentMethod = method;
		console.log(method + "방법 선택")
		$("#payment_type").val(method); // form태그 밸류 설정
	  }

	  async function requestPayment() {
        	let productsInfo = [];
			let productNo = 0;
			let quantity = 0;
		    
		    for (let i = 0; i < $('.product_quantity').length; i++) {
		    	
		    	productNo = parseInt($('.product_quantity')[i].id);
	            quantity = parseInt($("#"+productNo + "_quantity").text());
	            
	            productsInfo.push({ productNo: parseInt(productNo), quantity: quantity });
	            console.log(productsInfo);
		    }

            const saveDeliveryType = document.querySelector("#saveDeliveryType").value;
            const deliveryName = document.querySelector("#deliveryName").value;
            const pointDCText = document.querySelector("#pointDC").textContent;
            const pointDC = parseInt(pointDCText.replace(/,/g, ''), 10);
            const couponUse = document.querySelector("#couponUse").value;
            const deliveryRequest = document.querySelector("input[name='deliveryRequest']").value;
            const ordererId = document.querySelector("input[name='ordererId']").value;
            
            const paymentType = document.querySelector("#payment_type").value;
            const deliveryAddress = document.querySelector("#deliveryAddressHidden").value + document.querySelector("#detailAddressNew").value;
            const ordererName = document.querySelector("input[name='ordererName']").value;
            const phoneNumber = document.querySelector("input[name='phoneNumber']").value;
            const email = document.querySelector("input[name='email']").value;
            
 			if (!validateData(ordererName)) {
 				showOrderModal("성함을 입력해주세요.");
            	return;       	
            }
            
			if (!validateData(phoneNumber)) {
				showOrderModal("핸드폰 번호를 입력해주세요.");
            	return;
			}
			
			if (!validateData(email)) {
				showOrderModal("이메일을 입력해주세요.");
            	return;
            }
            
            if (!validateEmail(email)) {
            	showOrderModal("유효하지 않은 이메일입니다.");
            	return;
            }
            
            if (!validateData(deliveryAddress)) {
            	showOrderModal("주소를 입력해주세요.");
            	return;
            }
            
            if (!validateData(deliveryAddress.split("/")[2])) {
            	showOrderModal("상세주소를 입력해주세요.");
            	return;
            }
            
            if (!validateData(paymentType)) {
            	showOrderModal("결제 수단을 선택해주세요.");
            	return;
            }
            
            const paymentData = {
                productsInfo,
                paymentType,
                saveDeliveryType,
                deliveryName,
                deliveryAddress,
                deliveryRequest,
                ordererId,
                ordererName,
                phoneNumber,
                email,
                pointDC,
                couponUse
            };

            console.log(paymentData);
           
			// 주문 테이블 생성
			let isOrderMade = false
			let orderId = null
			let totalPrice = null
            $.ajax({
            	async: false,
                url: '/orderProducts',
                type: 'POST',
                contentType: 'application/json',
                dataType: "json",
                data: JSON.stringify(paymentData), // 전체 paymentData를 JSON으로 변환하여 전송
                success: function(response) {
                    console.log('Success:', response);
                    orderId = response.orderId
                    totalPrice = parseInt(response.totalPrice)
					isOrderMade = true
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
					isOrderMade = false;
                }
            });
			
            if (isOrderMade == false) {return} // 주문 테이블 생성이 제대로 안되었을 때 함수 종료
            
			// @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
			let amount = {
				currency: "KRW",
				value: totalPrice,
			}
            console.log("amount : " + JSON.stringify(amount))
			let orderName =  $(".product-name").find("a").text()
			orderName = orderName.substring(0, 20)
			if ($(".product-name").length > 1) {
				orderName += ("외 " + ($(".product-name").length - 1) + "건")
			}
            console.log("amount : " + amount)
            console.log("orderName : " + orderName)
			
            
			$.ajax({
				async : false,
				type : 'POST',
				url : "/order/payMethod",
				data : {
					method: selectedPaymentMethod
				},
				dataType: "json",
				contentType : 'application/x-www-form-urlencoded',
				success : function(response) {
					console.log("/order/payMethod의 response : " + JSON.stringify(response))
				},
				error : function(request, status, error) {
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
				}
			})
				
			switch (selectedPaymentMethod) {
			case "CARD":
				await payment.requestPayment({
					method: "CARD", // 카드 및 간편결제
					amount: amount,
					orderId: orderId,
					orderName: orderName,
					successUrl: window.location.origin + "/payment/success.html", // 결제 요청이 성공하면 리다이렉트되는 URL
					failUrl: window.location.origin + "/fail.html", // 결제 요청이 실패하면 리다이렉트되는 URL
					card: {
						useEscrow: false,
						flowMode: "DEFAULT",
						useCardPoint: false,
						useAppCardOnly: false,
					},
				});
			case "TRANSFER":
				await payment.requestPayment({
					method: "TRANSFER", // 계좌이체 결제
					amount: amount,
					orderId: orderId,
					orderName: orderName,
					successUrl: window.location.origin + "/payment/success.html",
					failUrl: window.location.origin + "/fail.html",
					transfer: {
						cashReceipt: {
						type: "소득공제",
						},
						useEscrow: false,
					},
				});
			case "VIRTUAL_ACCOUNT":
				await payment.requestPayment({
					method: "VIRTUAL_ACCOUNT", // 가상계좌 결제
					amount: amount,
					orderId: orderId,
					orderName: orderName,
					successUrl: window.location.origin + "/payment/success.html",
					failUrl: window.location.origin + "/fail.html",
					virtualAccount: {
						cashReceipt: {
						type: "소득공제",
						},
						useEscrow: false,
						validHours: 24,
					},
				});
			}

			// 네이버페이
			// 레퍼런스 : https://developers.pay.naver.com/docs/v2/api#etc-etc_pay_reserve
			if (selectedPaymentMethod == "NAVER_PAY") {
				console.log("네이버 페이 선택")
				oPay.open({
					"merchantPayKey": "202410179U6ds9",
					"productName": orderName,
					"productCount": "0",
					"totalPayAmount": "" + amount.value,
					"taxScopeAmount": "" + amount.value,
					"taxExScopeAmount": "0",
					"returnUrl": window.location.origin + "/approveNaverPay"
				});
			}
			
			// TODO : 카카오페이
			// 레퍼런스 : https://developers.kakaopay.com/docs/payment/online/single-payment#payment-ready-sample-request
			if (selectedPaymentMethod == "KAKAO_PAY") {
				console.log("카카오 페이 선택")
				// NOTE : http 요청으로 카카오페이 서버에 직접 보내면 유저가 브라우저의 개발자 도구를 통해 cid, partner_order_id 같은 중요한 정보를 직접 확인 가능
				// 그러므로 여기서는 POST 요청으로 서버의 컨트롤러에게 대신 요청을 보내도록 함.
				// TODO : 보낼 겍체에 필요한 정보 별도로 채워넣기 (주문번호, 가격)
				let item = {
					amount: amount.value
				}
				
				// NOTE : ajax 요청은 컨트롤러로부터 응답을 받아도 페이지를 이동시켜주지 않는다. 그래서 success 메서드를 붙어야 함 
				$.ajax({
					type : 'POST',
					url : "/kakaoPay/ready",
					data: item,
					dataType: "json",
					contentType : 'application/x-www-form-urlencoded',
					// NOTE : cotentType을 application/json으로 지정하고 스프링 서버에서 @Requestbody + DTO 객체로 받아올 수도 있지만 DTO 만들기 싫어서 이렇게 함
					success : function(response) {
						// console.log("response : " + response)
						// NOTE : 성공하면 페이지 이동해서 그 페이지에서 자바스크립트를 호출하여 카카오페이 결제 팝업을 바꾸는 방식에서
						// 페이지 이동하지 않고 그냥 주문 페이지에서 팝업 띄우는 방식으로 변경하였다.
						console.log("카카오페이 결제 팝업 호출")
						console.log("response : " + JSON.stringify(response))
						showKakaopayPaymentWindow(response.paymentURL)
					},
					error : function(request, status, error) {
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
					}
				})
			}
        }
	  
	  // TODO : orders 테이블에 행을 삽입하는 시점에서 orderId가 서버의 session에 저장되어 있어야 함.
	  // 일단 여기서는 테스트를 위해 입력폼으로 orderId를 전송, **테스트가 끝나면 컨트롤러의 메소드를 삭제해야 함!!**
	  function sendOrderIdForTest() {
		  let orderId = $("#testOrderIdInput").val()
		  console.log("서버 세션에 저장할 orderId : " + orderId)
		  $.ajax({
			  async : false,
			  type : 'POST',
			  url : "/payment/test/saveOrderId",
			  data: {
				  "orderId": orderId
			  },
			  dataType: "text",
			  success : function(res) {
				  console.log("saveOrderId 성공");
			  },
		      error : function(request, status, error) {
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				  console.log("saveOrderId 실패")       
			  }
		  })
	  }

	  // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하기 위해 서버에 저장
	  // orders 테이블에 insert가 이미 일어났으므로 orderId는 이미 서버에 저장되어 있음
	  function sendAmountToServer(amount) {
		  let response = null
		  let sentByOrderRequest = null
		  $.ajax({
			  async : false,
			  type : 'POST',
			  url : "/order/session",
			  data: amount, // amount 객체의 예시 : {currency : "KRW", value : 100}
			  dataType: "json",
			  contentType : 'application/x-www-form-urlencoded',
			  // NOTE : cotentType을 application/json으로 지정하고 스프링 서버에서 @Requestbody + DTO 객체로 받아올 수도 있지만 DTO 만들기 싫어서 이렇게 함
			  success : function(res) {
				  console.log("sendAmountToServer response : " + JSON.stringify(res));
				  response = res
			  },
		      error : function(request, status, error) {
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
			  }
		  })
		  return response
	  }
	  
	  function generateRandomString() {
		  return window.btoa(Math.random()).slice(0, 20);
	  }
	</script>
</body>
</html>