class Product
	attr_reader :title, :price, :stock
	attr_writer :stock

	@@products = []

	def initialize(options={})
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		add_to_products(options[:title])
	end

	def self.all
		@@products
	end

	def self.find_by_title(title)
		@@products.each do |product|
			break product if product.title == title
		end
	end

	def in_stock?
		@stock > 0 ? true : false
	end

	def self.in_stock
		@@products.select { |product| product.stock > 0 }
	end

	private
	def add_to_products(title)
		is_new_product = true
		@@products.each do |product|
			if product.title == title
				is_new_product = false
				raise DuplicateProductError, "'#{title}' already exists"  ##check if 'break' is available
				break
			end
		end
		@@products << self if is_new_product
	end
end