namespace uvs;


type OrderStatus : String enum {
    Pending;
    Shipped;
    Delivered;
    Canceled
}

entity Orders {
    key ID : String @title : 'Order ID';
    customerID : String @title : 'Customer ID';  
    orderDate : DateTime @title : 'Order Date';  
    totalAmount : Decimal(10, 2) @title : 'Total Amount';
    status : OrderStatus;
    items : Composition of many OrderItems on items.order = $self
}

entity OrderItems {
    key ID : String @title : 'Item ID';  
    name : String @title : 'Item Name';  
    quantity : Integer @title : 'Quantity of Items';  
    price : Decimal(10, 2) @title : 'Item Price';
    netPrice : Decimal(10, 2) @title : 'Net Price';
    order : Association to Orders;
}



