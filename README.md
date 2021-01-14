# Knights Travails
  Knights Travails involes determining the **shortest path** from point A to B for a chess knight. This program allows me to practise with **graphs**, which is another data structure. Up until this point I have used [Binary Search Trees](https://github.com/qamk/binary-search-tree-top), [Linked Lists](https://github.com/qamk/linked-list-top) and queues. Live program on [Repl.it](https://repl.it/@qamk/knights-travails-top#README.md).
  Onto the tasks!

## Files
  **main.rb** is the CLI for the program (run this)
  **lib/knight.rb** describes the knight and creation of a graph in the context of a knight
  **lib/mechanics.rb** other interactions with the graph (and knight) e.g. converting cells to labels and vice-versa
  **lib/board.rb** defines the board
  **lib/graph.rb** defines the graph with an adjacency list

## Aim and Tasks
  So the aim is fairly simple. A program that one of the possible ways to get from point A to B for Mr/Ms Knight. As for specific tasks these are to:
  - [x] Use a graph to represent each square and squares connected to it by valid knight moves (L-shaped moves)
    - [x] Represent as either: an edgelist, adjacency marix or adjacency list (chosen)
  - [x] Use a previously learnt tree traversal method to enable finding the shortest path
    - (Breadth First Traversal chosen)
  - [x] (Optional) Implement the program as a script or (more-or-less) friendly CLI program (chosen)
  - [] (Optional) Use both traversal methods
  - [] (Optional) Use another representation for the graph
    - Not a fan of using an edgelist; an adjacency matrix is alright due to the undirected and dense graph, however its main strength seems to lie in querying
    - Parsing neighbours seems better with the adjacency list in this case (correct me if I'm wrong) which might not matter now but the decision making is important for other tasks
  - [x] (Optional) COLOUR
  - [] Fix shortest path algorithm by checking more of the search space

## Final comments and resources used
  Overall this was fairly simple, the main annoyance was "cleaning" the data from the search in order to get the shortest path. This was done by checking "parent" neighbours. While I am confident in my reasoning I am not as confident how I coded it but it works! I can revise it at another time if I feel like it. It was interesting learning to apply these data types in Ruby!
  As for resources, the main ones were:
  - [Khan Academy](https://www.khanacademy.org/computing/computer-science/algorithms/graph-representation/a/representing-graphs)
    - This was a great help in understanding graphs (I did the tasks as well)
  - [Wikipedia/Wikiwand --> Adjacency Lists](https://www.wikiwand.com/en/Adjacency_list)
    - Useful for learning about some of the features of adjacency lists vs adjacency matrices in more detail (mostly knowledge consolidation)
    - Also the wikipedia for graphs in general was useful to check my Graph class
  - [Git: commit and push file removal (superuser.com)](https://superuser.com/questions/918317/how-to-delete-remove-files-from-a-pushed-commit)
    - So I decided to move files into a lib/ directory and needed to commit the "deleted" changes, whereupon this proved helpful
  
  Thanks for reading, hope the resources help and let me know if you spot ways for me to improve.