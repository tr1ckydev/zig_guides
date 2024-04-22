const std = @import("std");

pub fn main() void {
    var buffer: [std.crypto.hash.sha2.Sha256.digest_length]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash("some data here", &buffer, .{});
    std.debug.print("{s}\n", .{std.fmt.bytesToHex(buffer, .lower)});
}
