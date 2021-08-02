class PingResult < ApplicationRecord
  belongs_to :host

  validates :success, :transmitted, :received, presence: true
end
