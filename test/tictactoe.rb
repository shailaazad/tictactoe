require 'capybara/minitest'
require 'minitest/autorun'
require 'webdrivers'
require 'pry'

class CapybaraTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def teardown
    Capybara.reset_sessions!    
  end
end

class TicTacToeTests < CapybaraTestCase

  def setup
  	Capybara.default_driver = :selenium_chrome
    Capybara.app_host = "https://codepen.io"
  end

  def test_generate_grid 
  	visit('/jshlfts32/full/bjambP/')
  	
  	page.within_frame('result') do 
  		grid_size = 3
	    fill_in('number', with: grid_size)
	    click_button('start')
  		assert_equal page.all('table td').size, (grid_size * grid_size)
  	end
  end

  def test_winner_x
  	visit('/jshlfts32/full/bjambP/')
  	
  	page.within_frame('result') do 
  		grid_size = 3
	    fill_in('number', with: grid_size)
	    click_button('start')
	
	    cells = page.all('table td')
	    cells[0].click
	    cells[1].click
	    cells[4].click
	    cells[5].click
	    cells[8].click
	    
	    assert page.has_text? "Congratulations player X! You've won. Refresh to play again!"
  	end
  end

  def test_winner_o
  	visit('/jshlfts32/full/bjambP/')
  	
  	page.within_frame('result') do 
  		grid_size = 3
	    fill_in('number', with: grid_size)
	    click_button('start')
	
	    cells = page.all('table td')
	    cells[0].click
	    cells[1].click
	    cells[2].click
	    cells[4].click
	    cells[5].click
	    cells[7].click

	    assert page.has_text? "Congratulations player O! You've won. Refresh to play again!"
  	end
  end
  
  def test_tie
  	visit('/jshlfts32/full/bjambP/')
  	
  	page.within_frame('result') do 
  		grid_size = 3
	    fill_in('number', with: grid_size)
	    click_button('start')
	
	    cells = page.all('table td')
	    cells[0].click
	    cells[1].click
	    cells[2].click
	    cells[3].click
	    cells[6].click
	    cells[4].click
	    cells[5].click
	    cells[8].click
	    cells[7].click

	    assert_equal page.all('#endgame').size,0
  	end
  end

end
