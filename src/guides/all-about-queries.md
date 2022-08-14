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
  is_capital BOOLEAN NOT NULL,
   CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	  REFERENCES countries(id)
)
```

:::

::: code-block

[down.sql](https://github.com/diesel-rs/diesel/tree/v1.4.4/examples/postgres/getting_started_step_1/migrations/20160815133237_create_posts/down.sql)

```sql
DROP TABLE cities
```

:::

We can now apply our new migrations:

```sh
diesel migration run
```


Let's insert some new countries and cities into our tables:

```rust
mod schema;

#[macro_use]
extern crate diesel;
extern crate dotenv;

use std::env;
use self::diesel::prelude::*;
use self::schema::countries;
use dotenv::dotenv;
use crate::cities::{country_id, is_capital, name};
use crate::schema::cities;

pub fn establish_connection() -> PgConnection {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");
    PgConnection::establish(&database_url)
        .expect(&format!("Error connecting to {}", database_url))
}

fn main() {
    let connection = establish_connection();
    diesel::insert_into(countries::table)
        .values(vec![
            countries::name.eq("Germany"),
            countries::name.eq("France"),
            countries::name.eq("Spain")
        ])
        .execute(&connection)
        .expect("Error saving new countries");

    diesel::insert_into(cities::table)
        .values(vec![
            (name.eq("Berlin"), country_id.eq(1), is_capital.eq(true)),
            (name.eq("Hamburg"), country_id.eq(1), is_capital.eq(false)),
            (name.eq("Paris"), country_id.eq(2), is_capital.eq(true)),
            (name.eq("Marseille"), country_id.eq(2), is_capital.eq(false)),
            (name.eq("Madrid"), country_id.eq(3), is_capital.eq(true)),
            (name.eq("Barcelona"), country_id.eq(3), is_capital.eq(false)),
        ])
        .execute(&connection)
        .expect("Error saving new cities");
}
```

After that, we want to create a file that includes our models. We'll use these models later to query our database.
We'll create a new file under src/models.rs:

```rust
use diesel::sql_types::{Date};

#[derive(Queryable)]
pub struct Country {
    pub id: i32,
    pub name: String
}

#[derive(Queryable)]
pub struct City {
    pub id: i32,
    pub name: String,
    pub country_id: i32,
    pub is_capital: bool
}
```

:::
:::
:::
