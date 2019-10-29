defmodule Languaginator do
  @de %{
    a: 6.51,
    b: 1.89,
    c: 3.06,
    d: 5.08,
    e: 17.40,
    f: 1.66,
    g: 3.01,
    h: 4.76,
    i: 7.55,
    j: 0.27,
    k: 1.21,
    l: 3.44,
    m: 2.53,
    n: 9.78,
    o: 2.51,
    p: 0.79,
    q: 0.02,
    r: 7.00,
    s: 7.27,
    t: 6.15,
    u: 4.35,
    v: 0.67,
    w: 1.89,
    x: 0.03,
    y: 0.04,
    z: 1.13
  }

  @eng %{
    a: 8.167,
    b: 1.492,
    c: 2.782,
    d: 4.253,
    e: 12.702,
    f: 2.228,
    g: 2.015,
    h: 6.094,
    i: 6.966,
    j: 0.153,
    k: 0.772,
    l: 4.025,
    m: 2.406,
    n: 6.749,
    o: 7.507,
    p: 1.929,
    q: 0.095,
    r: 5.987,
    s: 6.327,
    t: 9.056,
    u: 2.758,
    v: 0.978,
    w: 2.360,
    x: 0.150,
    y: 1.974,
    z: 0.074
  }

  @fr %{
    a: 7.636,
    b: 0.901,
    c: 3.260,
    d: 3.669,
    e: 14.715,
    f: 1.066,
    g: 0.866,
    h: 0.737,
    i: 7.529,
    j: 0.545,
    k: 0.049,
    l: 5.456,
    m: 2.968,
    n: 7.095,
    o: 5.378,
    p: 3.021,
    q: 1.362,
    r: 6.553,
    s: 7.948,
    t: 7.244,
    u: 6.311,
    v: 1.628,
    w: 0.114,
    x: 0.387,
    y: 0.308,
    z: 0.136
  }

  @languages %{
    de: @de,
    en: @eng,
    fr: @fr
  }

  def classify(input) do
    input = input_frequency(input)

    @languages
    |> Enum.map(fn {lang, freq} ->
      {lang, distance(freq, input)}
    end)
    |> Enum.sort_by(&elem(&1, 1))
    |> List.first()
    |> elem(0)
  end

  def input_frequency(input) do
    input =
      input
      |> String.downcase()
      |> String.replace(~r/[^a-z]/, "")

    len = String.length(input)

    input
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn letter, acc ->
      letter = List.to_string([letter])
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
    |> Enum.map(fn {letter, count} -> {letter, count / len * 100} end)
    |> Enum.into(%{})
  end

  def distance(a, b) do
    for letter <- ?a..?z do
      letter = List.to_string([letter])
      freq_a = Map.get(a, String.to_atom(letter))
      freq_b = Map.get(b, letter, 0)

      :math.pow(freq_a - freq_b, 2)
    end
    |> Enum.sum()
  end
end
