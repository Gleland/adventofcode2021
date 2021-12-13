# solution inspired by https://github.com/SnoozeySleepy/AdventofCode/blob/main/day12.py
#
# enable the special condition, one small cave can be visited twice, with part2=True
def depth_first_search(graph, start, _end, path, part2)
  path << start
  if start == _end
    # found a path to end
    return [path]
  end
  paths = []
  graph[start].each do |node|
    # part 1: small caves can only be visited once, large caves indefinitely
    if !path.include? node or node.downcase != node
      paths += depth_first_search(graph, node, _end, path.dup, part2)
    # find additional paths for part 2
    elsif path.include? node and node.downcase == node and part2 and node != "start"
      paths += depth_first_search(graph, node, _end, path.dup, false)
    end
  end
  return paths
end

caves = {}
relations = File.read('input').split("\n")
relations.each do |line|
  locs = line.split('-')
  if caves[locs[0]].nil?
    caves[locs[0]] = []
  end
  caves[locs[0]] << locs[1]
  if caves[locs[1]].nil?
    caves[locs[1]] = []
  end
  caves[locs[1]] << locs[0]
end

result = depth_first_search(caves, 'start', 'end', path=[], part2=false)
# 4241
pp "Part 1: #{result.size}"

result = depth_first_search(caves, 'start', 'end', path=[], part2=true)
# 122134
pp "Part 2: #{result.size}"



