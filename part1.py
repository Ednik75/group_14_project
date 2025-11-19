print("---Welcome Dear Customer---")
user_name = input("Enter your full name : ")
budget = float(input("Enter your budget : "))
print(f"Hello {user_name}, your budget is {budget}")
#product1
product_1 = input("enter product 1 :")
price_1 = 300
quantity_1 = int(input(f"enter quantity of {product_1} :"))
total_price_1 = price_1 * quantity_1
#product2
product_2 = input("enter product 2 :")
price_2 = 300
quantity_2 = int(input(f"enter quantity of {product_2} :"))
total_price_2 = price_2 * quantity_2
#product3
product_3 = input("enter product 3 :")
price_3 = 300
quantity_3 = int(input(f"enter quantity of {product_3} :"))
total_price_3 = price_3 * quantity_3
#product4
product_4 = input("enter product 4 :")
price_4 = 300
quantity_4 = int(input(f"enter quantity of {product_4} :"))
total_price_4 = price_4 * quantity_4
#total
total_price = total_price_1 + total_price_2 + total_price_3 + total_price_4
#possibility
budget_possibilty = total_price <= budget
#rest
rest = budget - total_price

print(f"Dear {user_name} with {budget} here the different products you bought :")

print(f"{product_1}:{total_price_1}")
print(f"{product_2}:{total_price_2}")
print(f"{product_3}:{total_price_3}")
print(f"{product_4}:{total_price_4}")
print(f"Total price is : {total_price}")
print(f"Is your budget enough ? : {budget_possibilty}")
print(f"Rest is : {rest}")