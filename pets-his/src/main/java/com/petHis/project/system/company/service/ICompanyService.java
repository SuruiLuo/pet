package com.petHis.project.system.company.service;

import java.util.List;

import com.petHis.project.system.clients.domain.Clients;
import com.petHis.project.system.company.domain.Company;

/**
 * companyService接口
 * 
 * @author petHis
 * @date 2025-03-17
 */
public interface ICompanyService
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
     * 批量删除company
     * 
     * @param companyIds 需要删除的company主键集合
     * @return 结果
     */
    public int deleteCompanyByCompanyIds(String companyIds);

    /**
     * 删除company信息
     * 
     * @param companyId company主键
     * @return 结果
     */
    public int deleteCompanyByCompanyId(Long companyId);
}
