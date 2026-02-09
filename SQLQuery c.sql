/*
================================================================================
BLINKIT SALES ANALYSIS PROJECT
================================================================================
Description: Comprehensive data analysis and performance metrics for BlinkIT
             retail operations, including KPIs, sales trends, and outlet
             performance indicators.

Author:      [Your Name/GitHub User]
Created:     February 2026
Database:    SQL Server
Version:     1.0

Purpose:     This script performs end-to-end analysis of BlinkIT sales data,
             covering inventory metrics, customer ratings, revenue analysis,
             and outlet performance segmentation.

Usage:       Execute sections sequentially or run specific queries as needed.
             All monetary values are formatted to 2 decimal places.
================================================================================
*/

-- ============================================================================
-- SECTION 1: BASE DATA EXPLORATION
-- ============================================================================
-- Quick overview of the entire dataset
-- Use this to verify data structure and initial record counts

SELECT * 
FROM dbo.BlinkIT;

-- ============================================================================
-- SECTION 2: HIGH-LEVEL KPI'S (KEY PERFORMANCE INDICATORS)
-- ============================================================================
-- Core business metrics that provide snapshot of overall performance

-- Total Inventory Count
-- Returns: Total number of items/SKUs in the system
SELECT COUNT(*) AS Nr_of_Items
FROM dbo.BlinkIT;

-- Average Sales per Transaction
-- Returns: Mean sales value across all transactions
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
FROM dbo.BlinkIT;

-- Average Customer Rating
-- Returns: Overall customer satisfaction metric (typically 1-5 scale)
SELECT CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Average_Rating 
FROM dbo.BlinkIT; 

-- Average Sales for Low Fat Items Only
-- Returns: Mean sales specifically for health-conscious product segment
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales_LowFat
FROM dbo.BlinkIT
WHERE Item_Fat_Content = 'Low Fat';

-- ============================================================================
-- SECTION 3: GRANULAR SALES ANALYSIS
-- ============================================================================
-- Detailed breakdown of sales performance across different dimensions

-- Sales Performance by Item Category
-- Identifies which product types generate highest average revenue
SELECT 
      Item_Type
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales 
FROM dbo.BlinkIT
GROUP BY Item_Type
ORDER BY Average_Sales DESC;

-- Comprehensive Performance Metrics by Fat Content
-- Compares Low Fat vs Regular products across multiple KPIs
SELECT 
      Item_Fat_Content
    , COUNT(*) AS Nr_of_Items
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
    , CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Average_Rating
    , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM dbo.BlinkIT
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

-- TOP 5 Categories by Total Revenue
-- Reveals best-performing product categories for strategic focus
SELECT TOP 5 
      Item_Type
    , COUNT(*) AS Nr_of_Items
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
    , CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Average_Rating
    , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM dbo.BlinkIT
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- ============================================================================
-- SECTION 4: OUTLET PERFORMANCE ANALYSIS
-- ============================================================================
-- Multi-dimensional analysis of outlet characteristics and their impact on sales

-- Historical Performance by Establishment Year
-- Shows sales trends and evolution across outlet age cohorts
-- Useful for understanding maturity curves and lifecycle patterns
SELECT 
      Outlet_Establishment_Year
    , COUNT(*) AS Nr_of_Items
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
    , CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Average_Rating
    , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM dbo.BlinkIT
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

-- Performance by Outlet Size with Market Share
-- Analyzes correlation between outlet size and revenue contribution
-- Sales_Percentage shows each size category's contribution to total revenue
SELECT 
      Outlet_Size
    , COUNT(*) AS Nr_of_Items
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
    , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
    , CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER ()) AS DECIMAL(10, 2)) AS Sales_Percentage
FROM dbo.BlinkIT
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Performance by Location Tier
-- Compares Tier 1, Tier 2, Tier 3 cities performance
-- Critical for geographic expansion and resource allocation decisions
SELECT 
      Outlet_Location_Type
    , COUNT(*) AS Nr_of_Items
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
    , CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Average_Rating
    , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM dbo.BlinkIT
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- Performance by Outlet Type (Business Model)
-- Differentiates between Grocery Store, Supermarket Type1, Type2, Type3
-- Helps identify most effective retail format
SELECT 
      Outlet_Type
    , COUNT(*) AS Nr_of_Items
    , CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Average_Sales
    , CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Average_Rating
    , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM dbo.BlinkIT
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

-- ============================================================================
-- SECTION 5: ADVANCED DATA TRANSFORMATIONS
-- ============================================================================
-- Complex analytical queries using PIVOT and window functions

-- Pivot Table: Sales by Location Tier and Fat Content
-- Transforms row data into columnar format for easier comparison
-- ISNULL handles cases where a location has no sales in a category
-- Ideal for dashboard visualization and cross-tabulation analysis
SELECT
      Outlet_Location_Type
    , ISNULL([Low Fat], 0) AS Low_Fat
    , ISNULL([Regular], 0) AS Regular
FROM (
    SELECT
          Outlet_Location_Type
        , Item_Fat_Content
        , CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
    FROM dbo.BlinkIT
    GROUP BY Outlet_Location_Type, Item_Fat_Content 
) AS SourceTable
PIVOT ( 
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular]) 
) AS PivotTable
ORDER BY Outlet_Location_Type;

/*
================================================================================
END OF SCRIPT
================================================================================

Notes:
- All decimal values are rounded to 2 places for consistency
- NULL handling implemented where applicable
- Queries optimized for readability and maintainability

For questions or contributions, please open an issue on GitHub.
================================================================================
*/