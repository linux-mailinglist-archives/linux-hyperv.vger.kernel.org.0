Return-Path: <linux-hyperv+bounces-10777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G87FuuKAmrVtwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10777-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:05:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A3518A25
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2FEF305D5FE
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F422F619D;
	Tue, 12 May 2026 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bD+tslee"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580632D7812;
	Tue, 12 May 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551405; cv=none; b=Kkj9HebQ+nm1jwej27AzzY4WBdzvrLKE18veGBPqvhN2jrX8qTa7uK8UYZSpGjQ0WYF4fZEfirr6tKujhsw+OF7ETmuPzpI08ymG70gj/r+Q9jkIjwUjeVkRCdJU4dnQWWyUVHcTBiPsC64XH44IuTSXP3P9blTIFskHTuqqq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551405; c=relaxed/simple;
	bh=cKNmu5kTnn04IlU0+uGx8nFTijByejUaTMVt4ltTx5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrkQ86iuVdoygVu+OB0NSp0JmutPLPCa+sh1xjvYUitsNZvPNvdY/n3gacuqf1D9xJ/mj7pI6q8gkAKnuQvtX5otCw1kV8YXGgVVc9J9HZSZ/BuxnLuULrgRynO8Jel6mKKn54FrphaghG/smdvj6DJ/ldLFJaBYQbS9jXt7kiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bD+tslee; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id F08C720B7169;
	Mon, 11 May 2026 19:03:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F08C720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551400;
	bh=5AUWmMSE9er8oWtWVdhLYfhBV62m5YIK8L9e8/xH+o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bD+tsleeoUrmJPtjyj0ISriWIzzCOckDXpIS/7xvyWwNyIceA+MjeHPLEZlF2zs4c
	 YgKSTcySxmupLiWCW5kYybLWGm0KiNq7Nkq5pWqaM/UWMa5Aj+8EBSs3ZCZKLnHxDu
	 LGQfyhioa8fVcPoIwPhuxG8VCq7pYk9ITmDpgtmY=
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
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V3 05/11] mshv: Implement mshv bridge device for VFIO
Date: Mon, 11 May 2026 19:02:53 -0700
Message-ID: <20260512020259.1678627-6-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB5A3518A25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10777-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

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
index be6fe3ee8707..b038a79786d2 100644
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


