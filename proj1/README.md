# Project 1

**Gloria Nazareth; UFID: 8221 8035**

**Rishab Lokray; UFID: 9357 3447**

## Steps to run code
Go into the directory proj1 and run the following commmand
```elixir
time mix run test.ex <startlimit> <endlimit>
```
##Number of Workers created
```elixir
8 Workers created
numberOfWorkers = min(8, endLimit-startLimit)

```


##Size of each work unit
```elixir
range = div(endLimit-startLimit,numberOfWorkers)+1
list_of_lists = Enum.chunk_every(startLimit..endLimit, range)

#Since each process runs on single core, we can have a maximum of 8 simultaneous processes running on the machine.
#Increasing the number of processes will slow down the process

```

##The result <100000> to <200000>


Number of vampire numbers: 57

CPU cores: 3.6 

Times: real- 0m48.3secs;
       user- 2m50.808secs;
       sys-  0m6.98secs;


##Largest problem solved
EndLimit: 10,000,000

