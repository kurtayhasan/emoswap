# EmoSwap Deployment Guide

## 🚀 Proje Hazır! Son Adımlar

### ✅ Tamamlanan İşlemler:
- ✅ Smart contract'lar düzeltildi
- ✅ Frontend temizlendi ve optimize edildi
- ✅ Gereksiz dosyalar kaldırıldı
- ✅ Proje yapısı düzenlendi

### 🔧 Yapmanız Gerekenler:

#### 1. Environment Dosyalarını Oluşturun
```bash
# Root dizinde .env dosyası oluşturun
cp env.example .env

# Web dizininde .env.local dosyası oluşturun
cd web
cp env.example .env.local
```

#### 2. Environment Değişkenlerini Düzenleyin
`.env` dosyasını açın ve şunları ekleyin:
```env
DEPLOYER_MNEMONIC="your testnet mnemonic phrase here"
```

#### 3. Testnet ALGO Alın
- [AlgoFaucet](https://bank.testnet.algorand.network/) adresinden testnet ALGO alın
- Pera Wallet'ı testnet'e bağlayın

#### 4. Python Bağımlılıklarını Yükleyin
```bash
pip install pyteal==0.24.1 py-algorand-sdk==2.11.0 beaker-pyteal==1.1.1 python-dotenv==0.19.2
```

#### 5. Frontend Bağımlılıklarını Yükleyin
```bash
cd web
npm install
```

#### 6. Smart Contract'ları Deploy Edin
```bash
# Contract'ları derle
python scripts/compile_teal.py

# EmotionFactory'yi deploy et
python scripts/deploy_emotion_factory.py

# $MOOD token ve Governance'i deploy et
python scripts/deploy_liquidity_and_stake.py

# Her emotion için SwapPool deploy et (örnek)
python scripts/deploy_swap_pool.py <asset_id>
```

#### 7. Frontend Konfigürasyonunu Güncelleyin
Deploy edilen contract ID'lerini `web/.env.local` dosyasına ekleyin:
```env
NEXT_PUBLIC_EMOTION_FACTORY_ID=<deployed_id>
NEXT_PUBLIC_SWAP_POOL_IDS={"Happy": <pool_id>}
NEXT_PUBLIC_LIQUIDITY_POOL_IDS={"Happy": <liquidity_id>}
NEXT_PUBLIC_STAKING_REWARDS_ID=<staking_id>
NEXT_PUBLIC_GOVERNANCE_ID=<governance_id>
NEXT_PUBLIC_MOOD_TOKEN_ID=<mood_token_id>
```

#### 8. Frontend'i Başlatın
```bash
cd web
npm run dev
```

### 🎯 Sonuç:
- Frontend: `http://localhost:3000`
- Tüm özellikler çalışır durumda
- Wallet bağlantısı aktif
- Contract etkileşimleri hazır

### 📁 Proje Yapısı:
```
emoswap/
├── contracts/           # Smart contract'lar
├── scripts/            # Deploy script'leri
├── web/                # Frontend (Next.js)
├── docs/               # Dokümantasyon
├── .env                # Environment variables
├── .gitignore          # Git ignore
├── LICENSE             # MIT License
└── README.md           # Proje açıklaması
```

### 🎉 Tebrikler!
EmoSwap projeniz tamamen hazır ve production-ready!
