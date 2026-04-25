---------------------------------------------CAGLAR CEM UNVER 1ST DA PROJECT 4. PART------------------------------------------
WITH combined AS (
    SELECT 
        ad_date,
        campaign_name,
        reach
    FROM public.google_ads_basic_daily
    
    UNION ALL
    
    SELECT 
        f.ad_date,
        c.campaign_name,
        f.reach
    FROM public.facebook_ads_basic_daily f
    JOIN public.facebook_campaign c 
        ON f.campaign_id = c.campaign_id
),
monthly_reach AS (
    SELECT 
        DATE_TRUNC('month', ad_date) AS month,
        campaign_name,
        SUM(reach) AS total_reach
    FROM combined
    GROUP BY month, campaign_name
),
growth AS (
    SELECT 
        campaign_name,
        month,
        total_reach,
        total_reach - LAG(total_reach) OVER (
            PARTITION BY campaign_name 
            ORDER BY month
        ) AS reach_growth
    FROM monthly_reach
)
SELECT 
    campaign_name,
    month,
    reach_growth
FROM growth
ORDER BY reach_growth DESC
LIMIT 1;
