const std = @import("std");

pub fn get_csv_line(list: *std.ArrayList([]const u8), line: []const u8) void {
  if (line.len == 0) return;
  var cols = std.mem.splitScalar(u8, line, ',');
  while (cols.next()) |col| {
      try list.append(try a.dupe(
        u8, 
        std.mem.trim(u8, col, " \r") 
      ));
  }
}

pub fn get_csv_data(
  io: std.Io,
  allocator: std.mem.Allocator,
  csv_file_path: []const u8
)  {
  var arena = std.heap.ArenaAllocator.init(allocator);
  defer arena.deinit();
  const a = arena.allocator();
  
  const csv_text = try std.Io.Dir.cwd().readFileAlloc(
    io,
    csv_file_path,
    a,
    .unlimited,
  );
  // defer allocator.free(csv_text);

  var lines = std.mem.splitScalar(u8, csv_text, '\n');
  var headers = std.ArrayList([]const u8).init(a);
  var rows = std.ArrayList([]const u8).init(a);
  var i: usize = 0;
  for (lines) |line| {
    get_csv_line(headers, line);
    break;
  }
  while (lines.next()) |line| {
    var row = std.ArrayList([]const u8).init(a);
    var row_map = std.StringHashMap([]const u8).init(a);
    get_csv_line(row, line);
    var j: usize = 0;
    while (row) |value| : (j += 1) {
      try row_map.put(headers[j], value);
    }
    rows.append(row_map);
  }
}
