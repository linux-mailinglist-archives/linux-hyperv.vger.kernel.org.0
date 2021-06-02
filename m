Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74F0399165
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFBRW5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3C45120B800D;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C45120B800D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=kUB2qnEqQNHgFZw8QsVpodTAnhZ1toRX3gB0NY9UQwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nM0OroTeTNcwX7Atdb9ClXRh89kYGE5fOw2AY1SMnAAdGDs/RqMT4+lBGEPTOHk5D
         YrmDTOYez7TWzMrjWLqnkA2rFx539ji+3ykEgT/7klV97leHJUrxmhhXuaCdW/KEkd
         77MU5x7OA3GwQz7bjGLdlzeApFZHyWq6xK9qe/yg=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 05/17] mshv: SynIC event ring and event flags support
Date:   Wed,  2 Jun 2021 17:20:50 +0000
Message-Id: <b0231e97ba26fede0d1f31acca488f5461340d74.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Doorbell is a  mechanism by which a parent partition can register for
notification if a specified mmio address is touched by a child partition.
Parent partition can setup the notification by specifying mmio address,
size of the data written(1/2/4/8 bytes) and optionally the data as well.

Hyper-V makes use of an event ring buffer to signal events. This
buffer is implemented as a GPA overlay page. Doorbell notifications are
delivered via this event ring buffer.

Enable SynIC event ring buffer.

While at it, enable SynIC event flags. It is a lightweight inter-partition
communication mechanism to signal events between partitions or from
hypervisor to a partition.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h |  2 +
 drivers/hv/hv_synic.c              | 81 +++++++++++++++++++++++++++---
 drivers/hv/mshv_main.c             |  6 +--
 include/asm-generic/hyperv-tlfs.h  | 29 +++++++++++
 include/linux/mshv.h               |  8 ++-
 5 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 871f5d014ae0..e4b0eea1703e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -189,6 +189,7 @@ enum hv_isolation_type {
 #define HV_REGISTER_SIEFP			0x40000082
 #define HV_REGISTER_SIMP			0x40000083
 #define HV_REGISTER_EOM				0x40000084
+#define HV_REGISTER_SIRBP			0x40000085
 #define HV_REGISTER_SINT0			0x40000090
 #define HV_REGISTER_SINT1			0x40000091
 #define HV_REGISTER_SINT2			0x40000092
@@ -252,6 +253,7 @@ enum hv_isolation_type {
 #define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
 #define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
 #define HV_X64_MSR_EOM			HV_REGISTER_EOM
+#define HV_X64_MSR_SIRBP		HV_REGISTER_SIRBP
 #define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
 #define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
 #define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
index 9800ae6693a9..a2f712acca82 100644
--- a/drivers/hv/hv_synic.c
+++ b/drivers/hv/hv_synic.c
@@ -19,8 +19,8 @@
 
 void mshv_isr(void)
 {
-	struct hv_message_page **msg_page =
-			this_cpu_ptr(mshv.synic_message_page);
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
 	struct hv_message *msg;
 	u32 message_type;
 	struct mshv_partition *partition;
@@ -115,10 +115,16 @@ void mshv_isr(void)
 int mshv_synic_init(unsigned int cpu)
 {
 	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sirbp sirbp;
 	union hv_synic_sint sint;
 	union hv_synic_scontrol sctrl;
-	struct hv_message_page **msg_page =
-			this_cpu_ptr(mshv.synic_message_page);
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_synic_event_flags_page **event_flags_page =
+			&spages->synic_event_flags_page;
+	struct hv_synic_event_ring_page **event_ring_page =
+			&spages->synic_event_ring_page;
 
 	/* Setup the Synic's message page */
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
@@ -127,11 +133,35 @@ int mshv_synic_init(unsigned int cpu)
 			     HV_HYP_PAGE_SIZE,
                              MEMREMAP_WB);
 	if (!(*msg_page)) {
-		pr_err("%s: memremap failed\n", __func__);
+		pr_err("%s: SIMP memremap failed\n", __func__);
 		return -EFAULT;
 	}
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
 
+	/* Setup the Synic's event flags page */
+	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.siefp_enabled = true;
+	*event_flags_page = memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
+		     PAGE_SIZE, MEMREMAP_WB);
+
+	if (!(*event_flags_page)) {
+		pr_err("%s: SIEFP memremap failed\n", __func__);
+		goto cleanup;
+	}
+	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+
+	/* Setup the Synic's event ring page */
+	sirbp.as_uint64 = hv_get_register(HV_REGISTER_SIRBP);
+	sirbp.sirbp_enabled = true;
+	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
+		     PAGE_SIZE, MEMREMAP_WB);
+
+	if (!(*event_ring_page)) {
+		pr_err("%s: SIRBP memremap failed\n", __func__);
+		goto cleanup;
+	}
+	hv_set_register(HV_REGISTER_SIRBP, sirbp.as_uint64);
+
 	/* Enable intercepts */
 	sint.as_uint64 = 0;
 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
@@ -150,15 +180,40 @@ int mshv_synic_init(unsigned int cpu)
 	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
 
 	return 0;
+
+cleanup:
+	if (*event_ring_page) {
+		sirbp.sirbp_enabled = false;
+		hv_set_register(HV_REGISTER_SIRBP, sirbp.as_uint64);
+		memunmap(*event_ring_page);
+	}
+	if (*event_flags_page) {
+		siefp.siefp_enabled = false;
+		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+		memunmap(*event_flags_page);
+	}
+	if (*msg_page) {
+		simp.simp_enabled = false;
+		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+		memunmap(*msg_page);
+	}
+
+	return -EFAULT;
 }
 
 int mshv_synic_cleanup(unsigned int cpu)
 {
 	union hv_synic_sint sint;
 	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sirbp sirbp;
 	union hv_synic_scontrol sctrl;
-	struct hv_message_page **msg_page =
-			this_cpu_ptr(mshv.synic_message_page);
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_synic_event_flags_page **event_flags_page =
+		&spages->synic_event_flags_page;
+	struct hv_synic_event_ring_page **event_ring_page =
+		&spages->synic_event_ring_page;
 
 	/* Disable the interrupt */
 	sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
@@ -166,6 +221,18 @@ int mshv_synic_cleanup(unsigned int cpu)
 	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
 			sint.as_uint64);
 
+	/* Disable Synic's event ring page */
+	sirbp.as_uint64 = hv_get_register(HV_REGISTER_SIRBP);
+	sirbp.sirbp_enabled = false;
+	hv_set_register(HV_REGISTER_SIRBP, sirbp.as_uint64);
+	memunmap(*event_ring_page);
+
+	/* Disable Synic's event flags page */
+	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.siefp_enabled = false;
+	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	memunmap(*event_flags_page);
+
 	/* Disable Synic's message page */
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = false;
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index fe6fb2668d36..2adae676dba5 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -1118,8 +1118,8 @@ __init mshv_init(void)
 		return ret;
 	}
 
-	mshv.synic_message_page = alloc_percpu(struct hv_message_page *);
-	if (!mshv.synic_message_page) {
+	mshv.synic_pages = alloc_percpu(struct hv_synic_pages);
+	if (!mshv.synic_pages) {
 		pr_err("%s: failed to allocate percpu synic page\n", __func__);
 		misc_deregister(&mshv_dev);
 		return -ENOMEM;
@@ -1144,7 +1144,7 @@ static void
 __exit mshv_exit(void)
 {
 	cpuhp_remove_state(mshv_cpuhp_online);
-	free_percpu(mshv.synic_message_page);
+	free_percpu(mshv.synic_pages);
 
 	misc_deregister(&mshv_dev);
 }
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 8f08d0e9163d..f70391a3320f 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -279,8 +279,23 @@ struct hv_timer_message_payload {
 	__u64 delivery_time;	/* When the message was delivered */
 } __packed;
 
+/* Define the synthentic interrupt controller event ring format */
+#define HV_SYNIC_EVENT_RING_MESSAGE_COUNT 63
+
+struct hv_synic_event_ring {
+	u8  signal_masked;
+	u8  ring_full;
+	u16 reserved_z;
+	u32 data[HV_SYNIC_EVENT_RING_MESSAGE_COUNT];
+} __packed;
+
+struct hv_synic_event_ring_page {
+	volatile struct hv_synic_event_ring sint_event_ring[HV_SYNIC_SINT_COUNT];
+};
+
 /* Define synthetic interrupt controller flag constants. */
 #define HV_EVENT_FLAGS_COUNT		(256 * 8)
+#define HV_EVENT_FLAGS_BYTE_COUNT	(256)
 #define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
 
 /*
@@ -304,9 +319,14 @@ union hv_stimer_config {
 
 /* Define the synthetic interrupt controller event flags format. */
 union hv_synic_event_flags {
+	unsigned char flags8[HV_EVENT_FLAGS_BYTE_COUNT];
 	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
 };
 
+struct hv_synic_event_flags_page {
+	volatile union hv_synic_event_flags event_flags[HV_SYNIC_SINT_COUNT];
+};
+
 /* Define SynIC control register. */
 union hv_synic_scontrol {
 	u64 as_uint64;
@@ -349,6 +369,15 @@ union hv_synic_siefp {
 	} __packed;
 };
 
+union hv_synic_sirbp {
+	u64 as_uint64;
+	struct {
+		u64 sirbp_enabled:1;
+		u64 preserved:11;
+		u64 base_sirbp_gpa:52;
+	} __packed;
+};
+
 struct hv_vpset {
 	u64 format;
 	u64 valid_bank_mask;
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 33f4d0cfee11..679aa3fa8cdb 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -49,8 +49,14 @@ struct mshv_partition {
 	} vps;
 };
 
+struct hv_synic_pages {
+	struct hv_message_page *synic_message_page;
+	struct hv_synic_event_flags_page *synic_event_flags_page;
+	struct hv_synic_event_ring_page *synic_event_ring_page;
+};
+
 struct mshv {
-	struct hv_message_page __percpu **synic_message_page;
+	struct hv_synic_pages __percpu *synic_pages;
 	struct {
 		spinlock_t lock;
 		u64 count;
-- 
2.25.1

