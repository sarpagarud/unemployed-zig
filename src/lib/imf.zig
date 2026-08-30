// IMF
const std = @import("std");
const globals = @import("globals.zig");
const csv = @import("csv.zig");

const zig_core = @import("zig-core");

const ImfData = struct {
    year: []const u8,
    gdp: f64,
    unemployment_rate: f64,
};

const ImfGraphData = struct {
    year: std.ArrayList([]const u8) = .empty,
    gdp: std.ArrayList(f64) = 0.0,
    unemployment: std.ArrayList(f64) = 0.0,
};

pub const IMF = struct {
  arena: std.heap.ArenaAllocator,
  _csv: zig_core.csv.Csv,
  status: []const u8 = "",

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
      const cell = row.get("TIME_PERIOD") orelse return;
      if (!std.mem.eql(u8, cell, "2026")) continue;
      const COUNTRY = row.get("COUNTRY") orelse "";
      const INDICATOR = row.get("INDICATOR") orelse "";
      const OBS_VALUE = row.get("OBS_VALUE") orelse "";
      const TIME_PERIOD = row.get("TIME_PERIOD") orelse "";
      const SCALE = row.get("SCALE") orelse "";
      const UNIT = row.get("UNIT") orelse "";
      const COUNTRY_UPDATE_DATE = row.get("COUNTRY_UPDATE_DATE") orelse "";
      //const UNEMPLOYMENT = row.get("UNEMPLOYMENT") orelse "";
      //_ = try std.fmt.parseFloat(f64, UNEMPLOYMENT);
      
      const country = COUNTRY;
      const indicator = globals.IMF_INDICATORS.get(INDICATOR) orelse INDICATOR;
      const scale = try std.fmt.parseInt(i32, SCALE, 10);
      var obs_value = try std.fmt.parseFloat(f64, OBS_VALUE);
      obs_value = obs_value / std.math.pow(f64, 10.0, @floatFromInt(scale));
      const time_period = TIME_PERIOD;
      const unit = UNIT;
      const country_update_date = COUNTRY_UPDATE_DATE;
      

      std.debug.print("{s}\t{s}\t{s}\t{any}\t{s}\t{s}\n", .{
        country, indicator, time_period, 
        obs_value, unit, country_update_date
      });
    }
  }

  pub fn create_svg(
    self: *IMF, 
    country_code: []const u8, 
  ) !void {
    std.debug.print("{s}\n", .{"create_svg start"});
    const allocator = self.arena_allocator();
    var data:std.ArrayList(ImfData) = .empty;
    var imf_data = ImfGraphData{};
    for(self._csv.rows.items) |row| {
      const cell = row.get("COUNTRY") orelse continue;
      if (!std.mem.eql(u8, cell, country_code)) continue;
      const COUNTRY = row.get("COUNTRY") orelse "";
      const INDICATOR = row.get("INDICATOR") orelse "";
      const OBS_VALUE = row.get("OBS_VALUE") orelse "";
      const TIME_PERIOD = row.get("TIME_PERIOD") orelse "";
      const SCALE = row.get("SCALE") orelse "";
      if(
        !std.mem.eql(u8, INDICATOR, "LUR") and 
        !std.mem.eql(u8, INDICATOR, "NGAP_NPGDP")
      ) continue;
      
      const country = COUNTRY;
      const indicator = globals.IMF_INDICATORS.get(INDICATOR) orelse INDICATOR;
      const scale = try std.fmt.parseInt(i32, SCALE, 10);
      var obs_value = try std.fmt.parseFloat(f64, OBS_VALUE);
      obs_value = obs_value / std.math.pow(f64, 10.0, @floatFromInt(scale));
      const time_period = TIME_PERIOD;
      _ = indicator;
      _ = country;

      std.debug.print("{s} {s} {any}\n", .{time_period, INDICATOR, obs_value});

      if(std.mem.eql(u8, INDICATOR, "LUR")) {
        imf_data.unemployment.append(allocator, obs_value);
      }
      if(std.mem.eql(u8, INDICATOR, "NGAP_NPGDP")) {
        imf_data.gdp.append(allocator, obs_value);
      }
      if(std.mem.eql(u8, INDICATOR, "LUR")) {
        imf_data.year.append(allocator, time_period);
      }

      try data.append(allocator, .{
        .year = time_period,
        .gdp = 0.0,
        .unemployment_rate = obs_value,
      });

    }
    try self.create_svg_content(data, imf_data);
    std.debug.print("{s}\n", .{"create_svg end"});
  }

  pub fn create_svg_content(
    self: *IMF, 
    data: std.ArrayList(ImfData),
    imf_data: ImfGraphData,
  ) !void {
    std.debug.print("{s}\n", .{"create_svg_content"});
    //const allocator = self.arena_allocator();
    //_ = self;
    //_ = data;
    // SVG canvas size
    const width: f64 = 900;
    const height: f64 = 620;
    const margin_left: f64 = 80;
    const margin_right: f64 = 40;
    const margin_top: f64 = 60;
    const margin_bottom: f64 = 80;

    const plot_w = width - margin_left - margin_right;
    const plot_h = height - margin_top - margin_bottom;

    // Data ranges (with padding)
    const gdp_min: f64 = -3.0;
    const gdp_max: f64 = 7.0;
    const unemp_min: f64 = 2.5;
    const unemp_max: f64 = 10.5;

    // Helper: map data → SVG coordinates
    const mapX = struct {
        fn f(v: f64) f64 {
            return margin_left + (v - gdp_min) / (gdp_max - gdp_min) * plot_w;
        }
    }.f;

    const mapY = struct {
        fn f(v: f64) f64 {
            return margin_top + (unemp_max - v) / (unemp_max - unemp_min) * plot_h;
        }
    }.f;

    _ = mapX;

    _ = mapY;

    std.debug.print("{d}\n", .{data.items.len});

    for(data.items) |e| {
      std.debug.print("{s} {any} {any}\n", .{
        e.year, e.unemployment_rate, e.unemployment_rate
      });
    }

    std.debug.print("{s}\n", .{"----------"});
    for(imf_data.gdp.items, 0..) |v, i| {
      std.debug.print("{d}. {any}\n", .{i+1, v});
    }


    const svg = try self.get_svg(width, height);

    var threaded: std.Io.Threaded = .init_single_threaded;
    const io = threaded.io();
    try std.Io.Dir.cwd().writeFile(io, .{
      .sub_path = "./g.svg",
      .data = svg,
    });
  }

  pub fn get_svg(
    self: *IMF, 
    width: f64,
    height: f64
  ) ![]const u8 {
    const allocator = self.arena_allocator();
    const background = std.fmt.allocPrint(allocator,
      \\<rect x="{d}" y="{d}" width="{d}" height="{d}" fill="#ffffff" stroke="#ddd" stroke-width="1"/>
      ,.{0, 0, width, height}
    ) catch unreachable;

    const data = std.fmt.allocPrint(allocator,
      \\<circle cx="{d:.1}" cy="{d:.1}" r="7" class="point"/>
      ,.{1, 1}
    ) catch unreachable;


    const svg = std.fmt.allocPrint(allocator,
      \\<?xml version="1.0" encoding="UTF-8"?>
      \\<svg xmlns="http://www.w3.org/2000/svg" width="{d}" height="{d}" viewBox="0 0 {d} {d}">
      \\{s}
      \\<g>{s}</g>
      \\</svg>
      ,.{width, height, width, height, background, data}
    ) catch unreachable;

    return svg;
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
    //try _csv.test_create_csv(io, allocator, csv_path);
    var imf = IMF{
      .arena = arena,
      ._csv = _csv,
    };
    imf.status = "loaded";
    return imf;
  }

  pub fn deinit(self: *const IMF) void {
    defer self._csv.deinit();
    defer self.arena.deinit();
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
