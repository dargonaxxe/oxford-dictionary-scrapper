ExUnit.start()

defmodule Oxford.LinkBuilder.FromFileTest do
  use ExUnit.Case

  test "should produce expected result" do
    [
      "https://www.oxfordlearnersdictionaries.com/definition/english/test",
      "https://www.oxfordlearnersdictionaries.com/definition/english/another one",
      "https://www.oxfordlearnersdictionaries.com/definition/english/hehe",
      "https://www.oxfordlearnersdictionaries.com/definition/english/haha",
      "https://www.oxfordlearnersdictionaries.com/definition/english/hoho\n"
    ] = Oxford.LinkBuilder.from_file!("test/res/oxford_link_builder_from_file.input")
  end
end
