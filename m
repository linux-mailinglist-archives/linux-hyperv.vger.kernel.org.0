Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404E713273C
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgAGNK1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35894 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNK1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so9258628pjb.1;
        Tue, 07 Jan 2020 05:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUpxubwinJTic0lIoXBDmYhv+VqElfUG5Oe43WkJgYk=;
        b=sctSFyyuaxNu7+DSW8JT65VFWFDaTlaw7g9GaXOamkKFJPUS/gpRh2feIkG2qqsnco
         3E9NZKXXAxYOwcwSETaN+aBNcGcWVBcpur/6PqPVrBPIwcoxsmAFAfCtiXaKG0Bd+yKH
         7yOptVY/wBFSV78GatJWNenumFzIewJKQqayWpBpR2K7XVGFlMyDwcj5lMGCs7aF7L6m
         8rlEmxAbSgCTtWWN5UPMLWDmc9PQ7a1S6AYre3kQspVRAKn31/Htxl8wEHMUFJM10tbm
         GYueaNNQSR0a/CGor0D+CAH/8c8rdJsDgs8SVZLrRiOI1SrYJB04q1eBFB9WQPrJnos3
         JpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUpxubwinJTic0lIoXBDmYhv+VqElfUG5Oe43WkJgYk=;
        b=kdcAqKg9QOJr01BMpLx/BRKQ149HjiFu9Ls5hVbHmjai39YFZh+OqvBqUoOybuiRbr
         w7cv9fJqRBZYN8mPI56BbvOoUURVN0YO12Oy6WI0i0Aj3ldW4ToohmJlV7FL29qOq1xW
         XEES9rt62QTV47RTBa0lfxxXTBPw8SthlaSNkC5RjvmWagBDHSJMueK5hmNit1cg7SLD
         NyiF/djA6yTqIh1DyywlNVhmTQYSoJ7uz/Yn2qkD/+xYTYTve9YU0vBkNAigDVcS+0zQ
         hjVgQFs62vZEF/Wq+pZ2ib5P/jSIF2wM6Qf2l7D7oYltDfIZbuYF5+rxjwy7HqEZE+lc
         Ep+A==
X-Gm-Message-State: APjAAAUMEvVgZvmTDZd4stzeMjZ6fq2Vpe2b9YWU8T358NvLDxYR7JP1
        vFnBCNOTdTYFB4lPUO0P9qyAydu8DRw=
X-Google-Smtp-Source: APXvYqwwRlRu2lMeKPEDTCA/ABPySKfxwLbjb8djIkIAD2jMXAhiquzDper9ItvHpbq2ax1CpPYR9Q==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr49784416pjt.131.1578402626686;
        Tue, 07 Jan 2020 05:10:26 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:25 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 6/10] x86/Hyper-V/Balloon: Enable mem hot-remove capability
Date:   Tue,  7 Jan 2020 21:09:46 +0800
Message-Id: <20200107130950.2983-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Enable mem hot-remove capability, handle request in the
common work and add mem hot-remove operation later.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 729dc5551302..43e490f492d5 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -49,6 +49,7 @@
  * Changes to 0.2 on 2009/05/14
  * Changes to 0.3 on 2009/12/03
  * Changed to 1.0 on 2011/04/05
+ * Changed to 2.0 on 2019/12/10
  */
 
 #define DYNMEM_MAKE_VERSION(Major, Minor) ((__u32)(((Major) << 16) | (Minor)))
@@ -94,7 +95,13 @@ enum dm_message_type {
 	 * Version 1.0.
 	 */
 	DM_INFO_MESSAGE			= 12,
-	DM_VERSION_1_MAX		= 12
+	DM_VERSION_1_MAX		= 12,
+
+	/*
+	 * Version 2.0
+	 */
+	DM_MEM_HOT_REMOVE_REQUEST        = 13,
+	DM_MEM_HOT_REMOVE_RESPONSE       = 14
 };
 
 
@@ -123,7 +130,8 @@ union dm_caps {
 		 * represents an alignment of 2^n in mega bytes.
 		 */
 		__u64 hot_add_alignment:4;
-		__u64 reservedz:58;
+		__u64 hot_remove:1;
+		__u64 reservedz:57;
 	} cap_bits;
 	__u64 caps;
 } __packed;
@@ -234,7 +242,9 @@ struct dm_capabilities {
 struct dm_capabilities_resp_msg {
 	struct dm_header hdr;
 	__u64 is_accepted:1;
-	__u64 reservedz:63;
+	__u64 hot_remove:1;
+	__u64 suppress_pressure_reports:1;
+	__u64 reservedz:61;
 } __packed;
 
 /*
@@ -377,6 +387,27 @@ struct dm_hot_add_response {
 	__u32 result;
 } __packed;
 
+struct dm_hot_remove {
+	struct dm_header hdr;
+	__u32 virtual_node;
+	__u32 page_count;
+	__u32 qos_flags;
+	__u32 reservedZ;
+} __packed;
+
+struct dm_hot_remove_response {
+	struct dm_header hdr;
+	__u32 result;
+	__u32 range_count;
+	__u64 more_pages:1;
+	__u64 reservedz:63;
+	union dm_mem_page_range range_array[];
+} __packed;
+
+#define DM_REMOVE_QOS_LARGE	 (1 << 0)
+#define DM_REMOVE_QOS_LOCAL	 (1 << 1)
+#define DM_REMOVE_QOS_MASK       (0x3)
+
 /*
  * Types of information sent from host to the guest.
  */
@@ -455,6 +486,11 @@ union dm_msg_info {
 		union dm_mem_page_range ha_page_range;
 		union dm_mem_page_range ha_region_range;
 	} hot_add;
+	struct {
+		__u32 virtual_node;
+		__u32 page_count;
+		__u32 qos_flags;
+	} hot_remove;
 };
 
 struct dm_msg_wrk {
@@ -496,6 +532,7 @@ enum hv_dm_state {
 	DM_BALLOON_UP,
 	DM_BALLOON_DOWN,
 	DM_HOT_ADD,
+	DM_HOT_REMOVE,
 	DM_INIT_ERROR
 };
 
@@ -571,6 +608,35 @@ static struct hv_dynmem_device dm_device;
 
 static void post_status(struct hv_dynmem_device *dm);
 
+static int hv_send_hot_remove_response(
+		struct dm_hot_remove_response *resp,
+		unsigned long request_count, bool more_pages)
+{
+	struct hv_dynmem_device *dm = &dm_device;
+	int ret;
+
+	resp->hdr.type = DM_MEM_HOT_REMOVE_RESPONSE;
+	resp->range_count = request_count;
+	resp->more_pages = more_pages;
+	resp->hdr.size = sizeof(struct dm_hot_remove_response)
+			+ sizeof(union dm_mem_page_range) * request_count;
+	resp->result = !!request_count;
+
+	do {
+		resp->hdr.trans_id = atomic_inc_return(&trans_id);
+		ret = vmbus_sendpacket(dm->dev->channel, resp,
+				       resp->hdr.size,
+				       (unsigned long)NULL,
+				       VM_PKT_DATA_INBAND, 0);
+
+		if (ret == -EAGAIN)
+			msleep(20);
+		post_status(&dm_device);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
 				     unsigned long pfn)
@@ -982,6 +1048,17 @@ static unsigned long process_hot_add(unsigned long pg_start,
 
 #endif
 
+static void hot_remove_req(union dm_msg_info *msg_info)
+{
+	struct hv_dynmem_device *dm = &dm_device;
+
+	/* Add hot remove operation later and send failure response. */
+	hv_send_hot_remove_response((struct dm_hot_remove_response *)
+				balloon_up_send_buffer, 0, false);
+
+	dm->state = DM_INITIALIZED;
+}
+
 static void hot_add_req(union dm_msg_info *msg_info)
 {
 	struct dm_hot_add_response resp;
@@ -1366,6 +1443,9 @@ static void dm_msg_work(struct work_struct *dummy)
 	case DM_MEM_HOT_ADD_REQUEST:
 		hot_add_req(msg_info);
 		break;
+	case DM_MEM_HOT_REMOVE_REQUEST:
+		hot_remove_req(msg_info);
+		break;
 	default:
 		return;
 	}
@@ -1506,6 +1586,7 @@ static void balloon_onchannelcallback(void *context)
 	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
 	struct dm_balloon *bal_msg;
 	struct dm_hot_add *ha_msg;
+	struct dm_hot_remove *hr_msg;
 	struct dm_msg_wrk *dm_wrk = &dm_device.dm_wrk;
 	union dm_msg_info *msg_info = &dm_wrk->dm_msg;
 	union dm_mem_page_range *ha_pg_range;
@@ -1587,6 +1668,22 @@ static void balloon_onchannelcallback(void *context)
 			schedule_work(&dm_wrk->wrk);
 			break;
 
+		case DM_MEM_HOT_REMOVE_REQUEST:
+			if (dm->state == DM_HOT_REMOVE)
+				pr_warn("Currently hot-removing.\n");
+
+			dm->state = DM_HOT_REMOVE;
+			hr_msg = (struct dm_hot_remove *)recv_buffer;
+
+			msg_info->hot_remove.virtual_node
+					= hr_msg->virtual_node;
+			msg_info->hot_remove.page_count = hr_msg->page_count;
+			msg_info->hot_remove.qos_flags = hr_msg->qos_flags;
+
+			dm_wrk->msg_type = DM_MEM_HOT_REMOVE_REQUEST;
+			schedule_work(&dm_wrk->wrk);
+			break;
+
 		case DM_INFO_MESSAGE:
 			process_info(dm, (struct dm_info_msg *)dm_msg);
 			break;
@@ -1665,6 +1762,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	 */
 	cap_msg.caps.cap_bits.balloon = 1;
 	cap_msg.caps.cap_bits.hot_add = 1;
+	cap_msg.caps.cap_bits.hot_remove = 1;
 
 	/*
 	 * Specify our alignment requirements as it relates
-- 
2.14.5

