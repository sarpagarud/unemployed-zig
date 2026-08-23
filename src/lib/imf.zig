// IMF
const std = @import("std");
const globals = @import("globals.zig");
const csv = @import("csv.zig");

pub fn get_imf_data(
  io: std.Io,
  allocator: std.mem.Allocator
) !void {
  const cwd = try std.process.currentPathAlloc(io, allocator);
  defer allocator.free(cwd);

  const path = globals.data.get("data_path").?;
  //var buf: [256]u8 = undefined;
  //const csv_path = try std.fmt.bufPrint(&buf, "{s}{s}", .{ path, "weoall.csv" });
  const csv_path = try std.fs.path.resolve(allocator, &.{ cwd, path, "test.csv" });
  defer allocator.free(csv_path); 
  std.debug.print("abs {s}\n", .{csv_path});
  //const csv_data = try csv.get_csv_data(io, allocator, csv_path);
  std.debug.print("{s}\n", .{"1"});
  var csv_data = try csv.get_csv_data(io, allocator, csv_path);
  defer {
    for(csv_data.headers) |h|{
      allocator.free(h);
    }
    allocator.free(csv_data.headers);
    defer {
      for(csv_data.rows.items) |*h|{
        var rit = h.iterator();
        while (rit.next()) |e| {
          allocator.free(e.value_ptr.*);
        }
        h.deinit();
      }
      csv_data.rows.deinit(allocator);
    }
    csv_data.deinit();
  }
  std.debug.print("{s}\n", .{"2"});
  
  for(csv_data.headers) |h| {
    std.debug.print("{s}\n", .{h});
  }
  for(csv_data.rows.items) |h| {
    var it = h.iterator();
    while (it.next()) |e| {
      std.debug.print("{s} = {s}\n", .{ e.key_ptr.*, e.value_ptr.* });
    }
  }
}