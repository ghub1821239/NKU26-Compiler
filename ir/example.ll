; SysY runtime declarations
declare i32 @getint()        ;函数名：getint；无参数；返回值：i32
declare void @putint(i32)
declare void @putch(i32)

define i32 @calc(i32 %n) {   ;@ ：全局范围  % ：函数内部
entry:
    %n.addr = alloca i32
    %i = alloca i32
    %sum = alloca i32

    store i32 %n, ptr %n.addr
    store i32 1, ptr %i
    store i32 0, ptr %sum

    br label %while.cond
while.cond:
    %i.val = load i32, ptr %i
    %n.val = load i32, ptr %n.addr
    %while.cmp = icmp sle i32 %i.val, %n.val
    br i1 %while.cmp, label %while.body, label %while.end
while.body:
    %rem = srem i32 %i.val, 2
    %is.even = icmp eq i32 %rem, 0
    br i1 %is.even, label %if.then, label %if.else

if.then:
    %sum.then.old = load i32, ptr %sum
    %double.i = mul i32 %i.val, 2
    %sum.then.new = add i32 %sum.then.old, %double.i
    store i32 %sum.then.new, ptr %sum
    br label %if.end

if.else:
    %sum.else.old = load i32, ptr %sum
    %sum.else.new = sub i32 %sum.else.old, %i.val
    store i32 %sum.else.new, ptr %sum
    br label %if.end

if.end:
    %i.old = load i32, ptr %i
    %i.next = add i32 %i.old, 1
    store i32 %i.next, ptr %i
    br label %while.cond

while.end:
    %result = load i32, ptr %sum
    ret i32 %result
}

define i32 @main() {
entry:
    %n = alloca i32
    %ans = alloca i32

    %input = call i32 @getint()
    store i32 %input, ptr %n

    %n.val = load i32, ptr %n
    %calc.result = call i32 @calc(i32 %n.val)
    store i32 %calc.result, ptr %ans

    %ans.val = load i32, ptr %ans
    call void @putint(i32 %ans.val)
    call void @putch(i32 10)

    ret i32 0
}