# helpers for email for tests
module Helpers::Email
  def click_email_link(index, mail = ActionMailer::Base.deliveries.last)
    html = Nokogiri(mail.body.to_s)
    link = html.css("a").to_a[index]

    visit link["href"]
  end
end
