require 'spec_helper'

class HelloWorldTest < Test::Unit::TestCase
  include Capybara::DSL
  # Capybara.default_driver = :selenium # <-- use Selenium driver

  def setup
    Capybara.app = App
  end

  def test_home_page
    visit '/'
    assert page.has_content?('Secret message service')
  end

  def test_redirect
    visit '/'
    fill_in('body', with: 'HelloWorldBaby')
    click_button('submit')
    assert page.has_content?(Message.last.fake_id)
  end

  def test_visit_message_page
    visit '/'
    fill_in('body', with: 'New littel test this message')
    click_button('submit')
    click_link('Open your message')
    assert page.has_content?('New littel test this message')
  end

  def test_deleted_at
    message = Message.create(body:'Hello!', message_type: 'first_visit')
    visit ("/message/#{message.fake_id}")
    assert page.has_content?('Hello!')
    visit ("/message/#{message.fake_id}")
    assert page.has_content?('Sorry , but the message is not available or created')
    assert_not_nil(message.reload.deleted_at)
    assert_not_nil(message.reload.created_at)
  end

end
