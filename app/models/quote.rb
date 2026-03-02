class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :philosopher
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories
  accepts_nested_attributes_for :quote_categories, reject_if: :all_blank, allow_destroy: true 
  accepts_nested_attributes_for :philosopher, reject_if: :all_blank

  validate :must_have_at_least_one_category

  private

  def must_have_at_least_one_category
    # Only count quote_categories that aren’t marked for destruction
    if quote_categories.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "You must select at least one category")
    end
  end
end
