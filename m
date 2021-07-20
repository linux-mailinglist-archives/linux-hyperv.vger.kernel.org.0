Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523293CF2B0
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbhGTCxR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jul 2021 22:53:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344805AbhGTCvD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jul 2021 22:51:03 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5AFA820B6C50; Mon, 19 Jul 2021 20:31:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AFA820B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1626751902;
        bh=xKpUq+4MWjjLXaR5yNmZ36ioRzUBXaj2O4klpaj34qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0YyddiCjKZwQxGrBVsv5a7OSKosKO20EiZP4uKdGXx7ebbODEPfA3Qy1AFgrYWKU
         BHh07FbocHvW1tUUN7pQv26nmJ2bqawU78vfSGMT144OGiWd7QwkJ4YUQG++OZtqn3
         L1qNKYi0D6M66Qzjtt2+lln0UDOh4Ae04wBygf3M=
From:   longli@linuxonhyperv.com
To:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
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
Subject: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Date:   Mon, 19 Jul 2021 20:31:05 -0700
Message-Id: <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Azure Blob provides scalable, secure and shared storage services for Azure.

This driver adds support for accelerated access to Azure Blob storage. As an
alternative to REST APIs, it provides a fast data path that uses host native
network stack and direct data link for storage server access.

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
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/hv/Kconfig                            |  11 +
 drivers/hv/Makefile                           |   1 +
 drivers/hv/channel_mgmt.c                     |   7 +
 drivers/hv/hv_azure_blob.c                    | 628 ++++++++++++++++++
 include/linux/hyperv.h                        |   9 +
 include/uapi/misc/hv_azure_blob.h             |  34 +
 7 files changed, 692 insertions(+)
 create mode 100644 drivers/hv/hv_azure_blob.c
 create mode 100644 include/uapi/misc/hv_azure_blob.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 9bfc2b510c64..1ee8c0c7bd2e 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -180,6 +180,8 @@ Code  Seq#    Include File                                           Comments
 'R'   01     linux/rfkill.h                                          conflict!
 'R'   C0-DF  net/bluetooth/rfcomm.h
 'R'   E0     uapi/linux/fsl_mc.h
+'R'   F0-FF  uapi/misc/hv_azure_blob.h                               Microsoft Azure Blob driver
+                                                                     <mailto:longli@microsoft.com>
 'S'   all    linux/cdrom.h                                           conflict!
 'S'   80-81  scsi/scsi_ioctl.h                                       conflict!
 'S'   82-FF  scsi/scsi.h                                             conflict!
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d92391..53bebd0ad812 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -27,4 +27,15 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_AZURE_BLOB
+	tristate "Microsoft Azure Blob driver"
+	depends on HYPERV && X86_64
+	help
+	  Select this option to enable Microsoft Azure Blob driver.
+
+	  This driver implements a fast datapath over Hyper-V to support
+	  accelerated access to Microsoft Azure Blob services.
+	  To compile this driver as a module, choose M here. The module will be
+	  called azure_blob.
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf8240c95..272644532245 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_HYPERV_AZURE_BLOB)	+= hv_azure_blob.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 705e95d7a040..3095611045b5 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -154,6 +154,13 @@ const struct vmbus_device vmbus_devs[] = {
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
diff --git a/drivers/hv/hv_azure_blob.c b/drivers/hv/hv_azure_blob.c
new file mode 100644
index 000000000000..04bec92aa058
--- /dev/null
+++ b/drivers/hv/hv_azure_blob.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021 Microsoft Corporation. */
+
+#include <uapi/misc/hv_azure_blob.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/debugfs.h>
+#include <linux/pagemap.h>
+#include <linux/hyperv.h>
+#include <linux/miscdevice.h>
+#include <linux/uio.h>
+
+struct az_blob_device {
+	struct hv_device *device;
+
+	/* Opened files maintained by this device */
+	struct list_head file_list;
+	/* Lock for protecting file_list */
+	spinlock_t file_lock;
+
+	/* The refcount for this device */
+	refcount_t count;
+
+	/* Pending requests to VSP */
+	atomic_t pending;
+	wait_queue_head_t waiting_to_drain;
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
+	/* Lock for protecting vsp_pending_requests */
+	spinlock_t vsp_pending_lock;
+	wait_queue_head_t wait_vsp_pending;
+
+	pid_t pid;
+
+	struct az_blob_device *dev;
+};
+
+/* The maximum number of pages we can pass to VSP in a single packet */
+#define AZ_BLOB_MAX_PAGES 8192
+
+static struct az_blob_device *az_blob_dev;
+#define AZ_DEV (&az_blob_dev->device->device)
+
+/* Ring buffer size in bytes */
+#define AZ_BLOB_RING_SIZE (128 * 1024)
+
+/* System wide device queue depth */
+#define AZ_BLOB_QUEUE_DEPTH 1024
+
+/* The VSP protocol version this driver understands */
+#define VSP_PROTOCOL_VERSION_V1 0
+
+static const struct hv_vmbus_device_id id_table[] = {
+	{ HV_AZURE_BLOB_GUID,
+	  .driver_data = 0
+	},
+	{ },
+};
+
+static void az_blob_on_channel_callback(void *context)
+{
+	struct vmbus_channel *channel = (struct vmbus_channel *)context;
+	const struct vmpacket_descriptor *desc;
+
+	foreach_vmbus_pkt(desc, channel) {
+		struct az_blob_vsp_request_ctx *request_ctx;
+		struct az_blob_vsp_response *response;
+		u64 cmd_rqst = vmbus_request_addr(&channel->requestor,
+						  desc->trans_id);
+		if (cmd_rqst == VMBUS_RQST_ERROR) {
+			dev_err(AZ_DEV, "incorrect transaction id %llu\n",
+				desc->trans_id);
+			continue;
+		}
+		request_ctx = (struct az_blob_vsp_request_ctx *)cmd_rqst;
+		response = hv_pkt_data(desc);
+
+		dev_dbg(AZ_DEV, "got response for request %pUb status %u "
+			    "response_len %u\n",
+			    &request_ctx->request->guid, response->error,
+			    response->response_len);
+		request_ctx->request->response.status = response->error;
+		request_ctx->request->response.response_len =
+			response->response_len;
+		complete(&request_ctx->wait_vsp);
+	}
+}
+
+static int az_blob_fop_open(struct inode *inode, struct file *file)
+{
+	struct az_blob_device *dev = az_blob_dev;
+	struct az_blob_file_ctx *file_ctx;
+	unsigned long flags;
+
+	file_ctx = kzalloc(sizeof(*file_ctx), GFP_KERNEL);
+	if (!file_ctx)
+		return -ENOMEM;
+
+	file_ctx->pid = task_tgid_vnr(current);
+	INIT_LIST_HEAD(&file_ctx->vsp_pending_requests);
+	init_waitqueue_head(&file_ctx->wait_vsp_pending);
+	spin_lock_init(&file_ctx->vsp_pending_lock);
+	file_ctx->dev = dev;
+	refcount_inc(&dev->count);
+
+	spin_lock_irqsave(&dev->file_lock, flags);
+	list_add_tail(&file_ctx->list, &dev->file_list);
+	spin_unlock_irqrestore(&dev->file_lock, flags);
+
+	file->private_data = file_ctx;
+	return 0;
+}
+
+static int az_blob_fop_release(struct inode *inode, struct file *file)
+{
+	struct az_blob_file_ctx *file_ctx = file->private_data;
+	struct az_blob_device *dev = file_ctx->dev;
+	unsigned long flags;
+
+	wait_event(file_ctx->wait_vsp_pending,
+		   list_empty(&file_ctx->vsp_pending_requests));
+
+	spin_lock_irqsave(&dev->file_lock, flags);
+	list_del(&file_ctx->list);
+	spin_unlock_irqrestore(&dev->file_lock, flags);
+
+	kfree(file_ctx);
+	if (refcount_dec_and_test(&dev->count))
+		kfree(dev);
+
+	return 0;
+}
+
+static inline bool az_blob_safe_file_access(struct file *file)
+{
+	return file->f_cred == current_cred() && !uaccess_kernel();
+}
+
+/* Pin the user buffer pages into memory for passing to VSP */
+static int get_buffer_pages(int rw, void __user *buffer, u32 buffer_len,
+			    struct page ***ppages, size_t *start,
+			    size_t *num_pages)
+{
+	struct iovec iov;
+	struct iov_iter iter;
+	int ret;
+	ssize_t result;
+	struct page **pages;
+
+	ret = import_single_range(rw, buffer, buffer_len, &iov, &iter);
+	if (ret) {
+		dev_dbg(AZ_DEV, "request buffer access error %d\n", ret);
+		return ret;
+	}
+
+	result = iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start);
+	if (result < 0) {
+		dev_dbg(AZ_DEV, "failed to pin user pages result=%ld\n", result);
+		return result;
+	}
+
+	*num_pages = (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
+	if (result != buffer_len) {
+		dev_dbg(AZ_DEV, "can't pin user pages requested %d got %ld\n",
+			buffer_len, result);
+		for (i = 0; i < *num_pages; i++)
+			put_page(pages[i]);
+		kvfree(pages);
+		return -EFAULT;
+	}
+
+	*ppages = pages;
+	return 0;
+}
+
+static void fill_in_page_buffer(u64 *pfn_array, int *index,
+				struct page **pages, unsigned long num_pages)
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
+		if (pages && pages[i])
+			put_page(pages[i]);
+	kvfree(pages);
+}
+
+static long az_blob_ioctl_user_request(struct file *filp, unsigned long arg)
+{
+	struct az_blob_file_ctx *file_ctx = filp->private_data;
+	struct az_blob_device *dev = file_ctx->dev;
+	struct az_blob_request_sync __user *request_user =
+		(struct az_blob_request_sync __user *)arg;
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
+		dev_dbg(AZ_DEV, "process %d(%s) changed security contexts after"
+			    " opening file descriptor\n",
+			    task_tgid_vnr(current), current->comm);
+		return -EACCES;
+	}
+
+	if (copy_from_user(&request, request_user, sizeof(request))) {
+		dev_dbg(AZ_DEV, "don't have permission to user provided buffer\n");
+		return -EFAULT;
+	}
+
+	dev_dbg(AZ_DEV, "az_blob ioctl request guid %pUb timeout %u request_len %u"
+		    " response_len %u data_len %u request_buffer %llx "
+		    "response_buffer %llx data_buffer %llx\n",
+		    &request.guid, request.timeout, request.request_len,
+		    request.response_len, request.data_len, request.request_buffer,
+		    request.response_buffer, request.data_buffer);
+
+	if (!request.request_len || !request.response_len)
+		return -EINVAL;
+
+	if (request.data_len && request.data_len < request.data_valid)
+		return -EINVAL;
+
+	if (request.data_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
+	    request.request_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
+	    request.response_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES)
+		return -EINVAL;
+
+	init_completion(&request_ctx.wait_vsp);
+	request_ctx.request = &request;
+
+	ret = get_buffer_pages(READ, (void __user *)request.request_buffer,
+			       request.request_len, &request_pages,
+			       &request_start, &request_num_pages);
+	if (ret)
+		goto get_user_page_failed;
+
+	ret = get_buffer_pages(READ | WRITE,
+			       (void __user *)request.response_buffer,
+			       request.response_len, &response_pages,
+			       &response_start, &response_num_pages);
+	if (ret)
+		goto get_user_page_failed;
+
+	if (request.data_len) {
+		ret = get_buffer_pages(READ | WRITE,
+				       (void __user *)request.data_buffer,
+				       request.data_len, &data_pages,
+				       &data_start, &data_num_pages);
+		if (ret)
+			goto get_user_page_failed;
+	}
+
+	total_num_pages = request_num_pages + response_num_pages +
+				data_num_pages;
+	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
+		dev_dbg(AZ_DEV, "number of DMA pages %lu buffer exceeding %u\n",
+			total_num_pages, AZ_BLOB_MAX_PAGES);
+		ret = -EINVAL;
+		goto get_user_page_failed;
+	}
+
+	/* Construct a VMBUS packet and send it over to VSP */
+	desc_size = struct_size(desc, range.pfn_array, total_num_pages);
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
+				    data_num_pages);
+		vsp_request->data_buffer_offset = data_start;
+		vsp_request->data_buffer_length = request.data_len;
+		vsp_request->data_buffer_valid = request.data_valid;
+	}
+
+	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
+			    request_num_pages);
+	vsp_request->request_buffer_offset = request_start +
+						data_num_pages * PAGE_SIZE;
+	vsp_request->request_buffer_length = request.request_len;
+
+	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
+			    response_num_pages);
+	vsp_request->response_buffer_offset = response_start +
+		(data_num_pages + request_num_pages) * PAGE_SIZE;
+	vsp_request->response_buffer_length = request.response_len;
+
+	vsp_request->version = VSP_PROTOCOL_VERSION_V1;
+	vsp_request->timeout_ms = request.timeout;
+	vsp_request->operation_type = AZ_BLOB_DRIVER_USER_REQUEST;
+	guid_copy(&vsp_request->transaction_id, &request.guid);
+
+	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
+	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
+	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
+
+	atomic_inc(&dev->pending);
+
+	/* Check if device is being removed */
+	if (dev->removing) {
+		ret = -ENODEV;
+		goto vmbus_send_failed;
+	}
+
+	ret = vmbus_sendpacket_mpb_desc(dev->device->channel, desc, desc_size,
+					vsp_request, sizeof(*vsp_request),
+					(u64)&request_ctx);
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
+	if (copy_to_user(&request_user->response, &request.response,
+			 sizeof(request.response)))
+		ret = -EFAULT;
+
+vmbus_send_failed:
+	if (atomic_dec_and_test(&dev->pending) && dev->removing)
+		wake_up(&dev->waiting_to_drain);
+
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
+			      unsigned long arg)
+{
+	switch (cmd) {
+	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
+		return az_blob_ioctl_user_request(filp, arg);
+
+	default:
+		dev_dbg(AZ_DEV, "unrecognized IOCTL code %u\n", cmd);
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations az_blob_client_fops = {
+	.owner		= THIS_MODULE,
+	.open		= az_blob_fop_open,
+	.unlocked_ioctl = az_blob_fop_ioctl,
+	.release	= az_blob_fop_release,
+};
+
+static struct miscdevice az_blob_misc_device = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "azure_blob",
+	.fops	= &az_blob_client_fops,
+};
+
+static int az_blob_show_pending_requests(struct seq_file *m, void *v)
+{
+	unsigned long flags, flags2;
+	struct az_blob_vsp_request_ctx *request_ctx;
+	struct az_blob_file_ctx *file_ctx;
+	struct az_blob_device *dev = az_blob_dev;
+
+	seq_puts(m, "List of pending requests\n");
+	seq_puts(m, "UUID request_len response_len data_len "
+		"request_buffer response_buffer data_buffer\n");
+	spin_lock_irqsave(&dev->file_lock, flags);
+	list_for_each_entry(file_ctx, &dev->file_list, list) {
+		spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags2);
+		seq_printf(m, "file context for pid %u\n", file_ctx->pid);
+		list_for_each_entry(request_ctx,
+				    &file_ctx->vsp_pending_requests, list) {
+			seq_printf(m, "%pUb ", &request_ctx->request->guid);
+			seq_printf(m, "%u ", request_ctx->request->request_len);
+			seq_printf(m, "%u ",
+				   request_ctx->request->response_len);
+			seq_printf(m, "%u ", request_ctx->request->data_len);
+			seq_printf(m, "%llx ",
+				   request_ctx->request->request_buffer);
+			seq_printf(m, "%llx ",
+				   request_ctx->request->response_buffer);
+			seq_printf(m, "%llx\n",
+				   request_ctx->request->data_buffer);
+		}
+		spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags2);
+	}
+	spin_unlock_irqrestore(&dev->file_lock, flags);
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
+static void az_blob_remove_device(void)
+{
+	struct dentry *debugfs_root = debugfs_lookup("az_blob", NULL);
+
+	debugfs_remove_recursive(debugfs_root);
+	misc_deregister(&az_blob_misc_device);
+}
+
+static int az_blob_create_device(struct az_blob_device *dev)
+{
+	int ret;
+	struct dentry *debugfs_root;
+
+	ret = misc_register(&az_blob_misc_device);
+	if (ret)
+		return ret;
+
+	debugfs_root = debugfs_create_dir("az_blob", NULL);
+	debugfs_create_file("pending_requests", 0400, debugfs_root, NULL,
+			    &az_blob_debugfs_fops);
+
+	return 0;
+}
+
+static int az_blob_connect_to_vsp(struct hv_device *device,
+				  struct az_blob_device *dev, u32 ring_size)
+{
+	int ret;
+
+	dev->device = device;
+	device->channel->rqstor_size = AZ_BLOB_QUEUE_DEPTH;
+
+	ret = vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
+			 az_blob_on_channel_callback, device->channel);
+
+	if (ret)
+		return ret;
+
+	hv_set_drvdata(device, dev);
+
+	return ret;
+}
+
+static void az_blob_remove_vmbus(struct hv_device *device)
+{
+	hv_set_drvdata(device, NULL);
+	vmbus_close(device->channel);
+}
+
+static int az_blob_probe(struct hv_device *device,
+			 const struct hv_vmbus_device_id *dev_id)
+{
+	int ret;
+	struct az_blob_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	spin_lock_init(&dev->file_lock);
+	INIT_LIST_HEAD(&dev->file_list);
+	atomic_set(&dev->pending, 0);
+	init_waitqueue_head(&dev->waiting_to_drain);
+
+	ret = az_blob_connect_to_vsp(device, dev, AZ_BLOB_RING_SIZE);
+	if (ret)
+		goto fail;
+
+	refcount_set(&dev->count, 1);
+	az_blob_dev = dev;
+
+	// create user-mode client library facing device
+	ret = az_blob_create_device(dev);
+	if (ret) {
+		dev_err(AZ_DEV, "failed to create device ret=%d\n", ret);
+		az_blob_remove_vmbus(device);
+		goto fail;
+	}
+
+	dev_info(AZ_DEV, "successfully probed device\n");
+	return 0;
+
+fail:
+	kfree(dev);
+	return ret;
+}
+
+static int az_blob_remove(struct hv_device *device)
+{
+	struct az_blob_device *dev = hv_get_drvdata(device);
+
+	dev->removing = true;
+	az_blob_remove_device();
+
+	/*
+	 * We won't get any new requests from user-mode. There may be
+	 * pending requests already sent over VMBUS and we may get more
+	 * responses from VSP. Wait until no VSC/VSP traffic is possible.
+	 */
+	wait_event(dev->waiting_to_drain,
+		   atomic_read(&dev->pending) == 0);
+
+	az_blob_remove_vmbus(device);
+
+	if (refcount_dec_and_test(&dev->count))
+		kfree(dev);
+
+	return 0;
+}
+
+static struct hv_driver az_blob_drv = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= id_table,
+	.probe		= az_blob_probe,
+	.remove		= az_blob_remove,
+	.driver		= {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int __init az_blob_drv_init(void)
+{
+	return vmbus_driver_register(&az_blob_drv);
+}
+
+static void __exit az_blob_drv_exit(void)
+{
+	vmbus_driver_unregister(&az_blob_drv);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Azure Blob driver");
+module_init(az_blob_drv_init);
+module_exit(az_blob_drv_exit);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d1e59dbef1dd..ac3136284ace 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -772,6 +772,7 @@ enum vmbus_device_type {
 	HV_FCOPY,
 	HV_BACKUP,
 	HV_DM,
+	HV_AZURE_BLOB,
 	HV_UNKNOWN,
 };
 
@@ -1349,6 +1350,14 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 	.guid = GUID_INIT(0xba6163d9, 0x04a1, 0x4d29, 0xb6, 0x05, \
 			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
 
+/*
+ * Azure Blob GUID
+ * {0590b792-db64-45cc-81db-b8d70c577c9e}
+ */
+#define HV_AZURE_BLOB_GUID \
+	.guid = GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
+			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
+
 /*
  * Shutdown GUID
  * {0e0b6031-5213-4934-818b-38d90ced39db}
diff --git a/include/uapi/misc/hv_azure_blob.h b/include/uapi/misc/hv_azure_blob.h
new file mode 100644
index 000000000000..ebb141b2762a
--- /dev/null
+++ b/include/uapi/misc/hv_azure_blob.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/* Copyright (c) 2021 Microsoft Corporation. */
+
+#ifndef _AZ_BLOB_H
+#define _AZ_BLOB_H
+
+#include <linux/kernel.h>
+#include <linux/uuid.h>
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
2.25.1

