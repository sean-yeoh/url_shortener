class Url < ActiveRecord::Base
  validates :long, presence: true, uniqueness: true, format: { with: /\A\S+[.]\S+\z/, message: "Invalid URL" }
  before_create do
    self.shorten
  end

  def shorten
    alphanumeric = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).sample(rand(6..8)).join
    check_url = Url.find_by short: alphanumeric
    while !(check_url.nil?)
      alphanumeric = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).sample(rand(6..8)).join
      check_url = Url.find_by short: alphanumeric
    end
    self.short = alphanumeric
  end
end
