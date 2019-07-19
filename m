Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD876D802
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jul 2019 02:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfGSA67 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jul 2019 20:58:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSA66 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jul 2019 20:58:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so13655318pgi.6;
        Thu, 18 Jul 2019 17:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWWNgv0WcWjfE9wWYHQhoeNKyBfGxLtvDshgZHYc1vE=;
        b=TI80sLTaRhpFMe8tn7BS5nXuhpKYxs7wmEnANGJMyCFvkvEteuEhqCEtgO0ziIu0rf
         kEy9Gtv+msFRMIANvUU/oimdps2d2hnYX2IJJFKm/jM1Vfy4c60u8wy2o52mfyyvCmYb
         dKkQrHZU2RaZQ/41n1L2jj8El/rsasHr2hOnJKG0HOW2gZ9w535y0tv4hV3geHY3dKtn
         U5ac4XnCiGMY/gTJTTgc/vF2u7pbq5M4ITjv4rPKi+MVyAZfZSeC8FuFkQv8hA2Y5rYw
         gESZNpyAmd5tyMhxRLQRH7XXgye29x82D4QfoIgonBwQ1oizdLloA1uaSsRVLD6/Vaxz
         SJZQ==
X-Gm-Message-State: APjAAAWj6Tt+Yf5WtByAGrl8JvcjFmbKinrZqT/kY5ux7+vUR6NwdWzT
        MrcLJln5kPBAKvp4daMHvG8=
X-Google-Smtp-Source: APXvYqxZoIKjz9ViGfUIEExjwwIbnjfGtWb7w9xiUnCbHyVRrBrLCxFCFJP5cS9IAYKOxxdelYaABg==
X-Received: by 2002:a63:a346:: with SMTP id v6mr4814748pgn.57.1563497937499;
        Thu, 18 Jul 2019 17:58:57 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.58.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:58:56 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v3 0/9] x86: Concurrent TLB flushes
Date:   Thu, 18 Jul 2019 17:58:28 -0700
Message-Id: <20190719005837.4150-1-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[ Cover-letter is identical to v2, including benchmark results,
  excluding the change log. ] 

Currently, local and remote TLB flushes are not performed concurrently,
which introduces unnecessary overhead - each INVLPG can take 100s of
cycles. This patch-set allows TLB flushes to be run concurrently: first
request the remote CPUs to initiate the flush, then run it locally, and
finally wait for the remote CPUs to finish their work.

In addition, there are various small optimizations to avoid unwarranted
false-sharing and atomic operations.

The proposed changes should also improve the performance of other
invocations of on_each_cpu(). Hopefully, no one has relied on this
behavior of on_each_cpu() that invoked functions first remotely and only
then locally [Peter says he remembers someone might do so, but without
further information it is hard to know how to address it].

Running sysbench on dax/ext4 w/emulated-pmem, write-cache disabled on
2-socket, 48-logical-cores (24+SMT) Haswell-X, 5 repetitions:

 sysbench fileio --file-total-size=3G --file-test-mode=rndwr \
  --file-io-mode=mmap --threads=X --file-fsync-mode=fdatasync run

  Th.   tip-jun28 avg (stdev)   +patch-set avg (stdev)  change
  ---   ---------------------   ----------------------  ------
  1     1267765 (14146)         1299253 (5715)          +2.4%
  2     1734644 (11936)         1799225 (19577)         +3.7%
  4     2821268 (41184)         2919132 (40149)         +3.4%
  8     4171652 (31243)         4376925 (65416)         +4.9%
  16    5590729 (24160)         5829866 (8127)          +4.2%
  24    6250212 (24481)         6522303 (28044)         +4.3%
  32    3994314 (26606)         4077543 (10685)         +2.0%
  48    4345177 (28091)         4417821 (41337)         +1.6%

(Note that on configurations with up to 24 threads numactl was used to
set all threads on socket 1, which explains the drop in performance when
going to 32 threads).

Running the same benchmark with security mitigations disabled (PTI,
Spectre, MDS):

  Th.   tip-jun28 avg (stdev)   +patch-set avg (stdev)  change
  ---   ---------------------   ----------------------  ------
  1     1598896 (5174)          1607903 (4091)          +0.5%
  2     2109472 (17827)         2224726 (4372)          +5.4%
  4     3448587 (11952)         3668551 (30219)         +6.3%
  8     5425778 (29641)         5606266 (33519)         +3.3%
  16    6931232 (34677)         7054052 (27873)         +1.7%
  24    7612473 (23482)         7783138 (13871)         +2.2%
  32    4296274 (18029)         4283279 (32323)         -0.3%
  48    4770029 (35541)         4764760 (13575)         -0.1%

Presumably, PTI requires two invalidations of each mapping, which allows
to get higher benefits from concurrency when PTI is on. At the same
time, when mitigations are on, other overheads reduce the potential
speedup.

I tried to reduce the size of the code of the main patch, which required
restructuring of the series.

v2 -> v3:
* Open-code the remote/local-flush decision code [Andy]
* Fix hyper-v, Xen implementations [Andrew]
* Fix redundant TLB flushes.

v1 -> v2:
* Removing the patches that Thomas took [tglx]
* Adding hyper-v, Xen compile-tested implementations [Dave]
* Removing UV [Andy]
* Adding lazy optimization, removing inline keyword [Dave]
* Restructuring patch-set

RFCv2 -> v1:
* Fix comment on flush_tlb_multi [Juergen]
* Removing async invalidation optimizations [Andy]
* Adding KVM support [Paolo]

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org

Nadav Amit (9):
  smp: Run functions concurrently in smp_call_function_many()
  x86/mm/tlb: Remove reason as argument for flush_tlb_func_local()
  x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Privatize cpu_tlbstate
  x86/mm/tlb: Do not make is_lazy dirty for no reason
  cpumask: Mark functions as pure
  x86/mm/tlb: Remove UV special case
  x86/mm/tlb: Remove unnecessary uses of the inline keyword

 arch/x86/hyperv/mmu.c                 |  10 +-
 arch/x86/include/asm/paravirt.h       |   6 +-
 arch/x86/include/asm/paravirt_types.h |   4 +-
 arch/x86/include/asm/tlbflush.h       |  47 ++++-----
 arch/x86/include/asm/trace/hyperv.h   |   2 +-
 arch/x86/kernel/kvm.c                 |  11 ++-
 arch/x86/kernel/paravirt.c            |   2 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 133 ++++++++++++++++----------
 arch/x86/xen/mmu_pv.c                 |  11 +--
 include/linux/cpumask.h               |   6 +-
 include/linux/smp.h                   |  27 ++++--
 include/trace/events/xen.h            |   2 +-
 kernel/smp.c                          | 133 ++++++++++++--------------
 14 files changed, 218 insertions(+), 178 deletions(-)

-- 
2.20.1

