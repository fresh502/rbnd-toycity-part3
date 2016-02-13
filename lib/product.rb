class Product
	attr_reader :title

	@@products = []

	def initialize(options={})
		@title = options[:title]
		add_to_products(options[:title])
	end

	def self.all
		@@products
	end

	private
	def add_to_products(title)
		is_new_product = true
		@@products.each do |product|
			if product.title == title
				is_new_product = false
				raise DuplicateProductError, "#{title} already exists"
				break
			end
		end
		@@products << self if is_new_product
	end
end