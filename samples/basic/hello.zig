// https://codeberg.org/ziglang/zig/src/branch/master/doc/langref/hello.zig

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");
    std.debug.print("Hello, {s}!\n", .{"World"});
}

// exe=succeed
