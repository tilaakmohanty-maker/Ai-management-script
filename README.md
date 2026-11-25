# Ai-management-script
From raw bookings to a risk model and an AI-assisted follow-up review
link:
https://github.com/tilaakmohanty-maker/Ai-management-script.git

## Line Executive Summary (One Finding per Part, 1–4)
Write one concise bullet or numbered line summarizing the core finding from each part:

## Part 1 (Data Foundations & Cleaning): Cleaned 1,000+ raw bookings down to 990 valid appointments (218 no-shows, 22.0% overall rate) and enriched clinic records with Open-Meteo temperature data.

the mean of the columns in ["age","distance_km","fee_inr","lead_days"] are [48.17373737  9.50090909  26.   11.81919192]


-*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*-


the number and share of rows with leading days > 14 are 296 and 0.298989898989899 respectively


the z-scores of distance and the number of rows having |z|>2 are [[ 1.57157464 -0.38416269 -0.01164129 -1.17577066]] and 0

column means : [48.17  9.5  26.   11.82]
Lead Days range: 1 to 45
Rows with lead days greayter than 14: 29.9%
No-shows: 218 out of 990 (22.0%)
rows with |Z| > 2 for distance_km: 53


## Part 2 (SQL & Trend Analysis): Clinic no-show rates ranged from 13.8% (Vaishali Nagar Clinic) to 26.8% (Malviya Nagar Clinic), with bookings made further in advance (31+ days lead time) showing substantially higher no-show rates than short-lead (1–7 days) bookings.

Without HAVING, two more clinics appear: Gomti Nagar Care Point (Lucknow) has the highest rate, 33.3%, but only 90 appointments; Sitabuldi Health Point (Nagpur) has 82 appointments at 15.9%.
The pandas counts match the SQL counts exactly.

## 2.2 Without HAVING, two more clinics appear: Gomti Nagar Care Point (Lucknow) has the highest rate, 33.3%, but only 90 appointments; Sitabuldi Health Point (Nagpur) has 82 appointments at 15.9%.
The pandas counts match the SQL counts exactly.
2.3 (appointments / no-shows / %) are 2.3: 1-7: 390 / 63 / 16.2 · 8-14: 304 / 53 / 17.4 · 15-30: 253 / 76 / 30.0 · 31+: 43 / 26 / 60.5 (appointments / no-shows / %).
2.4 (month · appointments · rate · change), 2.4: 2025-01: 157 · 24.8 · blank; 2025-02: 151 · 20.5 · −4.3; 2025-03: 142 · 20.4 · −0.1; 2025-04: 177 · 20.9 · +0.5; 2025-05: 198 · 23.7 · +2.8; 2025-06: 165 · 21.2 · −2.5
2.5: overall rate is 22.02%. Eight rows: Indore — Vijay Nagar 20.8, rank 1, below · Jaipur — Malviya Nagar 26.8, rank 1, above; Vaishali Nagar 13.8, rank 2, below · Kochi — Edappally 16.2, rank 1, below · Lucknow — Gomti Nagar 33.3, rank 1, above · Nagpur — Sitabuldi 15.9, rank 1, below · Pune — Hadapsar 27.3, rank 1, above; Kothrud 22.5, rank 2, above.

## Part 3 (Machine Learning): Evaluated tuned classifiers across 792 training bookings; Logistic Regression achieved the strongest 5-fold CV ROC-AUC (~0.77) and test ROC-AUC (~0.79), and lowering the decision threshold from 0.50 to 0.35 boosted test recall to ~0.57 (~49 patients flagged out of 198).

## Part 4 (GenAI Call-Centre Note Classification): Classified 9 non-blank call-centre notes into structured root causes using Gemini Flash and Pydantic validation; 100% (2 of 2) of forgot_or_no_reminder cases belonged to appointments with reminder_sent = No (5 of 10 notes overall had no reminder).

## 3. One-Paragraph Operational Recommendation

## At least four concrete numbers drawn from Parts 1–4 (e.g., 22.0% baseline no-show rate, 0.79 test ROC-AUC, 0.35 threshold, 49 of 198 flagged bookings, or 2 of 2 unreminded forgot_or_no_reminder cases).
## The chosen model and why, explicitly stating both its AUC and decision threshold (e.g., deploying Logistic Regression with test ROC-AUC ~0.79 at threshold 0.35 every evening to flag high-risk next-day bookings for reminder calls, prioritizing long-lead bookings and unreminded patients).

X shape: (990, 11) | Columns: ['age', 'distance_km', 'fee_inr', 'lead_days', 'prior_no_shows', 'reminder_sent', 'booking_channel_App', 'booking_channel_Phone', 'booking_channel_Walk-In', 'visit_type_Consultation', 'visit_type_Follow-up']
Train size: 792, Test size: 198
No-shows in test set: 49
Baseline accuracy (always predicting 'Attended'): 0.7525 (149 of 198)

Accuracy:  0.7929
Confusion Matrix:
 [[141   8]
 [ 33  16]]
Precision: 0.6667
Recall:    0.3265
F1:        0.4384
ROC-AUC:   0.8008

Coefficients by feature (in X column order):
                feature      coef  scale_sd
                    age -0.248377 16.655863
            distance_km  0.252579  6.051810
                fee_inr  0.000000  1.000000
              lead_days  0.598915  8.614206
         prior_no_shows  0.634842  0.968578
          reminder_sent -0.578444  0.494975
    booking_channel_App -0.034198  0.486016
  booking_channel_Phone  0.206141  0.481046
booking_channel_Walk-In -0.189676  0.435178
visit_type_Consultation  0.182692  0.492792
   visit_type_Follow-up -0.182692  0.492792

reminder_sent scaled coef: -0.5784, SD (scaler.scale_): 0.4950
np.exp(coef) [per 1 SD of scaled feature]: 0.5608
np.exp(coef / scale) [No (0) -> Yes (1)]:  0.3108

## Explanation: np.exp(coef) measures the odds multiplier for a 1-standard-deviation increase in the scaled reminder_sent variable (~0.49), whereas np.exp(coef / scale) measures the odds multiplier for a full 1-unit change from No (0) to Yes (1).

## Conclusion: In this model, holding the other features constant, having a reminder is associated with lower no-show odds (odds multiplier ~0.31 for No -> Yes), though because the data are observational this shows an association rather than proving causation.

Full-depth tree (depth=15): train acc = 1.0000, test acc = 0.7071
Depth-3 tree: train acc = 0.8220, test acc = 0.7778

## Gap takeaway: The huge train-to-test gap on the full-depth tree (1.00 vs ~0.67, below baseline) shows it memorized training noise and overfit, whereas max_depth=3 generalizes much better to unseen bookings.

Random Forest (100 trees) -> Accuracy: 0.7626, Recall: 0.2857, ROC-AUC: 0.6996
Top 3 feature importances:
 lead_days      0.252125
age            0.239889
distance_km    0.234091
dtype: float64

Task 3.4 Comparison Table:
                            model  accuracy  recall  roc_auc
             Logistic Regression    0.7929  0.3265   0.8008
     Decision Tree (max_depth=3)    0.7778  0.2245   0.6997
Random Forest (n_estimators=100)    0.7626  0.2857   0.6996


## Best look on test reporting: Logistic regression looks strongest overall (highest ROC-AUC and balanced accuracy/recall), though formal model selection is done via cross-validation on the training set in Task 3.5.


Tuned RF best_params_: {'max_depth': 5, 'n_estimators': 200}
Tuned RF best_score_ (5-fold CV ROC-AUC): 0.7658

5-fold CV ROC-AUC on X_train:
  logistic_regression_pipe: 0.7722
  decision_tree_depth3: 0.6865
  random_forest_100: 0.7298
  random_forest_tuned: 0.7658
  
## Winner by CV ROC-AUC: logistic_regression_pipe

OOF @ threshold 0.50 -> precision: 0.6164, recall: 0.2663, F1: 0.3719, flagged: 73
OOF @ threshold 0.35 -> precision: 0.5166, recall: 0.4615, F1: 0.4875, flagged: 151

## Chosen threshold: 0.35 (higher F1 and much higher recall than 0.5).

## Why recall matters: Missing a likely no-show costs an empty appointment slot, whereas an extra follow-up call only costs about a minute of front-desk time.

Final Single Test-Set Evaluation (Logistic Regression @ 0.35):
  Precision: 0.6458
  Recall:    0.6327
  Flagged:   48
  ROC-AUC:   0.8008

## Operational threshold note: In practice, a clinic would set the threshold by balancing how many follow-up calls the front desk can realistically make in an evening against the cost of an empty slot.


## 4. Three Honest Limitations

## 1. Small Qualitative Sample: The 10 call-centre notes analyzed in Part 4 are an illustrative sample only and cannot be generalized as the true clinic-wide distribution of no-show causes.

## 2. Pre-Split Preprocessing & Random Split Leakage: Imputation medians and IQR outlier fences in Part 1 were computed across all 990 rows prior to the train/test split, and a random split allows the same patient to appear in both training and test sets rather than simulating a strict past-to-future split.

## 3. Observational Data & Operational Capacity: Because the dataset is observational, strong feature relationships (such as reminder_sent and lower no-shows) show association rather than proven causation, and in production a clinic must tune its probability threshold (0.35 vs. higher/lower) to match evening front-desk calling capacity.

{'root_cause': 'forgot_or_no_reminder', 'confidence': 1.0, 'summary': 'Patient missed appointment due to lack of reminder and forgetting the visit. Requests rescheduling.', 'recommended_action': 'Reschedule appointment and verify patient contact preferences for reminder notifications.'}
