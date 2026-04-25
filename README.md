# Marketing Analytics & User Behavior Tracking | Pazarlama Analitiği ve Kullanıcı Davranışı Takibi

A dual-platform SQL project analyzing multi-channel ad performance (PostgreSQL) and e-commerce conversion funnels (BigQuery/GA4).

---

## 🇺🇸 English Version

### 📊 Project Overview
This study consists of two main parts:
1. **Ad Performance Analysis (PostgreSQL):** Combining Facebook and Google Ads data to calculate ROMI, reach growth, and campaign efficiency.
2. **Web Analytics (BigQuery & GA4):** Tracking user journeys through the conversion funnel, analyzing landing page performance, and session-based conversion rates.

### 🛠️ Technical Toolkit
- **PostgreSQL (DBeaver):** CTEs, Window Functions, Aggregate Operations.
- **Google BigQuery:** GA4 Schema handling, event-based tracking, session-id & user-id concatenation.

### 🔍 Key Insights Extracted
- Calculated daily **ROMI** and identified top-performing weekly campaigns.
- Built a **Conversion Funnel** from `session_start` to `purchase`.
- Analyzed **Landing Page Conversion Rates** (CR) to optimize marketing spend.

---

## 🇹🇷 Türkçe Versiyon

### 📊 Proje Özeti
Bu çalışma iki ana bölümden oluşmaktadır:
1. **Reklam Performans Analizi (PostgreSQL):** Facebook ve Google Ads verilerini birleştirerek ROMI, erişim artışı ve kampanya verimliliği hesaplamaları.
2. **Web Analitiği (BigQuery & GA4):** Kullanıcı yolculuğunu dönüşüm hunisi üzerinden takip etme, açılış sayfası performansı ve oturum bazlı dönüşüm oranları analizi.

### 🛠️ Teknik Yetkinlikler
- **PostgreSQL (DBeaver):** CTE'ler, Window Fonksiyonları, Agregat İşlemleri.
- **Google BigQuery:** GA4 şeması yönetimi, etkinlik bazlı takip, session_id & user-id birleştirme.

### 🔍 Elde Edilen Önemli Bulgular
- Günlük **ROMI** hesaplaması ve haftalık en iyi performans gösteren kampanyaların tespiti.
- `session_start` etkinliğinden `purchase` aşamasına kadar **Dönüşüm Hunisi** kurgusu.
- Pazarlama bütçesini optimize etmek için **Açılış Sayfası Dönüşüm Oranları** (CR) analizi.
