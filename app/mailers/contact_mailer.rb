class ContactMailer < ApplicationMailer

  def send_mail(mail_title,mail_content,room_users)
    @mail_title = mail_title
    @mail_content = mail_content
    mail bcc: room_users.pluck(:email), subject: mail_title
  end
end
