class Product < ApplicationRecord
  validates :title,
            presence: true,
            uniqueness: { message: "should be unique" },
            length: { maximum: 40, message: "is too long" }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url,
            presence: true,
            format: {
              allow_blank: true,
              with: /\.(gif|jpg|png)\Z/i,
              message: 'must be a URL for GIF, JPG or PNG image.'
            }

  has_many :line_items

  before_destroy :ensure_not_reference_by_any_line_item

  private

  def ensure_not_reference_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
