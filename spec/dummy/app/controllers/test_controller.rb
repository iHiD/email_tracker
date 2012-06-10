class TestController < ApplicationController
  def test
    render :text => "Foobar"
  end
end