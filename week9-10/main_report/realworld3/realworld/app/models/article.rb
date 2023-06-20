class Article < ApplicationRecord
  before_save :generate_slug

  def generate_slug
    self.slug = title.parameterize
  end
end
