defmodule HelloWeb.CMS.PageView do
  use HelloWeb, :view

  alias Hello.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end
end
