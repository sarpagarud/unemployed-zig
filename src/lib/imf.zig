// IMF
const std = @import("std");
const globals = @import("globals.zig");
const csv = @import("csv.zig");

pub fn get_imf_data(
  io: std.Io,
  allocator: std.mem.Allocator
) !void {
  var buf: [256]u8 = undefined;
  const path = globals.data.get("data_path").?;
  std.debug.print("{s}\n", .{path});
  const csv_path = try std.fmt.bufPrint(&buf, "{s}{s}", .{ path, "weoall.csv" });
  std.debug.print("{s}\n", .{csv_path});
  const csv_data = try csv.get_csv_data(io, allocator, csv_path);
  for(csv_data.headers) |h| {
    std.debug.print("{s}\n", .{h});
  }
}
