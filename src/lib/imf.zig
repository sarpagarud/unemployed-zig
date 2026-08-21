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
  const csv_path = try std.fs.path.resolve(allocator, &.{ cwd, path, "weo.csv" });
  defer allocator.free(csv_path); 
  std.debug.print("abs {s}\n", .{csv_path});
  //const csv_data = try csv.get_csv_data(io, allocator, csv_path);
  _ = try csv.get_csv_data(io, allocator, csv_path);
  //defer csv_data.deinit();
  //for(csv_data.headers) |h| {
  //  std.debug.print("{s}\n", .{h});
  //}
}