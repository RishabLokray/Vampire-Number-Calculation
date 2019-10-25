defmodule CheckVampireNumber do
  @moduledoc false
  def checkVampireNumber do
    list = System.argv();
    startLimit = List.first(list)
    endLimit =  List.last(list)
    startLimit = String.to_integer(String.trim(startLimit,"\n"))
    endLimit = String.to_integer(String.trim(endLimit,"\n"))
    if startLimit>endLimit do
        raise("Start Limit must be less than or equal to end limit")
    else
       numberOfWorkers = min(10, endLimit-startLimit)
       IO.puts("Number of Workers : #{numberOfWorkers}")
       range = div(endLimit-startLimit,numberOfWorkers)+1
       #IO.puts("#{range}")
       list_of_lists = Enum.chunk_every(startLimit..endLimit, range)
       parent = self() #pid of parent
       Enum.map list_of_lists, fn z->
         start = hd(z)
         stop = Enum.at(z,-1)
         {:ok, pid} = Actor.start_link()
         spawn fn ->  Actor.vampire_numbers(pid, parent, start, stop ) end
       end
      recv(numberOfWorkers)
       end
     end


# to permutate the numbers
  def permutations([]), do: [[]]

  def permutations(numList), do:
    for number <- numList, remainingNumbers <- permutations(numList--[number]), do: [number|remainingNumbers]

  def uniq1(list), do: MapSet.new(list) |> MapSet.to_list

  def recv(count) do
   #IO.puts("#{count}")
    receive do
      {:hello,msg} -> IO.puts "#{msg}"

      if count >= 2 do
      recv(count-1)

      end
    end
  end

end

