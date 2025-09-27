# Data Science: K-Means Clustering to Identify Subscriber Segments in Cable Services

This project segments 10,000 cable TV subscriber households based on spending for video, internet, and phone services. From conducting K-means clustering, I was able to identify actionable customer segments—high, mid, and low value—to guide personalized marketing offers, optimize retention, and increase revenue. Insights highlight spending patterns, service preferences, and opportunities for targeted upselling.

---

## Project Motivation
Understanding household-level spending behavior across bundled services (video, internet, phone) helps providers tailor offers, retain high-value subscribers, and upsell effectively to increase revenue.

---

## Data Overview
| Dataset | Description |
|---------|-------------|
| `subscriber_data.csv` | Household-level data including service spend and demographics |

### Unit of Analysis  
- 10,000 subscriber households  

### Clustering Variables (for K-means)  
- **Video** – Monthly spend on cable TV services (channels/packages)  
- **Internet** – Monthly spend tied to speed and data plan usage  
- **Phone** – Monthly spend on landline services  

### Demographic Profiling Variables  
Used to interpret clusters and design offers:  
- Age of household head  
- Household income  
- Household size  
- Marital status  
- Number of children  

---

## Methodology
1. **K-means clustering** on video, internet, and phone spend  
2. **Cluster interpretation** using demographics to profile segments  
3. **Actionable insights** for targeted marketing, retention, and upselling  

---

## Key Findings
- Clear segmentation into high-, mid-, and low-value households  
- High-value clusters spend disproportionately on internet + video bundles  
- Low-value clusters are price-sensitive, preferring minimal services  
- Demographics reveal young families drive higher bundled usage  

---

## Key Methods & Tools
| Category | Details |
|----------|---------|
| Methods  | K-means clustering, Exploratory Data Analysis, Demographic profiling |
| Tools    | RStudio (packages: *tidyverse*, *dplyr*, *stats*, *ggplot2*) |

---

## How to Run
1. Clone the repository:  
```bash
git clone https://github.com/YOUR_USERNAME/kmeans-subscriber-segmentation-datascience.git
