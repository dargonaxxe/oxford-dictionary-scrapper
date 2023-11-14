ExUnit.start()

defmodule Oxford.LinkBuilderTest do
  use ExUnit.Case

  test "should return expected result" do
    "https://www.oxfordlearnersdictionaries.com/definition/english/riveting" =
      Oxford.LinkBuilder.create("riveting")
  end
end
