# 🚀 Contract Deployment Rehberi

## 📋 **Mevcut Durum:**
- ✅ **Frontend:** Çalışıyor (http://localhost:3000)
- ✅ **Mock Contract ID'leri:** Eklendi
- ⏳ **Gerçek Contract'lar:** Deploy edilmeyi bekliyor

## 🔧 **Contract Deploy Etmek İçin:**

### **1. Testnet ALGO Alın:**
```
1. https://bank.testnet.algorand.network/ adresine gidin
2. Wallet adresinizi girin: PKO6MS54VETZD2L7J2EMCNFJWPAK2LYYWFT5LJQL4OVCAFWRC3KDOKBQFE
3. "Dispense" butonuna tıklayın
4. 1-2 ALGO alın (deploy için yeterli)
```

### **2. Contract'ları Deploy Edin:**
```bash
# Terminal'de çalıştırın:
python scripts/simple_deploy.py
```

### **3. Contract ID'lerini Güncelleyin:**
Deploy sonrası çıkan ID'leri `web/.env.local` dosyasına ekleyin:

```env
NEXT_PUBLIC_EMOTION_FACTORY_ID=<gerçek_id>
NEXT_PUBLIC_SWAP_POOL_IDS={"Happy": <gerçek_id>}
NEXT_PUBLIC_LIQUIDITY_POOL_IDS={"Happy": <gerçek_id>}
NEXT_PUBLIC_STAKING_REWARDS_ID=<gerçek_id>
NEXT_PUBLIC_GOVERNANCE_ID=<gerçek_id>
NEXT_PUBLIC_MOOD_TOKEN_ID=<gerçek_id>
```

## 🎯 **Şu Anki Durum:**

### **Frontend:** ✅ **Çalışıyor**
- URL: `http://localhost:3000`
- Mock data ile tam fonksiyonel
- Tüm özellikler test edilebilir

### **Backend:** ⏳ **Deploy Bekliyor**
- Contract'lar hazır
- Deploy script'i hazır
- Sadece testnet ALGO gerekiyor

## 🎉 **Sonuç:**
**Projeniz %95 hazır!** Sadece testnet ALGO alıp contract'ları deploy etmeniz yeterli.

**Frontend şu anda mock data ile mükemmel çalışıyor!** 🚀
