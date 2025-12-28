# Sky Takeout (苍穹外卖)

A comprehensive food delivery and takeout management system that provides a complete solution for restaurant operations, including customer-facing mobile application, administrative dashboard, and backend services.

## Project Overview

Sky Takeout is a full-stack food delivery platform that enables restaurants to manage their operations efficiently while providing customers with a seamless ordering experience. The system consists of three main components:

1. **WeChat Mini Program** - Customer-facing mobile application
2. **Admin Dashboard** - Restaurant management web interface
3. **Backend API** - RESTful services for business logic

Here shows the diagram of this project
```mermaid

flowchart TB

%% ======================
%% User Lane
%% ======================
subgraph User
    direction TB
    U1[WeChat Login]
    U2[Browse Dishes / Combos]
    U3[Add to Cart]
    U4[Place Order]
    U5{Confirm Address?}
    U6[Payment]
    U7[Order Cancelled]
    U8[Shopping Cart]
    U9[User Center]
    U10[Order History]
    U11[Reorder]
    U12[Address Management]

    U1 --> U2 --> U3 --> U4 --> U5
    U5 -- Yes --> U6
    U5 -- No --> U12 --> U5
    U6 -- Payment Failed --> U8
    U6 -- Cancel --> U7
    U9 --> U10 --> U11 --> U6
end

%% ======================
%% Merchant Lane
%% ======================
subgraph Merchant
    direction TB
    M0[Create Employee Account]
    M1[Order Received]
    M2[Employee Login]
    M3[Upload Dishes / Combos]
    M4[Start Business]
    M5{Accept Order?}
    M6[Prepare Order]
    M7[Reject Order]
    M8[Other Rejection Reasons]
    M9[Stop Selling Dishes / Combos]
    M10[Order Completed]
    M11[Data Statistics]

    M0 --> M2 --> M3 --> M4
    M1 --> M5
    M5 -- Yes --> M6
    M5 -- No --> M7 --> M8 --> M9
    M10 --> M11
end

%% ======================
%% Courier Lane
%% ======================
subgraph Courier
    direction TB
    C1{Courier Accepts Delivery?}
    C2[Deliver Order]
    C3[Confirm Delivery]

    C1 -- Yes --> C2 --> C3
end

%% ======================
%% Cross-lane Connections
%% ======================
U6 -- Payment Success --> M1
M6 --> C1
C3 --> M10


```


## Core Features

### Customer Features (WeChat Mini Program)
- **User Authentication** - WeChat login integration
- **Menu Browsing** - Browse dishes and setmeals by category
- **Shopping Cart** - Add, modify, and manage items in cart
- **Order Management** - Place orders, view order history, track order status
- **Payment Integration** - WeChat Pay payment processing
- **Address Management** - Add, edit, and manage delivery addresses
- **Order Details** - View detailed order information and status

### Admin Features
- **Employee Management** - Add, edit, enable/disable employee accounts
- **Category Management** - Organize dishes into categories
- **Dish Management** - Create, update, and manage dishes with flavors
- **Setmeal Management** - Create and manage meal packages
- **Order Management** - Process orders, update order status, handle cancellations
- **Shop Management** - Configure shop information and business hours


## Services Implemented

### User Services
- **User Service** - User registration, login, and profile management
- **Address Book Service** - Delivery address CRUD operations
- **Shopping Cart Service** - Cart item management
- **Order Service** - Order creation, payment processing, status tracking

### Admin Services
- **Employee Service** - Employee account management and authentication
- **Category Service** - Category management with hierarchical structure
- **Dish Service** - Dish management with flavor options and image upload
- **Setmeal Service** - Setmeal creation and management
- **Order Service** - Order processing, status updates, and statistics
- **Shop Service** - Shop configuration and status management
- **Workspace Service** - Business data analytics and reporting

### Common Services
- **File Upload Service** - Image and file upload to cloud storage (AWS S3)
- **Payment Service** - WeChat Pay integration for order payments
- **Notification Service** - Order status notifications

## Technology Stack

<table><tr><td valign="top" width="33%">

### Backend Development  
<div align="center">  
<a href="https://spring.io/projects/spring-boot" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/springio-icon.svg" alt="Spring Boot" height="50" /></a>  
<a href="https://mybatis.org/mybatis-3/" target="_blank"><img style="margin: 10px" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mybatis/mybatis-original.svg" alt="MyBatis" height="50" /></a>  
<a href="https://www.mysql.com/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/mysql-original-wordmark.svg" alt="MySQL" height="50" /></a>  
<a href="https://redis.io/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/redis-original-wordmark.svg" alt="Redis" height="50" /></a>  



</div>

</td><td valign="top" width="33%">

### Frontend Development  
<div align="center">  
<a href="https://vuejs.org/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/vuejs-original-wordmark.svg" alt="Vue.js" height="50" /></a>  
<a href="https://www.typescriptlang.org/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/typescript-original.svg" alt="TypeScript" height="50" /></a>  

</div>

</td><td valign="top" width="33%">

### Tools & Infrastructure  
<div align="center">  
<a href="https://www.nginx.com/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/nginx-original.svg" alt="Nginx" height="50" /></a>  
 
<a href="https://git-scm.com/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/git-scm-icon.svg" alt="Git" height="50" /></a>  

<a href="https://aws.amazon.com/s3/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/amazonwebservices-original-wordmark.svg" alt="AWS S3" height="50" /></a>  
</div>

</td></tr></table>

## Project Diagram
### User Query Dishes with redis for caching
```mermaid
flowchart TB

%% Client
A[Frontend] --> B[Controller<br/>Receive Request]

%% Controller to Service
B --> C[Service Layer<br/>Process Data]

%% Redis Logic
C --> D[Define Redis Operation Type]
D --> E[Build Redis Key]
E --> F{Does Data Exist<br/>in Redis?}

%% Cache Hit
F -- Yes --> G[Return VO]

%% Cache Miss
F -- No --> H[Query Database by Category ID]
H --> I[Query Dish Flavors by Dish ID]
I --> J[Assemble VO Object]
J --> K[Convert VO to JSON<br/>and Store in Redis]
K --> G

%% Database Layer
C --> L[Mapper Layer<br/>Database Access]
L --> M[Query Dish Data]
M --> H
```

## TODO List

### Order Management Service

- [ ] Implement order pagination query
- [ ] Implement order details query
- [ ] Implement order status update
- [ ] Implement order confirmation
- [ ] Implement order rejection
- [ ] Implement order cancellation
- [ ] Implement order delivery
- [ ] Implement order completion
- [ ] Implement user order history
- [ ] Implement order statistics

### Payment Service

- [ ] Implement payment processing
- [ ] Implement payment callback handler
- [ ] Implement payment status query
- [ ] Implement refund functionality
- [ ] Add payment methods to OrderService interface
- [ ] Add payment endpoints to User OrderController

### Order Dashboard Service

- [ ] Complete getOverviewOrders method
- [ ] Complete getBusinessData method
- [ ] Add order statistics method
- [ ] Add order trend analysis method
- [ ] Create WorkspaceServiceImpl
- [ ] Create WorkspaceController

### Controllers

- [ ] Create Admin OrderController
- [ ] Add order statistics endpoint
- [ ] Enhance User OrderController with history and detail endpoints

### Data Access Layer

- [ ] Enhance OrderMapper methods
- [ ] Enhance OrderDetailMapper methods

### DTOs/VOs

- [ ] Create order DTOs (Confirm, Rejection, Cancel, Delivery)
- [ ] Create order VOs (Statistics, Detail)

### Testing

- [ ] Test order management flow
- [ ] Test payment functionality
- [ ] Test dashboard services
