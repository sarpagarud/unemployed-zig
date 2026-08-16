const std = @import("std");
const calculations = @import("calculations");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");
    const v = calculations.velocity_of_money(10.0, 10.0, 10.0);
    std.debug.print("{:.2}\n", .{v});
}

// exe=succeed
