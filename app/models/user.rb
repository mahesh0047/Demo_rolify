# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
