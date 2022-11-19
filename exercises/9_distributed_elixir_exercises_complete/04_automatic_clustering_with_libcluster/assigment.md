# Task

Manually connecting your nodes is not something you can do in production. Hence there's a library that makes your life easier called libcluster. Here is a video that explains how it more or less works [here](https://www.youtube.com/watch?v=zQEgEnjuQsU). The information in the video is just an extra and not required for this exercise.

First make an empty mix project (with an application level supervisor):

```bash
mix new da_libcluster_test --sup
```

Add the dependency as described on [this page](https://hexdocs.pm/libcluster/readme.html).

Goal: make the exercise "03-calling-remote-genserver" again, but this time provide a supervision tree with a dynamic supervisor to support this.

* You have your application level supervisor (already generated).
* Copy the `MyBuilding` module to your `lib` folder and refactor it to `DaLibclusterTest.Mybuilding`. Also refactor it so that it uses `start_link`, as we'll use it under a supervisor.
* Configure your application level supervisor for libcluster. You can either use the Epmd strategy (manual node config) or the gossip strategy. We prefer the gossip strategy, copy the following code in your application level supervisor to configure libcluster with this strategy:

```elixir
topologies = [
      da_assignment_test: [
        strategy: Cluster.Strategy.Gossip,
      ]
    ]
    children = [
      {Cluster.Supervisor, [topologies, [name: DaLibclusterTest.ClusterSupervisor]]},
    ]
```

* By adding this configuration, nodes that runs this application wil automatically take part in the cluster. This of course assumes that all nodes run on the same network and that there are no hiccups finding each other. Since we run every node on the same local machine, this won't be an issue.
* Let your application level supervisor start a dynamic supervisor with the name `DaLibclusterTest.BuildingDynamicSupervisor`.
* There is a module called `DaLibclusterTest`. Add the following methods:
  * To add childs easily: `DaLibclusterTest.start_building/1` where the argument is the name of the building, such as ProximusBlokD.
  * To check whether a node is running the process for a specific building: `DaLibclusterTest.building_at_this_node?/1` where the argument is a building atom (use the `Process` module).
  * To retrieve the rooms for a building at a specific node: `DaLibclusterTest.get_rooms_for_building_at_node/2` where the first parameter is your building name and the second your node name.
