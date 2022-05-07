/*1*/
select TC08_customer.*,TC08_vehicle.* 
FROM TC08_customer
INNER JOIN TC08_vehicle
ON TC08_customer.cust_id = TC08_vehicle.cust_id
INNER JOIN TC08_claim
ON TC08_customer.cust_id = TC08_claim.cust_id
WHERE TC08_claim.incident_id IS NOT NULL
AND TC08_claim.claim_status LIKE "pending";

/*2*/
SELECT TC08_customer.*
FROM TC08_Customer
inner JOIN TC08_premium_payment
ON TC08_customer.cust_id = TC08_premium_payment.cust_id 
WHERE premium_payment_amount > (SELECT SUM(cust_id) FROM TC08_customer);

/*4*/
select tc08_customer.* from tc08_customer
inner join  tc08_premium_payment on tc08_customer.cust_id= tc08_premium_payment.cust_id
inner join tc08_incident_report on tc08_customer.cust_id= tc08_incident_report.cust_id and
tc08_incident_report.incident_type like 'ACCIDENT' and 
tc08_premium_payment.receipt_id is null and
tc08_customer.cust_id in (select cust_id from tc08_vehicle having count(cust_id)>1);

/*5*/
Select tc08_vehicle.* from tc08_vehicle
inner join tc08_premium_payment
on  tc08_vehicle.cust_id = tc08_premium_payment.cust_id
where tc08_premium_payment.premium_payment_amount >  tc08_vehicle.vehicle_number;

/*6*/
DELIMITER //
create function sum_of_id(claim_settlement_id int, vehicle_id varchar(20), claim_id varchar(20),cust_id int)
returns decimal(12,0)
deterministic
begin 
	declare total int;
	set total = claim_settlement_id+vehicle_id+cast(claim_id as decimal(10,0))+cust_id;
	return total;
end //
delimiter ; 

select tc08_customer.* from tc08_customer where cust_id in (
SELECT distinct(tc08_customer.cust_id)
FROM TC08_customer, TC08_vehicle, TC08_claim , TC08_insurance_policy , TC08_coverage , TC08_claim_settlement 
WHERE tc08_vehicle.cust_id = tc08_customer.cust_id AND
      tc08_claim.cust_id = tc08_customer.cust_id AND
      tc08_insurance_policy.cust_id = tc08_customer.cust_id AND
	  tc08_claim_settlement.claim_id = tc08_claim.claim_id AND
      tc08_claim.claim_amount < tc08_coverage.coverage_amount AND
      tc08_claim.claim_amount > (tc08_claim_settlement.claim_settlement_id + 
                                       tc08_vehicle.vehicle_id + tc08_claim.claim_id + tc08_customer.cust_id)
);


select sum_of_id(claim_settlement_id,tc08_vehicle.vehicle_id,tc08_claim.claim_id,tc08_claim.cust_id) 
from tc08_claim_settlement,tc08_vehicle,tc08_claim,tc08_customer;