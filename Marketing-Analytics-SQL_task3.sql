SELECT * FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` LIMIT 1000

WITH base_events AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    user_pseudo_id,
    
    (SELECT value.int_value 
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    
    event_name,
    traffic_source.source AS source,
    traffic_source.medium AS medium,
    traffic_source.name AS campaign

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

  WHERE 
    _TABLE_SUFFIX BETWEEN '20210101' AND '20211231'
),

sessions AS (
  SELECT
    event_date,
    source,
    medium,
    campaign,
    user_pseudo_id,
    session_id,

    MAX(CASE WHEN event_name = 'session_start' THEN 1 ELSE 0 END) AS has_session,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS has_cart,
    MAX(CASE WHEN event_name = 'begin_checkout' THEN 1 ELSE 0 END) AS has_checkout,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS has_purchase

  FROM base_events
  GROUP BY 
    event_date,
    source,
    medium,
    campaign,
    user_pseudo_id,
    session_id
)

SELECT
  event_date,
  source,
  medium,
  campaign,

  COUNTIF(has_session = 1) AS user_sessions_count,

  SAFE_DIVIDE(
    COUNTIF(has_cart = 1),
    COUNTIF(has_session = 1)
  ) AS visit_to_cart,

  SAFE_DIVIDE(
    COUNTIF(has_checkout = 1),
    COUNTIF(has_session = 1)
  ) AS visit_to_checkout,

  SAFE_DIVIDE(
    COUNTIF(has_purchase = 1),
    COUNTIF(has_session = 1)
  ) AS visit_to_purchase

FROM sessions
WHERE has_session = 1

GROUP BY
  event_date,
  source,
  medium,
  campaign

ORDER BY event_date;
