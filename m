Return-Path: <linux-hyperv+bounces-8983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DgFFg3vnmk/XwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8983-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:46:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EEA1978B3
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69C530A9DC9
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F603B8BA4;
	Wed, 25 Feb 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="qOgPZIrR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1A3AE718;
	Wed, 25 Feb 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023479; cv=pass; b=LcXNvhqxoGD3danbk4YM/xrnpXWcg5sT5a05+riTLW8eS0TKzWLnqWh+qHb/Z4rLf7nwMGoaNWlGbeZaH2e2xUmgqmmoSEubfzdxJZcUb7G65wuhlJkv2pAx9VHk5fkxUuDlzrAUI4uHCTx7wT6kPyk0ki02Dx186L7YPd4/4/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023479; c=relaxed/simple;
	bh=RxR/oi0rOYoCMAb2sBCv8X6o3fpeeP+8oQ4uM+kDhHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRZ9ApUuhpQ2L4u6H2X9NNmrrl+fxJVyO1RD/KyKfLJoz9a8MHFextBSmhrbo8P4u5gpvFnCyES3zhoZFNR9e0dyRDPzxmy1RURiUPN72N+sFnZAPUNJCJsFf4UqvnaaV2MqY5GjWFwZzIXNZRsuPy2Oo/wKXhv+mDVl0/4cF5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=qOgPZIrR; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1772023464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lhqnLLgQeWrjxNPsqbmUJpN2bNICBJsuNc1QQqx34DIw6dwH6UX2jzH9wwyqc3Rp1EAuOMK/OWJGxTv/8ccFUvXwq3Yhk7Oo2/Ouee3OtkFukQHJoiEUZiaJibeAsO37sc5VQ15YV8MS88t30uDO2ItnPRkGMJcm53ly/xdUYz0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772023464; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ymeZAGX/HEhwO2fptLx3iDYagZh6YeFQ6xUqLXHq6Fg=; 
	b=Y0h0QCAmMc+qteMAZ4ZJTel5kH4vxfss8IKFIpW0AUq8Y4EmdbVC3dCRghLKqLqi3CxxnpdCB+tAf3qOvi7v64WlqlWZbOBO2mWD15hIz7UuwO6fdNSQA3fGznC1dNkDaZWw9R1iteUshOgmuM8638ow2kxOa/khc6shikcun2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772023464;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ymeZAGX/HEhwO2fptLx3iDYagZh6YeFQ6xUqLXHq6Fg=;
	b=qOgPZIrRkMOiRBFYDwzfiuWhqzQqsfI2iS6hibTg/BnqzhRF/fGQuL/cAPWVj6P+
	M3sPGmskep62CCe7T9RFTiYSQfVDRok8cFTGgv63tcvYSPK9m5UfM+6T0xo7T4NIPC8
	MICifH/U92DDKAg51QkNSWgs7fy8FUBhenS3065o=
Received: by mx.zohomail.com with SMTPS id 1772023462929869.887002562424;
	Wed, 25 Feb 2026 04:44:22 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com,
	Michael Kelley <mhklinux@outlook.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Subject: [PATCH v6 2/2] mshv: add arm64 support for doorbell & intercept SINTs
Date: Wed, 25 Feb 2026 12:44:03 +0000
Message-Id: <20260225124403.2187880-3-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225124403.2187880-1-anirudh@anirudhrb.com>
References: <20260225124403.2187880-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[anirudhrb.com,outlook.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8983-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,anirudhrb.com:mid,anirudhrb.com:dkim,anirudhrb.com:email]
X-Rspamd-Queue-Id: C3EEA1978B3
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_synic.c     | 119 +++++++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h |   2 +
 2 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index f716c2a4952f..1e48fce5816b 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -10,17 +10,21 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/random.h>
 #include <linux/cpuhotplug.h>
 #include <linux/reboot.h>
 #include <asm/mshyperv.h>
+#include <linux/acpi.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
 
 static int synic_cpuhp_online;
 static struct hv_synic_pages __percpu *synic_pages;
+static int mshv_sint_vector = -1; /* hwirq for the SynIC SINTs */
+static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
 
 static u32 synic_event_ring_get_queued_port(u32 sint_index)
 {
@@ -442,9 +446,7 @@ void mshv_isr(void)
 		if (msg->header.message_flags.msg_pending)
 			hv_set_non_nested_msr(HV_MSR_EOM, 0);
 
-#ifdef HYPERVISOR_CALLBACK_VECTOR
-		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
-#endif
+		add_interrupt_randomness(mshv_sint_vector);
 	} else {
 		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
 			     msg->header.message_type);
@@ -456,9 +458,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
-#ifdef HYPERVISOR_CALLBACK_VECTOR
 	union hv_synic_sint sint;
-#endif
 	union hv_synic_scontrol sctrl;
 	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
@@ -501,10 +501,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 
-#ifdef HYPERVISOR_CALLBACK_VECTOR
+	if (mshv_sint_irq != -1)
+		enable_percpu_irq(mshv_sint_irq, 0);
+
 	/* Enable intercepts */
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = mshv_sint_vector;
 	sint.masked = false;
 	sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
@@ -512,13 +514,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 
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
@@ -573,6 +574,9 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
 			      sint.as_uint64);
 
+	if (mshv_sint_irq != -1)
+		disable_percpu_irq(mshv_sint_irq);
+
 	/* Disable Synic's event ring page */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 	sirbp.sirbp_enabled = false;
@@ -683,14 +687,106 @@ static struct notifier_block mshv_synic_reboot_nb = {
 	.notifier_call = mshv_synic_reboot_notify,
 };
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+static DEFINE_PER_CPU(long, mshv_evt);
+
+static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
+{
+	mshv_isr();
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_ACPI
+static int __init mshv_acpi_setup_sint_irq(void)
+{
+	return acpi_register_gsi(NULL, mshv_sint_vector, ACPI_EDGE_SENSITIVE,
+					ACPI_ACTIVE_HIGH);
+}
+
+static void mshv_acpi_cleanup_sint_irq(void)
+{
+	acpi_unregister_gsi(mshv_sint_vector);
+}
+#else
+static int __init mshv_acpi_setup_sint_irq(void)
+{
+	return -ENODEV;
+}
+
+static void mshv_acpi_cleanup_sint_irq(void)
+{
+}
+#endif
+
+static int __init mshv_sint_vector_setup(void)
+{
+	int ret;
+	struct hv_register_assoc reg = {
+		.name = HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
+	};
+	union hv_input_vtl input_vtl = { 0 };
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				1, input_vtl, &reg);
+	if (ret || !reg.value.reg64)
+		return -ENODEV;
+
+	mshv_sint_vector = reg.value.reg64;
+	ret = mshv_acpi_setup_sint_irq();
+	if (ret < 0) {
+		pr_err("Failed to setup IRQ for MSHV SINT vector %d: %d\n",
+			mshv_sint_vector, ret);
+		goto out_fail;
+	}
+
+	mshv_sint_irq = ret;
+
+	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
+		&mshv_evt);
+	if (ret)
+		goto out_unregister;
+
+	return 0;
+
+out_unregister:
+	mshv_acpi_cleanup_sint_irq();
+out_fail:
+	return ret;
+}
+
+static void mshv_sint_vector_cleanup(void)
+{
+	free_percpu_irq(mshv_sint_irq, &mshv_evt);
+	mshv_acpi_cleanup_sint_irq();
+}
+#else /* !HYPERVISOR_CALLBACK_VECTOR */
+static int __init mshv_sint_vector_setup(void)
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
 
+	ret = mshv_sint_vector_setup();
+	if (ret)
+		return ret;
+
 	synic_pages = alloc_percpu(struct hv_synic_pages);
 	if (!synic_pages) {
 		dev_err(dev, "Failed to allocate percpu synic page\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto sint_vector_cleanup;
 	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
@@ -713,6 +809,8 @@ int __init mshv_synic_init(struct device *dev)
 	cpuhp_remove_state(synic_cpuhp_online);
 free_synic_pages:
 	free_percpu(synic_pages);
+sint_vector_cleanup:
+	mshv_sint_vector_cleanup();
 	return ret;
 }
 
@@ -721,4 +819,5 @@ void mshv_synic_exit(void)
 	unregister_reboot_notifier(&mshv_synic_reboot_nb);
 	cpuhp_remove_state(synic_cpuhp_online);
 	free_percpu(synic_pages);
+	mshv_sint_vector_cleanup();
 }
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 056ef7b6b360..8bb3dd71c5b4 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1121,6 +1121,8 @@ enum hv_register_name {
 	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
 
 	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
+#elif defined(CONFIG_ARM64)
+	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	= 0x00070001,
 #endif
 };
 
-- 
2.34.1


