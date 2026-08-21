// IMF
const csv = @import("csv.zig")

pub fn get_imf_data(
  io: std.Io,
  allocator: std.mem.Allocator
) void {
  const csv_data = csv.get_csv_data(io, allocator, "../data/weoall.csv");
}
