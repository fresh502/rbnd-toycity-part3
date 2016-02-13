class Transaction
	attr_reader :id, :customer, :product

	@@id = 0
	@@transactions = []

	def initialize(customer, product)
		add_to_transactions(customer, product)
	end

	def self.all
		@@transactions
	end

	def self.find(id)
		@@transactions.each do |transaction|
			break transaction if transaction.id == id
		end
	end

	private
	def add_to_transactions(customer, product)
		if product.stock > 0
			@id = @@id += 1
			@customer = customer
			@product = product
			product.stock -= 1
			@@transactions << self
		else
			raise OutOfStockError, "'#{product.title}' is out of stock"
		end
	end
end