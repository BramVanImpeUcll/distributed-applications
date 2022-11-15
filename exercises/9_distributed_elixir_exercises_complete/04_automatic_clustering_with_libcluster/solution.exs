# Node A
DaLibclusterTest.start_building(A)
DaLibclusterTest.building_at_this_node?(A)
# returns true

# Node B
DaLibclusterTest.building_at_this_node?(A)
# returns error
DaLibclusterTest.get_rooms_for_building_at_node(A, :"node1@LT2211617")
# returns result
