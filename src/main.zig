const std = @import("std");
const calculations = @import("calculations");
const imf = @import("lib/imf.zig");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");
    const v = calculations.velocity_of_money(10.0, 10.0, 10.0);
    std.debug.print("{:.2}\n", .{v});

    var args_iter = try init.minimal.args.iterateAllocator(init.gpa);
    defer args_iter.deinit();

    while (args_iter.next()) |arg| {
        std.debug.print("{s}\n", .{arg});
    }

    try imf.get_imf_data(init.io, init.gpa);

}

// exe=succeed
