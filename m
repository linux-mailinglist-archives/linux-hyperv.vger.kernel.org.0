Return-Path: <linux-hyperv+bounces-9818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNNyFjDrxmloQAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9818-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:40:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9D34B215
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 067E230E9B7B
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065BC39E191;
	Fri, 27 Mar 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RTFVT+95"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639F39DBF9;
	Fri, 27 Mar 2026 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642787; cv=none; b=m5Y1HRggLpw6AcdWsRf9CP+ewsUarG/8Vvw2dlKWZeJ6ZUKv8zIwI2mILheMCfKFCJC3bqb1xu5rNMBTz0PomfdN5bQkECnD0ddeVnoTmIEHmpENjMrXtSh5wzKyD8yAGXU75nJ81d62H0+6YqQmbTPSZtiN5trqlSmKVC7CjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642787; c=relaxed/simple;
	bh=n3wRMWxijb5f+Ki/ATxgIfrLW6wOCwMljQUOyeOhKng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9bJY/BDlTvII9E7/XXapM9mlOjitpOFpQkW2juhA/M5EHOoe1zAkX/JXzIjtoe/t3KYnNTGAppQYkH/O3z0gBhl69KWovgi6MxJl6+Y9L9ORiQwg2FTM7QS8/e69AuLNlQCd1ecTUH6HNcJqE/QXB1bezZYSlorYahVVH354Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RTFVT+95; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id DB01320B712D; Fri, 27 Mar 2026 13:19:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB01320B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642786;
	bh=A3whTba+kKlux0T39+Eo6dSgs6pyxVciElJs0djBuTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTFVT+95MBkFfdiq9i+cyUbuieLWF4mXd+LwBrvQ2cebq5WXZ9GJBhqwP11HhNrMd
	 bXyvfkilSzHtkJMx/KYs3O94YiOk4+aPHkiT4RNGJYEDeT+BVOvWUs9wDKpbQKnpKF
	 2MrrfyO7nEKBdV/SzjXar/WlPRUZlNiFN45kIGao=
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
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned resources
Date: Fri, 27 Mar 2026 13:19:15 -0700
Message-ID: <20260327201920.2100427-5-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9818-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 6BA9D34B215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SynIC is shared between VMBus and MSHV. VMBus owns the message
page (SIMP), event flags page (SIEFP), global enable (SCONTROL), and
SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).

Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and
SCONTROL that VMBus already configured, and mshv_synic_cleanup()
disables all of them. This is wrong because MSHV can be torn down
while VMBus is still active. In particular, a kexec reboot notifier
tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out from
under VMBus causes its later cleanup to write SynIC MSRs while SynIC
is disabled, which the hypervisor does not tolerate.

Restrict MSHV to managing only the resources it owns:
- SINT0, SINT5: mask on cleanup, unmask on init
- SIRBP: enable/disable as before
- SIMP, SIEFP, SCONTROL: on L1VH leave entirely to VMBus (it
  already enabled them); on root partition VMBus doesn't run, so
  MSHV must enable/disable them

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c | 109 ++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index f8b0337cdc82..8a7d76a10dc3 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -454,7 +454,6 @@ int mshv_synic_init(unsigned int cpu)
 #ifdef HYPERVISOR_CALLBACK_VECTOR
 	union hv_synic_sint sint;
 #endif
-	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
@@ -462,28 +461,37 @@ int mshv_synic_init(unsigned int cpu)
 	struct hv_synic_event_ring_page **event_ring_page =
 			&spages->synic_event_ring_page;
 
-	/* Setup the Synic's message page */
+	/*
+	 * Map the SYNIC message page. On root partition the hypervisor
+	 * pre-provisions the SIMP GPA but may not set simp_enabled;
+	 * on L1VH, VMBus already fully set it up. Enable it on root.
+	 */
 	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
-	simp.simp_enabled = true;
+	if (hv_root_partition()) {
+		simp.simp_enabled = true;
+		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+	}
 	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 			     HV_HYP_PAGE_SIZE,
 			     MEMREMAP_WB);
 
 	if (!(*msg_page))
-		return -EFAULT;
-
-	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+		goto cleanup_simp;
 
-	/* Setup the Synic's event flags page */
+	/*
+	 * Map the event flags page. Same as SIMP: enable on root,
+	 * already enabled by VMBus on L1VH.
+	 */
 	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
-	siefp.siefp_enabled = true;
+	if (hv_root_partition()) {
+		siefp.siefp_enabled = true;
+		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	}
 	*event_flags_page = memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
 				     PAGE_SIZE, MEMREMAP_WB);
 
 	if (!(*event_flags_page))
-		goto cleanup;
-
-	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+		goto cleanup_siefp;
 
 	/* Setup the Synic's event ring page */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
@@ -492,7 +500,7 @@ int mshv_synic_init(unsigned int cpu)
 				    PAGE_SIZE, MEMREMAP_WB);
 
 	if (!(*event_ring_page))
-		goto cleanup;
+		goto cleanup_siefp;
 
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 
@@ -515,28 +523,33 @@ int mshv_synic_init(unsigned int cpu)
 			      sint.as_uint64);
 #endif
 
-	/* Enable global synic bit */
-	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
-	sctrl.enable = 1;
-	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+	/*
+	 * On L1VH, VMBus owns SCONTROL and has already enabled it.
+	 * On root partition, VMBus doesn't run so we must enable it.
+	 */
+	if (hv_root_partition()) {
+		union hv_synic_scontrol sctrl;
+
+		sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
+		sctrl.enable = 1;
+		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+	}
 
 	return 0;
 
-cleanup:
-	if (*event_ring_page) {
-		sirbp.sirbp_enabled = false;
-		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
-		memunmap(*event_ring_page);
-	}
-	if (*event_flags_page) {
+cleanup_siefp:
+	if (*event_flags_page)
+		memunmap(*event_flags_page);
+	if (hv_root_partition()) {
 		siefp.siefp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
-		memunmap(*event_flags_page);
 	}
-	if (*msg_page) {
+cleanup_simp:
+	if (*msg_page)
+		memunmap(*msg_page);
+	if (hv_root_partition()) {
 		simp.simp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
-		memunmap(*msg_page);
 	}
 
 	return -EFAULT;
@@ -545,10 +558,7 @@ int mshv_synic_init(unsigned int cpu)
 int mshv_synic_cleanup(unsigned int cpu)
 {
 	union hv_synic_sint sint;
-	union hv_synic_simp simp;
-	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
-	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
@@ -568,28 +578,43 @@ int mshv_synic_cleanup(unsigned int cpu)
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
 			      sint.as_uint64);
 
-	/* Disable Synic's event ring page */
+	/* Disable SYNIC event ring page owned by MSHV */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 	sirbp.sirbp_enabled = false;
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 	memunmap(*event_ring_page);
 
-	/* Disable Synic's event flags page */
-	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
-	siefp.siefp_enabled = false;
-	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	/*
+	 * Release our mappings of the message and event flags pages.
+	 * On root partition, we enabled SIMP/SIEFP — disable them.
+	 * On L1VH, VMBus owns the MSRs, leave them alone.
+	 */
 	memunmap(*event_flags_page);
+	if (hv_root_partition()) {
+		union hv_synic_simp simp;
+		union hv_synic_siefp siefp;
 
-	/* Disable Synic's message page */
-	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
-	simp.simp_enabled = false;
-	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+		siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
+		siefp.siefp_enabled = false;
+		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+
+		simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
+		simp.simp_enabled = false;
+		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+	}
 	memunmap(*msg_page);
 
-	/* Disable global synic bit */
-	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
-	sctrl.enable = 0;
-	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+	/*
+	 * On root partition, we enabled SCONTROL in init — disable it.
+	 * On L1VH, VMBus owns SCONTROL, leave it alone.
+	 */
+	if (hv_root_partition()) {
+		union hv_synic_scontrol sctrl;
+
+		sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
+		sctrl.enable = 0;
+		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+	}
 
 	return 0;
 }
-- 
2.43.0


