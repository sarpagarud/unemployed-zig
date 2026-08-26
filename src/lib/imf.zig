// IMF
const std = @import("std");
const globals = @import("globals.zig");
const csv = @import("csv.zig");

const zig_core = @import("zig-core");

const IMF = struct {
  arena: std.heap.ArenaAllocator,
  _csv: zig_core.csv.Csv,

  pub fn print(
    self: *const IMF, 
    key: []const u8, 
    value: []const u8
  ) !void {
    for(self._csv.rows.items) |row| {
      if (key.len != 0 and value.len != 0) {
        const cell = row.get(key) orelse return;
        if (!std.mem.eql(u8, cell, value)) continue;
      }
      const COUNTRY = row.get("COUNTRY") orelse "";
      const INDICATOR = row.get("INDICATOR") orelse "";
      const OBS_VALUE = row.get("OBS_VALUE") orelse "";
      const TIME_PERIOD = row.get("TIME_PERIOD") orelse "";
      const SCALE = row.get("SCALE") orelse "";
      const UNIT = row.get("UNIT") orelse "";
      const COUNTRY_UPDATE_DATE = row.get("COUNTRY_UPDATE_DATE") orelse "";

      const value = OBS_VALUE / std.math.pow(f64, 10.0, @floatFromInt(SCALE));
      const indicator = globals.IMF_INDICATORS.get(INDICATOR).? orelse INDICATOR;

      std.debug.print("{s}\t{s}\t{s}\t{any}\t{s}\t{s}\n", .{
        COUNTRY, indicator, TIME_PERIOD, 
        value, UNIT, COUNTRY_UPDATE_DATE
      });
    }
  }

  fn arena_allocator(self: *IMF) std.mem.Allocator {
      return self.arena.allocator();
  }

  pub fn init(
    io: std.Io,
    allocator: std.mem.Allocator
  ) !IMF {
    const arena = std.heap.ArenaAllocator.init(allocator);
    const path = globals.data.get("data_path").?;
    const cwd = try std.process.currentPathAlloc(io, allocator);
    defer allocator.free(cwd);
    const csv_path = try std.fs.path.resolve(allocator, &.{ cwd, path, "weo.csv" });
    defer allocator.free(csv_path); 
    const _csv = try zig_core.csv.Csv.init(io, allocator, csv_path);
    return .{
      .arena: arena,
      ._csv: _csv,
    } 
  }

  pub fn deinit(self *const IMF) !void {
    errdefer self._csv.deinit();
  }

};



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
  std.debug.print("{s}\n", .{"1"});
  //var csv_data = try csv.get_csv_data(io, allocator, csv_path);
  //defer {
  //  for(csv_data.headers) |h|{
  //    allocator.free(h);
  //  }
  //  allocator.free(csv_data.headers);
  //  defer {
  //    for(csv_data.rows.items) |*h|{
  //      var rit = h.iterator();
  //      while (rit.next()) |e| {
  //        allocator.free(e.value_ptr.*);
  //      }
  //      h.deinit();
  //    }
  //    csv_data.rows.deinit(allocator);
  //  }
  //  csv_data.deinit();
  //}
  //std.debug.print("{s}\n", .{"2"});
  //
  //for(csv_data.headers) |h| {
  //  std.debug.print("{s}\n", .{h});
  //}
  //for(csv_data.rows.items) |h| {
  //  var it = h.iterator();
  //  while (it.next()) |e| {
  //    std.debug.print("{s} = {s}\n", .{ e.key_ptr.*, e.value_ptr.* });
  //  }
  //}

  const _csv = try zig_core.csv.Csv.init(io, allocator, csv_path);
  defer _csv.deinit();
  try _csv.print_headers();
  //try _csv.print_rows();
  try _csv.print_rows_by_key_value("COUNTRY", "IND");

}
