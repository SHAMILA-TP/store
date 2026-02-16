class Product < ApplicationRecord
  has_many :subscribers, dependent: :destroy
  after_update_commit :notify_subscribers, if: :back_in_stock?
  validates :name, presence:  true
  has_one_attached :photo
  validates :inventory_count, numericality: {greater_than_or_equal_to: 0}

  def back_in_stock?
    inventory_count_previously_was.to_i.zero? && inventory_count.positive?
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      ProductMailer
        .with(product: self, subscriber: subscriber)
        .in_stock
        .deliver_later
    end
  end
  
end
