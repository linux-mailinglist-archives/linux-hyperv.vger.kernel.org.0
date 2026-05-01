Return-Path: <linux-hyperv+bounces-10534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGSlEij382kC9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10534-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:43:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411084A94A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B50FB3013C48
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667DB2C11D6;
	Fri,  1 May 2026 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M2woPDPU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807329D26E;
	Fri,  1 May 2026 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596138; cv=none; b=cQsNZGkA5U4SIuNgOjVxB9RN1ovEZJR9z+LI7Xhmq6gHW4mkdAKyf/i8kNBT6eycqzxuySjmLVTVTGwWX9fK72u0TvX0zzGdKUppAFbH/D8RUxiLq8Kz2iIvJ8sTqGdlfdpLEKn5cjv4ins1PdtOZ+jtE+RbIb+C7O3rmLYLdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596138; c=relaxed/simple;
	bh=jYrebEGyLACqbZL/w3y9a7O0xWgw6FHchfvbYBMKEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG5azDiLHzS0McDObbeYBOE8uOG2K/PoyfNGhFF833lcBBOjj0kzG/T5TuelkyqvlO5GqE6ELpWVo1kYVDShIjwHZ5KpYAgvTD74E+kc+I0fX4dvvc4UuhoMVi61ZM07yssRrfcUcf4IstIb2BxSxlJbZ9CPvZjttVSLdfWKD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M2woPDPU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id E073920B7172;
	Thu, 30 Apr 2026 17:42:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E073920B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596136;
	bh=YnF+uI+QwqeYTK6oQpqBg7HAiFmqfGlkyQt6D84StzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2woPDPUVdS9NeB1SvEI95f9f67vYOHf0bdchGfAnnczATXJUsd3Yceu8VF7i/UpP
	 7DgPhd5zkRdX9oeAT1xw9YBVkGj0ljox6Cp1YhGs5U0U95RxUn4K6+GsojTxirfkzI
	 t4yb2645Dak1/3wEswZ2pTGHC12MMmW2OxGVmXWc=
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
Subject: [PATCH V2 05/11] mshv: Implement mshv bridge device for VFIO
Date: Thu, 30 Apr 2026 17:41:51 -0700
Message-ID: <20260501004157.3108202-6-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
References: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 411084A94A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10534-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


