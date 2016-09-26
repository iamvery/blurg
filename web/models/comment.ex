defmodule Blurg.Comment do
  use Blurg.Web, :model

  schema "comments" do
    field :body, :string
    belongs_to :post, Blurg.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :post_id])
    |> validate_required([:body, :post_id])
  end
end
