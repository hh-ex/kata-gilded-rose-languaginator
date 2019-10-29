defmodule LanguaginatorTest do
  use ExUnit.Case
  doctest Languaginator

  test "classifies texts" do
    assert Languaginator.classify(File.read!("./test/de.txt")) == :de
    assert Languaginator.classify(File.read!("./test/fr.txt")) == :fr
    assert Languaginator.classify(File.read!("./test/en.txt")) == :en
  end
end
