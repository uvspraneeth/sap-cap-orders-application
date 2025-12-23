using {uvs} from '../db/schema';
using {northwind} from './external/northwind';

service OrderServices @(
    requires: 'authenticated-user',
    path    : '/OrderManagermentServices'
)
{
    @odata.draft.enabled
    @restrict: [ { grant: 'READ', to: 'Viewer' }, { grant: '*', to: 'Admin' } ]

    entity Orders     as
        projection on uvs.Orders {
            *,
            customer : Association to Customers
                           on customer.CustomerID = $self.customerID
        };
    
    entity OrderItems as projection on uvs.OrderItems;

    @odata.draft.enabled
    entity ZCustomers as projection on Customers;

    //External Service Exposing
    entity Customers  as
        projection on northwind.Customers {
            CustomerID,
            CompanyName,
            ContactName,
            ContactTitle,
            Address,
            City,
            Region,
            PostalCode,
            Country,
            Phone,
            Fax,
        };

}
