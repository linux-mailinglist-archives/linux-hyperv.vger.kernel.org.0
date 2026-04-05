Return-Path: <linux-hyperv+bounces-9997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAlLOc7d0mmAbwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9997-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 00:10:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3B39FF49
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55623006942
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Apr 2026 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7B382F02;
	Sun,  5 Apr 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP1YSvBt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE192F1FC9
	for <linux-hyperv@vger.kernel.org>; Sun,  5 Apr 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775427020; cv=pass; b=RTagne+q+jX9VukxgP33EfzU8WY9eAI1G7R0DjjJekiz+6BJM8q0hX8lIqT+T6p+veEZ2ZYeRea8oB61DM3Rs+VU1AHj/+Vc1OFmCEAkQHUtWkWZEAu4+gW0xegqnz8uFABlGxHFbM7GWGGPBTZVrXBrs6uNIGuHJsTQA0FdTEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775427020; c=relaxed/simple;
	bh=ABUjEWGDZYHREqnQ0FoQ2NGfgCH18iC9mDSHCs7Bdws=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cHLUHg5qErQbsZE1zFwAzP3R15/dTeDm+HUGbDmksQANMvoZFDGHO5fsU5FqqLjNgedWX42ZZTbHLi8YKaFq1nbe/cbVOyT6bj5f0I+VZ18hJh7AVlJVsTIJbRM+sPfCcUAvMvbovgeQ1HBR312lwuZGcSgXqMYMdhm+rE2I0y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP1YSvBt; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1117322a12.3
        for <linux-hyperv@vger.kernel.org>; Sun, 05 Apr 2026 15:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775427018; cv=none;
        d=google.com; s=arc-20240605;
        b=VA5Bdk/28xEuiZ3/y/g3jzucNn37Y4eLYkUXXhTwCG5vIYMlDRTNPZ0zrL88H9sB49
         N6hcEjI6WzoEkGIZJcfPTk7dzjQcqj05V2iVuM/qOQ23xtOAGKozIR7wkYV3AURyGfSV
         urOqRsnat8NGPyKIYy73Y6WFvWM6Jl3VthxNGBZrC9qi0dk5Gc1X8o5ay2ZVnP+ruGZx
         94/F+tKGTqmskYt4M0B1UI1X2BiM/VxMqaLOK3RCIiH3OhDv1LE8x+REGIUNF3/ZkOD0
         LF+9e6jfdKVImQ6cLdD/wdgy+0zWMUF/2rqmwc+TjXDnf4VI3ozYA+WTL3bz9f4rGFww
         IVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=e9u+QzC2aJqKtNe3/rtmBsCiYMsv2LB2s8cYUNUD6G0=;
        fh=JZoITFd5uHibZ6ssBBHktwK8alAZTzDXbDxXh5gMVrQ=;
        b=kC7f0F0cJ4x72E2OZszRcNIcqCrYb5yrAXTW/er09GH/JeClgv7LH54wAZ0y+AAsHL
         ozg05A1p8FJ4uW6dZxxw1p2TspFR7Gmdtw/Zr7rajW+03XK1BbDK19pcyoB4JuWv2hOS
         bVyMwY6buTWYJTJwK7BD9SSot09207qIho+B2zZoNQgP8UhmtUAgMtNLUDcXCL3eSCqQ
         KWp2ek1bS9G4OpoTitEr691bGB7qNzuFNRfKHhOw3n77fHHfNmqnltL7cdbdNGYbqOeZ
         ENgLCjzqnCzxlAHZczVb+5EwGAjutl2TZ2nUXJWzUC5ga5yXFArzAWPxXrGfPMexlr9P
         q92g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775427018; x=1776031818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e9u+QzC2aJqKtNe3/rtmBsCiYMsv2LB2s8cYUNUD6G0=;
        b=iP1YSvBtoOu9bqPRdP3j8rrFjtR46+1xrjNJyNNgsJK/ZaJ4Rnvf7uAciI35pHPhpE
         1AyGVy/XOlndXLfMtKF9OC9TLQpcDE9w7MV5dnUbv8cdJ8dcQA6shl2S02uGwm4WwMdV
         /aTpPh8WZDNfiIRxVhdzO3EUYUazWVE1MMrEUHvGI4KWU11GeDsVehSBlatcTUbzssMI
         TvPgsW93MzJf/uD+ObD3lwYwC6NL2JgzPUtN6mBuXBoGzlOmyKdMfDL67wF1w8Ihh3/m
         d98Pz89ldzmzE1cXw9jMtWKAOyatyXFwRGrn3UOMXFNvy+tBTftXmmTjnBEPZzrC8vL6
         sMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775427018; x=1776031818;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9u+QzC2aJqKtNe3/rtmBsCiYMsv2LB2s8cYUNUD6G0=;
        b=Ka68W9BRtvk/KEfzmeMtg4TCqKeGXWCXvZQqhxo6SIYCMOIVwqmDwGBruCHfiP49Iz
         bfjRPvAcTOiFb5lBQ2ad6+69dr8KPJWjDn1ASP8KiDwRd5T88NTFs+NcjQimZSEInUYb
         K2IbGRr/YXh6feD/dflnXtHSpaKauSLgurnxce8DSOQeZy3OWjKnKnnmvRrOyN87t9/N
         FM3sVK50EFmkEZOcXj2VmZE7mPSpZ6E7MncG52FMvikO1c1wVHwPU1n0faX6GH1Q7EeQ
         l6nQuwHbiClfZ0efmCMWjOWlSmsTG96Rv24nG2oVh4JvaswUMNUs0FRKWIlUqVCu1zui
         yrRg==
X-Forwarded-Encrypted: i=1; AJvYcCXhEvg5qChumNe+BkzYfIMboI/eP+so+iGnIOEw5hj61pGOlmgw33nzuqeQbBpMD444QlEWKm291IhQ4nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh03LcE9jo4heG04x9YBb2cv2fVSif1B3MSkBAA8JCvU9rcZ0a
	/In9iidCb9JDK0vN1vR4qeVK4kl0Wr9WgMmnrlG8KYPFqlpmzQv7bRdc/7kPsmtWU4LcY762GTt
	1HdWqN5TFDIXJWDS18dHPZ+c78ckZLcM=
X-Gm-Gg: AeBDiev1PrgAPpUBfMjcpo+sJcSmoo3XJiEt/mFNGZ506fsG2cCiGe18+tg0eiI0dAp
	sDXTZzlHYQfMy1TwSceJyfnxFKQsGv2btozpR9ikZeu3y/iDEqquXcC/Cp5NoA6PhRoCzbw3Dop
	sbcyqhbmj9DuzQe+l23BcB7x1fh05nC0jtzrYfmQiDJaZjh9qrSKynP/PtBjTKuYck1inUsvnEv
	H+mr7eoYPf7vuUdUhlB6MKR3VNRwaEziuPlTHZeSim4k1fuFGbcXg4qjw1X2lRjDFoEy1VYYkY0
	XR/bHQWOnd8qVHkMSIQ5aoL8W7P2zSSBdeyUcCVdwkogpS7aAsc=
X-Received: by 2002:a05:6a20:12c5:b0:39c:4af6:4305 with SMTP id
 adf61e73a8af0-39f2ef776f8mr10913190637.10.1775427018045; Sun, 05 Apr 2026
 15:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Date: Sun, 5 Apr 2026 15:10:07 -0700
X-Gm-Features: AQROBzBRYTfs3R9pignNAUl0z7_W9YKD9Yw5QkOdj1ny5dpfRahj1Q-2xMfYdFA
Message-ID: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
Subject: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt due
 to cross-CPU raw TSC inconsistency
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9997-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomaslefebvre3@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 48A3B39FF49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I'm seeing KVM_GET_CLOCK return values ~253 years in the future when
running KVM inside a Hyper-V VM (nested virtualization).  I tracked
it down to an unsigned wraparound in __get_kvmclock() and have
bpftrace data showing the exact failure.

Setup:
  - Intel i7-11800H laptop running Windows with Hyper-V
  - L1 guest: Ubuntu 24.04, kernel 6.8.0, 4 vCPUs
  - Clocksource: hyperv_clocksource_tsc_page (VDSO_CLOCKMODE_HVCLOCK)
  - KVM running inside L1, hosting L2 guests

Root cause:

__get_kvmclock() does:

    hv_clock.tsc_timestamp = ka->master_cycle_now;
    hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
    ...
    data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);

and __pvclock_read_cycles() does:

    delta = tsc - src->tsc_timestamp;    /* unsigned */

master_cycle_now is a raw RDTSC captured by
pvclock_update_vm_gtod_copy().  host_tsc is a raw RDTSC read by
__get_kvmclock() on the current CPU.  Both go through the vgettsc()
HVCLOCK path which calls hv_read_tsc_page_tsc() -- this computes a
cross-CPU-consistent reference counter via scale/offset, but stores
the *raw* RDTSC in tsc_timestamp as a side effect.

Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
The hypervisor corrects them only through the TSC page scale/offset.
If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
later runs on CPU 1 where the raw TSC is lower, the unsigned
subtraction wraps.

I wrote a bpftrace tracer (included below) to instrument both
functions and captured two corruption events:

  Event 1:

    [GTOD_COPY] pid=2117649 cpu=0->0 use_master=1
                mcn=598992030530137 mkn=259977082393200

    [GET_CLOCK] pid=2117649 entry_cpu=1 exit_cpu=1 use_master=1
      clock=8006399342167092479 host_tsc=598991848289183
      master_cycle_now=598992030530137
      system_time(mkn+off)=5175860260
      TSC DEFICIT: 182240954 cycles

    master_cycle_now captured on CPU 0, host_tsc read on CPU 1.
    CPU 1's raw RDTSC was 182M cycles lower.

      598991848289183 - 598992030530137 = 18446744073527310662 (u64)

    Returned clock: 8,006,399,342,167,092,479 ns (~253.7 years)
    Correct system_time: 5,175,860,260 ns (~5.2 seconds)

  Event 2:

    [GTOD_COPY] pid=2117953 cpu=0->0 use_master=1
                mcn=599040238416510

    [GET_CLOCK] pid=2117953 entry_cpu=3 exit_cpu=3 use_master=1
      clock=8006399342464295526 host_tsc=599040211994220
      master_cycle_now=599040238416510
      TSC DEFICIT: 26422290 cycles

    Same pattern, CPU 0 vs CPU 3, 26M cycle deficit.

kvm_get_wall_clock_epoch() has the same pattern -- fresh host_tsc
vs stale master_cycle_now passed to __pvclock_read_cycles().

The simplest fix I can think of is guarding the __pvclock_read_cycles
call in __get_kvmclock():

    if (data->host_tsc >= hv_clock.tsc_timestamp)
        data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
    else
        data->clock = hv_clock.system_time;

system_time (= master_kernel_ns + kvmclock_offset) was computed from
the TSC page's corrected reference counter and is accurate regardless
of CPU.  The fallback loses sub-us interpolation but avoids a 253-year
jump.  On systems with consistent cross-CPU TSC, the branch is never
taken.

One thing I wasn't sure about: when the fallback triggers,
KVM_CLOCK_TSC_STABLE is still set in data->flags.  I left it alone
since the returned value is still correct (just less precise), but
I could see an argument for clearing it.

Disabling master clock entirely for HVCLOCK would also work but
seemed heavy -- it sacrifices PVCLOCK_TSC_STABLE_BIT, forces the
guest pvclock read into the atomic64_cmpxchg monotonicity guard,
and triggers KVM_REQ_GLOBAL_CLOCK_UPDATE on vCPU migration.

Reproducer bpftrace script (run while exercising KVM on a Hyper-V
host):

  #!/usr/bin/env bpftrace
  /*
   * Detect host_tsc < master_cycle_now in __get_kvmclock.
   *
   * struct kvm_clock_data layout (for raw offset reads):
   *   offset 0:  u64 clock
   *   offset 24: u64 host_tsc
   */

  kprobe:__get_kvmclock
  {
      $kvm = (struct kvm *)arg0;
      @get_data[tid] = (uint64)arg1;
      @get_use_master[tid] = (uint64)$kvm->arch.use_master_clock;
      @get_mcn[tid] = (uint64)$kvm->arch.master_cycle_now;
      @get_cpu[tid] = cpu;
  }

  kretprobe:__get_kvmclock
  {
      $data_ptr = @get_data[tid];
      if ($data_ptr != 0) {
          $clock = *(uint64 *)($data_ptr);
          $host_tsc = *(uint64 *)($data_ptr + 24);
          $use_master = @get_use_master[tid];
          $mcn = @get_mcn[tid];

          if ($use_master && $host_tsc != 0 && $host_tsc < $mcn) {
              printf("BUG: pid=%d cpu=%d->%d host_tsc=%lu mcn=%lu "
                     "deficit=%lu clock=%lu\n",
                     pid, @get_cpu[tid], cpu, $host_tsc,
                     $mcn, $mcn - $host_tsc, $clock);
          }
      }
      delete(@get_data[tid]);
      delete(@get_use_master[tid]);
      delete(@get_mcn[tid]);
      delete(@get_cpu[tid]);
  }

  kprobe:pvclock_update_vm_gtod_copy {
      @gtod_kvm[tid] = (uint64)arg0;
      @gtod_cpu[tid] = cpu;
  }
  kretprobe:pvclock_update_vm_gtod_copy
  {
      $kvm = (struct kvm *)@gtod_kvm[tid];
      if ($kvm != 0) {
          printf("GTOD: pid=%d cpu=%d->%d mcn=%lu use_master=%d\n",
                 pid, @gtod_cpu[tid], cpu,
                 $kvm->arch.master_cycle_now,
                 $kvm->arch.use_master_clock);
      }
      delete(@gtod_kvm[tid]);
      delete(@gtod_cpu[tid]);
  }

Thanks,
Thomas

