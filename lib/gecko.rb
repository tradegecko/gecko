# frozen_string_literal: true

require 'virtus'
require 'active_support/inflector'
require 'active_support/notifications'
require 'oauth2'

require 'gecko/client'

# Include models
require 'gecko/record/base'
require 'gecko/record/base_adapter'
require 'gecko/record/exceptions'

require 'gecko/record/account'
require 'gecko/record/address'
require 'gecko/record/company'
require 'gecko/record/contact'
require 'gecko/record/currency'
require 'gecko/record/order'
require 'gecko/record/order_line_item'
require 'gecko/record/fulfillment'
require 'gecko/record/fulfillment_line_item'
require 'gecko/record/invoice'
require 'gecko/record/invoice_line_item'
require 'gecko/record/stock_adjustment'
require 'gecko/record/stock_adjustment_line_item'
require 'gecko/record/product'
require 'gecko/record/variant'
require 'gecko/record/image'
require 'gecko/record/location'
require 'gecko/record/note'
require 'gecko/record/user'
require 'gecko/record/purchase_order'
require 'gecko/record/purchase_order_line_item'
require 'gecko/record/tax_type'
require 'gecko/record/payment_method'
require 'gecko/record/payment_term'
require 'gecko/record/webhook'

module Gecko
  def self.enable_logging
    require 'gecko/ext/log_subscriber'
  end

  def self.install_liquid_shim
    require 'gecko/ext/liquid_compat'
  end
end
