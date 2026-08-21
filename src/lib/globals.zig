const std = @import("std");

pub const data = std.StaticStringMap([]const u8).initComptime(.{
    .{ "data_path", "./zig-out/share/unemployed-zig/" },
});