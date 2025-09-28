<!DOCTYPE html>
<html lang="en">
<body>

  <h1>OLA Ride Sharing — India</h1>
  This data project prepares and analyses Ola ride-sharing data (July 2024) to surface operational, revenue and service-quality insights and recommend actions to improve cab & bike operations across India.</p>

  <hr>

  <h2>📑 Table of Contents</h2>
  <ol>
    <li><a href="#overview">Overview</a></li>
    <li><a href="#problem-solving-objectives">Problem Solving Objectives</a></li>
    <li><a href="#data-scale">Data & Scale</a></li>
    <li><a href="#tools">Tools & Technology Used</a></li>
    <li><a href="#repository">Repository Structure</a></li>
    <li><a href="#steps">What I did — Step by step</a></li>
    <li><a href="#insights">Key Insights (summary)</a></li>
    <li><a href="#recommendations">Key Recommendations (actionable)</a></li>
    <li><a href="#limitations">Limitations & Next Steps</a></li>
    <li><a href="#reproduce">How to reproduce / run locally</a></li>
    <li><a href="#author">Author / Contact</a></li>
  </ol>

  <hr>

  <h2 id="overview">📌 Overview</h2>
  <p>
    This repository contains a full analytics pipeline for Ola ride data (July 2024). The pipeline includes ingestion of raw data into MySQL, cleaning and exploration in Excel, deeper transformations and KPI generation using SQL, and a multi-page Power BI report (summary + focused pages for Revenue, Vehicle Types, Cancellations, Ratings). The goal: translate raw trip-level logs (lakhs of rows) into operational insights for product, operations and growth teams.
  </p>

  <h2 id="problem-solving-objectives">🎯 Problem Solving Objectives</h2>
  <ul>
    <li>  Quantify booking volumes and success rates (overall and by vehicle type / weekday).</li>
    <li>Understand cancellation drivers (customer vs driver vs driver-unavailable) and their root causes.</li>
    <li>Measure revenue and booking value across payment modes and vehicle categories.</li>
    <li>Identify loyal/high-value customers and opportunities to reduce churn.</li>
    <li>Evaluate customer & driver ratings by vehicle type and identify service-quality gaps.</li>
    <li>Deliver an actionable, navigable Power BI report for stakeholders.</li>
  </ul>



  <h2 id="data-scale">📊 Data & Scale</h2>
  <ul>
    <li><strong>Source:</strong>Ola rides dataset (trip-level logs) for July 2024.</li>
    <li><strong>Row-count: :</strong> dataset in the order of lakhs (hundreds of thousands of bookings).</li>
    <li><strong>Key fields used:</strong> raw trip logs (booking date, time, amount, vehicle preferred, cancellations, reasons etc), customer metadata (anonymized IDs), driver metadata (anonymized IDs).
</li>
    <li><strong> Sensitive information:</strong>all personal identifiers are anonymized (Customer IDs like CID954071).
</li>
  </ul>









  <h2 id="tools">🛠 Tools & Technology Used</h2>
  <ul>
    <li>Python — ingestion & validation</li>
    <li>MySQL — storage & queries</li>
    <li>Excel — initial cleaning & pivots</li>
    <li>Power BI — dashboards (6 pages)</li>
    <li>Git/GitHub — version control</li>
  </ul>

  <h2 id="repository">📂 Repository Structure</h2>
  <pre>

├─ Excel_Prepare_EDA/            # Excel files used for initial cleaning & exploratory pivots
├─ Icons and ReportPages SS/     # Visual assets and screenshots used in Power BI report
├─ OLA Dataset/                  # Raw + processed CSVs (anonymized samples)
├─ Python Script/                # Ingestion scripts: read -> validate -> MySQL
├─ Report Power BI/              # .pbix Power BI files (6 pages)
├─ SQL_Queries/                  # SQL scripts for transformations, KPIs and indexes
└─ README.md
  </pre>

  <h2 id="steps">📝 What I did — Step by step</h2>
  <h3>1. Python — Data ingestion</h3>
  <p>Ingest raw CSV → validate → push to MySQL staging</p>

  <h3>2. Excel — Cleaning & EDA</h3>
  <p>Detected issues, standardized cancel labels, built pivot checks.</p>

  <h3>3. MySQL / SQL</h3>
  <p>Aggregations, cancellation grouping, distance buckets, booking value calculation and more.</p>

  <h3>4. Power BI</h3>
  <p>6-page report with Summary and detailed pages for Revenue, Vehicle Type, Cancellations, Ratings.</p>

  <h2 id="insights">📈 Key Insights (summary)</h2>
  <ul>
    <li>Total bookings: <strong>~103,000</strong></li>
    <li>Success rate: <strong>62%</strong></li>
    <li>Driver cancellations: <strong>~10.5%</strong></li>
    <li>Customer cancellations: <strong>~19%</strong></li>
    <li>Un-availability : <strong>~10%</strong></li>
    <li><strong>Incomplete rides: </strong>Incomplete (successful but incompleted) rides reveals that Vehicle Breakdown (1,591) and Customer Demand (1,601) are the leading causes, together accounting for over 80% of incomplete rides, with Other Issues contributing 734 cases.</li>
    <li>Revenue: <strong>₹35.08M</strong></li>
    <li>Payment mode: Cash (53%), UPI (39%), Cards (~5%)</li>
    <li>Top 10 Loyal Customers : CID954071, CID966929, CID819034, CID836942, CID309168, CID465260, CID340854, CID539191, CID189965, CID980727</li>
    <li>Prime Sedan → long rides | Auto → local short trips</li>
    <li>Ratings: Customer (4.0), Driver (3.8)</li>
  </ul>


  <h2 id="recommendations">✅ Key Recommendations</h2>
  <ol>
    <li>Reduce driver cancellations via training & vehicle support.</li>
    <li>Fix driver-not-found with better matching algorithms.</li>
    <li>Promote UPI/cards with incentives.</li>
    <li>Optimize vehicle mix & pricing strategies.</li>
    <li>Improve Bike service ratings with driver programs.</li>
    <li>Reward top loyal customers.</li>
    <li>Preventive maintenance to reduce breakdowns.</li>
    <li>Pilot ML models for cancellation prediction.</li>
  </ol>

  <h2 id="limitations">⚠️ Limitations & Next Steps</h2>
  <ul>
    <li>Single-month snapshot — needs more months for seasonality.</li>
    <li>Some financial fields missing (tolls, discounts).</li>
  </ul>
  <p><strong>Future Scope:</strong> Expand to yearly data, automate ETL, build ML models, run A/B tests.</p>

  <h2 id="reproduce">💻 How to Reproduce / Run Locally</h2>
  <pre>
git clone &lt;repo-url&gt;
cd ola-ride-analytics
python "Python Script/ingest_to_mysql.py"
# Run SQL scripts in SQL_Queries
# Explore and clean in Excel
# Open .pbix files in Power BI
  </pre>


  <h2 id="author">👤 Author / Contact</h2>
  <p><strong>Author:</strong> Umar — Data Analyst & Aspiring Data Scientist</p>
  <p><strong>Email:</strong> umarofficial073@gmail.com</p>
  <p><strong>LinkedIn:</strong> https://www.linkedin.com/in/hereumar/</p>
  <p><strong>Portfolio:</strong>https://mushtaqumar.github.io/JS-Personal-Portfolio/ </p>

</body>
</html>

## Report Overview
![Report Summary Page](./Icons%20and%20ReportPages%20SS/Report%20Pages%20Demo/S1%20Summary.png)

