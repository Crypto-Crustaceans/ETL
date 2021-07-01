CREATE TABLE "spy" (
    "date_time_on_30_min" varchar,
    "Ticker" varchar,
    "Open" DECIMAL,
    "High" DECIMAL,
    "Low" DECIMAL,
    "Close" DECIMAL,
    "Adj_Close" DECIMAL,
    "Volume" DECIMAL,
    "Percent_Change_From_Startdate" DECIMAL,
    "Change_Close_Less_Open" DECIMAL,
    CONSTRAINT "pk_SPY" PRIMARY KEY (
        "date_time_on_30_min"
     )
);

CREATE TABLE "uuq" (
    "date_time_on_30_min" varchar,
    "Ticker" varchar,
    "Open" DECIMAL,
    "High" DECIMAL,
    "Low" DECIMAL,
    "Close" DECIMAL,
    "Adj_Close" DECIMAL,
    "Volume" DECIMAL,
    "Percent_Change_From_Startdate" DECIMAL,
    "Change_Close_Less_Open" DECIMAL,
    CONSTRAINT "pk_UUQ" PRIMARY KEY (
        "date_time_on_30_min"
     )
);

CREATE TABLE "press" (
    "url" varchar,
    "title" varchar,
    "category" varchar,
    "date" date,
    "time" varchar,
    "date_time_on_30_min" varchar,
    "text" varchar,
    CONSTRAINT "pk_Press" PRIMARY KEY (
        "url"
     )
);