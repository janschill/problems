module Graph where

data Node = Node String deriving (Show, Eq)
type Weight = Integer
type Edge = ([Node], Weight)
type Graph = ([Node], [Edge])
type Queue = [Node]

a = Node "A"
b = Node "B"
c = Node "C"
d = Node "D"
e = Node "E"

edgeAB = ([a,b], 5)
edgeBB = ([b,b], 1)
edgeAC = ([a,c], 8)
edgeBC = ([b,c], 2)
edgeCD = ([c,d], 10)

g1 = ([a,b,c,d,e], [edgeAB,edgeAC,edgeBC,edgeCD])

hasEdge::Graph->Node->Node->Bool
hasEdge (_, edges) n1 n2 = hasEdge'' edges n1 n2
  where
    hasEdge'::Edge->Node->Node->Bool
    hasEdge' ([n11, n12], _) n21 n22 = n11 == n21 && n12 == n22 || n11 == n22 && n12 == n21

    hasEdge''::[Edge]->Node->Node->Bool
    hasEdge'' [] _ _ = False
    hasEdge'' (e:es) n1 n2 | hasEdge' e n1 n2 = True
                           | otherwise = hasEdge'' es n1 n2

hasNode::Graph->Node->Bool
hasNode ([], _) _ = False
hasNode (nodes, _) node = elem node nodes

addNode::Graph->Node->Graph
addNode (nodes, edges) node = ((node:nodes), edges)

addEdge::Graph->Node->Node->Weight->Graph
addEdge (nodes, edges) node1 node2 weight | hasEdge (nodes, edges) node1 node2 = (nodes, edges)
                                          | hasEdge (nodes, edges) node1 node2 == False && hasNode (nodes, edges) node1 && hasNode (nodes, edges) node2 = (nodes, ([node1, node2], weight):edges)
                                          | hasEdge (nodes, edges) node1 node2 == False && hasNode (nodes, edges) node1 == False && hasNode (nodes, edges) node2 = (node1:nodes, ([node1, node2], weight):edges)
                                          | hasEdge (nodes, edges) node1 node2 == False && hasNode (nodes, edges) node1 && hasNode (nodes, edges) node2 == False = (node2:nodes, ([node1, node2], weight):edges)
                                          | hasEdge (nodes, edges) node1 node2 == False && hasNode (nodes, edges) node1 == False && hasNode (nodes, edges) node2 == False = (node1:node2:nodes, ([node1, node2], weight):edges)
                                          | otherwise = (nodes, edges)

removeEdge::Graph->Node->Node->Graph
removeEdge graph node1 node2 | hasEdge graph node1 node2 = removeEdge' graph node1 node2
                             | otherwise = graph
                             where
                              removeEdge'::Graph->Node->Node->Graph
                              removeEdge' (nodes, edges) node1 node2 = (nodes, aux edges node1 node2)
                                where
                                  aux::[Edge]->Node->Node->[Edge]
                                  aux ((edgeNodes, weight):ens) node1 node2 | elem node1 edgeNodes && elem node2 edgeNodes = ens
                                                                            | otherwise = (edgeNodes, weight):(aux ens node1 node2)

adjacentNodes::Graph->Node->[Node]
adjacentNodes (_, edges) node = aux edges node
  where
    aux::[Edge]->Node->[Node]
    aux [] _ = []
    aux (([node1, node2], _):es) node | node1 == node = node2:(aux es node)
                                      | node2 == node = node1:(aux es node)
                                      | otherwise = aux es node

type Searched = [Node]

bfs::Graph->Node->Node->[Node]
bfs graph node1 node2 = aux graph node1 node2 (adjacentNodes graph node1) []
    where
      aux::Graph->Node->Node->Queue->Searched->[Node]
      aux _ _ _ [] _ = []
      aux graph node1 node2 (q:qs) searched | node2 == q = searched
                                            | otherwise = aux graph node1 node2 (qs ++ (filter (not . isElem searched) (adjacentNodes graph q))) (q:searched)
      isElem::Eq a=>[a]->a->Bool
      isElem list value = elem value list












