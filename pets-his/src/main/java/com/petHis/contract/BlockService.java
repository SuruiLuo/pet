package com.petHis.contract;

import com.alibaba.fastjson.JSONObject;
import org.fisco.bcos.sdk.client.Client;
import org.fisco.bcos.sdk.client.protocol.response.BcosBlock;
import org.fisco.bcos.sdk.crypto.keypair.CryptoKeyPair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.List;

@Service
public class BlockService {

    @Autowired
    public Client client;
    @Autowired
    public CryptoKeyPair cryptoKeyPair;
    @Value("${fisco.contractAddress.PetInsuranceContract}")
    public String petInsuranceContract;
    @Value("${fisco.contractAddress.AdminAddress}")
    public String adminAddress;

    public JSONObject getBlockchainInfo() {
        BigInteger latestBlockNumber = client.getBlockNumber().getBlockNumber();
        BcosBlock block = client.getBlockByNumber(latestBlockNumber, true);
        //第二个参数 var2 是一个 boolean 类型的变量，表示是否要获取该区块的详细信息。

        List<BcosBlock.TransactionResult> transactions = block.getBlock().getTransactions();
        String latesTransacitionHash = null;
        if (!transactions.isEmpty()) {
            BcosBlock.TransactionResult transactionResult = transactions.get(transactions.size() - 1);
            if (transactionResult instanceof BcosBlock.TransactionObject) {
                latesTransacitionHash = ((BcosBlock.TransactionObject) transactionResult).getHash();
            }
        }
        JSONObject requesjsonObject = new JSONObject();
        requesjsonObject.put("latestBlockNumber", latestBlockNumber);
        requesjsonObject.put("latesTransacitionHash", latesTransacitionHash);
        return requesjsonObject;
    }

    public BcosBlock getBlockNumberDetails(Long blockNumber) {
        try {
            BcosBlock blockByNumber = client.getBlockByNumber(BigInteger.valueOf(blockNumber), true);
            return blockByNumber;
        }catch (Exception e) {
            return null;
        }
    }
}



