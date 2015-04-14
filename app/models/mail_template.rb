class MailTemplate < ActiveRecord::Base
  validates :name, uniqueness: true
end
