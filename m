Return-Path: <linux-hyperv+bounces-9580-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCe8Lz9cvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9580-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3742D2181
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE51316CAEB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B033F99F1;
	Thu, 19 Mar 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABAIKlnz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DA3F7E93
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951930; cv=none; b=helzMAz43G1cx5RotEpCvDk/QAk1xpCHekLlUFadD/lShGkEg+4eriSLQVRKT4LU2Oc3n6APPGMbGe/rFeABDq3wNP7JHK9RtR2WfyaJb0L53ER/mAVVKvL3D3zZOBOrASVgd6vhdpxB7MDDKOclbF3KSzrUvdkrO9oRy/LnmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951930; c=relaxed/simple;
	bh=IqcUGpB2PtgVu6arzPygtpGtWVPPQZJgUoQW8arIol0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUt6bu0O80fcP5tq5eFnBoWrX40oLAoKyQyFbBNt78+ZxhLyR65roEjQxAOapLnm5as+dVo4Z2eF9aObMggHnK57I8VYX1EcsqEv2vD7TXiByz6PLjaUmYvkGZCgCElIwowsakPZE6gLvis79dlckztw7K/rnbD/SG5AeiY2j4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABAIKlnz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so10974645e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951924; x=1774556724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye1TIkHhwdICDOIgZUhwxe648xXV4IEZCAKFuIhIotg=;
        b=ABAIKlnzISTT15ZHqqMzqIO7bfibaVTb3lWpEh52OjZ6mG+caurZOFC7EYxYbsnega
         U5mf0UeLnQuGvKw7vhv6+Dt052+NSkUj5udTbWssxKG5Izd/A5uEbhbn6E/cP9o+ROqd
         l1aJsxOXbgGEMXWxdYoWoTp4xmjIREr7KeMdpD/iMouIHyioWbcApOIOjAVxG388ogSa
         f0P9FZQi+NGVHmISzgd/AUSNuAXqvvGmVLwVbiTTFDCcpo2/ZtuI8X1VgG783rdp/CU+
         yaLVPtD0vo7nqv/8+lg5+e4i1zh4Efly5i7tOF0oATEinJQ2C6pe60YQMJDsZNvpbbze
         P7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951924; x=1774556724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ye1TIkHhwdICDOIgZUhwxe648xXV4IEZCAKFuIhIotg=;
        b=gHoH57IT4rVZE2u+DEghF19pyhWSDjUuMurmB2zM+EwfoLurKP7VwwYlEFhakfC5uH
         nAW3lLi8a08XWs7pdV5qD1XLv3MBosir73pP0ISoSrhVObPdxUEQ5RsMN11FeiocmQ/0
         +2GoZwOtfh3NWGeq6XTh4lv9ZxCdQoYvt+oGcZlDLCs12sgfXPvRfr+1BElxtYUlidO/
         49BKvBxvWpGWzZ/ib5dKSuG177MJJlA2IPcnwDL79NFVDfvcCeoTzril3JYkatl9LB0Y
         IH3Gf18RHWYYv3o3zFojr8621MVJ84H1JwaaApsyOxJ7JFkBn1ZcSEctgvbk+7ybvv5y
         Eeig==
X-Gm-Message-State: AOJu0YwgwC2x/c2YUKXbMUD9rscLyxN0rna/7ZXoz1eGaM6JbAI/c6jI
	MgTHU2ZgodJJ8cGkuwFceSRS4dhFBvvKBuUYA6NDQcmfMFwlwgG5+ZA+oKxYhtTMK4w=
X-Gm-Gg: ATEYQzyZFSIFaRdFgkA6gPdVIv51IHYNsFOY3jGM5efuyam/+uOZQWFOquX/OiIQWE0
	jKxvAN34fE0qNBKr+yjEdR/qxA8UoWc24+xNhK/UdAxsneqCKdh52u9UQn9Gy952CTvW0FSg/kS
	ZTq8JHMUyXbt+HFYXo/+b0gPAZDC5C3xPjrlaHtCDFEq3gwWpW7NNhX/EOL0+U4Oezalqo0DoMO
	Qlex4wJXXTSqF0yfLgu66z5DWxawHTGyNgX1T7/AB7wJVjf3zAQwPvwrIXoRoPjSH4UMv1eRBuQ
	joVsNJX/JHrIH0EVPO3a4Dz0j/h2cHdgx1AXaUJbCDIG7lVrMFa8kO7zy7/UXiH9551fLZIqlTH
	zB9uafTdxDlrNq10A/Bm5++P5yLOE0TI5gs8pqfvIOTvt0IqTFCZeostBREDVnU5Ti1NNEoCPY6
	7FMiziSe1XMXBZavcs5Uoh6iPbcY6ZuKlNMr6qUU1lgDHfVEvQ
X-Received: by 2002:a05:600c:1d0c:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-486fee2ff25mr6878185e9.30.1773951923676;
        Thu, 19 Mar 2026 13:25:23 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:23 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 09/55] drivers: hv: dxgkrnl: Creation of compute device sync objects
Date: Thu, 19 Mar 2026 20:24:23 +0000
Message-ID: <20260319202509.63802-10-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9580-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C3742D2181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to create and destroy compute devicesync objects:
 - the LX_DXCREATESYNCHRONIZATIONOBJECT ioctl,
 - the LX_DXDESTROYSYNCHRONIZATIONOBJECT ioctl.

Compute device synchronization objects are used to synchronize
execution of compute device commands, which are queued to
different execution contexts (dxgcontext objects).

There are several types of sync objects (mutex, monitored
fence, CPU event, fence). A "signal" or a "wait" operation
could be queued to an execution context.

Monitored fence sync objects are particular important.
A monitored fence object has a fence value, which could be
monitored by the compute device or by CPU. Therefore, a CPU
virtual address is allocated during object creation to allow
an application to read the fence value. dxg_map_iospace and
dxg_unmap_iospace implement creation of the CPU virtual address.
This is done as follow:
- The host allocates a portion of the guest IO space, which is mapped
  to the actual fence value memory on the host
- The host returns the guest IO space address to the guest
- The guest allocates a CPU virtual address and updates page tables
  to point to the IO space address

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 184 ++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  80 +++++++++++++
 drivers/hv/dxgkrnl/dxgmodule.c  |   1 +
 drivers/hv/dxgkrnl/dxgprocess.c |  16 +++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 205 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  20 ++++
 drivers/hv/dxgkrnl/ioctl.c      | 130 +++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h    |  95 +++++++++++++++
 8 files changed, 729 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 402caa81a5db..d2f2b96527e6 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -160,6 +160,24 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
 	list_del(&process_info->adapter_process_list_entry);
 }
 
+void dxgadapter_add_syncobj(struct dxgadapter *adapter,
+			    struct dxgsyncobject *object)
+{
+	down_write(&adapter->shared_resource_list_lock);
+	list_add_tail(&object->syncobj_list_entry, &adapter->syncobj_list_head);
+	up_write(&adapter->shared_resource_list_lock);
+}
+
+void dxgadapter_remove_syncobj(struct dxgsyncobject *object)
+{
+	down_write(&object->adapter->shared_resource_list_lock);
+	if (object->syncobj_list_entry.next) {
+		list_del(&object->syncobj_list_entry);
+		object->syncobj_list_entry.next = NULL;
+	}
+	up_write(&object->adapter->shared_resource_list_lock);
+}
+
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
 {
 	down_write(&adapter->core_lock);
@@ -213,6 +231,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 		init_rwsem(&device->context_list_lock);
 		init_rwsem(&device->alloc_list_lock);
 		INIT_LIST_HEAD(&device->pqueue_list_head);
+		INIT_LIST_HEAD(&device->syncobj_list_head);
 		device->object_state = DXGOBJECTSTATE_CREATED;
 		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
 
@@ -228,6 +247,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 void dxgdevice_stop(struct dxgdevice *device)
 {
 	struct dxgallocation *alloc;
+	struct dxgsyncobject *syncobj;
 
 	DXG_TRACE("Destroying device: %p", device);
 	dxgdevice_acquire_alloc_list_lock(device);
@@ -235,6 +255,14 @@ void dxgdevice_stop(struct dxgdevice *device)
 		dxgallocation_stop(alloc);
 	}
 	dxgdevice_release_alloc_list_lock(device);
+
+	hmgrtable_lock(&device->process->handle_table, DXGLOCK_EXCL);
+	list_for_each_entry(syncobj, &device->syncobj_list_head,
+			    syncobj_list_entry) {
+		dxgsyncobject_stop(syncobj);
+	}
+	hmgrtable_unlock(&device->process->handle_table, DXGLOCK_EXCL);
+	DXG_TRACE("Device stopped: %p", device);
 }
 
 void dxgdevice_mark_destroyed(struct dxgdevice *device)
@@ -263,6 +291,20 @@ void dxgdevice_destroy(struct dxgdevice *device)
 
 	dxgdevice_acquire_alloc_list_lock(device);
 
+	while (!list_empty(&device->syncobj_list_head)) {
+		struct dxgsyncobject *syncobj =
+		    list_first_entry(&device->syncobj_list_head,
+				     struct dxgsyncobject,
+				     syncobj_list_entry);
+		list_del(&syncobj->syncobj_list_entry);
+		syncobj->syncobj_list_entry.next = NULL;
+		dxgdevice_release_alloc_list_lock(device);
+
+		dxgsyncobject_destroy(process, syncobj);
+
+		dxgdevice_acquire_alloc_list_lock(device);
+	}
+
 	{
 		struct dxgallocation *alloc;
 		struct dxgallocation *tmp;
@@ -565,6 +607,30 @@ void dxgdevice_release(struct kref *refcount)
 	kfree(device);
 }
 
+void dxgdevice_add_syncobj(struct dxgdevice *device,
+			   struct dxgsyncobject *syncobj)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_add_tail(&syncobj->syncobj_list_entry, &device->syncobj_list_head);
+	kref_get(&syncobj->syncobj_kref);
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_remove_syncobj(struct dxgsyncobject *entry)
+{
+	struct dxgdevice *device = entry->device;
+
+	dxgdevice_acquire_alloc_list_lock(device);
+	if (entry->syncobj_list_entry.next) {
+		list_del(&entry->syncobj_list_entry);
+		entry->syncobj_list_entry.next = NULL;
+		kref_put(&entry->syncobj_kref, dxgsyncobject_release);
+	}
+	dxgdevice_release_alloc_list_lock(device);
+	kref_put(&device->device_kref, dxgdevice_release);
+	entry->device = NULL;
+}
+
 struct dxgcontext *dxgcontext_create(struct dxgdevice *device)
 {
 	struct dxgcontext *context;
@@ -812,3 +878,121 @@ void dxgprocess_adapter_remove_device(struct dxgdevice *device)
 	}
 	mutex_unlock(&device->adapter_info->device_list_mutex);
 }
+
+struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
+					   struct dxgdevice *device,
+					   struct dxgadapter *adapter,
+					   enum
+					   d3dddi_synchronizationobject_type
+					   type,
+					   struct
+					   d3dddi_synchronizationobject_flags
+					   flags)
+{
+	struct dxgsyncobject *syncobj;
+
+	syncobj = kzalloc(sizeof(*syncobj), GFP_KERNEL);
+	if (syncobj == NULL)
+		goto cleanup;
+	syncobj->type = type;
+	syncobj->process = process;
+	switch (type) {
+	case _D3DDDI_MONITORED_FENCE:
+	case _D3DDDI_PERIODIC_MONITORED_FENCE:
+		syncobj->monitored_fence = 1;
+		break;
+	default:
+		break;
+	}
+	if (flags.shared) {
+		syncobj->shared = 1;
+		if (!flags.nt_security_sharing) {
+			DXG_ERR("nt_security_sharing must be set");
+			goto cleanup;
+		}
+	}
+
+	kref_init(&syncobj->syncobj_kref);
+
+	if (syncobj->monitored_fence) {
+		syncobj->device = device;
+		syncobj->device_handle = device->handle;
+		kref_get(&device->device_kref);
+		dxgdevice_add_syncobj(device, syncobj);
+	} else {
+		dxgadapter_add_syncobj(adapter, syncobj);
+	}
+	syncobj->adapter = adapter;
+	kref_get(&adapter->adapter_kref);
+
+	DXG_TRACE("Syncobj created: %p", syncobj);
+	return syncobj;
+cleanup:
+	if (syncobj)
+		kfree(syncobj);
+	return NULL;
+}
+
+void dxgsyncobject_destroy(struct dxgprocess *process,
+			   struct dxgsyncobject *syncobj)
+{
+	int destroyed;
+
+	DXG_TRACE("Destroying syncobj: %p", syncobj);
+
+	dxgsyncobject_stop(syncobj);
+
+	destroyed = test_and_set_bit(0, &syncobj->flags);
+	if (!destroyed) {
+		DXG_TRACE("Deleting handle: %x", syncobj->handle.v);
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		if (syncobj->handle.v) {
+			hmgrtable_free_handle(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+					      syncobj->handle);
+			syncobj->handle.v = 0;
+			kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+		}
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+		if (syncobj->monitored_fence)
+			dxgdevice_remove_syncobj(syncobj);
+		else
+			dxgadapter_remove_syncobj(syncobj);
+		if (syncobj->adapter) {
+			kref_put(&syncobj->adapter->adapter_kref,
+				 dxgadapter_release);
+			syncobj->adapter = NULL;
+		}
+	}
+	kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+}
+
+void dxgsyncobject_stop(struct dxgsyncobject *syncobj)
+{
+	int stopped = test_and_set_bit(1, &syncobj->flags);
+
+	if (!stopped) {
+		DXG_TRACE("Stopping syncobj");
+		if (syncobj->monitored_fence) {
+			if (syncobj->mapped_address) {
+				int ret =
+				    dxg_unmap_iospace(syncobj->mapped_address,
+						      PAGE_SIZE);
+
+				(void)ret;
+				DXG_TRACE("unmap fence %d %p",
+					ret, syncobj->mapped_address);
+				syncobj->mapped_address = NULL;
+			}
+		}
+	}
+}
+
+void dxgsyncobject_release(struct kref *refcount)
+{
+	struct dxgsyncobject *syncobj;
+
+	syncobj = container_of(refcount, struct dxgsyncobject, syncobj_kref);
+	kfree(syncobj);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index fa053fb6ac9c..1b9410c9152b 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -38,6 +38,7 @@ struct dxgdevice;
 struct dxgcontext;
 struct dxgallocation;
 struct dxgresource;
+struct dxgsyncobject;
 
 /*
  * Driver private data.
@@ -100,6 +101,56 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
 void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
 void dxgvmbuschannel_receive(void *ctx);
 
+/*
+ * This is GPU synchronization object, which is used to synchronize execution
+ * between GPU contextx/hardware queues or for tracking GPU execution progress.
+ * A dxgsyncobject is created when somebody creates a syncobject or opens a
+ * shared syncobject.
+ * A syncobject belongs to an adapter, unless it is a cross-adapter object.
+ * Cross adapter syncobjects are currently not implemented.
+ *
+ * D3DDDI_MONITORED_FENCE and D3DDDI_PERIODIC_MONITORED_FENCE are called
+ * "device" syncobject, because the belong to a device (dxgdevice).
+ * Device syncobjects are inserted to a list in dxgdevice.
+ *
+ */
+struct dxgsyncobject {
+	struct kref			syncobj_kref;
+	enum d3dddi_synchronizationobject_type	type;
+	/*
+	 * List entry in dxgdevice for device sync objects.
+	 * List entry in dxgadapter for other objects
+	 */
+	struct list_head		syncobj_list_entry;
+	/* Adapter, the syncobject belongs to. NULL for stopped sync obejcts. */
+	struct dxgadapter		*adapter;
+	/*
+	 * Pointer to the device, which was used to create the object.
+	 * This is NULL for non-device syncbjects
+	 */
+	struct dxgdevice		*device;
+	struct dxgprocess		*process;
+	/* CPU virtual address of the fence value for "device" syncobjects */
+	void				*mapped_address;
+	/* Handle in the process handle table */
+	struct d3dkmthandle		handle;
+	/* Cached handle of the device. Used to avoid device dereference. */
+	struct d3dkmthandle		device_handle;
+	union {
+		struct {
+			/* Must be the first bit */
+			u32		destroyed:1;
+			/* Must be the second bit */
+			u32		stopped:1;
+			/* device syncobject */
+			u32		monitored_fence:1;
+			u32		shared:1;
+			u32		reserved:27;
+		};
+		long			flags;
+	};
+};
+
 /*
  * The structure defines an offered vGPU vm bus channel.
  */
@@ -109,6 +160,20 @@ struct dxgvgpuchannel {
 	struct hv_device	*hdev;
 };
 
+struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
+					   struct dxgdevice *device,
+					   struct dxgadapter *adapter,
+					   enum
+					   d3dddi_synchronizationobject_type
+					   type,
+					   struct
+					   d3dddi_synchronizationobject_flags
+					   flags);
+void dxgsyncobject_destroy(struct dxgprocess *process,
+			   struct dxgsyncobject *syncobj);
+void dxgsyncobject_stop(struct dxgsyncobject *syncobj);
+void dxgsyncobject_release(struct kref *refcount);
+
 struct dxgglobal {
 	struct dxgdriver	*drvdata;
 	struct dxgvmbuschannel	channel;
@@ -271,6 +336,8 @@ struct dxgadapter {
 	struct list_head	adapter_list_entry;
 	/* The list of dxgprocess_adapter entries */
 	struct list_head	adapter_process_list_head;
+	/* List of all non-device dxgsyncobject objects */
+	struct list_head	syncobj_list_head;
 	/* This lock protects shared resource and syncobject lists */
 	struct rw_semaphore	shared_resource_list_lock;
 	struct pci_dev		*pci_dev;
@@ -296,6 +363,9 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
 void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
 void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_add_syncobj(struct dxgadapter *adapter,
+			    struct dxgsyncobject *so);
+void dxgadapter_remove_syncobj(struct dxgsyncobject *so);
 void dxgadapter_add_process(struct dxgadapter *adapter,
 			    struct dxgprocess_adapter *process_info);
 void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
@@ -325,6 +395,7 @@ struct dxgdevice {
 	struct list_head	resource_list_head;
 	/* List of paging queues. Protected by process handle table lock. */
 	struct list_head	pqueue_list_head;
+	struct list_head	syncobj_list_head;
 	struct d3dkmthandle	handle;
 	enum d3dkmt_deviceexecution_state execution_state;
 	u32			handle_valid;
@@ -345,6 +416,8 @@ void dxgdevice_remove_alloc_safe(struct dxgdevice *dev,
 				 struct dxgallocation *a);
 void dxgdevice_add_resource(struct dxgdevice *dev, struct dxgresource *res);
 void dxgdevice_remove_resource(struct dxgdevice *dev, struct dxgresource *res);
+void dxgdevice_add_syncobj(struct dxgdevice *dev, struct dxgsyncobject *so);
+void dxgdevice_remove_syncobj(struct dxgsyncobject *so);
 bool dxgdevice_is_active(struct dxgdevice *dev);
 void dxgdevice_acquire_context_list_lock(struct dxgdevice *dev);
 void dxgdevice_release_context_list_lock(struct dxgdevice *dev);
@@ -455,6 +528,7 @@ void dxgallocation_free_handle(struct dxgallocation *a);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 
+int dxg_unmap_iospace(void *va, u32 size);
 /*
  * The convention is that VNBus instance id is a GUID, but the host sets
  * the lower part of the value to the host adapter LUID. The function
@@ -514,6 +588,12 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
+				   struct dxgadapter *adapter,
+				   struct d3dkmt_createsynchronizationobject2
+				   *args, struct dxgsyncobject *so);
+int dxgvmb_send_destroy_sync_object(struct dxgprocess *pr,
+				    struct d3dkmthandle h);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 053ce6f3e083..9bc8931c5043 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -162,6 +162,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	init_rwsem(&adapter->core_lock);
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
+	INIT_LIST_HEAD(&adapter->syncobj_list_head);
 	init_rwsem(&adapter->shared_resource_list_lock);
 	adapter->pci_dev = dev;
 	guid_to_luid(guid, &adapter->luid);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index ca307beb9a9a..a41985ef438d 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -59,6 +59,7 @@ void dxgprocess_destroy(struct dxgprocess *process)
 	enum hmgrentry_type t;
 	struct d3dkmthandle h;
 	void *o;
+	struct dxgsyncobject *syncobj;
 	struct dxgprocess_adapter *entry;
 	struct dxgprocess_adapter *tmp;
 
@@ -84,6 +85,21 @@ void dxgprocess_destroy(struct dxgprocess *process)
 		}
 	}
 
+	i = 0;
+	while (hmgrtable_next_entry(&process->handle_table, &i, &t, &h, &o)) {
+		switch (t) {
+		case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+			DXG_TRACE("Destroy syncobj: %p %d", o, i);
+			syncobj = o;
+			syncobj->handle.v = 0;
+			dxgsyncobject_destroy(process, syncobj);
+			break;
+		default:
+			DXG_ERR("invalid entry in handle table %d", t);
+			break;
+		}
+	}
+
 	hmgrtable_destroy(&process->handle_table);
 	hmgrtable_destroy(&process->local_handle_table);
 }
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 14b51a3c6afc..d323afc85249 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -495,6 +495,88 @@ dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
 	return ret;
 }
 
+static int check_iospace_address(unsigned long address, u32 size)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	if (address < dxgglobal->mmiospace_base ||
+	    size > dxgglobal->mmiospace_size ||
+	    address >= (dxgglobal->mmiospace_base +
+			dxgglobal->mmiospace_size - size)) {
+		DXG_ERR("invalid iospace address %lx", address);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int dxg_unmap_iospace(void *va, u32 size)
+{
+	int ret = 0;
+
+	DXG_TRACE("Unmapping io space: %p %x", va, size);
+
+	/*
+	 * When an app calls exit(), dxgkrnl is called to close the device
+	 * with current->mm equal to NULL.
+	 */
+	if (current->mm) {
+		ret = vm_munmap((unsigned long)va, size);
+		if (ret) {
+			DXG_ERR("vm_munmap failed %d", ret);
+			return -ENOTRECOVERABLE;
+		}
+	}
+	return 0;
+}
+
+static u8 *dxg_map_iospace(u64 iospace_address, u32 size,
+			   unsigned long protection, bool cached)
+{
+	struct vm_area_struct *vma;
+	unsigned long va;
+	int ret = 0;
+
+	DXG_TRACE("Mapping io space: %llx %x %lx",
+		iospace_address, size, protection);
+	if (check_iospace_address(iospace_address, size) < 0) {
+		DXG_ERR("invalid address to map");
+		return NULL;
+	}
+
+	va = vm_mmap(NULL, 0, size, protection, MAP_SHARED | MAP_ANONYMOUS, 0);
+	if ((long)va <= 0) {
+		DXG_ERR("vm_mmap failed %lx %d", va, size);
+		return NULL;
+	}
+
+	mmap_read_lock(current->mm);
+	vma = find_vma(current->mm, (unsigned long)va);
+	if (vma) {
+		pgprot_t prot = vma->vm_page_prot;
+
+		if (!cached)
+			prot = pgprot_writecombine(prot);
+		DXG_TRACE("vma: %lx %lx %lx",
+			vma->vm_start, vma->vm_end, va);
+		vma->vm_pgoff = iospace_address >> PAGE_SHIFT;
+		ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+					 size, prot);
+		if (ret)
+			DXG_ERR("io_remap_pfn_range failed: %d", ret);
+	} else {
+		DXG_ERR("failed to find vma: %p %lx", vma, va);
+		ret = -ENOMEM;
+	}
+	mmap_read_unlock(current->mm);
+
+	if (ret) {
+		dxg_unmap_iospace((void *)va, size);
+		return NULL;
+	}
+	DXG_TRACE("Mapped VA: %lx", va);
+	return (u8 *) va;
+}
+
 /*
  * Global messages to the host
  */
@@ -613,6 +695,39 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	return ret;
 }
 
+int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
+				    struct d3dkmthandle sync_object)
+{
+	struct dxgkvmb_command_destroysyncobject *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_DESTROYSYNCOBJECT,
+				 process->host_handle);
+	command->sync_object = sync_object;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(dxgglobal_get_dxgvmbuschannel(),
+					    msg.hdr, msg.size);
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
@@ -1023,7 +1138,11 @@ int create_existing_sysmem(struct dxgdevice *device,
 		ret = -ENOMEM;
 		goto cleanup;
 	}
+#ifdef _MAIN_KERNEL_
 	DXG_TRACE("New gpadl %d", dxgalloc->gpadl.gpadl_handle);
+#else
+	DXG_TRACE("New gpadl %d", dxgalloc->gpadl);
+#endif
 
 	command_vgpu_to_host_init2(&set_store_command->hdr,
 				   DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
@@ -1501,6 +1620,92 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
+		       u64 fence_gpu_va, u8 *va)
+{
+	args->info.periodic_monitored_fence.fence_gpu_virtual_address =
+	    fence_gpu_va;
+	args->info.periodic_monitored_fence.fence_cpu_virtual_address = va;
+}
+
+int
+dxgvmb_send_create_sync_object(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_createsynchronizationobject2 *args,
+			       struct dxgsyncobject *syncobj)
+{
+	struct dxgkvmb_command_createsyncobject_return result = { };
+	struct dxgkvmb_command_createsyncobject *command;
+	int ret;
+	u8 *va = 0;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATESYNCOBJECT,
+				   process->host_handle);
+	command->args = *args;
+	command->client_hint = 1;	/* CLIENTHINT_UMD */
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	if (ret < 0) {
+		DXG_ERR("failed %d", ret);
+		goto cleanup;
+	}
+	args->sync_object = result.sync_object;
+	if (syncobj->shared) {
+		if (result.global_sync_object.v == 0) {
+			DXG_ERR("shared handle is 0");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		args->info.shared_handle = result.global_sync_object;
+	}
+
+	if (syncobj->monitored_fence) {
+		va = dxg_map_iospace(result.fence_storage_address, PAGE_SIZE,
+				     PROT_READ | PROT_WRITE, true);
+		if (va == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		if (args->info.type == _D3DDDI_MONITORED_FENCE) {
+			args->info.monitored_fence.fence_gpu_virtual_address =
+			    result.fence_gpu_va;
+			args->info.monitored_fence.fence_cpu_virtual_address =
+			    va;
+			{
+				unsigned long value;
+
+				DXG_TRACE("fence cpu va: %p", va);
+				ret = copy_from_user(&value, va,
+						     sizeof(u64));
+				if (ret) {
+					DXG_ERR("failed to read fence");
+					ret = -EINVAL;
+				} else {
+					DXG_TRACE("fence value:%lx",
+						value);
+				}
+			}
+		} else {
+			set_result(args, result.fence_gpu_va, va);
+		}
+		syncobj->mapped_address = va;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 4b7466d1b9f2..bbf5f31cdf81 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -410,4 +410,24 @@ struct dxgkvmb_command_destroycontext {
 	struct d3dkmthandle	context;
 };
 
+struct dxgkvmb_command_createsyncobject {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createsynchronizationobject2 args;
+	u32				client_hint;
+};
+
+struct dxgkvmb_command_createsyncobject_return {
+	struct d3dkmthandle	sync_object;
+	struct d3dkmthandle	global_sync_object;
+	u64			fence_gpu_va;
+	u64			fence_storage_address;
+	u32			fence_storage_offset;
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroysyncobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle	sync_object;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 0eaa577d7ed4..4bba1e209f33 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1341,6 +1341,132 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_create_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_createsynchronizationobject2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgsyncobject *syncobj = NULL;
+	bool device_lock_acquired = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0)
+		goto cleanup;
+
+	device_lock_acquired = true;
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	syncobj = dxgsyncobject_create(process, device, adapter, args.info.type,
+				       args.info.flags);
+	if (syncobj == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_create_sync_object(process, adapter, &args, syncobj);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy output args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, syncobj,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      args.sync_object);
+	if (ret >= 0)
+		syncobj->handle = args.sync_object;
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+cleanup:
+
+	if (ret < 0) {
+		if (syncobj) {
+			dxgsyncobject_destroy(process, syncobj);
+			if (args.sync_object.v)
+				dxgvmb_send_destroy_sync_object(process,
+							args.sync_object);
+		}
+	}
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device_lock_acquired)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroysynchronizationobject args;
+	struct dxgsyncobject *syncobj = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	DXG_TRACE("handle 0x%x", args.sync_object.v);
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	syncobj = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGSYNCOBJECT,
+					       args.sync_object);
+	if (syncobj) {
+		DXG_TRACE("syncobj 0x%p", syncobj);
+		syncobj->handle.v = 0;
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      args.sync_object);
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (syncobj == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgsyncobject_destroy(process, syncobj);
+
+	ret = dxgvmb_send_destroy_sync_object(process, args.sync_object);
+
+cleanup:
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static struct ioctl_desc ioctls[] = {
 /* 0x00 */	{},
 /* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
@@ -1358,7 +1484,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x0d */	{},
 /* 0x0e */	{},
 /* 0x0f */	{},
-/* 0x10 */	{},
+/* 0x10 */	{dxgkio_create_sync_object, LX_DXCREATESYNCHRONIZATIONOBJECT},
 /* 0x11 */	{},
 /* 0x12 */	{},
 /* 0x13 */	{dxgkio_destroy_allocation, LX_DXDESTROYALLOCATION2},
@@ -1371,7 +1497,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x1a */	{},
 /* 0x1b */	{},
 /* 0x1c */	{},
-/* 0x1d */	{},
+/* 0x1d */	{dxgkio_destroy_sync_object, LX_DXDESTROYSYNCHRONIZATIONOBJECT},
 /* 0x1e */	{},
 /* 0x1f */	{},
 /* 0x20 */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index cf670b9c4dc2..4e1069f41d76 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -256,6 +256,97 @@ enum d3dkmdt_standardallocationtype {
 	_D3DKMDT_STANDARDALLOCATION_GDISURFACE			= 4,
 };
 
+struct d3dddi_synchronizationobject_flags {
+	union {
+		struct {
+			__u32	shared:1;
+			__u32	nt_security_sharing:1;
+			__u32	cross_adapter:1;
+			__u32	top_of_pipeline:1;
+			__u32	no_signal:1;
+			__u32	no_wait:1;
+			__u32	no_signal_max_value_on_tdr:1;
+			__u32	no_gpu_access:1;
+			__u32	reserved:23;
+		};
+		__u32		value;
+	};
+};
+
+enum d3dddi_synchronizationobject_type {
+	_D3DDDI_SYNCHRONIZATION_MUTEX		= 1,
+	_D3DDDI_SEMAPHORE			= 2,
+	_D3DDDI_FENCE				= 3,
+	_D3DDDI_CPU_NOTIFICATION		= 4,
+	_D3DDDI_MONITORED_FENCE			= 5,
+	_D3DDDI_PERIODIC_MONITORED_FENCE	= 6,
+	_D3DDDI_SYNCHRONIZATION_TYPE_LIMIT
+};
+
+struct d3dddi_synchronizationobjectinfo2 {
+	enum d3dddi_synchronizationobject_type	type;
+	struct d3dddi_synchronizationobject_flags flags;
+	union {
+		struct {
+			__u32	initial_state;
+		} synchronization_mutex;
+
+		struct {
+			__u32			max_count;
+			__u32			initial_count;
+		} semaphore;
+
+		struct {
+			__u64		fence_value;
+		} fence;
+
+		struct {
+			__u64		event;
+		} cpu_notification;
+
+		struct {
+			__u64	initial_fence_value;
+#ifdef __KERNEL__
+			void	*fence_cpu_virtual_address;
+#else
+			__u64	*fence_cpu_virtual_address;
+#endif
+			__u64	fence_gpu_virtual_address;
+			__u32	engine_affinity;
+		} monitored_fence;
+
+		struct {
+			struct d3dkmthandle	adapter;
+			__u32			vidpn_target_id;
+			__u64			time;
+#ifdef __KERNEL__
+			void			*fence_cpu_virtual_address;
+#else
+			__u64			fence_cpu_virtual_address;
+#endif
+			__u64			fence_gpu_virtual_address;
+			__u32			engine_affinity;
+		} periodic_monitored_fence;
+
+		struct {
+			__u64	reserved[8];
+		} reserved;
+	};
+	struct d3dkmthandle			shared_handle;
+};
+
+struct d3dkmt_createsynchronizationobject2 {
+	struct d3dkmthandle				device;
+	__u32						reserved;
+	struct d3dddi_synchronizationobjectinfo2	info;
+	struct d3dkmthandle				sync_object;
+	__u32						reserved1;
+};
+
+struct d3dkmt_destroysynchronizationobject {
+	struct d3dkmthandle	sync_object;
+};
+
 enum d3dkmt_standardallocationtype {
 	_D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP	= 1,
 	_D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER	= 2,
@@ -483,6 +574,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x06, struct d3dkmt_createallocation)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXCREATESYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x10, struct d3dkmt_createsynchronizationobject2)
 #define LX_DXDESTROYALLOCATION2		\
 	_IOWR(0x47, 0x13, struct d3dkmt_destroyallocation2)
 #define LX_DXENUMADAPTERS2		\
@@ -491,6 +584,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x15, struct d3dkmt_closeadapter)
 #define LX_DXDESTROYDEVICE		\
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
+#define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 

