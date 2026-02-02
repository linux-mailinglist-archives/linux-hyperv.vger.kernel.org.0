Return-Path: <linux-hyperv+bounces-8656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNz0Mt3sgGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8656-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:28:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42074D02B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019F43006799
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C222EC086;
	Mon,  2 Feb 2026 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="tOSGmKlO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E852DF12A;
	Mon,  2 Feb 2026 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056874; cv=pass; b=NQ5zwIcBiELdnGnnyrFWbV6ki8zcK/geUyXTbIkmQ+g6RNmrF1a2yNga5KhYfAhVhlYpQxoT8GTPe+z36FV+sLAP2gR0xDjQGv5vHZJShBzduExmVhw+Jgln7gNCiH6zFlTjYF3nvKog9qmHbwYaMRmRD2msjvuG2UwcZtnVF2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056874; c=relaxed/simple;
	bh=i6E2BG3fmZ61cCvSFGo8qDQnTVECh1fOzUHZfpOVjBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYaSy/hsx1xb/t+IYNs8D7Ijas2zDSHJLEhuu+yXllvcD62U+ZfVbdmRQQzDthoYjI+xhTl12Cez6y6Mqg5OcVaAMX54KIxdhqOKzIMJpXj+GBl4TzVun5VHKZWXn9otBjiZMQbOM2nWTaHJ/eBRtXtoIR/A7+6dNqo9br71C94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=tOSGmKlO; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770056867; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A52MIABv/xTCqGWCd/J3tZJojfXvy84fYZdifgBOBTGE9mX7bzmGmvmGwHKaI0Sf7RgZP/uqVq0T0rLVNa3qTosfXNIMIObAKRaIbY1EwlpGix22+tORaw3Rzcn7Mt01GFX8xlPy2tQDP5iVv0NJguG5d0PaHoGr8oBTY/NyYFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770056867; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mx7O/zXOAbdiaNWi2kWP4kiU1sNJSFWVveu6dLILbOI=; 
	b=IkEYdN1CKY5X3hDWqRjvDgaZZE8igsuQOx7QzwFClE7AOMccSi5pxX4jz+REWqP7KMv4gJ/y2ELhzz+OZtvWEJ+BYiRtX5VtLOAwCkUO6ahgYb2iVobYo8g5Ipxvj4jhU2IMv8cZKH/kNHT7KAbTrHxZ1rXcJONUrCcJ2gIr9eY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770056867;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=mx7O/zXOAbdiaNWi2kWP4kiU1sNJSFWVveu6dLILbOI=;
	b=tOSGmKlORdVeEr2d5rKRsVoOg7TMPfvDiI14t2f7CjtAe+kbNc0GU38sen5hfMPt
	9v7cCI7u53JEj79ayceWYXlRHe81PGhE8mzWYfnO418zZSFGDRzfzvRrWJWqB6wjIA1
	ecn3mscXIoksrEBHinKrSgcbDUCuCRBEaOrczOoI=
Received: by mx.zohomail.com with SMTPS id 1770056864902880.0118829679859;
	Mon, 2 Feb 2026 10:27:44 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v2 2/2] mshv: add arm64 support for doorbell & intercept SINTs
Date: Mon,  2 Feb 2026 18:27:06 +0000
Message-Id: <20260202182706.648192-3-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202182706.648192-1-anirudh@anirudhrb.com>
References: <20260202182706.648192-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8656-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42074D02B2
X-Rspamd-Action: no action

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the INTID for SINTs should be in the SGI or PPI range. The
hypervisor exposes a virtual device in the ACPI that reserves a
PPI for this use. Introduce a platform_driver that binds to this ACPI
device and obtains the interrupt vector that can be used for SINTs.

To better unify x86 and arm64 paths, introduce mshv_sint_vector_init() that
either registers the platform_driver and obtains the INTID (arm64) or
just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_synic.c | 163 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 156 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 98c58755846d..de5fee6e9f29 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -10,17 +10,24 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/random.h>
 #include <linux/cpuhotplug.h>
 #include <linux/reboot.h>
 #include <asm/mshyperv.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
 
 static int synic_cpuhp_online;
 static struct hv_synic_pages __percpu *synic_pages;
+static int mshv_sint_vector = -1; /* hwirq for the SynIC SINTs */
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
+#endif
 
 static u32 synic_event_ring_get_queued_port(u32 sint_index)
 {
@@ -456,9 +463,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
-#ifdef HYPERVISOR_CALLBACK_VECTOR
 	union hv_synic_sint sint;
-#endif
 	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
@@ -501,10 +506,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 
-#ifdef HYPERVISOR_CALLBACK_VECTOR
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+	enable_percpu_irq(mshv_sint_irq, 0);
+#endif
+
 	/* Enable intercepts */
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = mshv_sint_vector;
 	sint.masked = false;
 	sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
@@ -512,13 +520,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 
 	/* Doorbell SINT */
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = mshv_sint_vector;
 	sint.masked = false;
 	sint.as_intercept = 1;
 	sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
 			      sint.as_uint64);
-#endif
 
 	/* Enable global synic bit */
 	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
@@ -573,6 +580,10 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
 			      sint.as_uint64);
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+	disable_percpu_irq(mshv_sint_irq);
+#endif
+
 	/* Disable Synic's event ring page */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 	sirbp.sirbp_enabled = false;
@@ -680,14 +691,149 @@ static struct notifier_block mshv_synic_reboot_nb = {
 	.notifier_call = mshv_synic_reboot_notify,
 };
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+#ifdef CONFIG_ACPI
+static long __percpu *mshv_evt;
+
+static acpi_status mshv_walk_resources(struct acpi_resource *res, void *ctx)
+{
+	struct resource r;
+
+	if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
+		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
+			pr_err("Unable to parse MSHV ACPI interrupt\n");
+			return AE_ERROR;
+		}
+		/* ARM64 INTID */
+		mshv_sint_vector = res->data.extended_irq.interrupts[0];
+		/* Linux IRQ number */
+		mshv_sint_irq = r.start;
+	}
+
+	return AE_OK;
+}
+
+static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
+{
+	mshv_isr();
+	return IRQ_HANDLED;
+}
+
+static int mshv_sint_probe(struct platform_device *pdev)
+{
+	acpi_status result;
+	int ret;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
+	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+					mshv_walk_resources, NULL);
+	if (ACPI_FAILURE(result)) {
+		ret = -ENODEV;
+		goto out_fail;
+	}
+
+	mshv_evt = alloc_percpu(long);
+	if (!mshv_evt) {
+		ret = -ENOMEM;
+		goto out_fail;
+	}
+
+	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
+		mshv_evt);
+	if (ret)
+		goto free_evt;
+
+	return 0;
+
+free_evt:
+	free_percpu(mshv_evt);
+out_fail:
+	mshv_sint_vector = -1;
+	mshv_sint_irq = -1;
+	return ret;
+}
+
+static void mshv_sint_remove(struct platform_device *pdev)
+{
+	free_percpu_irq(mshv_sint_irq, mshv_evt);
+	free_percpu(mshv_evt);
+}
+#else
+static int mshv_sint_probe(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+
+static void mshv_sint_remove(struct platform_device *pdev)
+{
+}
+#endif
+
+static const __maybe_unused struct acpi_device_id mshv_sint_device_ids[] = {
+	{"MSFT1003", 0},
+	{"", 0},
+};
+
+static struct platform_driver mshv_sint_drv = {
+	.probe = mshv_sint_probe,
+	.remove = mshv_sint_remove,
+	.driver = {
+		.name = "mshv_sint",
+		.acpi_match_table = ACPI_PTR(mshv_sint_device_ids),
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+	},
+};
+
+static int __init mshv_sint_vector_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	ret = platform_driver_register(&mshv_sint_drv);
+	if (ret)
+		return ret;
+
+	if (mshv_sint_vector == -1 || mshv_sint_irq == -1) {
+		platform_driver_unregister(&mshv_sint_drv);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void mshv_sint_vector_cleanup(void)
+{
+	platform_driver_unregister(&mshv_sint_drv);
+}
+#else /* HYPERVISOR_CALLBACK_VECTOR */
+static int __init mshv_sint_vector_init(void)
+{
+	mshv_sint_vector = HYPERVISOR_CALLBACK_VECTOR;
+	return 0;
+}
+
+static void mshv_sint_vector_cleanup(void)
+{
+}
+#endif /* HYPERVISOR_CALLBACK_VECTOR */
+
 int __init mshv_synic_init(struct device *dev)
 {
 	int ret = 0;
 
+	ret = mshv_sint_vector_init();
+	if (ret) {
+		dev_err(dev, "Failed to get MSHV SINT vector: %i\n", ret);
+		return ret;
+	}
+
 	synic_pages = alloc_percpu(struct hv_synic_pages);
 	if (!synic_pages) {
 		dev_err(dev, "Failed to allocate percpu synic page\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto sint_vector_cleanup;
 	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
@@ -712,6 +858,8 @@ int __init mshv_synic_init(struct device *dev)
 	cpuhp_remove_state(synic_cpuhp_online);
 free_synic_pages:
 	free_percpu(synic_pages);
+sint_vector_cleanup:
+	mshv_sint_vector_cleanup();
 	return ret;
 }
 
@@ -721,4 +869,5 @@ void mshv_synic_cleanup(void)
 		unregister_reboot_notifier(&mshv_synic_reboot_nb);
 	cpuhp_remove_state(synic_cpuhp_online);
 	free_percpu(synic_pages);
+	mshv_sint_vector_cleanup();
 }
-- 
2.34.1


