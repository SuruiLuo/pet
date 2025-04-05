package com.petHis.contract.service;

import com.petHis.common.exception.AlertException;
import com.petHis.contract.BlockService;
import com.petHis.contract.data.PetInsurance;
import org.fisco.bcos.sdk.abi.datatypes.DynamicArray;
import org.fisco.bcos.sdk.model.TransactionReceipt;
import org.fisco.bcos.sdk.transaction.model.exception.ContractException;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.List;
import java.util.Objects;

@Service
public class PetInsuranceService extends BlockService {

    public void addUser(Long userId, String name) {
        PetInsurance petInsurance = PetInsurance.load(petInsuranceContract, client, cryptoKeyPair);
        TransactionReceipt transactionReceipt = petInsurance.addUser(
                BigInteger.valueOf(userId), name, BigInteger.ZERO
        );
        if (transactionReceipt.getMessage() != null) {
            throw new AlertException("添加用户失败");
        } else if (Objects.equals(transactionReceipt.getStatusMsg(), "RevertInstruction")) {
            throw new AlertException("添加用户失败");
        }
    }

    public void addPet(Long petId, Long userId, String name) {
        PetInsurance petInsurance = PetInsurance.load(petInsuranceContract, client, cryptoKeyPair);
        TransactionReceipt transactionReceipt = petInsurance.addPet(
                BigInteger.valueOf(petId),
                BigInteger.valueOf(userId),
                name
        );
        if (transactionReceipt.getMessage() != null) {
            throw new AlertException("添加宠物失败");
        } else if (Objects.equals(transactionReceipt.getStatusMsg(), "RevertInstruction")) {
            throw new AlertException("添加宠物失败");
        }
    }

    public void addInsurance(Long insuranceId,
                             String name,
                             BigInteger level1Num,
                             BigInteger level1Ratio,
                             BigInteger level2Num,
                             BigInteger level2Ratio,
                             BigInteger premium) {
        PetInsurance petInsurance = PetInsurance.load(petInsuranceContract, client, cryptoKeyPair);
        TransactionReceipt transactionReceipt = petInsurance.addInsurance(
                BigInteger.valueOf(insuranceId),
                name,
                level1Num,
                level1Ratio,
                level2Num,
                level2Ratio,
                premium
        );
        if (transactionReceipt.getMessage() != null) {
            throw new AlertException("添加保险失败");
        } else if (Objects.equals(transactionReceipt.getStatusMsg(), "RevertInstruction")) {
            throw new AlertException("添加保险失败");
        }
    }

    public void purchaseInsurance(Long userId,
                                  Long petId,
                                  Long insuranceId) {
        PetInsurance petInsurance = PetInsurance.load(petInsuranceContract, client, cryptoKeyPair);
        TransactionReceipt transactionReceipt = petInsurance.purchaseInsurance(
                BigInteger.valueOf(userId),
                BigInteger.valueOf(petId),
                BigInteger.valueOf(insuranceId)
        );
        if (transactionReceipt.getMessage() != null) {
            throw new AlertException("购买保险失败");
        } else if (Objects.equals(transactionReceipt.getStatusMsg(), "RevertInstruction")) {
            throw new AlertException("购买保险失败");
        }
    }

    public void claimInsurance(Long petId,
                               BigInteger medicalExpense) {
        PetInsurance petInsurance = PetInsurance.load(petInsuranceContract, client, cryptoKeyPair);
        TransactionReceipt transactionReceipt = petInsurance.claimInsurance(
                BigInteger.valueOf(petId), medicalExpense
        );
        if (transactionReceipt.getMessage() != null) {
            throw new AlertException("保险理赔失败");
        } else if (Objects.equals(transactionReceipt.getStatusMsg(), "RevertInstruction")) {
            throw new AlertException("保险理赔失败,请检查是否已购买保险或者保险已过期");
        }
    }

    public List<PetInsurance.TradeLog> getTradeLogsByUser(Long userId) {
        PetInsurance petInsurance = PetInsurance.load(petInsuranceContract, client, cryptoKeyPair);
        DynamicArray<PetInsurance.TradeLog> tradeLogsByUser = null;
        try {
            tradeLogsByUser = petInsurance.getTradeLogsByUser(BigInteger.valueOf(userId));
        } catch (ContractException e) {
            throw new RuntimeException(e);
        }
        List<PetInsurance.TradeLog> value = tradeLogsByUser.getValue();
        return value;
    }
}



