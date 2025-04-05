package com.petHis.project.system.clients.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.project.system.clients.mapper.ClientsMapper;
import com.petHis.project.system.clients.domain.Clients;
import com.petHis.project.system.clients.service.IClientsService;
import com.petHis.common.utils.text.Convert;

/**
 * 客户Service业务层处理
 * 
 * @author petHis
 * @date 2025-02-16
 */
@Service
public class ClientsServiceImpl implements IClientsService 
{
    @Autowired
    private ClientsMapper clientsMapper;

    /**
     * 查询客户
     *
     * @param userId 客户主键
     * @return 客户
     */
    @Override
    public Clients selectClientsByUserId(Long userId)
    {
        return clientsMapper.selectClientsByUserId(userId);
    }

    /**
     * 查询客户
     * 
     * @param clientId 客户主键
     * @return 客户
     */
    @Override
    public Clients selectClientsByClientId(Long clientId)
    {
        return clientsMapper.selectClientsByClientId(clientId);
    }

    /**
     * 查询客户列表
     * 
     * @param clients 客户
     * @return 客户
     */
    @Override
    public List<Clients> selectClientsList(Clients clients)
    {
        return clientsMapper.selectClientsList(clients);
    }

    /**
     * 新增客户
     * 
     * @param clients 客户
     * @return 结果
     */
    @Override
    public int insertClients(Clients clients)
    {
        // 检查 phone 号码是否已存在
//        Clients existingClient = clientsMapper.selectClientByPhone(client.getPhone());
        List<Clients> existingClient = clientsMapper.selectClientsList(clients);
        if(existingClient.size()>0){
            throw new RuntimeException("该手机号码已存在，不能重复插入！");
        }
        return clientsMapper.insertClients(clients);
    }

    /**
     * 修改客户
     * 
     * @param clients 客户
     * @return 结果
     */
    @Override
    public int updateClients(Clients clients)
    {
        Clients newClient = new Clients();
        newClient.setPhone(clients.getPhone());
        List<Clients> isExistPhone= selectClientsList(newClient);
//        System.out.println(isExistPhone);
//        System.out.println(clients);
//        System.out.println(isExistPhone.isEmpty());
        if (!isExistPhone.isEmpty()){
            throw new RuntimeException("该手机号已存在，请勿重复添加。");
        }
        return clientsMapper.updateClients(clients);
    }

    /**
     * 批量删除客户
     * 
     * @param clientIds 需要删除的客户主键
     * @return 结果
     */
    @Override
    public int deleteClientsByClientIds(String clientIds)
    {
        return clientsMapper.deleteClientsByClientIds(Convert.toStrArray(clientIds));
    }

    /**
     * 删除客户信息
     * 
     * @param clientId 客户主键
     * @return 结果
     */
    @Override
    public int deleteClientsByClientId(Long clientId)
    {
        return clientsMapper.deleteClientsByClientId(clientId);
    }

}
