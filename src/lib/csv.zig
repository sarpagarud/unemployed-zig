const std = @import("std");

const Csv = struct {
  headers: [][]const u8,
  rows: std.StringHashMap([]const u8),
};

pub fn get_csv_line(
  a: std.mem.Allocator,
  list: *std.ArrayList([]const u8), 
  line: []const u8
) !void {
  if (line.len == 0) return;
  var cols = std.mem.splitScalar(u8, line, ',');
  while (cols.next()) |col| {
      try list.append(a, try a.dupe(
        u8, 
        std.mem.trim(u8, col, " \r") 
      ));
  }
}

pub fn get_csv_data(
  io: std.Io,
  allocator: std.mem.Allocator,
  csv_file_path: []const u8
) !Csv {
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
  var headers: std.ArrayList([]const u8) = .empty;
  var rows = std.StringHashMap([]const u8).init(a);
  //var i: usize = 0;
  while (lines.next()) |line| {
    try get_csv_line(a, &headers, line);
    break;
  }
  while (lines.next()) |line| {
    var row: std.ArrayList([]const u8) = .empty;
    var row_map = std.StringHashMap([]const u8).init(a);
    try get_csv_line(a, &row, line);
    for (row.items, 0..) |value, j| {
      try row_map.put(headers.items[j], value);
    }
    rows.append(row_map);
  }
  return Csv{
    .headers = try headers.toOwnedSlice(),
    .rows = try rows.toOwnedSlice(),
  };
}
