class Transaction
	attr_reader :id, :customer, :product

	@@id = 0
	@@transactions = []

	def initialize(options={})
		add_to_transactions(options)
	end

	def self.all
		@@transactions
	end

	def self.find(id)
		@@transactions.each do |transaction|
			break transaction if transaction.id == id
		end
	end

	def self.cancel(transaction_be_canceled)
		@@transactions.delete_if { |transaction| transaction.id == transaction_be_canceled.id }
		transaction_be_canceled.product.stock += 1
	end

	private
	def add_to_transactions(options)
		if options[:product].stock > 0
			@id = @@id += 1
			@customer = options[:customer]
			@product = options[:product]
			product.stock -= 1
			@@transactions << self
		else
			raise OutOfStockError, "'#{product.title}' is out of stock"
		end
	end
end