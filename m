Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74F34C94BA
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiCATrO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiCATrN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA7666C97F;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7DF8C20B6C14;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DF8C20B6C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163990;
        bh=tZnS3vdELV26cJ4keov1MczMe6TQNJGiOKn7Z3zdTTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9ItmDbTycKzUZfUhN2BOqp7irBa6xy+0PVIRrKt2uH7L2VB62F0dioPUyZjyMMKN
         UJJdGn+q9yNODLz0beRgg6nhOICSdmxcqYb8nWaQwoLKEDTRnSY/dOqLNiIFwzIhPo
         zTi37FzW2kUxVnn3CLjhhQHDRkmn2mbITKvPxYQ0=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 03/30] drivers: hv: dxgkrnl: Add VM bus message support, initialize VM bus channels.
Date:   Tue,  1 Mar 2022 11:45:50 -0800
Message-Id: <fde2024f8cd2d2ca2ed9a461298b7914c78226e6.1646163378.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement support for sending/receiving VM bus messages between
the host and the guest.

Initialize the VM bus channels and notify the host about IO space
settings of the VM bus global channel.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile    |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h   |  14 ++
 drivers/hv/dxgkrnl/dxgmodule.c |   7 +
 drivers/hv/dxgkrnl/dxgvmbus.c  | 413 +++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h  |  86 +++++++
 drivers/hv/dxgkrnl/hmgr.h      |  75 ++++++
 drivers/hv/dxgkrnl/ioctl.c     |  24 ++
 drivers/hv/dxgkrnl/misc.h      |  72 ++++++
 include/uapi/misc/d3dkmthk.h   |  34 +++
 9 files changed, 726 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 052f8bd62ad3..76349064b60a 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o
+dxgkrnl-y		:= dxgmodule.o dxgvmbus.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 6b3e9334bce8..533f3bb3ece2 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -29,6 +29,7 @@
 
 struct dxgadapter;
 
+#include "misc.h"
 #include <uapi/misc/d3dkmthk.h>
 
 struct dxgvmbuschannel {
@@ -87,6 +88,13 @@ struct dxgglobal {
 
 extern struct dxgglobal		*dxgglobal;
 
+int dxgglobal_init_global_channel(void);
+void dxgglobal_destroy_global_channel(void);
+struct vmbus_channel *dxgglobal_get_vmbus(void);
+struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void);
+int dxgglobal_acquire_channel_lock(void);
+void dxgglobal_release_channel_lock(void);
+
 struct dxgprocess {
 	/* Placeholder */
 };
@@ -116,4 +124,10 @@ static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 #define DXGK_VMBUS_INTERFACE_VERSION			40
 #define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
 
+void dxgvmb_initialize(void);
+int dxgvmb_send_set_iospace_region(u64 start, u64 len,
+				   struct vmbus_gpadl *shared_mem_gpadl);
+
+int ntstatus2int(struct ntstatus status);
+
 #endif
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 412c37bc592d..78f233e354b9 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -296,6 +296,13 @@ int dxgglobal_init_global_channel(void)
 		goto error;
 	}
 
+	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
+					     dxgglobal->mmiospace_size, 0);
+	if (ret < 0) {
+		pr_err("send_set_iospace_region failed");
+		goto error;
+	}
+
 	hv_set_drvdata(dxgglobal->hdev, dxgglobal);
 
 	dxgglobal->dxgdevice.minor = MISC_DYNAMIC_MINOR;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
new file mode 100644
index 000000000000..399dec02a3a1
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * VM bus interface implementation
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/eventfd.h>
+#include <linux/hyperv.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+#include <linux/pagemap.h>
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+#define RING_BUFSIZE (256 * 1024)
+
+/*
+ * The structure is used to track VM bus packets, waiting for completion.
+ */
+struct dxgvmbuspacket {
+	struct list_head packet_list_entry;
+	u64 request_id;
+	struct completion wait;
+	void *buffer;
+	u32 buffer_length;
+	int status;
+	bool completed;
+};
+
+struct dxgvmb_ext_header {
+	/* Offset from the start of the message to DXGKVMB_COMMAND_BASE */
+	u32		command_offset;
+	u32		reserved;
+	struct winluid	vgpu_luid;
+};
+
+#define VMBUSMESSAGEONSTACK	64
+
+struct dxgvmbusmsg {
+/* Points to the allocated buffer */
+	struct dxgvmb_ext_header	*hdr;
+/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
+	void				*msg;
+/* The vm bus channel, used to pass the message to the host */
+	struct dxgvmbuschannel		*channel;
+/* Message size in bytes including the header and the payload */
+	u32				size;
+/* Buffer used for small messages */
+	char				msg_on_stack[VMBUSMESSAGEONSTACK];
+};
+
+struct dxgvmbusmsgres {
+/* Points to the allocated buffer */
+	struct dxgvmb_ext_header	*hdr;
+/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
+	void				*msg;
+/* The vm bus channel, used to pass the message to the host */
+	struct dxgvmbuschannel		*channel;
+/* Message size in bytes including the header, the payload and the result */
+	u32				size;
+/* Result buffer size in bytes */
+	u32				res_size;
+/* Points to the result within the allocated buffer */
+	void				*res;
+};
+
+static int init_message(struct dxgvmbusmsg *msg,
+			struct dxgprocess *process, u32 size)
+{
+	bool use_ext_header = dxgglobal->vmbus_ver >=
+			      DXGK_VMBUS_INTERFACE_VERSION;
+
+	if (use_ext_header)
+		size += sizeof(struct dxgvmb_ext_header);
+	msg->size = size;
+	if (size <= VMBUSMESSAGEONSTACK) {
+		msg->hdr = (void *)msg->msg_on_stack;
+		memset(msg->hdr, 0, size);
+	} else {
+		msg->hdr = vzalloc(size);
+		if (msg->hdr == NULL)
+			return -ENOMEM;
+	}
+	if (use_ext_header) {
+		msg->msg = (char *)&msg->hdr[1];
+		msg->hdr->command_offset = sizeof(msg->hdr[0]);
+	} else {
+		msg->msg = (char *)msg->hdr;
+	}
+	msg->channel = &dxgglobal->channel;
+	return 0;
+}
+
+static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
+{
+	if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
+		vfree(msg->hdr);
+}
+
+/*
+ * Helper functions
+ */
+
+int ntstatus2int(struct ntstatus status)
+{
+	if (NT_SUCCESS(status))
+		return (int)status.v;
+	switch (status.v) {
+	case STATUS_OBJECT_NAME_COLLISION:
+		return -EEXIST;
+	case STATUS_NO_MEMORY:
+		return -ENOMEM;
+	case STATUS_INVALID_PARAMETER:
+		return -EINVAL;
+	case STATUS_OBJECT_NAME_INVALID:
+	case STATUS_OBJECT_NAME_NOT_FOUND:
+		return -ENOENT;
+	case STATUS_TIMEOUT:
+		return -EAGAIN;
+	case STATUS_BUFFER_TOO_SMALL:
+		return -EOVERFLOW;
+	case STATUS_DEVICE_REMOVED:
+		return -ENODEV;
+	case STATUS_ACCESS_DENIED:
+		return -EACCES;
+	case STATUS_NOT_SUPPORTED:
+		return -EPERM;
+	case STATUS_ILLEGAL_INSTRUCTION:
+		return -EOPNOTSUPP;
+	case STATUS_INVALID_HANDLE:
+		return -EBADF;
+	case STATUS_GRAPHICS_ALLOCATION_BUSY:
+		return -EINPROGRESS;
+	case STATUS_OBJECT_TYPE_MISMATCH:
+		return -EPROTOTYPE;
+	case STATUS_NOT_IMPLEMENTED:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+}
+
+int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev)
+{
+	int ret;
+
+	ch->hdev = hdev;
+	spin_lock_init(&ch->packet_list_mutex);
+	INIT_LIST_HEAD(&ch->packet_list_head);
+	atomic64_set(&ch->packet_request_id, 0);
+
+	ch->packet_cache = kmem_cache_create("DXGK packet cache",
+					     sizeof(struct dxgvmbuspacket), 0,
+					     0, NULL);
+	if (ch->packet_cache == NULL) {
+		pr_err("packet_cache alloc failed");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	hdev->channel->max_pkt_size = DXG_MAX_VM_BUS_PACKET_SIZE;
+	ret = vmbus_open(hdev->channel, RING_BUFSIZE, RING_BUFSIZE,
+			 NULL, 0, dxgvmbuschannel_receive, ch);
+	if (ret) {
+		pr_err("vmbus_open failed: %d", ret);
+		goto cleanup;
+	}
+
+	ch->channel = hdev->channel;
+
+cleanup:
+
+	return ret;
+}
+
+void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch)
+{
+	kmem_cache_destroy(ch->packet_cache);
+	ch->packet_cache = NULL;
+
+	if (ch->channel) {
+		vmbus_close(ch->channel);
+		ch->channel = NULL;
+	}
+}
+
+static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
+				     enum dxgkvmb_commandtype_global type)
+{
+	command->command_type = type;
+	command->process.v = 0;
+	command->command_id = 0;
+	command->channel_type = DXGKVMB_VM_TO_HOST;
+}
+
+static void process_inband_packet(struct dxgvmbuschannel *channel,
+				  struct vmpacket_descriptor *desc)
+{
+	u32 packet_length = hv_pkt_datalen(desc);
+	struct dxgkvmb_command_host_to_vm *packet;
+
+	if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
+		pr_err("Invalid global packet");
+	} else {
+		packet = hv_pkt_data(desc);
+		pr_debug("global packet %d",
+				packet->command_type);
+		switch (packet->command_type) {
+		case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
+		case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+			break;
+		case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
+			break;
+		default:
+			pr_err("unexpected host message %d",
+					packet->command_type);
+		}
+	}
+}
+
+static void process_completion_packet(struct dxgvmbuschannel *channel,
+				      struct vmpacket_descriptor *desc)
+{
+	struct dxgvmbuspacket *packet = NULL;
+	struct dxgvmbuspacket *entry;
+	u32 packet_length = hv_pkt_datalen(desc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->packet_list_mutex, flags);
+	list_for_each_entry(entry, &channel->packet_list_head,
+			    packet_list_entry) {
+		if (desc->trans_id == entry->request_id) {
+			packet = entry;
+			list_del(&packet->packet_list_entry);
+			packet->completed = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&channel->packet_list_mutex, flags);
+	if (packet) {
+		if (packet->buffer_length) {
+			if (packet_length < packet->buffer_length) {
+				pr_debug("invalid size %d Expected:%d",
+					    packet_length,
+					    packet->buffer_length);
+				packet->status = -EOVERFLOW;
+			} else {
+				memcpy(packet->buffer, hv_pkt_data(desc),
+				       packet->buffer_length);
+			}
+		}
+		complete(&packet->wait);
+	} else {
+		pr_err("did not find packet to complete");
+	}
+}
+
+/* Receive callback for messages from the host */
+void dxgvmbuschannel_receive(void *ctx)
+{
+	struct dxgvmbuschannel *channel = ctx;
+	struct vmpacket_descriptor *desc;
+	u32 packet_length = 0;
+
+	foreach_vmbus_pkt(desc, channel->channel) {
+		packet_length = hv_pkt_datalen(desc);
+		pr_debug("next packet (id, size, type): %llu %d %d",
+			desc->trans_id, packet_length, desc->type);
+		if (desc->type == VM_PKT_COMP) {
+			process_completion_packet(channel, desc);
+		} else {
+			if (desc->type != VM_PKT_DATA_INBAND)
+				pr_err("unexpected packet type");
+			else
+				process_inband_packet(channel, desc);
+		}
+	}
+}
+
+int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
+			 void *command,
+			 u32 cmd_size,
+			 void *result,
+			 u32 result_size)
+{
+	int ret;
+	struct dxgvmbuspacket *packet = NULL;
+	struct dxgkvmb_command_vm_to_host *cmd1;
+
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    result_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("%s invalid data size", __func__);
+		return -EINVAL;
+	}
+
+	packet = kmem_cache_alloc(channel->packet_cache, 0);
+	if (packet == NULL) {
+		pr_err("kmem_cache_alloc failed");
+		return -ENOMEM;
+	}
+
+	pr_debug("send_sync_msg global: %d %p %d %d",
+		cmd1->command_type, command, cmd_size, result_size);
+
+	packet->request_id = atomic64_inc_return(&channel->packet_request_id);
+	init_completion(&packet->wait);
+	packet->buffer = result;
+	packet->buffer_length = result_size;
+	packet->status = 0;
+	packet->completed = false;
+	spin_lock_irq(&channel->packet_list_mutex);
+	list_add_tail(&packet->packet_list_entry, &channel->packet_list_head);
+	spin_unlock_irq(&channel->packet_list_mutex);
+
+	ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+			       packet->request_id, VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (ret) {
+		pr_err("vmbus_sendpacket failed: %x", ret);
+		spin_lock_irq(&channel->packet_list_mutex);
+		list_del(&packet->packet_list_entry);
+		spin_unlock_irq(&channel->packet_list_mutex);
+		goto cleanup;
+	}
+
+	pr_debug("waiting completion: %llu", packet->request_id);
+	ret = wait_for_completion_killable(&packet->wait);
+	if (ret) {
+		pr_err("wait_for_complition failed: %x", ret);
+		spin_lock_irq(&channel->packet_list_mutex);
+		if (!packet->completed)
+			list_del(&packet->packet_list_entry);
+		spin_unlock_irq(&channel->packet_list_mutex);
+		goto cleanup;
+	}
+	pr_debug("completion done: %llu %x",
+		packet->request_id, packet->status);
+	ret = packet->status;
+
+cleanup:
+
+	kmem_cache_free(channel->packet_cache, packet);
+	if (ret < 0)
+		pr_debug("%s failed: %x", __func__, ret);
+	return ret;
+}
+
+static int
+dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
+			      void *command, u32 cmd_size)
+{
+	struct ntstatus status;
+	int ret;
+
+	ret = dxgvmb_send_sync_msg(channel, command, cmd_size,
+				   &status, sizeof(status));
+	if (ret >= 0)
+		ret = ntstatus2int(status);
+	return ret;
+}
+
+/*
+ * Global messages to the host
+ */
+
+int dxgvmb_send_set_iospace_region(u64 start, u64 len,
+	struct vmbus_gpadl *shared_mem_gpadl)
+{
+	int ret;
+	struct dxgkvmb_command_setiospaceregion *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init1(&command->hdr,
+				 DXGK_VMBCOMMAND_SETIOSPACEREGION);
+	command->start = start;
+	command->length = len;
+	if (command->shared_page_gpadl)
+		command->shared_page_gpadl = shared_mem_gpadl->gpadl_handle;
+	ret = dxgvmb_send_sync_msg_ntstatus(&dxgglobal->channel, msg.hdr,
+					    msg.size);
+	if (ret < 0)
+		pr_err("send_set_iospace_region failed %x", ret);
+
+	dxgglobal_release_channel_lock();
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
new file mode 100644
index 000000000000..d6136fd1ce9a
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * VM bus interface with the host definitions
+ *
+ */
+
+#ifndef _DXGVMBUS_H
+#define _DXGVMBUS_H
+
+#define DXG_MAX_VM_BUS_PACKET_SIZE	(1024 * 128)
+
+enum dxgkvmb_commandchanneltype {
+	DXGKVMB_VGPU_TO_HOST,
+	DXGKVMB_VM_TO_HOST,
+	DXGKVMB_HOST_TO_VM
+};
+
+/*
+ *
+ * Commands, sent to the host via the guest global VM bus channel
+ * DXG_GUEST_GLOBAL_VMBUS
+ *
+ */
+
+enum dxgkvmb_commandtype_global {
+	DXGK_VMBCOMMAND_VM_TO_HOST_FIRST	= 1000,
+	DXGK_VMBCOMMAND_CREATEPROCESS	= DXGK_VMBCOMMAND_VM_TO_HOST_FIRST,
+	DXGK_VMBCOMMAND_DESTROYPROCESS		= 1001,
+	DXGK_VMBCOMMAND_OPENSYNCOBJECT		= 1002,
+	DXGK_VMBCOMMAND_DESTROYSYNCOBJECT	= 1003,
+	DXGK_VMBCOMMAND_CREATENTSHAREDOBJECT	= 1004,
+	DXGK_VMBCOMMAND_DESTROYNTSHAREDOBJECT	= 1005,
+	DXGK_VMBCOMMAND_SIGNALFENCE		= 1006,
+	DXGK_VMBCOMMAND_NOTIFYPROCESSFREEZE	= 1007,
+	DXGK_VMBCOMMAND_NOTIFYPROCESSTHAW	= 1008,
+	DXGK_VMBCOMMAND_QUERYETWSESSION		= 1009,
+	DXGK_VMBCOMMAND_SETIOSPACEREGION	= 1010,
+	DXGK_VMBCOMMAND_COMPLETETRANSACTION	= 1011,
+	DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST	= 1021,
+	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
+};
+
+/*
+ * Commands, sent by the host to the VM
+ */
+enum dxgkvmb_commandtype_host_to_vm {
+	DXGK_VMBCOMMAND_SIGNALGUESTEVENT,
+	DXGK_VMBCOMMAND_PROPAGATEPRESENTHISTORYTOKEN,
+	DXGK_VMBCOMMAND_SETGUESTDATA,
+	DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE,
+	DXGK_VMBCOMMAND_SENDWNFNOTIFICATION,
+	DXGK_VMBCOMMAND_INVALID_HOST_TO_VM
+};
+
+struct dxgkvmb_command_vm_to_host {
+	u64				command_id;
+	struct d3dkmthandle		process;
+	enum dxgkvmb_commandchanneltype	channel_type;
+	enum dxgkvmb_commandtype_global	command_type;
+};
+
+struct dxgkvmb_command_host_to_vm {
+	u64					command_id;
+	struct d3dkmthandle			process;
+	u32					channel_type	: 8;
+	u32					async_msg	: 1;
+	u32					reserved	: 23;
+	enum dxgkvmb_commandtype_host_to_vm	command_type;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setiospaceregion {
+	struct dxgkvmb_command_vm_to_host hdr;
+	u64				start;
+	u64				length;
+	u32				shared_page_gpadl;
+};
+
+#endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/hmgr.h b/drivers/hv/dxgkrnl/hmgr.h
new file mode 100644
index 000000000000..b8b8f3ae5939
--- /dev/null
+++ b/drivers/hv/dxgkrnl/hmgr.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Handle manager definitions
+ *
+ */
+
+#ifndef _HMGR_H_
+#define _HMGR_H_
+
+#include "misc.h"
+
+struct hmgrentry;
+
+/*
+ * Handle manager table.
+ *
+ * Implementation notes:
+ *   A list of free handles is built on top of the array of table entries.
+ *   free_handle_list_head is the index of the first entry in the list.
+ *   m_FreeHandleListTail is the index of an entry in the list, which is
+ *   HMGRTABLE_MIN_FREE_ENTRIES from the head. It means that when a handle is
+ *   freed, the next time the handle can be re-used is after allocating
+ *   HMGRTABLE_MIN_FREE_ENTRIES number of handles.
+ *   Handles are allocated from the start of the list and free handles are
+ *   inserted after the tail of the list.
+ *
+ */
+struct hmgrtable {
+	struct dxgprocess	*process;
+	struct hmgrentry	*entry_table;
+	u32			free_handle_list_head;
+	u32			free_handle_list_tail;
+	u32			table_size;
+	u32			free_count;
+	struct rw_semaphore	table_lock;
+};
+
+/*
+ * Handle entry data types.
+ */
+#define HMGRENTRY_TYPE_BITS 5
+
+enum hmgrentry_type {
+	HMGRENTRY_TYPE_FREE				= 0,
+	HMGRENTRY_TYPE_DXGADAPTER			= 1,
+	HMGRENTRY_TYPE_DXGSHAREDRESOURCE		= 2,
+	HMGRENTRY_TYPE_DXGDEVICE			= 3,
+	HMGRENTRY_TYPE_DXGRESOURCE			= 4,
+	HMGRENTRY_TYPE_DXGALLOCATION			= 5,
+	HMGRENTRY_TYPE_DXGOVERLAY			= 6,
+	HMGRENTRY_TYPE_DXGCONTEXT			= 7,
+	HMGRENTRY_TYPE_DXGSYNCOBJECT			= 8,
+	HMGRENTRY_TYPE_DXGKEYEDMUTEX			= 9,
+	HMGRENTRY_TYPE_DXGPAGINGQUEUE			= 10,
+	HMGRENTRY_TYPE_DXGDEVICESYNCOBJECT		= 11,
+	HMGRENTRY_TYPE_DXGPROCESS			= 12,
+	HMGRENTRY_TYPE_DXGSHAREDVMOBJECT		= 13,
+	HMGRENTRY_TYPE_DXGPROTECTEDSESSION		= 14,
+	HMGRENTRY_TYPE_DXGHWQUEUE			= 15,
+	HMGRENTRY_TYPE_DXGREMOTEBUNDLEOBJECT		= 16,
+	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEOBJECT	= 17,
+	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEPROXY	= 18,
+	HMGRENTRY_TYPE_DXGTRACKEDWORKLOAD		= 19,
+	HMGRENTRY_TYPE_LIMIT		= ((1 << HMGRENTRY_TYPE_BITS) - 1),
+	HMGRENTRY_TYPE_MONITOREDFENCE	= HMGRENTRY_TYPE_LIMIT + 1,
+};
+
+#endif
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
new file mode 100644
index 000000000000..277e25e5d8c6
--- /dev/null
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Ioctl implementation
+ *
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/anon_inodes.h>
+#include <linux/mman.h>
+
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
new file mode 100644
index 000000000000..9fa3c7c8c3f5
--- /dev/null
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Misc definitions
+ *
+ */
+
+#ifndef _MISC_H_
+#define _MISC_H_
+
+extern const struct d3dkmthandle zerohandle;
+
+/*
+ * Synchronization lock hierarchy.
+ *
+ * The higher enum value, the higher is the lock order.
+ * When a lower lock ois held, the higher lock should not be acquired.
+ *
+ * channel_lock
+ * device_mutex
+ */
+
+/*
+ * Some of the Windows return codes, which needs to be translated to Linux
+ * IOCTL return codes. Positive values are success codes and need to be
+ * returned from the driver IOCTLs. libdxcore.so depends on returning
+ * specific return codes.
+ */
+#define STATUS_SUCCESS					((int)(0))
+#define	STATUS_OBJECT_NAME_INVALID			((int)(0xC0000033L))
+#define	STATUS_DEVICE_REMOVED				((int)(0xC00002B6L))
+#define	STATUS_INVALID_HANDLE				((int)(0xC0000008L))
+#define	STATUS_ILLEGAL_INSTRUCTION			((int)(0xC000001DL))
+#define	STATUS_NOT_IMPLEMENTED				((int)(0xC0000002L))
+#define	STATUS_PENDING					((int)(0x00000103L))
+#define	STATUS_ACCESS_DENIED				((int)(0xC0000022L))
+#define	STATUS_BUFFER_TOO_SMALL				((int)(0xC0000023L))
+#define	STATUS_OBJECT_TYPE_MISMATCH			((int)(0xC0000024L))
+#define	STATUS_GRAPHICS_ALLOCATION_BUSY			((int)(0xC01E0102L))
+#define	STATUS_NOT_SUPPORTED				((int)(0xC00000BBL))
+#define	STATUS_TIMEOUT					((int)(0x00000102L))
+#define	STATUS_INVALID_PARAMETER			((int)(0xC000000DL))
+#define	STATUS_NO_MEMORY				((int)(0xC0000017L))
+#define	STATUS_OBJECT_NAME_COLLISION			((int)(0xC0000035L))
+#define STATUS_OBJECT_NAME_NOT_FOUND			((int)(0xC0000034L))
+
+
+#define NT_SUCCESS(status)				(status.v >= 0)
+
+#ifndef DEBUG
+
+#define DXGKRNL_ASSERT(exp)
+
+#else
+
+#define DXGKRNL_ASSERT(exp)	\
+do {				\
+	if (!(exp)) {		\
+		dump_stack();	\
+		BUG_ON(true);	\
+	}			\
+} while (0)
+
+#endif /* DEBUG */
+
+#endif /* _MISC_H_ */
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index bdb7bc325d1a..2b9ed954a520 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -14,6 +14,40 @@
 #ifndef _D3DKMTHK_H
 #define _D3DKMTHK_H
 
+/*
+ * This structure matches the definition of D3DKMTHANDLE in Windows.
+ * The handle is opaque in user mode. It is used by user mode applications to
+ * represent kernel mode objects, created by dxgkrnl.
+ */
+struct d3dkmthandle {
+	union {
+		struct {
+			__u32 instance	:  6;
+			__u32 index	: 24;
+			__u32 unique	: 2;
+		};
+		__u32 v;
+	};
+};
+
+/*
+ * VM bus messages return Windows' NTSTATUS, which is integer and only negative
+ * value indicates a failure. A positive number is a success and needs to be
+ * returned to user mode as the IOCTL return code. Negative status codes are
+ * converted to Linux error codes.
+ */
+struct ntstatus {
+	union {
+		struct {
+			int code	: 16;
+			int facility	: 13;
+			int customer	: 1;
+			int severity	: 2;
+		};
+		int v;
+	};
+};
+
 /* Matches Windows LUID definition */
 struct winluid {
 	__u32 a;
-- 
2.35.1

