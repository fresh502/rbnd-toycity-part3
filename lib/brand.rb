class Brand
	attr_reader :name, :products

	@@brands = []

	def initialize(options={})
		@name = options[:name]
		@products = []
		add_to_brands(options)
	end

	def self.all
		@@brands
	end

	def self.find_by_name(name)
		@@brands.find { |brand| brand.name == name } # apply find method. Check if it is possbile in other classes.
	end

	private
	def add_to_brands(options={})
		is_new_brand = true
		@@brands.each do |brand|
			if brand.name == options[:name]
				is_new_brand = false
				brand.products << options[:product]
			end
		end
		if is_new_brand
			@@brands << self
			self.products << options[:product]
		end
	end
end