Return-Path: <linux-hyperv+bounces-10302-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MObFHuQ26GkbHAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10302-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:48:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CC844199F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2182B308F05C
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83B389E04;
	Wed, 22 Apr 2026 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KSXqriht"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2437F75B;
	Wed, 22 Apr 2026 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825243; cv=none; b=Zeu/kspUik3w7j9TidQSQPvibPFQ2ieXAAHPIRm46KiCuRpUTGgprwrZBH8vZ5sDHTFhLdaGRpvW+gvvsYnR5zrHZR2OjNPbb+ywcsp0Y1ebxOslTCLktX6KKC2Y+D87h3LnZwWNcudn7YSkd7spY2U+kFQcTVnzrXwqMqfhnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825243; c=relaxed/simple;
	bh=i0VTBJ+JnPrBDXBmboabc0DGz729xEaksDvoWqta6X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeEONEXlbnW4DUH5Ik1BKqxENGx5BcEeIXf9HpQmZmKExkb7I5uWMn5QcB3+LDP9JUZE0QYcCCWm5izcNKULlZ4lUQ579DUNZcRfwb/KkhES7VSeeFAi0OhHtDDKNyyTWp7lUF1qugb4tpo5i7i09SuMEIXIzt496+X2udcUbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KSXqriht; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED9A020B6F21;
	Tue, 21 Apr 2026 19:33:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED9A020B6F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825229;
	bh=0bjgMj0k5nPoMwets23GFJzSwvZMJJftuqSY4+V25iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSXqrihtAgVG9XWdFdwCwru9n3hQ4behZV7iMeZ+4xukeURssOqspE+157qhVzqtE
	 FcWf0Kqa9z1IMmlXd0RXAk5UDgU6m+Krr21XJYtyiHUD3hPw94cm3d4ANawOaG/guA
	 k8Sc0Ahq2V7Pyqtx95aCFFwz+95MqfwUe9gjoEwc=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V1 09/13] mshv: Import data structs around device passthru from hyperv headers
Date: Tue, 21 Apr 2026 19:32:35 -0700
Message-ID: <20260422023239.1171963-10-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10302-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B1CC844199F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Copy/import from Hyper-V public headers, definitions and declarations that
are related to attaching and detaching of device domains, and building
device ids for those purposes.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |  11 ++++
 include/hyperv/hvhdk_mini.h | 112 ++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..da622fb06440 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -326,6 +326,9 @@ union hv_hypervisor_version_info {
 /* stimer Direct Mode is available */
 #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
 
+#define HV_DEVICE_DOMAIN_AVAILABLE			BIT(24)
+#define HV_S1_DEVICE_DOMAIN_AVAILABLE			BIT(25)
+
 /*
  * Implementation recommendations. Indicates which behaviors the hypervisor
  * recommends the OS implement for optimal performance.
@@ -475,6 +478,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
 #define HVCALL_RETARGET_INTERRUPT			0x007e
+#define HVCALL_ATTACH_DEVICE                            0x0082
+#define HVCALL_DETACH_DEVICE                            0x0083
 #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
 #define HVCALL_ENTER_SLEEP_STATE			0x0084
 #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
@@ -486,9 +491,15 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
+#define HVCALL_CREATE_DEVICE_DOMAIN                     0x00b1
+#define HVCALL_ATTACH_DEVICE_DOMAIN                     0x00b2
+#define HVCALL_MAP_DEVICE_GPA_PAGES                     0x00b3
+#define HVCALL_UNMAP_DEVICE_GPA_PAGES                   0x00b4
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
 #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
 #define HVCALL_DISPATCH_VP				0x00c2
+#define HVCALL_DETACH_DEVICE_DOMAIN                     0x00c4
+#define HVCALL_DELETE_DEVICE_DOMAIN                     0x00c5
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index b4cb2fa26e9b..60425052a799 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -468,6 +468,32 @@ struct hv_send_ipi_ex { /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI_EX */
 	struct hv_vpset vp_set;
 } __packed;
 
+union hv_attdev_flags {		/* HV_ATTACH_DEVICE_FLAGS */
+	struct {
+		u32 logical_id : 1;
+		u32 resvd0 : 1;
+		u32 ats_enabled : 1;
+		u32 virt_func : 1;
+		u32 shared_irq_child : 1;
+		u32 virt_dev : 1;
+		u32 ats_supported : 1;
+		u32 small_irt : 1;
+		u32 resvd : 24;
+	} __packed;
+	u32 as_uint32;
+};
+
+union hv_dev_pci_caps {		/* HV_DEVICE_PCI_CAPABILITIES */
+	struct {
+		u32 max_pasid_width : 5;
+		u32 invalidate_qdepth : 5;
+		u32 global_inval : 1;
+		u32 prg_response_req : 1;
+		u32 resvd : 20;
+	} __packed;
+	u32 as_uint32;
+};
+
 typedef u16 hv_pci_rid;		/* HV_PCI_RID */
 typedef u16 hv_pci_segment;	/* HV_PCI_SEGMENT */
 typedef u64 hv_logical_device_id;
@@ -547,4 +573,90 @@ union hv_device_id {		/* HV_DEVICE_ID */
 	} acpi;
 } __packed;
 
+struct hv_input_attach_device {         /* HV_INPUT_ATTACH_DEVICE */
+	u64 partition_id;
+	union hv_device_id device_id;
+	union hv_attdev_flags attdev_flags;
+	u8  attdev_vtl;
+	u8  rsvd0;
+	u16 rsvd1;
+	u64 logical_devid;
+	union hv_dev_pci_caps dev_pcicaps;
+	u16 pf_pci_rid;
+	u16 resvd2;
+} __packed;
+
+struct hv_input_detach_device {		/* HV_INPUT_DETACH_DEVICE */
+	u64 partition_id;
+	u64 logical_devid;
+} __packed;
+
+
+/* 3 domain types: stage 1, stage 2, and SOC */
+#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
+#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
+#define HV_DEVICE_DOMAIN_TYPE_SOC 2 /* HV_DEVICE_DOMAIN_ID_TYPE_SOC */
+
+/* ID for stage 2 default domain and NULL domain */
+#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
+#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
+
+union hv_device_domain_id {
+	u64 as_uint64;
+	struct {
+		u32 type : 4;
+		u32 reserved : 28;
+		u32 id;
+	};
+} __packed;
+
+struct hv_input_device_domain { /* HV_INPUT_DEVICE_DOMAIN */
+	u64 partition_id;
+	union hv_input_vtl owner_vtl;
+	u8 padding[7];
+	union hv_device_domain_id domain_id;
+} __packed;
+
+union hv_create_device_domain_flags {	/* HV_CREATE_DEVICE_DOMAIN_FLAGS */
+	u32 as_uint32;
+	struct {
+		u32 forward_progress_required : 1;
+		u32 inherit_owning_vtl : 1;
+		u32 reserved : 30;
+	} __packed;
+} __packed;
+
+struct hv_input_create_device_domain {	/* HV_INPUT_CREATE_DEVICE_DOMAIN */
+	struct hv_input_device_domain device_domain;
+	union hv_create_device_domain_flags create_device_domain_flags;
+} __packed;
+
+struct hv_input_delete_device_domain {	/* HV_INPUT_DELETE_DEVICE_DOMAIN */
+	struct hv_input_device_domain device_domain;
+} __packed;
+
+struct hv_input_attach_device_domain {	/* HV_INPUT_ATTACH_DEVICE_DOMAIN */
+	struct hv_input_device_domain device_domain;
+	union hv_device_id device_id;
+} __packed;
+
+struct hv_input_detach_device_domain {	/* HV_INPUT_DETACH_DEVICE_DOMAIN */
+	u64 partition_id;
+	union hv_device_id device_id;
+} __packed;
+
+struct hv_input_map_device_gpa_pages {	/* HV_INPUT_MAP_DEVICE_GPA_PAGES */
+	struct hv_input_device_domain device_domain;
+	union hv_input_vtl target_vtl;
+	u8 padding[3];
+	u32 map_flags;
+	u64 target_device_va_base;
+	u64 gpa_page_list[];
+} __packed;
+
+struct hv_input_unmap_device_gpa_pages {  /* HV_INPUT_UNMAP_DEVICE_GPA_PAGES */
+	struct hv_input_device_domain device_domain;
+	u64 target_device_va_base;
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.51.2.vfs.0.1


