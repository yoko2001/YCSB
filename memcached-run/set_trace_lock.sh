#! /bin/bash

#turn off trace first
echo 0 > /sys/kernel/debug/tracing/tracing_on

#check current tracer
echo "current_tracer are belows:"
echo > /sys/kernel/debug/tracing/set_event
echo "nop" > /sys/kernel/debug/tracing/current_tracer

echo "add all lru_gen tracers below: "
echo 1 > /sys/kernel/debug/tracing/events/lru_gen/folio_lock_timer/enable
cat /sys/kernel/debug/tracing/events/lru_gen/folio_lock_timer/enable
echo 1 > /sys/kernel/debug/tracing/events/lru_gen/folio_fail_lock_timer/enable
cat /sys/kernel/debug/tracing/events/lru_gen/folio_fail_lock_timer/enable