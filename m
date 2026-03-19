Return-Path: <linux-hyperv+bounces-9584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHuGKGNcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9584-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409902D21D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7DAD31E5E20
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734E3F9F43;
	Thu, 19 Mar 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9wRChrF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B43F8E17
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951935; cv=none; b=k2sn8gAhb2fLkCQ3zckM8tNFjqDL6d/lQ1A3+R/bBuUcmSh1+7CvGqx19PGPgqf0be+atpyJ2jLvv9ypUxOZr5xzT2OBmCSTAhOL3K21AEeuTbmK7uok4RGB7iF5o1Hcfiafbr5sSUrWohakP0OPHeEdHh6IzTG2SVBnnV6/dDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951935; c=relaxed/simple;
	bh=Wyfl5HMleWSVQS2+JE3lSyv2/KjGm8u0uivL3jjSyy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKpJgUZjrC44kjGL6HOfplIKQZGvhiq76XyzTHTkU/+kx6V/dc72LL7zqtl7ueqApULj3+BdCJ6Mo7rQp7sEqN+yXXZIjG/Iv0wOmOTy6jSx+MzTF++1gg82/Q8B7NMDugUZr3EF/8fB64EsMoYdrwIBNSJ9G4tbbEKZvvPHPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9wRChrF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b40003d13so878509f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951929; x=1774556729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foecVG4NkSz3e2l7RzQJubwhPdT7oC4jV/7FgDEFmFs=;
        b=F9wRChrFjr//TotHPtk2na3IA68XdhGu8F/XMwJRFxq8pIYK2dge34b70GP1To5yaD
         j8Z9BpQKIZZiFEqp/8//l8OKzyaB+Y46ebxeLyQYtsPocaq+2CHfQLhNTrW0fMbellKC
         AFoxdoxYmM7jjJ4r7YpaV/+5NBYSgeq+cmHfSRT3jIeUO9nvEbxMgtP9oLBjgtRD3iSk
         Yhsl7+DCTyyvt90aRZ5bOsxNUTm1woXQfHSKlV9MRKhbuUg4VVZwD5ZEcLL8DxqbIDvw
         D9CGe149qpZzvnyUD1wnE7MP2Ytk/IRVHCaDn7QRDfr3fbyj0anh1s/OK0buTicd1Vcq
         cjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951929; x=1774556729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foecVG4NkSz3e2l7RzQJubwhPdT7oC4jV/7FgDEFmFs=;
        b=EosHhbUYNkE9I9I2VYl4d3wBHSwnD+CVdCtnwHakPRRJDbk3DKmsGyeNeafFg/qpo/
         +VRmLDRNR1gCRHQg7iSQJtcqrKT91nMMI9ksY6SLH4H4akeJF86cX6tGtNzqUyf0Mh59
         3gHcD61j2c3MGs5zRuZRvOXMEeB92KnpOJ7Ljnz94DKQvwIwg3T5yUWhuyFJ9DFzyvaR
         mIqBCkyFmjG+Vmh4qx4l61WiQ0UNr2R0elbZm1JxdROIEKfyYg2fBu5JWnXMIgEQ682n
         ec3X+ZwTZwgrU6oQB67rm6Jtr7hW6BLb5SjJbuB3VZCfkj6WMd3cJpC3/aq39Qh0I0gK
         n6Lw==
X-Gm-Message-State: AOJu0Yz246LGr3scV2lUcDmVQAz94AT+qMQoxEUThzf+lArBU1gkXLHt
	qYdp44AhehG5HTClO45+2ALBhSHNSRZqmiN8wIdyrrSBynKnRX1XUwq5nUAwB+XhQRw=
X-Gm-Gg: ATEYQzzohcwGVrjQgZwDNFkBA1UYtjuwJuaFsS3MLizLIjf7j73n7tR/b4e+Hzr0g2P
	qpjljK4jDy8OS/jZ3msE1gl/JlG/IBSgozreql8NMMmEhHETdErZjp3CeT3DgnBincIKC1oLVA3
	JpE8yXlAfCoh0K1dtERJ41JhxhUHfHU29s4POdnm2Y4VlP2Hc05bL+gB9FX12EcDkks2caSD9Zi
	/Ga2SKmXjCLY8RSesUCw/9Vv8hwX17brzKK8SADXFMI7iXgTK+J6IpYSaJfaJy9IDezySDYLNNJ
	ELapEgBAym2naOTijH/v7YHuNi8vWDlYrxjhTeZXsF8XT2OpWl9y275+u3uzEMK4lj1Gl5dJgeg
	WxDkx4AHa1XrM16XpquCVvJ3GVMql1XoFn9MdV7rNlyW0FRyoKYl/Bjf3BxMbgUv3rk1dupuczE
	sWgjWrcWO93UppcdL4NvHa17PT/J5BzOggzmsLThPOUbktvmngbZgwzMHUMEM=
X-Received: by 2002:a5d:584b:0:b0:43b:54c9:7d21 with SMTP id ffacd0b85a97d-43b642816c1mr1148905f8f.37.1773951928897;
        Thu, 19 Mar 2026 13:25:28 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:28 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 13/55] drivers: hv: dxgkrnl: Creation of paging queue objects.
Date: Thu, 19 Mar 2026 20:24:27 +0000
Message-ID: <20260319202509.63802-14-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9584-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 409902D21D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls for creation/destruction of the paging queue objects:
  - LX_DXCREATEPAGINGQUEUE,
  - LX_DXDESTROYPAGINGQUEUE

Paging queue objects (dxgpagingqueue) contain operations, which
handle residency of device accessible allocations. An allocation is
resident, when the device has access to it. For example, the allocation
resides in local device memory or device page tables point to system
memory which is made non-pageable.

Each paging queue has an associated monitored fence sync object, which
is used to detect when a paging operation is completed.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  89 +++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  24 ++++
 drivers/hv/dxgkrnl/dxgprocess.c |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c   |  74 +++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  17 +++
 drivers/hv/dxgkrnl/ioctl.c      | 189 +++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h    |  27 +++++
 7 files changed, 418 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index f59173f13559..410f08768bad 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -278,6 +278,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 void dxgdevice_stop(struct dxgdevice *device)
 {
 	struct dxgallocation *alloc;
+	struct dxgpagingqueue *pqueue;
 	struct dxgsyncobject *syncobj;
 
 	DXG_TRACE("Stopping device: %p", device);
@@ -288,6 +289,10 @@ void dxgdevice_stop(struct dxgdevice *device)
 	dxgdevice_release_alloc_list_lock(device);
 
 	hmgrtable_lock(&device->process->handle_table, DXGLOCK_EXCL);
+	list_for_each_entry(pqueue, &device->pqueue_list_head,
+			    pqueue_list_entry) {
+		dxgpagingqueue_stop(pqueue);
+	}
 	list_for_each_entry(syncobj, &device->syncobj_list_head,
 			    syncobj_list_entry) {
 		dxgsyncobject_stop(syncobj);
@@ -375,6 +380,17 @@ void dxgdevice_destroy(struct dxgdevice *device)
 		dxgdevice_release_context_list_lock(device);
 	}
 
+	{
+		struct dxgpagingqueue *tmp;
+		struct dxgpagingqueue *pqueue;
+
+		DXG_TRACE("destroying paging queues");
+		list_for_each_entry_safe(pqueue, tmp, &device->pqueue_list_head,
+					 pqueue_list_entry) {
+			dxgpagingqueue_destroy(pqueue);
+		}
+	}
+
 	/* Guest handles need to be released before the host handles */
 	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
 	if (device->handle_valid) {
@@ -708,6 +724,26 @@ void dxgdevice_release(struct kref *refcount)
 	kfree(device);
 }
 
+void dxgdevice_add_paging_queue(struct dxgdevice *device,
+				struct dxgpagingqueue *entry)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_add_tail(&entry->pqueue_list_entry, &device->pqueue_list_head);
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_remove_paging_queue(struct dxgpagingqueue *pqueue)
+{
+	struct dxgdevice *device = pqueue->device;
+
+	dxgdevice_acquire_alloc_list_lock(device);
+	if (pqueue->pqueue_list_entry.next) {
+		list_del(&pqueue->pqueue_list_entry);
+		pqueue->pqueue_list_entry.next = NULL;
+	}
+	dxgdevice_release_alloc_list_lock(device);
+}
+
 void dxgdevice_add_syncobj(struct dxgdevice *device,
 			   struct dxgsyncobject *syncobj)
 {
@@ -899,6 +935,59 @@ else
 	kfree(alloc);
 }
 
+struct dxgpagingqueue *dxgpagingqueue_create(struct dxgdevice *device)
+{
+	struct dxgpagingqueue *pqueue;
+
+	pqueue = kzalloc(sizeof(*pqueue), GFP_KERNEL);
+	if (pqueue) {
+		pqueue->device = device;
+		pqueue->process = device->process;
+		pqueue->device_handle = device->handle;
+		dxgdevice_add_paging_queue(device, pqueue);
+	}
+	return pqueue;
+}
+
+void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
+{
+	int ret;
+
+	if (pqueue->mapped_address) {
+		ret = dxg_unmap_iospace(pqueue->mapped_address, PAGE_SIZE);
+		DXG_TRACE("fence is unmapped %d %p",
+			ret, pqueue->mapped_address);
+		pqueue->mapped_address = NULL;
+	}
+}
+
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
+{
+	struct dxgprocess *process = pqueue->process;
+
+	DXG_TRACE("Destroying pqueue %p %x", pqueue, pqueue->handle.v);
+
+	dxgpagingqueue_stop(pqueue);
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	if (pqueue->handle.v) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+				      pqueue->handle);
+		pqueue->handle.v = 0;
+	}
+	if (pqueue->syncobj_handle.v) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_MONITOREDFENCE,
+				      pqueue->syncobj_handle);
+		pqueue->syncobj_handle.v = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (pqueue->device)
+		dxgdevice_remove_paging_queue(pqueue);
+	kfree(pqueue);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 0330352b9c06..440d1f9b8882 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -104,6 +104,16 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
 void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
 void dxgvmbuschannel_receive(void *ctx);
 
+struct dxgpagingqueue {
+	struct dxgdevice	*device;
+	struct dxgprocess	*process;
+	struct list_head	pqueue_list_entry;
+	struct d3dkmthandle	device_handle;
+	struct d3dkmthandle	handle;
+	struct d3dkmthandle	syncobj_handle;
+	void			*mapped_address;
+};
+
 /*
  * The structure describes an event, which will be signaled by
  * a message from host.
@@ -127,6 +137,10 @@ struct dxghosteventcpu {
 	bool			remove_from_list;
 };
 
+struct dxgpagingqueue *dxgpagingqueue_create(struct dxgdevice *device);
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue);
+void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue);
+
 /*
  * This is GPU synchronization object, which is used to synchronize execution
  * between GPU contextx/hardware queues or for tracking GPU execution progress.
@@ -516,6 +530,9 @@ void dxgdevice_remove_alloc_safe(struct dxgdevice *dev,
 				 struct dxgallocation *a);
 void dxgdevice_add_resource(struct dxgdevice *dev, struct dxgresource *res);
 void dxgdevice_remove_resource(struct dxgdevice *dev, struct dxgresource *res);
+void dxgdevice_add_paging_queue(struct dxgdevice *dev,
+				struct dxgpagingqueue *pqueue);
+void dxgdevice_remove_paging_queue(struct dxgpagingqueue *pqueue);
 void dxgdevice_add_syncobj(struct dxgdevice *dev, struct dxgsyncobject *so);
 void dxgdevice_remove_syncobj(struct dxgsyncobject *so);
 bool dxgdevice_is_active(struct dxgdevice *dev);
@@ -762,6 +779,13 @@ dxgvmb_send_create_context(struct dxgadapter *adapter,
 int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 				struct dxgprocess *process,
 				struct d3dkmthandle h);
+int dxgvmb_send_create_paging_queue(struct dxgprocess *pr,
+				    struct dxgdevice *dev,
+				    struct d3dkmt_createpagingqueue *args,
+				    struct dxgpagingqueue *pq);
+int dxgvmb_send_destroy_paging_queue(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle h);
 int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				  struct d3dkmt_createallocation *args,
 				  struct d3dkmt_createallocation *__user inargs,
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 4021084ebd78..5de3f8ccb448 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -277,6 +277,10 @@ struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
 			device_handle =
 			    ((struct dxgcontext *)obj)->device_handle;
 			break;
+		case HMGRENTRY_TYPE_DXGPAGINGQUEUE:
+			device_handle =
+			    ((struct dxgpagingqueue *)obj)->device_handle;
+			break;
 		case HMGRENTRY_TYPE_DXGHWQUEUE:
 			device_handle =
 			    ((struct dxghwqueue *)obj)->device_handle;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index e83600945de1..c9c00b288ae0 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1155,6 +1155,80 @@ int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 	return ret;
 }
 
+int dxgvmb_send_create_paging_queue(struct dxgprocess *process,
+				    struct dxgdevice *device,
+				    struct d3dkmt_createpagingqueue *args,
+				    struct dxgpagingqueue *pqueue)
+{
+	struct dxgkvmb_command_createpagingqueue_return result;
+	struct dxgkvmb_command_createpagingqueue *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, device->adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATEPAGINGQUEUE,
+				   process->host_handle);
+	command->args = *args;
+	args->paging_queue.v = 0;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	if (ret < 0) {
+		DXG_ERR("send_create_paging_queue failed %x", ret);
+		goto cleanup;
+	}
+
+	args->paging_queue = result.paging_queue;
+	args->sync_object = result.sync_object;
+	args->fence_cpu_virtual_address =
+	    dxg_map_iospace(result.fence_storage_physical_address, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE, true);
+	if (args->fence_cpu_virtual_address == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	pqueue->mapped_address = args->fence_cpu_virtual_address;
+	pqueue->handle = args->paging_queue;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_paging_queue(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle h)
+{
+	int ret;
+	struct dxgkvmb_command_destroypagingqueue *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_DESTROYPAGINGQUEUE,
+				   process->host_handle);
+	command->paging_queue = h;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, NULL, 0);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 static int
 copy_private_data(struct d3dkmt_createallocation *args,
 		  struct dxgkvmb_command_createallocation *command,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 2e2fd1ae5ec2..aba075d374c9 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -462,6 +462,23 @@ struct dxgkvmb_command_destroycontext {
 	struct d3dkmthandle	context;
 };
 
+struct dxgkvmb_command_createpagingqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createpagingqueue	args;
+};
+
+struct dxgkvmb_command_createpagingqueue_return {
+	struct d3dkmthandle	paging_queue;
+	struct d3dkmthandle	sync_object;
+	u64			fence_storage_physical_address;
+	u64			fence_storage_offset;
+};
+
+struct dxgkvmb_command_destroypagingqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle	paging_queue;
+};
+
 struct dxgkvmb_command_createsyncobject {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_createsynchronizationobject2 args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 3cfc1c40e0bb..a2d236f5eff5 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -329,7 +329,7 @@ static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
 
 			if (alloc_data_size) {
 				if (data_size < alloc_data_size) {
-					dev_err(DXGDEV,
+					DXG_ERR(
 						"Invalid private data size");
 					ret = -EINVAL;
 					goto cleanup1;
@@ -1010,6 +1010,183 @@ static int dxgkio_destroy_hwqueue(struct dxgprocess *process,
 	return ret;
 }
 
+static int
+dxgkio_create_paging_queue(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createpagingqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgpagingqueue *pqueue = NULL;
+	int ret;
+	struct d3dkmthandle host_handle = {};
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
+	adapter = device->adapter;
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	pqueue = dxgpagingqueue_create(device);
+	if (pqueue == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_create_paging_queue(process, device, &args, pqueue);
+	if (ret >= 0) {
+		host_handle = args.paging_queue;
+
+		ret = copy_to_user(inargs, &args, sizeof(args));
+		if (ret) {
+			DXG_ERR("failed to copy input args");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, pqueue,
+					      HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+					      host_handle);
+		if (ret >= 0) {
+			pqueue->handle = host_handle;
+			ret = hmgrtable_assign_handle(&process->handle_table,
+						NULL,
+						HMGRENTRY_TYPE_MONITOREDFENCE,
+						args.sync_object);
+			if (ret >= 0)
+				pqueue->syncobj_handle = args.sync_object;
+		}
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+		/* should not fail after this */
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (pqueue)
+			dxgpagingqueue_destroy(pqueue);
+		if (host_handle.v)
+			dxgvmb_send_destroy_paging_queue(process,
+							 adapter,
+							 host_handle);
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
+dxgkio_destroy_paging_queue(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dddi_destroypagingqueue args;
+	struct dxgpagingqueue *paging_queue = NULL;
+	int ret;
+	struct d3dkmthandle device_handle = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	paging_queue = hmgrtable_get_object_by_type(&process->handle_table,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
+	if (paging_queue) {
+		device_handle = paging_queue->device_handle;
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+				      args.paging_queue);
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_MONITOREDFENCE,
+				      paging_queue->syncobj_handle);
+		paging_queue->syncobj_handle.v = 0;
+		paging_queue->handle.v = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	if (device_handle.v)
+		device = dxgprocess_device_by_handle(process, device_handle);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
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
+	ret = dxgvmb_send_destroy_paging_queue(process, adapter,
+					       args.paging_queue);
+
+	dxgpagingqueue_destroy(paging_queue);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device) {
+		dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 get_standard_alloc_priv_data(struct dxgdevice *device,
 			     struct d3dkmt_createstandardallocation *alloc_info,
@@ -1272,7 +1449,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 		    args.private_runtime_resource_handle;
 		if (args.flags.create_shared) {
 			if (!args.flags.nt_security_sharing) {
-				dev_err(DXGDEV,
+				DXG_ERR(
 					"nt_security_sharing must be set");
 				ret = -EINVAL;
 				goto cleanup;
@@ -1313,7 +1490,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 					args.private_runtime_data,
 					args.private_runtime_data_size);
 				if (ret) {
-					dev_err(DXGDEV,
+					DXG_ERR(
 						"failed to copy runtime data");
 					ret = -EINVAL;
 					goto cleanup;
@@ -1333,7 +1510,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 					args.priv_drv_data,
 					args.priv_drv_data_size);
 				if (ret) {
-					dev_err(DXGDEV,
+					DXG_ERR(
 						"failed to copy res data");
 					ret = -EINVAL;
 					goto cleanup;
@@ -3481,7 +3658,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x04 */	{dxgkio_create_context_virtual, LX_DXCREATECONTEXTVIRTUAL},
 /* 0x05 */	{dxgkio_destroy_context, LX_DXDESTROYCONTEXT},
 /* 0x06 */	{dxgkio_create_allocation, LX_DXCREATEALLOCATION},
-/* 0x07 */	{},
+/* 0x07 */	{dxgkio_create_paging_queue, LX_DXCREATEPAGINGQUEUE},
 /* 0x08 */	{},
 /* 0x09 */	{dxgkio_query_adapter_info, LX_DXQUERYADAPTERINFO},
 /* 0x0a */	{},
@@ -3502,7 +3679,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x19 */	{dxgkio_destroy_device, LX_DXDESTROYDEVICE},
 /* 0x1a */	{},
 /* 0x1b */	{dxgkio_destroy_hwqueue, LX_DXDESTROYHWQUEUE},
-/* 0x1c */	{},
+/* 0x1c */	{dxgkio_destroy_paging_queue, LX_DXDESTROYPAGINGQUEUE},
 /* 0x1d */	{dxgkio_destroy_sync_object, LX_DXDESTROYSYNCHRONIZATIONOBJECT},
 /* 0x1e */	{},
 /* 0x1f */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index a78252901c8d..6ec70852de6e 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -211,6 +211,29 @@ struct d3dddi_createhwqueueflags {
 	};
 };
 
+enum d3dddi_pagingqueue_priority {
+	_D3DDDI_PAGINGQUEUE_PRIORITY_BELOW_NORMAL	= -1,
+	_D3DDDI_PAGINGQUEUE_PRIORITY_NORMAL		= 0,
+	_D3DDDI_PAGINGQUEUE_PRIORITY_ABOVE_NORMAL	= 1,
+};
+
+struct d3dkmt_createpagingqueue {
+	struct d3dkmthandle		device;
+	enum d3dddi_pagingqueue_priority priority;
+	struct d3dkmthandle		paging_queue;
+	struct d3dkmthandle		sync_object;
+#ifdef __KERNEL__
+	void				*fence_cpu_virtual_address;
+#else
+	__u64				fence_cpu_virtual_address;
+#endif
+	__u32				physical_adapter_index;
+};
+
+struct d3dddi_destroypagingqueue {
+	struct d3dkmthandle		paging_queue;
+};
+
 enum d3dkmdt_gdisurfacetype {
 	_D3DKMDT_GDISURFACE_INVALID				= 0,
 	_D3DKMDT_GDISURFACE_TEXTURE				= 1,
@@ -890,6 +913,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x05, struct d3dkmt_destroycontext)
 #define LX_DXCREATEALLOCATION		\
 	_IOWR(0x47, 0x06, struct d3dkmt_createallocation)
+#define LX_DXCREATEPAGINGQUEUE		\
+	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \
@@ -908,6 +933,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x18, struct d3dkmt_createhwqueue)
 #define LX_DXDESTROYHWQUEUE		\
 	_IOWR(0x47, 0x1b, struct d3dkmt_destroyhwqueue)
+#define LX_DXDESTROYPAGINGQUEUE		\
+	_IOWR(0x47, 0x1c, struct d3dddi_destroypagingqueue)
 #define LX_DXDESTROYDEVICE		\
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \

