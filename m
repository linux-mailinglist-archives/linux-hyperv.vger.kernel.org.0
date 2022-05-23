Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98679531499
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 May 2022 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiEWNx1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 May 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiEWNxX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 May 2022 09:53:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC8C142A13;
        Mon, 23 May 2022 06:53:18 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5783320B71D5;
        Mon, 23 May 2022 06:53:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5783320B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653313998;
        bh=Pkd6PuM6gw2kxZLdHgPexMScsBxV8YX4+rSyQfPcJuY=;
        h=From:To:Subject:Date:From;
        b=fg4veuzBdG5ShIrwATJfvYsUOndjPpZMsj74xhknJ8kYdW08YtAMSCnwZm+jwo+d6
         wz7yDWtQrXijL0+Wbv/5YmVSMrYnZUsbNgNFrLGf1DVwua88TtaxQktZCcjV80niM1
         M75wjgW4Bd+M35hKVE0xawYQ1W6zaa+Ai0zVvUqg=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mikelley@microsoft.com, longli@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: storvsc: Removing Pre Win8 related logic
Date:   Mon, 23 May 2022 06:53:14 -0700
Message-Id: <1653313994-8139-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The latest storvsc code has already removed the support for windows 7 and
earlier. There is still some code logic reamining which is there to support
pre Windows 8 OS. This patch removes these stale logic.
This patch majorly does three things :

1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct is
same for all the OS post windows 8 there is no need of delta.
2. Simplify sense_buffer_size logic, as there is single buffer size for
all the post windows 8 OS.
3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
as there is no separate handling required for different OS.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
v2 : 1. Added error message for old Hyper-V versions
     2. Removed a check "vmstor_proto_version >= VMSTOR_PROTO_VERSION_WIN8", which will always be true

 drivers/scsi/storvsc_drv.c | 148 ++++++++++---------------------------
 1 file changed, 40 insertions(+), 108 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5585e9d30bbf..dd9cde6331bc 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -137,18 +137,16 @@ struct hv_fc_wwn_packet {
 #define STORVSC_MAX_CMD_LEN			0x10
 
 #define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
-#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
 
 #define STORVSC_SENSE_BUFFER_SIZE		0x14
 #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
 
 /*
- * Sense buffer size changed in win8; have a run-time
- * variable to track the size we should use.  This value will
- * likely change during protocol negotiation but it is valid
- * to start by assuming pre-Win8.
+ * Sense buffer size was differnt pre win8 but those OS are not supported any
+ * more starting 5.19 kernel. This results in to supporting a single value from
+ * win8 onwards.
  */
-static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
+static int sense_buffer_size = POST_WIN7_STORVSC_SENSE_BUFFER_SIZE;
 
 /*
  * The storage protocol version is determined during the
@@ -177,18 +175,6 @@ do {								\
 		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
 } while (0)
 
-struct vmscsi_win8_extension {
-	/*
-	 * The following were added in Windows 8
-	 */
-	u16 reserve;
-	u8  queue_tag;
-	u8  queue_action;
-	u32 srb_flags;
-	u32 time_out_value;
-	u32 queue_sort_ey;
-} __packed;
-
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -214,46 +200,23 @@ struct vmscsi_request {
 	/*
 	 * The following was added in win8.
 	 */
-	struct vmscsi_win8_extension win8_extension;
+	u16 reserve;
+	u8  queue_tag;
+	u8  queue_action;
+	u32 srb_flags;
+	u32 time_out_value;
+	u32 queue_sort_ey;
 
 } __attribute((packed));
 
 /*
- * The list of storage protocols in order of preference.
+ * The list of windows version in order of preference.
  */
-struct vmstor_protocol {
-	int protocol_version;
-	int sense_buffer_size;
-	int vmscsi_size_delta;
-};
 
-
-static const struct vmstor_protocol vmstor_protocols[] = {
-	{
+static const int protocol_version[] = {
 		VMSTOR_PROTO_VERSION_WIN10,
-		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
-		0
-	},
-	{
 		VMSTOR_PROTO_VERSION_WIN8_1,
-		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
-		0
-	},
-	{
 		VMSTOR_PROTO_VERSION_WIN8,
-		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
-		0
-	},
-	{
-		VMSTOR_PROTO_VERSION_WIN7,
-		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
-		sizeof(struct vmscsi_win8_extension),
-	},
-	{
-		VMSTOR_PROTO_VERSION_WIN6,
-		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
-		sizeof(struct vmscsi_win8_extension),
-	}
 };
 
 
@@ -409,9 +372,7 @@ static void storvsc_on_channel_callback(void *context);
 #define STORVSC_IDE_MAX_CHANNELS			1
 
 /*
- * Upper bound on the size of a storvsc packet. vmscsi_size_delta is not
- * included in the calculation because it is set after STORVSC_MAX_PKT_SIZE
- * is used in storvsc_connect_to_vsp
+ * Upper bound on the size of a storvsc packet.
  */
 #define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
 			      sizeof(struct vstor_packet))
@@ -452,17 +413,6 @@ struct storvsc_device {
 	unsigned char path_id;
 	unsigned char target_id;
 
-	/*
-	 * The size of the vmscsi_request has changed in win8. The
-	 * additional size is because of new elements added to the
-	 * structure. These elements are valid only when we are talking
-	 * to a win8 host.
-	 * Track the correction to size we need to apply. This value
-	 * will likely change during protocol negotiation but it is
-	 * valid to start by assuming pre-Win8.
-	 */
-	int vmscsi_size_delta;
-
 	/*
 	 * Max I/O, the device can support.
 	 */
@@ -795,8 +745,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 	vstor_packet->sub_channel_count = num_sc;
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-			       stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       VMBUS_RQST_INIT,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -864,8 +813,7 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-			       stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       VMBUS_RQST_INIT,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -915,14 +863,13 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 	 * Query host supported protocol version.
 	 */
 
-	for (i = 0; i < ARRAY_SIZE(vmstor_protocols); i++) {
+	for (i = 0; i < ARRAY_SIZE(protocol_version); i++) {
 		/* reuse the packet for version range supported */
 		memset(vstor_packet, 0, sizeof(struct vstor_packet));
 		vstor_packet->operation =
 			VSTOR_OPERATION_QUERY_PROTOCOL_VERSION;
 
-		vstor_packet->version.major_minor =
-			vmstor_protocols[i].protocol_version;
+		vstor_packet->version.major_minor = protocol_version[i];
 
 		/*
 		 * The revision number is only used in Windows; set it to 0.
@@ -936,21 +883,16 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 			return -EINVAL;
 
 		if (vstor_packet->status == 0) {
-			vmstor_proto_version =
-				vmstor_protocols[i].protocol_version;
-
-			sense_buffer_size =
-				vmstor_protocols[i].sense_buffer_size;
-
-			stor_device->vmscsi_size_delta =
-				vmstor_protocols[i].vmscsi_size_delta;
+			vmstor_proto_version = protocol_version[i];
 
 			break;
 		}
 	}
 
-	if (vstor_packet->status != 0)
+	if (vstor_packet->status != 0) {
+		dev_err(&device->device, "Obsolete Hyper-V version\n");
 		return -EINVAL;
+	}
 
 
 	memset(vstor_packet, 0, sizeof(struct vstor_packet));
@@ -986,11 +928,10 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 	cpumask_set_cpu(device->channel->target_cpu,
 			&stor_device->alloced_cpus);
 
-	if (vmstor_proto_version >= VMSTOR_PROTO_VERSION_WIN8) {
-		if (vstor_packet->storage_channel_properties.flags &
-		    STORAGE_CHANNEL_SUPPORTS_MULTI_CHANNEL)
-			process_sub_channels = true;
-	}
+	if (vstor_packet->storage_channel_properties.flags &
+	    STORAGE_CHANNEL_SUPPORTS_MULTI_CHANNEL)
+		process_sub_channels = true;
+
 	stor_device->max_transfer_bytes =
 		vstor_packet->storage_channel_properties.max_transfer_bytes;
 
@@ -1289,8 +1230,8 @@ static void storvsc_on_channel_callback(void *context)
 		struct storvsc_cmd_request *request = NULL;
 		u32 pktlen = hv_pkt_datalen(desc);
 		u64 rqst_id = desc->trans_id;
-		u32 minlen = rqst_id ? sizeof(struct vstor_packet) -
-			stor_device->vmscsi_size_delta : sizeof(enum vstor_packet_operation);
+		u32 minlen = rqst_id ? sizeof(struct vstor_packet) :
+			sizeof(enum vstor_packet_operation);
 
 		if (pktlen < minlen) {
 			dev_err(&device->device,
@@ -1346,7 +1287,7 @@ static void storvsc_on_channel_callback(void *context)
 		}
 
 		memcpy(&request->vstor_packet, packet,
-		       (sizeof(struct vstor_packet) - stor_device->vmscsi_size_delta));
+		       sizeof(struct vstor_packet));
 		complete(&request->wait_event);
 	}
 }
@@ -1557,8 +1498,7 @@ static int storvsc_do_io(struct hv_device *device,
 found_channel:
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
-	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
-					stor_device->vmscsi_size_delta);
+	vstor_packet->vm_srb.length = sizeof(struct vmscsi_request);
 
 
 	vstor_packet->vm_srb.sense_info_length = sense_buffer_size;
@@ -1574,13 +1514,11 @@ static int storvsc_do_io(struct hv_device *device,
 		ret = vmbus_sendpacket_mpb_desc(outgoing_channel,
 				request->payload, request->payload_sz,
 				vstor_packet,
-				(sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta),
+				sizeof(struct vstor_packet),
 				(unsigned long)request);
 	} else {
 		ret = vmbus_sendpacket(outgoing_channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       (unsigned long)request,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -1684,8 +1622,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	vstor_packet->vm_srb.path_id = stor_device->path_id;
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       VMBUS_RQST_RESET,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -1778,31 +1715,31 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));
 	vm_srb = &cmd_request->vstor_packet.vm_srb;
-	vm_srb->win8_extension.time_out_value = 60;
+	vm_srb->time_out_value = 60;
 
-	vm_srb->win8_extension.srb_flags |=
+	vm_srb->srb_flags |=
 		SRB_FLAGS_DISABLE_SYNCH_TRANSFER;
 
 	if (scmnd->device->tagged_supported) {
-		vm_srb->win8_extension.srb_flags |=
+		vm_srb->srb_flags |=
 		(SRB_FLAGS_QUEUE_ACTION_ENABLE | SRB_FLAGS_NO_QUEUE_FREEZE);
-		vm_srb->win8_extension.queue_tag = SP_UNTAGGED;
-		vm_srb->win8_extension.queue_action = SRB_SIMPLE_TAG_REQUEST;
+		vm_srb->queue_tag = SP_UNTAGGED;
+		vm_srb->queue_action = SRB_SIMPLE_TAG_REQUEST;
 	}
 
 	/* Build the SRB */
 	switch (scmnd->sc_data_direction) {
 	case DMA_TO_DEVICE:
 		vm_srb->data_in = WRITE_TYPE;
-		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_OUT;
+		vm_srb->srb_flags |= SRB_FLAGS_DATA_OUT;
 		break;
 	case DMA_FROM_DEVICE:
 		vm_srb->data_in = READ_TYPE;
-		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_IN;
+		vm_srb->srb_flags |= SRB_FLAGS_DATA_IN;
 		break;
 	case DMA_NONE:
 		vm_srb->data_in = UNKNOWN_TYPE;
-		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_NO_DATA_TRANSFER;
+		vm_srb->srb_flags |= SRB_FLAGS_NO_DATA_TRANSFER;
 		break;
 	default:
 		/*
@@ -2004,7 +1941,6 @@ static int storvsc_probe(struct hv_device *device,
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
 	stor_device->host = host;
-	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
 	spin_lock_init(&stor_device->lock);
 	hv_set_drvdata(device, stor_device);
 	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
@@ -2217,10 +2153,6 @@ static int __init storvsc_drv_init(void)
 	 * than the ring buffer size since that page is reserved for
 	 * the ring buffer indices) by the max request size (which is
 	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
-	 *
-	 * The computation underestimates max_outstanding_req_per_channel
-	 * for Win7 and older hosts because it does not take into account
-	 * the vmscsi_size_delta correction to the max request size.
 	 */
 	max_outstanding_req_per_channel =
 		((storvsc_ringbuffer_size - PAGE_SIZE) /
-- 
2.25.1

