package com.agri.merchant.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("merchant")
public class Merchant {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String account;
    private String password;
    private String merchantName;
    private String contactPerson;
    private String contactPhone;
    private String businessLicense;
    private String legalPersonId;
    private String shopLogo;
    private String shopDescription;
    private Integer status;
    private String rejectReason;
    private BigDecimal commissionRate;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
