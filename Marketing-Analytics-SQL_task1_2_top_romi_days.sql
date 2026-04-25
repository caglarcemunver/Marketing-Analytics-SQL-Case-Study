---------------------------------------------CAGLAR CEM UNVER 1ST DA PROJECT 2. PART------------------------------------------
WITH combined AS (
    SELECT 
        ad_date,
        spend,
        value
    FROM public.google_ads_basic_daily
    
    UNION ALL
    
    SELECT 
        ad_date,
        spend,
        value
    FROM public.facebook_ads_basic_daily
),
daily_romi AS (
    SELECT 
        ad_date,
        SUM(value) AS total_value,
        SUM(spend) AS total_spend,
        ROUND(SUM(value) / NULLIF(SUM(spend),0), 4) AS romi
    FROM combined
    GROUP BY ad_date
)
SELECT 
    ad_date,
    romi
FROM daily_romi
ORDER BY romi DESC
LIMIT 5;
