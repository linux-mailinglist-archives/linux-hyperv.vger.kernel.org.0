Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417643B4D18
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Jun 2021 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFZGdH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Jun 2021 02:33:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52320 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFZGdH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Jun 2021 02:33:07 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id A8C4520B6C50; Fri, 25 Jun 2021 23:30:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8C4520B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1624689045;
        bh=tEQgc6HvIhLUNK+Kw+yWRHDhU694FsEhVwCDx8kQbxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMXFVqeWxxx5QT2OZb9z5+ET1Fn84vsQoRDgeP1Q5QrOKpTydOwZGQAbqO2zR1trn
         rIgFkPdEowopGgJ/Qc69fbLMM1PJwekWhHRXOEtQSfvPcyqu3yN6WNdpTnk99yDF1X
         dwRUoxbGhs+V7iSyOS/6GTgn5dHA9fuz4itVWgHE=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Date:   Fri, 25 Jun 2021 23:30:19 -0700
Message-Id: <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Azure Blob storage provides scalable and durable data storage for Azure.
(https://azure.microsoft.com/en-us/services/storage/blobs/)

This driver adds support for accelerated access to Azure Blob storage. As an
alternative to REST APIs, it provides a fast data path that uses host native
network stack and secure direct data link for storage server access.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andra Paraschiv <andraprs@amazon.com>
Cc: Siddharth Gupta <sidgup@codeaurora.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 drivers/hv/Kconfig                                 |  10 +
 drivers/hv/Makefile                                |   1 +
 drivers/hv/azure_blob.c                            | 655 +++++++++++++++++++++
 drivers/hv/channel_mgmt.c                          |   7 +
 include/linux/hyperv.h                             |   9 +
 include/uapi/misc/azure_blob.h                     |  31 +
 7 files changed, 715 insertions(+)
 create mode 100644 drivers/hv/azure_blob.c
 create mode 100644 include/uapi/misc/azure_blob.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 9bfc2b5..d3c2a90 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -180,6 +180,8 @@ Code  Seq#    Include File                                           Comments
 'R'   01     linux/rfkill.h                                          conflict!
 'R'   C0-DF  net/bluetooth/rfcomm.h
 'R'   E0     uapi/linux/fsl_mc.h
+'R'   F0-FF  uapi/misc/azure_blob.h                                  Microsoft Azure Blob driver
+                                                                     <mailto:longli@microsoft.com>
 'S'   all    linux/cdrom.h                                           conflict!
 'S'   80-81  scsi/scsi_ioctl.h                                       conflict!
 'S'   82-FF  scsi/scsi.h                                             conflict!
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d..e08b8d3 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -27,4 +27,14 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_AZURE_BLOB
+	tristate "Microsoft Azure Blob driver"
+	depends on HYPERV && X86_64
+	help
+	  Select this option to enable Microsoft Azure Blob driver.
+
+	  This driver supports accelerated Microsoft Azure Blob access.
+	  To compile this driver as a module, choose M here. The module will be
+	  called azure_blob.
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf82..a322575 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_HYPERV_AZURE_BLOB)	+= azure_blob.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
diff --git a/drivers/hv/azure_blob.c b/drivers/hv/azure_blob.c
new file mode 100644
index 0000000..6c8f957
--- /dev/null
+++ b/drivers/hv/azure_blob.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright (c) 2021, Microsoft Corporation. */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/debugfs.h>
+#include <linux/pagemap.h>
+#include <linux/hyperv.h>
+#include <linux/miscdevice.h>
+#include <linux/uio.h>
+#include <uapi/misc/azure_blob.h>
+
+struct az_blob_device {
+	struct hv_device *device;
+
+	/* Opened files maintained by this device */
+	struct list_head file_list;
+	spinlock_t file_lock;
+	wait_queue_head_t file_wait;
+
+	bool removing;
+};
+
+/* VSP messages */
+enum az_blob_vsp_request_type {
+	AZ_BLOB_DRIVER_REQUEST_FIRST     = 0x100,
+	AZ_BLOB_DRIVER_USER_REQUEST      = 0x100,
+	AZ_BLOB_DRIVER_REGISTER_BUFFER   = 0x101,
+	AZ_BLOB_DRIVER_DEREGISTER_BUFFER = 0x102,
+};
+
+/* VSC->VSP request */
+struct az_blob_vsp_request {
+	u32 version;
+	u32 timeout_ms;
+	u32 data_buffer_offset;
+	u32 data_buffer_length;
+	u32 data_buffer_valid;
+	u32 operation_type;
+	u32 request_buffer_offset;
+	u32 request_buffer_length;
+	u32 response_buffer_offset;
+	u32 response_buffer_length;
+	guid_t transaction_id;
+} __packed;
+
+/* VSP->VSC response */
+struct az_blob_vsp_response {
+	u32 length;
+	u32 error;
+	u32 response_len;
+} __packed;
+
+struct az_blob_vsp_request_ctx {
+	struct list_head list;
+	struct completion wait_vsp;
+	struct az_blob_request_sync *request;
+};
+
+struct az_blob_file_ctx {
+	struct list_head list;
+
+	/* List of pending requests to VSP */
+	struct list_head vsp_pending_requests;
+	spinlock_t vsp_pending_lock;
+	wait_queue_head_t wait_vsp_pending;
+};
+
+/* The maximum number of pages we can pass to VSP in a single packet */
+#define AZ_BLOB_MAX_PAGES 8192
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *az_blob_debugfs_root;
+#endif
+
+static struct az_blob_device az_blob_dev;
+
+static int az_blob_ringbuffer_size = (128 * 1024);
+module_param(az_blob_ringbuffer_size, int, 0444);
+MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size (bytes)");
+
+static const struct hv_vmbus_device_id id_table[] = {
+	{ HV_AZURE_BLOB_GUID,
+	  .driver_data = 0
+	},
+	{ },
+};
+
+#define AZ_ERR 0
+#define AZ_WARN 1
+#define AZ_DBG 2
+static int log_level = AZ_ERR;
+module_param(log_level, int, 0644);
+MODULE_PARM_DESC(log_level,
+	"Log level: 0 - Error (default), 1 - Warning, 2 - Debug.");
+
+static uint device_queue_depth = 1024;
+module_param(device_queue_depth, uint, 0444);
+MODULE_PARM_DESC(device_queue_depth,
+	"System level max queue depth for this device");
+
+#define az_blob_log(level, fmt, args...)	\
+do {	\
+	if (level <= log_level)	\
+		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
+} while (0)
+
+#define az_blob_dbg(fmt, args...) az_blob_log(AZ_DBG, fmt, ##args)
+#define az_blob_warn(fmt, args...) az_blob_log(AZ_WARN, fmt, ##args)
+#define az_blob_err(fmt, args...) az_blob_log(AZ_ERR, fmt, ##args)
+
+static void az_blob_on_channel_callback(void *context)
+{
+	struct vmbus_channel *channel = (struct vmbus_channel *)context;
+	const struct vmpacket_descriptor *desc;
+
+	az_blob_dbg("entering interrupt from vmbus\n");
+	foreach_vmbus_pkt(desc, channel) {
+		struct az_blob_vsp_request_ctx *request_ctx;
+		struct az_blob_vsp_response *response;
+		u64 cmd_rqst = vmbus_request_addr(&channel->requestor,
+					desc->trans_id);
+		if (cmd_rqst == VMBUS_RQST_ERROR) {
+			az_blob_err("incorrect transaction id %llu\n",
+				desc->trans_id);
+			continue;
+		}
+		request_ctx = (struct az_blob_vsp_request_ctx *) cmd_rqst;
+		response = hv_pkt_data(desc);
+
+		az_blob_dbg("got response for request %pUb status %u "
+			"response_len %u\n",
+			&request_ctx->request->guid, response->error,
+			response->response_len);
+		request_ctx->request->response.status = response->error;
+		request_ctx->request->response.response_len =
+			response->response_len;
+		complete(&request_ctx->wait_vsp);
+	}
+
+}
+
+static int az_blob_fop_open(struct inode *inode, struct file *file)
+{
+	struct az_blob_file_ctx *file_ctx;
+	unsigned long flags;
+
+
+	file_ctx = kzalloc(sizeof(*file_ctx), GFP_KERNEL);
+	if (!file_ctx)
+		return -ENOMEM;
+
+
+	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
+	if (az_blob_dev.removing) {
+		spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
+		kfree(file_ctx);
+		return -ENODEV;
+	}
+	list_add_tail(&file_ctx->list, &az_blob_dev.file_list);
+	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
+
+	INIT_LIST_HEAD(&file_ctx->vsp_pending_requests);
+	init_waitqueue_head(&file_ctx->wait_vsp_pending);
+	file->private_data = file_ctx;
+
+	return 0;
+}
+
+static int az_blob_fop_release(struct inode *inode, struct file *file)
+{
+	struct az_blob_file_ctx *file_ctx = file->private_data;
+	unsigned long flags;
+
+	wait_event(file_ctx->wait_vsp_pending,
+		list_empty(&file_ctx->vsp_pending_requests));
+
+	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
+	list_del(&file_ctx->list);
+	if (list_empty(&az_blob_dev.file_list))
+		wake_up(&az_blob_dev.file_wait);
+	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
+
+	return 0;
+}
+
+static inline bool az_blob_safe_file_access(struct file *file)
+{
+	return file->f_cred == current_cred() && !uaccess_kernel();
+}
+
+static int get_buffer_pages(int rw, void __user *buffer, u32 buffer_len,
+	struct page ***ppages, size_t *start, size_t *num_pages)
+{
+	struct iovec iov;
+	struct iov_iter iter;
+	int ret;
+	ssize_t result;
+	struct page **pages;
+
+	ret = import_single_range(rw, buffer, buffer_len, &iov, &iter);
+	if (ret) {
+		az_blob_dbg("request buffer access error %d\n", ret);
+		return ret;
+	}
+	az_blob_dbg("iov_iter type %d offset %lu count %lu nr_segs %lu\n",
+		iter.type, iter.iov_offset, iter.count, iter.nr_segs);
+
+	result = iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start);
+	if (result < 0) {
+		az_blob_dbg("failed to pin user pages result=%ld\n", result);
+		return result;
+	}
+	if (result != buffer_len) {
+		az_blob_dbg("can't pin user pages requested %d got %ld\n",
+			buffer_len, result);
+		return -EFAULT;
+	}
+
+	*ppages = pages;
+	*num_pages = (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
+	return 0;
+}
+
+static void fill_in_page_buffer(u64 *pfn_array,
+	int *index, struct page **pages, unsigned long num_pages)
+{
+	int i, page_idx = *index;
+
+	for (i = 0; i < num_pages; i++)
+		pfn_array[page_idx++] = page_to_pfn(pages[i]);
+	*index = page_idx;
+}
+
+static void free_buffer_pages(size_t num_pages, struct page **pages)
+{
+	unsigned long i;
+
+	for (i = 0; i < num_pages; i++)
+		if (pages[i])
+			put_page(pages[i]);
+	kvfree(pages);
+}
+
+static long az_blob_ioctl_user_request(struct file *filp, unsigned long arg)
+{
+	struct az_blob_device *dev = &az_blob_dev;
+	struct az_blob_file_ctx *file_ctx = filp->private_data;
+	char __user *argp = (char __user *) arg;
+	struct az_blob_request_sync request;
+	struct az_blob_vsp_request_ctx request_ctx;
+	unsigned long flags;
+	int ret;
+	size_t request_start, request_num_pages = 0;
+	size_t response_start, response_num_pages = 0;
+	size_t data_start, data_num_pages = 0, total_num_pages;
+	struct page **request_pages = NULL, **response_pages = NULL;
+	struct page **data_pages = NULL;
+	struct vmbus_packet_mpb_array *desc;
+	u64 *pfn_array;
+	int desc_size;
+	int page_idx;
+	struct az_blob_vsp_request *vsp_request;
+
+	/* Fast fail if device is being removed */
+	if (dev->removing)
+		return -ENODEV;
+
+	if (!az_blob_safe_file_access(filp)) {
+		az_blob_dbg("process %d(%s) changed security contexts after"
+			" opening file descriptor\n",
+			task_tgid_vnr(current), current->comm);
+		return -EACCES;
+	}
+
+	if (copy_from_user(&request, argp, sizeof(request))) {
+		az_blob_dbg("don't have permission to user provided buffer\n");
+		return -EFAULT;
+	}
+
+	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u request_len %u"
+		" response_len %u data_len %u request_buffer %llx "
+		"response_buffer %llx data_buffer %llx\n",
+		&request.guid, request.timeout, request.request_len,
+		request.response_len, request.data_len, request.request_buffer,
+		request.response_buffer, request.data_buffer);
+
+	if (!request.request_len || !request.response_len)
+		return -EINVAL;
+
+	if (request.data_len && request.data_len < request.data_valid)
+		return -EINVAL;
+
+	init_completion(&request_ctx.wait_vsp);
+	request_ctx.request = &request;
+
+	/*
+	 * Need to set rw to READ to have page table set up for passing to VSP.
+	 * Setting it to WRITE will cause the page table entry not allocated
+	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
+	 * work in this scenario because VSP wants all the pages to be present.
+	 */
+	ret = get_buffer_pages(READ, (void __user *) request.request_buffer,
+		request.request_len, &request_pages, &request_start,
+		&request_num_pages);
+	if (ret)
+		goto get_user_page_failed;
+
+	ret = get_buffer_pages(READ, (void __user *) request.response_buffer,
+		request.response_len, &response_pages, &response_start,
+		&response_num_pages);
+	if (ret)
+		goto get_user_page_failed;
+
+	if (request.data_len) {
+		ret = get_buffer_pages(READ,
+			(void __user *) request.data_buffer, request.data_len,
+			&data_pages, &data_start, &data_num_pages);
+		if (ret)
+			goto get_user_page_failed;
+	}
+
+	total_num_pages = request_num_pages + response_num_pages +
+				data_num_pages;
+	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
+		az_blob_dbg("number of DMA pages %lu buffer exceeding %u\n",
+			total_num_pages, AZ_BLOB_MAX_PAGES);
+		ret = -EINVAL;
+		goto get_user_page_failed;
+	}
+
+	/* Construct a VMBUS packet and send it over to VSP */
+	desc_size = sizeof(struct vmbus_packet_mpb_array) +
+			sizeof(u64) * total_num_pages;
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	vsp_request = kzalloc(sizeof(*vsp_request), GFP_KERNEL);
+	if (!desc || !vsp_request) {
+		kfree(desc);
+		kfree(vsp_request);
+		ret = -ENOMEM;
+		goto get_user_page_failed;
+	}
+
+	desc->range.offset = 0;
+	desc->range.len = total_num_pages * PAGE_SIZE;
+	pfn_array = desc->range.pfn_array;
+	page_idx = 0;
+
+	if (request.data_len) {
+		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
+			data_num_pages);
+		vsp_request->data_buffer_offset = data_start;
+		vsp_request->data_buffer_length = request.data_len;
+		vsp_request->data_buffer_valid = request.data_valid;
+	}
+
+	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
+		request_num_pages);
+	vsp_request->request_buffer_offset = request_start +
+						data_num_pages * PAGE_SIZE;
+	vsp_request->request_buffer_length = request.request_len;
+
+	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
+		response_num_pages);
+	vsp_request->response_buffer_offset = response_start +
+		(data_num_pages + request_num_pages) * PAGE_SIZE;
+	vsp_request->response_buffer_length = request.response_len;
+
+	vsp_request->version = 0;
+	vsp_request->timeout_ms = request.timeout;
+	vsp_request->operation_type = AZ_BLOB_DRIVER_USER_REQUEST;
+	guid_copy(&vsp_request->transaction_id, &request.guid);
+
+	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
+	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
+	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
+
+	az_blob_dbg("sending request to VSP\n");
+	az_blob_dbg("desc_size %u desc->range.len %u desc->range.offset %u\n",
+		desc_size, desc->range.len, desc->range.offset);
+	az_blob_dbg("vsp_request data_buffer_offset %u data_buffer_length %u "
+		"data_buffer_valid %u request_buffer_offset %u "
+		"request_buffer_length %u response_buffer_offset %u "
+		"response_buffer_length %u\n",
+		vsp_request->data_buffer_offset,
+		vsp_request->data_buffer_length,
+		vsp_request->data_buffer_valid,
+		vsp_request->request_buffer_offset,
+		vsp_request->request_buffer_length,
+		vsp_request->response_buffer_offset,
+		vsp_request->response_buffer_length);
+
+	ret = vmbus_sendpacket_mpb_desc(dev->device->channel, desc, desc_size,
+		vsp_request, sizeof(*vsp_request), (u64) &request_ctx);
+
+	kfree(desc);
+	kfree(vsp_request);
+	if (ret)
+		goto vmbus_send_failed;
+
+	wait_for_completion(&request_ctx.wait_vsp);
+
+	/*
+	 * At this point, the response is already written to request
+	 * by VMBUS completion handler, copy them to user-mode buffers
+	 * and return to user-mode
+	 */
+	if (copy_to_user(argp +
+			offsetof(struct az_blob_request_sync,
+				response.status),
+			&request.response.status,
+			sizeof(request.response.status))) {
+		ret = -EFAULT;
+		goto vmbus_send_failed;
+	}
+
+	if (copy_to_user(argp +
+			offsetof(struct az_blob_request_sync,
+				response.response_len),
+			&request.response.response_len,
+			sizeof(request.response.response_len)))
+		ret = -EFAULT;
+
+vmbus_send_failed:
+	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
+	list_del(&request_ctx.list);
+	if (list_empty(&file_ctx->vsp_pending_requests))
+		wake_up(&file_ctx->wait_vsp_pending);
+	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
+
+get_user_page_failed:
+	free_buffer_pages(request_num_pages, request_pages);
+	free_buffer_pages(response_num_pages, response_pages);
+	free_buffer_pages(data_num_pages, data_pages);
+
+	return ret;
+}
+
+static long az_blob_fop_ioctl(struct file *filp, unsigned int cmd,
+	unsigned long arg)
+{
+	long ret = -EIO;
+
+	switch (cmd) {
+	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
+		if (_IOC_SIZE(cmd) != sizeof(struct az_blob_request_sync))
+			return -EINVAL;
+		ret = az_blob_ioctl_user_request(filp, arg);
+		break;
+
+	default:
+		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
+	}
+
+	return ret;
+}
+
+static const struct file_operations az_blob_client_fops = {
+	.owner	= THIS_MODULE,
+	.open	= az_blob_fop_open,
+	.unlocked_ioctl = az_blob_fop_ioctl,
+	.release = az_blob_fop_release,
+};
+
+static struct miscdevice az_blob_misc_device = {
+	MISC_DYNAMIC_MINOR,
+	"azure_blob",
+	&az_blob_client_fops,
+};
+
+static int az_blob_show_pending_requests(struct seq_file *m, void *v)
+{
+	unsigned long flags, flags2;
+	struct az_blob_vsp_request_ctx *request_ctx;
+	struct az_blob_file_ctx *file_ctx;
+
+	seq_puts(m, "List of pending requests\n");
+	seq_puts(m, "UUID request_len response_len data_len "
+		"request_buffer response_buffer data_buffer\n");
+	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
+	list_for_each_entry(file_ctx, &az_blob_dev.file_list, list) {
+		spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags2);
+		list_for_each_entry(request_ctx,
+				&file_ctx->vsp_pending_requests, list) {
+			seq_printf(m, "%pUb ", &request_ctx->request->guid);
+			seq_printf(m, "%u ", request_ctx->request->request_len);
+			seq_printf(m,
+				"%u ", request_ctx->request->response_len);
+			seq_printf(m, "%u ", request_ctx->request->data_len);
+			seq_printf(m,
+				"%llx ", request_ctx->request->request_buffer);
+			seq_printf(m,
+				"%llx ", request_ctx->request->response_buffer);
+			seq_printf(m,
+				"%llx\n", request_ctx->request->data_buffer);
+		}
+		spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags2);
+	}
+	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
+
+	return 0;
+}
+
+static int az_blob_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, az_blob_show_pending_requests, NULL);
+}
+
+static const struct file_operations az_blob_debugfs_fops = {
+	.open		= az_blob_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release
+};
+
+static void az_blob_remove_device(struct az_blob_device *dev)
+{
+	wait_event(dev->file_wait, list_empty(&dev->file_list));
+	misc_deregister(&az_blob_misc_device);
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(az_blob_debugfs_root);
+#endif
+	/* At this point, we won't get any requests from user-mode */
+}
+
+static int az_blob_create_device(struct az_blob_device *dev)
+{
+	int rc;
+	struct dentry *d;
+
+	rc = misc_register(&az_blob_misc_device);
+	if (rc) {
+		az_blob_err("misc_register failed rc %d\n", rc);
+		return rc;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	az_blob_debugfs_root = debugfs_create_dir("az_blob", NULL);
+	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
+		d = debugfs_create_file("pending_requests", 0400,
+			az_blob_debugfs_root, NULL,
+			&az_blob_debugfs_fops);
+		if (IS_ERR_OR_NULL(d)) {
+			az_blob_warn("failed to create debugfs file\n");
+			debugfs_remove_recursive(az_blob_debugfs_root);
+			az_blob_debugfs_root = NULL;
+		}
+	} else
+		az_blob_warn("failed to create debugfs root\n");
+#endif
+
+	return 0;
+}
+
+static int az_blob_connect_to_vsp(struct hv_device *device, u32 ring_size)
+{
+	int ret;
+
+	spin_lock_init(&az_blob_dev.file_lock);
+	INIT_LIST_HEAD(&az_blob_dev.file_list);
+	init_waitqueue_head(&az_blob_dev.file_wait);
+
+	az_blob_dev.removing = false;
+
+	az_blob_dev.device = device;
+	device->channel->rqstor_size = device_queue_depth;
+
+	ret = vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
+			az_blob_on_channel_callback, device->channel);
+
+	if (ret) {
+		az_blob_err("failed to connect to VSP ret %d\n", ret);
+		return ret;
+	}
+
+	hv_set_drvdata(device, &az_blob_dev);
+
+	return ret;
+}
+
+static void az_blob_remove_vmbus(struct hv_device *device)
+{
+	/* At this point, no VSC/VSP traffic is possible over vmbus */
+	hv_set_drvdata(device, NULL);
+	vmbus_close(device->channel);
+}
+
+static int az_blob_probe(struct hv_device *device,
+			const struct hv_vmbus_device_id *dev_id)
+{
+	int rc;
+
+	az_blob_dbg("probing device\n");
+
+	rc = az_blob_connect_to_vsp(device, az_blob_ringbuffer_size);
+	if (rc) {
+		az_blob_err("error connecting to VSP rc %d\n", rc);
+		return rc;
+	}
+
+	// create user-mode client library facing device
+	rc = az_blob_create_device(&az_blob_dev);
+	if (rc) {
+		az_blob_remove_vmbus(device);
+		return rc;
+	}
+
+	az_blob_dbg("successfully probed device\n");
+	return 0;
+}
+
+static int az_blob_remove(struct hv_device *dev)
+{
+	struct az_blob_device *device = hv_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&device->file_lock, flags);
+	device->removing = true;
+	spin_unlock_irqrestore(&device->file_lock, flags);
+
+	az_blob_remove_device(device);
+	az_blob_remove_vmbus(dev);
+	return 0;
+}
+
+static struct hv_driver az_blob_drv = {
+	.name = KBUILD_MODNAME,
+	.id_table = id_table,
+	.probe = az_blob_probe,
+	.remove = az_blob_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int __init az_blob_drv_init(void)
+{
+	int ret;
+
+	ret = vmbus_driver_register(&az_blob_drv);
+	return ret;
+}
+
+static void __exit az_blob_drv_exit(void)
+{
+	vmbus_driver_unregister(&az_blob_drv);
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("Microsoft Azure Blob driver");
+module_init(az_blob_drv_init);
+module_exit(az_blob_drv_exit);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0c75662..436fdeb 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -154,6 +154,13 @@
 	  .allowed_in_isolated = false,
 	},
 
+	/* Azure Blob */
+	{ .dev_type = HV_AZURE_BLOB,
+	  HV_AZURE_BLOB_GUID,
+	  .perf_device = false,
+	  .allowed_in_isolated = false,
+	},
+
 	/* Unknown GUID */
 	{ .dev_type = HV_UNKNOWN,
 	  .perf_device = false,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d1e59db..ac31362 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -772,6 +772,7 @@ enum vmbus_device_type {
 	HV_FCOPY,
 	HV_BACKUP,
 	HV_DM,
+	HV_AZURE_BLOB,
 	HV_UNKNOWN,
 };
 
@@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
 
 /*
+ * Azure Blob GUID
+ * {0590b792-db64-45cc-81db-b8d70c577c9e}
+ */
+#define HV_AZURE_BLOB_GUID \
+	.guid = GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
+			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
+
+/*
  * Shutdown GUID
  * {0e0b6031-5213-4934-818b-38d90ced39db}
  */
diff --git a/include/uapi/misc/azure_blob.h b/include/uapi/misc/azure_blob.h
new file mode 100644
index 0000000..29413fc
--- /dev/null
+++ b/include/uapi/misc/azure_blob.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright (c) 2021, Microsoft Corporation. */
+
+#ifndef _AZ_BLOB_H
+#define _AZ_BLOB_H
+
+/* user-mode sync request sent through ioctl */
+struct az_blob_request_sync_response {
+	__u32 status;
+	__u32 response_len;
+};
+
+struct az_blob_request_sync {
+	guid_t guid;
+	__u32 timeout;
+	__u32 request_len;
+	__u32 response_len;
+	__u32 data_len;
+	__u32 data_valid;
+	__aligned_u64 request_buffer;
+	__aligned_u64 response_buffer;
+	__aligned_u64 data_buffer;
+	struct az_blob_request_sync_response response;
+};
+
+#define AZ_BLOB_MAGIC_NUMBER	'R'
+#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
+		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
+			struct az_blob_request_sync)
+
+#endif /* define _AZ_BLOB_H */
-- 
1.8.3.1

