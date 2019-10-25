defmodule Actor do
  @moduledoc false
use GenServer, restart: :transient
  #client
  def start_link do
    GenServer.start_link(__MODULE__, [])

  end


  def vampire_numbers(pid, parent, start, stop) do
    GenServer.cast(pid, {:vampire_numbers, parent, start, stop})
  end

  #server
  def init(msgs) do
    {:ok, msgs}
  end

  def handle_cast({:vampire_numbers, parent,start,stop}, _msgs) do

    #IO.puts "#{start} #{stop}"

    msg = [] ++ Enum.map start..stop, fn  n ->
    #vampire logic
    length = String.length(Integer.to_string(n))
    if length > 2 && rem(length,2)==0  do
      #IO.puts("qq")
      permutations = CheckVampireNumber.permutations(Integer.to_charlist(n))
      permutations = CheckVampireNumber.uniq1(permutations)
      #IO.inspect permutations
      fang_list = [] ++ Enum.map permutations, fn i ->

        flang1 = rem(List.to_integer(i),:math.pow(10,div(length,2))|>round)
        flang2 = div(List.to_integer(i),:math.pow(10,div(length,2))|>round)
        if rem(flang1,10) != 0  || rem(flang2,10)!=0 do
          product = flang1*flang2
          if(product ==n && flang1<flang2) do
            #IO.inspect flang1
            "   #{flang1}   #{flang2}   "

          end
        end
      end

      fang_list = Enum.filter(fang_list, ( & !is_nil(&1)) )
      if fang_list != [] do

      fang_list = ["#{n}"] ++ fang_list
        fang_list = Enum.join Enum.filter fang_list, ( & !is_nil(&1) )
        " #{fang_list}\n"
      end
      end


     end
     msg = Enum.filter(msg, ( & !is_nil(&1)) )
      if msg != [] do
         msg =  Enum.join Enum.filter msg, ( & !is_nil(&1) )
         msg= msg |> String.slice(0..-2)

         send parent,{:hello,msg}
       end
    {:noreply, start}
  end


  # to permutate the numbers
  def permutations([]), do: [[]]

  def permutations(numList), do:
    for number <- numList, remainingNumbers <- permutations(numList--[number]), do: [number|remainingNumbers]

  def uniq1(list), do: MapSet.new(list) |> MapSet.to_list

end