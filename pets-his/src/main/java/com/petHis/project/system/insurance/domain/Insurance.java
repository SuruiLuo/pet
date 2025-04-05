package com.petHis.project.system.insurance.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.petHis.framework.aspectj.lang.annotation.Excel;
import com.petHis.framework.web.domain.BaseEntity;

/**
 * 保险对象 insurance
 * 
 * @author petHis
 * @date 2025-03-17
 */
public class Insurance extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 保险ID */
    private Long insuranceId;

    private Long companyId;

    public Long getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Long companyId) {
        this.companyId = companyId;
    }

    /** 保险名 */
    @Excel(name = "保险名")
    private String name;

    /** 一级赔付额 */
    @Excel(name = "一级赔付额")
    private BigDecimal level1Num;

    public BigDecimal getPremium() {
        return premium;
    }

    public void setPremium(BigDecimal premium) {
        this.premium = premium;
    }

    @Excel(name = "保费")
    private BigDecimal premium;

    /** 一级赔付比 */
    @Excel(name = "一级赔付比")
    private BigDecimal level1ClaimRatio;

    /** 二级赔付额 */
    @Excel(name = "二级赔付额")
    private BigDecimal level2Num;

    /** 二级赔付比 */
    @Excel(name = "二级赔付比")
    private BigDecimal level2ClaimRatio;

    public void setInsuranceId(Long insuranceId) 
    {
        this.insuranceId = insuranceId;
    }

    public Long getInsuranceId() 
    {
        return insuranceId;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public void setLevel1Num(BigDecimal level1Num) 
    {
        this.level1Num = level1Num;
    }

    public BigDecimal getLevel1Num() 
    {
        return level1Num;
    }

    public void setLevel1ClaimRatio(BigDecimal level1ClaimRatio) 
    {
        this.level1ClaimRatio = level1ClaimRatio;
    }

    public BigDecimal getLevel1ClaimRatio() 
    {
        return level1ClaimRatio;
    }

    public void setLevel2Num(BigDecimal level2Num) 
    {
        this.level2Num = level2Num;
    }

    public BigDecimal getLevel2Num() 
    {
        return level2Num;
    }

    public void setLevel2ClaimRatio(BigDecimal level2ClaimRatio) 
    {
        this.level2ClaimRatio = level2ClaimRatio;
    }

    public BigDecimal getLevel2ClaimRatio() 
    {
        return level2ClaimRatio;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("insuranceId", getInsuranceId())
            .append("companyId", getCompanyId())
            .append("premium", getPremium())
            .append("name", getName())
            .append("level1Num", getLevel1Num())
            .append("level1ClaimRatio", getLevel1ClaimRatio())
            .append("level2Num", getLevel2Num())
            .append("level2ClaimRatio", getLevel2ClaimRatio())
            .toString();
    }
}
