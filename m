Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27639EB35
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jun 2021 03:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFHBGm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Jun 2021 21:06:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45960 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhFHBGl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Jun 2021 21:06:41 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 84C0B20B83DC; Mon,  7 Jun 2021 18:04:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84C0B20B83DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1623114289;
        bh=IiOwotsdyVIdaHigget4NjIt/V8VyBvs6xb4Rj6AyxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1hEZo2lgHglPUkW4+zMDO3vcHOqQAqyc2jHhe0OakQfmwtKX2yurujvC0QmXJz9G
         s3v0Dt7Fpy/azLRxS7RA26a+euyoMo008eZE/aaCt9NqJRHhfGHoGypTVHelIYt2If
         SIS3tIH+ePUxwBdaxZ2muzyTp20d2KlRDCdxwyL4=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Date:   Mon,  7 Jun 2021 18:04:36 -0700
Message-Id: <1623114276-11696-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Add XStore Fastpath driver to support accelerated access to Azure Blob
Storage Services.

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 MAINTAINERS                 |   1 +
 drivers/hv/Kconfig          |  11 +
 drivers/hv/Makefile         |   1 +
 drivers/hv/channel_mgmt.c   |   6 +
 drivers/hv/hv_xs_fastpath.c | 579 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/hv_xs_fastpath.h |  82 +++++++
 include/linux/hyperv.h      |   9 +
 7 files changed, 689 insertions(+)
 create mode 100644 drivers/hv/hv_xs_fastpath.c
 create mode 100644 drivers/hv/hv_xs_fastpath.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9487061..b547eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8440,6 +8440,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Stephen Hemminger <sthemmin@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Dexuan Cui <decui@microsoft.com>
+M:	Long Li <longli@microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d..2128a8b 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -27,4 +27,15 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_XS_FASTPATH
+	tristate "Microsoft Azure XStore Fastpath driver"
+	depends on HYPERV && X86_64
+	help
+	  Select this option to enable Microsoft Azure XStore Fastpath driver.
+
+	  This driver supports accelerated Microsoft Azure XStore Blob access.
+	  To compile this driver as a module, choose M here. The module will be
+	  called hv_xs_fastpath.
+
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf82..080fe88 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_HYPERV_XS_FASTPATH)+= hv_xs_fastpath.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6fd7ae5..a3f156e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -153,6 +153,12 @@
 	  .allowed_in_isolated = false,
 	},
 
+	/* XStore Fastpath */
+	{ .dev_type = HV_XS_FASTPATH,
+	  HV_XS_FASTPATH_GUID,
+	  .perf_device = true,
+	},
+
 	/* Unknown GUID */
 	{ .dev_type = HV_UNKNOWN,
 	  .perf_device = false,
diff --git a/drivers/hv/hv_xs_fastpath.c b/drivers/hv/hv_xs_fastpath.c
new file mode 100644
index 0000000..ee4152e
--- /dev/null
+++ b/drivers/hv/hv_xs_fastpath.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Long Li <longli@microsoft.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/debugfs.h>
+#include <linux/pagemap.h>
+#include "hv_xs_fastpath.h"
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *xs_fastpath_debugfs_root;
+#endif
+
+static struct xs_fastpath_device xs_fastpath_dev;
+
+static int xs_fastpath_ringbuffer_size = (128 * 1024);
+module_param(xs_fastpath_ringbuffer_size, int, 0444);
+MODULE_PARM_DESC(xs_fastpath_ringbuffer_size, "Ring buffer size (bytes)");
+
+static const struct hv_vmbus_device_id id_table[] = {
+	{ HV_XS_FASTPATH_GUID,
+	  .driver_data = 0
+	},
+	{ },
+};
+
+#define XS_ERR 0
+#define XS_WARN 1
+#define XS_DBG 2
+static int log_level = XS_WARN;
+module_param(log_level, int, 0644);
+MODULE_PARM_DESC(logging_level,
+	"Log level, 0 - Error, 1 - Warning (default), 3 - Debug.");
+
+#define xs_fastpath_log(level, fmt, args...)	\
+do {	\
+	if (level <= log_level)	\
+		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
+} while (0)
+
+#define xs_fastpath_dbg(fmt, args...) xs_fastpath_log(XS_DBG, fmt, ##args)
+#define xs_fastpath_warn(fmt, args...) xs_fastpath_log(XS_WARN, fmt, ##args)
+#define xs_fastpath_err(fmt, args...) xs_fastpath_log(XS_ERR, fmt, ##args)
+
+struct xs_fastpath_vsp_request_ctx {
+	struct list_head list;
+	struct completion wait_vsp;
+	struct xs_fastpath_request_sync *request;
+};
+
+static void xs_fastpath_on_channel_callback(void *context)
+{
+	struct vmbus_channel *channel = (struct vmbus_channel *)context;
+	const struct vmpacket_descriptor *desc;
+
+	xs_fastpath_dbg("entering interrupt from vmbus\n");
+	foreach_vmbus_pkt(desc, channel) {
+		struct xs_fastpath_vsp_request_ctx *request_ctx;
+		struct xs_fastpath_vsp_response *response;
+		u64 cmd_rqst = vmbus_request_addr(&channel->requestor,
+					desc->trans_id);
+		if (cmd_rqst == VMBUS_RQST_ERROR) {
+			xs_fastpath_err("Incorrect transaction id %llu\n",
+				desc->trans_id);
+			continue;
+		}
+		request_ctx = (struct xs_fastpath_vsp_request_ctx *) cmd_rqst;
+		response = hv_pkt_data(desc);
+
+		xs_fastpath_dbg("got response for request %pUb status %u "
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
+static int xs_fastpath_fop_open(struct inode *inode, struct file *file)
+{
+	atomic_inc(&xs_fastpath_dev.file_count);
+	if (xs_fastpath_dev.removing) {
+		if (atomic_dec_and_test(&xs_fastpath_dev.file_count))
+			wake_up(&xs_fastpath_dev.wait_files);
+		return -ENODEV;
+	}
+
+	file->private_data = &xs_fastpath_dev;
+
+	return 0;
+}
+
+static int xs_fastpath_fop_release(struct inode *inode, struct file *file)
+{
+	if (atomic_dec_and_test(&xs_fastpath_dev.file_count))
+		wake_up(&xs_fastpath_dev.wait_files);
+	return 0;
+}
+
+static inline bool xs_fastpath_safe_file_access(struct file *file)
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
+		xs_fastpath_err("request buffer access error %d\n", ret);
+		return ret;
+	}
+	xs_fastpath_dbg("iov_iter type %d offset %lu count %lu nr_segs %lu\n",
+		iter.type, iter.iov_offset, iter.count, iter.nr_segs);
+
+	result = iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start);
+	if (result < 0) {
+		xs_fastpath_err("failed to ping user pages result=%ld\n", result);
+		return result;
+	}
+	if (result != buffer_len) {
+		xs_fastpath_err("can't ping user pages requested %d got %ld\n",
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
+	kfree(pages);
+}
+
+static long xs_fastpath_ioctl_user_request(struct file *filp, unsigned long arg)
+{
+	struct xs_fastpath_device *dev = filp->private_data;
+	char __user *argp = (char __user *) arg;
+	struct xs_fastpath_request_sync request;
+	struct xs_fastpath_vsp_request_ctx *request_ctx;
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
+	struct xs_fastpath_vsp_request *vsp_request;
+
+	if (dev->removing)
+		return -ENODEV;
+
+	if (!xs_fastpath_safe_file_access(filp)) {
+		xs_fastpath_err("process %d(%s) changed security contexts after"
+			" opening file descriptor\n",
+			task_tgid_vnr(current), current->comm);
+		return -EACCES;
+	}
+
+	if (!access_ok(argp, sizeof(struct xs_fastpath_request_sync))) {
+
+		xs_fastpath_err("don't have permission to user provided buffer\n");
+		return -EFAULT;
+	}
+
+	if (copy_from_user(&request, argp, sizeof(request)))
+		return -EFAULT;
+
+	xs_fastpath_dbg("xs_fastpath ioctl request guid %pUb timeout %u request_len %u"
+		" response_len %u data_len %u request_buffer %llx "
+		"response_buffer %llx data_buffer %llx\n",
+		&request.guid, request.timeout, request.request_len,
+		request.response_len, request.data_len, request.request_buffer,
+		request.response_buffer, request.data_buffer);
+
+	if (!request.request_len || !request.response_len)
+		return -EINVAL;
+
+	request_ctx = kzalloc(sizeof(*request_ctx), GFP_KERNEL);
+	if (!request_ctx)
+		return -ENOMEM;
+
+	init_completion(&request_ctx->wait_vsp);
+	request_ctx->request = &request;
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
+	if (total_num_pages > XS_FASTPATH_MAX_PAGES) {
+		xs_fastpath_err("number of DMA pages %lu buffer exceeding %u\n",
+			total_num_pages, XS_FASTPATH_MAX_PAGES);
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
+		vsp_request->data_buffer_valid = 1;
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
+	vsp_request->operation_type = XS_FASTPATH_DRIVER_USER_REQUEST;
+	guid_copy(&vsp_request->transaction_id, &request.guid);
+
+	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
+	list_add_tail(&request_ctx->list, &dev->vsp_pending_list);
+	spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
+
+	xs_fastpath_dbg("sending request to VSP\n");
+	xs_fastpath_dbg("desc_size %u desc->range.len %u desc->range.offset %u\n",
+		desc_size, desc->range.len, desc->range.offset);
+	xs_fastpath_dbg("vsp_request data_buffer_offset %u data_buffer_length %u "
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
+		vsp_request, sizeof(*vsp_request), (u64) request_ctx);
+
+	kfree(desc);
+	kfree(vsp_request);
+	if (ret)
+		goto vmbus_send_failed;
+
+	wait_for_completion(&request_ctx->wait_vsp);
+
+	/*
+	 * At this point, the response is already written to request
+	 * by VMBUS completion handler, copy them to user-mode buffers
+	 * and return to user-mode
+	 */
+	if (copy_to_user(argp +
+			offsetof(struct xs_fastpath_request_sync,
+				response.status),
+			&request.response.status,
+			sizeof(request.response.status))) {
+		ret = -EFAULT;
+		goto vmbus_send_failed;
+	}
+
+	if (copy_to_user(argp +
+			offsetof(struct xs_fastpath_request_sync,
+				response.response_len),
+			&request.response.response_len,
+			sizeof(request.response.response_len)))
+		ret = -EFAULT;
+
+vmbus_send_failed:
+	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
+	list_del(&request_ctx->list);
+	if (list_empty(&dev->vsp_pending_list))
+		wake_up(&dev->wait_vsp);
+	spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
+
+get_user_page_failed:
+	free_buffer_pages(request_num_pages, request_pages);
+	free_buffer_pages(response_num_pages, response_pages);
+	free_buffer_pages(data_num_pages, data_pages);
+
+	kfree(request_ctx);
+	return ret;
+}
+
+static long xs_fastpath_fop_ioctl(struct file *filp, unsigned int cmd,
+	unsigned long arg)
+{
+	long ret = -EIO;
+
+	switch (cmd) {
+	case IOCTL_XS_FASTPATH_DRIVER_USER_REQUEST:
+		if (_IOC_SIZE(cmd) != sizeof(struct xs_fastpath_request_sync))
+			return -EINVAL;
+		ret = xs_fastpath_ioctl_user_request(filp, arg);
+		break;
+
+	default:
+		xs_fastpath_err("unrecognized IOCTL code %u\n", cmd);
+	}
+
+	return ret;
+}
+
+static const struct file_operations xs_fastpath_client_fops = {
+	.owner	= THIS_MODULE,
+	.open	= xs_fastpath_fop_open,
+	.unlocked_ioctl = xs_fastpath_fop_ioctl,
+	.release = xs_fastpath_fop_release,
+};
+
+static struct miscdevice xs_fastpath_misc_device = {
+	MISC_DYNAMIC_MINOR,
+	"azure_xs_fastpath",
+	&xs_fastpath_client_fops,
+};
+
+static int xs_fastpath_show_pending_requests(struct seq_file *m, void *v)
+{
+	unsigned long flags;
+	struct xs_fastpath_vsp_request_ctx *request_ctx;
+
+	seq_puts(m, "List of pending requests\n");
+	seq_puts(m, "UUID request_len response_len data_len "
+		"request_buffer response_buffer data_buffer\n");
+	spin_lock_irqsave(&xs_fastpath_dev.vsp_pending_lock, flags);
+	list_for_each_entry(request_ctx, &xs_fastpath_dev.vsp_pending_list, list) {
+		seq_printf(m, "%pUb ", &request_ctx->request->guid);
+		seq_printf(m, "%u ", request_ctx->request->request_len);
+		seq_printf(m, "%u ", request_ctx->request->response_len);
+		seq_printf(m, "%u ", request_ctx->request->data_len);
+		seq_printf(m, "%llx ", request_ctx->request->request_buffer);
+		seq_printf(m, "%llx ", request_ctx->request->response_buffer);
+		seq_printf(m, "%llx\n", request_ctx->request->data_buffer);
+	}
+	spin_unlock_irqrestore(&xs_fastpath_dev.vsp_pending_lock, flags);
+
+	return 0;
+}
+
+static int xs_fastpath_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, xs_fastpath_show_pending_requests, NULL);
+}
+
+static const struct file_operations xs_fastpath_debugfs_fops = {
+	.open		= xs_fastpath_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release
+};
+
+static void xs_fastpath_remove_device(struct xs_fastpath_device *dev)
+{
+	wait_event(dev->wait_files, atomic_read(&dev->file_count) == 0);
+	misc_deregister(&xs_fastpath_misc_device);
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(xs_fastpath_debugfs_root);
+#endif
+	/* At this point, we won't get any requests from user-mode */
+}
+
+static int xs_fastpath_create_device(struct xs_fastpath_device *dev)
+{
+	int rc;
+	struct dentry *d;
+
+	atomic_set(&xs_fastpath_dev.file_count, 0);
+	init_waitqueue_head(&xs_fastpath_dev.wait_files);
+	rc = misc_register(&xs_fastpath_misc_device);
+	if (rc) {
+		xs_fastpath_err("misc_register failed rc %d\n", rc);
+		return rc;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	xs_fastpath_debugfs_root = debugfs_create_dir("xs_fastpath", NULL);
+	if (!IS_ERR_OR_NULL(xs_fastpath_debugfs_root)) {
+		d = debugfs_create_file("pending_requests", 0400,
+			xs_fastpath_debugfs_root, NULL,
+			&xs_fastpath_debugfs_fops);
+		if (IS_ERR_OR_NULL(d)) {
+			xs_fastpath_err("failed to create debugfs file\n");
+			debugfs_remove_recursive(xs_fastpath_debugfs_root);
+			xs_fastpath_debugfs_root = NULL;
+		}
+	} else
+		xs_fastpath_err("failed to create debugfs root\n");
+#endif
+
+	return 0;
+}
+
+static int xs_fastpath_connect_to_vsp(struct hv_device *device, u32 ring_size)
+{
+	int ret;
+
+	spin_lock_init(&xs_fastpath_dev.vsp_pending_lock);
+	INIT_LIST_HEAD(&xs_fastpath_dev.vsp_pending_list);
+	init_waitqueue_head(&xs_fastpath_dev.wait_vsp);
+	xs_fastpath_dev.removing = false;
+
+	xs_fastpath_dev.device = device;
+	device->channel->rqstor_size = xs_fastpath_ringbuffer_size /
+		sizeof(struct xs_fastpath_vsp_request);
+
+	ret = vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
+			xs_fastpath_on_channel_callback, device->channel);
+
+	if (ret) {
+		xs_fastpath_err("failed to connect to VSP ret %d\n", ret);
+		return ret;
+	}
+
+	hv_set_drvdata(device, &xs_fastpath_dev);
+
+	return ret;
+}
+
+static void xs_fastpath_remove_vmbus(struct hv_device *device)
+{
+	struct xs_fastpath_device *dev = hv_get_drvdata(device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
+	if (!list_empty(&dev->vsp_pending_list)) {
+		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
+		xs_fastpath_dbg("wait for vsp_pending_list\n");
+		wait_event(dev->wait_vsp,
+			list_empty(&dev->vsp_pending_list));
+	} else
+		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
+
+	/* At this point, no VSC/VSP traffic is possible over vmbus */
+	hv_set_drvdata(device, NULL);
+	vmbus_close(device->channel);
+}
+
+static int xs_fastpath_probe(struct hv_device *device,
+			const struct hv_vmbus_device_id *dev_id)
+{
+	int rc;
+
+	xs_fastpath_dbg("probing device\n");
+
+	rc = xs_fastpath_connect_to_vsp(device, xs_fastpath_ringbuffer_size);
+	if (rc) {
+		xs_fastpath_err("error connecting to VSP rc %d\n", rc);
+		return rc;
+	}
+
+	// create user-mode client library facing device
+	rc = xs_fastpath_create_device(&xs_fastpath_dev);
+	if (rc) {
+		xs_fastpath_remove_vmbus(device);
+		return rc;
+	}
+
+	xs_fastpath_dbg("successfully probed device\n");
+	return 0;
+}
+
+static int xs_fastpath_remove(struct hv_device *dev)
+{
+	struct xs_fastpath_device *device = hv_get_drvdata(dev);
+
+	device->removing = true;
+	xs_fastpath_remove_device(device);
+	xs_fastpath_remove_vmbus(dev);
+	return 0;
+}
+
+static struct hv_driver xs_fastpath_drv = {
+	.name = KBUILD_MODNAME,
+	.id_table = id_table,
+	.probe = xs_fastpath_probe,
+	.remove = xs_fastpath_remove,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int __init xs_fastpath_drv_init(void)
+{
+	int ret;
+
+	ret = vmbus_driver_register(&xs_fastpath_drv);
+	return ret;
+}
+
+static void __exit xs_fastpath_drv_exit(void)
+{
+	vmbus_driver_unregister(&xs_fastpath_drv);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Azure XStore Storage Fastpath driver");
+module_init(xs_fastpath_drv_init);
+module_exit(xs_fastpath_drv_exit);
diff --git a/drivers/hv/hv_xs_fastpath.h b/drivers/hv/hv_xs_fastpath.h
new file mode 100644
index 0000000..6db1904
--- /dev/null
+++ b/drivers/hv/hv_xs_fastpath.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Long Li <longli@microsoft.com>
+ */
+#ifndef _XS_FASTPATH_H
+#define _XS_FASTPATH_H
+
+#include <linux/hyperv.h>
+#include <linux/miscdevice.h>
+#include <linux/hashtable.h>
+#include <linux/uio.h>
+
+struct xs_fastpath_device {
+	struct hv_device *device;
+	bool removing;
+
+	struct list_head vsp_pending_list;
+	spinlock_t vsp_pending_lock;
+	wait_queue_head_t wait_vsp;
+
+	wait_queue_head_t wait_files;
+	atomic_t file_count;
+};
+
+/* user-mode sync request sent through ioctl */
+struct xs_fastpath_request_sync_response {
+	__u32 status;
+	__u32 response_len;
+};
+
+struct xs_fastpath_request_sync {
+	guid_t guid;
+	__u32 timeout;
+	__u32 request_len;
+	__u32 response_len;
+	__u32 data_len;
+	__aligned_u64 request_buffer;
+	__aligned_u64 response_buffer;
+	__aligned_u64 data_buffer;
+	struct xs_fastpath_request_sync_response response;
+};
+
+/* VSP messages */
+enum xs_fastpath_vsp_request_type {
+	XS_FASTPATH_DRIVER_REQUEST_FIRST     = 0x100,
+	XS_FASTPATH_DRIVER_USER_REQUEST      = 0x100,
+	XS_FASTPATH_DRIVER_REGISTER_BUFFER   = 0x101,
+	XS_FASTPATH_DRIVER_DEREGISTER_BUFFER = 0x102,
+	XS_FASTPATH_DRIVER_REQUEST_MAX       = 0x103
+};
+
+/* VSC->VSP request */
+struct xs_fastpath_vsp_request {
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
+struct xs_fastpath_vsp_response {
+	u32 length;
+	u32 error;
+	u32 response_len;
+} __packed;
+
+#define IOCTL_XS_FASTPATH_DRIVER_USER_REQUEST \
+		_IOWR('R', 10, struct xs_fastpath_request_sync)
+
+#define XS_FASTPATH_MAX_PAGES 8192
+
+#endif /* define _XS_FASTPATH_H */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d1e59db..a1730c4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -772,6 +772,7 @@ enum vmbus_device_type {
 	HV_FCOPY,
 	HV_BACKUP,
 	HV_DM,
+	HV_XS_FASTPATH,
 	HV_UNKNOWN,
 };
 
@@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
 
 /*
+ * XStore Fastpath GUID
+ * {0590b792-db64-45cc-81db-b8d70c577c9e}
+ */
+#define HV_XS_FASTPATH_GUID \
+	.guid = GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
+			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
+
+/*
  * Shutdown GUID
  * {0e0b6031-5213-4934-818b-38d90ced39db}
  */
-- 
1.8.3.1

