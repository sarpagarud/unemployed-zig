# Basic hello world

```zig
const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello, World!\n");
}

// exe=succeed
```

```
// exe=succeed Compile as an executable and expect it to run successfully (exit code 0)
// exe=fail Compile as an executable and expect it to fail at runtime
// exe=build_fail Expect the code to fail to compile
// test Run the example as a unit test
```
