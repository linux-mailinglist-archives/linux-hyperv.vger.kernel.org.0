Return-Path: <linux-hyperv+bounces-10067-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIFoNJSx1WlF8wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10067-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:38:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746693B5FAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEF5304C97A
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17E346E58;
	Wed,  8 Apr 2026 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EIiVGlKZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1511448E0;
	Wed,  8 Apr 2026 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612228; cv=none; b=AGQ55d7fcqE9+TszIWjE44eirqTMF2Q6lnEmID84aj15nLL2Qa3WAwfMIoafOU/iFHwqUGeQldpy1G+iA/PMtVsO8EO6Dk1nQ3lHBIXIsLceKxdn7dUuH0/iFSBRN7HwUqk51NZyLfH+ga57LGVrtoM6ZFrBizMI9drMJNKsOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612228; c=relaxed/simple;
	bh=1xwNPpWCJJHzAunNsCZ36KEBj++s0IvEH8fJ/QguJfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaPgLMin7gdPCPBpzZaF1t2k9QoUW/WjNsZ+D0/ukx78jk4y/d5PErLGBRBmKTuiTeP3uBSo9kl0ed0PwHviRQuYrjLSxqlU9Rb2VIzmOxYDTdDc0Dkrec8A9g8EZa296o1CDX1Dn7ueqhrsd9CVpnuOsxv0nPi0DVfYjF7mbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EIiVGlKZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 035A720B6F1F; Tue,  7 Apr 2026 18:37:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 035A720B6F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775612227;
	bh=csyZ7K2c0JqRTNIFzxpMvEwiQQ941LLIyuYU3krJCrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIiVGlKZVuQVb5XrkLsCKG+kL8GkaQ3tQuJ/9V79ZeRy0bG4p3z/w5QGfpRKV0rKr
	 fwyqdMwxjz+6SO1yHgvR4LfRrg/IbkRrbqlJKy5CDjNgStACoNw0usg/xYXTjyiKR+
	 YLq7XKLRC8ytbfMvu0jOZ1iUE6BH+cxPSCOxdZm8=
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
Subject: [PATCH v3 4/6] mshv: limit SynIC management to MSHV-owned resources
Date: Tue,  7 Apr 2026 18:36:41 -0700
Message-ID: <20260408013645.286723-5-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260408013645.286723-1-jloeser@linux.microsoft.com>
References: <20260408013645.286723-1-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10067-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 746693B5FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SynIC is shared between VMBus and MSHV. VMBus owns the message
page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).

Currently mshv_synic_cpu_init() redundantly enables SIMP, SIEFP, and
SCONTROL that VMBus already configured, and mshv_synic_cpu_exit()
disables all of them. This is wrong because MSHV can be torn down
while VMBus is still active. In particular, a kexec reboot notifier
tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out
from under VMBus causes its later cleanup to write SynIC MSRs while
SynIC is disabled, which the hypervisor does not tolerate.

Restrict MSHV to managing only the resources it owns:
- SINT0, SINT5: mask on cleanup, unmask on init
- SIRBP: enable/disable as before
- SIMP, SIEFP, SCONTROL: leave to VMBus when it is active (L1VH
  and nested root partition); on a non-nested root partition VMBus
  doesn't run, so MSHV must enable/disable them

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c | 142 ++++++++++++++++++++++++++--------------
 1 file changed, 94 insertions(+), 48 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index e2288a726fec..f71d5dfce1c1 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -456,46 +456,72 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
 	union hv_synic_sint sint;
-	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
 			&spages->synic_event_flags_page;
 	struct hv_synic_event_ring_page **event_ring_page =
 			&spages->synic_event_ring_page;
+	/* VMBus runs on L1VH and nested root; it owns SIMP/SIEFP/SCONTROL */
+	bool vmbus_active = !hv_root_partition() || hv_nested;
 
-	/* Setup the Synic's message page */
+	/*
+	 * Map the SYNIC message page. When VMBus is not active the
+	 * hypervisor pre-provisions the SIMP GPA but may not set
+	 * simp_enabled — enable it here.
+	 */
 	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
-	simp.simp_enabled = true;
+	if (!vmbus_active) {
+		simp.simp_enabled = true;
+		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+	}
 	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 			     HV_HYP_PAGE_SIZE,
 			     MEMREMAP_WB);
 
 	if (!(*msg_page))
-		return -EFAULT;
+		goto cleanup_simp;
 
-	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
-
-	/* Setup the Synic's event flags page */
+	/*
+	 * Map the event flags page. Same as SIMP: enable when
+	 * VMBus is not active, already enabled by VMBus otherwise.
+	 */
 	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
-	siefp.siefp_enabled = true;
+	if (!vmbus_active) {
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
-	sirbp.sirbp_enabled = true;
-	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
-				    PAGE_SIZE, MEMREMAP_WB);
 
-	if (!(*event_ring_page))
-		goto cleanup;
+	if (hv_root_partition()) {
+		*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
+					    PAGE_SIZE, MEMREMAP_WB);
 
+		if (!(*event_ring_page))
+			goto cleanup_siefp;
+	} else {
+		/*
+		 * On L1VH the hypervisor does not provide a SIRBP page.
+		 * Allocate one and program its GPA into the MSR.
+		 */
+		*event_ring_page = (struct hv_synic_event_ring_page *)
+			get_zeroed_page(GFP_KERNEL);
+
+		if (!(*event_ring_page))
+			goto cleanup_siefp;
+
+		sirbp.base_sirbp_gpa = virt_to_phys(*event_ring_page)
+				>> PAGE_SHIFT;
+	}
+
+	sirbp.sirbp_enabled = true;
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 
 	if (mshv_sint_irq != -1)
@@ -518,28 +544,30 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
 			      sint.as_uint64);
 
-	/* Enable global synic bit */
-	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
-	sctrl.enable = 1;
-	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+	/* When VMBus is active it already enabled SCONTROL. */
+	if (!vmbus_active) {
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
+	if (!vmbus_active) {
 		siefp.siefp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
-		memunmap(*event_flags_page);
 	}
-	if (*msg_page) {
+cleanup_simp:
+	if (*msg_page)
+		memunmap(*msg_page);
+	if (!vmbus_active) {
 		simp.simp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
-		memunmap(*msg_page);
 	}
 
 	return -EFAULT;
@@ -548,16 +576,15 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 static int mshv_synic_cpu_exit(unsigned int cpu)
 {
 	union hv_synic_sint sint;
-	union hv_synic_simp simp;
-	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
-	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
 		&spages->synic_event_flags_page;
 	struct hv_synic_event_ring_page **event_ring_page =
 		&spages->synic_event_ring_page;
+	/* VMBus runs on L1VH and nested root; it owns SIMP/SIEFP/SCONTROL */
+	bool vmbus_active = !hv_root_partition() || hv_nested;
 
 	/* Disable the interrupt */
 	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
@@ -574,28 +601,47 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 	if (mshv_sint_irq != -1)
 		disable_percpu_irq(mshv_sint_irq);
 
-	/* Disable Synic's event ring page */
+	/* Disable SYNIC event ring page owned by MSHV */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 	sirbp.sirbp_enabled = false;
-	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
-	memunmap(*event_ring_page);
 
-	/* Disable Synic's event flags page */
-	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
-	siefp.siefp_enabled = false;
-	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	if (hv_root_partition()) {
+		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+		memunmap(*event_ring_page);
+	} else {
+		sirbp.base_sirbp_gpa = 0;
+		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+		free_page((unsigned long)*event_ring_page);
+	}
+
+	/*
+	 * Release our mappings of the message and event flags pages.
+	 * When VMBus is not active, we enabled SIMP/SIEFP — disable
+	 * them. Otherwise VMBus owns the MSRs — leave them.
+	 */
 	memunmap(*event_flags_page);
+	if (!vmbus_active) {
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
+	/* When VMBus is active it owns SCONTROL — leave it. */
+	if (!vmbus_active) {
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


