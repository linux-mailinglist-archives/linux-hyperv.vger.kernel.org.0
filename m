Return-Path: <linux-hyperv+bounces-8782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOM+GvO3jGnlsQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8782-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:10:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14C126731
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653A33018292
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0133EAEC;
	Wed, 11 Feb 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="xOSBqPEx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8693451AA;
	Wed, 11 Feb 2026 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829681; cv=pass; b=AaBr9krfzi0QQwa+nKBjiE/4axS2zWwho1LmpFWLEd6ouO4rMILDRlArvK8uDNEge+fzygrdF32OIoO2CCFOCZzsDK3AJ0UXa7xBmeN+SoLR0sSkcxJkKM+c6Q4b1aXS/ILKqEtrpLtRx5+RnXpCNOq95NSrL3moDqf++9Ems2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829681; c=relaxed/simple;
	bh=E/8t7p72FAMDZ6WETg4v8GYmJD8WhI92mmghyoxWm18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=broUrtRQ/SSQLb6/UpYoKumZbMU/oeNgIcLlrpd8m5ktuXMyMejJxBYaoNpbOtEpfRr7hVvroGOS08lfqeAe4mJRXUECSvgLhj8jLvRT7cpWyNQ2b/RDIxRBLD1hLyViQfddB1sOiXNJ7VQXveuyWZ98oCN3w5LR2lUqMiP0Mvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=xOSBqPEx; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770829673; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T68GaAq2yv1cW1IbuN2CMYUqoRjlm1dtrWrtrgGksuQaMglACKJ0e5tz1Qtz43hG7+aIENX54IJZyNdKKjlZPzhiOLMLf/E0Y5GIASji1KFgGjqlz9JrQK26q7yKYvyAtPEbVmYJbgXtln4MTyFBbEvqxvgmi6enCDBpbbzf7aI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770829673; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kWX8dD/WVaZcqwciWqSY4AstmFy4lnYtScH7W+qMPt0=; 
	b=mzz7XUuRDcr5sLfbbO8Lsdho/6UnICXkt0qPhuiqsEhgxOiYOjCY5fL8ZZfC3wSyYcdHkTFwXML/HzOT95qMwLhRfW4zMXKNNje3+HtKklUOm0U1D9shgVSmIbPH/1r9ejVA+Stej4RdcLE37sJd+KqYJw06jpsZ+wfmWm4XrWs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770829673;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kWX8dD/WVaZcqwciWqSY4AstmFy4lnYtScH7W+qMPt0=;
	b=xOSBqPExEwyyFUlPcLql86K5kCLiglBFJWiCrUsCbgjC3VKi/FHtJpaquSbvkwjh
	x7qGZIZEfk0JXfZ1puHU7UG27cLBfDtOMF1fm5PEvzBhZpThLo66V7rNMA02ZUGe/Hh
	/jAu8S82pwDhV43S+W2hPP0u/Kcp9XmaRo5jm0ow=
Received: by mx.zohomail.com with SMTPS id 1770829672047455.300085197527;
	Wed, 11 Feb 2026 09:07:52 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v4 2/2] mshv: add arm64 support for doorbell & intercept SINTs
Date: Wed, 11 Feb 2026 17:07:28 +0000
Message-Id: <20260211170728.3056226-3-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211170728.3056226-1-anirudh@anirudhrb.com>
References: <20260211170728.3056226-1-anirudh@anirudhrb.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8782-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:mid,anirudhrb.com:dkim,anirudhrb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE14C126731
X-Rspamd-Action: no action

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the hypervisor exposes a synthetic register that can be read
to find the INTID that should be used for SINTs. This INTID is in the
PPI range.

To better unify the code paths, introduce mshv_sint_vector_init() that
either reads the synthetic register and obtains the INTID (arm64) or
just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_synic.c     | 112 +++++++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h |   2 +
 2 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 074e37c48876..7957ad0328dd 100644
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
@@ -683,14 +694,98 @@ static struct notifier_block mshv_synic_reboot_nb = {
 	.notifier_call = mshv_synic_reboot_notify,
 };
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+#ifdef CONFIG_ACPI
+static long __percpu *mshv_evt;
+#endif
+
+static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
+{
+	mshv_isr();
+	return IRQ_HANDLED;
+}
+
+static int __init mshv_sint_vector_init(void)
+{
+#ifdef CONFIG_ACPI
+	int ret;
+	struct hv_register_assoc reg = {
+		.name = HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
+	};
+	union hv_input_vtl input_vtl = { 0 };
+
+	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				1, input_vtl, &reg);
+	if (ret || !reg.value.reg64)
+		return -ENODEV;
+
+	mshv_sint_vector = reg.value.reg64;
+	ret  = acpi_register_gsi(NULL, mshv_sint_vector, ACPI_EDGE_SENSITIVE,
+					ACPI_ACTIVE_HIGH);
+	if (ret < 0)
+		goto out_fail;
+
+	mshv_sint_irq = ret;
+
+	mshv_evt = alloc_percpu(long);
+	if (!mshv_evt) {
+		ret = -ENOMEM;
+		goto out_unregister;
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
+out_unregister:
+	acpi_unregister_gsi(mshv_sint_vector);
+out_fail:
+	return ret;
+#else
+	return -ENODEV;
+#endif
+}
+
+static void mshv_sint_vector_cleanup(void)
+{
+#ifdef CONFIG_ACPI
+	free_percpu_irq(mshv_sint_irq, mshv_evt);
+	free_percpu(mshv_evt);
+	acpi_unregister_gsi(mshv_sint_vector);
+#endif
+}
+#else /* !HYPERVISOR_CALLBACK_VECTOR */
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
@@ -713,6 +808,8 @@ int __init mshv_synic_init(struct device *dev)
 	cpuhp_remove_state(synic_cpuhp_online);
 free_synic_pages:
 	free_percpu(synic_pages);
+sint_vector_cleanup:
+	mshv_sint_vector_cleanup();
 	return ret;
 }
 
@@ -721,4 +818,5 @@ void mshv_synic_cleanup(void)
 	unregister_reboot_notifier(&mshv_synic_reboot_nb);
 	cpuhp_remove_state(synic_cpuhp_online);
 	free_percpu(synic_pages);
+	mshv_sint_vector_cleanup();
 }
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 30fbbde81c5c..7676f78e0766 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1117,6 +1117,8 @@ enum hv_register_name {
 	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
 
 	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
+#elif defined(CONFIG_ARM64)
+	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	= 0x00070001,
 #endif
 };
 
-- 
2.34.1


