# Airbnb Comprehensive Data Analytics and NLP Pipeline

## Project Overview

This repository documents an enterprise-grade, end-to-end analytics pipeline engineered to translate raw Airbnb telemetry into actionable business intelligence. Crucially, the architectural design and methodological approach were strictly governed by predefined business requirements. Rather than performing isolated statistical exercises, every data transformation, SQL aggregation, and Machine Learning inference was reverse-engineered from core stakeholder questions regarding yield management, market saturation, and true customer sentiment.

While traditional quantitative metrics (e.g., 1-to-5 star ratings) offer a baseline heuristic for property performance, they are highly susceptible to skew and frequently fail to capture nuanced qualitative experiences or complex pricing dynamics. To bridge this analytical gap, this project deploys advanced Natural Language Processing (NLP) to extract latent sentiment from unstructured text, fusing qualitative insights with quantitative operational data to drive strategic, data-driven decision-making

## Repository Structure

* /dataPipeline.ipynb: The core Python ETL engine. Automates the extraction of raw Airbnb calendar and review data, performs data cleaning, generates unique listing IDs, executes RoBERTa-based sentiment analysis on guest reviews, and loads the structured data into a SQL Server database via SQLAlchemy.
* /EDA.sql: The Exploratory Data Analysis script. Contains advanced T-SQL queries used to validate data integrity, explore seasonality, calculate average pricing and occupancy metrics, and identify variance in property performance.
* /Airbnb.pbix: The final Power BI dashboard. Translates the database into an interactive tool for stakeholders to analyze property metrics, market trends, and AI-driven sentiment analysis.
* /Business questions.docx: Outlines the primary objectives and key performance indicators (KPIs) driving this analysis.
* /project_plan.docx & /diary.docx: Documentation of the project lifecycle, including phase planning, execution logs, and architectural decisions.

## Architecture and Tech Stack

* Data Engineering (ETL): Python (Pandas, SQLAlchemy, PyODBC)
* Machine Learning (NLP): Hugging Face Transformers (RoBERTa-base-sentiment)
* Relational Database: Microsoft SQL Server (T-SQL)
* Data Visualization: Power BI

##Note on the Power BI Dashboard (.pbix): 
Due to GitHub's file size limitations for large relational datasets, the compiled Airbnb.pbix file exceeds the maximum upload threshold. 
Consequently, the semantic model, DAX measures, and interactive presentation layer have been rigorously documented via high-resolution visual evidence in the sections below.

## Methodology and Project Phases

### Phase 1: Planning and Business Requirements
Guided by the objectives outlined in the business questions document, the project plan was structured to first address fundamental operational metrics (pricing and availability) before layering on advanced analytics (NLP sentiment).

### Phase 2: Data Ingestion and Transformation (ETL)
The Python pipeline systematically scans local directories for raw CSV files (e.g., Calendar and Reviews data). 
* Data Cleaning: Formats date columns, cleans text fields, and establishes relational primary keys.
* Advanced Transformation: Integrates a pre-trained RoBERTa deep learning model to process the text of recent reviews, calculating exact probabilities for Positive, Neutral, and Negative sentiment.
* Database Loading: Uses batch processing to securely push millions of transformed records into SQL Server.

### Phase 3: Exploratory Data Analysis (SQL)
Before visualization, the data was rigorously tested and explored within SQL Server. Queries were designed to:
* Aggregate average daily rates (ADR) across different geographic regions.
* Analyze seasonal availability and occupancy trends.
* Cross-reference traditional star ratings against the newly generated NLP sentiment scores.

### Phase 4: Business Intelligence and Visualization
The Power BI dashboard serves as the final product, enabling stakeholders to interact with the data dynamically. 

#### Executive Summary & Pricing Trends
This section focuses on the macro-level economic data, showing seasonal price fluctuations and availability constraints.

<img width="1437" height="798" alt="image" src="https://github.com/user-attachments/assets/6d70cd5c-7de1-411e-929a-689309ca08c5" />

#### Sentiment Analysis & Quality Control
This section utilizes the RoBERTa NLP scores to uncover the "true vibe" of properties. It highlights "Hidden Gems" (properties with low standard ratings but high NLP positive sentiment) and provides a Red Flag matrix for properties receiving severely negative written feedback.

<img width="1422" height="797" alt="image" src="https://github.com/user-attachments/assets/7b31f30c-eba3-4a7c-aa4e-d3ea65c6f892" />

#### Regional Performance Breakdown
A geographical analysis of property distribution

<img width="1355" height="747" alt="image" src="https://github.com/user-attachments/assets/760a08b4-d63f-490b-8bce-d59595b2fb1b" />


## Data 
The data set is from: https://insideairbnb.com/get-the-data/ 


