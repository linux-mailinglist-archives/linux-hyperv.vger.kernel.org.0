Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D72399169
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFBRW6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51170 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 99EB420B8019;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99EB420B8019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=fDaM2VV4WaJrzYK/e1rP32p6O14RslFTADMAXkXOq3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpESvFf70fxU2oN1raZyFXlwqUrQpfk5Q96QXKxvqo4kE3/w4CUExdjt4Rv/JJPxP
         btCNELhiG7Fd+POymeKDqyjSyW2N4l2TRfEKpYTxiMdXT51llIQ0iTKc+U8EfN/TBh
         hhbSr+J5EzYE71voZDm+vq+By1zbCqBzsecKi7dg=
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
Subject: [PATCH 09/17] mshv: Doorbell handler in hypercall ISR
Date:   Wed,  2 Jun 2021 17:20:54 +0000
Message-Id: <52548d6a476be42d725c8aa21772b35fa5b72f50.1622654100.git.viremana@linux.microsoft.com>
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

Setup doorbell signal to be delivered by intercept interrupt and handle
the doorbell signal.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c              |  32 ++++-
 arch/x86/include/asm/mshyperv.h        |   2 +
 drivers/hv/hv_synic.c                  | 175 +++++++++++++++++++++----
 drivers/hv/mshv.h                      |   2 +-
 include/uapi/asm-generic/hyperv-tlfs.h |   4 +
 5 files changed, 186 insertions(+), 29 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 722bafdb2225..c295ccfdffd7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -51,6 +51,16 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 void  __percpu **hyperv_pcpu_output_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
+/*
+ * Per-cpu array holding the tail pointer for the SynIC event ring buffer
+ * for each SINT.
+ *
+ * We cannot maintain this in mshv driver because the tail pointer should
+ * persist even if the mshv driver is unloaded.
+ */
+u8 __percpu **hv_synic_eventring_tail;
+EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
+
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
@@ -58,11 +68,13 @@ static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	unsigned int order = hv_root_partition ? 1 : 0;
+	u8 **synic_eventring_tail;
 	void **input_arg;
 	struct page *pg;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
-	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
+	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, order);
 	if (unlikely(!pg))
 		return -ENOMEM;
 
@@ -73,6 +85,14 @@ static int hv_cpu_init(unsigned int cpu)
 
 		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*output_arg = page_address(pg + 1);
+
+		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
+						irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+		if (unlikely(!*synic_eventring_tail)) {
+			__free_pages(pg, order);
+			return -ENOMEM;
+		}
 	}
 
 	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
@@ -197,6 +217,7 @@ EXPORT_SYMBOL_GPL(clear_hv_tscchange_cb);
 static int hv_cpu_die(unsigned int cpu)
 {
 	struct hv_reenlightenment_control re_ctrl;
+	u8 **synic_eventring_tail;
 	unsigned int new_cpu;
 	unsigned long flags;
 	void **input_arg;
@@ -212,6 +233,10 @@ static int hv_cpu_die(unsigned int cpu)
 
 		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*output_arg = NULL;
+
+		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+		kfree(*synic_eventring_tail);
+		*synic_eventring_tail = NULL;
 	}
 
 	local_irq_restore(flags);
@@ -390,10 +415,13 @@ void __init hyperv_init(void)
 
 	BUG_ON(hyperv_pcpu_input_arg == NULL);
 
-	/* Allocate the per-CPU state for output arg for root */
 	if (hv_root_partition) {
+		/* Allocate the per-CPU state for output arg for root */
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(hyperv_pcpu_output_arg == NULL);
+
+		hv_synic_eventring_tail = alloc_percpu(u8 *);
+		BUG_ON(hv_synic_eventring_tail == NULL);
 	}
 
 	/* Allocate percpu VP index */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c6eb01f3864d..f780ec35ac44 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -39,6 +39,8 @@ extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
 extern void  __percpu  **hyperv_pcpu_output_arg;
 
+extern u8 __percpu **hv_synic_eventring_tail;
+
 extern u64 hv_current_partition_id;
 
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
index 6a00c66edc3f..e3262f6d3daa 100644
--- a/drivers/hv/hv_synic.c
+++ b/drivers/hv/hv_synic.c
@@ -17,34 +17,124 @@
 
 #include "mshv.h"
 
-void mshv_isr(void)
+u32
+synic_event_ring_get_queued_port(u32 sint_index)
 {
-	struct hv_synic_pages *spages = this_cpu_ptr(mshv.synic_pages);
-	struct hv_message_page **msg_page = &spages->synic_message_page;
-	struct hv_message *msg;
-	u32 message_type;
-	struct mshv_partition *partition;
-	struct mshv_vp *vp;
-	u64 partition_id;
-	u32 vp_index;
-	int i;
-	unsigned long flags;
-	struct task_struct *task;
-
-	if (unlikely(!(*msg_page))) {
-		pr_err("%s: Missing synic page!\n", __func__);
-		return;
+	struct hv_synic_event_ring_page **event_ring_page;
+	volatile struct hv_synic_event_ring *ring;
+	struct hv_synic_pages *spages;
+	u8 **synic_eventring_tail;
+	u32 message;
+	u8 tail;
+
+	spages = this_cpu_ptr(mshv.synic_pages);
+	event_ring_page = &spages->synic_event_ring_page;
+	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+	tail = (*synic_eventring_tail)[sint_index];
+
+	if (unlikely(!(*event_ring_page))) {
+		pr_err("%s: Missing synic event ring page!\n", __func__);
+		return 0;
 	}
 
-	msg = &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
+	ring = &(*event_ring_page)->sint_event_ring[sint_index];
 
 	/*
-	 * If the type isn't set, there isn't really a message;
-	 * it may be some other hyperv interrupt
+	 * Get the message.
 	 */
-	message_type = msg->header.message_type;
-	if (message_type == HVMSG_NONE)
-		return;
+	message = ring->data[tail];
+
+	if (!message) {
+		if (ring->ring_full) {
+			/*
+			 * Ring is marked full, but we would have consumed all
+			 * the messages. Notify the hypervisor that ring is now
+			 * empty and check again.
+			 */
+			ring->ring_full = 0;
+			hv_call_notify_port_ring_empty(sint_index);
+			message = ring->data[tail];
+		}
+
+		if (!message) {
+			ring->signal_masked = 0;
+			/*
+			 * Unmask the signal and sync with hypervisor
+			 * before one last check for any message.
+			 */
+			mb();
+			message = ring->data[tail];
+
+			/*
+			 * Ok, lets bail out.
+			 */
+			if (!message)
+				return 0;
+		}
+
+		ring->signal_masked = 1;
+
+	}
+
+	/*
+	 * Clear the message in the ring buffer.
+	 */
+	ring->data[tail] = 0;
+
+	if (++tail == HV_SYNIC_EVENT_RING_MESSAGE_COUNT)
+		tail = 0;
+
+	(*synic_eventring_tail)[sint_index] = tail;
+
+	return message;
+}
+
+static bool
+mshv_doorbell_isr(struct hv_message *msg)
+{
+	struct hv_notification_message_payload *notification;
+	u32 port;
+
+	if (msg->header.message_type != HVMSG_SYNIC_SINT_INTERCEPT)
+		return false;
+
+	notification = (struct hv_notification_message_payload *)msg->u.payload;
+	if (notification->sint_index != HV_SYNIC_DOORBELL_SINT_INDEX)
+		return false;
+
+	while ((port = synic_event_ring_get_queued_port(
+					HV_SYNIC_DOORBELL_SINT_INDEX))) {
+		struct port_table_info ptinfo = { 0 };
+
+		if (hv_portid_lookup(port, &ptinfo)) {
+			pr_err("Failed to get port information from port_table!\n");
+			continue;
+		}
+
+		if (ptinfo.port_type != HV_PORT_TYPE_DOORBELL) {
+			pr_warn("Not a doorbell port!, port: %d, port_type: %d\n",
+					port, ptinfo.port_type);
+			continue;
+		}
+
+		/* Invoke the callback */
+		ptinfo.port_doorbell.doorbell_cb(port, ptinfo.port_doorbell.data);
+	}
+
+	return true;
+}
+
+static bool
+mshv_intercept_isr(struct hv_message *msg)
+{
+	struct mshv_partition *partition;
+	struct task_struct *task;
+	bool handled = false;
+	unsigned long flags;
+	struct mshv_vp *vp;
+	u64 partition_id;
+	u32 vp_index;
+	int i;
 
 	/* Look for the partition */
 	partition_id = msg->header.sender;
@@ -102,14 +192,47 @@ void mshv_isr(void)
 	 */
 	wake_up_process(task);
 
+	handled = true;
+
 unlock_out:
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
-	/* Acknowledge message with hypervisor */
-	msg->header.message_type = HVMSG_NONE;
-	wrmsrl(HV_X64_MSR_EOM, 0);
+	return handled;
+}
+
+void mshv_isr(void)
+{
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_message *msg;
+	bool handled;
+
+	if (unlikely(!(*msg_page))) {
+		pr_err("%s: Missing synic page!\n", __func__);
+		return;
+	}
+
+	msg = &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
+
+	/*
+	 * If the type isn't set, there isn't really a message;
+	 * it may be some other hyperv interrupt
+	 */
+	if (msg->header.message_type == HVMSG_NONE)
+		return;
 
-	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+	handled = mshv_doorbell_isr(msg);
+
+	if (!handled)
+		handled = mshv_intercept_isr(msg);
+
+	if (handled) {
+		/* Acknowledge message with hypervisor */
+		msg->header.message_type = HVMSG_NONE;
+		wrmsrl(HV_X64_MSR_EOM, 0);
+
+		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+	}
 }
 
 static inline bool hv_recommend_using_aeoi(void)
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index ff5dc02cd8b6..07b0e7865a4c 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -44,7 +44,7 @@ int mshv_synic_cleanup(unsigned int cpu);
  * NOTE: This is called in interrupt context. Callback
  * should defer slow and sleeping logic to later.
  */
-typedef void (*doorbell_cb_t) (void *);
+typedef void (*doorbell_cb_t) (int doorbell_id, void *);
 
 /*
  * port table information
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index 2031115c6cce..ef91b11a12cf 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -31,6 +31,10 @@ enum hv_message_type {
 	/* Trace buffer complete messages. */
 	HVMSG_EVENTLOG_BUFFERCOMPLETE		= 0x80000040,
 
+	/* SynIC intercepts */
+	HVMSG_SYNIC_EVENT_INTERCEPT		= 0x80000060,
+	HVMSG_SYNIC_SINT_INTERCEPT		= 0x80000061,
+
 	/* Platform-specific processor intercept messages. */
 	HVMSG_X64_IO_PORT_INTERCEPT		= 0x80010000,
 	HVMSG_X64_MSR_INTERCEPT			= 0x80010001,
-- 
2.25.1

