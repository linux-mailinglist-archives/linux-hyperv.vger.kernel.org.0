Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421CB48624E
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jan 2022 10:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiAFJqX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jan 2022 04:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237427AbiAFJqU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jan 2022 04:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641462380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UOql9r6TG+gVAuhd4vUHWF9s3KT2BSsvXaBsFleNoFI=;
        b=frQvTH4vG5cCXn90qjd6Qau8r/6SBVCw9PUqH+HuhXuvaFHbDnon7l9x/EKGd0Y5KbljHr
        eVPnpVjAkpEkMvTGllgWtuEkjnFzCxIzRPlV+FR7WIX3fr1jSt3FX/FPaxcfy/vxcwhw6d
        zsE3r4kL2NwsYpXM/mntYCe5Agz2nXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-WhVcCo76N52plnlYAnjunw-1; Thu, 06 Jan 2022 04:46:16 -0500
X-MC-Unique: WhVcCo76N52plnlYAnjunw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1373EA0BDE;
        Thu,  6 Jan 2022 09:46:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 919521079741;
        Thu,  6 Jan 2022 09:46:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/hyperv: Properly deal with empty cpumasks in hyperv_flush_tlb_multi()
Date:   Thu,  6 Jan 2022 10:46:11 +0100
Message-Id: <20220106094611.1404218-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

KASAN detected the following issue:

 BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_multi+0xf88/0x1060
 Read of size 4 at addr ffff8880011ccbc0 by task kcompactd0/33

 CPU: 1 PID: 33 Comm: kcompactd0 Not tainted 5.14.0-39.el9.x86_64+debug #1
 Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine,
     BIOS Hyper-V UEFI Release v4.0 12/17/2019
 Call Trace:
  dump_stack_lvl+0x57/0x7d
  print_address_description.constprop.0+0x1f/0x140
  ? hyperv_flush_tlb_multi+0xf88/0x1060
  __kasan_report.cold+0x7f/0x11e
  ? hyperv_flush_tlb_multi+0xf88/0x1060
  kasan_report+0x38/0x50
  hyperv_flush_tlb_multi+0xf88/0x1060
  flush_tlb_mm_range+0x1b1/0x200
  ptep_clear_flush+0x10e/0x150
...
 Allocated by task 0:
  kasan_save_stack+0x1b/0x40
  __kasan_kmalloc+0x7c/0x90
  hv_common_init+0xae/0x115
  hyperv_init+0x97/0x501
  apic_intr_mode_init+0xb3/0x1e0
  x86_late_time_init+0x92/0xa2
  start_kernel+0x338/0x3eb
  secondary_startup_64_no_verify+0xc2/0xcb

 The buggy address belongs to the object at ffff8880011cc800
  which belongs to the cache kmalloc-1k of size 1024
 The buggy address is located 960 bytes inside of
  1024-byte region [ffff8880011cc800, ffff8880011ccc00)

'hyperv_flush_tlb_multi+0xf88/0x1060' points to
hv_cpu_number_to_vp_number() and '960 bytes' means we're trying to get
VP_INDEX for CPU#240. 'nr_cpus' here is exactly 240 so we're trying to
access past hv_vp_index's last element. This can (and will) happen
when 'cpus' mask is empty and cpumask_last() will return '>=nr_cpus'.

Commit ad0a6bad4475 ("x86/hyperv: check cpu mask after interrupt has
been disabled") tried to deal with empty cpumask situation but
apparently didn't fully fix the issue.

'cpus' cpumask which is passed to hyperv_flush_tlb_multi() is
'mm_cpumask(mm)' (which is '&mm->cpu_bitmap'). This mask changes every
time the particular mm is scheduled/unscheduled on some CPU (see
switch_mm_irqs_off()), disabling IRQs on the CPU which is performing remote
TLB flush has zero influence on whether the particular process can get
scheduled/unscheduled on _other_ CPUs so e.g. in the case where the mm was
scheduled on one other CPU and got unscheduled during
hyperv_flush_tlb_multi()'s execution will lead to cpumask becoming empty.

It doesn't seem that there's a good way to protect 'mm_cpumask(mm)'
from changing during hyperv_flush_tlb_multi()'s execution. It would be
possible to copy it in the very beginning of the function but this is a
waste. It seems we can deal with changing cpumask just fine.

When 'cpus' cpumask changes during hyperv_flush_tlb_multi()'s
execution, there are two possible issues:
- 'Under-flushing': we will not flush TLB on a CPU which got added to
the mask while hyperv_flush_tlb_multi() was already running. This is
not a problem as this is equal to mm getting scheduled on that CPU
right after TLB flush.
- 'Over-flushing': we may flush TLB on a CPU which is already cleared
from the mask. First, extra TLB flush preserves correctness. Second,
Hyper-V's TLB flush hypercall takes 'mm->pgd' argument so Hyper-V may
avoid the flush if CR3 doesn't match.

Fix the immediate issue with cpumask_last()/hv_cpu_number_to_vp_number()
and remove the pointless cpumask_empty() check from the beginning of the
function as it really doesn't protect anything. Also, avoid the hypercall
altogether when 'flush->processor_mask' ends up being empty.

Fixes: ad0a6bad4475 ("x86/hyperv: check cpu mask after interrupt has been disabled")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/mmu.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index bd13736d0c05..0ad2378fe6ad 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -68,15 +68,6 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	/*
-	 * Only check the mask _after_ interrupt has been disabled to avoid the
-	 * mask changing under our feet.
-	 */
-	if (cpumask_empty(cpus)) {
-		local_irq_restore(flags);
-		return;
-	}
-
 	flush_pcpu = (struct hv_tlb_flush **)
 		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -115,7 +106,9 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 		 * must. We will also check all VP numbers when walking the
 		 * supplied CPU set to remain correct in all cases.
 		 */
-		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
+		cpu = cpumask_last(cpus);
+
+		if (cpu < nr_cpumask_bits && hv_cpu_number_to_vp_number(cpu) >= 64)
 			goto do_ex_hypercall;
 
 		for_each_cpu(cpu, cpus) {
@@ -131,6 +124,12 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 			__set_bit(vcpu, (unsigned long *)
 				  &flush->processor_mask);
 		}
+
+		/* nothing to flush if 'processor_mask' ends up being empty */
+		if (!flush->processor_mask) {
+			local_irq_restore(flags);
+			return;
+		}
 	}
 
 	/*
-- 
2.33.1

