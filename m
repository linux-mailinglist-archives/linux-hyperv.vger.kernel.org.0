Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B16399168
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFBRW5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51158 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6C1D420B8013;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C1D420B8013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=+TSbGngTue63bY8gIF10bzOMWI3JSQvihdSXxwQiNPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBR24jWFfgw8fp8WMoZuUAw+kEGIa4tidCvVAo6lKz+SywMvOMZyWcvh4AkgUrS7u
         qo0x9wmFnIcAD8zcwu3dVwkCeOZQTZqV98k1c1+fmN1pzRxAphYtdPFPulQdOazsGl
         gbbWnk8INSMd1XCHaXhj7qnNDDSFnuD23D9j+d7I=
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
Subject: [PATCH 07/17] hyperv: Configure SINT for Doorbell
Date:   Wed,  2 Jun 2021 17:20:52 +0000
Message-Id: <f07b8f1636ecf6f7bf69c31c42f9edb57c85e4ae.1622654100.git.viremana@linux.microsoft.com>
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

Doorbell events are delivered by a SynIC interrupt. Configure a SynIC
interrupt source for doorbell.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_synic.c             | 30 +++++++++++++++++++++++++-----
 include/asm-generic/hyperv-tlfs.h | 15 ++++++++++++++-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
index a2f712acca82..6a00c66edc3f 100644
--- a/drivers/hv/hv_synic.c
+++ b/drivers/hv/hv_synic.c
@@ -112,6 +112,15 @@ void mshv_isr(void)
 	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
 }
 
+static inline bool hv_recommend_using_aeoi(void)
+{
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	return false;
+#endif
+}
+
 int mshv_synic_init(unsigned int cpu)
 {
 	union hv_synic_simp simp;
@@ -166,14 +175,19 @@ int mshv_synic_init(unsigned int cpu)
 	sint.as_uint64 = 0;
 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	sint.masked = false;
-#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
-	sint.auto_eoi =	!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
-#else
-	sint.auto_eoi = 0;
-#endif
+	sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
 			sint.as_uint64);
 
+	/* Doorbell SINT */
+	sint.as_uint64 = 0;
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+	sint.as_intercept = 1;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
+			sint.as_uint64);
+
 	/* Enable global synic bit */
 	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
 	sctrl.enable = 1;
@@ -221,6 +235,12 @@ int mshv_synic_cleanup(unsigned int cpu)
 	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
 			sint.as_uint64);
 
+	/* Disable Doorbell SINT */
+	sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX);
+	sint.masked = true;
+	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
+			sint.as_uint64);
+
 	/* Disable Synic's event ring page */
 	sirbp.as_uint64 = hv_get_register(HV_REGISTER_SIRBP);
 	sirbp.sirbp_enabled = false;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 42e0237b0da8..3ed4f532ed57 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -262,6 +262,9 @@ enum hv_status {
 #define HV_SYNIC_HVL_SHARED_SINT_INDEX   0x00000004
 #define HV_SYNIC_FIRST_UNUSED_SINT_INDEX 0x00000005
 
+/* mshv assigned SINT for doorbell */
+#define HV_SYNIC_DOORBELL_SINT_INDEX     HV_SYNIC_FIRST_UNUSED_SINT_INDEX
+
 #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
@@ -284,6 +287,14 @@ struct hv_timer_message_payload {
 	__u64 delivery_time;	/* When the message was delivered */
 } __packed;
 
+/*
+ * Message format for notifications delivered via
+ * intercept message(as_intercept=1)
+ */
+struct hv_notification_message_payload {
+	u32 sint_index;
+} __packed;
+
 /* Define the synthentic interrupt controller event ring format */
 #define HV_SYNIC_EVENT_RING_MESSAGE_COUNT 63
 
@@ -350,7 +361,9 @@ union hv_synic_sint {
 		u64 masked:1;
 		u64 auto_eoi:1;
 		u64 polling:1;
-		u64 reserved2:45;
+		u64 as_intercept: 1;
+		u64 proxy: 1;
+		u64 reserved2:43;
 	} __packed;
 };
 
-- 
2.25.1

