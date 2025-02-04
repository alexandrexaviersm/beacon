defmodule Beacon.Types.Site do
  @moduledoc """
  Sites are identified as atoms and stored as string in the database.
  """

  use Ecto.Type

  @typedoc """
  Atom to identify a site, eg: `:my_site`
  """
  @type t :: atom()

  @doc """
  Returns `true` if `site` is valid, otherwise returns `false`.

  A site is valid if it's a atom with no special characters, except `_`.

  ## Examples

      iex> valid?(:my_site)
      true

      iex> valid?(:"my-site!")
      false

  """
  def valid?(site) when site in ["", nil, true, false], do: false

  def valid?(site) when is_binary(site) do
  end

  def valid?(site) when is_atom(site) do
    site = Atom.to_string(site)
    Regex.match?(~r/^[a-zA-Z0-9_]+$/, site)
  end

  def valid?(_site), do: false

  @doc false
  def safe_to_atom(site) when is_atom(site), do: site
  def safe_to_atom(site) when is_binary(site), do: String.to_existing_atom(site)

  @doc false
  def type, do: :atom

  @doc false
  def cast(:any, site) when is_binary(site), do: {:ok, String.to_existing_atom(site)}
  def cast(:any, site) when is_atom(site), do: {:ok, site}
  def cast(:any, _), do: :error

  @doc false
  def cast(site) when is_binary(site), do: {:ok, String.to_existing_atom(site)}
  def cast(site) when is_atom(site), do: {:ok, site}
  def cast(_), do: :error

  @doc false
  def load(site) when is_binary(site), do: {:ok, String.to_existing_atom(site)}

  @doc false
  def dump(site) when is_binary(site), do: {:ok, site}
  def dump(site) when is_atom(site), do: {:ok, Atom.to_string(site)}
  def dump(_), do: :error
end
