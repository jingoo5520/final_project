package com.finalProject.model.order;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class ProductCancelRequestDTO {
    private Integer orderproductNo;
    private String request; // "환불신청" 혹은 "환불취소"
}
