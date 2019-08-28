# frozen_string_literal: true

class UserProvider
  attr_reader :results

  def initialize(key)
    @results = User.all
    filter_by_key(key)
  end

  # Filter users nickname by key
  def filter_by_key(key)
    @results = if key.blank?
                 []
               else
                 @results.where('lower(nickname) like ?', "%#{key.downcase}%")
               end
  end
end
