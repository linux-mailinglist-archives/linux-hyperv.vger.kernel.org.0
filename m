Return-Path: <linux-hyperv+bounces-9579-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNWuGNdbvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9579-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC12D210C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58F68302D594
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F73F8E12;
	Thu, 19 Mar 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgPDMX4H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A63F7E9F
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951927; cv=none; b=gWRV5NklyY5Iev8r/ebngo2Bem2qnj9B5Fueb3+Q+RQKOwI4aNtxzkYkgeYk3yAy7ZPVe4/2UAQQj3Z9zgyIrPjf/gZvFIonWAbkMAIAJJP4RX7+QHP+eUPd0VjP1Z7wB3jwOuRJ/0H+Ps7gwrsueHc/gDyHDXdile22JKyB6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951927; c=relaxed/simple;
	bh=6m9Fl64FQgYRCmM/OBqroPX57hoWtFkTtimspki1Gv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P66zwuteGL+KhLJUGj8E/GNMgtOrlDXepgT7kmJAIdwKfkNZ3yXfuJVy+PCKQm3Ja5G0qF+nRNgcxvWorraWTrCo2G+tmrqz0BZ+tod1dlWIlmXxD1tUuu8e3or2U15j2/8ZRJ0Kp9Z/bjsenUrTD7eTUXiRPXLSrtuYYIuQD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgPDMX4H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso11780775e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951921; x=1774556721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ows384rFvcW/0zTyYeLYh2R71jyN2NXXSfsnbCfkYBk=;
        b=jgPDMX4H12WC8AkpwT3EfwMmj9cbcVVv2WoLqI/60vBXsxHPTR+soE37O/jg5te23C
         AX2Dble5gWPrYzb9eCjRybdkhKG9TfhtwycvsCXkf6wyDNkRCt0/xrSPXDo8l2c5JfPO
         1MH4aBIC5ztso5DixCBpDjlQdLrOC8U85pGTh/9TtIemXE/DM6D9yzIe+NY364Syq/RW
         z+3j2LSGStiMsnQOT5pzzLWQq8myJtxpMjFwsjNS1XOBEG1ZSETNlHqjiBcWqId1vYFc
         /hLxaOKurFwt7BdqM4txDD2DXCSqV3KzorNJX0xjBFUZ5P9jM5qGKX91Um5zN44HSULL
         dwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951921; x=1774556721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ows384rFvcW/0zTyYeLYh2R71jyN2NXXSfsnbCfkYBk=;
        b=h8PX2CgIHGz7Z5zCW+cZC9QrIgvzojPaKRn8ZTL4SUsSltmR0+YqLWimmaDRqkJzYk
         dMXbxlNms1zP5k2YIsUp9+Bx6wQCE06HZR9YcnY0hCjEaWBXM0E9ouPcvDzmJtffutmG
         6YeebMGkwkFSHxW+Ipr0Pcg1Q7Xb5EqRbzjTgxQ+81HrKRknw5tEtwGe94LAs5C+1coc
         EkCGnNLswaBmaUclDnuylKPX/k3gov/lxPxHI6iN9X1xusJzlGzMU+xj3rtObHgwEOiu
         YWTNfLQmbDMzgjWuK3qBlEwOhT+CCvqe4QsxTnqWvLD9Mkv/Uh1UjmTaCpauEIRNTQEm
         gWKg==
X-Gm-Message-State: AOJu0YyfjR0apgYU032otYfL8ZqoQxMGymyoNovsXph054ghAxLjUb7c
	Sou/Ebpd5n5hxi6vg+DT/m+fpDG46m8/7r7uY+w2klpK+AP06HKPT22yQsDn/1JT/Z4=
X-Gm-Gg: ATEYQzy4oO7QvTPgtWUlLwmUoZYYUdxvW1RhcZ1vluJMYmfitY7MFavyzBtcC6rcCgW
	yogwM4IhGVOEBrArNTc6hrNbxCReLqwdJ1PF2UC4kZxqscZTzxr/xSmN47J+rooeLR4kc7Wj4Vf
	eLLqkWLyT4jY5FA109waZrrBZvXAswN5tvdkZ5EnqAZPXQGR9aiwZ83PL4aImGmpwlXli4kX7nw
	GkGRdlTcC/pwhhnFZxBM6RRN05VRkCEB6lzxetummVnTloXwuUARDhIjlD7QzyZFhqml9jbd+3v
	2pEACE4rXMu8a/0PgIbz4gSBRS/AvoDHIQR5enAD+OaPlUy2cVCbzBVlYLxnyP5d22pwlmrv4qY
	yNV0tbfMvzrrMRr+fh3dl1bJ2AGLbeHLpjvWE2aLMzDOiyiTzQUk0kwbVvnAmBIue79NUnva8AQ
	5hP2/uuc7/lu84p2NmaRijyHLIOxg1iHpYDIqtRrCozllaJGRV
X-Received: by 2002:a05:600c:19d4:b0:485:4278:24f0 with SMTP id 5b1f17b1804b1-486ff03d9d4mr6356905e9.30.1773951921361;
        Thu, 19 Mar 2026 13:25:21 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:20 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 07/55] drivers: hv: dxgkrnl: Creation of dxgcontext objects
Date: Thu, 19 Mar 2026 20:24:21 +0000
Message-ID: <20260319202509.63802-8-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9579-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 1FBC12D210C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls for creation/destruction of dxgcontext
objects:
  - the LX_DXCREATECONTEXTVIRTUAL ioctl
  - the LX_DXDESTROYCONTEXT ioctl.

A dxgcontext object represents a compute device execution thread.
Ccompute device DMA buffers and synchronization operations are
submitted for execution to a dxgcontext. dxgcontexts objects
belong to a dxgdevice object.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 103 ++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  38 ++++++++
 drivers/hv/dxgkrnl/dxgprocess.c |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 101 ++++++++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.h   |  18 ++++
 drivers/hv/dxgkrnl/ioctl.c      | 168 +++++++++++++++++++++++++++++++-
 drivers/hv/dxgkrnl/misc.h       |   1 +
 include/uapi/misc/d3dkmthk.h    |  47 +++++++++
 8 files changed, 477 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index a9a341716eba..cd103e092ac2 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -206,7 +206,9 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 		device->adapter = adapter;
 		device->process = process;
 		kref_get(&adapter->adapter_kref);
+		INIT_LIST_HEAD(&device->context_list_head);
 		init_rwsem(&device->device_lock);
+		init_rwsem(&device->context_list_lock);
 		INIT_LIST_HEAD(&device->pqueue_list_head);
 		device->object_state = DXGOBJECTSTATE_CREATED;
 		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
@@ -248,6 +250,20 @@ void dxgdevice_destroy(struct dxgdevice *device)
 
 	dxgdevice_stop(device);
 
+	{
+		struct dxgcontext *context;
+		struct dxgcontext *tmp;
+
+		DXG_TRACE("destroying contexts");
+		dxgdevice_acquire_context_list_lock(device);
+		list_for_each_entry_safe(context, tmp,
+					 &device->context_list_head,
+					 context_list_entry) {
+			dxgcontext_destroy(process, context);
+		}
+		dxgdevice_release_context_list_lock(device);
+	}
+
 	/* Guest handles need to be released before the host handles */
 	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
 	if (device->handle_valid) {
@@ -302,6 +318,32 @@ bool dxgdevice_is_active(struct dxgdevice *device)
 	return device->object_state == DXGOBJECTSTATE_ACTIVE;
 }
 
+void dxgdevice_acquire_context_list_lock(struct dxgdevice *device)
+{
+	down_write(&device->context_list_lock);
+}
+
+void dxgdevice_release_context_list_lock(struct dxgdevice *device)
+{
+	up_write(&device->context_list_lock);
+}
+
+void dxgdevice_add_context(struct dxgdevice *device, struct dxgcontext *context)
+{
+	down_write(&device->context_list_lock);
+	list_add_tail(&context->context_list_entry, &device->context_list_head);
+	up_write(&device->context_list_lock);
+}
+
+void dxgdevice_remove_context(struct dxgdevice *device,
+			      struct dxgcontext *context)
+{
+	if (context->context_list_entry.next) {
+		list_del(&context->context_list_entry);
+		context->context_list_entry.next = NULL;
+	}
+}
+
 void dxgdevice_release(struct kref *refcount)
 {
 	struct dxgdevice *device;
@@ -310,6 +352,67 @@ void dxgdevice_release(struct kref *refcount)
 	kfree(device);
 }
 
+struct dxgcontext *dxgcontext_create(struct dxgdevice *device)
+{
+	struct dxgcontext *context;
+
+	context = kzalloc(sizeof(struct dxgcontext), GFP_KERNEL);
+	if (context) {
+		kref_init(&context->context_kref);
+		context->device = device;
+		context->process = device->process;
+		context->device_handle = device->handle;
+		kref_get(&device->device_kref);
+		INIT_LIST_HEAD(&context->hwqueue_list_head);
+		init_rwsem(&context->hwqueue_list_lock);
+		dxgdevice_add_context(device, context);
+		context->object_state = DXGOBJECTSTATE_ACTIVE;
+	}
+	return context;
+}
+
+/*
+ * Called when the device context list lock is held
+ */
+void dxgcontext_destroy(struct dxgprocess *process, struct dxgcontext *context)
+{
+	DXG_TRACE("Destroying context %p", context);
+	context->object_state = DXGOBJECTSTATE_DESTROYED;
+	if (context->device) {
+		if (context->handle.v) {
+			hmgrtable_free_handle_safe(&process->handle_table,
+						   HMGRENTRY_TYPE_DXGCONTEXT,
+						   context->handle);
+		}
+		dxgdevice_remove_context(context->device, context);
+		kref_put(&context->device->device_kref, dxgdevice_release);
+	}
+	kref_put(&context->context_kref, dxgcontext_release);
+}
+
+void dxgcontext_destroy_safe(struct dxgprocess *process,
+			     struct dxgcontext *context)
+{
+	struct dxgdevice *device = context->device;
+
+	dxgdevice_acquire_context_list_lock(device);
+	dxgcontext_destroy(process, context);
+	dxgdevice_release_context_list_lock(device);
+}
+
+bool dxgcontext_is_active(struct dxgcontext *context)
+{
+	return context->object_state == DXGOBJECTSTATE_ACTIVE;
+}
+
+void dxgcontext_release(struct kref *refcount)
+{
+	struct dxgcontext *context;
+
+	context = container_of(refcount, struct dxgcontext, context_kref);
+	kfree(context);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 45ac1f25cc5e..a3d8d3c9f37d 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -35,6 +35,7 @@
 struct dxgprocess;
 struct dxgadapter;
 struct dxgdevice;
+struct dxgcontext;
 
 /*
  * Driver private data.
@@ -298,6 +299,7 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
 /*
  * The object represent the device object.
  * The following objects take reference on the device
+ * - dxgcontext
  * - device handle (struct d3dkmthandle)
  */
 struct dxgdevice {
@@ -311,6 +313,8 @@ struct dxgdevice {
 	struct kref		device_kref;
 	/* Protects destcruction of the device object */
 	struct rw_semaphore	device_lock;
+	struct rw_semaphore	context_list_lock;
+	struct list_head	context_list_head;
 	/* List of paging queues. Protected by process handle table lock. */
 	struct list_head	pqueue_list_head;
 	struct d3dkmthandle	handle;
@@ -325,7 +329,33 @@ void dxgdevice_mark_destroyed(struct dxgdevice *device);
 int dxgdevice_acquire_lock_shared(struct dxgdevice *dev);
 void dxgdevice_release_lock_shared(struct dxgdevice *dev);
 void dxgdevice_release(struct kref *refcount);
+void dxgdevice_add_context(struct dxgdevice *dev, struct dxgcontext *ctx);
+void dxgdevice_remove_context(struct dxgdevice *dev, struct dxgcontext *ctx);
 bool dxgdevice_is_active(struct dxgdevice *dev);
+void dxgdevice_acquire_context_list_lock(struct dxgdevice *dev);
+void dxgdevice_release_context_list_lock(struct dxgdevice *dev);
+
+/*
+ * The object represent the execution context of a device.
+ */
+struct dxgcontext {
+	enum dxgobjectstate	object_state;
+	struct dxgdevice	*device;
+	struct dxgprocess	*process;
+	/* entry in the device context list */
+	struct list_head	context_list_entry;
+	struct list_head	hwqueue_list_head;
+	struct rw_semaphore	hwqueue_list_lock;
+	struct kref		context_kref;
+	struct d3dkmthandle	handle;
+	struct d3dkmthandle	device_handle;
+};
+
+struct dxgcontext *dxgcontext_create(struct dxgdevice *dev);
+void dxgcontext_destroy(struct dxgprocess *pr, struct dxgcontext *ctx);
+void dxgcontext_destroy_safe(struct dxgprocess *pr, struct dxgcontext *ctx);
+void dxgcontext_release(struct kref *refcount);
+bool dxgcontext_is_active(struct dxgcontext *ctx);
 
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
@@ -371,6 +401,14 @@ int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
 			       struct d3dkmthandle h);
 int dxgvmb_send_flush_device(struct dxgdevice *device,
 			     enum dxgdevice_flushschedulerreason reason);
+struct d3dkmthandle
+dxgvmb_send_create_context(struct dxgadapter *adapter,
+			   struct dxgprocess *process,
+			   struct d3dkmt_createcontextvirtual
+			   *args);
+int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
+				struct dxgprocess *process,
+				struct d3dkmthandle h);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 8373f681e822..ca307beb9a9a 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -257,6 +257,10 @@ struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
 		case HMGRENTRY_TYPE_DXGDEVICE:
 			device = obj;
 			break;
+		case HMGRENTRY_TYPE_DXGCONTEXT:
+			device_handle =
+			    ((struct dxgcontext *)obj)->device_handle;
+			break;
 		default:
 			DXG_ERR("invalid handle type: %d", t);
 			break;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 73804d11ec49..e66aac7c13cb 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -731,7 +731,7 @@ int dxgvmb_send_flush_device(struct dxgdevice *device,
 			     enum dxgdevice_flushschedulerreason reason)
 {
 	int ret;
-	struct dxgkvmb_command_flushdevice *command;
+	struct dxgkvmb_command_flushdevice *command = NULL;
 	struct dxgvmbusmsg msg = {.hdr = NULL};
 	struct dxgprocess *process = device->process;
 
@@ -745,6 +745,105 @@ int dxgvmb_send_flush_device(struct dxgdevice *device,
 	command->device = device->handle;
 	command->reason = reason;
 
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
+struct d3dkmthandle
+dxgvmb_send_create_context(struct dxgadapter *adapter,
+			   struct dxgprocess *process,
+			   struct d3dkmt_createcontextvirtual *args)
+{
+	struct dxgkvmb_command_createcontextvirtual *command = NULL;
+	u32 cmd_size;
+	int ret;
+	struct d3dkmthandle context = {};
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("PrivateDriverDataSize is invalid");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	cmd_size = sizeof(struct dxgkvmb_command_createcontextvirtual) +
+	    args->priv_drv_data_size - 1;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATECONTEXTVIRTUAL,
+				   process->host_handle);
+	command->device = args->device;
+	command->node_ordinal = args->node_ordinal;
+	command->engine_affinity = args->engine_affinity;
+	command->flags = args->flags;
+	command->client_hint = args->client_hint;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user(command->priv_drv_data,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			DXG_ERR("Faled to copy private data");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+	/* Input command is returned back as output */
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   command, cmd_size);
+	if (ret < 0) {
+		goto cleanup;
+	} else {
+		context = command->context;
+		if (args->priv_drv_data_size) {
+			ret = copy_to_user(args->priv_drv_data,
+					   command->priv_drv_data,
+					   args->priv_drv_data_size);
+			if (ret) {
+				dev_err(DXGDEV,
+					"Faled to copy private data to user");
+				ret = -EINVAL;
+				dxgvmb_send_destroy_context(adapter, process,
+							    context);
+				context.v = 0;
+			}
+		}
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return context;
+}
+
+int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
+				struct dxgprocess *process,
+				struct d3dkmthandle h)
+{
+	int ret;
+	struct dxgkvmb_command_destroycontext *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_DESTROYCONTEXT,
+				   process->host_handle);
+	command->context = h;
+
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
 	free_message(&msg, process);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 4ccf45765954..ebcb7b0f62c1 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -269,4 +269,22 @@ struct dxgkvmb_command_flushdevice {
 	enum dxgdevice_flushschedulerreason	reason;
 };
 
+struct dxgkvmb_command_createcontextvirtual {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	struct d3dkmthandle		device;
+	u32				node_ordinal;
+	u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+	enum d3dkmt_clienthint		client_hint;
+	u32				priv_drv_data_size;
+	u8				priv_drv_data[1];
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroycontext {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle	context;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 405e8b92913e..5d10ebd2ce6a 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -550,13 +550,177 @@ dxgkio_destroy_device(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_create_context_virtual(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createcontextvirtual args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgcontext *context = NULL;
+	struct d3dkmthandle host_context_handle = {};
+	bool device_lock_acquired = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
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
+	context = dxgcontext_create(device);
+	if (context == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	host_context_handle = dxgvmb_send_create_context(adapter,
+							 process, &args);
+	if (host_context_handle.v) {
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, context,
+					      HMGRENTRY_TYPE_DXGCONTEXT,
+					      host_context_handle);
+		if (ret >= 0)
+			context->handle = host_context_handle;
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+		if (ret < 0)
+			goto cleanup;
+		ret = copy_to_user(&((struct d3dkmt_createcontextvirtual *)
+				   inargs)->context, &host_context_handle,
+				   sizeof(struct d3dkmthandle));
+		if (ret) {
+			DXG_ERR("failed to copy context handle");
+			ret = -EINVAL;
+		}
+	} else {
+		DXG_ERR("invalid host handle");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_context_handle.v) {
+			dxgvmb_send_destroy_context(adapter, process,
+						    host_context_handle);
+		}
+		if (context)
+			dxgcontext_destroy_safe(process, context);
+	}
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device) {
+		if (device_lock_acquired)
+			dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_destroy_context(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroycontext args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgcontext *context = NULL;
+	struct dxgdevice *device = NULL;
+	struct d3dkmthandle device_handle = {};
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	context = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGCONTEXT,
+					       args.context);
+	if (context) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGCONTEXT, args.context);
+		context->handle.v = 0;
+		device_handle = context->device_handle;
+		context->object_state = DXGOBJECTSTATE_DESTROYED;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (context == NULL) {
+		DXG_ERR("invalid context handle: %x", args.context.v);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	device = dxgprocess_device_by_handle(process, device_handle);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_destroy_context(adapter, process, args.context);
+
+	dxgcontext_destroy_safe(process, context);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	DXG_TRACE("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static struct ioctl_desc ioctls[] = {
 /* 0x00 */	{},
 /* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
 /* 0x02 */	{dxgkio_create_device, LX_DXCREATEDEVICE},
 /* 0x03 */	{},
-/* 0x04 */	{},
-/* 0x05 */	{},
+/* 0x04 */	{dxgkio_create_context_virtual, LX_DXCREATECONTEXTVIRTUAL},
+/* 0x05 */	{dxgkio_destroy_context, LX_DXDESTROYCONTEXT},
 /* 0x06 */	{},
 /* 0x07 */	{},
 /* 0x08 */	{},
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index e0bd33b365b0..3a9637f0b5e2 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -29,6 +29,7 @@ extern const struct d3dkmthandle zerohandle;
  * fd_mutex
  * plistmutex (process list mutex)
  * table_lock (handle table lock)
+ * context_list_lock
  * core_lock (dxgadapter lock)
  * device_lock (dxgdevice lock)
  * process_adapter_mutex
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 7414f0f5ce8e..4ba0070b061f 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -154,6 +154,49 @@ struct d3dkmt_destroydevice {
 	struct d3dkmthandle		device;
 };
 
+enum d3dkmt_clienthint {
+	_D3DKMT_CLIENTHNT_UNKNOWN	= 0,
+	_D3DKMT_CLIENTHINT_OPENGL	= 1,
+	_D3DKMT_CLIENTHINT_CDD		= 2,
+	_D3DKMT_CLIENTHINT_DX7		= 7,
+	_D3DKMT_CLIENTHINT_DX8		= 8,
+	_D3DKMT_CLIENTHINT_DX9		= 9,
+	_D3DKMT_CLIENTHINT_DX10		= 10,
+};
+
+struct d3dddi_createcontextflags {
+	union {
+		struct {
+			__u32		null_rendering:1;
+			__u32		initial_data:1;
+			__u32		disable_gpu_timeout:1;
+			__u32		synchronization_only:1;
+			__u32		hw_queue_supported:1;
+			__u32		reserved:27;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_destroycontext {
+	struct d3dkmthandle		context;
+};
+
+struct d3dkmt_createcontextvirtual {
+	struct d3dkmthandle		device;
+	__u32				node_ordinal;
+	__u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+	enum d3dkmt_clienthint		client_hint;
+	struct d3dkmthandle		context;
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -232,6 +275,10 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x01, struct d3dkmt_openadapterfromluid)
 #define LX_DXCREATEDEVICE		\
 	_IOWR(0x47, 0x02, struct d3dkmt_createdevice)
+#define LX_DXCREATECONTEXTVIRTUAL	\
+	_IOWR(0x47, 0x04, struct d3dkmt_createcontextvirtual)
+#define LX_DXDESTROYCONTEXT		\
+	_IOWR(0x47, 0x05, struct d3dkmt_destroycontext)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXENUMADAPTERS2		\

