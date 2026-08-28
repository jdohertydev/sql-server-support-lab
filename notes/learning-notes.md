# Learning Notes

These notes record the main ideas reinforced while building the SQL Server Support Lab.

## SQL Server and SSMS

**SQL Server** is the database engine that stores and processes the data.

**SQL Server Management Studio (SSMS)** is a client and management environment used to connect to SQL Server, inspect objects and run SQL queries.

A SQL Server instance can contain multiple databases. Before running a query, especially a modifying query, it is important to confirm the connected server and selected database.

## Relational structure

A **primary key** uniquely identifies a row in a table.

A **foreign key** links one table to another and helps enforce valid relationships. In this lab, for example, `Orders.customer_id` must refer to an existing `Customers.customer_id`.

`NULL` means that no value is stored. It is not the same as an empty string. SQL uses `IS NULL` and `IS NOT NULL` rather than `= NULL`.

## Query patterns practised

Basic investigation pattern:

```sql
SELECT columns
FROM table
WHERE condition;
```

Related data pattern:

```sql
SELECT columns
FROM TableA AS a
INNER JOIN TableB AS b
    ON a.related_id = b.related_id
WHERE condition;
```

`INNER JOIN` returns matching related rows. `LEFT JOIN` keeps rows from the table on the left even when there is no match on the right, which makes it useful for investigating missing relationships.

Aliases such as `a`, `o`, `ol` and `p` are short names for tables within a query. They are not new tables or columns.

## Evidence before explanation

A recurring support lesson from the exercises is to separate **what the database shows** from **why it happened**.

Examples:

- an inactive product on a historical order does not prove it was inactive when the order was placed;
- a stored order price that differs from today's catalogue price does not automatically indicate corruption;
- an order with zero order lines confirms missing related rows, but does not explain how they became missing;
- two identical-looking customer records support a duplicate-account investigation, but do not by themselves justify deleting one.

A useful support sequence is:

1. confirm the reported record exists;
2. narrow the scope with identifiers and filters;
3. inspect related records;
4. quantify or compare where useful;
5. state the evidence separately from possible explanations;
6. fix or escalate only when the cause and authorised process are sufficiently understood;
7. test and communicate the outcome.

## Data-change safety

A modifying statement can affect many rows if its scope is wrong. Before an `UPDATE` or `DELETE`, run a `SELECT` with the same intended `WHERE` condition and verify the rows returned.

A transaction provides a controlled way to practise a change:

```sql
BEGIN TRANSACTION;

-- proposed change
-- verification query

ROLLBACK;
```

`ROLLBACK` undoes the uncommitted transaction. `COMMIT` makes it permanent.

In SSMS, if text is highlighted, executing runs the selected text. If nothing is highlighted, the whole batch may run. Keeping old write statements mixed with read-only investigation queries can therefore create avoidable risk.

SSMS IntelliSense warnings can also be stale. Refreshing local metadata may clear a red underline even when the SQL Server engine can already execute the query correctly. Actual execution errors should be checked in the Messages pane.

## What I understand versus what I need to memorise

The priority is understanding the purpose and structure of the query rather than memorising every statement character for character.

I should be able to explain:

- why a particular table is being queried;
- what a `WHERE` condition is narrowing;
- why two tables need to be joined;
- what the `ON` condition is matching;
- why a `LEFT JOIN` is useful for a missing-related-record investigation;
- why a transaction and verification step reduce risk.

I do not yet need to claim that I can write complex joins or production SQL from memory without reference material.

## Current level

This lab supports a description such as **introductory practical familiarity with SQL Server and SSMS**.

It does not support claims such as "advanced SQL", "SQL Server expert", "production DBA" or professional SQL Server support experience.

Strengths developed here are the investigation process, evidence discipline and safe-change mindset. SQL syntax fluency, especially writing joins independently, still needs further practice.

## Sensible next topics

Future learning could include:

- writing joins from memory with less scaffolding;
- practising `AVG` and additional aggregate queries;
- joining three or more tables;
- understanding indexes at a basic support level;
- reading execution plans at an introductory level;
- learning how a real application's logging, audit and permissions model interacts with database troubleshooting.
