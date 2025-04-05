package com.petHis.contract;

import org.fisco.bcos.sdk.client.Client;
import org.fisco.bcos.sdk.crypto.CryptoSuite;
import org.fisco.bcos.sdk.crypto.keypair.CryptoKeyPair;
import org.fisco.bcos.sdk.model.CryptoType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractUtils {
    @Autowired
    private static Client client;
    @Autowired
    private static CryptoKeyPair cryptoKeyPair;
    public static CryptoKeyPair generateKeyPairAndAddress() {
        // 创建加密套件（使用 ECDSA 算法）
        CryptoSuite cryptoSuite = new CryptoSuite(CryptoType.ECDSA_TYPE);
        CryptoKeyPair keyPair = cryptoSuite.getKeyPairFactory().generateKeyPair();
        // 生成密钥对
        keyPair.storeKeyPairWithPemFormat();

        // 返回地址
        return keyPair;
    }

    /**
     * 方法 2：根据地址获取对应的 CryptoKeyPair
     * @param address 地址
     * @return 对应的 CryptoKeyPair，如果地址不存在则返回 null
     */
    public static CryptoKeyPair getCryptoKeyPairByAddress(String secretkey,String address) {
        CryptoSuite cryptoSuite = new CryptoSuite(CryptoType.ECDSA_TYPE);
        CryptoKeyPair keyPair = cryptoSuite.getKeyPairFactory().createKeyPair(secretkey);
        if (!keyPair.getAddress().equals(address)) {
            return null;
        }
        return keyPair;
    }
}
