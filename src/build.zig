const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const calculations = b.createModule(.{
        .root_source_file = b.path("lib/calculations.zig"),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = "main",
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "calculations", .module = calculations },
            },
        }),
    });

    const zig_core = b.dependency("zig_core", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("zig-core", zig_core.module("zig_core"));

    b.installArtifact(exe);
    b.installDirectory(.{
        .source_dir = b.path("data"),
        .install_dir = .prefix,
        .install_subdir = "share/unemployed-zig",
    });
}

// syntax
