const std = @import("std");

fn addOne(number: i32) i32 {
    return number + 1;
}

test "add" {
    try std.testing.expect(addOne(41) == 42);
}

test addOne {
    try std.testing.expect(2 * 2 == 4);
}

test "string" {
    try std.testing.expectEqualStrings("zig", &.{ 'z', 'i', 'g' });
}

test "skip" {
    return error.SkipZigTest;
}
