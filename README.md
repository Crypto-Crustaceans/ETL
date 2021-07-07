# Do Federal Reserve Press Announcements Have an Impact on the Securities Market?

## Objective

For our ETL project, we've decided to examine the immediate impact a central banking system has on the securities market, specifically the United States' central bank, the Federal Reserve, and its impact on the S&P 500 index and strength of USD currency. Monetary policy can take a long time to impact interest rate, inflation, unemployment, etc, and those effects are often hard to quantify. With that said, the securities and foreign exchange markets can react immediately to sudden announcements.

![image](https://user-images.githubusercontent.com/78992395/124069556-39807e00-d9f1-11eb-93c6-600c96209079.png)

The Fed Board of Governors keep a log of all their press releases since 2006 on their official website (https://www.federalreserve.gov/newsevents/pressreleases.htm) and categorizes them by types: Monetary Policy, Orders on Banking Application, Enforcement Actions, Banking and Consumer Regulatory Policy, and Other Announcements. We are scraping information from each press releases in order to plot them against the changes in the S&P 500 Index.

![image](https://user-images.githubusercontent.com/78992395/124069709-78aecf00-d9f1-11eb-84bf-16cf0f6d2298.png)

The S&P 500 serves as a good proxy for the securities index as it tracks the largest 500 companies on the U.S. stock exchanges. The source of data we are scraping this from is Yahoo Finance, as new data constantly updates and historical data is readily available to manipulate and analyze. 

We also chose to review data on the US Dollar Currency Index as a proxy for the stregth of the USD. The ticker symbol here is UUP, and the data is also from Yahoo Finance.

## Extract: Scraping Federal Reserve press releases market data from Yahoo Finance

### Federal Reserve Press Releases
***Relevant files: fed_reserve_press_release_scraper.ipynb, fed_press_releases.csv***

We first set up Splinter to run the scraping in Chrome, specified the target url, then utilized Selenium in order to deal with JavaScript elements. Each pages were looped through, regardless of press release types, then in each pages, an HTML object was created to scrape using Beautiful Soup. The elements we scraped are the url, date, time, and content of article. We exported the raw data into CSV so we could easily test and graph them.

### Yahoo Finance
***Relevant files: yfinance.ipynb, SPY.csv, UUP.csv***

We utilized yfinance library to pull SPY and UUP ticker data, representing the S&P 500 Index ETF and the US Dollar Currency Index, respectively. We've decided on these ticker symbols to be a proxy for the stock market and foreign exchange volatility. The scraped data records the date and time, open, high, low, close, volume. We also exported the raw data into CSV format in order to manipulate and test the data.

## Transform: Data cleanup & analysis
***Relevant files: fed_reserve_press_release_scraper.ipynb, fed_press_releases.csv***

![image](https://user-images.githubusercontent.com/78992395/124068979-536d9100-d9f0-11eb-9018-84759ed1bc17.png)

In order for the data from the Fed press releases, S&P 500 index, and USD currency index to be compatable, we had to first manipulate the formattng of date and time in the data from the press releases. We first merged the two separate date and time dataframe columns into one datetime column, then account for the extra hour during Daylight Saving Time (Fed press releases are all in either EST or EDT timezone). Finally, we adjusted the string to match the format Yahoo Finance scraper pulled.

![image](https://user-images.githubusercontent.com/78992395/124069428-01793b00-d9f1-11eb-8071-608f7d6c5689.png)

In order for the data from the Fed press releases, S&P 500 index, and USD currency index to be compatable, we had to first manipulate the formattng of date and time in the data from the press releases. We first merged the two separate date and time dataframe columns into one datetime column, then account for the extra hour during Daylight Saving Time (Fed press releases are all in either EST or EDT timezone). Finally, we adjusted the string to match the format Yahoo Finance scraper pulled.

## Load: Putting everything together with SQLAlchemy
***Relevant files: quickDBD.sql***

![image](https://user-images.githubusercontent.com/78992395/124069035-70a25f80-d9f0-11eb-93fd-2a2357eb3732.png)

We put together the SQL schemas using QuickDBD diagram tool (https://www.quickdatabasediagrams.com/). The link to the schema is https://app.quickdatabasediagrams.com/#/d/voTMBM. The three tables were then loaded: "Press" Fed press releases, "SPY" S&P 500 index, and "UUP" USD currency index. We chose to compare Fed press releases against the S&P and UUP separately, as we treated the two indices as two separate dependent variables, and independent from each other.

We realized that not all Fed announcements are equal, and therefore we chose to group them by their categories. And since we are focusing on the impact of these annoucements, we compared them against the daily changes (closing price in USD minus opening price in USD). 

The query utilized left join with the formatted datetime column as the key. Left join (with press announcement data on the right table) preserves market data on the days when there are no press announcements from the Fed. From this new table, we grouped each Fed press releases by category, then averaged the dollar amount of changes in the market that day for each respective categories. Finally, we rounded the data to make it more legible and easier to review.

## Analysis and Conclusions

### Daily Changes in the S&P 500 Index for Each Categories of Fed Press Announcement

![image](https://user-images.githubusercontent.com/78992395/124064804-62e9db80-d9ea-11eb-92cf-ffc3a384fd72.png)

From the illustration above, we can see that there is indeed a correlation between the different types of Fed announcements and market movements. The control groups to make note of are Null (no Fed announcement that day) and Other Announcements (unrelated to market, such as announcement that Fed office will be closed on a national holiday). 

The greatest positive impacts at 70 cents/day come from Orders on Banking Applications, generally when the Fed approves a merger and/or acquisition of banks, or approving an application to open a bank branch in new states. Following closely at 44 cents/day were Monetary Policy announcements, such as an extension to an economic relief program, economic projections, and release of Federal Open Market Committee minutes. These are all generally positive news, where economic growth is hinted.

There is a slight negative correlation with Banking and Consumer Regulatory Policy, negative news for anyone impacted. Such announcements impose regulations on impacted industries and banks. It must be noted, however, that a 6 cents/day change may not be a strong enough correlation to base financial decisions on.

### Daily Changes in the US Dollar Currency Index for Each Categories of Fed Press Announcement

![image](https://user-images.githubusercontent.com/78992395/124064898-92004d00-d9ea-11eb-893e-7daebe2ac4f2.png)

Reviewing these announcements against the USD Currency Index is more difficult as the changes are smaller. It is worth noting, however, that the correlations are similar to the changes against the S&P 500 illustrated Index above. We have a strong positive correlation with Orders on Banking Applications and Monetary Policy annoucements, and slight negative correlation with Banking and Consumer Regulatory Policy announcements. 

What stood out to us is that the strongest positive correlation here are with announcements on Enforecement Actions. These are actions taken against an institution or an individual that has violated regulations. These seem to have the greatest positive impact on the strength of the US Dollar.

In conclusion, while central banks such as the Federal Reserve implement changes to the economy primarily through monetary policy, which is one of its main function, we must be aware as well that anticipation of these monetary policies, triggered by press announcements, could have an immediate impact on both the financial markets and the currency.
