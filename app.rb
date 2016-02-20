require_relative "lib/errors"
require_relative "lib/customer"
require_relative "lib/product"
require_relative "lib/transaction"
require_relative "lib/brand"

# PRODUCTS

Product.new(title: "LEGO Iron Man vs. Ultron", brand_name: "LEGO", price: 22.99, stock: 55)
Product.new(title: "Nano Block Empire State Building", brand_name: "Nano Blocks", price: 49.99, stock: 12)
Product.new(title: "LEGO Firehouse Headquarter", brand_name: "LEGO", price: 199.99, stock: 0)

puts Product.all.count # Should return 3

# Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
# Should return DuplicateProductError: 'LEGO Iron Man vs. Ultron' already exists.

nanoblock = Product.find_by_title("Nano Block Empire State Building")
firehouse = Product.find_by_title("LEGO Firehouse Headquarter")

puts nanoblock.title # Should return 'Nano Block Empire State Building'
puts nanoblock.price # Should return 49.99
puts nanoblock.stock # Should return 12
puts nanoblock.in_stock? # Should return true
puts firehouse.in_stock? # Should return false

products_in_stock = Product.in_stock
#Should return an array of all products with a stock greater than zero
puts products_in_stock.include?(nanoblock) # Should return true
puts products_in_stock.include?(firehouse) # Should return false

# CUSTOMERS

Customer.new(name: "Walter Latimer")
Customer.new(name: "Julia Van Cleve")

puts Customer.all.count # Should return 2

# Customer.new(name: "Walter Latimer")
# Should return DuplicateCustomerError: 'Walter Latimer' already exists.

walter = Customer.find_by_name("Walter Latimer")

puts walter.name # Should return "Walter Latimer"

# TRANSACTIONS

transaction = Transaction.new(customer: walter, product: nanoblock)

puts transaction.id # Should return 1
puts transaction.product == nanoblock # Should return true
puts transaction.product == firehouse # Should return false
puts transaction.customer == walter # Should return true

puts nanoblock.stock # Should return 11

# PURCHASES

walter.purchase(nanoblock)

puts Transaction.all.count # Should return 2

transaction2 = Transaction.find(2)
puts transaction2.product == nanoblock # Should return true

# walter.purchase(firehouse)
# Should return OutOfStockError: 'LEGO Firehouse Headquarter' is out of stock.

# Brand

puts Brand.all.count # Should return 2
Brand.all.each do |each_brand|
	puts each_brand.inspect # Should return each brand
end
Brand.find_by_name("LEGO").products.each { |product| puts product.title } # Should return 'LEGO' brand's product title

# Cancel transaction(a way for customers to return items)

puts Transaction.all.count # Should return 2
puts nanoblock.stock # Should return 10
puts Transaction.all.inspect
Transaction.cancel(transaction2) # Cancel transaction of id=2 in which Walter bought nanoblock
puts Transaction.all.count # Should return 1
puts nanoblock.stock # Should return 11
puts Transaction.all.inspect

