Return-Path: <linux-hyperv+bounces-9973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOZUDhsQ0GlQ2wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9973-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:08:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B0397882
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A026B3089A1C
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AA13D6CCF;
	Fri,  3 Apr 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kNSVa9Kh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73E35BDDC;
	Fri,  3 Apr 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243184; cv=none; b=d0XDLoAzJr30TJ/4rxn4Io2PYOX5VqK8v5T4QxeeMx8hWXpaX5mEiOE1w6zm4I+K1LOV5gUdaX7ozR0oqI3rtAnRn1+nepBgkYHu44ZjL2vjeWc6KTQdblCcT/INKQXz3lblslBSW2DIrHSt4L1rAcaLoTKmyHUXqlj7LdSvxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243184; c=relaxed/simple;
	bh=Oz1uz7dAG/uy72PvrmHa/5jl/z6xN5LT5cGFKSNgkTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af1Xi7ztwmX+6fX1QcFFNxEh6tf7YJghAyxs08DR+ZfwgGKWu55yU4pzKs3tfozQFnGUtqsYRVXFK0eklGn6JRTITwmy2LtzfG06Rd5M2+dNsVvaPiLxFad+HULH5nC3k2e0xl17l3hPh0fVe3TKXi3/weBH4NP2lTkMUvIqApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kNSVa9Kh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 4B16B20B6F1B; Fri,  3 Apr 2026 12:06:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B16B20B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775243183;
	bh=FlLuRtFSyNeb7uNmEQyawZmHGTy6mdwgcVGZEcmm/NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNSVa9Khjn0KGn4hrAjlF6ArDf69UDvLSGUnQOe+DE84NBziWHIjM6K/GFuzljp6F
	 hGTo8QDOcbqyMRstGStqJS2D9vM+ls/5c9Sms/56GCbE2z3sJwO1Jy5t993dNJMfmK
	 CphjhhesuyFkaTUv2Yw5ua3tcT1DA8BoNwRWIlTM=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v2 5/6] mshv: clean up SynIC state on kexec for L1VH
Date: Fri,  3 Apr 2026 12:06:11 -0700
Message-ID: <20260403190613.47026-6-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403190613.47026-1-jloeser@linux.microsoft.com>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
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
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9973-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 968B0397882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register the mshv reboot notifier for all parent partitions, not just
root. Previously the notifier was gated on hv_root_partition(), so on
L1VH (where hv_root_partition() is false) SINT0, SINT5, and SIRBP were
never cleaned up before kexec. The kexec'd kernel then inherited stale
unmasked SINTs and an enabled SIRBP pointing to freed memory.

The L1VH SIRBP also needs special handling: unlike the root partition
where the hypervisor provides the SIRBP page, L1VH must allocate its
own page and program the GPA into the MSR. Add this allocation to
mshv_synic_init() and the corresponding free to mshv_synic_cleanup().

Remove the unnecessary mshv_root_partition_init/exit wrappers and
register the reboot notifier directly in mshv_parent_partition_init().
Make mshv_reboot_nb static since it no longer needs external linkage.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e6509c980763..281f530b68a9 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2256,20 +2256,10 @@ static int mshv_reboot_notify(struct notifier_block *nb,
 	return 0;
 }
 
-struct notifier_block mshv_reboot_nb = {
+static struct notifier_block mshv_reboot_nb = {
 	.notifier_call = mshv_reboot_notify,
 };
 
-static void mshv_root_partition_exit(void)
-{
-	unregister_reboot_notifier(&mshv_reboot_nb);
-}
-
-static int __init mshv_root_partition_init(struct device *dev)
-{
-	return register_reboot_notifier(&mshv_reboot_nb);
-}
-
 static int __init mshv_init_vmm_caps(struct device *dev)
 {
 	int ret;
@@ -2339,8 +2329,7 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
-	if (hv_root_partition())
-		ret = mshv_root_partition_init(dev);
+	ret = register_reboot_notifier(&mshv_reboot_nb);
 	if (ret)
 		goto remove_cpu_state;
 
@@ -2368,8 +2357,7 @@ static int __init mshv_parent_partition_init(void)
 deinit_root_scheduler:
 	root_scheduler_deinit();
 exit_partition:
-	if (hv_root_partition())
-		mshv_root_partition_exit();
+	unregister_reboot_notifier(&mshv_reboot_nb);
 remove_cpu_state:
 	cpuhp_remove_state(mshv_cpuhp_online);
 free_synic_pages:
@@ -2387,8 +2375,7 @@ static void __exit mshv_parent_partition_exit(void)
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
-	if (hv_root_partition())
-		mshv_root_partition_exit();
+	unregister_reboot_notifier(&mshv_reboot_nb);
 	cpuhp_remove_state(mshv_cpuhp_online);
 	free_percpu(mshv_root.synic_pages);
 }
-- 
2.43.0


