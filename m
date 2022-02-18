Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ADD4BBFC1
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Feb 2022 19:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiBRSm5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Feb 2022 13:42:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbiBRSm4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Feb 2022 13:42:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26351E55;
        Fri, 18 Feb 2022 10:42:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so13115627pja.3;
        Fri, 18 Feb 2022 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urKWsSHIiVg8SE5ibUVhjuZacJ5inG2IY/D8PhtnG20=;
        b=ChFjSnJyVs7p1hH6Xh9nz5h2AJVHjhK0nPVHROOVzem8LGu6CjvJ6r0DCEqeUequZs
         QzKMy6MFXzgejIh8/qco6VU/Ha0e1rgdKirpbUgRozSUObaMWINbcCYEFa3MstG5JcKl
         artr3DImFWJ+BDnwH/Kwb4jMQq86+nI6PrSMdN+mfArmqeumRWvv3WlaC0ekiDj0mnGC
         VGa8GR2sumMJH5eY/wXGgA9UwCe+aPgpP6FMj82gePvBzLOifW+lFzoiDqkvTdinFpzf
         4Idkyttnwl1ibO9ZJ2LB+utPRl7OpRAX9SqwEYAJNquDrzR/sJp9dnOGK9EaJsEzV5MI
         VndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urKWsSHIiVg8SE5ibUVhjuZacJ5inG2IY/D8PhtnG20=;
        b=YGYPsDAj10tsiOBhduMsUaaZUFID1okBqtSgyOhGDIM4Xc9BcW23y05QqQ77OWoxOx
         m3fi+P7UQ7FtpiByiUltwPtQTLlHaBeohk+ap2+E9SdfqwbCN587w1Plw19UrLo903i5
         nQZWzdSqIXjDnzWw1YML1Gy+QKVzUlxrOsudPdI/TeqK4IIjtfKRPJLkjGR1TdVLBmI0
         HZ3VI0jY3xxhccYa4cft87F64n/rkcRhr2Vtge0TFvpstkA2MZH3xZ11YXChNOBsEatV
         gsAubkcxWIbPaT/dfhfGg86I1O+LFb1drH9AhnekqRbujNPHIkC9VU5cxD8d2P0syHej
         KuHg==
X-Gm-Message-State: AOAM531msn3SXAE1nqvGJo3d3hO3naVHQ00h7yt9vW+TsPhS0qsKod8N
        8vtJeRFx2i+35cmMaPKLHD0=
X-Google-Smtp-Source: ABdhPJxQzASGxFQyLK/xUCiG/MbmGEB0qc8MGrT1r73xgasLJX5NxekuU3/mIa2sNHut3hrH3UIqPg==
X-Received: by 2002:a17:902:ab52:b0:14d:7ce1:8d66 with SMTP id ij18-20020a170902ab5200b0014d7ce18d66mr8648122plb.88.1645209758387;
        Fri, 18 Feb 2022 10:42:38 -0800 (PST)
Received: from vm-111.3frfxmc3btcupaqenzdpat1uec.xx.internal.cloudapp.net ([13.77.171.140])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090ab79100b001b89fd7e298sm130132pjr.4.2022.02.18.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:42:37 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     mikelley@microsoft.com, jejb@linux.ibm.com, kys@microsoft.com,
        martin.petersen@oracle.com, mst@redhat.com,
        benh@kernel.crashing.org, decui@microsoft.com,
        don.brace@microchip.com, R-QLogic-Storage-Upstream@marvell.com,
        haiyangz@microsoft.com, jasowang@redhat.com, john.garry@huawei.com,
        kashyap.desai@broadcom.com, mpe@ellerman.id.au,
        njavali@marvell.com, pbonzini@redhat.com, paulus@samba.org,
        sathya.prakash@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sreekanth.reddy@broadcom.com, stefanha@redhat.com,
        sthemmin@microsoft.com, suganath-prabu.subramani@broadcom.com,
        sumit.saxena@broadcom.com, tyreld@linux.ibm.com,
        wei.liu@kernel.org, linuxppc-dev@lists.ozlabs.org,
        megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        storagedev@microchip.com,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com
Cc:     andres@anarazel.de
Subject: [PATCH RFC v1 4/5] scsi: storvsc: use per device tag sets
Date:   Fri, 18 Feb 2022 18:41:56 +0000
Message-Id: <20220218184157.176457-5-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218184157.176457-1-melanieplageman@gmail.com>
References: <20220218184157.176457-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

storvsc operates in virtual environments where multiple devices with
potentially widely varying performance can be attached to the same SCSI
controller.

As such, it can benefit from the device independence
provided by per-device tag sets.

Map each device tag set to a small integer index which can be combined
with the tag number to uniquely identify an I/O request and can be
quickly looked up and validated when a request completes.

Signed-off-by: Melanie Plageman <melanieplageman@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 85 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 9a0bba5a51a7..0ed764bcabab 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -399,6 +399,7 @@ static void storvsc_on_channel_callback(void *context);
 #define STORVSC_MAX_LUNS_PER_TARGET			255
 #define STORVSC_MAX_TARGETS				2
 #define STORVSC_MAX_CHANNELS				8
+#define STORVSC_MAX_DEVICES_PER_CONTROLLER		64
 
 #define STORVSC_FC_MAX_LUNS_PER_TARGET			255
 #define STORVSC_FC_MAX_TARGETS				128
@@ -431,6 +432,14 @@ struct storvsc_cmd_request {
 	struct vstor_packet vstor_packet;
 };
 
+union storvsc_scsi_device_tag {
+	u64 as_uint64;
+	struct {
+		u32 tag;
+		u32 idx;
+	} __packed;
+};
+
 
 /* A storvsc device is a device object that contains a vmbus channel */
 struct storvsc_device {
@@ -502,6 +511,7 @@ struct hv_host_device {
 	struct workqueue_struct *handle_error_wq;
 	struct work_struct host_scan_work;
 	struct Scsi_Host *host;
+	struct blk_mq_tag_set *device_tag_sets[STORVSC_MAX_DEVICES_PER_CONTROLLER];
 };
 
 struct storvsc_scan_work {
@@ -700,6 +710,7 @@ static void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
 
 static u64 storvsc_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 {
+	union storvsc_scsi_device_tag tag;
 	struct storvsc_cmd_request *request =
 		(struct storvsc_cmd_request *)(unsigned long)rqst_addr;
 
@@ -708,11 +719,15 @@ static u64 storvsc_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 	if (rqst_addr == VMBUS_RQST_RESET)
 		return VMBUS_RQST_RESET;
 
+	tag.tag = blk_mq_unique_tag(scsi_cmd_to_rq(request->cmd));
+
 	/*
 	 * Cannot return an ID of 0, which is reserved for an unsolicited
 	 * message from Hyper-V.
 	 */
-	return (u64)blk_mq_unique_tag(scsi_cmd_to_rq(request->cmd)) + 1;
+	tag.tag++;
+	tag.idx = (u64) request->cmd->device->hostdata;
+	return tag.as_uint64;
 }
 
 static void handle_sc_creation(struct vmbus_channel *new_sc)
@@ -1272,6 +1287,7 @@ static void storvsc_on_channel_callback(void *context)
 	struct hv_device *device;
 	struct storvsc_device *stor_device;
 	struct Scsi_Host *shost;
+	struct hv_host_device *host_dev;
 
 	if (channel->primary_channel != NULL)
 		device = channel->primary_channel->device_obj;
@@ -1283,6 +1299,7 @@ static void storvsc_on_channel_callback(void *context)
 		return;
 
 	shost = stor_device->host;
+	host_dev = shost_priv(shost);
 
 	foreach_vmbus_pkt(desc, channel) {
 		struct vstor_packet *packet = hv_pkt_data(desc);
@@ -1330,13 +1347,34 @@ static void storvsc_on_channel_callback(void *context)
 				}
 			} else {
 				struct scsi_cmnd *scmnd;
+				union storvsc_scsi_device_tag tag;
+				struct blk_mq_tag_set *tag_set;
 
 				/* Transaction 'rqst_id' corresponds to tag 'rqst_id - 1' */
-				scmnd = scsi_host_find_tag(shost, rqst_id - 1);
-				if (scmnd == NULL) {
+				tag.as_uint64 = rqst_id;
+				tag.tag--;
+
+				if (tag.idx >= STORVSC_MAX_DEVICES_PER_CONTROLLER) {
+					dev_err(&device->device,
+						"SCSI Device Tag Set index %d is invalid.\n",
+						tag.idx);
+					continue;
+				}
+
+				tag_set = READ_ONCE(host_dev->device_tag_sets[tag.idx]);
+				if (!tag_set) {
+					dev_err(&device->device,
+						"No SCSI Device Tag Set found at idx %d.\n",
+						tag.idx);
+					continue;
+				}
+
+				scmnd = scsi_find_tag(tag_set, tag.tag);
+				if (!scmnd) {
 					dev_err(&device->device, "Incorrect transaction ID\n");
 					continue;
 				}
+
 				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
 				scsi_dma_unmap(scmnd);
 			}
@@ -1596,6 +1634,10 @@ static int storvsc_do_io(struct hv_device *device,
 
 static int storvsc_device_alloc(struct scsi_device *sdevice)
 {
+	u64 i;
+	struct hv_host_device *host_dev = shost_priv(sdevice->host);
+	struct hv_device *dev = host_dev->dev;
+
 	/*
 	 * Set blist flag to permit the reading of the VPD pages even when
 	 * the target may claim SPC-2 compliance. MSFT targets currently
@@ -1607,7 +1649,31 @@ static int storvsc_device_alloc(struct scsi_device *sdevice)
 	 */
 	sdevice->sdev_bflags = BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES;
 
-	return 0;
+	if (!sdevice->tag_set)
+		return -EINVAL;
+	/*
+	 * Find an open spot in the array to save the pointer to the
+	 * blk_mq_tag_set allocated in scsi_alloc_sdev, then save that spot's
+	 * index. The index comprises part of the tag that is eventually
+	 * assigned to a dispatched SCSI command.
+	 *
+	 * This can be done without a lock because scanning is serialized with
+	 * the Scsi_Host->scan_mutex.
+	 */
+	for (i = 0; i < STORVSC_MAX_DEVICES_PER_CONTROLLER; i++) {
+		if (READ_ONCE(host_dev->device_tag_sets[i]))
+			continue;
+
+		WRITE_ONCE(host_dev->device_tag_sets[i], sdevice->tag_set);
+
+		sdevice->hostdata = (void *) i;
+		return 0;
+	}
+
+	dev_err(&dev->device,
+		"The storvsc SCSI Device Tag Set array is full. No additional tag sets can be allocated.");
+
+	return -EINVAL;
 }
 
 static int storvsc_device_configure(struct scsi_device *sdevice)
@@ -1636,6 +1702,15 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 	return 0;
 }
 
+static void storvsc_device_destroy(struct scsi_device *sdevice)
+{
+	struct Scsi_Host *host = sdevice->host;
+	struct hv_host_device *host_dev = shost_priv(host);
+	u64 idx = (u64) sdevice->hostdata;
+
+	WRITE_ONCE(host_dev->device_tag_sets[idx], NULL);
+}
+
 static int storvsc_get_chs(struct scsi_device *sdev, struct block_device * bdev,
 			   sector_t capacity, int *info)
 {
@@ -1912,6 +1987,7 @@ static struct scsi_host_template scsi_driver = {
 	.proc_name =		"storvsc_host",
 	.eh_timed_out =		storvsc_eh_timed_out,
 	.slave_alloc =		storvsc_device_alloc,
+	.slave_destroy =	storvsc_device_destroy,
 	.slave_configure =	storvsc_device_configure,
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
@@ -1920,6 +1996,7 @@ static struct scsi_host_template scsi_driver = {
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
+	.per_device_tag_set =	1,
 };
 
 enum {
-- 
2.25.1

