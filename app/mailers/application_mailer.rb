class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@headway_project_v1.com',
          return_path: 'contact@headway_project_v1.com'

  layout 'mailer'

  def email(to_address, subject, body)
    options = { to: to_address, subject: subject, body: body }
    mail options
  end
end
