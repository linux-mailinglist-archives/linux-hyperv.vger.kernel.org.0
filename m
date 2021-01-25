Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B755302C70
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Jan 2021 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbhAYUXA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jan 2021 15:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbhAYUUc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 15:20:32 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CBC061574
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Jan 2021 12:19:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id c18so4139415ljd.9
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Jan 2021 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NoB95oMBEGR5sckmdInxtow+uc420MtguXF/itdZt+I=;
        b=GuS4IHjvNzHMLYCh81wy1/3GvONJSx+use0ZutkcO+KUk0Oa6usC+hO9icZa/6fOOv
         urYPLDqoF6W/+/0xfOJ96F6up6GtGd7Gqz/kTs2FIlzdwCjfl9YhJf9uOcRRKLj9xTMs
         zvD/nRp8p1+/3jA6z4nEbtCyVe8VR+QG9EKjckPlJCP4Rh2JRdEytnmiUdcYal0mLsmo
         YMk+X6ccON9v00UeZshTvIjMQY/9wVvmpIb/I0O0iXrnyaqeMShVkdMhLo84v2v4wMUl
         ZRhGB4pySCIcPdgRpakqEDBq9E3xDSyUYqtFHxSwFi36CsvXZTi0YTXUzEolKHbhgIhG
         FU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NoB95oMBEGR5sckmdInxtow+uc420MtguXF/itdZt+I=;
        b=iYuZMWM/n7PWZHkZiyzDza2DrcCiIlowAIHlBaDvEKBt2zr4XofAX7aL4PpaC87+6d
         rMCLP4cTAqyfx1xY4ARlyiREkUtM/7HXmce3zVkMHGKcmDiI3FwhQcdN/1xbhIFXi6N2
         WXIbjuAFBTMdLMpMtIRmhxs4BatHtNimZaxUYyAmJo+/dPlh3gERjvW+omEu/4YqBtX9
         PuDxTtlwsqhcSM2rF5mjj6wTbmLu1JWaspUqB+shql5obz3cm9UTzGADIjkxsp8dPOTz
         0wN7zxor7Op34uV7KvTmTTPvsiRjisrPI0mpfHIZ8jFF4mrYFbB7lAqW1siyLdbUM2RH
         xD4g==
X-Gm-Message-State: AOAM533eUlarehn6GZ7b8SsrUCdCaDmHgsBim9eBML8Q2c2ZmhFOu3g7
        8YC3c9ETSeb46M0vRNMH9YdNUKJxIZGwfSCAWbs=
X-Google-Smtp-Source: ABdhPJwg1oUbSL7WetLnWif3okyT4hcPBDjMFV8TLA/bJnj/nPvw0U6rTHeUGKsiqZ8/G8AvAUljKeRLvFHwZDCVYcs=
X-Received: by 2002:a2e:bc13:: with SMTP id b19mr1023924ljf.381.1611605990597;
 Mon, 25 Jan 2021 12:19:50 -0800 (PST)
MIME-Version: 1.0
From:   Jon Stanley <jonstanley@gmail.com>
Date:   Mon, 25 Jan 2021 15:19:32 -0500
Message-ID: <CALY6xngo6fU7NoEgrmP_qtdz4OMQgKo9CiJno2uhtWie0ze3Rw@mail.gmail.com>
Subject: hv_balloon issues??
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I'm working to make a method to install bare-metal machines with
Packer images, and in testing (this isn't going to wind up in
production on Hyper-V) I think I've found an issue in hv_balloon, but
I'm not sure.

Starting from a RHEL 8 live CD, I make a tmpfs filesystem and download
a disk image to it. Despite having plenty of memory to do this (I was
downloading a 5GB image onto a VM with 16GB of RAM), I got paid a
visit by the OOM killer.

If I turn off dynamic memory, then things work as expected. This isn't
100% reproducible, I tried immediately after boot and it worked,
unmounted the tmpfs filesystem and waited for a kernel message that
said the balloon floor was reached and tried again, and BOOM!

The actual process that is filling the filesystem (curl) doesn't get
killed (which makes sense I guess since *it* isn't taking a ton of
memory), and also never completes presumably due to it's I/O becoming
blocked. Does this have to do with a sudden, enormous demand for
memory perhaps that the hypervisor is having difficulty fulfilling?
The host has plenty of memory available (63GB right now)

On another note, is there a way that I'm not seeing to tell the
current status of the balloon driver - i.e. current/max allocations? A
quick look through /proc and /sys wasn't revealing.

Also, sorry to be using a distro kernel instead of upstream.

-Jon

Jan 25 14:58:43 dhcp-132.rmrf.net kernel: hv_balloon: Balloon request
will be partially fulfilled. Balloon floor reached.
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: tuned invoked oom-killer:
gfp_mask=0x6200ca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: CPU: 0 PID: 1165 Comm: tuned
Not tainted 4.18.0-240.10.1.el8_3.x86_64 #1
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Hardware name: Microsoft
Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release
v4.0 11/01/2019
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Call Trace:
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  dump_stack+0x5c/0x80
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  dump_header+0x51/0x308
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  oom_kill_process.cold.28+0xb/0x10
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  out_of_memory+0x1c1/0x4b0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  __alloc_pages_slowpath+0xc24/0xd40
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  __alloc_pages_nodemask+0x245/0x280
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  filemap_fault+0x3b8/0x840
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ? hrtimer_cancel+0x11/0x20
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ? futex_wait+0x19a/0x210
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ? xas_load+0x8/0x80
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ? xas_find+0x173/0x1b0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ? filemap_map_pages+0x1a3/0x380
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ext4_filemap_fault+0x2c/0x40 [ext4]
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  __do_fault+0x38/0xc0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  do_fault+0x191/0x3c0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  __handle_mm_fault+0x3e6/0x7c0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  handle_mm_fault+0xc2/0x1d0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  __do_page_fault+0x21b/0x4d0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  do_page_fault+0x32/0x110
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  ? page_fault+0x8/0x30
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:  page_fault+0x1e/0x30
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: RIP: 0033:0x7faf2f8c5df2
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Code: Bad RIP value.
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: RSP: 002b:00007faf242629a0
EFLAGS: 00010246
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: RAX: ffffffffffffff92 RBX:
00007faf24262a40 RCX: 00007faf2f8c5df2
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: RDX: 0000000000000000 RSI:
0000000000000189 RDI: 00007faf1c002490
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: RBP: 00007faf1c002490 R08:
0000000000000000 R09: 00000000ffffffff
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: R10: 00007faf24262a40 R11:
0000000000000246 R12: 0000000000000000
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: R13: 0000000000000000 R14:
00007faf24262a40 R15: 000000003b9aca00
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Mem-Info:
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: active_anon:18180
inactive_anon:738744 isolated_anon:0
                                           active_file:18
inactive_file:337 isolated_file:32
                                           unevictable:132114 dirty:0
writeback:0 unstable:0
                                           slab_reclaimable:6250
slab_unreclaimable:5966
                                           mapped:1626 shmem:738916
pagetables:1396 bounce:0
                                           free:31759 free_pcp:30 free_cma:0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 active_anon:72720kB
inactive_anon:2954976kB active_file:72kB inactive_file:1348kB
unevictable:528456kB isolated(anon):0kB i>
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 DMA free:15908kB
min:64kB low:80kB high:96kB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictabl>
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: lowmem_reserve[]: 0 3845
15960 15960 15960
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 DMA32 free:64676kB
min:16264kB low:20328kB high:24392kB active_anon:1424kB
inactive_anon:2489752kB active_file:28kB inactiv>
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: lowmem_reserve[]: 0 0 12114
12114 12114
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 Normal free:46452kB
min:51248kB low:64060kB high:76872kB active_anon:71296kB
inactive_anon:465224kB active_file:4kB inactiv>
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: lowmem_reserve[]: 0 0 0 0 0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 DMA: 1*4kB (U) 0*8kB
0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB
(U) 1*2048kB (M) 3*4096kB (M) = >
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 DMA32: 29*4kB (UE)
36*8kB (UE) 33*16kB (UME) 6*32kB (UE) 3*64kB (UME) 1*128kB (U) 3*256kB
(UME) 2*512kB (UM) 2*1024kB (U) 3>
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 Normal: 833*4kB (UME)
712*8kB (UME) 305*16kB (UME) 152*32kB (UME) 52*64kB (E) 28*128kB (UME)
15*256kB (UME) 11*512kB (UME) >
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 hugepages_total=0
hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Node 0 hugepages_total=0
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: 871413 total pagecache pages
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: 0 pages in swap cache
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Swap cache stats: add 0,
delete 0, find 0/0
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Free swap  = 0kB
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Total swap = 0kB
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: 4194027 pages RAM
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: 0 pages HighMem/MovableOnly
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: 91830 pages reserved
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: 0 pages hwpoisoned
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ pid ]   uid  tgid total_vm
     rss pgtables_bytes swapents oom_score_adj name
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  762]     0   762    27626
    1788   290816        0             0 systemd-journal
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  816]     0   816    25338
     353   212992        0         -1000 systemd-udevd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  819]     0   819    15287
     152   135168        0         -1000 auditd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  860]    81   860    14087
     213   155648        0          -900 dbus-daemon
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  875]   995   875    29968
     111   147456        0             0 chronyd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  907]     0   907    48443
     510   405504        0             0 sssd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  908]   997   908   404961
    1915   331776        0             0 polkitd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  913]     0   913     1085
      16    53248        0             0 hypervvssd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  914]   994   914    40028
     204   208896        0             0 rngd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  921]     0   921    50484
     659   421888        0             0 sssd_be
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  922]     0   922    53956
     395   462848        0             0 sssd_nss
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  925]     0   925    74573
    5478   466944        0             0 firewalld
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  926]     0   926    24290
     252   204800        0             0 systemd-logind
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  940]     0   940   116867
     614   389120        0             0 NetworkManager
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  958]     0   958    23072
     224   212992        0         -1000 sshd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  968]     0   968     1778
      30    61440        0             0 hypervkvpd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  969]     0   969   106589
    3721   450560        0             0 tuned
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  972]     0   972     9232
     221   106496        0             0 crond
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [  973]     0   973    10449
     135   114688        0             0 rhsmcertd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ 1189]     0  1189    56455
     509   192512        0             0 rsyslogd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ 1201]     0  1201    30749
     215   266240        0             0 login
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ 1206]     0  1206    23443
     331   225280        0             0 systemd
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ 1210]     0  1210    37531
     648   299008        0             0 (sd-pam)
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ 1216]     0  1216     6554
     154    86016        0             0 bash
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: [ 1285]     0  1285    20229
     245   196608        0             0 curl
Jan 25 14:59:30 dhcp-132.rmrf.net kernel:
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/system.slice/firewalld.service,>
Jan 25 14:59:30 dhcp-132.rmrf.net kernel: Out of memory: Killed
process 925 (firewalld) total-vm:298292kB, anon-rss:21912kB,
file-rss:0kB, shmem-rss:0kB, UID:0
Jan 25 14:59:34 dhcp-132.rmrf.net systemd[1]: firewalld.service: Main
process exited, code=killed, status=9/KILL
Jan 25 14:59:47 dhcp-132.rmrf.net systemd[1]: firewalld.service:
Failed with result 'signal'.
