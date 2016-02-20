class Customer
	attr_reader :name

	@@customers = []

	def initialize(options={})
		@name = options[:name]
		add_to_customers(options[:name])
	end

	def self.all
		@@customers
	end

	def self.find_by_name(name)
		@@customers.find { |customer| customer.name == name }
	end

	def purchase(product)
		Transaction.new(customer: self, product: product)
	end

	def return(transaction_id)
		Transaction.cancel(transaction_id)
	end

	private
	def add_to_customers(name)
		is_new_customer = true
		@@customers.each do |customer|
			if customer.name == name
				is_new_customer = false
				raise DuplicateCustomerError, "'#{name}' already exists"
			end
		end
		@@customers << self if is_new_customer
	end
end