Return-Path: <linux-hyperv+bounces-11282-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OqlAuePF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11282-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:44:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD05EB582
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0D4730B56FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10798233955;
	Thu, 28 May 2026 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PIEHqNEC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626981E520A;
	Thu, 28 May 2026 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928961; cv=none; b=Zyr+iGABElW+UbyitFSLRTXQnyzF4h56zu2Wr6o5x8VPQ61WzbijvaaNcv1oTOlPqTWxJ58A+H+iS8rKP4oDBaB2yvTZGV05l/6Y4G0T3MToTZWtDGhr3r6fY4P3M/D1QPq2o3FrXG3Qk8Ttis5cYfKhtPDUGLCSbcwh/lb27I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928961; c=relaxed/simple;
	bh=Mpa2aIOvk2CntAM7UYhmKylxYj2hR3vge1hDDTwYyTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHKQ8vUee0+4GevesW1ZKUzkdsj8qPU4N8cFUkDKY+ZMKBA/Rux/vTST0TxschSJwCVPSc1zd/MJakyn7QoKV4LnrD5UgHOgokLksVaGaD840DFwlIkaSI1YbYQQJOeSyKIaiQT7sLRf5FRGk7JiKloe3+mwsq7AyHTFdKkPdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PIEHqNEC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id D7DDE20B7187; Wed, 27 May 2026 17:42:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7DDE20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928944;
	bh=Cpp3h87G8qknuAl35zSdpszjamPTiyZ/dw7XF2/OzTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIEHqNECP5CTqhXoOkn4rDFNUhRk3G8ySSEWPLqOtUqj80vbwQHXMFlUQhyAXL6nk
	 Lkhsmhg721K+zYQEUnUOCDla7QLptnzUdto/HtBqJ3+Y+YsgwYNi4ynRenpctewPNA
	 Xaw+l3dqh3iNA2xMzdvnzv7XVsaBKTonUE6FHXyI=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 17/20] hyperv: Reserve crash MSR P2 for page preservation root PA
Date: Wed, 27 May 2026 17:41:59 -0700
Message-ID: <20260528004204.1484584-18-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11282-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78AD05EB582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The crash MSRs have no formal semantics and nothing depends on their
contents, so the register assignment can be reshuffled freely.

Reserve crash MSR P2 for passing the KHO radix tree root physical
address to the crash kernel for MSHV page exclusion during dump
collection. Stop overwriting it in the panic reporting paths.

Move IP/PC to P3 and SP to P4 in hyperv_report_panic() on both x86
and ARM64. Remove the P2 write from hv_kmsg_dump().

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c | 6 +++---
 arch/x86/hyperv/hv_init.c   | 4 ++--
 drivers/hv/hv_common.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index e33a9e3c366a..b75337c4892d 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -185,9 +185,9 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 	 */
 	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P0, err);
 	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P1, guest_id);
-	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P2, regs->pc);
-	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->sp);
-	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, 0);
+	/* P2 is reserved for the KHO preserved-pages tree root PA */
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->pc);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, regs->sp);
 
 	/*
 	 * Let Hyper-V know there is crash data available
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 55a8b6de2865..cd75e2be19b2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -675,8 +675,8 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 
 	wrmsrq(HV_X64_MSR_CRASH_P0, err);
 	wrmsrq(HV_X64_MSR_CRASH_P1, guest_id);
-	wrmsrq(HV_X64_MSR_CRASH_P2, regs->ip);
-	wrmsrq(HV_X64_MSR_CRASH_P3, regs->ax);
+	/* P2 is reserved for the KHO preserved-pages tree root PA */
+	wrmsrq(HV_X64_MSR_CRASH_P3, regs->ip);
 	wrmsrq(HV_X64_MSR_CRASH_P4, regs->sp);
 
 	/*
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 8a593117e9b8..ae6415f42f25 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -212,7 +212,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 */
 	hv_set_msr(HV_MSR_CRASH_P0, 0);
 	hv_set_msr(HV_MSR_CRASH_P1, 0);
-	hv_set_msr(HV_MSR_CRASH_P2, 0);
+	/* P2 is reserved for the KHO preserved-pages tree root PA */
 	hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_panic_page) : 0);
 	hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
 
-- 
2.43.0


