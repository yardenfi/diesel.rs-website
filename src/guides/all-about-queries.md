---
lang: en-US
title: "All About Queries"
css: ../assets/stylesheets/application.css
include-after: |
    <script src="../assets/javascripts/application.js"></script>
---

::: demo
::: content-wrapper
::: guide-wrapper

In this guide we're going to walk through the different ways to execute queries and get data from the database, 
see the different filters possible as part of the diesel library and finally 
look at the ways we can query joined data from different tables.  


### Setup

Before we can dive in, let's create some data we can query.
If you don't have a sample project with diesel set up you can walk through the "Getting Started" guide.

We'll create two table for now - one for countries, and one for cities.

Let's create the countries table first. To do so, we'll create a migration by running:

```sh
diesel migration generate create_countries
```

Diesel CLI will create two empty files for us in the required structure.
You'll see output that looks something like this:

```
Creating migrations/20160815133237_create_countries/up.sql
Creating migrations/20160815133237_create_countries/down.sql
```

Next, we'll write the SQL for migrations:

::: code-block

[up.sql]( https://github.com/diesel-rs/diesel/tree/v1.4.4/examples/postgres/getting_started_step_1/migrations/20160815133237_create_posts/up.sql)

```sql
CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
)
```

:::

::: code-block

[down.sql](https://github.com/diesel-rs/diesel/tree/v1.4.4/examples/postgres/getting_started_step_1/migrations/20160815133237_create_posts/down.sql)

```sql
DROP TABLE countries
```

:::

Then We'll create the migration for cities by running:

```sh
diesel migration generate create_cities
```

Diesel CLI will create two empty files for us in the required structure.
You'll see output that looks something like this:

```
Creating migrations/20160815133237_create_cities/up.sql
Creating migrations/20160815133237_create_cities/down.sql
```

Next, we'll write the SQL for migrations:

::: code-block

[up.sql]( https://github.com/diesel-rs/diesel/tree/v1.4.4/examples/postgres/getting_started_step_1/migrations/20160815133237_create_posts/up.sql)

```sql
CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  country_id INT NOT NULL,
  foundation_date DATE NOT NULL,
  is_capital BOOLEAN NOT NULL,
   CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	  REFERENCES countries(country_id)
)
```

:::

::: code-block

[down.sql](https://github.com/diesel-rs/diesel/tree/v1.4.4/examples/postgres/getting_started_step_1/migrations/20160815133237_create_posts/down.sql)

```sql
DROP TABLE countries
```

:::



:::
:::
:::
