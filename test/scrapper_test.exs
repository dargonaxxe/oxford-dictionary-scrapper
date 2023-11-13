defmodule ScrapperTest do
  use ExUnit.Case
  doctest Scrapper

  test "greets the world" do
    assert Scrapper.hello() == :world
  end
end
