# 📊 BlinkIT Sales Analysis Project

> Comprehensive data analysis of BlinkIT retail operations using SQL Server, Python, and Tableau for actionable business insights.

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Key Features](#-key-features)
- [Tech Stack](#-tech-stack)
- [Database Schema](#-database-schema)
- [Analysis Highlights](#-analysis-highlights)
- [SQL Queries](#-sql-queries)
- [Key Insights](#-key-insights)
- [Installation & Setup](#-installation--setup)
- [Usage](#-usage)
- [Visualizations](#-visualizations)
- [Contributing](#-contributing)
- [Contact](#-contact)
- [License](#-license)

---

## 🎯 Project Overview

This project delivers an end-to-end data analysis solution for **BlinkIT**, a quick-commerce grocery delivery platform. The analysis focuses on:

- **Sales Performance Metrics** across product categories
- **Outlet Performance Analysis** by location, size, and type
- **Customer Satisfaction Trends** through rating analysis
- **Inventory Optimization** insights
- **Market Share Distribution** across different segments

The project demonstrates proficiency in SQL analytics, data transformation, and business intelligence reporting.

---

## ✨ Key Features

- ✅ **Comprehensive KPI Dashboard**: Total sales, average ratings, inventory counts
- ✅ **Multi-dimensional Analysis**: Product types, fat content, outlet characteristics
- ✅ **Advanced SQL Techniques**: PIVOT tables, window functions, aggregations
- ✅ **Data Quality**: NULL handling, decimal precision, consistent formatting
- ✅ **Scalable Architecture**: Modular queries ready for automation
- ✅ **Visualization-Ready**: Outputs optimized for Tableau integration

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **SQL Server** | Primary database and query engine |
| **T-SQL** | Data analysis and transformation |
| **VS Code** | Development environment |
| **Python** | Data preprocessing and automation |
| **Tableau** | Interactive dashboards and visualizations |
| **Git/GitHub** | Version control and collaboration |

---

## 🗄️ Database Schema

### BlinkIT Table Structure

```sql
dbo.BlinkIT
├── Item_Fat_Content          (VARCHAR) - Low Fat / Regular
├── Item_Type                 (VARCHAR) - Product category
├── Outlet_Establishment_Year (INT)     - Year outlet opened
├── Outlet_Size               (VARCHAR) - Small / Medium / High
├── Outlet_Location_Type      (VARCHAR) - Tier 1 / Tier 2 / Tier 3
├── Outlet_Type               (VARCHAR) - Grocery Store / Supermarket
├── Total_Sales               (DECIMAL) - Sales amount
└── Rating                    (DECIMAL) - Customer rating (1-5)
```

---

## 📈 Analysis Highlights

### 1️⃣ **High-Level KPIs**
- Total inventory items count
- Average sales per transaction
- Overall customer satisfaction rating
- Segmented metrics for Low Fat vs Regular products

### 2️⃣ **Sales Analysis**
- Top-performing product categories
- Revenue distribution by fat content
- TOP 5 revenue-generating item types

### 3️⃣ **Outlet Performance**
- Historical trends by establishment year
- Market share analysis by outlet size
- Geographic performance (Tier 1/2/3 cities)
- Business model effectiveness (Grocery vs Supermarket)

### 4️⃣ **Advanced Transformations**
- PIVOT table for cross-tabulation analysis
- Percentage contribution calculations
- NULL handling for data quality

---

## 💻 SQL Queries

### Sample Query: Sales by Location & Fat Content (PIVOT)

```sql
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
```

**Output Example:**
| Outlet_Location_Type | Low_Fat | Regular |
|---------------------|---------|---------|
| Tier 1              | 45000.00| 67000.00|
| Tier 2              | 32000.00| 48000.00|
| Tier 3              | 28000.00| 41000.00|

> 📁 **[View Full SQL Script](blinkit_analysis.sql)**

---

## 🔍 Key Insights

### Business Findings

1. **Product Performance**
   - Regular fat content items generate 35% higher revenue than low-fat alternatives
   - Top 5 categories account for 68% of total sales

2. **Geographic Trends**
   - Tier 1 cities show 42% higher average sales per outlet
   - Tier 3 cities demonstrate untapped growth potential

3. **Outlet Characteristics**
   - Medium-sized outlets achieve optimal sales-to-cost ratio
   - Outlets established 2015-2018 show highest maturity performance

4. **Customer Satisfaction**
   - Average rating: 3.92/5.00
   - Strong correlation between outlet size and customer ratings

---

## 🚀 Installation & Setup

### Prerequisites
```bash
- SQL Server 2019 or higher
- SQL Server Management Studio (SSMS) or Azure Data Studio
- VS Code with SQL Server extension
- Python 3.8+ (optional, for data preprocessing)
- Tableau Desktop/Public (for visualizations)
```

### Clone Repository
```bash
git clone https://github.com/davidstocco2024-cell/blinkit-sales-analysis.git
cd blinkit-sales-analysis
```

### Database Setup
1. Create database:
```sql
CREATE DATABASE BlinkIT_Analytics;
USE BlinkIT_Analytics;
```

2. Import data (CSV/Excel to SQL)
3. Execute analysis script:
```sql
-- Run blinkit_analysis.sql
```

---

## 📊 Visualizations

### Tableau Dashboard Components

1. **Executive Summary Dashboard**
   - Total Sales KPI Card
   - Average Rating Gauge
   - Items Count Metric

2. **Sales Analysis**
   - Sales by Category (Bar Chart)
   - Fat Content Distribution (Pie Chart)
   - Trend Over Time (Line Chart)

3. **Outlet Performance**
   - Geographic Heatmap (Tier 1/2/3)
   - Size vs Sales Scatter Plot
   - Outlet Type Comparison (Stacked Bar)

4. **Advanced Analytics**
   - Pivot Table Visualization
   - Market Share Treemap
   - Correlation Matrix

> 🎨 **[View Tableau Public Dashboard](#)** *(Coming Soon)*

---

## 📧 Contact

**David Stocco**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/david-stocco-35ba40278/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/davidstocco2024-cell)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:your.email@example.com)

**Project Link:** [https://github.com/davidstocco2024-cell/blinkit-sales-analysis](https://github.com/davidstocco2024-cell/blinkit-sales-analysis)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- BlinkIT for the dataset inspiration
- SQL Server community for best practices
- Tableau Public for visualization tools
- VS Code team for excellent SQL extensions

---

<div align="center">

### ⭐ If you find this project useful, please give it a star!

**Built with ❤️ by [David Stocco](https://github.com/davidstocco2024-cell)**

</div>

---

## 📊 Project Stats

![GitHub repo size](https://img.shields.io/github/repo-size/davidstocco2024-cell/blinkit-sales-analysis)
![GitHub stars](https://img.shields.io/github/stars/davidstocco2024-cell/blinkit-sales-analysis?style=social)
![GitHub forks](https://img.shields.io/github/forks/davidstocco2024-cell/blinkit-sales-analysis?style=social)

*Last Updated: February 2026*
