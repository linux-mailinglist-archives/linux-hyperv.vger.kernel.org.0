Return-Path: <linux-hyperv+bounces-10300-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDafGz406GlDGwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10300-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:36:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BD4417F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9249230156EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54C38B7D6;
	Wed, 22 Apr 2026 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GgLzpdJZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA7382F28;
	Wed, 22 Apr 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825238; cv=none; b=CH3KS8gmXPPRB9m6XYJksBcEuggtP1YZ2G6ffjjyuPZPcPKCw3OFMUaGKK8EGJ5j2cFkjvRY/emPqGB21NOu+NQwXJ9o6osJJd0zNALps4m0t5in4isyKl2MSakb6OaddNQQFae0a9i9aDn2X0L8sLNvQTJ4C1+7zX3Y5Y8pqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825238; c=relaxed/simple;
	bh=jYrebEGyLACqbZL/w3y9a7O0xWgw6FHchfvbYBMKEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRc/AUM1OY/zrRDaaTIkMHvLUV8piHXbpsJdlLiYBguWKJqxuG3TGFqsq1wxmq6GXDVY6FYCux3a7FXPS0fIrqo1YEfP/j/2Gj7QlIELF8mcooRiI3IzjVnhuPpUEyGzAtv5NEvfvoN7kJyJtUqFpGvaAoIkypaeJcVkVmQ90MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GgLzpdJZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F8A320B6F1F;
	Tue, 21 Apr 2026 19:33:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F8A320B6F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825225;
	bh=YnF+uI+QwqeYTK6oQpqBg7HAiFmqfGlkyQt6D84StzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgLzpdJZ9nmTE/p4NZSlFoqA8wfROdvtb29VmC5gy4u/g+sAFKx15pHMNK0ZG8yfE
	 ZZXvc8Tcv/AFHSLs7vfDcTEqxfvehzsr5Ba8763F99tj78RMpsTTOAbzlpVQ1i8sAI
	 YdWhJVQ0mYd+YLMldvIq5xIVa5h4ubRqYaMgZAfk=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V1 06/13] mshv: Implement mshv bridge device for VFIO
Date: Tue, 21 Apr 2026 19:32:32 -0700
Message-ID: <20260422023239.1171963-7-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10300-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E41BD4417F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new file to implement VFIO-MSHV bridge pseudo device. These
functions are called in the VFIO framework, and credits to kvm/vfio.c
as this file was adapted from it.

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/Makefile       |   3 +-
 drivers/hv/mshv_vfio.c    | 211 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mshv.h |   1 +
 3 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/mshv_vfio.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 888a748cc7cb..9ab6fc254c38 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -14,7 +14,8 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
-	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
+	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o  \
+               mshv_vfio.o
 mshv_root-$(CONFIG_DEBUG_FS) += mshv_debugfs.o
 mshv_root-$(CONFIG_TRACEPOINTS) += mshv_trace.o
 mshv_vtl-y := mshv_vtl_main.o
diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
new file mode 100644
index 000000000000..00a97920e25b
--- /dev/null
+++ b/drivers/hv/mshv_vfio.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO-MSHV bridge pseudo device
+ *
+ * Heavily inspired by the VFIO-KVM bridge pseudo device.
+ */
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/vfio.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+struct mshv_vfio_file {
+	struct list_head node;
+	struct file *file;	/* list of struct mshv_vfio_file */
+};
+
+struct mshv_vfio {
+	struct list_head file_list;
+	struct mutex lock;
+};
+
+static bool mshv_vfio_file_is_valid(struct file *file)
+{
+	bool (*fn)(struct file *file);
+	bool ret;
+
+	fn = symbol_get(vfio_file_is_valid);
+	if (!fn)
+		return false;
+
+	ret = fn(file);
+
+	symbol_put(vfio_file_is_valid);
+
+	return ret;
+}
+
+static long mshv_vfio_file_add(struct mshv_device *mshvdev, unsigned int fd)
+{
+	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
+	struct mshv_vfio_file *mvf;
+	struct file *filp;
+	long ret = 0;
+
+	filp = fget(fd);
+	if (!filp)
+		return -EBADF;
+
+	/* Ensure the FD is a vfio FD. */
+	if (!mshv_vfio_file_is_valid(filp)) {
+		ret = -EINVAL;
+		goto out_fput;
+	}
+
+	mutex_lock(&mshv_vfio->lock);
+
+	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
+		if (mvf->file == filp) {
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+	}
+
+	mvf = kzalloc(sizeof(*mvf), GFP_KERNEL_ACCOUNT);
+	if (!mvf) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	mvf->file = get_file(filp);
+	list_add_tail(&mvf->node, &mshv_vfio->file_list);
+
+out_unlock:
+	mutex_unlock(&mshv_vfio->lock);
+out_fput:
+	fput(filp);
+	return ret;
+}
+
+static long mshv_vfio_file_del(struct mshv_device *mshvdev, unsigned int fd)
+{
+	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
+	struct mshv_vfio_file *mvf;
+	long ret;
+
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+
+	ret = -ENOENT;
+	mutex_lock(&mshv_vfio->lock);
+
+	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
+		if (mvf->file != fd_file(f))
+			continue;
+
+		list_del(&mvf->node);
+		fput(mvf->file);
+		kfree(mvf);
+		ret = 0;
+		break;
+	}
+
+	mutex_unlock(&mshv_vfio->lock);
+	return ret;
+}
+
+static long mshv_vfio_set_file(struct mshv_device *mshvdev, long attr,
+			      void __user *arg)
+{
+	int32_t __user *argp = arg;
+	int32_t fd;
+
+	switch (attr) {
+	case MSHV_DEV_VFIO_FILE_ADD:
+		if (get_user(fd, argp))
+			return -EFAULT;
+		return mshv_vfio_file_add(mshvdev, fd);
+
+	case MSHV_DEV_VFIO_FILE_DEL:
+		if (get_user(fd, argp))
+			return -EFAULT;
+		return mshv_vfio_file_del(mshvdev, fd);
+	}
+
+	return -ENXIO;
+}
+
+static long mshv_vfio_set_attr(struct mshv_device *mshvdev,
+			      struct mshv_device_attr *attr)
+{
+	switch (attr->group) {
+	case MSHV_DEV_VFIO_FILE:
+		return mshv_vfio_set_file(mshvdev, attr->attr,
+					  u64_to_user_ptr(attr->addr));
+	}
+
+	return -ENXIO;
+}
+
+static long mshv_vfio_has_attr(struct mshv_device *mshvdev,
+			      struct mshv_device_attr *attr)
+{
+	switch (attr->group) {
+	case MSHV_DEV_VFIO_FILE:
+		switch (attr->attr) {
+		case MSHV_DEV_VFIO_FILE_ADD:
+		case MSHV_DEV_VFIO_FILE_DEL:
+			return 0;
+		}
+
+		break;
+	}
+
+	return -ENXIO;
+}
+
+static long mshv_vfio_create_device(struct mshv_device *mshvdev)
+{
+	struct mshv_device *tmp;
+	struct mshv_vfio *mshv_vfio;
+
+	/* Only one VFIO "device" per VM */
+	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
+			     device_ptnode)
+		if (tmp->device_ops == &mshv_vfio_device_ops)
+			return -EBUSY;
+
+	mshv_vfio = kzalloc(sizeof(*mshv_vfio), GFP_KERNEL_ACCOUNT);
+	if (mshv_vfio == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mshv_vfio->file_list);
+	mutex_init(&mshv_vfio->lock);
+
+	mshvdev->device_private = mshv_vfio;
+
+	return 0;
+}
+
+/* This is called from mshv_device_fop_release() */
+static void mshv_vfio_release_device(struct mshv_device *mshvdev)
+{
+	struct mshv_vfio *mv = mshvdev->device_private;
+	struct mshv_vfio_file *mvf, *tmp;
+
+	list_for_each_entry_safe(mvf, tmp, &mv->file_list, node) {
+		fput(mvf->file);
+		list_del(&mvf->node);
+		kfree(mvf);
+	}
+
+	kfree(mv);
+	kfree(mshvdev);
+}
+
+struct mshv_device_ops mshv_vfio_device_ops = {
+	.device_name = "mshv-vfio",
+	.device_create = mshv_vfio_create_device,
+	.device_release = mshv_vfio_release_device,
+	.device_set_attr = mshv_vfio_set_attr,
+	.device_has_attr = mshv_vfio_has_attr,
+};
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 4373a8243951..6404e8a98237 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -254,6 +254,7 @@ struct mshv_root_hvcall {
 #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
 /* Generic hypercall */
 #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+#define MSHV_CREATE_DEVICE             _IOWR(MSHV_IOCTL, 0x08, struct mshv_create_device)
 
 /*
  ********************************
-- 
2.51.2.vfs.0.1


