package com.petHis.project.system.company.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.project.system.company.mapper.CompanyMapper;
import com.petHis.project.system.company.domain.Company;
import com.petHis.project.system.company.service.ICompanyService;
import com.petHis.common.utils.text.Convert;

/**
 * companyService业务层处理
 * 
 * @author petHis
 * @date 2025-03-17
 */
@Service
public class CompanyServiceImpl implements ICompanyService 
{
    @Autowired
    private CompanyMapper companyMapper;

    /**
     * 查询company
     * 
     * @param companyId company主键
     * @return company
     */
    @Override
    public Company selectCompanyByCompanyId(Long companyId)
    {
        return companyMapper.selectCompanyByCompanyId(companyId);
    }

    /**
     * 查询company列表
     * 
     * @param company company
     * @return company
     */
    @Override
    public List<Company> selectCompanyList(Company company)
    {
        return companyMapper.selectCompanyList(company);
    }

    /**
     * 新增company
     * 
     * @param company company
     * @return 结果
     */
    @Override
    public int insertCompany(Company company)
    {
        return companyMapper.insertCompany(company);
    }

    /**
     * 修改company
     * 
     * @param company company
     * @return 结果
     */
    @Override
    public int updateCompany(Company company)
    {
        return companyMapper.updateCompany(company);
    }

    /**
     * 批量删除company
     * 
     * @param companyIds 需要删除的company主键
     * @return 结果
     */
    @Override
    public int deleteCompanyByCompanyIds(String companyIds)
    {
        return companyMapper.deleteCompanyByCompanyIds(Convert.toStrArray(companyIds));
    }

    /**
     * 删除company信息
     * 
     * @param companyId company主键
     * @return 结果
     */
    @Override
    public int deleteCompanyByCompanyId(Long companyId)
    {
        return companyMapper.deleteCompanyByCompanyId(companyId);
    }
}
