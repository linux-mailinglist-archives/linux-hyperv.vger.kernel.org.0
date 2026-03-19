Return-Path: <linux-hyperv+bounces-9603-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FVxJ+BcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9603-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDAE2D2257
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1D0A308642E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0B3F786C;
	Thu, 19 Mar 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQCLFGJh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B63FCB1F
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951955; cv=none; b=q4eFPq9eY9di/USx7J5YL3P29otc/cbiTEiBUB5mfFfA88vCxiHNtUjmKpAFSubaNB+sYJfYMpXXyUf+Z8lKVPzyXqDu3HLsfdgWSfYZx/8QscJm0Rw7rpYC6Dbjucz96SG4fG6OqcKSTSS6HBCMwWn8Yk02Q4Ru4kahuyEagjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951955; c=relaxed/simple;
	bh=lbJJqathQ0RsrVpKR+Bj4fX/ytc5wlKUMv0nb6CZSto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HznOQQ0lmhQjE9UKvjwGiJ1zGct6gH2S+lYhi7mjFnnBHsaX3DKyP6HpBX19K2HPMYD8pV6GSWx7d+H3A7Dr1+SAwPRp/A5t66mtB+1lbToKnnhgs/xBBRPViE41JRRr8SYbiYPFPEsMtXNpjtHG6QVzARbxy8Q3C7dL/8pAVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQCLFGJh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so267375e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951949; x=1774556749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfPgBA+Pl94DE98AaTxzZlc8zjDbPiM5ZxN+Lw61xBc=;
        b=gQCLFGJhUnFinELTygYYEzWUR+/WXM5Kz28y76QDI0MCPbKQd8fJCuLDKum6b7KvQf
         bL93M/B2C519lWOr5ehriWuYbPGwRwUObN80JE0WM4s9VtPYIpW23VUNVESmIShBwJAd
         N93bpGYT8iehtNGN/dJkMi/5W0q0SQk4TqyPWKlBkJF5mwfMYLv+lHB/xMWm6LCySIg9
         3m7iwtw7NMdYzDZJpmfOFMRTleuJiOB3lpnk/p86x820hFTIk6DLY44gXJ4yP6QL4g08
         98jO26vtonKsQcyyskIuNtZznzTI+MNkznhWl8n9tpF6JmDnuqKAihqFxhQN6HPiqV+h
         bWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951949; x=1774556749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yfPgBA+Pl94DE98AaTxzZlc8zjDbPiM5ZxN+Lw61xBc=;
        b=HfMjNNm3uAt6hAD2zjhghr2RULTjeQG5yBfGH+00nSUYtV7uLsqGFRZ7SZoELu1CWO
         Fy2tBftRAy40A1u/k5UNas4b1GIkpFfbZQYDj0WR8oDhR3cLysn1Zc5t0Htl2z+gDhnY
         GgDs21UFU3zCwf1aRuShfii8Xcg5LcCk1BrT0grA+WmwD/gE2V/lt7vwSya5ppm4+cJS
         8ViXF9bq+jUMa55E0+kkqh7BpQwHFrPGvXQNBIJlHnQJQT0jrnd66O9GLvBKcVoQkNNZ
         23J1dC0zSMkuVo6AbpTJd2F27ADROXKlsc/wVhxMfRxEmXbGTrQT1pGq+y6czAmLd2zn
         CfsA==
X-Gm-Message-State: AOJu0YxSCrai/TuNbXjVP5DmUrna6PysBVtaa9FsqowLnqDsG7T6Pbvy
	y8FwrpULPf5ieGgJKThUVu48EumzN16vPxr7K/vwyTUx4wc8NX6ytHsGOgI11fTITlY=
X-Gm-Gg: ATEYQzzFXuG8W3vPXuqFZQnvFbZx7qiB+p7VLKcws/eg/Skep9+ACIU9gjP1WY/qwJH
	qx46j4t5hb569Qcfim+YBNcSuDxYP71zO8WyJn0I51ZnANB2PwFiFDP/5rUjfaZsP/kZgwTzmkd
	2g5/Jw8LY8MPOJ5tC0fACcJLtcfwLNvqgJ98xtnF04TN9SiWDeoFsOyFza2nZ/jMO1dCqVvDncy
	IC0vg5btTDm+GDxcAfxBZJfRDfKprby67z3akHFrw3sBJPbA4BJe5w/61c5IzIg+AWqWftwtz1Z
	G6bYXku9dPJtdBKcRyLAgsIcfjRSpUgpBYxubBPQUWRXKOOMaQzU5FZM6IF4FEqOpkZ8i1VuobC
	3tNzdCVtjuu+CQZHvelp/0D2LV7f51p01heWk66GQaD/bo0XJbbV5XJVA5FDG9VEGJrAJmbQwah
	796Q7De0/lNpUXXX/27mDOFN7c/U4zBBgBDGUXOkMPbraZWovJ
X-Received: by 2002:a05:6000:420c:b0:43b:460a:b13 with SMTP id ffacd0b85a97d-43b64281506mr1176416f8f.44.1773951948875;
        Thu, 19 Mar 2026 13:25:48 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:48 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 31/55] drivers: hv: dxgkrnl: Creation of dxgsyncfile objects
Date: Thu, 19 Mar 2026 20:24:45 +0000
Message-ID: <20260319202509.63802-32-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9603-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FDAE2D2257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the ioctl to create a dxgsyncfile object
(LX_DXCREATESYNCFILE). This object is a wrapper around a monitored
fence sync object and a fence value.

dxgsyncfile is built on top of the Linux sync_file object and
provides a way for the user mode to synchronize with the execution
of the device DMA packets.

The ioctl creates a dxgsyncfile object for the given GPU synchronization
object and a fence value. A file descriptor of the sync_file object
is returned to the caller. The caller could wait for the object by using
poll(). When the underlying GPU synchronization object is signaled on
the host, the host sends a message to the virtual machine and the
sync_file object is signaled.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/Kconfig       |   2 +
 drivers/hv/dxgkrnl/Makefile      |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h     |   2 +
 drivers/hv/dxgkrnl/dxgmodule.c   |  12 ++
 drivers/hv/dxgkrnl/dxgsyncfile.c | 215 +++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgsyncfile.h |  30 +++++
 drivers/hv/dxgkrnl/dxgvmbus.c    |  33 +++--
 drivers/hv/dxgkrnl/ioctl.c       |   5 +-
 include/uapi/misc/d3dkmthk.h     |   9 ++
 9 files changed, 294 insertions(+), 16 deletions(-)
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.c
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.h

diff --git a/drivers/hv/dxgkrnl/Kconfig b/drivers/hv/dxgkrnl/Kconfig
index bcd92bbff939..782692610887 100644
--- a/drivers/hv/dxgkrnl/Kconfig
+++ b/drivers/hv/dxgkrnl/Kconfig
@@ -6,6 +6,8 @@ config DXGKRNL
 	tristate "Microsoft Paravirtualized GPU support"
 	depends on HYPERV
 	depends on 64BIT || COMPILE_TEST
+	select DMA_SHARED_BUFFER
+	select SYNC_FILE
 	help
 	  This driver supports paravirtualized virtual compute devices, exposed
 	  by Microsoft Hyper-V when Linux is running inside of a virtual machine
diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index fc85a47a6ad5..89824cda670a 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y := dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
+dxgkrnl-y := dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o  dxgsyncfile.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 091dbe999d33..3a69e3b34e1c 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -120,6 +120,7 @@ struct dxgpagingqueue {
  */
 enum dxghosteventtype {
 	dxghostevent_cpu_event = 1,
+	dxghostevent_dma_fence = 2,
 };
 
 struct dxghostevent {
@@ -858,6 +859,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event);
 int dxgvmb_send_lock2(struct dxgprocess *process,
 		      struct dxgadapter *adapter,
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index f1245a9d8826..af51fcd35697 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -16,6 +16,7 @@
 #include <linux/hyperv.h>
 #include <linux/pci.h>
 #include "dxgkrnl.h"
+#include "dxgsyncfile.h"
 
 #define PCI_VENDOR_ID_MICROSOFT		0x1414
 #define PCI_DEVICE_ID_VIRTUAL_RENDER	0x008E
@@ -145,6 +146,15 @@ void dxgglobal_remove_host_event(struct dxghostevent *event)
 	spin_unlock_irq(&dxgglobal->host_event_list_mutex);
 }
 
+static void signal_dma_fence(struct dxghostevent *eventhdr)
+{
+	struct dxgsyncpoint *event = (struct dxgsyncpoint *)eventhdr;
+
+	event->fence_value++;
+	list_del(&eventhdr->host_event_list_entry);
+	dma_fence_signal(&event->base);
+}
+
 void signal_host_cpu_event(struct dxghostevent *eventhdr)
 {
 	struct dxghosteventcpu *event = (struct dxghosteventcpu *)eventhdr;
@@ -184,6 +194,8 @@ void dxgglobal_signal_host_event(u64 event_id)
 			DXG_TRACE("found event to signal");
 			if (event->event_type == dxghostevent_cpu_event)
 				signal_host_cpu_event(event);
+			else if (event->event_type == dxghostevent_dma_fence)
+				signal_dma_fence(event);
 			else
 				DXG_ERR("Unknown host event type");
 			break;
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.c b/drivers/hv/dxgkrnl/dxgsyncfile.c
new file mode 100644
index 000000000000..88fd78f08fbe
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
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
+#include "dxgsyncfile.h"
+
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
+
+#ifdef DEBUG
+static char *errorstr(int ret)
+{
+	return ret < 0 ? "err" : "";
+}
+#endif
+
+static const struct dma_fence_ops dxgdmafence_ops;
+
+static struct dxgsyncpoint *to_syncpoint(struct dma_fence *fence)
+{
+	if (fence->ops != &dxgdmafence_ops)
+		return NULL;
+	return container_of(fence, struct dxgsyncpoint, base);
+}
+
+int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createsyncfile args;
+	struct dxgsyncpoint *pt = NULL;
+	int ret = 0;
+	int fd = get_unused_fd_flags(O_CLOEXEC);
+	struct sync_file *sync_file = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_waitforsynchronizationobjectfromcpu waitargs = {};
+
+	if (fd < 0) {
+		DXG_ERR("get_unused_fd_flags failed: %d", fd);
+		ret = fd;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		DXG_ERR("dxgprocess_device_by_handle failed");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		DXG_ERR("dxgdevice_acquire_lock_shared failed");
+		device = NULL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		DXG_ERR("dxgadapter_acquire_lock_shared failed");
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	pt = kzalloc(sizeof(*pt), GFP_KERNEL);
+	if (!pt) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	spin_lock_init(&pt->lock);
+	pt->fence_value = args.fence_value;
+	pt->context = dma_fence_context_alloc(1);
+	pt->hdr.event_id = dxgglobal_new_host_event_id();
+	pt->hdr.event_type = dxghostevent_dma_fence;
+	dxgglobal_add_host_event(&pt->hdr);
+
+	dma_fence_init(&pt->base, &dxgdmafence_ops, &pt->lock,
+		       pt->context, args.fence_value);
+
+	sync_file = sync_file_create(&pt->base);
+	if (sync_file == NULL) {
+		DXG_ERR("sync_file_create failed");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	dma_fence_put(&pt->base);
+
+	waitargs.device = args.device;
+	waitargs.object_count = 1;
+	waitargs.objects = &args.monitored_fence;
+	waitargs.fence_values = &args.fence_value;
+	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
+					       &waitargs, false,
+					       pt->hdr.event_id);
+	if (ret < 0) {
+		DXG_ERR("dxgvmb_send_wait_sync_object_cpu failed");
+		goto cleanup;
+	}
+
+	args.sync_file_handle = (u64)fd;
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy output args");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	fd_install(fd, sync_file->file);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (ret) {
+		if (sync_file) {
+			fput(sync_file->file);
+			/* sync_file_release will destroy dma_fence */
+			pt = NULL;
+		}
+		if (pt)
+			dma_fence_put(&pt->base);
+		if (fd >= 0)
+			put_unused_fd(fd);
+	}
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static const char *dxgdmafence_get_driver_name(struct dma_fence *fence)
+{
+	return "dxgkrnl";
+}
+
+static const char *dxgdmafence_get_timeline_name(struct dma_fence *fence)
+{
+	return "no_timeline";
+}
+
+static void dxgdmafence_release(struct dma_fence *fence)
+{
+	struct dxgsyncpoint *syncpoint;
+
+	syncpoint = to_syncpoint(fence);
+	if (syncpoint) {
+		if (syncpoint->hdr.event_id)
+			dxgglobal_get_host_event(syncpoint->hdr.event_id);
+		kfree(syncpoint);
+	}
+}
+
+static bool dxgdmafence_signaled(struct dma_fence *fence)
+{
+	struct dxgsyncpoint *syncpoint;
+
+	syncpoint = to_syncpoint(fence);
+	if (syncpoint == 0)
+		return true;
+	return __dma_fence_is_later(syncpoint->fence_value, fence->seqno,
+				    fence->ops);
+}
+
+static bool dxgdmafence_enable_signaling(struct dma_fence *fence)
+{
+	return true;
+}
+
+static void dxgdmafence_value_str(struct dma_fence *fence,
+				  char *str, int size)
+{
+	snprintf(str, size, "%lld", fence->seqno);
+}
+
+static void dxgdmafence_timeline_value_str(struct dma_fence *fence,
+					   char *str, int size)
+{
+	struct dxgsyncpoint *syncpoint;
+
+	syncpoint = to_syncpoint(fence);
+	snprintf(str, size, "%lld", syncpoint->fence_value);
+}
+
+static const struct dma_fence_ops dxgdmafence_ops = {
+	.get_driver_name = dxgdmafence_get_driver_name,
+	.get_timeline_name = dxgdmafence_get_timeline_name,
+	.enable_signaling = dxgdmafence_enable_signaling,
+	.signaled = dxgdmafence_signaled,
+	.release = dxgdmafence_release,
+	.fence_value_str = dxgdmafence_value_str,
+	.timeline_value_str = dxgdmafence_timeline_value_str,
+};
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.h b/drivers/hv/dxgkrnl/dxgsyncfile.h
new file mode 100644
index 000000000000..207ef9b30f67
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Headers for sync file objects
+ *
+ */
+
+#ifndef _DXGSYNCFILE_H
+#define _DXGSYNCFILE_H
+
+#include <linux/sync_file.h>
+
+int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs);
+
+struct dxgsyncpoint {
+	struct dxghostevent	hdr;
+	struct dma_fence	base;
+	u64			fence_value;
+	u64			context;
+	spinlock_t		lock;
+	u64			u64;
+};
+
+#endif	 /* _DXGSYNCFILE_H */
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 4d7807909284..913ea3cabb31 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2820,6 +2820,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event)
 {
 	int ret = -EINVAL;
@@ -2844,19 +2845,25 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 	command->guest_event_pointer = (u64) cpu_event;
 	current_pos = (u8 *) &command[1];
 
-	ret = copy_from_user(current_pos, args->objects, object_size);
-	if (ret) {
-		DXG_ERR("failed to copy objects");
-		ret = -EINVAL;
-		goto cleanup;
-	}
-	current_pos += object_size;
-	ret = copy_from_user(current_pos, args->fence_values,
-				fence_size);
-	if (ret) {
-		DXG_ERR("failed to copy fences");
-		ret = -EINVAL;
-		goto cleanup;
+	if (user_address) {
+		ret = copy_from_user(current_pos, args->objects, object_size);
+		if (ret) {
+			DXG_ERR("failed to copy objects");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		current_pos += object_size;
+		ret = copy_from_user(current_pos, args->fence_values,
+					fence_size);
+		if (ret) {
+			DXG_ERR("failed to copy fences");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		memcpy(current_pos, args->objects, object_size);
+		current_pos += object_size;
+		memcpy(current_pos, args->fence_values, fence_size);
 	}
 
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 8732a66040a0..6c26aafb0619 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -19,6 +19,7 @@
 
 #include "dxgkrnl.h"
 #include "dxgvmbus.h"
+#include "dxgsyncfile.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"dxgk: " fmt
@@ -3488,7 +3489,7 @@ dxgkio_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
-					       &args, event_id);
+					       &args, true, event_id);
 	if (ret < 0)
 		goto cleanup;
 
@@ -5224,7 +5225,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x42 */	{dxgkio_open_resource_nt, LX_DXOPENRESOURCEFROMNTHANDLE},
 /* 0x43 */	{dxgkio_query_statistics, LX_DXQUERYSTATISTICS},
 /* 0x44 */	{dxgkio_share_object_with_host, LX_DXSHAREOBJECTWITHHOST},
-/* 0x45 */	{},
+/* 0x45 */	{dxgkio_create_sync_file, LX_DXCREATESYNCFILE},
 };
 
 /*
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 1f60f5120e1d..c7f168425dc7 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1554,6 +1554,13 @@ struct d3dkmt_shareobjectwithhost {
 	__u64			object_vail_nt_handle;
 };
 
+struct d3dkmt_createsyncfile {
+	struct d3dkmthandle	device;
+	struct d3dkmthandle	monitored_fence;
+	__u64			fence_value;
+	__u64			sync_file_handle;	/* out */
+};
+
 /*
  * Dxgkrnl Graphics Port Driver ioctl definitions
  *
@@ -1677,5 +1684,7 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x43, struct d3dkmt_querystatistics)
 #define LX_DXSHAREOBJECTWITHHOST	\
 	_IOWR(0x47, 0x44, struct d3dkmt_shareobjectwithhost)
+#define LX_DXCREATESYNCFILE	\
+	_IOWR(0x47, 0x45, struct d3dkmt_createsyncfile)
 
 #endif /* _D3DKMTHK_H */

