defmodule Worker do

  def start_link do
    pid = spawn(__MODULE__, :init, [])
    IO.puts("pic of worker #{pid}")
  end
  def init() do
    CheckVampireNumber.checkVampireNumber

  end
end
