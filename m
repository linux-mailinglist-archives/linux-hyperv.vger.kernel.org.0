Return-Path: <linux-hyperv+bounces-10535-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD+FEEv382kC9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10535-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:43:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE54A94F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3311C305D4C5
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6072D77E9;
	Fri,  1 May 2026 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GgEuZ+lV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660492C08BB;
	Fri,  1 May 2026 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596139; cv=none; b=jMQu/Ako1p9Jexnb2TnDxpM2gxaoMc8cDdoH1SqoKOJ7okpnWq6IbWr61PxqWBz+KTT0uVqBciqzjtdliP/PvKY38qYUakWrEmGyMh1dlwwAK67YoZZjyty9ybyPUaLlayYv5HXdrVrlu2KGmWNHhYEC2cLNLQ3UIn00QF7M+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596139; c=relaxed/simple;
	bh=C8TsFVJy+pAFOBhAef081HD3HUSmaQJnLst8p/bA8vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB1to2pgHwcmqkafINseDKV8c+6gzG1rD+1xgQB8MQ1thcuNWNNv4INqNC+RjjsZxJLcJWgqC7O36j3ffQz6kSIwuIDoc37kEqGXcDiz3Ou2azZh+hsQ4yCfRgjAU0SqcGmTpHBGOn9nQuvij3+H6Ki5e+Ng6Ulr5qMWbxZnzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GgEuZ+lV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 845E120B717A;
	Thu, 30 Apr 2026 17:42:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 845E120B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596138;
	bh=torw1rFNIs6S4jLC1p2Rij05fcbQgV06MR8D7ovym88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgEuZ+lV4+qhPCL+RnBEUNCxZUlH6K/GBrH4cMuvbt/TWi8/nT0UvnILg/Q7qQSaV
	 pODWfGhx0Q1YUOgdlY+x4RseC/IZSIz5Y68iLZFSo59QzYivKLiBlCcihKxf+fHNke
	 TGOm/u79XcxxEGqidmGPEr71nRiY3VsHG38nNCM4=
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
Subject: [PATCH V2 06/11] mshv: Add ioctl support for MSHV-VFIO bridge device
Date: Thu, 30 Apr 2026 17:41:52 -0700
Message-ID: <20260501004157.3108202-7-mrathor@linux.microsoft.com>
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
X-Rspamd-Queue-Id: ADDE54A94F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10535-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add ioctl support for creating MSHV devices for a partition. At
present only VFIO device types are supported, but more could be
added. At a high level, a partition ioctl to create device verifies
it is of type VFIO and does some setup for bridge code in mshv_vfio.c.
Adapted from KVM device ioctls.

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 116 ++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 02c107458be9..6ceb5f608589 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1625,6 +1625,119 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	return ret;
 }
 
+static long mshv_device_attr_ioctl(struct mshv_device *mshv_dev, int cmd,
+				   ulong uarg)
+{
+	struct mshv_device_attr attr;
+	const struct mshv_device_ops *devops = mshv_dev->device_ops;
+
+	if (copy_from_user(&attr, (void __user *)uarg, sizeof(attr)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case MSHV_SET_DEVICE_ATTR:
+		if (devops->device_set_attr)
+			return devops->device_set_attr(mshv_dev, &attr);
+		break;
+	case MSHV_HAS_DEVICE_ATTR:
+		if (devops->device_has_attr)
+			return devops->device_has_attr(mshv_dev, &attr);
+		break;
+	}
+
+	return -EPERM;
+}
+
+static long mshv_device_fop_ioctl(struct file *filp, unsigned int cmd,
+				  ulong uarg)
+{
+	struct mshv_device *mshv_dev = filp->private_data;
+
+	switch (cmd) {
+	case MSHV_SET_DEVICE_ATTR:
+	case MSHV_HAS_DEVICE_ATTR:
+		return mshv_device_attr_ioctl(mshv_dev, cmd, uarg);
+	}
+
+	return -ENOTTY;
+}
+
+static int mshv_device_fop_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_device *mshv_dev = filp->private_data;
+	struct mshv_partition *partition = mshv_dev->device_pt;
+
+	if (mshv_dev->device_ops->device_release) {
+		mutex_lock(&partition->pt_mutex);
+		hlist_del(&mshv_dev->device_ptnode);
+		mshv_dev->device_ops->device_release(mshv_dev);
+		mutex_unlock(&partition->pt_mutex);
+	}
+
+	mshv_partition_put(partition);
+	return 0;
+}
+
+static const struct file_operations mshv_device_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = mshv_device_fop_ioctl,
+	.release = mshv_device_fop_release,
+};
+
+static long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
+					       void __user *uarg)
+{
+	long rc;
+	struct mshv_create_device devargk;
+	struct mshv_device *mshv_dev;
+	const struct mshv_device_ops *vfio_ops;
+
+	if (copy_from_user(&devargk, uarg, sizeof(devargk)))
+		return -EFAULT;
+
+	/* At present, only VFIO is supported */
+	if (devargk.type != MSHV_DEV_TYPE_VFIO)
+		return -ENODEV;
+
+	if (devargk.flags & MSHV_CREATE_DEVICE_TEST)
+		return 0;
+
+	/* This is freed later by mshv_vfio_release_device() */
+	mshv_dev = kzalloc(sizeof(*mshv_dev), GFP_KERNEL_ACCOUNT);
+	if (mshv_dev == NULL)
+		return -ENOMEM;
+
+	vfio_ops = &mshv_vfio_device_ops;
+	mshv_dev->device_ops = vfio_ops;
+	mshv_dev->device_pt = partition;
+
+	rc = vfio_ops->device_create(mshv_dev);
+	if (rc < 0) {
+		kfree(mshv_dev);
+		return rc;
+	}
+
+	hlist_add_head(&mshv_dev->device_ptnode, &partition->pt_devices);
+
+	mshv_partition_get(partition);
+	rc = anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
+			      mshv_dev, O_RDWR | O_CLOEXEC);
+	if (rc < 0)
+		goto undo_out;
+
+	devargk.fd = rc;
+	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
+		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
+
+	return 0;
+
+undo_out:
+	hlist_del(&mshv_dev->device_ptnode);
+	vfio_ops->device_release(mshv_dev);    /* will kfree(mshv_dev) */
+	mshv_partition_put(partition);
+	return rc;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -1661,6 +1774,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_ROOT_HVCALL:
 		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
 		break;
+	case MSHV_CREATE_DEVICE:
+		ret = mshv_partition_ioctl_create_device(partition, uarg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.51.2.vfs.0.1


