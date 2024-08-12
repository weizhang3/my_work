# Urban Wear A/B Testing: Improving Email Sign-Up Conversion

## Overview

This project involves an A/B test designed to improve the email sign-up conversion rate for Urban Wear, a clothing brand launching its eCommerce store. The test compares the performance of two versions of the email sign-up button on the pre-launch page: a blue submit button (control) and a green submit button (treatment). The goal is to determine which version results in a higher sign-up rate, thereby guiding the product team in making a data-driven decision on the button design for the website launch.

## Project Objectives

1. **Design and Run an A/B Test**: Create and execute an A/B test to evaluate the impact of button color on email sign-up conversion rates.
2. **Analyze Experiment Results**: Apply statistical methods to determine if the difference in conversion rates between the control and treatment groups is statistically significant.
3. **Provide a Data-Driven Recommendation**: Based on the analysis, recommend whether Urban Wear should switch to the green submit button for better user engagement.

## Datasets Overview

### Pretest Data (`pretest.csv`)
- **Rows**: 309,903
- **Columns**:
  - `visitor_id`: Unique identifier for each site visitor.
  - `date`: Date of the visit.
  - `email`: Collected email address (if any).
  - `experiment`: Name of the experiment (if applicable).
  - `group`: Indicator of whether the visitor saw the control or treatment version.
  - `submitted`: Boolean indicating whether the visitor signed up.

### Test Data (`test.csv`)
- **Rows**: Number of rows reflects the visitors during the A/B test period.
- **Columns**: Same as `pretest.csv`, containing the results of the A/B test.

## Tools and Libraries Used

- **Programming Language**: Python
- **Libraries**:
  - **Pandas**: Data manipulation and analysis.
  - **NumPy**: Numerical computations.
  - **Matplotlib & Seaborn**: Data visualization.
  - **Statsmodels**: Statistical analysis and hypothesis testing.
  - **SciPy**: Additional statistical functions and tests.

## Project Structure

- **`pretest.csv`**: Pretest data used to understand baseline performance.
- **`test.csv`**: Data collected during the actual A/B test.
- **`ab_test_analysis.ipynb`**: Jupyter notebook containing the full code for data analysis, experiment design, and statistical testing.

## Key Findings

1. **Baseline Performance**:
   - The pretest sign-up rate was 10%.
   - A sample size of 15,000 per group was determined necessary to detect a 10% improvement with 80% power.

2. **Experiment Results**:
   - The treatment group (green button) achieved a sign-up rate of 10.8% compared to 9.6% for the control group (blue button).
   - Both the Chi-Square and T-Test results were statistically significant, with p-values less than 0.05.

3. **Statistical Inference**:
   - The observed lift in conversion was 12.8%, with a 95% confidence interval ranging from 5.7% to 19.9%.

## Conclusion

The A/B test results indicate that the green submit button significantly improves email sign-up rates compared to the blue button. Given the statistical and practical significance observed, it is recommended that Urban Wear implement the green submit button on their pre-launch page to maximize conversions.
