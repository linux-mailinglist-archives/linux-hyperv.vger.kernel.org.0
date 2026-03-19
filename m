Return-Path: <linux-hyperv+bounces-9578-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHe4Lb9bvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9578-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF6D2D20E2
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5B0B300ACAB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49823F87E2;
	Thu, 19 Mar 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJDSl3CR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F13F7E93
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951925; cv=none; b=Sw6FWKh2s5sRajBLKJjh/v27omkUOzcgqNosvby8bhBlZ0usiLMpUpdPGqC/yo1c8WNC/zFIHf9gpPFJXcwD/fbhANcgeM/4jsG0zHR74eME44zNamj3mDjHH6m1X107ELYAA7ZhsV69OlsedKdUw86T2KQFhISKT3qJl6HgCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951925; c=relaxed/simple;
	bh=BwbOvMcrpk/JeI9lLXANltPjkl3MrcAJhQ1ckdx2g+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5vKOL8FCaL2IJFp13MQmaJpgsJh9NMP8Josg7oCM+N6YtRMnpCP1agx83x/66Umpet5FZlmmax2+Y6wG7W+Q67NG0tiZmEEmomsX3KXJOmpxFIAKG8WeFpVFlUjrrmlsCts/Ul5bfmS48UCdwSBSF44EBbOPOH6a/Cj3F75yqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJDSl3CR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c6fc2910so893811f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951920; x=1774556720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFYi4vEIDiWJbzjeVpI113/KGRLf22OTGV2qcIdBQXs=;
        b=mJDSl3CRt3w1u1fXfRjqRPXU6c1TRPM3urkvJjYo2oP/b1jMlrvWgKKKUAP540N2WS
         5Bf0P1DSebRzr4TU8m3Mc3RRWykXWW4EKxz8j2dOTAtoVyFavH6EEugowITTcOR6vnbP
         hO7Olmd7tSBYezvd7yWtuolXaZ8lR8IO1cVF05yzETUFSxsU+yXSFUrvaBnyiogW4GXt
         u50/wdvZE0majc3RruOTb8cD5za1/xsgMxo5CQ1HRUjmalpQo10vZ/QQ04CU0mwLlIlC
         BZYL8XnCmE8vritmvsJlxuDXNPfJiJeZBGvkVXuW9AXHgpF6Ag07LUedHVpLJYXsyd0o
         GNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951920; x=1774556720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EFYi4vEIDiWJbzjeVpI113/KGRLf22OTGV2qcIdBQXs=;
        b=dTiumJHFWbxjUdUsVTJJB9KD3n2iVx7e0bxBO1xFOTvd1hMtvzAdmfom+BIqeDF7Wj
         WgIbTbRuFQc+VxfV5W4tp3Hj2MWPnwhuF1TXKH4BjBzHAbZt7RPqHRtiud4dGuk8WeRZ
         O6fRQjPjXIZrsy04owrLrZHv+qkuUqREIGSKDYThjDoMFPhT/VP3hkvXU8V/OiMkXeTP
         klruQM07alVm8KGQ5WhO2D3yqyAmR6UiL67rnUYVNZ/yaxy7MYp9cLGcp3lJ3FHc9Wuj
         brh2i3Go4F6gPa2PqqtxiPJ6qHGLaGd8YMfbCsjweyXhv4LfV1ZFx/2VsKZq7ZgNIxPI
         0lAw==
X-Gm-Message-State: AOJu0YyZfAprlxfi4OzGw9fQfoEfRTSgvYnW4WVF33ymtRr1/QsELtEl
	lDdwr/kqW0Mk2PInF/cTZ+FYGWhvVYe0qYp2B0Lfol4MaD3tK8AU5NDV7wZTXzUKLcM=
X-Gm-Gg: ATEYQzywiikZgnOZd1zy3YTyYJviPJDx7S3RSfU2nm939/1efSCSJHI10AG5WWbRfvU
	7smnQDI24UkfTudl5jQ5VPKYIUeOeKTVg+HEgoTqqpggKF5ZkTbo62PjgMJcrnUM+kHPbj8IUqU
	665MgYH0HopWrYz7gCDd4k9o5T90KHteJT4zh3CByx/EaGVbpSM2acsRattmBu4eZf6ksIkFVu5
	2jUbJUgS4Q3jz3bd5ll0fXQoZBE9L6jt7FeWUqnziM/YeYctOKwfeG/m1O28w0uKpp9Qv+LyC6w
	yLSv7QV7OYa0rXih9JRwf7b/r/EzVRS0nsBg99wxSfJZ/CgBFTSepBic51lECJl+LOeBN6fEOXr
	QMcpypOu41P6P6qIOAJi2LcdC3bhJvGQskWopio3GGUZi2/h+CoUBS3ZmhFRsXyg3FgTpclmVDE
	S9sKxoZiM5OgCiTzddE6b6bx8Qr4+iYrJ3wriE7gN6uo+VzhA3sxHXaV7jagg=
X-Received: by 2002:a05:6000:2f84:b0:43b:4d2e:a004 with SMTP id ffacd0b85a97d-43b64242f00mr1145615f8f.10.1773951920229;
        Thu, 19 Mar 2026 13:25:20 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:19 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 06/55] drivers: hv: dxgkrnl: Creation of dxgdevice objects
Date: Thu, 19 Mar 2026 20:24:20 +0000
Message-ID: <20260319202509.63802-7-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9578-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CF6D2D20E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls for creation and destruction of dxgdevice
objects:
 - the LX_DXCREATEDEVICE ioctl
 - the LX_DXDESTROYDEVICE ioctl

A dxgdevice object represents a container of other virtual
compute device objects (allocations, sync objects, contexts,
etc.). It belongs to a dxgadapter object.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 187 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  58 ++++++++++
 drivers/hv/dxgkrnl/dxgprocess.c |  43 ++++++++
 drivers/hv/dxgkrnl/dxgvmbus.c   |  80 ++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  22 ++++
 drivers/hv/dxgkrnl/ioctl.c      | 130 +++++++++++++++++++++-
 drivers/hv/dxgkrnl/misc.h       |   8 +-
 include/uapi/misc/d3dkmthk.h    |  82 ++++++++++++++
 8 files changed, 604 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index fa0d6beca157..a9a341716eba 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -194,6 +194,122 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
 	up_read(&adapter->core_lock);
 }
 
+struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
+				   struct dxgprocess *process)
+{
+	struct dxgdevice *device;
+	int ret;
+
+	device = kzalloc(sizeof(struct dxgdevice), GFP_KERNEL);
+	if (device) {
+		kref_init(&device->device_kref);
+		device->adapter = adapter;
+		device->process = process;
+		kref_get(&adapter->adapter_kref);
+		init_rwsem(&device->device_lock);
+		INIT_LIST_HEAD(&device->pqueue_list_head);
+		device->object_state = DXGOBJECTSTATE_CREATED;
+		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
+
+		ret = dxgprocess_adapter_add_device(process, adapter, device);
+		if (ret < 0) {
+			kref_put(&device->device_kref, dxgdevice_release);
+			device = NULL;
+		}
+	}
+	return device;
+}
+
+void dxgdevice_stop(struct dxgdevice *device)
+{
+}
+
+void dxgdevice_mark_destroyed(struct dxgdevice *device)
+{
+	down_write(&device->device_lock);
+	device->object_state = DXGOBJECTSTATE_DESTROYED;
+	up_write(&device->device_lock);
+}
+
+void dxgdevice_destroy(struct dxgdevice *device)
+{
+	struct dxgprocess *process = device->process;
+	struct dxgadapter *adapter = device->adapter;
+	struct d3dkmthandle device_handle = {};
+
+	DXG_TRACE("Destroying device: %p", device);
+
+	down_write(&device->device_lock);
+
+	if (device->object_state != DXGOBJECTSTATE_ACTIVE)
+		goto cleanup;
+
+	device->object_state = DXGOBJECTSTATE_DESTROYED;
+
+	dxgdevice_stop(device);
+
+	/* Guest handles need to be released before the host handles */
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	if (device->handle_valid) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGDEVICE, device->handle);
+		device_handle = device->handle;
+		device->handle_valid = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (device_handle.v) {
+		up_write(&device->device_lock);
+		if (dxgadapter_acquire_lock_shared(adapter) == 0) {
+			dxgvmb_send_destroy_device(adapter, process,
+						   device_handle);
+			dxgadapter_release_lock_shared(adapter);
+		}
+		down_write(&device->device_lock);
+	}
+
+cleanup:
+
+	if (device->adapter) {
+		dxgprocess_adapter_remove_device(device);
+		kref_put(&device->adapter->adapter_kref, dxgadapter_release);
+		device->adapter = NULL;
+	}
+
+	up_write(&device->device_lock);
+
+	kref_put(&device->device_kref, dxgdevice_release);
+	DXG_TRACE("Device destroyed");
+}
+
+int dxgdevice_acquire_lock_shared(struct dxgdevice *device)
+{
+	down_read(&device->device_lock);
+	if (!dxgdevice_is_active(device)) {
+		up_read(&device->device_lock);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+void dxgdevice_release_lock_shared(struct dxgdevice *device)
+{
+	up_read(&device->device_lock);
+}
+
+bool dxgdevice_is_active(struct dxgdevice *device)
+{
+	return device->object_state == DXGOBJECTSTATE_ACTIVE;
+}
+
+void dxgdevice_release(struct kref *refcount)
+{
+	struct dxgdevice *device;
+
+	device = container_of(refcount, struct dxgdevice, device_kref);
+	kfree(device);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
@@ -208,6 +324,8 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 		adapter_info->adapter = adapter;
 		adapter_info->process = process;
 		adapter_info->refcount = 1;
+		mutex_init(&adapter_info->device_list_mutex);
+		INIT_LIST_HEAD(&adapter_info->device_list_head);
 		list_add_tail(&adapter_info->process_adapter_list_entry,
 			      &process->process_adapter_list_head);
 		dxgadapter_add_process(adapter, adapter_info);
@@ -221,10 +339,34 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 
 void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info)
 {
+	struct dxgdevice *device;
+
+	mutex_lock(&adapter_info->device_list_mutex);
+	list_for_each_entry(device, &adapter_info->device_list_head,
+			    device_list_entry) {
+		dxgdevice_stop(device);
+	}
+	mutex_unlock(&adapter_info->device_list_mutex);
 }
 
 void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info)
 {
+	struct dxgdevice *device;
+
+	mutex_lock(&adapter_info->device_list_mutex);
+	while (!list_empty(&adapter_info->device_list_head)) {
+		device = list_first_entry(&adapter_info->device_list_head,
+					  struct dxgdevice, device_list_entry);
+		list_del(&device->device_list_entry);
+		device->device_list_entry.next = NULL;
+		mutex_unlock(&adapter_info->device_list_mutex);
+		dxgvmb_send_flush_device(device,
+			DXGDEVICE_FLUSHSCHEDULER_DEVICE_TERMINATE);
+		dxgdevice_destroy(device);
+		mutex_lock(&adapter_info->device_list_mutex);
+	}
+	mutex_unlock(&adapter_info->device_list_mutex);
+
 	dxgadapter_remove_process(adapter_info);
 	kref_put(&adapter_info->adapter->adapter_kref, dxgadapter_release);
 	list_del(&adapter_info->process_adapter_list_entry);
@@ -240,3 +382,48 @@ void dxgprocess_adapter_release(struct dxgprocess_adapter *adapter_info)
 	if (adapter_info->refcount == 0)
 		dxgprocess_adapter_destroy(adapter_info);
 }
+
+int dxgprocess_adapter_add_device(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct dxgdevice *device)
+{
+	struct dxgprocess_adapter *entry;
+	struct dxgprocess_adapter *adapter_info = NULL;
+	int ret = 0;
+
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &process->process_adapter_list_head,
+			    process_adapter_list_entry) {
+		if (entry->adapter == adapter) {
+			adapter_info = entry;
+			break;
+		}
+	}
+	if (adapter_info == NULL) {
+		DXG_ERR("failed to find process adapter info");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	mutex_lock(&adapter_info->device_list_mutex);
+	list_add_tail(&device->device_list_entry,
+		      &adapter_info->device_list_head);
+	device->adapter_info = adapter_info;
+	mutex_unlock(&adapter_info->device_list_mutex);
+
+cleanup:
+
+	dxgglobal_release_process_adapter_lock();
+	return ret;
+}
+
+void dxgprocess_adapter_remove_device(struct dxgdevice *device)
+{
+	DXG_TRACE("Removing device: %p", device);
+	mutex_lock(&device->adapter_info->device_list_mutex);
+	if (device->device_list_entry.next) {
+		list_del(&device->device_list_entry);
+		device->device_list_entry.next = NULL;
+	}
+	mutex_unlock(&device->adapter_info->device_list_mutex);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index b089d126f801..45ac1f25cc5e 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -34,6 +34,7 @@
 
 struct dxgprocess;
 struct dxgadapter;
+struct dxgdevice;
 
 /*
  * Driver private data.
@@ -71,6 +72,10 @@ struct dxgk_device_types {
 	u32 virtual_monitor_device:1;
 };
 
+enum dxgdevice_flushschedulerreason {
+	DXGDEVICE_FLUSHSCHEDULER_DEVICE_TERMINATE = 4,
+};
+
 enum dxgobjectstate {
 	DXGOBJECTSTATE_CREATED,
 	DXGOBJECTSTATE_ACTIVE,
@@ -166,6 +171,9 @@ struct dxgprocess_adapter {
 	struct list_head	adapter_process_list_entry;
 	/* Entry in dxgprocess::process_adapter_list_head */
 	struct list_head	process_adapter_list_entry;
+	/* List of all dxgdevice objects created for the process on adapter */
+	struct list_head	device_list_head;
+	struct mutex		device_list_mutex;
 	struct dxgadapter	*adapter;
 	struct dxgprocess	*process;
 	int			refcount;
@@ -175,6 +183,10 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter
 						     *adapter);
 void dxgprocess_adapter_release(struct dxgprocess_adapter *adapter);
+int dxgprocess_adapter_add_device(struct dxgprocess *process,
+					      struct dxgadapter *adapter,
+					      struct dxgdevice *device);
+void dxgprocess_adapter_remove_device(struct dxgdevice *device);
 void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info);
 void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info);
 
@@ -222,6 +234,11 @@ struct dxgadapter *dxgprocess_get_adapter(struct dxgprocess *process,
 					  struct d3dkmthandle handle);
 struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
 						struct d3dkmthandle handle);
+struct dxgdevice *dxgprocess_device_by_handle(struct dxgprocess *process,
+					      struct d3dkmthandle handle);
+struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
+						     enum hmgrentry_type t,
+						     struct d3dkmthandle h);
 void dxgprocess_ht_lock_shared_down(struct dxgprocess *process);
 void dxgprocess_ht_lock_shared_up(struct dxgprocess *process);
 void dxgprocess_ht_lock_exclusive_down(struct dxgprocess *process);
@@ -241,6 +258,7 @@ enum dxgadapter_state {
  * This object represents the grapchis adapter.
  * Objects, which take reference on the adapter:
  * - dxgglobal
+ * - dxgdevice
  * - adapter handle (struct d3dkmthandle)
  */
 struct dxgadapter {
@@ -277,6 +295,38 @@ void dxgadapter_add_process(struct dxgadapter *adapter,
 			    struct dxgprocess_adapter *process_info);
 void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
 
+/*
+ * The object represent the device object.
+ * The following objects take reference on the device
+ * - device handle (struct d3dkmthandle)
+ */
+struct dxgdevice {
+	enum dxgobjectstate	object_state;
+	/* Device takes reference on the adapter */
+	struct dxgadapter	*adapter;
+	struct dxgprocess_adapter *adapter_info;
+	struct dxgprocess	*process;
+	/* Entry in the DGXPROCESS_ADAPTER device list */
+	struct list_head	device_list_entry;
+	struct kref		device_kref;
+	/* Protects destcruction of the device object */
+	struct rw_semaphore	device_lock;
+	/* List of paging queues. Protected by process handle table lock. */
+	struct list_head	pqueue_list_head;
+	struct d3dkmthandle	handle;
+	enum d3dkmt_deviceexecution_state execution_state;
+	u32			handle_valid;
+};
+
+struct dxgdevice *dxgdevice_create(struct dxgadapter *a, struct dxgprocess *p);
+void dxgdevice_destroy(struct dxgdevice *device);
+void dxgdevice_stop(struct dxgdevice *device);
+void dxgdevice_mark_destroyed(struct dxgdevice *device);
+int dxgdevice_acquire_lock_shared(struct dxgdevice *dev);
+void dxgdevice_release_lock_shared(struct dxgdevice *dev);
+void dxgdevice_release(struct kref *refcount);
+bool dxgdevice_is_active(struct dxgdevice *dev);
+
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 
@@ -313,6 +363,14 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process);
 int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
+struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
+					      struct dxgprocess *process,
+					      struct d3dkmt_createdevice *args);
+int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
+			       struct dxgprocess *process,
+			       struct d3dkmthandle h);
+int dxgvmb_send_flush_device(struct dxgdevice *device,
+			     enum dxgdevice_flushschedulerreason reason);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index ab9a01e3c8c8..8373f681e822 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -241,6 +241,49 @@ struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
 	return adapter;
 }
 
+struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
+						     enum hmgrentry_type t,
+						     struct d3dkmthandle handle)
+{
+	struct dxgdevice *device = NULL;
+	void *obj;
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	obj = hmgrtable_get_object_by_type(&process->handle_table, t, handle);
+	if (obj) {
+		struct d3dkmthandle device_handle = {};
+
+		switch (t) {
+		case HMGRENTRY_TYPE_DXGDEVICE:
+			device = obj;
+			break;
+		default:
+			DXG_ERR("invalid handle type: %d", t);
+			break;
+		}
+		if (device == NULL)
+			device = hmgrtable_get_object_by_type(
+					&process->handle_table,
+					 HMGRENTRY_TYPE_DXGDEVICE,
+					 device_handle);
+		if (device)
+			if (kref_get_unless_zero(&device->device_kref) == 0)
+				device = NULL;
+	}
+	if (device == NULL)
+		DXG_ERR("device_by_handle failed: %d %x", t, handle.v);
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+	return device;
+}
+
+struct dxgdevice *dxgprocess_device_by_handle(struct dxgprocess *process,
+					      struct d3dkmthandle handle)
+{
+	return dxgprocess_device_by_object_handle(process,
+						  HMGRENTRY_TYPE_DXGDEVICE,
+						  handle);
+}
+
 void dxgprocess_ht_lock_shared_down(struct dxgprocess *process)
 {
 	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 0abf45d0d3f7..73804d11ec49 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -673,6 +673,86 @@ int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
 	return ret;
 }
 
+struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
+					struct dxgprocess *process,
+					struct d3dkmt_createdevice *args)
+{
+	int ret;
+	struct dxgkvmb_command_createdevice *command;
+	struct dxgkvmb_command_createdevice_return result = { };
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_CREATEDEVICE,
+				   process->host_handle);
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		result.device.v = 0;
+	free_message(&msg, process);
+cleanup:
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return result.device;
+}
+
+int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
+			       struct dxgprocess *process,
+			       struct d3dkmthandle h)
+{
+	int ret;
+	struct dxgkvmb_command_destroydevice *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_DESTROYDEVICE,
+				   process->host_handle);
+	command->device = h;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_flush_device(struct dxgdevice *device,
+			     enum dxgdevice_flushschedulerreason reason)
+{
+	int ret;
+	struct dxgkvmb_command_flushdevice *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+	struct dxgprocess *process = device->process;
+
+	ret = init_message(&msg, device->adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_FLUSHDEVICE,
+				   process->host_handle);
+	command->device = device->handle;
+	command->reason = reason;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
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
index a805a396e083..4ccf45765954 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -247,4 +247,26 @@ struct dxgkvmb_command_queryadapterinfo_return {
 	u8				private_data[1];
 };
 
+struct dxgkvmb_command_createdevice {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createdeviceflags	flags;
+	bool				cdd_device;
+	void				*error_code;
+};
+
+struct dxgkvmb_command_createdevice_return {
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_destroydevice {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_flushdevice {
+	struct dxgkvmb_command_vgpu_to_host	hdr;
+	struct d3dkmthandle			device;
+	enum dxgdevice_flushschedulerreason	reason;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index b08ea9430093..405e8b92913e 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -424,10 +424,136 @@ dxgkio_query_adapter_info(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createdevice args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct d3dkmthandle host_device_handle = {};
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/* The call acquires reference on the adapter */
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgdevice_create(adapter, process);
+	if (device == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0)
+		goto cleanup;
+
+	adapter_locked = true;
+
+	host_device_handle = dxgvmb_send_create_device(adapter, process, &args);
+	if (host_device_handle.v) {
+		ret = copy_to_user(&((struct d3dkmt_createdevice *)inargs)->
+				   device, &host_device_handle,
+				   sizeof(struct d3dkmthandle));
+		if (ret) {
+			DXG_ERR("failed to copy device handle");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, device,
+					      HMGRENTRY_TYPE_DXGDEVICE,
+					      host_device_handle);
+		if (ret >= 0) {
+			device->handle = host_device_handle;
+			device->handle_valid = 1;
+			device->object_state = DXGOBJECTSTATE_ACTIVE;
+		}
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_device_handle.v)
+			dxgvmb_send_destroy_device(adapter, process,
+						   host_device_handle);
+		if (device)
+			dxgdevice_destroy(device);
+	}
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_destroy_device(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroydevice args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	device = hmgrtable_get_object_by_type(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGDEVICE,
+					      args.device);
+	if (device) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGDEVICE, args.device);
+		device->handle_valid = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (device == NULL) {
+		DXG_ERR("invalid device handle: %x", args.device.v);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+
+	dxgdevice_destroy(device);
+
+	if (dxgadapter_acquire_lock_shared(adapter) == 0) {
+		dxgvmb_send_destroy_device(adapter, process, args.device);
+		dxgadapter_release_lock_shared(adapter);
+	}
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
-/* 0x02 */	{},
+/* 0x02 */	{dxgkio_create_device, LX_DXCREATEDEVICE},
 /* 0x03 */	{},
 /* 0x04 */	{},
 /* 0x05 */	{},
@@ -450,7 +576,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x16 */	{},
 /* 0x17 */	{},
 /* 0x18 */	{},
-/* 0x19 */	{},
+/* 0x19 */	{dxgkio_destroy_device, LX_DXDESTROYDEVICE},
 /* 0x1a */	{},
 /* 0x1b */	{},
 /* 0x1c */	{},
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index dc849a8ed3f2..e0bd33b365b0 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -27,10 +27,10 @@ extern const struct d3dkmthandle zerohandle;
  *
  * channel_lock (VMBus channel lock)
  * fd_mutex
- * plistmutex
- * table_lock
- * core_lock
- * device_lock
+ * plistmutex (process list mutex)
+ * table_lock (handle table lock)
+ * core_lock (dxgadapter lock)
+ * device_lock (dxgdevice lock)
  * process_adapter_mutex
  * adapter_list_lock
  * device_mutex (dxgglobal mutex)
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index c675d5827ed5..7414f0f5ce8e 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -86,6 +86,74 @@ struct d3dkmt_openadapterfromluid {
 	struct d3dkmthandle		adapter_handle;
 };
 
+struct d3dddi_allocationlist {
+	struct d3dkmthandle		allocation;
+	union {
+		struct {
+			__u32		write_operation		:1;
+			__u32		do_not_retire_instance	:1;
+			__u32		offer_priority		:3;
+			__u32		reserved		:27;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dddi_patchlocationlist {
+	__u32				allocation_index;
+	union {
+		struct {
+			__u32		slot_id:24;
+			__u32		reserved:8;
+		};
+		__u32			value;
+	};
+	__u32				driver_id;
+	__u32				allocation_offset;
+	__u32				patch_offset;
+	__u32				split_offset;
+};
+
+struct d3dkmt_createdeviceflags {
+	__u32				legacy_mode:1;
+	__u32				request_vSync:1;
+	__u32				disable_gpu_timeout:1;
+	__u32				gdi_device:1;
+	__u32				reserved:28;
+};
+
+struct d3dkmt_createdevice {
+	struct d3dkmthandle		adapter;
+	__u32				reserved3;
+	struct d3dkmt_createdeviceflags	flags;
+	struct d3dkmthandle		device;
+#ifdef __KERNEL__
+	void				*command_buffer;
+#else
+	__u64				command_buffer;
+#endif
+	__u32				command_buffer_size;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dddi_allocationlist	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_list_size;
+	__u32				reserved1;
+#ifdef __KERNEL__
+	struct d3dddi_patchlocationlist	*patch_location_list;
+#else
+	__u64				patch_location_list;
+#endif
+	__u32				patch_location_list_size;
+	__u32				reserved2;
+};
+
+struct d3dkmt_destroydevice {
+	struct d3dkmthandle		device;
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -125,6 +193,16 @@ struct d3dkmt_queryadapterinfo {
 	__u32				private_data_size;
 };
 
+enum d3dkmt_deviceexecution_state {
+	_D3DKMT_DEVICEEXECUTION_ACTIVE			= 1,
+	_D3DKMT_DEVICEEXECUTION_RESET			= 2,
+	_D3DKMT_DEVICEEXECUTION_HUNG			= 3,
+	_D3DKMT_DEVICEEXECUTION_STOPPED			= 4,
+	_D3DKMT_DEVICEEXECUTION_ERROR_OUTOFMEMORY	= 5,
+	_D3DKMT_DEVICEEXECUTION_ERROR_DMAFAULT		= 6,
+	_D3DKMT_DEVICEEXECUTION_ERROR_DMAPAGEFAULT	= 7,
+};
+
 union d3dkmt_enumadapters_filter {
 	struct {
 		__u64	include_compute_only:1;
@@ -152,12 +230,16 @@ struct d3dkmt_enumadapters3 {
 
 #define LX_DXOPENADAPTERFROMLUID	\
 	_IOWR(0x47, 0x01, struct d3dkmt_openadapterfromluid)
+#define LX_DXCREATEDEVICE		\
+	_IOWR(0x47, 0x02, struct d3dkmt_createdevice)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXENUMADAPTERS2		\
 	_IOWR(0x47, 0x14, struct d3dkmt_enumadapters2)
 #define LX_DXCLOSEADAPTER		\
 	_IOWR(0x47, 0x15, struct d3dkmt_closeadapter)
+#define LX_DXDESTROYDEVICE		\
+	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 

