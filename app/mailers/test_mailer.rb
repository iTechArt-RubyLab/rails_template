# frozen_string_literal: true

class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.test_email.subject
  #
  def test_email
    @greeting = 'Hi'

    attachments['ror.png'] = File.read(Rails.root.join(*%w(app assets images ror.png)))

    mail to: 'to@example.org'
  end
end
