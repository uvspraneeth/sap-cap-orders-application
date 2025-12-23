const cds = require('@sap/cds')

module.exports = class OrderServices extends cds.ApplicationService { async init() {

  const { Orders, OrderItems, Customers, ZCustomers } = cds.entities('OrderServices')

  const northwind_api = await cds.connect.to('northwind')

  this.on('READ', Customers, async (req) => {
    return northwind_api.tx(req).run(SELECT .from(Customers) .limit(10));
  });

  this.before('CREATE', OrderItems, async (req) => {
    const { quantity, price } = req.data
    if (quantity < 1) {
      req.error(400, 'Quantity must be at least 1');
    }
    if (price < 0) {
      req.error(400, 'Price cannot be negative');
    }
    req.data.netPrice = quantity * price;
  })
  this.before('CREATE', Orders, async (req) => {
    const { totalAmount } = req.data;
    if (totalAmount < 0) {
      req.error(400, 'Total amount cannot be negative');
    }
    if (!totalAmount) {
      req.error(400, 'Total amount is required');
    }
  })
  return super.init()
}}
