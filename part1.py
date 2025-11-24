print("--- Welcome to the Store System ---")

# --- CLASSES ---
class Product:
    def __init__(self, name: str, price: float, quantity: int):
        self.name = name
        self.price = price
        self.quantity = quantity

    def total(self):
        return self.price * self.quantity

class Customer:
    def __init__(self, full_name: str, budget: int):
        self.full_name = full_name
        self.budget = budget
        self.products = []

    def add_product(self, product: Product):
        self.products.append(product)

    def total_cost(self):
        return sum(p.total() for p in self.products)

    def can_afford(self):
        if self.total_cost() <= self.budget:
            return "Yes, your budget is enough."
        else:
            return "No, your budget is not enough."

    def remaining_money(self):
        remaining = self.budget - self.total_cost()
        return remaining if remaining >= 0 else 0


# --- 2. CATALOGUE (FIXED LIST) ---

def get_fixed_catalogue():
    # Fix value
    catalogue = {
        1: {"name": "Bread", "price": 150},
        2: {"name": "Soap", "price": 400},
        3: {"name": "Milk", "price": 300},
        4: {"name": "Rice(1KG)", "price": 4250}
    }
    return catalogue


# --- 3. PURCHASE FUNCTION --- 

def ask_product_selection(catalogue):
    print("\n--- AVAILABLE PRODUCTS ---")
    for id_prod, details in catalogue.items():
        print(f"{id_prod}. {details['name']} : {details['price']:.0f} CFA")
    print("--------------------------")
    
    
    while True:
        try:
            choice = int(input("Select product number to buy: "))
            if choice in catalogue:
                selected_data = catalogue[choice]
                break
            else:
                print("Error: This product number does not exist.")
        except ValueError:
            print("Error: Please enter a number.")

    
    while True:
        try:
            quantity = int(input(f"Please enter the desired quantity for '{selected_data['name']}' : "))
            if quantity > 0:
                break
            else:
                print("Error: Quantity must be at least 1.")
        except ValueError:
            print("Error: Please enter a valid integer number.")
    
    return Product(selected_data['name'], selected_data['price'], quantity)


# ==========================================
#           MAIN PROGRAM
# ==========================================

#  Chargement catalogue
shop_catalogue = get_fixed_catalogue()


# Client information
print("\n--- CUSTOMER ENTRY ---")

# Client name 
while True:
    user_name = input("Enter your full name: ").strip()
    
    has_digit = any(char.isdigit() for char in user_name)
    
    if user_name == "":
        print("Error: Name cannot be empty.")
    elif has_digit:
        print("Error: Name cannot contain numbers. Please use only letters.")
    else:
        break

#  BUDGET Notification
while True:
    try:
        budget = int(input("Enter your budget (in CFA): "))
        if budget > 0:
            break
        else:
            print("Error: Budget must be positive.")
    except ValueError:
        print("Error: Please enter a whole number (no letters).")

customer = Customer(user_name, budget)

# 4 products(MAX)
items_count = 0
MAX_LIMIT = 4

while items_count < MAX_LIMIT:
    print(f"\n--- Purchase {items_count + 1} of {MAX_LIMIT} ---")
    
    product = ask_product_selection(shop_catalogue)
    customer.add_product(product)
    items_count += 1
    
    print(f"-> Added to cart: {product.quantity} x {product.name}")

    if items_count == MAX_LIMIT:
        print("\n⚠️  You have reached the limit of 4 product choices.")
        break

    cont = input("\nDo you want to buy another item? (y/n): ").strip().lower()
    if cont != 'y':
        break

# Bill
print(f"\n========================================")
print(f"RECEIPT FOR: {customer.full_name}")
print(f"----------------------------------------")
for p in customer.products:
    print(f"- {p.name} (x{p.quantity}) : {p.total():.0f} CFA")
print(f"----------------------------------------")
print(f"Total Price     : {customer.total_cost():.0f} CFA")
print(f"Initial Budget  : {customer.budget} CFA")
print(f"Budget Status   : {customer.can_afford()}")
print(f"Remaining Money : {customer.remaining_money():.0f} CFA")
print(f"========================================")