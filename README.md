# Database_Project

## ETL

### Exploration

The data is relatively clean, with a few useless columns including only repeated or null values.
There is a clear ID connection between most tables except for the actors table and the films table. The Old HDD conveniently has the actors and films named, which we can use to create new keys. Language is a fairly useless dataset but we should leave it for generality and future data growth.

### Transformation

We create two functions:

- Data describe function that outputs the basic attributes of the CSV file inputted.
- Cleaner function that does some basic cleaning (string stripping, etc), counts null values, constant columns, and low variance columns.

We drop these columns to remove noise.

Further, we create new key columns on the Old HDD CSV file by merging with the Actors and Films CVSs, in order to be able to structure a link between the two.

Finally, we create a new column on Rentals to calculate the time rented.

### Loading

We construct the structure by reverse engineering on Workbench, and extract the resulting query to create the database. After this, loading the data is immediate using the Pandas functioniality.

## Analysis

We create 8 queries that extract the following:

1. First we connect all tables to create a megatable containing all the information

2. We find the top 5 most rented films

3. We find the most popular categories

4. We calculate the profit per title

5. We investigate the store activity and stock

6. Profit per actor

7. Rental frequency and money spent per customer

8. Finally, the preferred category per staff


