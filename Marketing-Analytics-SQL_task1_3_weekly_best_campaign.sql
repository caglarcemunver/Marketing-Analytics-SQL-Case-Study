---------------------------------------------CAGLAR CEM UNVER 1ST DA PROJECT 3. PART------------------------------------------
WITH combined AS (
    SELECT 
        ad_date,
        campaign_name,
        value
    FROM public.google_ads_basic_daily
    
    UNION ALL
    
    SELECT 
        f.ad_date,
        c.campaign_name,
        f.value
    FROM public.facebook_ads_basic_daily f
    JOIN public.facebook_campaign c 
        ON f.campaign_id = c.campaign_id
),
weekly_value AS (
    SELECT 
        DATE_TRUNC('week', ad_date) AS week_start,
        campaign_name,
        SUM(value) AS total_value
    FROM combined
    GROUP BY week_start, campaign_name
)
SELECT 
    week_start,
    campaign_name,
    ROUND(total_value,2) AS total_value
FROM weekly_value
ORDER BY total_value DESC
LIMIT 1;
