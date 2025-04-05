package com.petHis.project.system.company.mapper;

import java.util.List;
import com.petHis.project.system.company.domain.Company;

/**
 * companyMapper接口
 * 
 * @author petHis
 * @date 2025-03-17
 */
public interface CompanyMapper 
{
    /**
     * 查询company
     * 
     * @param companyId company主键
     * @return company
     */
    public Company selectCompanyByCompanyId(Long companyId);

    /**
     * 查询company列表
     * 
     * @param company company
     * @return company集合
     */
    public List<Company> selectCompanyList(Company company);

    /**
     * 新增company
     * 
     * @param company company
     * @return 结果
     */
    public int insertCompany(Company company);

    /**
     * 修改company
     * 
     * @param company company
     * @return 结果
     */
    public int updateCompany(Company company);

    /**
     * 删除company
     * 
     * @param companyId company主键
     * @return 结果
     */
    public int deleteCompanyByCompanyId(Long companyId);

    /**
     * 批量删除company
     * 
     * @param companyIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCompanyByCompanyIds(String[] companyIds);
}
