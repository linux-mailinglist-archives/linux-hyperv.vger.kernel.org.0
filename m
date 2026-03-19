Return-Path: <linux-hyperv+bounces-9575-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBXPMd5bvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9575-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C292D2115
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B78C316F212
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26E3F7E81;
	Thu, 19 Mar 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beauo174"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABE3F7E63
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951921; cv=none; b=tXpmITdQRDncKMuzMOCGlZHwPGCBmwlbT52K43WoNibIuGV7bGMDbZfl7S418BGme/EvgprbVs3GjT8UwGiTFsoe9WEK82sWdAUgEOMQEj1K58m/MftxYWGxqEifMIZZeawZas85ybWJh4Jd2XPSc2BzcdbTHmXnDn6VxxQXsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951921; c=relaxed/simple;
	bh=EurVXR0Bo0PoBM3EFaeoyRoEn6hj+hD9ZjqDURb9/9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umjTYNJgiV3uG6Lx0HTpTiuJWxkz14ty9Vu95ThbUOzPy/v4Tn+nH7gbx3I88XSMbCfRqlPK8+hsKndsjSXbmFuCow+5wXhfUANVQZpBU2iCQHCRmLr6E1TYJQP6LYGMCXdEvXvpqHybIMkwL+x3ZkdAWqaYtUdfQ8SCYlbr9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beauo174; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso1042454f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951916; x=1774556716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6veZ7Z/5z6EiBHg/NZ/zT+51+PY4RbSzn3T7r4lA98=;
        b=beauo174E5qLcZ93To7utG3Z02Nx3IuYq7UZuBig8uNtt8x5ZfhTIn+1artWvwbpYn
         V0xOWRZ2An1e0vx9YTiPUu9p6+11ZNX4ZUwm+pvzOy36S36gYMmAcKf6EIDXa8mxSw7k
         1eGDnJqEKzaZgzAJ3LVe91ZxH6JRfifW2RY0gb3GcIpSM5MK8Vwe154pIlNY7ULiBUG2
         tlPBHhFu8K8BGfufsWQh2ZJBlMdWxfZrmoQWGcRnrr3AxlNUpbBckFL0DV/rlIuhauKj
         0+eQOT+uZEcn0gMIUeohAFWu+UOfUx2dj5+9Kr9M9SVtismCwY/R2BXoHJFRrmq6M6gj
         mZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951916; x=1774556716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6veZ7Z/5z6EiBHg/NZ/zT+51+PY4RbSzn3T7r4lA98=;
        b=XYZ+j6GkVQnm9cKgL4UJXP4Z3fhC04wrMgLbm0jsRx6/XWBzs7c0DsErwdf/gxzDuQ
         auI8zWPEyAzYaJkbu2DsLzJ08pwUbD3NDYmYm1zJ2GytHDG9Db6ugs9Bfui3qfQwcPYL
         4pnW+iyq6RBIcovAaXc78/6g/kvHXjje9URiQikRK2aixrdiqOgT6IMjLRS7DDZqozQG
         7GNt80thWFtoa7xflJ1AuLctkUvF53ZhvQzR2H5ne9oI+kHsJ9JifXgd6m63R/YZk1YQ
         EbCIpWYf+pqUQF43OmvlbHO+RwQPq+Rr71UPjiFS0en+k8hkpgESJ/qWgNTun0FSSQvv
         EpSQ==
X-Gm-Message-State: AOJu0YyVBTD/XDnppLwZc53zCZFQ37A6bvOFQjlkO6VIxYAMKOSINn7v
	UGtF8WUC6irYaZaw4wFpy9wi/ONX42YILuYg1npdQkFxErotq3tNyAOX2IWfhFLmlHs=
X-Gm-Gg: ATEYQzyf0d5Ad/w5iOHydYrOYeaMNDtMy7hkl5njPUoEVKIZzmyYijGi9zFqMpp4ovz
	4szTLPQGEyB+xTh9QKP7W0cMaX4GP0x2FMcH2WN1nxsLycc1UC4F08zcd+MDbmgY1Tu1B1yr9Kj
	+ek8SaInMn7gYF6abFTa6Y0FgPllzt29gEXcxs6eKo1bmhgPAa8ND4eAS1AtVz6XAHqUn0eboV3
	7vaARCoyGFT+dGwW/WXsi8QReX3Hc7FghDeSgiPflrLHfhFBf+AdgLcLR7hSyvJGQGcCAwjXGWZ
	mirtzRKz2o1J/unqRKEQQsWWmPLQ/QH08JBD82iB6Vuqi5cwp40neluEQy/XZ1pK8ttRPjwR3CH
	XCQtiuNzYgiWeOiY+/QbH8D8e3/FxONUACxUpKemwCEg/G7Qv0+q3h7gyz3FmKMmEWQGGLvEqGq
	rICxIpBOsqJRwFfqQsq59nomtOe3fCtZTADRXaYVVY21I9p2YT
X-Received: by 2002:a05:6000:26c4:b0:43b:4ef0:e13 with SMTP id ffacd0b85a97d-43b6424e18emr1335928f8f.12.1773951916070;
        Thu, 19 Mar 2026 13:25:16 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:15 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 03/55] drivers: hv: dxgkrnl: Creation of dxgadapter object
Date: Thu, 19 Mar 2026 20:24:17 +0000
Message-ID: <20260319202509.63802-4-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9575-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.968];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26C292D2115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Handle creation and destruction of dxgadapter object, which
represents a virtual compute device, projected to the VM by
the host. The dxgadapter object is created when the
corresponding VMBus channel is offered by Hyper-V.

There could be multiple virtual compute device objects, projected
by the host to VM. They are enumerated by issuing IOCTLs to
the /dev/dxg device.

The adapter object can start functioning only when the global VMBus
channel and the corresponding per device VMBus channel are
initialized. Notifications about arrival of a virtual compute PCI
device and VMBus channels can happen in any order. Therefore,
the initial dxgadapter object state is DXGADAPTER_STATE_WAITING_VMBUS.
A list of VMBus channels and a list of waiting dxgadapter objects
are maintained. When dxgkrnl is notified about a VMBus channel
arrival, if tries to start all adapters, which are not started yet.

Properties of the adapter object are determined by sending VMBus
messages to the host to the corresponding VMBus channel.

When the per virtual compute device VMBus channel or the global
channel are destroyed, the adapter object is destroyed.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile     |   2 +-
 drivers/hv/dxgkrnl/dxgadapter.c | 170 +++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  85 +++++++++++++
 drivers/hv/dxgkrnl/dxgmodule.c  | 204 +++++++++++++++++++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 217 +++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h   | 128 +++++++++++++++++++
 drivers/hv/dxgkrnl/misc.c       |  37 ++++++
 drivers/hv/dxgkrnl/misc.h       |  24 +++-
 8 files changed, 844 insertions(+), 23 deletions(-)
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 create mode 100644 drivers/hv/dxgkrnl/misc.c

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 76349064b60a..2ed07d877c91 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o dxgvmbus.o
+dxgkrnl-y		:= dxgmodule.o misc.o dxgadapter.o ioctl.o dxgvmbus.o
diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
new file mode 100644
index 000000000000..07d47699d255
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Implementation of dxgadapter and its objects
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/hyperv.h>
+#include <linux/pagemap.h>
+#include <linux/eventfd.h>
+
+#include "dxgkrnl.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev)
+{
+	int ret;
+
+	guid_to_luid(&hdev->channel->offermsg.offer.if_instance,
+		     &adapter->luid);
+	DXG_TRACE("%x:%x %p %pUb",
+		adapter->luid.b, adapter->luid.a, hdev->channel,
+		&hdev->channel->offermsg.offer.if_instance);
+
+	ret = dxgvmbuschannel_init(&adapter->channel, hdev);
+	if (ret)
+		goto cleanup;
+
+	adapter->channel.adapter = adapter;
+	adapter->hv_dev = hdev;
+
+	ret = dxgvmb_send_open_adapter(adapter);
+	if (ret < 0) {
+		DXG_ERR("dxgvmb_send_open_adapter failed: %d", ret);
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_get_internal_adapter_info(adapter);
+
+cleanup:
+	if (ret)
+		DXG_ERR("Failed to set vmbus: %d", ret);
+	return ret;
+}
+
+void dxgadapter_start(struct dxgadapter *adapter)
+{
+	struct dxgvgpuchannel *ch = NULL;
+	struct dxgvgpuchannel *entry;
+	int ret;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	DXG_TRACE("%x-%x", adapter->luid.a, adapter->luid.b);
+
+	/* Find the corresponding vGPU vm bus channel */
+	list_for_each_entry(entry, &dxgglobal->vgpu_ch_list_head,
+			    vgpu_ch_list_entry) {
+		if (memcmp(&adapter->luid,
+			   &entry->adapter_luid,
+			   sizeof(struct winluid)) == 0) {
+			ch = entry;
+			break;
+		}
+	}
+	if (ch == NULL) {
+		DXG_TRACE("vGPU chanel is not ready");
+		return;
+	}
+
+	/* The global channel is initialized when the first adapter starts */
+	if (!dxgglobal->global_channel_initialized) {
+		ret = dxgglobal_init_global_channel();
+		if (ret) {
+			dxgglobal_destroy_global_channel();
+			return;
+		}
+		dxgglobal->global_channel_initialized = true;
+	}
+
+	/* Initialize vGPU vm bus channel */
+	ret = dxgadapter_set_vmbus(adapter, ch->hdev);
+	if (ret) {
+		DXG_ERR("Failed to start adapter %p", adapter);
+		adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+		return;
+	}
+
+	adapter->adapter_state = DXGADAPTER_STATE_ACTIVE;
+	DXG_TRACE("Adapter started %p", adapter);
+}
+
+void dxgadapter_stop(struct dxgadapter *adapter)
+{
+	bool adapter_stopped = false;
+
+	down_write(&adapter->core_lock);
+	if (!adapter->stopping_adapter)
+		adapter->stopping_adapter = true;
+	else
+		adapter_stopped = true;
+	up_write(&adapter->core_lock);
+
+	if (adapter_stopped)
+		return;
+
+	if (dxgadapter_acquire_lock_exclusive(adapter) == 0) {
+		dxgvmb_send_close_adapter(adapter);
+		dxgadapter_release_lock_exclusive(adapter);
+	}
+	dxgvmbuschannel_destroy(&adapter->channel);
+
+	adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+}
+
+void dxgadapter_release(struct kref *refcount)
+{
+	struct dxgadapter *adapter;
+
+	adapter = container_of(refcount, struct dxgadapter, adapter_kref);
+	DXG_TRACE("%p", adapter);
+	kfree(adapter);
+}
+
+bool dxgadapter_is_active(struct dxgadapter *adapter)
+{
+	return adapter->adapter_state == DXGADAPTER_STATE_ACTIVE;
+}
+
+int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
+{
+	down_write(&adapter->core_lock);
+	if (adapter->adapter_state != DXGADAPTER_STATE_ACTIVE) {
+		dxgadapter_release_lock_exclusive(adapter);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter)
+{
+	down_write(&adapter->core_lock);
+}
+
+void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter)
+{
+	up_write(&adapter->core_lock);
+}
+
+int dxgadapter_acquire_lock_shared(struct dxgadapter *adapter)
+{
+	down_read(&adapter->core_lock);
+	if (adapter->adapter_state == DXGADAPTER_STATE_ACTIVE)
+		return 0;
+	dxgadapter_release_lock_shared(adapter);
+	return -ENODEV;
+}
+
+void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
+{
+	up_read(&adapter->core_lock);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 52b9e82c51e6..ba2a7c6001aa 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -47,9 +47,39 @@ extern struct dxgdriver dxgdrv;
 
 #define DXGDEV dxgdrv.dxgdev
 
+struct dxgk_device_types {
+	u32 post_device:1;
+	u32 post_device_certain:1;
+	u32 software_device:1;
+	u32 soft_gpu_device:1;
+	u32 warp_device:1;
+	u32 bdd_device:1;
+	u32 support_miracast:1;
+	u32 mismatched_lda:1;
+	u32 indirect_display_device:1;
+	u32 xbox_one_device:1;
+	u32 child_id_support_dwm_clone:1;
+	u32 child_id_support_dwm_clone2:1;
+	u32 has_internal_panel:1;
+	u32 rfx_vgpu_device:1;
+	u32 virtual_render_device:1;
+	u32 support_preserve_boot_display:1;
+	u32 is_uefi_frame_buffer:1;
+	u32 removable_device:1;
+	u32 virtual_monitor_device:1;
+};
+
+enum dxgobjectstate {
+	DXGOBJECTSTATE_CREATED,
+	DXGOBJECTSTATE_ACTIVE,
+	DXGOBJECTSTATE_STOPPED,
+	DXGOBJECTSTATE_DESTROYED,
+};
+
 struct dxgvmbuschannel {
 	struct vmbus_channel	*channel;
 	struct hv_device	*hdev;
+	struct dxgadapter	*adapter;
 	spinlock_t		packet_list_mutex;
 	struct list_head	packet_list_head;
 	struct kmem_cache	*packet_cache;
@@ -81,6 +111,10 @@ struct dxgglobal {
 	struct miscdevice	dxgdevice;
 	struct mutex		device_mutex;
 
+	/* list of created adapters */
+	struct list_head	adapter_list_head;
+	struct rw_semaphore	adapter_list_lock;
+
 	/*
 	 * List of the vGPU VM bus channels (dxgvgpuchannel)
 	 * Protected by device_mutex
@@ -102,6 +136,10 @@ static inline struct dxgglobal *dxggbl(void)
 	return dxgdrv.dxgglobal;
 }
 
+int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
+			     struct winluid host_vgpu_luid);
+void dxgglobal_acquire_adapter_list_lock(enum dxglockstate state);
+void dxgglobal_release_adapter_list_lock(enum dxglockstate state);
 int dxgglobal_init_global_channel(void);
 void dxgglobal_destroy_global_channel(void);
 struct vmbus_channel *dxgglobal_get_vmbus(void);
@@ -113,6 +151,47 @@ struct dxgprocess {
 	/* Placeholder */
 };
 
+enum dxgadapter_state {
+	DXGADAPTER_STATE_ACTIVE		= 0,
+	DXGADAPTER_STATE_STOPPED	= 1,
+	DXGADAPTER_STATE_WAITING_VMBUS	= 2,
+};
+
+/*
+ * This object represents the grapchis adapter.
+ * Objects, which take reference on the adapter:
+ * - dxgglobal
+ * - adapter handle (struct d3dkmthandle)
+ */
+struct dxgadapter {
+	struct rw_semaphore	core_lock;
+	struct kref		adapter_kref;
+	/* Entry in the list of adapters in dxgglobal */
+	struct list_head	adapter_list_entry;
+	struct pci_dev		*pci_dev;
+	struct hv_device	*hv_dev;
+	struct dxgvmbuschannel	channel;
+	struct d3dkmthandle	host_handle;
+	enum dxgadapter_state	adapter_state;
+	struct winluid		host_adapter_luid;
+	struct winluid		host_vgpu_luid;
+	struct winluid		luid;	/* VM bus channel luid */
+	u16			device_description[80];
+	u16			device_instance_id[WIN_MAX_PATH];
+	bool			stopping_adapter;
+};
+
+int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev);
+bool dxgadapter_is_active(struct dxgadapter *adapter);
+void dxgadapter_start(struct dxgadapter *adapter);
+void dxgadapter_stop(struct dxgadapter *adapter);
+void dxgadapter_release(struct kref *refcount);
+int dxgadapter_acquire_lock_shared(struct dxgadapter *adapter);
+void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
+int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
+void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+
 /*
  * The convention is that VNBus instance id is a GUID, but the host sets
  * the lower part of the value to the host adapter LUID. The function
@@ -141,6 +220,12 @@ static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 
 void dxgvmb_initialize(void);
 int dxgvmb_send_set_iospace_region(u64 start, u64 len);
+int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
+int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
+int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
+int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
+			  void *command,
+			  u32 cmd_size);
 
 int ntstatus2int(struct ntstatus status);
 
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index e55639dc0adc..ef80b920f010 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -55,6 +55,156 @@ void dxgglobal_release_channel_lock(void)
 	up_read(&dxggbl()->channel_lock);
 }
 
+void dxgglobal_acquire_adapter_list_lock(enum dxglockstate state)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	if (state == DXGLOCK_EXCL)
+		down_write(&dxgglobal->adapter_list_lock);
+	else
+		down_read(&dxgglobal->adapter_list_lock);
+}
+
+void dxgglobal_release_adapter_list_lock(enum dxglockstate state)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	if (state == DXGLOCK_EXCL)
+		up_write(&dxgglobal->adapter_list_lock);
+	else
+		up_read(&dxgglobal->adapter_list_lock);
+}
+
+/*
+ * Returns a pointer to dxgadapter object, which corresponds to the given PCI
+ * device, or NULL.
+ */
+static struct dxgadapter *find_pci_adapter(struct pci_dev *dev)
+{
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dev == entry->pci_dev) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+	return adapter;
+}
+
+/*
+ * Returns a pointer to dxgadapter object, which has the givel LUID
+ * device, or NULL.
+ */
+static struct dxgadapter *find_adapter(struct winluid *luid)
+{
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (memcmp(luid, &entry->luid, sizeof(struct winluid)) == 0) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+	return adapter;
+}
+
+/*
+ * Creates a new dxgadapter object, which represents a virtual GPU, projected
+ * by the host.
+ * The adapter is in the waiting state. It will become active when the global
+ * VM bus channel and the adapter VM bus channel are created.
+ */
+int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
+			     struct winluid host_vgpu_luid)
+{
+	struct dxgadapter *adapter;
+	int ret = 0;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	adapter = kzalloc(sizeof(struct dxgadapter), GFP_KERNEL);
+	if (adapter == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapter->adapter_state = DXGADAPTER_STATE_WAITING_VMBUS;
+	adapter->host_vgpu_luid = host_vgpu_luid;
+	kref_init(&adapter->adapter_kref);
+	init_rwsem(&adapter->core_lock);
+
+	adapter->pci_dev = dev;
+	guid_to_luid(guid, &adapter->luid);
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_add_tail(&adapter->adapter_list_entry,
+		      &dxgglobal->adapter_list_head);
+	dxgglobal->num_adapters++;
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+
+	DXG_TRACE("new adapter added %p %x-%x", adapter,
+		adapter->luid.a, adapter->luid.b);
+cleanup:
+	return ret;
+}
+
+/*
+ * Attempts to start dxgadapter objects, which are not active yet.
+ */
+static void dxgglobal_start_adapters(void)
+{
+	struct dxgadapter *adapter;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	if (dxgglobal->hdev == NULL) {
+		DXG_TRACE("Global channel is not ready");
+		return;
+	}
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+	list_for_each_entry(adapter, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (adapter->adapter_state == DXGADAPTER_STATE_WAITING_VMBUS)
+			dxgadapter_start(adapter);
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+}
+
+/*
+ * Stopsthe active dxgadapter objects.
+ */
+static void dxgglobal_stop_adapters(void)
+{
+	struct dxgadapter *adapter;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	if (dxgglobal->hdev == NULL) {
+		DXG_TRACE("Global channel is not ready");
+		return;
+	}
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+	list_for_each_entry(adapter, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (adapter->adapter_state == DXGADAPTER_STATE_ACTIVE)
+			dxgadapter_stop(adapter);
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+}
+
 const struct file_operations dxgk_fops = {
 	.owner = THIS_MODULE,
 };
@@ -182,6 +332,15 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 	DXG_TRACE("Vmbus interface version: %d", dxgglobal->vmbus_ver);
 	DXG_TRACE("Host luid: %x-%x", vgpu_luid.b, vgpu_luid.a);
 
+	/* Create new virtual GPU adapter */
+	ret = dxgglobal_create_adapter(dev, &guid, vgpu_luid);
+	if (ret)
+		goto cleanup;
+
+	/* Attempt to start the adapter in case VM bus channels are created */
+
+	dxgglobal_start_adapters();
+
 cleanup:
 
 	mutex_unlock(&dxgglobal->device_mutex);
@@ -193,7 +352,25 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 
 static void dxg_pci_remove_device(struct pci_dev *dev)
 {
-	/* Placeholder */
+	struct dxgadapter *adapter;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	adapter = find_pci_adapter(dev);
+	if (adapter) {
+		dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+		list_del(&adapter->adapter_list_entry);
+		dxgglobal->num_adapters--;
+		dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+
+		dxgadapter_stop(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	} else {
+		DXG_ERR("Failed to find dxgadapter for pcidev");
+	}
+
+	mutex_unlock(&dxgglobal->device_mutex);
 }
 
 static struct pci_device_id dxg_pci_id_table[] = {
@@ -297,6 +474,25 @@ void dxgglobal_destroy_global_channel(void)
 	up_write(&dxgglobal->channel_lock);
 }
 
+static void dxgglobal_stop_adapter_vmbus(struct hv_device *hdev)
+{
+	struct dxgadapter *adapter = NULL;
+	struct winluid luid;
+
+	guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
+
+	DXG_TRACE("Stopping adapter %x:%x", luid.b, luid.a);
+
+	adapter = find_adapter(&luid);
+
+	if (adapter && adapter->adapter_state == DXGADAPTER_STATE_ACTIVE) {
+		down_write(&adapter->core_lock);
+		dxgvmbuschannel_destroy(&adapter->channel);
+		adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+		up_write(&adapter->core_lock);
+	}
+}
+
 static const struct hv_vmbus_device_id dxg_vmbus_id_table[] = {
 	/* Per GPU Device GUID */
 	{ HV_GPUP_DXGK_VGPU_GUID },
@@ -329,6 +525,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 		vgpuch->hdev = hdev;
 		list_add_tail(&vgpuch->vgpu_ch_list_entry,
 			      &dxgglobal->vgpu_ch_list_head);
+		dxgglobal_start_adapters();
 	} else if (uuid_le_cmp(hdev->dev_type,
 		   dxg_vmbus_id_table[1].guid) == 0) {
 		/* This is the global Dxgkgnl channel */
@@ -341,6 +538,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 			goto error;
 		}
 		dxgglobal->hdev = hdev;
+		dxgglobal_start_adapters();
 	} else {
 		/* Unknown device type */
 		DXG_ERR("Unknown VM bus device type");
@@ -364,6 +562,7 @@ static int dxg_remove_vmbus(struct hv_device *hdev)
 
 	if (uuid_le_cmp(hdev->dev_type, dxg_vmbus_id_table[0].guid) == 0) {
 		DXG_TRACE("Remove virtual GPU channel");
+		dxgglobal_stop_adapter_vmbus(hdev);
 		list_for_each_entry(vgpu_channel,
 				    &dxgglobal->vgpu_ch_list_head,
 				    vgpu_ch_list_entry) {
@@ -420,6 +619,8 @@ static struct dxgglobal *dxgglobal_create(void)
 	mutex_init(&dxgglobal->device_mutex);
 
 	INIT_LIST_HEAD(&dxgglobal->vgpu_ch_list_head);
+	INIT_LIST_HEAD(&dxgglobal->adapter_list_head);
+	init_rwsem(&dxgglobal->adapter_list_lock);
 
 	init_rwsem(&dxgglobal->channel_lock);
 
@@ -430,6 +631,7 @@ static void dxgglobal_destroy(struct dxgglobal *dxgglobal)
 {
 	if (dxgglobal) {
 		mutex_lock(&dxgglobal->device_mutex);
+		dxgglobal_stop_adapters();
 		dxgglobal_destroy_global_channel();
 		mutex_unlock(&dxgglobal->device_mutex);
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index a4365739826a..6d4b8d9d8d07 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -77,7 +77,7 @@ struct dxgvmbusmsgres {
 	void				*res;
 };
 
-static int init_message(struct dxgvmbusmsg *msg,
+static int init_message(struct dxgvmbusmsg *msg, struct dxgadapter *adapter,
 			struct dxgprocess *process, u32 size)
 {
 	struct dxgglobal *dxgglobal = dxggbl();
@@ -99,10 +99,15 @@ static int init_message(struct dxgvmbusmsg *msg,
 	if (use_ext_header) {
 		msg->msg = (char *)&msg->hdr[1];
 		msg->hdr->command_offset = sizeof(msg->hdr[0]);
+		if (adapter)
+			msg->hdr->vgpu_luid = adapter->host_vgpu_luid;
 	} else {
 		msg->msg = (char *)msg->hdr;
 	}
-	msg->channel = &dxgglobal->channel;
+	if (adapter && !dxgglobal->async_msg_enabled)
+		msg->channel = &adapter->channel;
+	else
+		msg->channel = &dxgglobal->channel;
 	return 0;
 }
 
@@ -116,6 +121,37 @@ static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
  * Helper functions
  */
 
+static void command_vm_to_host_init2(struct dxgkvmb_command_vm_to_host *command,
+				     enum dxgkvmb_commandtype_global t,
+				     struct d3dkmthandle process)
+{
+	command->command_type	= t;
+	command->process	= process;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VM_TO_HOST;
+}
+
+static void command_vgpu_to_host_init1(struct dxgkvmb_command_vgpu_to_host
+					*command,
+					enum dxgkvmb_commandtype type)
+{
+	command->command_type	= type;
+	command->process.v	= 0;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VGPU_TO_HOST;
+}
+
+static void command_vgpu_to_host_init2(struct dxgkvmb_command_vgpu_to_host
+					*command,
+					enum dxgkvmb_commandtype type,
+					struct d3dkmthandle process)
+{
+	command->command_type	= type;
+	command->process	= process;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VGPU_TO_HOST;
+}
+
 int ntstatus2int(struct ntstatus status)
 {
 	if (NT_SUCCESS(status))
@@ -216,22 +252,26 @@ static void process_inband_packet(struct dxgvmbuschannel *channel,
 	u32 packet_length = hv_pkt_datalen(desc);
 	struct dxgkvmb_command_host_to_vm *packet;
 
-	if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
-		DXG_ERR("Invalid global packet");
-	} else {
-		packet = hv_pkt_data(desc);
-		DXG_TRACE("global packet %d",
-			packet->command_type);
-		switch (packet->command_type) {
-		case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
-		case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
-			break;
-		case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
-			break;
-		default:
-			DXG_ERR("unexpected host message %d",
+	if (channel->adapter == NULL) {
+		if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
+			DXG_ERR("Invalid global packet");
+		} else {
+			packet = hv_pkt_data(desc);
+			DXG_TRACE("global packet %d",
 				packet->command_type);
+			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+				break;
+			case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
+				break;
+			default:
+				DXG_ERR("unexpected host message %d",
+					packet->command_type);
+			}
 		}
+	} else {
+		DXG_ERR("Unexpected packet for adapter channel");
 	}
 }
 
@@ -279,6 +319,7 @@ void dxgvmbuschannel_receive(void *ctx)
 	struct vmpacket_descriptor *desc;
 	u32 packet_length = 0;
 
+	DXG_TRACE("New adapter message: %p", channel->adapter);
 	foreach_vmbus_pkt(desc, channel->channel) {
 		packet_length = hv_pkt_datalen(desc);
 		DXG_TRACE("next packet (id, size, type): %llu %d %d",
@@ -302,6 +343,8 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 {
 	int ret;
 	struct dxgvmbuspacket *packet = NULL;
+	struct dxgkvmb_command_vm_to_host *cmd1;
+	struct dxgkvmb_command_vgpu_to_host *cmd2;
 
 	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
 	    result_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
@@ -315,6 +358,16 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 		return -ENOMEM;
 	}
 
+	if (channel->adapter == NULL) {
+		cmd1 = command;
+		DXG_TRACE("send_sync_msg global: %d %p %d %d",
+			cmd1->command_type, command, cmd_size, result_size);
+	} else {
+		cmd2 = command;
+		DXG_TRACE("send_sync_msg adapter: %d %p %d %d",
+			cmd2->command_type, command, cmd_size, result_size);
+	}
+
 	packet->request_id = atomic64_inc_return(&channel->packet_request_id);
 	init_completion(&packet->wait);
 	packet->buffer = result;
@@ -358,6 +411,41 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 	return ret;
 }
 
+int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
+			  void *command,
+			  u32 cmd_size)
+{
+	int ret;
+	int try_count = 0;
+
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("%s invalid data size", __func__);
+		return -EINVAL;
+	}
+
+	if (channel->adapter) {
+		DXG_ERR("Async message sent to the adapter channel");
+		return -EINVAL;
+	}
+
+	do {
+		ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+				0, VM_PKT_DATA_INBAND, 0);
+		/*
+		 * -EAGAIN is returned when the VM bus ring buffer if full.
+		 * Wait 2ms to allow the host to process messages and try again.
+		 */
+		if (ret == -EAGAIN) {
+			usleep_range(1000, 2000);
+			try_count++;
+		}
+	} while (ret == -EAGAIN && try_count < 5000);
+	if (ret < 0)
+		DXG_ERR("vmbus_sendpacket failed: %x", ret);
+
+	return ret;
+}
+
 static int
 dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
 			      void *command, u32 cmd_size)
@@ -383,7 +471,7 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len)
 	struct dxgvmbusmsg msg;
 	struct dxgglobal *dxgglobal = dxggbl();
 
-	ret = init_message(&msg, NULL, sizeof(*command));
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
 	if (ret)
 		return ret;
 	command = (void *)msg.msg;
@@ -408,3 +496,98 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len)
 		DXG_TRACE("Error: %d", ret);
 	return ret;
 }
+
+/*
+ * Virtual GPU messages to the host
+ */
+
+int dxgvmb_send_open_adapter(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_openadapter *command;
+	struct dxgkvmb_command_openadapter_return result = { };
+	struct dxgvmbusmsg msg;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_OPENADAPTER);
+	command->vmbus_interface_version = dxgglobal->vmbus_ver;
+	command->vmbus_last_compatible_interface_version =
+	    DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	adapter->host_handle = result.host_adapter_handle;
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		DXG_ERR("Failed to open adapter: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_close_adapter(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_closeadapter *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_CLOSEADAPTER);
+	command->host_handle = adapter->host_handle;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   NULL, 0);
+	free_message(&msg, NULL);
+	if (ret)
+		DXG_ERR("Failed to close adapter: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_getinternaladapterinfo *command;
+	struct dxgkvmb_command_getinternaladapterinfo_return result = { };
+	struct dxgvmbusmsg msg;
+	u32 result_size = sizeof(result);
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr,
+				   DXGK_VMBCOMMAND_GETINTERNALADAPTERINFO);
+	if (dxgglobal->vmbus_ver < DXGK_VMBUS_INTERFACE_VERSION)
+		result_size -= sizeof(struct winluid);
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, result_size);
+	if (ret >= 0) {
+		adapter->host_adapter_luid = result.host_adapter_luid;
+		adapter->host_vgpu_luid = result.host_vgpu_luid;
+		wcsncpy(adapter->device_description, result.device_description,
+			sizeof(adapter->device_description) / sizeof(u16));
+		wcsncpy(adapter->device_instance_id, result.device_instance_id,
+			sizeof(adapter->device_instance_id) / sizeof(u16));
+		dxgglobal->async_msg_enabled = result.async_msg_enabled != 0;
+	}
+	free_message(&msg, NULL);
+	if (ret)
+		DXG_ERR("Failed to get adapter info: %d", ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index b1bdd6039b73..584cdd3db6c0 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -47,6 +47,83 @@ enum dxgkvmb_commandtype_global {
 	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
 };
 
+/*
+ *
+ * Commands, sent to the host via the per adapter VM bus channel
+ * DXG_GUEST_VGPU_VMBUS
+ *
+ */
+
+enum dxgkvmb_commandtype {
+	DXGK_VMBCOMMAND_CREATEDEVICE		= 0,
+	DXGK_VMBCOMMAND_DESTROYDEVICE		= 1,
+	DXGK_VMBCOMMAND_QUERYADAPTERINFO	= 2,
+	DXGK_VMBCOMMAND_DDIQUERYADAPTERINFO	= 3,
+	DXGK_VMBCOMMAND_CREATEALLOCATION	= 4,
+	DXGK_VMBCOMMAND_DESTROYALLOCATION	= 5,
+	DXGK_VMBCOMMAND_CREATECONTEXTVIRTUAL	= 6,
+	DXGK_VMBCOMMAND_DESTROYCONTEXT		= 7,
+	DXGK_VMBCOMMAND_CREATESYNCOBJECT	= 8,
+	DXGK_VMBCOMMAND_CREATEPAGINGQUEUE	= 9,
+	DXGK_VMBCOMMAND_DESTROYPAGINGQUEUE	= 10,
+	DXGK_VMBCOMMAND_MAKERESIDENT		= 11,
+	DXGK_VMBCOMMAND_EVICT			= 12,
+	DXGK_VMBCOMMAND_ESCAPE			= 13,
+	DXGK_VMBCOMMAND_OPENADAPTER		= 14,
+	DXGK_VMBCOMMAND_CLOSEADAPTER		= 15,
+	DXGK_VMBCOMMAND_FREEGPUVIRTUALADDRESS	= 16,
+	DXGK_VMBCOMMAND_MAPGPUVIRTUALADDRESS	= 17,
+	DXGK_VMBCOMMAND_RESERVEGPUVIRTUALADDRESS = 18,
+	DXGK_VMBCOMMAND_UPDATEGPUVIRTUALADDRESS	= 19,
+	DXGK_VMBCOMMAND_SUBMITCOMMAND		= 20,
+	dxgk_vmbcommand_queryvideomemoryinfo	= 21,
+	DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMCPU = 22,
+	DXGK_VMBCOMMAND_LOCK2			= 23,
+	DXGK_VMBCOMMAND_UNLOCK2			= 24,
+	DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMGPU = 25,
+	DXGK_VMBCOMMAND_SIGNALSYNCOBJECT	= 26,
+	DXGK_VMBCOMMAND_SIGNALFENCENTSHAREDBYREF = 27,
+	DXGK_VMBCOMMAND_GETDEVICESTATE		= 28,
+	DXGK_VMBCOMMAND_MARKDEVICEASERROR	= 29,
+	DXGK_VMBCOMMAND_ADAPTERSTOP		= 30,
+	DXGK_VMBCOMMAND_SETQUEUEDLIMIT		= 31,
+	DXGK_VMBCOMMAND_OPENRESOURCE		= 32,
+	DXGK_VMBCOMMAND_SETCONTEXTSCHEDULINGPRIORITY = 33,
+	DXGK_VMBCOMMAND_PRESENTHISTORYTOKEN	= 34,
+	DXGK_VMBCOMMAND_SETREDIRECTEDFLIPFENCEVALUE = 35,
+	DXGK_VMBCOMMAND_GETINTERNALADAPTERINFO	= 36,
+	DXGK_VMBCOMMAND_FLUSHHEAPTRANSITIONS	= 37,
+	DXGK_VMBCOMMAND_BLT			= 38,
+	DXGK_VMBCOMMAND_DDIGETSTANDARDALLOCATIONDRIVERDATA = 39,
+	DXGK_VMBCOMMAND_CDDGDICOMMAND		= 40,
+	DXGK_VMBCOMMAND_QUERYALLOCATIONRESIDENCY = 41,
+	DXGK_VMBCOMMAND_FLUSHDEVICE		= 42,
+	DXGK_VMBCOMMAND_FLUSHADAPTER		= 43,
+	DXGK_VMBCOMMAND_DDIGETNODEMETADATA	= 44,
+	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE	= 45,
+	DXGK_VMBCOMMAND_ISSYNCOBJECTSIGNALED	= 46,
+	DXGK_VMBCOMMAND_CDDSYNCGPUACCESS	= 47,
+	DXGK_VMBCOMMAND_QUERYSTATISTICS		= 48,
+	DXGK_VMBCOMMAND_CHANGEVIDEOMEMORYRESERVATION = 49,
+	DXGK_VMBCOMMAND_CREATEHWQUEUE		= 50,
+	DXGK_VMBCOMMAND_DESTROYHWQUEUE		= 51,
+	DXGK_VMBCOMMAND_SUBMITCOMMANDTOHWQUEUE	= 52,
+	DXGK_VMBCOMMAND_GETDRIVERSTOREFILE	= 53,
+	DXGK_VMBCOMMAND_READDRIVERSTOREFILE	= 54,
+	DXGK_VMBCOMMAND_GETNEXTHARDLINK		= 55,
+	DXGK_VMBCOMMAND_UPDATEALLOCATIONPROPERTY = 56,
+	DXGK_VMBCOMMAND_OFFERALLOCATIONS	= 57,
+	DXGK_VMBCOMMAND_RECLAIMALLOCATIONS	= 58,
+	DXGK_VMBCOMMAND_SETALLOCATIONPRIORITY	= 59,
+	DXGK_VMBCOMMAND_GETALLOCATIONPRIORITY	= 60,
+	DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY = 61,
+	DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION	= 62,
+	DXGK_VMBCOMMAND_QUERYRESOURCEINFO	= 64,
+	DXGK_VMBCOMMAND_LOGEVENT		= 65,
+	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES	= 66,
+	DXGK_VMBCOMMAND_INVALID
+};
+
 /*
  * Commands, sent by the host to the VM
  */
@@ -66,6 +143,15 @@ struct dxgkvmb_command_vm_to_host {
 	enum dxgkvmb_commandtype_global	command_type;
 };
 
+struct dxgkvmb_command_vgpu_to_host {
+	u64				command_id;
+	struct d3dkmthandle		process;
+	u32				channel_type	: 8;
+	u32				async_msg	: 1;
+	u32				reserved	: 23;
+	enum dxgkvmb_commandtype	command_type;
+};
+
 struct dxgkvmb_command_host_to_vm {
 	u64					command_id;
 	struct d3dkmthandle			process;
@@ -83,4 +169,46 @@ struct dxgkvmb_command_setiospaceregion {
 	u32				shared_page_gpadl;
 };
 
+struct dxgkvmb_command_openadapter {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u32				vmbus_interface_version;
+	u32				vmbus_last_compatible_interface_version;
+	struct winluid			guest_adapter_luid;
+};
+
+struct dxgkvmb_command_openadapter_return {
+	struct d3dkmthandle		host_adapter_handle;
+	struct ntstatus			status;
+	u32				vmbus_interface_version;
+	u32				vmbus_last_compatible_interface_version;
+};
+
+struct dxgkvmb_command_closeadapter {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		host_handle;
+};
+
+struct dxgkvmb_command_getinternaladapterinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+};
+
+struct dxgkvmb_command_getinternaladapterinfo_return {
+	struct dxgk_device_types	device_types;
+	u32				driver_store_copy_mode;
+	u32				driver_ddi_version;
+	u32				secure_virtual_machine	: 1;
+	u32				virtual_machine_reset	: 1;
+	u32				is_vail_supported	: 1;
+	u32				hw_sch_enabled		: 1;
+	u32				hw_sch_capable		: 1;
+	u32				va_backed_vm		: 1;
+	u32				async_msg_enabled	: 1;
+	u32				hw_support_state	: 2;
+	u32				reserved		: 23;
+	struct winluid			host_adapter_luid;
+	u16				device_description[80];
+	u16				device_instance_id[WIN_MAX_PATH];
+	struct winluid			host_vgpu_luid;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
new file mode 100644
index 000000000000..cb1e0635bebc
--- /dev/null
+++ b/drivers/hv/dxgkrnl/misc.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Helper functions
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/uaccess.h>
+
+#include "dxgkrnl.h"
+#include "misc.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+u16 *wcsncpy(u16 *dest, const u16 *src, size_t n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		dest[i] = src[i];
+		if (src[i] == 0) {
+			i++;
+			break;
+		}
+	}
+	dest[i - 1] = 0;
+	return dest;
+}
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 4c6047c32a20..d292e9a9bb7f 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -14,18 +14,34 @@
 #ifndef _MISC_H_
 #define _MISC_H_
 
+/* Max characters in Windows path */
+#define WIN_MAX_PATH		260
+
 extern const struct d3dkmthandle zerohandle;
 
 /*
  * Synchronization lock hierarchy.
  *
- * The higher enum value, the higher is the lock order.
- * When a lower lock ois held, the higher lock should not be acquired.
+ * The locks here are in the order from lowest to highest.
+ * When a lower lock is held, the higher lock should not be acquired.
  *
- * channel_lock
- * device_mutex
+ * channel_lock (VMBus channel lock)
+ * fd_mutex
+ * plistmutex (process list mutex)
+ * table_lock (handle table lock)
+ * core_lock (dxgadapter lock)
+ * device_lock (dxgdevice lock)
+ * adapter_list_lock
+ * device_mutex (dxgglobal mutex)
  */
 
+u16 *wcsncpy(u16 *dest, const u16 *src, size_t n);
+
+enum dxglockstate {
+	DXGLOCK_SHARED,
+	DXGLOCK_EXCL
+};
+
 /*
  * Some of the Windows return codes, which needs to be translated to Linux
  * IOCTL return codes. Positive values are success codes and need to be

