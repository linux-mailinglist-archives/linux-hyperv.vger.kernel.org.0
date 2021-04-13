Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA335E2B0
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbhDMPXI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbhDMPXD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 11:23:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC3C06138C;
        Tue, 13 Apr 2021 08:22:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so10845135pji.5;
        Tue, 13 Apr 2021 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJbcZ8KnexDAAQ5C4Sah9FWkqLY6Pv3HeJbolDJY4aA=;
        b=dMKymLM++0iyOfy+Fp4BTgSzHasioUH85LfrzbqVkkt1W8hN5mKkO9e1HIi0eLdPGK
         E+z9YgmO23xLpuKjoJX7uPOT+4E3B2nw/8TgTufp8DyEt+aSENiBpTch0+Tqo3N5XaOV
         Kkwqv8zVVhwCOjc/ICWRKQYW3AiWgEN2aWxLXt1+sB+EVJWrz93l799+vfGKqx66+tYm
         p2YWbnu+LW/E2rRb7pOX6jU4mN7mfIkUVZjcwcnxy6QH3l981mCdUj9BQPPMcANymZHc
         uFjcGoD3Z6zuItwqHx7G4CQo8ET2GOO1ul0MjZefmw48IVJZLxxb3jGhKFo4nq6K9p1I
         MiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJbcZ8KnexDAAQ5C4Sah9FWkqLY6Pv3HeJbolDJY4aA=;
        b=m5A3M1UbUWPCpDi5elp5ZJhHa01G5+bopYnZKf8QRL6kazYVZkTO0J+mXAUMA15FMG
         4lYjEy996jLpHkg8UGlOesAk70TtvwLd3hFtuLcWAsyf5XcJvhC78OrWBrjEhYWKpUub
         I1mgPW0tqFT2P4Z2Zbx9XxI2jIa7JSxScQv8xbqQXa1Ic2r+59/V+EXYXim07LcMPsBA
         h//QwFnQOXVIuTwAVD0x8dzidL9IRS0d40MVa0rbgEnMzzZqUCYb58KLIF0owN7m/rEQ
         4WnhlPAe/XBZMnzAdJbSx9we4SUMtrXqDU4dS6hix5zacHliYL/4vsGwBx3ULuSUuolT
         Yy+g==
X-Gm-Message-State: AOAM533SSpx1Ab5H5YDpWykiwFeWZ0bEeUH3X4y3PZCCosurLYrYM1RN
        0yF1AIF8SQoyQM7PulV2I+0=
X-Google-Smtp-Source: ABdhPJxl66RYFu0e/3f9oCwMOenf2D6GMo0g6okoYbE/9zsJbSRh6SgfCYirp8Z4+FO0NCisVH+C4w==
X-Received: by 2002:a17:902:6544:b029:ea:f94e:9d4e with SMTP id d4-20020a1709026544b02900eaf94e9d4emr11495405pln.16.1618327363258;
        Tue, 13 Apr 2021 08:22:43 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:42 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC V2 PATCH 12/12] HV/Storvsc: Add Isolation VM support for storvsc driver
Date:   Tue, 13 Apr 2021 11:22:17 -0400
Message-Id: <20210413152217.3386288-13-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

In Isolation VM, all shared memory with host needs to mark visible
to host via hvcall. vmbus_establish_gpadl() has already done it for
netvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
mpb_desc() still need to handle. Use DMA API to map/umap these
memory during sending/receiving packet and Hyper-V DMA ops callback
will use swiotlb fucntion to allocate bounce buffer and copy data
from/to bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 67 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e4fa77445fd..d271578b1811 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -21,6 +21,8 @@
 #include <linux/device.h>
 #include <linux/hyperv.h>
 #include <linux/blkdev.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -414,6 +416,11 @@ static void storvsc_on_channel_callback(void *context);
 #define STORVSC_IDE_MAX_TARGETS				1
 #define STORVSC_IDE_MAX_CHANNELS			1
 
+struct dma_range {
+	dma_addr_t dma;
+	u32 mapping_size;
+};
+
 struct storvsc_cmd_request {
 	struct scsi_cmnd *cmd;
 
@@ -427,6 +434,8 @@ struct storvsc_cmd_request {
 	u32 payload_sz;
 
 	struct vstor_packet vstor_packet;
+	u32 hvpg_count;
+	struct dma_range *dma_range;
 };
 
 
@@ -1236,6 +1245,7 @@ static void storvsc_on_channel_callback(void *context)
 	const struct vmpacket_descriptor *desc;
 	struct hv_device *device;
 	struct storvsc_device *stor_device;
+	int i;
 
 	if (channel->primary_channel != NULL)
 		device = channel->primary_channel->device_obj;
@@ -1249,6 +1259,8 @@ static void storvsc_on_channel_callback(void *context)
 	foreach_vmbus_pkt(desc, channel) {
 		void *packet = hv_pkt_data(desc);
 		struct storvsc_cmd_request *request;
+		enum dma_data_direction dir;
+		u32 attrs;
 		u64 cmd_rqst;
 
 		cmd_rqst = vmbus_request_addr(&channel->requestor,
@@ -1261,6 +1273,22 @@ static void storvsc_on_channel_callback(void *context)
 
 		request = (struct storvsc_cmd_request *)(unsigned long)cmd_rqst;
 
+		if (request->vstor_packet.vm_srb.data_in == READ_TYPE)
+			dir = DMA_FROM_DEVICE;
+		 else
+			dir = DMA_TO_DEVICE;
+
+		if (request->dma_range) {
+			for (i = 0; i < request->hvpg_count; i++)
+				dma_unmap_page_attrs(&device->device,
+						request->dma_range[i].dma,
+						request->dma_range[i].mapping_size,
+						request->vstor_packet.vm_srb.data_in
+						     == READ_TYPE ?
+						DMA_FROM_DEVICE : DMA_TO_DEVICE, attrs);
+			kfree(request->dma_range);
+		}
+
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
@@ -1682,8 +1710,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct vmscsi_request *vm_srb;
 	struct scatterlist *cur_sgl;
 	struct vmbus_packet_mpb_array  *payload;
+	enum dma_data_direction dir;
 	u32 payload_sz;
 	u32 length;
+	u32 attrs;
 
 	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
 		/*
@@ -1722,14 +1752,17 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	case DMA_TO_DEVICE:
 		vm_srb->data_in = WRITE_TYPE;
 		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_OUT;
+		dir = DMA_TO_DEVICE;
 		break;
 	case DMA_FROM_DEVICE:
 		vm_srb->data_in = READ_TYPE;
 		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_IN;
+		dir = DMA_FROM_DEVICE;
 		break;
 	case DMA_NONE:
 		vm_srb->data_in = UNKNOWN_TYPE;
 		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_NO_DATA_TRANSFER;
+		dir = DMA_NONE;
 		break;
 	default:
 		/*
@@ -1786,6 +1819,12 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		hvpgoff = sgl->offset >> HV_HYP_PAGE_SHIFT;
 
 		cur_sgl = sgl;
+
+		cmd_request->dma_range = kzalloc(sizeof(struct dma_range) * hvpg_count,
+			      GFP_ATOMIC);
+		if (!cmd_request->dma_range)
+			return -ENOMEM;
+
 		for (i = 0; i < hvpg_count; i++) {
 			/*
 			 * 'i' is the index of hv pages in the payload and
@@ -1805,6 +1844,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 			 */
 			unsigned int hvpgoff_in_page =
 				(i + hvpgoff) % NR_HV_HYP_PAGES_IN_PAGE;
+			dma_addr_t dma;
+			u32 size;
 
 			/*
 			 * Two cases that we need to fetch a page:
@@ -1817,8 +1858,28 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 				cur_sgl = sg_next(cur_sgl);
 			}
 
-			payload->range.pfn_array[i] = hvpfn + hvpgoff_in_page;
+			size = min(HV_HYP_PAGE_SIZE - offset_in_hvpg, (unsigned long)length);
+			dma = dma_map_page_attrs(&dev->device,
+						 pfn_to_page(hvpfn),
+						 offset_in_hvpg, size,
+						 scmnd->sc_data_direction, attrs);
+			if (dma_mapping_error(&dev->device, dma)) {
+				pr_warn("dma map error.\n");
+				ret = -ENOMEM;
+				goto free_dma_range;
+			}
+
+			if (offset_in_hvpg) {
+				payload->range.offset = dma & ~HV_HYP_PAGE_MASK;
+				offset_in_hvpg = 0;
+			}
+
+			cmd_request->dma_range[i].dma = dma;
+			cmd_request->dma_range[i].mapping_size = size;
+			payload->range.pfn_array[i] = dma >> HV_HYP_PAGE_SHIFT;
+			length -= size;
 		}
+		cmd_request->hvpg_count = hvpg_count;
 	}
 
 	cmd_request->payload = payload;
@@ -1836,6 +1897,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	}
 
 	return 0;
+
+free_dma_range:
+	kfree(cmd_request->dma_range);
+	return ret;
 }
 
 static struct scsi_host_template scsi_driver = {
-- 
2.25.1

