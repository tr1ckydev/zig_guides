const std = @import("std");

pub fn main() !void {
    const rand = std.crypto.random;
    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);
    std.debug.print("{}\n{}\n{}\n{}\n", .{ a, b, c, d });
}
