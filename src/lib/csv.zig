const std = @import("std");

const Csv = struct {
  headers: [][]const u8,
  rows: std.StringHashMap([]const u8),

  pub fn deinit(self: *Csv) void {
    self.rows.deinit();
  }
};

fn toOwnedSliceGpa(
    arena_list: *std.ArrayList([]const u8),
    //a: std.mem.Allocator,      // arena allocator (only for cleanup of the list if needed)
    gpa: std.mem.Allocator,    // destination allocator
) ![][]const u8 {
    const result = try gpa.alloc([]const u8, arena_list.items.len);
    errdefer gpa.free(result);

    var i: usize = 0;
    errdefer {
        for (result[0..i]) |s| gpa.free(s);
    }

    for (arena_list.items) |s| {
        result[i] = try gpa.dupe(u8, s);
        i += 1;
    }

    // optional: clear the arena list (arena will free the old strings anyway)
    arena_list.clearRetainingCapacity();

    return result;
}

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
  const a = allocator; //arena.allocator();
  
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
    //std.debug.print("{s}\n", .{line});
    for (row.items, 0..) |value, j| {
      try row_map.put(headers.items[j], value);
    }
    var it = row_map.iterator();
    while (it.next()) |entry| {
        const value_copy = try allocator.dupe(u8, entry.value_ptr.*);
        try rows.put(entry.key_ptr.*, value_copy);
    }
    defer {
        var rit = row_map.iterator();
        while (rit.next()) |e| {
            allocator.free(e.value_ptr.*);
        }
        row_map.deinit();
    }
  }
  std.debug.print("{s}\n", .{"x"});
  return Csv{
    .headers = try headers.toOwnedSlice(allocator),
    .rows = rows
  };
}
