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
		@@customers.each do |customer|
			break customer if customer.name == name
		end
	end

	private
	def add_to_customers(name)
		is_new_customer = true
		@@customers.each do |customer|
			if customer.name == name
				is_new_customer = false
				raise DuplicateCustomerError, "'#{name}' already exists" #check if 'break' is available
				break
			end
		end
		@@customers << self if is_new_customer
	end
end