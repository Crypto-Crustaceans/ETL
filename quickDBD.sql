-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/voTMBM
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "SPY" (
    "date_time" date   NOT NULL,
    "stock_price" varchar   NOT NULL,
    "ticker" varchar   NOT NULL,
    CONSTRAINT "pk_SPY" PRIMARY KEY (
        "date_time"
     )
);

CREATE TABLE "Title_category" (
    "url" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    "category" varchar   NOT NULL,
    CONSTRAINT "pk_Title_category" PRIMARY KEY (
        "url"
     )
);

CREATE TABLE "date_time" (
    "url" varchar   NOT NULL,
    "date" date   NOT NULL,
    "time" varchar   NOT NULL,
    "date_time" date   NOT NULL,
    CONSTRAINT "pk_date_time" PRIMARY KEY (
        "url"
     )
);

ALTER TABLE "Title_category" ADD CONSTRAINT "fk_Title_category_url" FOREIGN KEY("url")
REFERENCES "date_time" ("url");

ALTER TABLE "date_time" ADD CONSTRAINT "fk_date_time_date_time" FOREIGN KEY("date_time")
REFERENCES "SPY" ("date_time");

