package com.petHis.project.system.company.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.petHis.framework.aspectj.lang.annotation.Excel;
import com.petHis.framework.web.domain.BaseEntity;

/**
 * company对象 company
 * 
 * @author petHis
 * @date 2025-03-17
 */
public class Company extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Long companyId;

    /**  */
    @Excel(name = "")
    private String name;

    public void setCompanyId(Long companyId) 
    {
        this.companyId = companyId;
    }

    public Long getCompanyId() 
    {
        return companyId;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("companyId", getCompanyId())
            .append("name", getName())
            .toString();
    }
}
