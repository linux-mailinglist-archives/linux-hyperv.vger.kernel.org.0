Return-Path: <linux-hyperv+bounces-9605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BCeACJdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9605-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:31:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC782D22B9
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AE4303B150
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297D3FEB1B;
	Thu, 19 Mar 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOPTdAuT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C693FD135
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951959; cv=none; b=M4uDQQFjFvc47uNTvuikKj1vlzfCPrsF7eCWni6MRuq8yvwnL+9LEbBB7FAo7uG24J5slc2Es+3V91pEFx1KYE8lh5b+BEkTZ7Vj4Wj9xuzPhYd3FOUkLfpaPN7kvhiOPA0YPnp8RrtwGnrr7QIVCdGmM//4eXK1BEfFMVXNqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951959; c=relaxed/simple;
	bh=uKmGbF8rvOyRqcvPuqwiscaTDoUHnF8QP9h0iffHXoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMdt3+lVUc/7Be8wfEgm74CRiWXL77aL87cT51RClAqjJn2dUhepO3nfWVy7MIwgNAXoYVlF7AS3JMc3VWcj5lLURJnTEtRsF8Liz2C96MByEHgOd98zDZO5vvb52K+OcnZ9LBi0U2qYW/EMWd5D72kcJnu2Zaotk3pF7Dapubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOPTdAuT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b7c2788dso776186f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951951; x=1774556751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VNqCL1U0CSB7nYmpRQ+tYoJD+LmgwpsnfIU7ZhvbLU=;
        b=XOPTdAuT07Iie5UCIJun/NM8WiMhgjPSRW1e9cptlUOgiP8Jf/db5tqdcNCV8GxE1H
         MaQ0ATr5vp9wrSI2IbClMlb9qv088iPEsJRyGnb9oYz32vJ0CUJwms/7zvV7Btr3ll+H
         qJdLuf6JD8TQCRMeSLTi1qnLnD6+Uy50h/99viFqquqs7g32QYM/V+E6TFiGOJ/00GXg
         evfG5i0x3zded3BqyLwa8J9lwyOSY2NWc56yfTXVEt0TNeNUmmNF9pWkuCvBPBei9Fy5
         230oQWQjEdTIubn/2/pxvGbcGQbtpfC5xymgL/hyqIqfON2uqf71XcEGUr/ofonJE3Qs
         nrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951951; x=1774556751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VNqCL1U0CSB7nYmpRQ+tYoJD+LmgwpsnfIU7ZhvbLU=;
        b=U2lHfKy4IoIMyupMReRkBKeV2I0l8Eo0GKlxzj1wuDIQ5AGws1pkTKAJxnoSLn8z0O
         M+XbNu/P2Lffue1ujW+jwG/I2sBgyqgGaIzwTqpeNMkiX01eIRkERRJ2kiJBzRSDC69x
         Lh2Fl0JMM0nh1UfcUDZy/0rEof/eSASSpVoTbFmct/6IbxY6nAWcRTNbPs6iiJD58WfS
         6JfGlPOBUkOAjKc+FeY9+QGXN00UW3ZZicHsZS0T4q6c9c8aDZwY34lEU3qHYWUiclo0
         7TZENCHLfTKA1ZHiHwhGPrt2x30HLAqJVJIDo5iIrc7Cq6pPy2hHz30WzLrMCpkS6MyB
         SkNw==
X-Gm-Message-State: AOJu0YyzVHwOJVHBTBfIUt2bJh6ReslscTmA7HT8ToZRrXJG9qt1a+v4
	Rx/3lVAtpA5WPTYApb/nff26o2aFWeVQ7e00EQ4GmLNNZ1pCK8kN0noZFo2Cjwy6ptg=
X-Gm-Gg: ATEYQzztOvcr2tl1LA/s9QzNsq6zMvXU5dCFINgpZNfjPlDRsmTp0BfeYUYaCp51hmr
	0Em/iSMhkszC/G9nh9njoMa2Mt51cLzHD+i3V0e0gOFL/AxfQ4F59kWv5lqrPu2TnvGTVfDfBFL
	u43NJvRVTA1xGuD73RLFEUG+hHdMjmnAFmQUPoBjPPNIJ5LkVbQo6xAKBwijRQguS/Q+vDTh7vQ
	6CdoEqNC3a8A0NG3EeytkOBfq9EqbUxC1VI01+ssgY/VyfYHlliIpD0nw7xgbEELnbaEKHM/ZNl
	DOV//ti5McvVGUisBdPnpktZsnc1egcBJXaoH1DDiD8q30vqmV9z0v0FEs6laBCbKzCQim7XG3q
	0XGYsfxu5LCcbiNVOVJDAGLJ8WIlNk77lulRZ4TKBfiK49I6DpN0eyOYp7qVgfQxU8/2uBNqWyD
	gIOPGwLXqezvMCQV6wEThTqAzyfO2aapTodaorNRdNylHPDNzp
X-Received: by 2002:a05:6000:2c0e:b0:43b:410d:c4b2 with SMTP id ffacd0b85a97d-43b6427d238mr1196798f8f.29.1773951951175;
        Thu, 19 Mar 2026 13:25:51 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:50 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 33/55] drivers: hv: dxgkrnl: Implement D3DKMTWaitSyncFile
Date: Thu, 19 Mar 2026 20:24:47 +0000
Message-ID: <20260319202509.63802-34-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9605-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 6DC782D22B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h     |  11 ++
 drivers/hv/dxgkrnl/dxgmodule.c   |   7 +-
 drivers/hv/dxgkrnl/dxgprocess.c  |  12 +-
 drivers/hv/dxgkrnl/dxgsyncfile.c | 291 ++++++++++++++++++++++++++++++-
 drivers/hv/dxgkrnl/dxgsyncfile.h |   3 +
 drivers/hv/dxgkrnl/dxgvmbus.c    |  49 ++++++
 drivers/hv/dxgkrnl/ioctl.c       |  16 +-
 include/uapi/misc/d3dkmthk.h     |  23 +++
 8 files changed, 396 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 3a69e3b34e1c..d92e1348ccfb 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -254,6 +254,10 @@ void dxgsharedsyncobj_add_syncobj(struct dxgsharedsyncobject *sharedsyncobj,
 				  struct dxgsyncobject *syncobj);
 void dxgsharedsyncobj_remove_syncobj(struct dxgsharedsyncobject *sharedsyncobj,
 				     struct dxgsyncobject *syncobj);
+int dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
+					struct dxgprocess *process,
+					struct d3dkmthandle objecthandle);
+void dxgsharedsyncobj_put(struct dxgsharedsyncobject *syncobj);
 
 struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
 					   struct dxgdevice *device,
@@ -384,6 +388,8 @@ struct dxgprocess {
 	pid_t			tgid;
 	/* how many time the process was opened */
 	struct kref		process_kref;
+	/* protects the object memory */
+	struct kref		process_mem_kref;
 	/*
 	 * This handle table is used for all objects except dxgadapter
 	 * The handle table lock order is higher than the local_handle_table
@@ -405,6 +411,7 @@ struct dxgprocess {
 struct dxgprocess *dxgprocess_create(void);
 void dxgprocess_destroy(struct dxgprocess *process);
 void dxgprocess_release(struct kref *refcount);
+void dxgprocess_mem_release(struct kref *refcount);
 int dxgprocess_open_adapter(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmthandle *handle);
@@ -932,6 +939,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct d3dkmt_opensyncobjectfromnthandle2
 				    *args,
 				    struct dxgsyncobject *syncobj);
+int dxgvmb_send_open_sync_object(struct dxgprocess *process,
+				struct d3dkmthandle device,
+				struct d3dkmthandle host_shared_syncobj,
+				struct d3dkmthandle *syncobj);
 int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 08feae97e845..5570f35954d4 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -149,10 +149,11 @@ void dxgglobal_remove_host_event(struct dxghostevent *event)
 	spin_unlock_irq(&dxgglobal->host_event_list_mutex);
 }
 
-static void signal_dma_fence(struct dxghostevent *eventhdr)
+static void dxg_signal_dma_fence(struct dxghostevent *eventhdr)
 {
 	struct dxgsyncpoint *event = (struct dxgsyncpoint *)eventhdr;
 
+	DXG_TRACE("syncpoint: %px, fence: %lld", event, event->fence_value);
 	event->fence_value++;
 	list_del(&eventhdr->host_event_list_entry);
 	dma_fence_signal(&event->base);
@@ -198,7 +199,7 @@ void dxgglobal_signal_host_event(u64 event_id)
 			if (event->event_type == dxghostevent_cpu_event)
 				signal_host_cpu_event(event);
 			else if (event->event_type == dxghostevent_dma_fence)
-				signal_dma_fence(event);
+				dxg_signal_dma_fence(event);
 			else
 				DXG_ERR("Unknown host event type");
 			break;
@@ -355,6 +356,7 @@ static struct dxgprocess *dxgglobal_get_current_process(void)
 		if (entry->tgid == current->tgid) {
 			if (kref_get_unless_zero(&entry->process_kref)) {
 				process = entry;
+				kref_get(&entry->process_mem_kref);
 				DXG_TRACE("found dxgprocess");
 			} else {
 				DXG_TRACE("process is destroyed");
@@ -405,6 +407,7 @@ static int dxgk_release(struct inode *n, struct file *f)
 		return -EINVAL;
 
 	kref_put(&process->process_kref, dxgprocess_release);
+	kref_put(&process->process_mem_kref, dxgprocess_mem_release);
 
 	f->private_data = NULL;
 	return 0;
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index afef196c0588..e77e3a4983f8 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -39,6 +39,7 @@ struct dxgprocess *dxgprocess_create(void)
 		} else {
 			INIT_LIST_HEAD(&process->plistentry);
 			kref_init(&process->process_kref);
+			kref_init(&process->process_mem_kref);
 
 			mutex_lock(&dxgglobal->plistmutex);
 			list_add_tail(&process->plistentry,
@@ -117,8 +118,17 @@ void dxgprocess_release(struct kref *refcount)
 
 	dxgprocess_destroy(process);
 
-	if (process->host_handle.v)
+	if (process->host_handle.v) {
 		dxgvmb_send_destroy_process(process->host_handle);
+		process->host_handle.v = 0;
+	}
+}
+
+void dxgprocess_mem_release(struct kref *refcount)
+{
+	struct dxgprocess *process;
+
+	process = container_of(refcount, struct dxgprocess, process_mem_kref);
 	kfree(process);
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.c b/drivers/hv/dxgkrnl/dxgsyncfile.c
index 88fd78f08fbe..9d5832c90ad7 100644
--- a/drivers/hv/dxgkrnl/dxgsyncfile.c
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.c
@@ -9,6 +9,20 @@
  * Dxgkrnl Graphics Driver
  * Ioctl implementation
  *
+ * dxgsyncpoint:
+ *    - pointer to dxgsharedsyncobject
+ *    - host_shared_handle_nt_reference incremented
+ *    - list of (process, local syncobj d3dkmthandle) pairs
+ * wait for sync file
+ *    - get dxgsyncpoint
+ *    - if process doesn't have a local syncobj
+ *        - create local dxgsyncobject
+ *        - send open syncobj to the host
+ *    - Send wait for syncobj to the context
+ * dxgsyncpoint destruction
+ *    -  walk the list of (process, local syncobj)
+ *    - destroy syncobj
+ *    - remove reference to dxgsharedsyncobject
  */
 
 #include <linux/eventfd.h>
@@ -45,12 +59,15 @@ int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
 	struct d3dkmt_createsyncfile args;
 	struct dxgsyncpoint *pt = NULL;
 	int ret = 0;
-	int fd = get_unused_fd_flags(O_CLOEXEC);
+	int fd;
 	struct sync_file *sync_file = NULL;
 	struct dxgdevice *device = NULL;
 	struct dxgadapter *adapter = NULL;
+	struct dxgsyncobject *syncobj = NULL;
 	struct d3dkmt_waitforsynchronizationobjectfromcpu waitargs = {};
+	bool device_lock_acquired = false;
 
+	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		DXG_ERR("get_unused_fd_flags failed: %d", fd);
 		ret = fd;
@@ -74,9 +91,9 @@ int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
 	ret = dxgdevice_acquire_lock_shared(device);
 	if (ret < 0) {
 		DXG_ERR("dxgdevice_acquire_lock_shared failed");
-		device = NULL;
 		goto cleanup;
 	}
+	device_lock_acquired = true;
 
 	adapter = device->adapter;
 	ret = dxgadapter_acquire_lock_shared(adapter);
@@ -109,6 +126,30 @@ int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
 	}
 	dma_fence_put(&pt->base);
 
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	syncobj = hmgrtable_get_object(&process->handle_table,
+				       args.monitored_fence);
+	if (syncobj == NULL) {
+		DXG_ERR("invalid syncobj handle %x", args.monitored_fence.v);
+		ret = -EINVAL;
+	} else {
+		if (syncobj->shared) {
+			kref_get(&syncobj->syncobj_kref);
+			pt->shared_syncobj = syncobj->shared_owner;
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (pt->shared_syncobj) {
+		ret = dxgsharedsyncobj_get_host_nt_handle(pt->shared_syncobj,
+						process,
+						args.monitored_fence);
+		if (ret)
+			pt->shared_syncobj = NULL;
+	}
+	if (ret)
+		goto cleanup;
+
 	waitargs.device = args.device;
 	waitargs.object_count = 1;
 	waitargs.objects = &args.monitored_fence;
@@ -132,10 +173,15 @@ int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
 	fd_install(fd, sync_file->file);
 
 cleanup:
+	if (syncobj && syncobj->shared)
+		kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
 	if (adapter)
 		dxgadapter_release_lock_shared(adapter);
-	if (device)
-		dxgdevice_release_lock_shared(device);
+	if (device) {
+		if (device_lock_acquired)
+			dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
 	if (ret) {
 		if (sync_file) {
 			fput(sync_file->file);
@@ -151,6 +197,228 @@ int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+int dxgkio_open_syncobj_from_syncfile(struct dxgprocess *process,
+				      void *__user inargs)
+{
+	struct d3dkmt_opensyncobjectfromsyncfile args;
+	int ret = 0;
+	struct dxgsyncpoint *pt = NULL;
+	struct dma_fence *dmafence = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgsyncobject *syncobj = NULL;
+	struct d3dddi_synchronizationobject_flags flags = { };
+	struct d3dkmt_opensyncobjectfromnthandle2 openargs = { };
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	dmafence = sync_file_get_fence(args.sync_file_handle);
+	if (dmafence == NULL) {
+		DXG_ERR("failed to get dmafence from handle: %llx",
+			args.sync_file_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	pt = to_syncpoint(dmafence);
+	if (pt->shared_syncobj == NULL) {
+		DXG_ERR("Sync object is not shared");
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
+		kref_put(&device->device_kref, dxgdevice_release);
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
+	flags.shared = 1;
+	flags.nt_security_sharing = 1;
+	syncobj = dxgsyncobject_create(process, device, adapter,
+				       _D3DDDI_MONITORED_FENCE, flags);
+	if (syncobj == NULL) {
+		DXG_ERR("failed to create sync object");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	dxgsharedsyncobj_add_syncobj(pt->shared_syncobj, syncobj);
+
+	/* Open the shared syncobj to get a local handle */
+
+	openargs.device = device->handle;
+	openargs.flags.shared = 1;
+	openargs.flags.nt_security_sharing = 1;
+	openargs.flags.no_signal = 1;
+
+	ret = dxgvmb_send_open_sync_object_nt(process,
+				&dxgglobal->channel, &openargs, syncobj);
+	if (ret) {
+		DXG_ERR("Failed to open shared syncobj on host");
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table,
+				      syncobj,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      openargs.sync_object);
+	if (ret == 0) {
+		syncobj->handle = openargs.sync_object;
+		kref_get(&syncobj->syncobj_kref);
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	args.syncobj = openargs.sync_object;
+	args.fence_value = pt->fence_value;
+	args.fence_value_cpu_va = openargs.monitored_fence.fence_value_cpu_va;
+	args.fence_value_gpu_va = openargs.monitored_fence.fence_value_gpu_va;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy output args");
+		ret = -EFAULT;
+	}
+
+cleanup:
+	if (dmafence)
+		dma_fence_put(dmafence);
+	if (ret) {
+		if (syncobj) {
+			dxgsyncobject_destroy(process, syncobj);
+			kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+		}
+	}
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device) {
+		dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+int dxgkio_wait_sync_file(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitsyncfile args;
+	struct dma_fence *dmafence = NULL;
+	int ret = 0;
+	struct dxgsyncpoint *pt = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle syncobj_handle = {};
+	bool device_lock_acquired = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	dmafence = sync_file_get_fence(args.sync_file_handle);
+	if (dmafence == NULL) {
+		DXG_ERR("failed to get dmafence from handle: %llx",
+			args.sync_file_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	pt = to_syncpoint(dmafence);
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
+	if (device == NULL) {
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
+	device_lock_acquired = true;
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		DXG_ERR("dxgadapter_acquire_lock_shared failed");
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	/* Open the shared syncobj to get a local handle */
+	if (pt->shared_syncobj == NULL) {
+		DXG_ERR("Sync object is not shared");
+		goto cleanup;
+	}
+	ret = dxgvmb_send_open_sync_object(process,
+				device->handle,
+				pt->shared_syncobj->host_shared_handle,
+				&syncobj_handle);
+	if (ret) {
+		DXG_ERR("Failed to open shared syncobj on host");
+		goto cleanup;
+	}
+
+	/* Ask the host to insert the syncobj to the context queue */
+	ret = dxgvmb_send_wait_sync_object_gpu(process, adapter,
+					       args.context, 1,
+					       &syncobj_handle,
+					       &pt->fence_value,
+					       false);
+	if (ret < 0) {
+		DXG_ERR("dxgvmb_send_wait_sync_object_cpu failed");
+		goto cleanup;
+	}
+
+	/*
+	 * Destroy the local syncobject immediately. This will not unblock
+	 * GPU waiters, but will unblock CPU waiter, which includes the sync
+	 * file itself.
+	 */
+	ret = dxgvmb_send_destroy_sync_object(process, syncobj_handle);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device) {
+		if (device_lock_acquired)
+			dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+	if (dmafence)
+		dma_fence_put(dmafence);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static const char *dxgdmafence_get_driver_name(struct dma_fence *fence)
 {
 	return "dxgkrnl";
@@ -166,11 +434,16 @@ static void dxgdmafence_release(struct dma_fence *fence)
 	struct dxgsyncpoint *syncpoint;
 
 	syncpoint = to_syncpoint(fence);
-	if (syncpoint) {
-		if (syncpoint->hdr.event_id)
-			dxgglobal_get_host_event(syncpoint->hdr.event_id);
-		kfree(syncpoint);
-	}
+	if (syncpoint == NULL)
+		return;
+
+	if (syncpoint->hdr.event_id)
+		dxgglobal_get_host_event(syncpoint->hdr.event_id);
+
+	if (syncpoint->shared_syncobj)
+		dxgsharedsyncobj_put(syncpoint->shared_syncobj);
+
+	kfree(syncpoint);
 }
 
 static bool dxgdmafence_signaled(struct dma_fence *fence)
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.h b/drivers/hv/dxgkrnl/dxgsyncfile.h
index 207ef9b30f67..292b7f718987 100644
--- a/drivers/hv/dxgkrnl/dxgsyncfile.h
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.h
@@ -17,10 +17,13 @@
 #include <linux/sync_file.h>
 
 int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs);
+int dxgkio_wait_sync_file(struct dxgprocess *process, void *__user inargs);
+int dxgkio_open_syncobj_from_syncfile(struct dxgprocess *p, void *__user args);
 
 struct dxgsyncpoint {
 	struct dxghostevent	hdr;
 	struct dma_fence	base;
+	struct dxgsharedsyncobject *shared_syncobj;
 	u64			fence_value;
 	u64			context;
 	spinlock_t		lock;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index d53d4254be63..36f4d4e84d3e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -796,6 +796,55 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_open_sync_object(struct dxgprocess *process,
+				struct d3dkmthandle device,
+				struct d3dkmthandle host_shared_syncobj,
+				struct d3dkmthandle *syncobj)
+{
+	struct dxgkvmb_command_opensyncobject *command;
+	struct dxgkvmb_command_opensyncobject_return result = { };
+	int ret;
+	struct dxgvmbusmsg msg;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_OPENSYNCOBJECT,
+				 process->host_handle);
+	command->device = device;
+	command->global_sync_object = host_shared_syncobj;
+	command->flags.shared = 1;
+	command->flags.nt_security_sharing = 1;
+	command->flags.no_signal = 1;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(&dxgglobal->channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	if (ret < 0)
+		goto cleanup;
+
+	*syncobj = result.sync_object;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
 					struct d3dkmthandle object,
 					struct d3dkmthandle *shared_handle)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 4db23cd55b24..622904d5c3a9 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -36,10 +36,8 @@ static char *errorstr(int ret)
 }
 #endif
 
-static int dxgsyncobj_release(struct inode *inode, struct file *file)
+void dxgsharedsyncobj_put(struct dxgsharedsyncobject *syncobj)
 {
-	struct dxgsharedsyncobject *syncobj = file->private_data;
-
 	DXG_TRACE("Release syncobj: %p", syncobj);
 	mutex_lock(&syncobj->fd_mutex);
 	kref_get(&syncobj->ssyncobj_kref);
@@ -56,6 +54,13 @@ static int dxgsyncobj_release(struct inode *inode, struct file *file)
 	}
 	mutex_unlock(&syncobj->fd_mutex);
 	kref_put(&syncobj->ssyncobj_kref, dxgsharedsyncobj_release);
+}
+
+static int dxgsyncobj_release(struct inode *inode, struct file *file)
+{
+	struct dxgsharedsyncobject *syncobj = file->private_data;
+
+	dxgsharedsyncobj_put(syncobj);
 	return 0;
 }
 
@@ -4478,7 +4483,7 @@ dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
-static int
+int
 dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
 				    struct dxgprocess *process,
 				    struct d3dkmthandle objecthandle)
@@ -5226,6 +5231,9 @@ static struct ioctl_desc ioctls[] = {
 /* 0x43 */	{dxgkio_query_statistics, LX_DXQUERYSTATISTICS},
 /* 0x44 */	{dxgkio_share_object_with_host, LX_DXSHAREOBJECTWITHHOST},
 /* 0x45 */	{dxgkio_create_sync_file, LX_DXCREATESYNCFILE},
+/* 0x46 */	{dxgkio_wait_sync_file, LX_DXWAITSYNCFILE},
+/* 0x46 */	{dxgkio_open_syncobj_from_syncfile,
+		 LX_DXOPENSYNCOBJECTFROMSYNCFILE},
 };
 
 /*
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index c7f168425dc7..1eaa3f038322 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1561,6 +1561,25 @@ struct d3dkmt_createsyncfile {
 	__u64			sync_file_handle;	/* out */
 };
 
+struct d3dkmt_waitsyncfile {
+	__u64			sync_file_handle;
+	struct d3dkmthandle	context;
+	__u32			reserved;
+};
+
+struct d3dkmt_opensyncobjectfromsyncfile {
+	__u64			sync_file_handle;
+	struct d3dkmthandle	device;
+	struct d3dkmthandle	syncobj;	/* out */
+	__u64			fence_value;	/* out */
+#ifdef __KERNEL__
+	void			*fence_value_cpu_va;	/* out */
+#else
+	__u64			fence_value_cpu_va;	/* out */
+#endif
+	__u64			fence_value_gpu_va;	/* out */
+};
+
 /*
  * Dxgkrnl Graphics Port Driver ioctl definitions
  *
@@ -1686,5 +1705,9 @@ struct d3dkmt_createsyncfile {
 	_IOWR(0x47, 0x44, struct d3dkmt_shareobjectwithhost)
 #define LX_DXCREATESYNCFILE	\
 	_IOWR(0x47, 0x45, struct d3dkmt_createsyncfile)
+#define LX_DXWAITSYNCFILE	\
+	_IOWR(0x47, 0x46, struct d3dkmt_waitsyncfile)
+#define LX_DXOPENSYNCOBJECTFROMSYNCFILE	\
+	_IOWR(0x47, 0x47, struct d3dkmt_opensyncobjectfromsyncfile)
 
 #endif /* _D3DKMTHK_H */

