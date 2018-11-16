class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories

  def self.enum_form_options(data)
    data.map { |record| [record.titleize, record] }
  end

  enum status: %i[draft published archived]
  enum job_type: %i[full_time part_time freelance temporary]
  enum how_to_apply: %i[apply_by_url apply_by_email]

  def self.job_type_form_options
    enum_form_options(job_types.keys)
  end

  def self.how_to_apply_form_options
    enum_form_options(how_to_applies.keys)
  end

  def self.cached
    order(:created_at).select(:id, :title)
  end

  def posted
    created_at.strftime('%b %e')
  end

  def path
    Rails.application.routes.url_helpers.post_url(self)
  end
end
