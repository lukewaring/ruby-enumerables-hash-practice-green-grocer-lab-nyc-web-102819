require 'pry'

def consolidate_cart(cart)
  final_hash = {}
  cart.map do |element_hash|
    element_name = element_hash.keys[0]
    
    if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1 
    else
      final_hash[element_name] = {
        price: element_hash[element_name][:price],
        clearance: element_hash[element_name][:clearance],
        count: 1 
      }
    end
  end
  final_hash
end

def apply_coupons(cart, coupons)
  coupons.map do |coupon|
    item = coupon[:item]
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"] = { price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num] }
      elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += coupon[:num]
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.map do |product_name, product_stats|
    if product_stats[:clearance] == true 
      product_stats[:price] = (product_stats[:price] * 0.8).round(2)
    binding.pry
    end
  end
  cart
end

# def checkout(cart, coupons)
#   # code here
# end
