SELECT * FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` LIMIT 1000

WITH base_events AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    user_pseudo_id,

    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,

    event_name,

   
    (SELECT value.string_value
     FROM UNNEST(event_params)
     WHERE key = 'page_location') AS page_location

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

  WHERE _TABLE_SUFFIX BETWEEN '20200101' AND '20201231'
),

sessions AS (
  SELECT
    user_pseudo_id,
    session_id,

   
    MAX(CASE 
        WHEN event_name = 'session_start' 
        THEN page_location 
        END) AS landing_page,

    MAX(CASE 
        WHEN event_name = 'session_start' 
        THEN 1 ELSE 0 
        END) AS has_session,

    MAX(CASE 
        WHEN event_name = 'purchase' 
        THEN 1 ELSE 0 
        END) AS has_purchase

  FROM base_events
  GROUP BY user_pseudo_id, session_id
)

SELECT
  landing_page AS page_path,

  COUNTIF(has_session = 1) AS user_sessions_count,

  COUNTIF(has_purchase = 1) AS purchase_count,

  SAFE_DIVIDE(
    COUNTIF(has_purchase = 1),
    COUNTIF(has_session = 1)
  ) AS purchase_conversion_rate

FROM sessions
WHERE has_session = 1
  AND landing_page IS NOT NULL

GROUP BY landing_page
ORDER BY purchase_conversion_rate DESC;
