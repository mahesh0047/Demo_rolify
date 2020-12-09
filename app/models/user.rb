# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[facebook github google_oauth2]

  def self.create_from_provider_data(provider_data)
    create_with(provider: provider_data.provider, uid: provider_data.uid).find_or_create_by(email: provider_data.info.email) do |user|
      user.name = provider_data.info.name
      user.password = Devise.friendly_token[0, 20]
      user.add_role(:trainee)
      user.save(validate: false)
    end
  end

  belongs_to :state
  belongs_to :city
  belongs_to :company
  has_and_belongs_to_many :languages

  validates :name, presence: { message: 'must be given' }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :phone_no, presence: true,
                       numericality: true

  scope :admin, -> { joins(:roles).where.not('roles.name = ?', 'admin') }

  scope :team_leader, -> { joins(:roles).where('roles.name = ? OR roles.name = ?', 'devloper', 'trainee') }

  scope :devloper, -> { joins(:roles).where('roles.name = ?', 'trainee') }
end
