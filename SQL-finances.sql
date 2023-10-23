-- Financial Data Analysis --
-- Using SQL Server Management Studio Management Studio 19 --

-- Creating a table "Income" --
CREATE TABLE Income (
	Id int IDENTITY(1,1) NOT NULL,
    Date DATE,
    Category VARCHAR(50),
    Amount DECIMAL(10, 2),
    Description TEXT
);

-- Creating a table "Expenses" --
CREATE TABLE Expenses (
	Id int IDENTITY(1,1) NOT NULL,
    Date DATE,
    Category VARCHAR(50),
    Amount DECIMAL(10, 2),
    Description TEXT
);

-- Entering additional data into the table "Expenses"
INSERT INTO Expenses (Date, Category, Amount, Description)
VALUES
    ('2023-11-25', 'Insurance', 190.00, 'Car insurance premium'),
    ('2023-12-30', 'Gifts', 70.00, 'Birthday gifts');

-- Query total income and expenses --
SELECT SUM([Income].[Amount]) AS TotalIncome, SUM([Expenses].[Amount]) AS TotalExpenses
FROM Income
RIGHT JOIN Expenses ON Income.ID = Expenses.ID;

Results:
TotalIncome	TotalExpenses
79300.00	21540.00

-- Query balance --
SELECT SUM(i.Amount) - SUM(e.Amount) AS Profit
FROM Income i
RIGHT JOIN Expenses e ON i.ID = e.ID;

Results:
Profit
57760.00

-- Query the balance in a given period --
SELECT
    (SELECT SUM(Amount) FROM Income WHERE Date >= '2023-06-01' AND Date <= '2023-06-30') -
    (SELECT SUM(Amount) FROM Expenses WHERE Date >= '2023-06-01' AND Date <= '2023-06-30') AS Balance;

Results:
Balance
4080.00

-- Query the number of expenses in June --
SELECT COUNT(*) AS NumOfExpenses
FROM Expenses
WHERE Date BETWEEN '2023-06-01' AND '2023-06-30'

Results:
NumOfExpenses
3

-- Query all expenses in a given period --
SELECT Date, SUM(Amount) AS Expenses
FROM Expenses
WHERE Date BETWEEN '2023-06-01' AND '2023-06-30'
GROUP BY Date;

Results:
Date		Expenses
2023-06-01	20.00
2023-06-05	1200.00
2023-06-15	400.00

-- Query income categories and total income in each category --
SELECT Category, SUM(Amount) AS TotalIncome
FROM Income
GROUP BY Category
ORDER BY Category;

Results:
Category  	TotalIncome
Bonus		2500.00
Consulting	4500.00
Freelance       3300.00
Investment	13400.00
Royalties  	1600.00
Salary		54000.00

-- Query the category with the highest income --
SELECT TOP (1) Category, SUM(Amount) AS TotalIncome
FROM Income
GROUP BY Category
ORDER BY TotalIncome DESC;

Results:
Category	TotalIncome
Salary		54000.00

-- Query the total income for each month --
SELECT month(date) AS MonthNumber, SUM(Amount) AS MonthlyIncome
FROM income
GROUP BY month(date);

Results:
MonthNumber	MonthlyIncome
1	        5900.00
2	        4500.00
3          	13000.00
4          	9500.00
5          	4500.00
6          	5700.00
7          	6300.00
8          	6300.00
9          	5300.00
10         	4700.00
11         	7600.00
12         	6000.00
