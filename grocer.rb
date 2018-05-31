require 'pry'

def consolidate_cart(cart)
  # code here
  return_hash = {}

  cart.each do |individual_item|
    count_num = cart.count(individual_item)
    return_hash[individual_item.first[0]] = individual_item.first[1]
    return_hash[individual_item.first[0]][:count] = count_num
  end
  return_hash
end

def apply_coupons(cart, coupons)
  # code here
  return_hash = {}
  if coupons == []
    cart.each do |individual_item|
      return_hash[individual_item[0]] = individual_item[1]
    end
    return return_hash
  end
  cart.each do |individual_item|
    return_hash[individual_item[0]] = individual_item[1]
    coupons.each do |coupon|
      if coupon[:item] == individual_item.first && coupon[:num] <= individual_item[1][:count]
        coupon_hash = {}
        coupon_hash["#{individual_item.first} W/COUPON"] = {}
        coupon_hash["#{individual_item.first} W/COUPON"][:price] = coupon[:cost]
        coupon_hash["#{individual_item.first} W/COUPON"][:clearance] = individual_item[1][:clearance]
        coupon_hash["#{individual_item.first} W/COUPON"][:count] = 1
        if return_hash[coupon[:item] + " W/COUPON"] == nil
          return_hash[coupon_hash.first[0]] = coupon_hash.first[1]
        else
          return_hash[coupon[:item] + " W/COUPON"][:count] += 1
        end
        return_hash[individual_item[0]][:count] = individual_item[1][:count] - coupon[:num]
      end
    end
  end
  return_hash
end

def apply_clearance(cart)
  # code here
  cart.each do |item|
    if item[1][:clearance] == true
      item[1][:price] = (item[1][:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  new_hash = consolidate_cart(cart)
  new_hash = apply_coupons(new_hash, coupons)
  new_hash = apply_clearance(new_hash)
  cart_total = 0.0
  new_hash.each do |item|
    cart_total += (item[1][:price] * item[1][:count].to_f).round(2)
  end
  if cart_total > 100.00
    cart_total = (cart_total * 0.9).round(2)
  end
  cart_total
end
