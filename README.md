# Ai-management-script
From raw bookings to a risk model and an AI-assisted follow-up review
link:
https://github.com/tilaakmohanty-maker/Ai-management-script.git

##Line Executive Summary (One Finding per Part, 1–4)
Write one concise bullet or numbered line summarizing the core finding from each part:

##Part 1 (Data Foundations & Cleaning): Cleaned 1,000+ raw bookings down to 990 valid appointments (218 no-shows, 22.0% overall rate) and enriched clinic records with Open-Meteo temperature data.

##Part 2 (SQL & Trend Analysis): Clinic no-show rates ranged from 13.8% (Vaishali Nagar Clinic) to 26.8% (Malviya Nagar Clinic), with bookings made further in advance (31+ days lead time) showing substantially higher no-show rates than short-lead (1–7 days) bookings.

##Part 3 (Machine Learning): Evaluated tuned classifiers across 792 training bookings; Logistic Regression achieved the strongest 5-fold CV ROC-AUC (~0.77) and test ROC-AUC (~0.79), and lowering the decision threshold from 0.50 to 0.35 boosted test recall to ~0.57 (~49 patients flagged out of 198).

##Part 4 (GenAI Call-Centre Note Classification): Classified 9 non-blank call-centre notes into structured root causes using Gemini Flash and Pydantic validation; 100% (2 of 2) of forgot_or_no_reminder cases belonged to appointments with reminder_sent = No (5 of 10 notes overall had no reminder).

##3. One-Paragraph Operational Recommendation

At least four concrete numbers drawn from Parts 1–4 (e.g., 22.0% baseline no-show rate, 0.79 test ROC-AUC, 0.35 threshold, 49 of 198 flagged bookings, or 2 of 2 unreminded forgot_or_no_reminder cases).
The chosen model and why, explicitly stating both its AUC and decision threshold (e.g., deploying Logistic Regression with test ROC-AUC ~0.79 at threshold 0.35 every evening to flag high-risk next-day bookings for reminder calls, prioritizing long-lead bookings and unreminded patients).

##4. Three Honest Limitations

1. Small Qualitative Sample: The 10 call-centre notes analyzed in Part 4 are an illustrative sample only and cannot be generalized as the true clinic-wide distribution of no-show causes.
2. Pre-Split Preprocessing & Random Split Leakage: Imputation medians and IQR outlier fences in Part 1 were computed across all 990 rows prior to the train/test split, and a random split allows the same patient to appear in both training and test sets rather than simulating a strict past-to-future split.
3. Observational Data & Operational Capacity: Because the dataset is observational, strong feature relationships (such as reminder_sent and lower no-shows) show association rather than proven causation, and in production a clinic must tune its probability threshold (0.35 vs. higher/lower) to match evening front-desk calling capacity.
