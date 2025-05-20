Return-Path: <linux-hyperv+bounces-5571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F9ABD618
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 13:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6718A38A0
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63827CCDC;
	Tue, 20 May 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDU4XywU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51C27B51C;
	Tue, 20 May 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739258; cv=none; b=kiQgdbUKagNPWfVxQ7mud5VUbM1cuLHPukse9zhC7si1UjQITUwyYBwePvztRCSlsyS8HQxA7tgPO1vMHhYueYLxqXIqK66HuiAtyUhDoi6p7fjv2btnA9dmEx4aOyn09IwYu1RA+QaU/MhqVDF0pDc9sG2YIOm8v0HxIXtKsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739258; c=relaxed/simple;
	bh=583vg1UGoVVLzqSxiuKpUTbmEoP4v8+DKr/qwwa/QPA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HHGwmP1ZE8015ezn4ULEnWoHXzSialMAC084RSlJj6XsnsjauUlQwJmSDdYCkmtzec0cYor2RsC5jdool/Tuz+HZKb/mZXEcJ6KO3sSqxlxug36EXPGYjPYHr9YpRwhVRkPiyoLpLA2GUp4XjjnzJKGv4Zb37t031C/kgAKzb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HDU4XywU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=VA8u/QPdc7wo8oqOhurIyOQjeWkHTGSNoZudB2U5izw=; b=HDU4XywURo8coRyniLZ/dwkjFo
	6KKEVwjcziTb/8HHcD7gzx+cEV/7blGlnkUBsi/bQV/ygVgnE+P90AzAdR7zpZd/fiPKBQfxZTGWL
	CAZSCrigSeHvtZhmnPGCPPA6rjTbs5iFcBSiCuyAxyYMTODCnzxmUwyQpmwHt0Jm3Oiwne/v9R7iZ
	3Mxc1FyuXPJbbyCaiezJwGzIdPzIwt5DKjmDosTxXiYrV5v5NMQ0fgCcZzHnp2ddJj0YZ+P0k2sHf
	Wk4t1o3usiBRJPWSdwXx5ydpY+VHRs4y5oGEJiOrtVSw6fO7aLGTq+rWYsUvJbKTCjWfebgpyouOF
	0p+XHsNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uHKoh-00000000lqm-3EeC;
	Tue, 20 May 2025 11:07:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 4E41B3007CD; Tue, 20 May 2025 13:07:27 +0200 (CEST)
Message-ID: <20250520110632.054673615@infradead.org>
User-Agent: quilt/0.66
Date: Tue, 20 May 2025 12:55:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 luto@kernel.org,
 linux-hyperv@vger.kernel.org
Subject: [PATCH 1/3] x86/mm: Unexport tlb_state_shared
References: <20250520105542.283166629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Never export data; modules have no business being able to change tlb
state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/hyperv/mmu.c           |    9 ++-------
 arch/x86/include/asm/tlbflush.h |    2 ++
 arch/x86/mm/tlb.c               |    7 ++++++-
 3 files changed, 10 insertions(+), 8 deletions(-)

--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -51,11 +51,6 @@ static inline int fill_gva_list(u64 gva_
 	return gva_n - offset;
 }
 
-static bool cpu_is_lazy(int cpu)
-{
-	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
-}
-
 static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 				   const struct flush_tlb_info *info)
 {
@@ -113,7 +108,7 @@ static void hyperv_flush_tlb_multi(const
 			goto do_ex_hypercall;
 
 		for_each_cpu(cpu, cpus) {
-			if (do_lazy && cpu_is_lazy(cpu))
+			if (do_lazy && cpu_tlbstate_is_lazy(cpu))
 				continue;
 			vcpu = hv_cpu_number_to_vp_number(cpu);
 			if (vcpu == VP_INVAL) {
@@ -198,7 +193,7 @@ static u64 hyperv_flush_tlb_others_ex(co
 
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
-			info->freed_tables ? NULL : cpu_is_lazy);
+			info->freed_tables ? NULL : cpu_tlbstate_is_lazy);
 	if (nr_bank < 0)
 		return HV_STATUS_INVALID_PARAMETER;
 
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -172,6 +172,8 @@ struct tlb_state_shared {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 
+bool cpu_tlbstate_is_lazy(int cpu);
+
 bool nmi_uaccess_okay(void);
 #define nmi_uaccess_okay nmi_uaccess_okay
 
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1322,7 +1322,12 @@ static bool should_trim_cpumask(struct m
 }
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
-EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);
+
+bool cpu_tlbstate_is_lazy(int cpu)
+{
+	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
+}
+EXPORT_SYMBOL_GPL(cpu_tlbstate_is_lazy);
 
 STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)



