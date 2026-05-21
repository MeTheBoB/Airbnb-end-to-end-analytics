# Airbnb-end-to-end-analytics
An end-to-end Machine Learning and Data Engineering pipeline that uses a RoBERTa neural network to extract true sentiment from Airbnb reviews, visualized in an interactive Power BI dashboard.


# 🏨 Airbnb End-to-End Analytics & NLP Pipeline

## 📖 Project Overview
Traditional 1-to-5 star ratings often fail to capture the true guest experience on Airbnb. A single unfair 1-star rating can tank a property's score, while a 5-star rating might hide sarcastic or mixed written feedback. 

This project is an end-to-end Data Engineering and Business Intelligence solution. It extracts raw Airbnb data, uses a state-of-the-art Natural Language Processing (NLP) neural network to score the true sentiment of written reviews, and serves those insights into an interactive Power BI dashboard for property managers.

## 🛠️ Architecture & Tech Stack
* **Data Engineering (ETL):** Python (`pandas`, `SQLAlchemy`)
* **Machine Learning (NLP):** Hugging Face `transformers`, RoBERTa-base-sentiment
* **Database & EDA:** Microsoft SQL Server (T-SQL)
* **Data Visualization:** Power BI

---

## 🚀 The Journey: Phase by Phase

### Phase 1: Data Ingestion & NLP (The ETL Pipeline)
**File:** `1_etl_pipeline/dataPipeline.ipynb`
* Designed an automated Python script to scan local directories for new raw Airbnb CSV datasets.
* Implemented **RoBERTa**, a deep learning model, to read the text of the 10,000 most recent reviews and generate precise probability scores for Negative, Neutral, and Positive sentiment.
* Engineered a bulletproof database connection using `SQLAlchemy` to load the transformed, AI-scored data directly into a relational SQL Server database in optimized chunks.

### Phase 2: Exploratory Data Analysis (SQL)
**File:** `2_sql_analysis/analyis.sql`
* Executed advanced SQL queries to verify data integrity and explore underlying trends before visualization.
* *(Note: Add 1-2 bullet points here explaining a cool insight you found while running your SQL queries!)*

### Phase 3: Business Intelligence (Power BI)
**File:** `3_dashboard/Airbnb.pbix`

*(Insert a screenshot of your Power BI dashboard here!)*
![Power BI Dashboard](3_dashboard/dashboard_preview.png)

Designed an interactive dashboard tailored for property managers and real estate investors.
**Key Features:**
* **The "Hidden Gem" Finder (Scatter Plot):** Plots Star Ratings against AI Positive Sentiment to instantly identify highly-praised properties that suffer from skewed star ratings.
* **The True Vibe Split (100% Stacked Bar):** Breaks down the exact probabilistic sentiment of properties at a glance.
* **The Red Flag Matrix:** A conditional heat map highlighting the most negative AI scores, allowing managers to instantly read the specific text that triggered the alert and fix maintenance/hosting issues.

---

## ⚙️ How to Run this Project Locally
1. Clone the repository.
2. Install Python dependencies: `pip install -r requirements.txt`
3. Update the SQL Server connection string in `dataPipeline.ipynb` to match your local instance.
4. Run the ETL pipeline to ingest data and process AI sentiment.
5. Open `Airbnb.pbix` and refresh the data source to view the dashboard.
