---------------------------------------------CAGLAR CEM UNVER 1ST DA PROJECT 5. PART------------------------------------------
WITH combined AS (
    SELECT 
        ad_date,
        adset_name
    FROM public.google_ads_basic_daily
    
    UNION ALL
    
    SELECT 
        f.ad_date,
        a.adset_name
    FROM public.facebook_ads_basic_daily f
    JOIN public.facebook_adset a
        ON f.adset_id = a.adset_id
),
dates_grouped AS (
    SELECT 
        adset_name,
        ad_date,
        ad_date - INTERVAL '1 day' * 
        ROW_NUMBER() OVER (
            PARTITION BY adset_name 
            ORDER BY ad_date
        ) AS grp
    FROM combined
),
streaks AS (
    SELECT 
        adset_name,
        MIN(ad_date) AS start_date,
        MAX(ad_date) AS end_date,
        COUNT(*) AS duration_days
    FROM dates_grouped
    GROUP BY adset_name, grp
)
SELECT 
    adset_name,
    start_date,
    end_date,
    duration_days
FROM streaks
ORDER BY duration_days DESC
LIMIT 1;
