/*
 * package com.finalProject.aop;
 * 
 * import java.util.Map;
 * 
 * import org.aspectj.lang.ProceedingJoinPoint; import
 * org.aspectj.lang.annotation.Around; import
 * org.aspectj.lang.annotation.Aspect; import
 * org.springframework.http.ResponseEntity; import
 * org.springframework.stereotype.Component;
 * 
 * @Aspect
 * 
 * @Component public class GlobalAOPComponent {
 * 
 * @Around("execution(* com.finalProject.service.admin.product.ProductServiceImpl.deleteProduct(java.util.Map,..))"
 * ) public Object handleResponseEntity(ProceedingJoinPoint joinPoint) throws
 * Throwable { // 실제 메서드 실행 Object result = joinPoint.proceed(); // 메서드의 반환값이
 * ResponseEntity<Map>일 경우 처리 if (result instanceof ResponseEntity) {
 * ResponseEntity<Map> responseEntity = (ResponseEntity<Map>) result;
 * Map<String, Object> body = responseEntity.getBody();
 * 
 * // 성공 응답이면 status를 success로 설정 if (body != null &&
 * responseEntity.getStatusCode().is2xxSuccessful()) { body.put("status",
 * "12313"); } // 실패 응답이면 status를 fail로 설정 else { if (body != null) {
 * body.put("status", "41415"); } }
 * 
 * // 수정된 ResponseEntity 반환 return new ResponseEntity<>(body,
 * responseEntity.getStatusCode()); }
 * 
 * return result; // ResponseEntity가 아닌 경우 원래 결과 반환 } }
 */
