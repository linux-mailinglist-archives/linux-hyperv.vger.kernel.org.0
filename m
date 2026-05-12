Return-Path: <linux-hyperv+bounces-10785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI2HGQCNAmrzuAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10785-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:14:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D81518C49
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2A3303029B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDAB312807;
	Tue, 12 May 2026 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o3bjvff/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC043043DC;
	Tue, 12 May 2026 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551974; cv=none; b=rpCLOpKUtOWhMG3tHkrBZszBPFdAm+DCL6Uq8SMII+C2nPnvyPmVbgrgr5OYdgebvYk1loq66sMpQNSuC9KiFCQh8jnMhth/XKh4fxazEb0sLFn3mhHzG+V/qYr23zqKvnZ6qXOUSGmaN5bLpsGyYyihs+KsyTjB8JCKdSnCGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551974; c=relaxed/simple;
	bh=k1fyeqFvOWhWiwhuu03xoXEKXIOY/LlOjsI8Du2iXHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG7XVTYplWj7ItdB8iPwwiPqOXSH1cloW5DRvM0qEQYtUfFmSKxlQBZ6ahK0X8AsnwHvPnZlT+MIOwSc4Yt0Nct95ZDDcXEGNAor3L8SyNYwZ2pFcj9pX8zJ+i5rgxCb1T/5841am0jv2Do39gM0wCGXpsnSINF0nRVoXzGuMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o3bjvff/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3048920B7167;
	Mon, 11 May 2026 19:12:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3048920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551970;
	bh=NzAneEtzNkIbXybIamfJGsZ0CM2u/FE+l2+Du+bWYlc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o3bjvff/qJDFWAsGhsQDK+mAyO7QUJKPo0yiJmfBvjotOqeiY8P80JpPZWJzEVV60
	 /LUKtwK8BuZyCleFS7ipHK0dEy2PVEwxBkX8QOoCSO1CMEYcFXYzbIswKaXFRjYKWY
	 rtDUDOu4Kix8e31/1dTtgl2jKMmjiL1XoTQITV/o=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH V1 1/3] mshv: Import declarations for irq remap and add irqbypass support
Date: Mon, 11 May 2026 19:12:40 -0700
Message-ID: <20260512021242.1679786-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260512021242.1679786-1-mrathor@linux.microsoft.com>
References: <20260512021242.1679786-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06D81518C49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10785-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

For the irq map/remap hypercalls, copy relevant data structures from
hypervisor public headers into Linux equivalents. Also, update Kconfig and
mshv_irqfd for irqbypass. Please note, irqbypass is required for doing
passthru on MSHV. This because there is really no way of knowing the linux
irq in the mshv_irqfd_assign and mshv_irqfd_update paths without it. The
linux irq is setup upfront by VFIO before irqfd assign/update happens.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/Kconfig          |  1 +
 drivers/hv/mshv_eventfd.h   |  3 +++
 include/hyperv/hvgdk_mini.h |  3 +++
 include/hyperv/hvhdk.h      | 17 +++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 7937ac0cbd0f..c831fe25ca2b 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -75,6 +75,7 @@ config MSHV_ROOT
 	# no particular order, making it impossible to reassemble larger pages
 	depends on PAGE_SIZE_4KB
 	select EVENTFD
+	select IRQ_BYPASS_MANAGER
 	select VIRT_XFER_TO_GUEST_WORK
 	select HMM_MIRROR
 	select MMU_NOTIFIER
diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
index 464c6b81ab33..ff4dd24b8ad4 100644
--- a/drivers/hv/mshv_eventfd.h
+++ b/drivers/hv/mshv_eventfd.h
@@ -9,6 +9,7 @@
 #define __LINUX_MSHV_EVENTFD_H
 
 #include <linux/poll.h>
+#include <linux/irqbypass.h>
 
 #include "mshv.h"
 #include "mshv_root.h"
@@ -37,6 +38,8 @@ struct mshv_irqfd {
 	struct mshv_irqfd_resampler	    *irqfd_resampler;
 	struct eventfd_ctx		    *irqfd_resamplefd;
 	struct hlist_node		     irqfd_resampler_hnode;
+	struct irq_bypass_consumer	     irqfd_bypass_cons;
+	struct irq_bypass_producer	    *irqfd_bypass_prod;
 };
 
 void mshv_eventfd_init(struct mshv_partition *partition);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index da622fb06440..1ef480825705 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -59,6 +59,8 @@ struct hv_u128 {
 #define HV_PARTITION_ID_INVALID		((u64)0)
 #define HV_PARTITION_ID_SELF		((u64)-1)
 
+#define HV_MAX_VPS    256               /* HV_MAXIMUM_PROCESSORS */
+
 /* Hyper-V specific model specific registers (MSRs) */
 
 #if defined(CONFIG_X86)
@@ -508,6 +510,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_UNMAP_VP_STATE_PAGE			0x00e2
 #define HVCALL_GET_VP_STATE				0x00e3
 #define HVCALL_SET_VP_STATE				0x00e4
+#define HVCALL_GET_VPSET_FROM_MDA                       0x00e5
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
 #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
 #define HVCALL_MMIO_READ				0x0106
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 5e83d3714966..d0a892347ab1 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -952,4 +952,21 @@ struct hv_input_modify_sparse_spa_page_host_access {
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
 
+#ifdef CONFIG_X86
+
+struct hv_input_get_vp_set_from_mda {   /* HV_OUTPUT_GET_VP_SET_FROM_MDA */
+	u64 target_partid;
+	u64 dest_address;
+	u8  input_vtl;
+	u8  destmode_logical;         /* true => mode is logical */
+	u16 reserved0;                /* mbz */
+	u32 reserved1;                /* mbz */
+} __packed;
+
+union hv_output_get_vp_set_from_mda {  /* HV_OUTPUT_GET_VP_SET_FROM_MDA */
+	struct hv_vpset target_vpset;
+	u64 bitset_buffer[HV_GENERIC_SET_QWORD_COUNT(HV_MAX_VPS)];
+} __packed;
+
+#endif /* CONFIG_X86 */
 #endif /* _HV_HVHDK_H */
-- 
2.51.2.vfs.0.1


