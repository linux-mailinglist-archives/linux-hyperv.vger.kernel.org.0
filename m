Return-Path: <linux-hyperv+bounces-9606-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF1QDzFdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9606-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:31:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C04842D22C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E842E3099683
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C23FEB2C;
	Thu, 19 Mar 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUR0p8Vx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA03FE361
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951959; cv=none; b=Wpr3S7u63VX7EDxiL0nFn4/nBA8X3iLNt5m41nw3CzLNm4kUuLmJAVHkwcKic8p+QBOzBcquSSwVA9JkgvLuC/hIiaBkNls9v758STIOkoo1KyQTBbI5dBkLczrYtQY3JVwlz9jSI/rbJE+Bb/WdmY/f7y1yoMz6/F033mA98fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951959; c=relaxed/simple;
	bh=PZhfdkz6l06fsjXhfbGY5sTpwcEke0jta0C1rvcvPOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btpFUQXMNECv5GG/oLwkvVS/3rwwovB2ccJUocZXGNLrO0qX4Vgd+e9/0T559lYpIlPXI+opUIf11DMGbNH+6hTB/qhWNslfCBNyXIrpxAHYCE1obnSHvLh0bwGW8QmgsUFoUThZf4p1QOvsoozjz4aWLO5au0zxnLIXJIJcE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUR0p8Vx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b9b1900bso859108f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951954; x=1774556754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9rYNHxfIvxcKsQ5ZLeeb8g2hhtOSjW/hV2qStJ99hI=;
        b=lUR0p8VxV4zsNnG1lqlfthJciimVjKCi7azHXERgNIMeFGEsRCU4btg2ReH8Lgd6xL
         ktPdfmGYD6uV2I3ZqL0ufomjcAqH0YPuVXoWO3dEMFCmNtnEwZNymzv94HIj+uqYW0x7
         J8uaRoqPuJA5IsLzazNfz1AN3dFvidUtoKmo3hB7P1qDPRUmJEi7r+c5DAe50/HnePM1
         k6exZI/H9dFbLrtFV3olantFSnxONx9CjPtptaU9Bi02RYiUcOp9Fz5B72Ta1UshKT/E
         kjHnPT1zxsRuXxZNc/jSls8ohbg25303CmhiJR7CFeA0w8F+KNJrXO6zfsQdatPujDhk
         PkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951954; x=1774556754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9rYNHxfIvxcKsQ5ZLeeb8g2hhtOSjW/hV2qStJ99hI=;
        b=Dd9v+Y/dVCP/BlfvwQ1RbokhDfTt3/oTvGmYZbCFQ9XESZ0Pd7MSYbUP18M8OEGAl3
         3YMM8/vDpIH/llYIuQWeutNIBvFeB0pdmYVV73RRyGWdE3FunGqAdW4N8tSR2UfT8tcH
         lf7IxSemVFhCEnEVlK+8cy3Zbbb8OvLbA2coBHtzzxNeSTqjFfN03q+MovPsxKx8xwzM
         /lZ3UZBEpVLtZx256ftjRlo8P6m60aPWPRod+lGKA9f7vFLoQEvPSKXXIaOVVRcqcD0w
         n41gYu2a076Wd82Y1CCcvc5BDN+8yKMELbYwRpa/RfzH/bIw4cTLoTmjT5CgEFoO48Hq
         kx6g==
X-Gm-Message-State: AOJu0YzbOKUkfAEIKPiasUwyORCkjG2od94/K27WmeITHSXvI3H3X3y5
	k+Kcw5QjMNXRXrVOhTpe1xw/DVmV9CZ24UTSN6cjFqdUWFfOV81CZ0wmRikM3oyaikM=
X-Gm-Gg: ATEYQzwZcd11O1J4xEuEkJE9xcTZLXzZyXg7JAqpOb9IcmVrEureIYibSrUvdRSiceH
	CwRTC04+X3Cidp06c7aD33ExJMKITwYv9rWnP/MlBNDr4rweWSXZ7MbJokn0UdQ8H7u7hsYB1Ch
	v+zmROimQPV1LErGTvLnXh6h9ebrWJ4eMKnKepFIP3sM8PYVQRu8kICpRC3jJFFQQcr4FQDyTm/
	u3Y9TzoytH+zRNCYV5UZNRHHXro5+1EVkpYcUoN2Ki2dxOPpFXdOSBrUIcZvM8hGeqv3DXM636c
	keJ2mAcaEMi259wGBvJa4b379M/zDVmyhsOMVv/s4kOwdu+or/KT3sp1cQExo7CjW3h4VU1mXgh
	QGzlKuJyrvb4SKqHeHdU/YoV6fmAo0iO+Dy4LhV6Yu0igrngKnRvPPW8FG7v4fZ7TIrlbNAQ/Ac
	tVBY3wDpv6vNeyrpHhPyF/KHtiz4Kwk0TEN4WJn7zsKRItcK4+
X-Received: by 2002:a05:6000:22c2:b0:43b:44e6:6e4a with SMTP id ffacd0b85a97d-43b6428ad26mr1156153f8f.52.1773951953472;
        Thu, 19 Mar 2026 13:25:53 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:53 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 35/55] drivers: hv: dxgkrnl: Fix synchronization locks
Date: Thu, 19 Mar 2026 20:24:49 +0000
Message-ID: <20260319202509.63802-36-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9606-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C04842D22C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 19 ++++----
 drivers/hv/dxgkrnl/dxgkrnl.h    |  8 +++-
 drivers/hv/dxgkrnl/dxgmodule.c  |  3 +-
 drivers/hv/dxgkrnl/dxgprocess.c | 11 +++--
 drivers/hv/dxgkrnl/dxgvmbus.c   | 85 +++++++++++++++++++++++----------
 drivers/hv/dxgkrnl/ioctl.c      | 24 ++++++----
 drivers/hv/dxgkrnl/misc.h       |  1 +
 7 files changed, 101 insertions(+), 50 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 3d8bec295b87..d9d45bd4a31e 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -136,7 +136,7 @@ void dxgadapter_release(struct kref *refcount)
 	struct dxgadapter *adapter;
 
 	adapter = container_of(refcount, struct dxgadapter, adapter_kref);
-	DXG_TRACE("%p", adapter);
+	DXG_TRACE("Destroying adapter: %px", adapter);
 	kfree(adapter);
 }
 
@@ -270,6 +270,8 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 		if (ret < 0) {
 			kref_put(&device->device_kref, dxgdevice_release);
 			device = NULL;
+		} else {
+			DXG_TRACE("dxgdevice created: %px", device);
 		}
 	}
 	return device;
@@ -413,11 +415,8 @@ void dxgdevice_destroy(struct dxgdevice *device)
 
 cleanup:
 
-	if (device->adapter) {
+	if (device->adapter)
 		dxgprocess_adapter_remove_device(device);
-		kref_put(&device->adapter->adapter_kref, dxgadapter_release);
-		device->adapter = NULL;
-	}
 
 	up_write(&device->device_lock);
 
@@ -721,6 +720,8 @@ void dxgdevice_release(struct kref *refcount)
 	struct dxgdevice *device;
 
 	device = container_of(refcount, struct dxgdevice, device_kref);
+	DXG_TRACE("Destroying device: %px", device);
+	kref_put(&device->adapter->adapter_kref, dxgadapter_release);
 	kfree(device);
 }
 
@@ -999,6 +1000,9 @@ void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
 	kfree(pqueue);
 }
 
+/*
+ * Process_adapter_mutex is held.
+ */
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
@@ -1108,7 +1112,7 @@ int dxgprocess_adapter_add_device(struct dxgprocess *process,
 
 void dxgprocess_adapter_remove_device(struct dxgdevice *device)
 {
-	DXG_TRACE("Removing device: %p", device);
+	DXG_TRACE("Removing device: %px", device);
 	mutex_lock(&device->adapter_info->device_list_mutex);
 	if (device->device_list_entry.next) {
 		list_del(&device->device_list_entry);
@@ -1147,8 +1151,7 @@ void dxgsharedsyncobj_release(struct kref *refcount)
 	if (syncobj->adapter) {
 		dxgadapter_remove_shared_syncobj(syncobj->adapter,
 							syncobj);
-		kref_put(&syncobj->adapter->adapter_kref,
-				dxgadapter_release);
+		kref_put(&syncobj->adapter->adapter_kref, dxgadapter_release);
 	}
 	kfree(syncobj);
 }
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index f63aa6f7a9dc..1b40d6e39085 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -404,7 +404,10 @@ struct dxgprocess {
 	/* Handle of the corresponding objec on the host */
 	struct d3dkmthandle	host_handle;
 
-	/* List of opened adapters (dxgprocess_adapter) */
+	/*
+	 * List of opened adapters (dxgprocess_adapter).
+	 * Protected by process_adapter_mutex.
+	 */
 	struct list_head	process_adapter_list_head;
 };
 
@@ -451,6 +454,8 @@ enum dxgadapter_state {
 struct dxgadapter {
 	struct rw_semaphore	core_lock;
 	struct kref		adapter_kref;
+	/* Protects creation and destruction of dxgdevice objects */
+	struct mutex		device_creation_lock;
 	/* Entry in the list of adapters in dxgglobal */
 	struct list_head	adapter_list_entry;
 	/* The list of dxgprocess_adapter entries */
@@ -997,6 +1002,7 @@ void dxgk_validate_ioctls(void);
 
 #define DXG_TRACE(fmt, ...)  do {			\
 	trace_printk(dev_fmt(fmt) "\n", ##__VA_ARGS__);	\
+	dev_dbg(DXGDEV, "%s: " fmt, __func__, ##__VA_ARGS__);	\
 }  while (0)
 
 #define DXG_ERR(fmt, ...) do {					\
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index aa27931a3447..f419597f711a 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -272,6 +272,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	adapter->host_vgpu_luid = host_vgpu_luid;
 	kref_init(&adapter->adapter_kref);
 	init_rwsem(&adapter->core_lock);
+	mutex_init(&adapter->device_creation_lock);
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
 	INIT_LIST_HEAD(&adapter->shared_resource_list_head);
@@ -961,4 +962,4 @@ module_exit(dxg_drv_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual compute device Driver");
-MODULE_VERSION("2.0.0");
+MODULE_VERSION("2.0.1");
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index e77e3a4983f8..fd51fd968049 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -214,14 +214,15 @@ int dxgprocess_close_adapter(struct dxgprocess *process,
 	hmgrtable_unlock(&process->local_handle_table, DXGLOCK_EXCL);
 
 	if (adapter) {
+		mutex_lock(&adapter->device_creation_lock);
+		dxgglobal_acquire_process_adapter_lock();
 		adapter_info = dxgprocess_get_adapter_info(process, adapter);
-		if (adapter_info) {
-			dxgglobal_acquire_process_adapter_lock();
+		if (adapter_info)
 			dxgprocess_adapter_release(adapter_info);
-			dxgglobal_release_process_adapter_lock();
-		} else {
+		else
 			ret = -EINVAL;
-		}
+		dxgglobal_release_process_adapter_lock();
+		mutex_unlock(&adapter->device_creation_lock);
 	} else {
 		DXG_ERR("Adapter not found %x", handle.v);
 		ret = -EINVAL;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 566ccb6d01c9..8c99f141482e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1573,8 +1573,27 @@ process_allocation_handles(struct dxgprocess *process,
 			   struct dxgresource *resource)
 {
 	int ret = 0;
-	int i;
+	int i = 0;
+	int k;
+	struct dxgkvmb_command_allocinfo_return *host_alloc;
 
+	/*
+	 * Assign handle to the internal objects, so VM bus messages will be
+	 * sent to the host to free them during object destruction.
+	 */
+	if (args->flags.create_resource)
+		resource->handle = res->resource;
+	for (i = 0; i < args->alloc_count; i++) {
+		host_alloc = &res->allocation_info[i];
+		dxgalloc[i]->alloc_handle = host_alloc->allocation;
+	}
+
+	/*
+	 * Assign handle to the handle table.
+	 * In case of a failure all handles should be freed.
+	 * When the function returns, the objects could be destroyed  by
+	 * handle immediately.
+	 */
 	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
 	if (args->flags.create_resource) {
 		ret = hmgrtable_assign_handle(&process->handle_table, resource,
@@ -1583,14 +1602,12 @@ process_allocation_handles(struct dxgprocess *process,
 		if (ret < 0) {
 			DXG_ERR("failed to assign resource handle %x",
 				res->resource.v);
+			goto cleanup;
 		} else {
-			resource->handle = res->resource;
 			resource->handle_valid = 1;
 		}
 	}
 	for (i = 0; i < args->alloc_count; i++) {
-		struct dxgkvmb_command_allocinfo_return *host_alloc;
-
 		host_alloc = &res->allocation_info[i];
 		ret = hmgrtable_assign_handle(&process->handle_table,
 					      dxgalloc[i],
@@ -1602,9 +1619,26 @@ process_allocation_handles(struct dxgprocess *process,
 				args->alloc_count, i);
 			break;
 		}
-		dxgalloc[i]->alloc_handle = host_alloc->allocation;
 		dxgalloc[i]->handle_valid = 1;
 	}
+	if (ret < 0) {
+		if (args->flags.create_resource) {
+			hmgrtable_free_handle(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGRESOURCE,
+					      res->resource);
+			resource->handle_valid = 0;
+		}
+		for (k = 0; k < i; k++) {
+			host_alloc = &res->allocation_info[i];
+			hmgrtable_free_handle(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGALLOCATION,
+					      host_alloc->allocation);
+			dxgalloc[i]->handle_valid = 0;
+		}
+	}
+
+cleanup:
+
 	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
 
 	if (ret)
@@ -1705,18 +1739,17 @@ create_local_allocations(struct dxgprocess *process,
 		}
 	}
 
-	ret = process_allocation_handles(process, device, args, result,
-					 dxgalloc, resource);
-	if (ret < 0)
-		goto cleanup;
-
 	ret = copy_to_user(&input_args->global_share, &args->global_share,
 			   sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy global share");
 		ret = -EFAULT;
+		goto cleanup;
 	}
 
+	ret = process_allocation_handles(process, device, args, result,
+					 dxgalloc, resource);
+
 cleanup:
 
 	if (ret < 0) {
@@ -3576,22 +3609,6 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 		goto cleanup;
 	}
 
-	ret = hmgrtable_assign_handle_safe(&process->handle_table, hwqueue,
-					   HMGRENTRY_TYPE_DXGHWQUEUE,
-					   command->hwqueue);
-	if (ret < 0)
-		goto cleanup;
-
-	ret = hmgrtable_assign_handle_safe(&process->handle_table,
-				NULL,
-				HMGRENTRY_TYPE_MONITOREDFENCE,
-				command->hwqueue_progress_fence);
-	if (ret < 0)
-		goto cleanup;
-
-	hwqueue->handle = command->hwqueue;
-	hwqueue->progress_fence_sync_object = command->hwqueue_progress_fence;
-
 	hwqueue->progress_fence_mapped_address =
 		dxg_map_iospace((u64)command->hwqueue_progress_fence_cpuva,
 				PAGE_SIZE, PROT_READ | PROT_WRITE, true);
@@ -3641,6 +3658,22 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 		}
 	}
 
+	ret = hmgrtable_assign_handle_safe(&process->handle_table,
+				NULL,
+				HMGRENTRY_TYPE_MONITOREDFENCE,
+				command->hwqueue_progress_fence);
+	if (ret < 0)
+		goto cleanup;
+
+	hwqueue->progress_fence_sync_object = command->hwqueue_progress_fence;
+	hwqueue->handle = command->hwqueue;
+
+	ret = hmgrtable_assign_handle_safe(&process->handle_table, hwqueue,
+					   HMGRENTRY_TYPE_DXGHWQUEUE,
+					   command->hwqueue);
+	if (ret < 0)
+		hwqueue->handle.v = 0;
+
 cleanup:
 	if (ret < 0) {
 		DXG_ERR("failed %x", ret);
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 3dc9e76f4f3d..7c72790f917f 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -636,6 +636,7 @@ dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
 	struct dxgdevice *device = NULL;
 	struct d3dkmthandle host_device_handle = {};
 	bool adapter_locked = false;
+	bool device_creation_locked = false;
 
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
@@ -651,6 +652,9 @@ dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 	}
 
+	mutex_lock(&adapter->device_creation_lock);
+	device_creation_locked = true;
+
 	device = dxgdevice_create(adapter, process);
 	if (device == NULL) {
 		ret = -ENOMEM;
@@ -699,6 +703,9 @@ dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
 	if (adapter_locked)
 		dxgadapter_release_lock_shared(adapter);
 
+	if (device_creation_locked)
+		mutex_unlock(&adapter->device_creation_lock);
+
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
 
@@ -803,22 +810,21 @@ dxgkio_create_context_virtual(struct dxgprocess *process, void *__user inargs)
 	host_context_handle = dxgvmb_send_create_context(adapter,
 							 process, &args);
 	if (host_context_handle.v) {
-		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
-		ret = hmgrtable_assign_handle(&process->handle_table, context,
-					      HMGRENTRY_TYPE_DXGCONTEXT,
-					      host_context_handle);
-		if (ret >= 0)
-			context->handle = host_context_handle;
-		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
-		if (ret < 0)
-			goto cleanup;
 		ret = copy_to_user(&((struct d3dkmt_createcontextvirtual *)
 				   inargs)->context, &host_context_handle,
 				   sizeof(struct d3dkmthandle));
 		if (ret) {
 			DXG_ERR("failed to copy context handle");
 			ret = -EFAULT;
+			goto cleanup;
 		}
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, context,
+					      HMGRENTRY_TYPE_DXGCONTEXT,
+					      host_context_handle);
+		if (ret >= 0)
+			context->handle = host_context_handle;
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
 	} else {
 		DXG_ERR("invalid host handle");
 		ret = -EINVAL;
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index ee2ebfdd1c13..9fcab4ae2c0c 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -38,6 +38,7 @@ extern const struct d3dkmthandle zerohandle;
  * core_lock (dxgadapter lock)
  * device_lock (dxgdevice lock)
  * process_adapter_mutex
+ * device_creation_lock in dxgadapter
  * adapter_list_lock
  * device_mutex (dxgglobal mutex)
  */

