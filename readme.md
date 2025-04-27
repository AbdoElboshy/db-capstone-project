# Little Lemon Booking System – Capstone Project

Welcome to the Little Lemon Booking System repository! This project demonstrates the design and implementation of a restaurant booking system using a MySQL database, Python for database connectivity and business logic, and Tableau for data analysis and reporting.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features & Deliverables](#features--deliverables)
- [Repository Structure](#repository-structure)
- [Setup Instructions](#setup-instructions)
- [ER Diagram](#er-diagram)
- [Procedures Implemented](#procedures-implemented)
- [Tableau Data Analysis](#tableau-data-analysis)
- [Grading Criteria](#grading-criteria)
- [Contributing](#contributing)
- [License](#license)

---

## Project Overview

This capstone project is part of the final assessment for building a comprehensive booking system for the fictional restaurant, Little Lemon.

**Objectives:**

- Design a relational data model for managing restaurant bookings.
- Implement the schema in a MySQL database.
- Develop Python scripts for database operations and to execute key procedures.
- Analyze booking data using Tableau, connecting directly to the database or using exported data.
- Present results with diagrams, screenshots, and dashboards.

---

## Features & Deliverables

- **Database Schema**: MySQL Workbench model + SQL schema file.
- **Python Integration**: Scripts for database connection and data manipulation.
- **Stored Procedures**: Core procedures for managing restaurant bookings.
- **Tableau Workbook**: Data analysis and reporting dashboards.
- **Documentation**: ER diagram, screenshots, and instructions.

---

## Repository Structure

```
.
├── /screenshots/             # PNG diagrams & screenshots (ERD, Tableau)
├── /sql/                     # Database schema and sample data (.sql)
├── /python/                  # Python scripts for DB operations
├── /tableau/                 # Tableau workbook (.twb or .twbx)
├── README.md                 # Project documentation
```

---

## Setup Instructions

### 1. Database Setup

- Install MySQL and MySQL Workbench.
- Open `/sql/little_lemon_schema.sql` in MySQL Workbench and run it to create the schema and tables.
- (Optional) Use `/sql/sample_data.sql` to populate the tables with sample records.

### 2. Python Client

- Ensure Python 3.x is installed.
- Install dependencies:
  ```bash
  pip install mysql-connector-python
  ```
- Configure database connection in `/python/db_connect.py`.
- Run scripts (see file docstrings for usage):
  ```bash
  python /python/manage_booking.py
  ```

### 3. Tableau Connection

- Open `/tableau/LittleLemonBookings.twbx` in Tableau Desktop.
- Connect directly to your MySQL database or use exported CSV data.
- Explore the predefined dashboards and visualizations.

---

## ER Diagram

Find the ER diagram in `/screenshots/little_lemon_er_diagram.png`.

**Tables include:**
- `Customers`
- `Bookings`
- `Tables`
- `Menu`
- `Orders`
- `OrderItems`

**Relationships:**
- Customers place Bookings.
- Bookings are assigned to Tables.
- Orders are linked to Bookings.

---

## Procedures Implemented

The following stored procedures are implemented in the project:

- **GetMaxQuantity()**
  - Returns the maximum number of guests allowed per table.
- **ManageBooking()**
  - Handles logic for booking creation, update, or cancellation.
- **UpdateBooking()**
  - Updates existing booking details in the database.
- **AddBooking()**
  - Adds a new booking for a customer.
- **CancelBooking()**
  - Cancels an existing booking and frees up the assigned table.

Find the SQL definitions in `/sql/procedures.sql` and Python wrappers in `/python/`.

---

## Tableau Data Analysis

The Tableau workbook includes:

- Booking and occupancy dashboards.
- Customer demographics analysis.
- Time-based booking trends.
- Cancellations and fulfillment rates.

**Screenshots:** See `/screenshots/tableau_dashboard_*.png`.

---


## Grading Criteria

Your project will be evaluated based on:

- [x] GitHub repository setup with all required files.
- [x] Inclusion of project code, SQL schema, and documentation.
- [x] ER diagram showing all table relationships.
- [x] Proper implementation of required procedures.
- [x] Data model created in MySQL Workbench.
- [x] Tableau workbook with all required dashboards.
- [x] Relevant diagrams and screenshots.

---

## Contributing

Contributions are welcome! Please fork the repository, make changes, and open a pull request.

---

## License

This project is provided for educational purposes and does not include a specific license.

---
