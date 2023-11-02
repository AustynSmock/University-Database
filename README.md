# University Database Project

This University Database Project focuses on modeling and managing data for a university's academic system. It includes tables for departments, instructors, courses, sections, students, and more. The database allows you to store and manage information about students, courses, instructors, and academic relationships.

## Table of Contents
- [Database Schema](#database-schema)
- [Populating the Database](#populating-the-database)
- [Executing Sample Queries](#executing-sample-queries)

## Database Schema

This database project is based on a relational database schema that consists of the following tables:

- **`department`:** Stores information about academic departments, including their names, buildings, and budgets.
- **`instructor`:** Contains details about university instructors, such as their IDs, names, department affiliations, and salaries.
- **`teaches`:** Represents the courses taught by instructors in different sections, including details about the course, semester, and year.
- **`course`:** Stores information about university courses, including course IDs, titles, department affiliations, and credit values.
- **`section`:** Contains data about course sections, including details about the course, semester, year, building, and room number.
- **`classroom`:** Includes information about classrooms, such as building, room number, and capacity.
- **`student`:** Represents student information, including student IDs, names, department affiliations, and total credits.
- **`takes`:** Contains data about students taking specific course sections, including details about the course, semester, year, and grades.
- **`advisor`:** Stores information about academic advisors for students, including student IDs and instructor IDs.
- **`prereq`:** Represents course prerequisites and their relationships.
- **`timeSlot`:** Contains information about time slots for classes, including time slot IDs, days, start and end times.

## Populating the Database

The database schema can be populated with sample data using SQL `INSERT INTO` statements. For instance, you can add data to the `department`, `instructor`, and other tables to create a realistic academic environment.

Please make sure you have a PostgreSQL database set up and running and execute the SQL statements mentioned in the provided SQL code to populate your database with sample data.

## Executing Sample Queries

Once the database is populated, you can execute various SQL queries to retrieve and manipulate data. The sample queries provided at the end of the SQL code are designed to help you test and verify the database's correctness. You can run these queries to confirm that the database contains the expected information.

For instance, you can query the database to retrieve information about classrooms, departments, courses, instructors, students, sections, and more.
