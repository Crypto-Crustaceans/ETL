# Crypto Crustaceans ETL Project

## Objective

For our ETL project, we've decided to examine the immediate impact a central banking system has on the securities market, specifically the United States' central bank, the Federal Reserve, and its impact on the S&P 500 index and strength of USD currency. Monetary policy can take a long time to impact interest rate, inflation, unemployment, etc, and those effects are often hard to quantify. With that said, the securities and foreign exchange markets can react immediately to sudden announcements.

The Fed Board of Governors keep a log of all their press releases since 2006 on their official website (https://www.federalreserve.gov/newsevents/pressreleases.htm) and categorizes them by types: Monetary Policy, Orders on Banking Application, Enforcement Actions, Banking and Consumer Regulatory Policy, and Other Announcements. We are scraping information from each press releases in order to plot them against the changes in the S&P 500 index.

The S&P 500 serves as a good proxy for the securities index as it tracks the largest 500 companies on the U.S. stock exchanges. The source of data we are scraping this from is Yahoo Finance, as new data constantly updates and historical data is readily available to manipulate and analyze.

## Extract: Scraping Federal Reserve press releases market data from Yahoo Finance

### Federal Reserve Press Releases
***Relevant files: fed_reserve_press_release_scraper.ipynb, fed_press_releases.csv***

We first set up a splinter to run the scraping in, specified the target url, then utilized Selenium in order to deal with JavaScript elements. Each pages are looped through, regardless of press release types, then in each pages, an HTML object is created to scrape using Beautiful Soup. The elements we are scraping are the url, date, time, and content of article. We exported the raw data into CSV so we could easily test and graph them.

### Yahoo Finance
***Relevant files: yfinance.ipynb, SPY.csv, USD.csv***

We utilized yfinance library to pull "SPY" and "DXY" ticker data, representing the S&P 500 ETF and the US Dollar currency index, respectively. We've decided on these ticker symbols to be a proxy for the stock market and foreign exchange volatility. The scraped data records the date and time, open, high, low, close, volume. We also exported the raw data into CSV format in order to manipulate and test the data.

## Transform: Data cleanup & analysis
***Relevant files: quickDBD.sql***

In order for the data from the Fed press releases, S&P 500 index, and USD currency index to be compatable, we had to first manipulate the formattng of date and time in the data from the press releases. We first merged the two separate date and time dataframe columns into one datetime column, then account for the extra hour during Daylight Saving Time (Fed press releases are all in either EST or EDT timezone). Finally, we adjusted the string to match the format Yahoo Finance scraper pulled.

We put together the SQL schemas using QuickDBD diagram tool (https://www.quickdatabasediagrams.com/). The link to the schema is https://app.quickdatabasediagrams.com/#/d/voTMBM.

## Load: Putting together everything together with SQLAlchemy


