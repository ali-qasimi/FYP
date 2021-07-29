# FYP
This repository contains my FYP code in MATLAB 

Files included:
- alarm.m
- network_label.m
- optimise_network.m
- Test_Network1.m
- utilisation.m

This project aims to explore how existing internet protocols can be manipulated to ensure efficient use of all links within a network so that over-utilisation and congestion can be minimised. The main focus of the project is on the Dijkstra’s shortest path algorithm, in which a packet traverses from a source node to a destination node by computing the path that results in minimal total weight. [1] An algorithm is designed that dynamically assigns weights to a selected number of links so that the shortest path for certain packets can be deviated into different routes, thus avoiding multiple transmissions occuring over the same links, which prevents over-utilisation of links and helps the network to distribute its flow of traffic across under-utilised links as well. 

MATLAB version 2018b is used to program a simulated network that randomly generates traffic with the user’s choice of scale defined by the number of active 1 GB/s connections. A monitoring system has been developed that tracks the flow of traffic and accurately computes every link’s utilisation levels throughout the simulation. An alarm system is also programmed that generates 3 levels of alarms (green, yellow and red), to indicate the status of every link’s utilisation level at any given point in time. All these systems integrate together to successfully locate every over-utilised link in the network at any given instance and implement the designed algorithm to dynamically assign weights to one or more neighbour links in the network that would result in rerouting a portion of the traffic from the over-utilised link to another link that carries lesser traffic.

The designed methodology is implemented on the simulation using topologies of real-life small and large networks; NFSNET backbone with 13 nodes and 18 links, and Telecom Italia’s backbone with 44 nodes and 71 links [2], [3]. 
