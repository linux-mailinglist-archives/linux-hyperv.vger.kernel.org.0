Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0372027F779
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 03:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJABiY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 21:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgJABiY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 21:38:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08041207C3;
        Thu,  1 Oct 2020 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601516304;
        bh=XZMO4TFRTZP9b5yzSScYL7RC7vJy1GH6mjdF75Dp63Q=;
        h=From:To:Cc:Subject:Date:From;
        b=saNzvhOF8SyN9uvJGhdWR4czhwd9sXkILvfsW8J69kKHEh2cP2XEUw79BEKtszGoK
         cSqCCLrryfDk/Wy0V2UFLxhLn+XZr/zR1pMhuHd4Fd5nBvODfA0X8Td9cVwZeUPxJp
         YcilWetfHKSBiUzrn2g9GGq7+EkaxLkmWyrBUouk=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_flush_tlb_others()
Date:   Wed, 30 Sep 2020 21:38:14 -0400
Message-Id: <20201001013814.2435935-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

cpumask can change underneath us, which is generally safe except when we
call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
garbage. As reported by KASAN:

[   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
[   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
[   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
[   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
[   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
[   84.196669] Call Trace:
[   84.196669] dump_stack (lib/dump_stack.c:120)
[   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
[   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
[   84.196669] kasan_report (arch/x86/include/asm/smap.h:71 mm/kasan/common.c:635)
[   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
[   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68 arch/x86/mm/tlb.c:798)
[   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-generic.c:88)

Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 5208ba49c89a9..b1d6afc5fc4a3 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 		 * must. We will also check all VP numbers when walking the
 		 * supplied CPU set to remain correct in all cases.
 		 */
-		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
+		int last = cpumask_last(cpus);
+
+		if (last < num_possible_cpus() && hv_cpu_number_to_vp_number(last) >= 64)
 			goto do_ex_hypercall;
 
 		for_each_cpu(cpu, cpus) {
-- 
2.25.1

