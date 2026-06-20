SELECT * FROM `pizzasales`.order_details;
SELECT * FROM `pizzasales`.orders;
SELECT * FROM `pizzasales`.pizza_types;
SELECT * FROM `pizzasales`.pizzas;

/*Basic*/
/*1:Retrieve the total number of orders placed.*/
SELECT COUNT(*) AS total_orders 
FROM `pizzasales`.orders;

/*2:Join relevant tables to find the category-wise distribution of pizzas.*/
SELECT pt.category, COUNT(od.pizza_id) AS pizza_count
FROM `pizzasales`.order_details od
JOIN `pizzasales`.pizzas p ON od.pizza_id = p.pizza_id
JOIN `pizzasales`.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

/*3:Calculate the total revenue generated from pizza sales.*/
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM `pizzasales`.order_details od
JOIN `pizzasales`.pizzas p ON od.pizza_id = p.pizza_id;

/*4:Identify the highest-priced pizza.*/
SELECT p.pizza_id, p.price
FROM `pizzasales`.pizzas p
ORDER BY p.price DESC
LIMIT 1;

/*5:Identify the most common pizza size ordered.*/
SELECT size, COUNT(*) AS size_count
FROM `pizzasales`.order_details od
JOIN `pizzasales`.pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY size_count DESC
LIMIT 1;

/*6:List the top 5 most ordered pizza types along with their quantities.*/
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM `pizzasales`.order_details od
JOIN `pizzasales`.pizzas p ON od.pizza_id = p.pizza_id
JOIN `pizzasales`.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;


/*Intermediate*/
/*7:Join the necessary tables to find the total quantity of each pizza category ordered.*/
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM `pizzasales`.order_details od
JOIN `pizzasales`.pizzas p ON od.pizza_id = p.pizza_id
JOIN `pizzasales`.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

/*8:Determine the distribution of orders by hour of the day.*/
SELECT EXTRACT(HOUR FROM o.time) AS order_hour, COUNT(o.order_id) AS order_count
FROM `pizzasales`.orders o
GROUP BY order_hour
ORDER BY order_hour;

/*9:Group the orders by date and calculate the average number of pizzas ordered per day.*/
SELECT o.date, AVG(od.quantity) AS avg_pizzas_per_day
FROM `pizzasales`.orders o
JOIN `pizzasales`.order_details od ON o.order_id = od.order_id
GROUP BY o.date;

/*10:Determine the top 3 most ordered pizza types based on revenue.*/
SELECT pt.name, SUM(od.quantity * p.price) AS total_revenue
FROM `pizzasales`.order_details od
JOIN `pizzasales`.pizzas p ON od.pizza_id = p.pizza_id
JOIN `pizzasales`.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


