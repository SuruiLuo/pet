package com.petHis.project.system.inventory.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.petHis.framework.aspectj.lang.annotation.Excel;
import com.petHis.framework.web.domain.BaseEntity;

/**
 * 药品库存对象 drug_inventory
 * 
 * @author petHis
 * @date 2025-02-23
 */
public class DrugInventory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 药品ID */
    private Long drugId;

    /** 药品名称 */
    @Excel(name = "药品名称")
    private String drugName;

    /** 规格 */
    @Excel(name = "规格")
    private String specification;

    /** 生产厂家 */
    @Excel(name = "生产厂家")
    private String manufacturer;

    /** 库存数量 */
    @Excel(name = "库存数量")
    private Long stockQuantity;

    /** 批次号 */
    @Excel(name = "批次号")
    private String batchNumber;

    /** 有效期 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @Excel(name = "有效期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date expirationDate;

    /** 进价 */
    @Excel(name = "进价")
    private BigDecimal purchasePrice;

    /** 零售价 */
    @Excel(name = "零售价")
    private BigDecimal retailPrice;

    /** 存放位置 */
    @Excel(name = "存放位置")
    private String storageLocation;

    /** 库存预警阈值 */
    @Excel(name = "库存预警阈值")
    private Long warningThreshold;

    /** 状态(0正常 1停用) */
    @Excel(name = "状态(0正常 1停用)")
    private String status;

    /** 删除标志(0存在 2删除) */
    private String delFlag;

    /** 单位价格（元/最小单位） */
    @Excel(name = "单位价格（元/最小单位）")
    private BigDecimal unitPrice;

    /** 每盒包含单位数量 */
    @Excel(name = "每盒包含单位数量")
    private Long unitQuantity;

    /** 单位类型（粒/片/支等） */
    @Excel(name = "单位类型（粒/片/支等）")
    private String unitType;


    public void setDrugId(Long drugId) 
    {
        this.drugId = drugId;
    }

    public Long getDrugId() 
    {
        return drugId;
    }

    public void setDrugName(String drugName) 
    {
        this.drugName = drugName;
    }

    public String getDrugName() 
    {
        return drugName;
    }

    public void setSpecification(String specification) 
    {
        this.specification = specification;
    }

    public String getSpecification() 
    {
        return specification;
    }

    public void setManufacturer(String manufacturer) 
    {
        this.manufacturer = manufacturer;
    }

    public String getManufacturer() 
    {
        return manufacturer;
    }

    public void setStockQuantity(Long stockQuantity) 
    {
        this.stockQuantity = stockQuantity;
    }

    public Long getStockQuantity() 
    {
        return stockQuantity;
    }

    public void setBatchNumber(String batchNumber) 
    {
        this.batchNumber = batchNumber;
    }

    public String getBatchNumber() 
    {
        return batchNumber;
    }

    public void setExpirationDate(Date expirationDate) 
    {
        this.expirationDate = expirationDate;
    }

    public Date getExpirationDate() 
    {
        return expirationDate;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) 
    {
        this.purchasePrice = purchasePrice;
    }

    public BigDecimal getPurchasePrice() 
    {
        return purchasePrice;
    }

    public void setRetailPrice(BigDecimal retailPrice) 
    {
        this.retailPrice = retailPrice;
    }

    public BigDecimal getRetailPrice() 
    {
        return retailPrice;
    }

    public void setStorageLocation(String storageLocation) 
    {
        this.storageLocation = storageLocation;
    }

    public String getStorageLocation() 
    {
        return storageLocation;
    }

    public void setWarningThreshold(Long warningThreshold) 
    {
        this.warningThreshold = warningThreshold;
    }

    public Long getWarningThreshold() 
    {
        return warningThreshold;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Long getUnitQuantity() {
        return unitQuantity;
    }

    public void setUnitQuantity(Long unitQuantity) {
        this.unitQuantity = unitQuantity;
    }

    public String getUnitType() {
        return unitType;
    }

    public void setUnitType(String unitType) {
        this.unitType = unitType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("drugId", getDrugId())
            .append("drugName", getDrugName())
            .append("specification", getSpecification())
            .append("manufacturer", getManufacturer())
            .append("stockQuantity", getStockQuantity())
            .append("batchNumber", getBatchNumber())
            .append("expirationDate", getExpirationDate())
            .append("purchasePrice", getPurchasePrice())
            .append("retailPrice", getRetailPrice())
            .append("storageLocation", getStorageLocation())
            .append("warningThreshold", getWarningThreshold())
            .append("status", getStatus())
            .append("delFlag", getDelFlag())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("unitPrice", getUnitPrice())
            .append("unitQuantity", getUnitQuantity())
            .append("unitType", getUnitType())
            .toString();
    }
}
