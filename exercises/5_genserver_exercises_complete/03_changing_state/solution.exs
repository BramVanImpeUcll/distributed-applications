Code.compile_file("solution.ex")

BuildingManager.start()

BuildingManager.list_rooms(BuildingManager)
# This should return an empty list

BuildingManager.add_room(BuildingManager, :d224, 6)
%{d224: 6} = BuildingManager.list_rooms(BuildingManager)

BuildingManager.delete_room(BuildingManager, :d224)
false = BuildingManager |> BuildingManager.list_rooms() |> Map.has_key?(:d224)
