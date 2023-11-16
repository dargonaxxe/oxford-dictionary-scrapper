ExUnit.start()

defmodule Reword.CsvFormatterTest do
  use ExUnit.Case

  @actual_output_path "tmp/reword_csv_formatter_from_json.output"
  @expected_output """
  "upfront";"/ˌʌpˈfrʌnt/";"not trying to hide what you think or do";"He's been upfront about his intentions since the beginning.";""
  "upfront";"/ˌʌpˈfrʌnt/";"paid in advance, before other payments are made";"There will be an upfront fee of 4%.";""
  "multitudinous";"/ˌmʌltɪˈtuːdɪnəs/";"extremely large in number"
  "insistence";"/ɪnˈsɪstəns/";"an act of demanding or saying something clearly and refusing to accept any opposition or excuses";"At her insistence, the matter was dropped.";"";"their insistence on strict standards of behaviour";"";"No one was convinced by his insistence that he was not to blame.";""
  """
  test "should return expected values" do
    :ok =
      Reword.CsvFormatter.from_json(
        "test/res/reword_csv_formatter_from_json.input",
        @actual_output_path
      )

    actual_output = File.read!(@actual_output_path)
    assert format(actual_output) == format(@expected_output)
  end

  defp format(content) do
    String.split("\n")
    |> Enum.map(&String.trim/1)
    |> MapSet.new()
  end
end
