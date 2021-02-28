Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224433272C9
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Feb 2021 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhB1PGZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Feb 2021 10:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhB1PFh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Feb 2021 10:05:37 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D231C0617A7;
        Sun, 28 Feb 2021 07:04:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e9so8248816plh.3;
        Sun, 28 Feb 2021 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P153ZkWh5tp6J8fj1sGcfDccB/JR0YTJr+e/Y7u7KxQ=;
        b=tN5Ey0zbJfoSWIKILdpLAP8ByoGIOJvKtLFCseQbfLHOXOsZi6JGJ/j4IMLCL9TbRU
         ccE299UKP3NnQxHaG7fPpuWCHPvaOSz8v2vthcAO8R2qdFI6UvwMwPtUOm3BeCgfOvnM
         PzFeCMFkEdyNQHfm31gcbVrAUPqSlsdB6mD4hcbOJMjRHbP8NnGpyySigKb/xdR/BjAy
         Xrv2dUY1Kc8kinO+DCtQR+gRJJraT2ysdFKit8NdPETFeC5JqKGF5sJppnpMJMQRTnec
         aaCyxvAkvLU7+saspl27+E0A+kzuaME1hXXdjEClIQu3cLQAwsAxKQCCtgPPPSanIJiQ
         sZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P153ZkWh5tp6J8fj1sGcfDccB/JR0YTJr+e/Y7u7KxQ=;
        b=WRHsp3UrvBIk4P4TeEMNB0JI84Dd1P35GKE5M6GPKls2T+yZzVIZ5idjU9ssPbIYZp
         WWXl5KpzF9kZLbeyF2ifQl6mhQ+rvRX2hILOPsc6wJPwqhl9KhdSZo01Dn2i4Bp6E+Qy
         VJXlRz3RaDetPCkG5Ls28O2+hVe04y/fS3DlK5n1n4O0tqsxo6ja9QxTU1lScpB2zfPX
         2mgGRsBH+/gYancGEkhp3wkqBFkpRCmOIwu9DzcolhP4Nqx+k1ruGTK4ifGyE3QOgak2
         Vag0VzVtWT2NHB6mWZHCJCXLJKczPdC5FuDtrrrJq61QrcLPiEEBWsqyCI/guOBvIZtf
         WHAg==
X-Gm-Message-State: AOAM532pmYFaOOPc2HNFaN8Vq9JyHtLIfMR/wXMBtBaJ6HsENaf3YHpi
        2OADU4pXQLYiDVw51CHnyyI=
X-Google-Smtp-Source: ABdhPJx1KIcvcTdTIkrrt4ipOI6uBVyMq5WV98tfAVsyf/VEd28uEpBP9D8o0MFC9Z/XmHaabzKoJg==
X-Received: by 2002:a17:90a:df8a:: with SMTP id p10mr13196207pjv.4.1614524659727;
        Sun, 28 Feb 2021 07:04:19 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:19 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC PATCH 10/12] HV: Add bounce buffer support for Isolation VM
Date:   Sun, 28 Feb 2021 10:03:13 -0500
Message-Id: <20210228150315.2552437-11-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides two kinds of Isolation VMs. VBS(Virtualization-based
security) and AMD SEV-SNP base Isolation VMs. The memory of these vms
are encrypted and host can't access guest memory directly. The
guest needs to call hv host visibility hvcall to mark memory visible
to host before sharing memory with host for IO operation. So there
is bounce buffer request for IO operation to get data from host.
To receive data, host puts data into the shared memory(bounce buffer)
and guest copies the data to private memory. Vice versa.

For SNP isolation VM, guest needs to access the shared memory via
extra address space which is specified by Hyper-V CPUID HYPERV_CPUID_
ISOLATION_CONFIG. The access physical address of the shared memory
should be bounce buffer memory GPA plus with shared_gpa_boundary.

Vmbus channel ring buffer has been marked as host visible and works
as bounce buffer for vmbus devices. vmbus_sendpacket_pagebuffer()
and vmbus_sendpacket_mpb_desc() send package which uses system memory
out of vmbus channel ring buffer. These memory still needs to allocate
additional bounce buffer to commnuicate with host. Add vmbus_sendpacket_
pagebuffer_bounce () and vmbus_sendpacket_mpb_desc_bounce() to handle
such case.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/channel.c      |  13 +-
 drivers/hv/channel_mgmt.c |   1 +
 drivers/hv/hv_bounce.c    | 579 +++++++++++++++++++++++++++++++++++++-
 drivers/hv/hyperv_vmbus.h |  13 +
 include/linux/hyperv.h    |   2 +
 5 files changed, 605 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 976ef99dda28..f5391a050bdc 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1090,7 +1090,11 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+	if (hv_is_isolation_supported())
+		return vmbus_sendpacket_pagebuffer_bounce(channel, &desc,
+			descsize, bufferlist, io_type, bounce_pkt, requestid);
+	else
+		return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
 
@@ -1130,7 +1134,12 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+	if (hv_is_isolation_supported()) {
+		return vmbus_sendpacket_mpb_desc_bounce(channel, desc,
+			desc_size, bufferlist, io_type, bounce_pkt, requestid);
+	} else {
+		return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+	}
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index e2846cacfd70..d8090b2e2421 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -359,6 +359,7 @@ static struct vmbus_channel *alloc_channel(void)
 	if (!channel)
 		return NULL;
 
+	spin_lock_init(&channel->bp_lock);
 	spin_lock_init(&channel->sched_lock);
 	init_completion(&channel->rescind_event);
 
diff --git a/drivers/hv/hv_bounce.c b/drivers/hv/hv_bounce.c
index c5898325b238..bed1a361d167 100644
--- a/drivers/hv/hv_bounce.c
+++ b/drivers/hv/hv_bounce.c
@@ -9,12 +9,589 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "hyperv_vmbus.h"
+#include <linux/uio.h>
+#include <asm/mshyperv.h>
+
+/* BP == Bounce Pages here */
+#define BP_LIST_MAINTENANCE_FREQ (30 * HZ)
+#define BP_MIN_TIME_IN_FREE_LIST (30 * HZ)
+#define IS_BP_MAINTENANCE_TASK_NEEDED(channel) \
+	(channel->bounce_page_alloc_count > \
+	 channel->min_bounce_resource_count && \
+	 !list_empty(&channel->bounce_page_free_head))
+#define BP_QUEUE_MAINTENANCE_WORK(channel) \
+	queue_delayed_work(system_unbound_wq,		\
+			   &channel->bounce_page_list_maintain, \
+			   BP_LIST_MAINTENANCE_FREQ)
+
+#define hv_copy_to_bounce(bounce_pkt) \
+		hv_copy_to_from_bounce(bounce_pkt, true)
+#define hv_copy_from_bounce(bounce_pkt)	\
+		hv_copy_to_from_bounce(bounce_pkt, false)
+/*
+ * A list of bounce pages, with original va, bounce va and I/O details such as
+ * the offset and length.
+ */
+struct hv_bounce_page_list {
+	struct list_head link;
+	u32 offset;
+	u32 len;
+	unsigned long va;
+	unsigned long bounce_va;
+	unsigned long bounce_original_va;
+	unsigned long bounce_extra_pfn;
+	unsigned long last_used_jiff;
+};
+
+/*
+ * This structure can be safely used to iterate over objects of the type
+ * 'hv_page_buffer', 'hv_mpb_array' or 'hv_multipage_buffer'. The min array
+ * size of 1 is needed to include the size of 'pfn_array' as part of the struct.
+ */
+struct hv_page_range {
+	u32 len;
+	u32 offset;
+	u64 pfn_array[1];
+};
+
+static inline struct hv_bounce_pkt *__hv_bounce_pkt_alloc(
+	struct vmbus_channel *channel)
+{
+	return kmem_cache_alloc(channel->bounce_pkt_cache,
+				__GFP_ZERO | GFP_KERNEL);
+}
+
+static inline void __hv_bounce_pkt_free(struct vmbus_channel *channel,
+					struct hv_bounce_pkt *bounce_pkt)
+{
+	kmem_cache_free(channel->bounce_pkt_cache, bounce_pkt);
+}
+
+static inline void hv_bounce_pkt_list_free(struct vmbus_channel *channel,
+					   const struct list_head *head)
+{
+	struct hv_bounce_pkt *bounce_pkt;
+	struct hv_bounce_pkt *tmp;
+
+	list_for_each_entry_safe(bounce_pkt, tmp, head, link) {
+		list_del(&bounce_pkt->link);
+		__hv_bounce_pkt_free(channel, bounce_pkt);
+	}
+}
+
+/*
+ * Assigns a free bounce packet from the channel, if one is available. Else,
+ * allocates one. Use 'hv_bounce_resources_release' to release the bounce packet
+ * as it also takes care of releasing the bounce pages within, if any.
+ */
+static struct hv_bounce_pkt *hv_bounce_pkt_assign(struct vmbus_channel *channel)
+{
+	if (channel->min_bounce_resource_count) {
+		struct hv_bounce_pkt *bounce_pkt = NULL;
+		unsigned long flags;
+
+		spin_lock_irqsave(&channel->bp_lock, flags);
+		if (!list_empty(&channel->bounce_pkt_free_list_head)) {
+			bounce_pkt = list_first_entry(
+					&channel->bounce_pkt_free_list_head,
+					struct hv_bounce_pkt, link);
+			list_del(&bounce_pkt->link);
+			channel->bounce_pkt_free_count--;
+		}
+
+		spin_unlock_irqrestore(&channel->bp_lock, flags);
+		if (bounce_pkt)
+			return bounce_pkt;
+	}
+
+	return __hv_bounce_pkt_alloc(channel);
+}
+
+static void hv_bounce_pkt_release(struct vmbus_channel *channel,
+				  struct hv_bounce_pkt *bounce_pkt)
+{
+	bool free_pkt = true;
+
+	if (channel->min_bounce_resource_count) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&channel->bp_lock, flags);
+		if (channel->bounce_pkt_free_count <
+		    channel->min_bounce_resource_count) {
+			list_add(&bounce_pkt->link,
+				 &channel->bounce_pkt_free_list_head);
+			channel->bounce_pkt_free_count++;
+			free_pkt = false;
+		}
+
+		spin_unlock_irqrestore(&channel->bp_lock, flags);
+	}
+
+	if (free_pkt)
+		__hv_bounce_pkt_free(channel, bounce_pkt);
+}
+
+/* Frees the list of bounce pages and all of the resources within */
+static void hv_bounce_page_list_free(struct vmbus_channel *channel,
+				     const struct list_head *head)
+{
+	u16 count = 0;
+	u64 pfn[HV_MIN_BOUNCE_BUFFER_PAGES];
+	struct hv_bounce_page_list *bounce_page;
+	struct hv_bounce_page_list *tmp;
+
+	BUILD_BUG_ON(HV_MIN_BOUNCE_BUFFER_PAGES > HV_MAX_MODIFY_GPA_REP_COUNT);
+	list_for_each_entry(bounce_page, head, link) {
+		if (hv_isolation_type_snp())
+			pfn[count++] = virt_to_hvpfn(
+					(void *)bounce_page->bounce_original_va);
+		else
+			pfn[count++] = virt_to_hvpfn(
+					(void *)bounce_page->bounce_va);
+
+		if (count < HV_MIN_BOUNCE_BUFFER_PAGES &&
+		    !list_is_last(&bounce_page->link, head))
+			continue;
+		hv_mark_gpa_visibility(count, pfn, VMBUS_PAGE_NOT_VISIBLE);
+		count = 0;
+	}
+
+	/*
+	 * Need a second iteration because the page should not be freed until
+	 * it is marked not-visible to the host.
+	 */
+	list_for_each_entry_safe(bounce_page, tmp, head, link) {
+		list_del(&bounce_page->link);
+
+		if (hv_isolation_type_snp()) {
+			vunmap((void *)bounce_page->bounce_va);
+			free_page(bounce_page->bounce_original_va);
+		} else
+			free_page(bounce_page->bounce_va);
+
+		kmem_cache_free(channel->bounce_page_cache, bounce_page);
+	}
+}
+
+/* Allocate a list of bounce pages and make them host visible. */
+static int hv_bounce_page_list_alloc(struct vmbus_channel *channel, u32 count)
+{
+	unsigned long flags;
+	struct list_head head;
+	u32 p;
+	u64 pfn[HV_MIN_BOUNCE_BUFFER_PAGES];
+	u32 pfn_count = 0;
+	bool queue_work = false;
+	int ret = -ENOSPC;
+	unsigned long va = 0;
+
+	INIT_LIST_HEAD(&head);
+	for (p = 0; p < count; p++) {
+		struct hv_bounce_page_list *bounce_page;
+
+		va = __get_free_page(__GFP_ZERO | GFP_ATOMIC);
+		if (unlikely(!va))
+			goto err_free;
+		bounce_page = kmem_cache_alloc(channel->bounce_page_cache,
+					       __GFP_ZERO | GFP_ATOMIC);
+		if (unlikely(!bounce_page))
+			goto err_free;
+
+		if (hv_isolation_type_snp()) {
+			bounce_page->bounce_extra_pfn =
+				virt_to_hvpfn((void *)va) +
+				(ms_hyperv.shared_gpa_boundary
+				 >> HV_HYP_PAGE_SHIFT);
+			bounce_page->bounce_original_va = va;
+			bounce_page->bounce_va = (u64)ioremap_cache(
+				bounce_page->bounce_extra_pfn << HV_HYP_PAGE_SHIFT,
+				HV_HYP_PAGE_SIZE);
+			if (!bounce_page->bounce_va)
+				goto err_free;
+		} else {
+			bounce_page->bounce_va = va;
+		}
+
+		pfn[pfn_count++] = virt_to_hvpfn((void *)va);
+		bounce_page->last_used_jiff = jiffies;
+
+		/* Add to the tail to maintain LRU sorting */
+		list_add_tail(&bounce_page->link, &head);
+		va = 0;
+		if (pfn_count == HV_MIN_BOUNCE_BUFFER_PAGES || p == count - 1) {
+			ret = hv_mark_gpa_visibility(pfn_count, pfn,
+					VMBUS_PAGE_VISIBLE_READ_WRITE);
+			if (hv_isolation_type_snp())
+				list_for_each_entry(bounce_page, &head, link)
+					memset((u64 *)bounce_page->bounce_va, 0x00,
+					       HV_HYP_PAGE_SIZE);
+
+			if (unlikely(ret < 0))
+				goto err_free;
+			pfn_count = 0;
+		}
+	}
+
+	spin_lock_irqsave(&channel->bp_lock, flags);
+	list_splice_tail(&head, &channel->bounce_page_free_head);
+	channel->bounce_page_alloc_count += count;
+	queue_work = IS_BP_MAINTENANCE_TASK_NEEDED(channel);
+	spin_unlock_irqrestore(&channel->bp_lock, flags);
+	if (queue_work)
+		BP_QUEUE_MAINTENANCE_WORK(channel);
+	return 0;
+err_free:
+	if (va)
+		free_page(va);
+	hv_bounce_page_list_free(channel, &head);
+	return ret;
+}
+
+/*
+ * Puts the bounce pages in the list back into the channel's free bounce page
+ * list and schedules the bounce page maintenance routine.
+ */
+static void hv_bounce_page_list_release(struct vmbus_channel *channel,
+					struct list_head *head)
+{
+	struct hv_bounce_page_list *bounce_page;
+	unsigned long flags;
+	bool queue_work;
+	struct hv_bounce_page_list *tmp;
+
+	/*
+	 * Need to iterate, rather than a direct list merge so that the last
+	 * used timestamp can be updated for each page.
+	 * Add the page to the tail of the free list to maintain LRU sorting.
+	 */
+	spin_lock_irqsave(&channel->bp_lock, flags);
+	list_for_each_entry_safe(bounce_page, tmp, head, link) {
+		list_del(&bounce_page->link);
+		bounce_page->last_used_jiff = jiffies;
+
+		/* Maintain LRU */
+		list_add_tail(&bounce_page->link,
+			      &channel->bounce_page_free_head);
+	}
+
+	queue_work = IS_BP_MAINTENANCE_TASK_NEEDED(channel);
+	spin_unlock_irqrestore(&channel->bp_lock, flags);
+	if (queue_work)
+		BP_QUEUE_MAINTENANCE_WORK(channel);
+}
+
+/*
+ * Maintenance work to prune the vmbus channel's free bounce page list. It runs
+ * at every 'BP_LIST_MAINTENANCE_FREQ' and frees the bounce pages that are in
+ * the free list longer than 'BP_MIN_TIME_IN_FREE_LIST' once the min bounce
+ * resource reservation requirement is met.
+ */
+static void hv_bounce_page_list_maintain(struct work_struct *work)
+{
+	struct vmbus_channel *channel;
+	struct delayed_work *dwork = to_delayed_work(work);
+	unsigned long flags;
+	struct list_head head_to_free;
+	bool queue_work;
+
+	channel = container_of(dwork, struct vmbus_channel,
+			       bounce_page_list_maintain);
+	INIT_LIST_HEAD(&head_to_free);
+	spin_lock_irqsave(&channel->bp_lock, flags);
+	while (IS_BP_MAINTENANCE_TASK_NEEDED(channel)) {
+		struct hv_bounce_page_list *bounce_page = list_first_entry(
+				&channel->bounce_page_free_head,
+				struct hv_bounce_page_list,
+				link);
+
+		/*
+		 * Stop on the first entry that fails the check since the
+		 * list is expected to be sorted on LRU.
+		 */
+		if (time_before(jiffies, bounce_page->last_used_jiff +
+				BP_MIN_TIME_IN_FREE_LIST))
+			break;
+		list_del(&bounce_page->link);
+		list_add_tail(&bounce_page->link, &head_to_free);
+		channel->bounce_page_alloc_count--;
+	}
+
+	queue_work = IS_BP_MAINTENANCE_TASK_NEEDED(channel);
+	spin_unlock_irqrestore(&channel->bp_lock, flags);
+	if (!list_empty(&head_to_free))
+		hv_bounce_page_list_free(channel, &head_to_free);
+	if (queue_work)
+		BP_QUEUE_MAINTENANCE_WORK(channel);
+}
+
+/*
+ * Assigns a free bounce page from the channel, if one is available. Else,
+ * allocates a bunch of bounce pages into the channel and returns one. Use
+ * 'hv_bounce_page_list_release' to release the page.
+ */
+static struct hv_bounce_page_list *hv_bounce_page_assign(
+	struct vmbus_channel *channel)
+{
+	struct hv_bounce_page_list *bounce_page = NULL;
+	unsigned long flags;
+	int ret;
+
+retry:	
+	spin_lock_irqsave(&channel->bp_lock, flags);
+	if (!list_empty(&channel->bounce_page_free_head)) {
+		bounce_page = list_first_entry(&channel->bounce_page_free_head,
+					       struct hv_bounce_page_list,
+					       link);
+		list_del(&bounce_page->link);
+	}
+	spin_unlock_irqrestore(&channel->bp_lock, flags);
+
+	if (likely(bounce_page))
+		return bounce_page;
+
+	if (hv_isolation_type_snp() && in_interrupt()) {
+		pr_warn_once("Reservse page is not enough.\n");
+		return NULL;
+	}
+
+	ret = hv_bounce_page_list_alloc(channel, HV_MIN_BOUNCE_BUFFER_PAGES);
+	if (unlikely(ret < 0))
+		return NULL;
+	goto retry;
+}
+
+/*
+ * Allocate 'count' linked list of bounce packets into the channel. Use
+ * 'hv_bounce_pkt_list_free' to free the list.
+ */
+static int hv_bounce_pkt_list_alloc(struct vmbus_channel *channel, u32 count)
+{
+	struct list_head bounce_pkt_head;
+	unsigned long flags;
+	u32 i;
+
+	INIT_LIST_HEAD(&bounce_pkt_head);
+	for (i = 0; i < count; i++) {
+		struct hv_bounce_pkt *bounce_pkt = __hv_bounce_pkt_alloc(
+							channel);
+
+		if (unlikely(!bounce_pkt))
+			goto err_free;
+		list_add(&bounce_pkt->link, &bounce_pkt_head);
+	}
+
+	spin_lock_irqsave(&channel->bp_lock, flags);
+	list_splice_tail(&bounce_pkt_head, &channel->bounce_pkt_free_list_head);
+	channel->bounce_pkt_free_count += count;
+	spin_unlock_irqrestore(&channel->bp_lock, flags);
+	return 0;
+err_free:
+	hv_bounce_pkt_list_free(channel, &bounce_pkt_head);
+	return -ENOMEM;
+}
+
+/*
+ * Allocate and reserve enough bounce resources to be able to handle the min
+ * specified bytes. This routine should be called prior to starting the I/O on
+ * the channel, else the channel will end up not reserving any bounce resources.
+ */
+int hv_bounce_resources_reserve(struct vmbus_channel *channel,
+				u32 min_bounce_bytes)
+{
+	unsigned long flags;
+	u32 round_up_count;
+	int ret;
+
+	if (!hv_is_isolation_supported())
+		return 0;
+
+	/* Resize operation is currently not supported */
+	if (unlikely((!min_bounce_bytes || channel->min_bounce_resource_count)))
+		return -EINVAL;
+
+	/*
+	 * Get the page count and round it up to the min bounce pages supported
+	 */
+	round_up_count = round_up(min_bounce_bytes, HV_HYP_PAGE_SIZE)
+			>> HV_HYP_PAGE_SHIFT;
+	round_up_count = round_up(round_up_count, HV_MIN_BOUNCE_BUFFER_PAGES);
+	spin_lock_irqsave(&channel->bp_lock, flags);
+	channel->min_bounce_resource_count = round_up_count;
+	spin_unlock_irqrestore(&channel->bp_lock, flags);
+	ret = hv_bounce_pkt_list_alloc(channel, round_up_count);
+	if (ret < 0)
+		return ret;
+	return hv_bounce_page_list_alloc(channel, round_up_count);
+}
+EXPORT_SYMBOL_GPL(hv_bounce_resources_reserve);
+
+static void hv_bounce_resources_release(struct vmbus_channel *channel,
+					struct hv_bounce_pkt *bounce_pkt)
+{
+	if (unlikely(!bounce_pkt))
+		return;
+	hv_bounce_page_list_release(channel, &bounce_pkt->bounce_page_head);
+	hv_bounce_pkt_release(channel, bounce_pkt);
+}
+
+static void hv_copy_to_from_bounce(const struct hv_bounce_pkt *bounce_pkt,
+				   bool copy_to_bounce)
+{
+	struct hv_bounce_page_list *bounce_page;
+
+	if ((copy_to_bounce && (bounce_pkt->flags != IO_TYPE_WRITE)) ||
+	    (!copy_to_bounce && (bounce_pkt->flags != IO_TYPE_READ)))
+		return;
+
+	list_for_each_entry(bounce_page, &bounce_pkt->bounce_page_head, link) {
+		u32 offset = bounce_page->offset;
+		u32 len = bounce_page->len;
+		u8 *bounce_buffer = (u8 *)bounce_page->bounce_va;
+		u8 *buffer = (u8 *)bounce_page->va;
+
+		if (copy_to_bounce)
+			memcpy(bounce_buffer + offset, buffer + offset, len);
+		else
+			memcpy(buffer + offset, bounce_buffer + offset, len);
+	}
+}
+
+/*
+ * Assigns the bounce resources needed to handle the PFNs within the range and
+ * updates the range accordingly. Uses resources from the pre-allocated pool if
+ * previously reserved, else allocates memory. Use 'hv_bounce_resources_release'
+ * to release.
+ */
+static struct hv_bounce_pkt *hv_bounce_resources_assign(
+	struct vmbus_channel *channel,
+	u32 rangecount,
+	struct hv_page_range *range,
+	u8 io_type)
+{
+	struct hv_bounce_pkt *bounce_pkt;
+	u32 r;
+
+	bounce_pkt = hv_bounce_pkt_assign(channel);
+	if (unlikely(!bounce_pkt))
+		return NULL;
+	bounce_pkt->flags = io_type;
+	INIT_LIST_HEAD(&bounce_pkt->bounce_page_head);
+	for (r = 0; r < rangecount; r++) {
+		u32 len = range[r].len;
+		u32 offset = range[r].offset;
+		u32 p;
+		u32 pfn_count;
+
+		pfn_count = round_up(offset + len, HV_HYP_PAGE_SIZE)
+				>> HV_HYP_PAGE_SHIFT;
+		for (p = 0; p < pfn_count; p++) {
+			struct hv_bounce_page_list *bounce_page;
+			u32 copy_len = min(len, ((u32)HV_HYP_PAGE_SIZE - offset));
+
+			bounce_page  = hv_bounce_page_assign(channel);
+			if (unlikely(!bounce_page))
+				goto err_free;
+			bounce_page->va = (unsigned long)
+				__va(range[r].pfn_array[p] << PAGE_SHIFT);
+			bounce_page->offset = offset;
+			bounce_page->len = copy_len;
+			list_add_tail(&bounce_page->link,
+				      &bounce_pkt->bounce_page_head);
+
+			if (hv_isolation_type_snp()) {
+				range[r].pfn_array[p] =
+					bounce_page->bounce_extra_pfn;
+			} else {
+				range[r].pfn_array[p] = virt_to_hvpfn(
+					(void *)bounce_page->bounce_va);
+			}
+			offset = 0;
+			len -= copy_len;
+		}
+	}
+
+	/* Copy data from original buffer to bounce buffer, if needed */
+	hv_copy_to_bounce(bounce_pkt);
+	return bounce_pkt;
+err_free:
+	/* This will also reclaim any allocated bounce pages */
+	hv_bounce_resources_release(channel, bounce_pkt);
+	return NULL;
+}
+
+int vmbus_sendpacket_pagebuffer_bounce(
+	struct vmbus_channel *channel,
+	struct vmbus_channel_packet_page_buffer *desc,
+	u32 desc_size, struct kvec *bufferlist,
+	u8 io_type, struct hv_bounce_pkt **pbounce_pkt,
+	u64 requestid)
+{
+	struct hv_bounce_pkt *bounce_pkt;
+	int ret;
+
+	bounce_pkt = hv_bounce_resources_assign(channel, desc->rangecount,
+			(struct hv_page_range *)desc->range, io_type);
+	if (unlikely(!bounce_pkt))
+		return -EAGAIN;
+	ret = hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+	if (unlikely(ret < 0))
+		hv_bounce_resources_release(channel, bounce_pkt);
+	else
+		*pbounce_pkt = bounce_pkt;
+
+	return ret;
+}
+
+int vmbus_sendpacket_mpb_desc_bounce(
+	struct vmbus_channel *channel,  struct vmbus_packet_mpb_array *desc,
+	u32 desc_size, struct kvec *bufferlist, u8 io_type,
+	struct hv_bounce_pkt **pbounce_pkt, u64 requestid)
+{
+	struct hv_bounce_pkt *bounce_pkt;
+	struct vmbus_packet_mpb_array *desc_bounce;
+	struct hv_mpb_array *range;
+	int ret = -ENOSPC;
+
+	desc_bounce = kzalloc(desc_size, GFP_ATOMIC);
+	if (unlikely(!desc_bounce))
+		return ret;
+
+	memcpy(desc_bounce, desc, desc_size);
+	range = &desc_bounce->range;
+	bounce_pkt = hv_bounce_resources_assign(channel, desc->rangecount,
+			(struct hv_page_range *)range, io_type);
+	if (unlikely(!bounce_pkt))
+		goto free;
+	bufferlist[0].iov_base = desc_bounce;
+	ret = hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+free:
+	kfree(desc_bounce);
+	if (unlikely(ret < 0))
+		hv_bounce_resources_release(channel, bounce_pkt);
+	else
+		*pbounce_pkt = bounce_pkt;
+	return ret;
+}
+
+void hv_pkt_bounce(struct vmbus_channel *channel,
+		   struct hv_bounce_pkt *bounce_pkt)
+{
+	if (!bounce_pkt)
+		return;
+
+	hv_copy_from_bounce(bounce_pkt);
+	hv_bounce_resources_release(channel, bounce_pkt);
+}
+EXPORT_SYMBOL_GPL(hv_pkt_bounce);
 
 int hv_init_channel_ivm(struct vmbus_channel *channel)
 {
 	if (!hv_is_isolation_supported())
 		return 0;
 
+	INIT_DELAYED_WORK(&channel->bounce_page_list_maintain,
+			  hv_bounce_page_list_maintain);
+
 	INIT_LIST_HEAD(&channel->bounce_page_free_head);
 	INIT_LIST_HEAD(&channel->bounce_pkt_free_list_head);
 
@@ -33,8 +610,8 @@ void hv_free_channel_ivm(struct vmbus_channel *channel)
 	if (!hv_is_isolation_supported())
 		return;
 
-
 	cancel_delayed_work_sync(&channel->bounce_page_list_maintain);
+
 	hv_bounce_pkt_list_free(channel, &channel->bounce_pkt_free_list_head);
 	hv_bounce_page_list_free(channel, &channel->bounce_page_free_head);
 	kmem_cache_destroy(channel->bounce_pkt_cache);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 7677f083d33a..d985271e5522 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -82,6 +82,19 @@ extern int hv_init_channel_ivm(struct vmbus_channel *channel);
 
 extern void hv_free_channel_ivm(struct vmbus_channel *channel);
 
+extern int vmbus_sendpacket_pagebuffer_bounce(struct vmbus_channel *channel,
+	struct vmbus_channel_packet_page_buffer *desc, u32 desc_size,
+	struct kvec *bufferlist, u8 io_type, struct hv_bounce_pkt **bounce_pkt,
+	u64 requestid);
+
+extern int vmbus_sendpacket_mpb_desc_bounce(struct vmbus_channel *channel,
+	struct vmbus_packet_mpb_array *desc, u32 desc_size,
+	struct kvec *bufferlist, u8 io_type, struct hv_bounce_pkt **bounce_pkt,
+	u64 requestid);
+
+extern void hv_pkt_bounce(struct vmbus_channel *channel,
+			  struct hv_bounce_pkt *bounce_pkt);
+
 /* struct hv_monitor_page Layout */
 /* ------------------------------------------------------ */
 /* | 0   | TriggerState (4 bytes) | Rsvd1 (4 bytes)     | */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d1a936091665..be7621b070f2 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1109,6 +1109,8 @@ void vmbus_set_sc_create_callback(struct vmbus_channel *primary_channel,
 void vmbus_set_chn_rescind_callback(struct vmbus_channel *channel,
 		void (*chn_rescind_cb)(struct vmbus_channel *));
 
+extern int hv_bounce_resources_reserve(struct vmbus_channel *channel,
+				       u32 min_bounce_bytes);
 /*
  * Check if sub-channels have already been offerred. This API will be useful
  * when the driver is unloaded after establishing sub-channels. In this case,
-- 
2.25.1

