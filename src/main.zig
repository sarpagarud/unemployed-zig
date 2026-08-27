const std = @import("std");
const calculations = @import("calculations");
const imf = @import("lib/imf.zig");
const zig_core = @import("zig-core");

pub fn main(init: std.process.Init) !void {
    //try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");
    //const v = calculations.velocity_of_money(10.0, 10.0, 10.0);
    //std.debug.print("{:.2}\n", .{v});

    //var args_iter = try init.minimal.args.iterateAllocator(init.gpa);
    //defer args_iter.deinit();

    //while (args_iter.next()) |arg| {
    //    std.debug.print("{s}\n", .{arg});
    //}

    //const home = init.environ_map.get("HOME") orelse "(no HOME)";
    //std.debug.print("home: {s}\n", .{home});
    //_ = try imf.get_imf_data(init.io, init.gpa);

    var _imf = try imf.IMF.init(init.io, init.gpa);
    defer _imf.deinit();
    try _imf.print("COUNTRY", "IND");
    try _imf.create_svg("IND");
    
    std.debug.print("{d}\n", .{zig_core.add(1, 2)});

    try zig_core.hello();

}

// exe=succeed
