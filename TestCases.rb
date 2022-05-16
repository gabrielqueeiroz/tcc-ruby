require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class TestCases < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :chrome
    @url = 'https://www.grocerycrud.com/v1.x/demo/my_boss_is_in_a_hurry/bootstrap'
    @driver.manage.timeouts.implicit_wait = 15
  end

  def test_register_user
    person = {:name => 'Tcc',
              :last_name => 'Gabriel',
              :contact_first_name => 'Teste',
              :phone => '92 9999-9999',
              :addressLine1 => 'Av Darcy Vargas, 1200',
              :addressLine2 => 'Stem',
              :city => 'Manaus',
              :state => 'AM',
              :postal_code => '69050-020',
              :country => 'Brasil',
              :from_employeer => 'Fixter',
              :credit_limit => '200'
    }
    @driver.get(@url)
    @driver.find_element(:xpath, '/html/body/div[1]/select/option[4]').click
    @driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[2]/form/div[1]/div[1]/a').click
    @driver.find_element(:xpath, '//*[@id="field-customerName"]').send_keys(person[:name])
    @driver.find_element(:xpath, '//*[@id="field-contactLastName"]').send_keys(person[:last_name])
    @driver.find_element(:xpath, '//*[@id="field-contactFirstName"]').send_keys(person[:contact_first_name])
    @driver.find_element(:xpath, '//*[@id="field-phone"]').send_keys(person[:addressLine1])
    @driver.find_element(:xpath, '//*[@id="field-addressLine1"]').send_keys(person[:addressLine2])
    @driver.find_element(:xpath, '//*[@id="field-addressLine2"]').send_keys(person[:city])
    @driver.find_element(:xpath, '//*[@id="field-city"]').send_keys(person[:state])
    @driver.find_element(:xpath, '//*[@id="field-postalCode"]').send_keys(person[:postal_code])
    @driver.find_element(:xpath, '//*[@id="field-country"]').send_keys(person[:country])
    @driver.find_element(:xpath, '//*[@id="field-salesRepEmployeeNumber"]').send_keys(person[:from_employeer])
    @driver.find_element(:xpath, '//*[@id="field-creditLimit"]').send_keys(person[:credit_limit])
    @driver.find_element(:xpath, '//*[@id="form-button-save"]').click

    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    wait.until { @driver.find_element(:xpath => '//*[@id="report-success"]').displayed? }
    @form_message = @driver.find_element(:xpath, '//*[@id="report-success"]').text
    assert_equal(@form_message, 'Your data has been successfully stored into the database. Edit Record or Go back to list')
  end

  def test_remove_user
    person = {:name => 'Tcc',
              :last_name => 'Gabriel',
              :contact_first_name => 'Teste',
              :phone => '92 9999-9999',
              :addressLine1 => 'Av Darcy Vargas, 1200',
              :addressLine2 => 'Stem',
              :city => 'Manaus',
              :state => 'AM',
              :postal_code => '69050-020',
              :country => 'Brasil',
              :from_employeer => 'Fixter',
              :credit_limit => '200'
    }
    @driver.get(@url)
    @driver.find_element(:xpath, '/html/body/div[1]/select/option[4]').click
    @driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[2]/form/div[1]/div[1]/a').click
    @driver.find_element(:xpath, '//*[@id="field-customerName"]').send_keys(person[:name])
    @driver.find_element(:xpath, '//*[@id="field-contactLastName"]').send_keys(person[:last_name])
    @driver.find_element(:xpath, '//*[@id="field-contactFirstName"]').send_keys(person[:contact_first_name])
    @driver.find_element(:xpath, '//*[@id="field-phone"]').send_keys(person[:addressLine1])
    @driver.find_element(:xpath, '//*[@id="field-addressLine1"]').send_keys(person[:addressLine2])
    @driver.find_element(:xpath, '//*[@id="field-addressLine2"]').send_keys(person[:city])
    @driver.find_element(:xpath, '//*[@id="field-city"]').send_keys(person[:state])
    @driver.find_element(:xpath, '//*[@id="field-postalCode"]').send_keys(person[:postal_code])
    @driver.find_element(:xpath, '//*[@id="field-country"]').send_keys(person[:country])
    @driver.find_element(:xpath, '//*[@id="field-salesRepEmployeeNumber"]').send_keys(person[:from_employeer])
    @driver.find_element(:xpath, '//*[@id="field-creditLimit"]').send_keys(person[:credit_limit])
    @driver.find_element(:xpath, '//*[@id="save-and-go-back-button"]').click
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    wait.until { @driver.find_element(:xpath => '/html/body/div[2]/div[2]/div[1]/div[2]/form/div[2]/table/thead/tr[2]/td[3]/input').displayed? }
    @driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[2]/form/div[2]/table/thead/tr[2]/td[3]/input').send_keys(person[:name])
    @driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[2]/form/div[2]/table/thead/tr[2]/td[2]/div[2]/a').click


    wait.until { @driver.find_element(:xpath => '/html/body/div[3]').displayed? }
    @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[2]/td[1]/div/input').click
    wait.until { @driver.find_element(:xpath => '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[2]/td[2]/div[1]/a').displayed? }
    @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[2]/td[2]/div[1]/a').click
    wait.until { @driver.find_element(:xpath => '/html/body/div[2]/div[2]/div[3]/div/div/div[3]/button[1]').displayed? }
    @delete_message = @driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[3]/div/div/div[2]/p[2]').text
    assert_equal(@delete_message, 'Are you sure that you want to delete this 1 item?')
    @driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[3]/div/div/div[3]/button[2]').click
    wait.until { @driver.find_element(:xpath => '/html/body/div[4]/span[3]/p').displayed? }
    @popup_message = @driver.find_element(:xpath, '/html/body/div[4]/span[3]/p').text
    assert_equal(@popup_message, 'Your data has been successfully deleted from the database.')
  end

  def test_check_columns
    @driver.get(@url)
    @column_1 = @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[1]/th[1]').text
    @column_2 = @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[1]/th[2]').text
    @column_3 = @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[1]/th[3]').text
    @column_4 = @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[1]/th[4]').text
    @column_5 = @driver.find_element(:xpath, '//*[@id="gcrud-search-form"]/div[2]/table/thead/tr[1]/th[5]').text

    assert_equal(@column_1, 'Actions')
    assert_equal(@column_2, 'CustomerName')
    assert_equal(@column_3, 'Phone')
    assert_equal(@column_4, 'AddressLine1')
    assert_equal(@column_5, 'CreditLimit')
  end

  def teardown
    @driver.quit
  end
end
