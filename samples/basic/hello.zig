// https://github.com/ziglang/zig/blob/master/doc/langref/hello.zig

const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello, World!\n");
}

// exe=succeed
