# frozen_string_literal: true

class ExampleMailer < ApplicationMailer
  default from: 'milan.tagline@gmail.com'

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
