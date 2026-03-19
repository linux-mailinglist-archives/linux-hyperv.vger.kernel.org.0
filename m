Return-Path: <linux-hyperv+bounces-9627-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDjTMApdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9627-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:31:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785C2D22A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6E25300D755
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542E3F8DE0;
	Thu, 19 Mar 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqjJjoed"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348A4070ED
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951979; cv=none; b=mr+Wff+tFKNhLBDGI+q3K2ZYRzTINMdGi201e+EYULWCIiCGlbguvJEZUdFiXw2Fc/3e/lhaEjY2whBaotU6gdvmxq7TvC1Td4nscjWu9FKy2BnW2b0NVQDI2MeLK2QHZXyJA+o6WOpeEcsIjraNne2+Jsx0ZQyP14Y3L6XSI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951979; c=relaxed/simple;
	bh=ql0Xd4LG9x6eDqclJsYGXJsH5ZH2WHcszH6YkEhQ8A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elJzKObxo42AwFFhkFK+rIj30xlR05j1m6PcoYSvRKtUqFajY6GzvsLkzk1gADLwMlFWLfBCj7J6zZhK9VFPb+aIwuJCbBctfmw9t426wv+qHLmeCaoK+IYIkIikZi3ekFnjsjGqjyGgnBcCSiaDtPz2JWy+73Svt8cq0ftvJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqjJjoed; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b9b190easo978931f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951975; x=1774556775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5uGyQLEbHu5J/MxRZx0GZsIsi9tax5qP4TW0jWXf40=;
        b=CqjJjoedq/tlNTU5eWf/1rnHyYdEV2MS5+LEOEyHa1gahFhpAWngLgk6+W6ZKrZHGp
         QvJf3YjtTXiPHjY1NvU2vmO5f3QhZCfJQ/yTTC07A8NqsG/droSfVzvIlVkGNi4aQ6Z7
         qO2H53R8MHPAoqxwnKedYsovQipOGnzmFzykw6xMJxJO5kPAW8eqk97uAis2/SGDAhS7
         i81j1YwqkTewQqZS0cQHBxruvvSxp5TGpuUTYb5MneGm5dUZ+6MTezLYO2SiiJs7QSJB
         Caf5sJYFqifRHMMw+Mo8fRV2FjvAyimuFKnEO/DY4lzHt+GyJUYMI9PfxXmCIQD6NhTm
         pWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951975; x=1774556775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5uGyQLEbHu5J/MxRZx0GZsIsi9tax5qP4TW0jWXf40=;
        b=cJuW21FYXbCrOKfriKOsyUOB8k4mlncHF5CVCYj1YO7QGGdff5jiU5OEfHG2fKkWmk
         1TOFkt4XFsN0zoJVIPHTXN1Muy7UCfwJPFZy4pCJLuNzaIzsp8Rgn5zSvMyJ0EO3NN7C
         f4bOy6oUfJSfFrzSCQJemeZvRIqZaHoZQQJ9hbSkDk1eQLbXyBlqlTwuDeNWYsFbCHg4
         DXrB1x0KYkAnM2/miu7l4KbswIlDlk4Asv1NOV/viPe/lzVo5ORUrz+7fozt7aJb6ipE
         Zasy8hLlnuL/ohhvvlIQ2cAFTfAr0gSCCS34rowC9397BHcRcZ/PzCQFtGGAmeEKH96q
         yY8g==
X-Gm-Message-State: AOJu0YyXogQKMEyWNoeUAZr0iuZA9u8kKpF3lphwRO46CXH0JNTk7qfy
	5KXpzh6WJ+Db2140Xl0FSLPg8uSUTHfO5ECott8QXQfhCioWjQySfHGxAvhlC7lqqQw=
X-Gm-Gg: ATEYQzx5Y1dLoVZi7/90fO1cdMIMhxSQ+YOHEEPZw8XVd5tVPAzA+4JbEykKsFPb2Ek
	dItkTuQxPhzt9OklXAkU/Mxx9WZB1Smd1Q93dKJIOnwqrUqt9StjMLPizig1U/Az7IGMKMqEGHj
	+w4DkeQ98Q5vXnrVl0yWateUqtj66qcfJGaDQMd59SaArwnvVD3En0Eba+cuIcoPybmYlUD1W8j
	HvOJ6UFVtJQTUzI06VNn0uIPCZ1TkS7zOMHyIYrGfbhRsrbw91hCTIjfigtU0Byo2MHcpRQVt3V
	imUcLOQP0SV6vSUq258zjtiGfqxcogumR1SVMEB3IUmMXOQJFKIWo3hW0aIySVQtnHZoy2cA23I
	M8lGHpC9COQhug++vxCccBmbPsLazwpbHiAdaDjd3ORgxpMnvO4KGjOquxEb/K57U0FhwAeI8YP
	UV9o7xJY3jUmeJFF6I2uYptFl+zQ/0swb6WgSl23gOxbp4uOA0
X-Received: by 2002:a05:6000:2383:b0:43b:445f:3177 with SMTP id ffacd0b85a97d-43b6427db29mr1239368f8f.31.1773951974718;
        Thu, 19 Mar 2026 13:26:14 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:14 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 55/55] drivers: hv: dxgkrnl: Code cleanup for upstream submission
Date: Thu, 19 Mar 2026 20:25:09 +0000
Message-ID: <20260319202509.63802-56-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9627-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 6785C2D22A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Address issues raised in previous LKML submission attempts (v1-v3):

- Replace deprecated one-element arrays [1] with C99 flexible arrays []
  in dxgvmbus.h and dxgkrnl.h
- Replace %px with %p in DXG_TRACE calls (avoids exposing kernel layout)
- Remove unnecessary braces from single-statement if blocks
- Remove LINUX_VERSION_CODE guard: max_pkt_size exists in all supported kernels
- Remove unused linux/version.h include from dxgkrnl.h
- Fix whitespace (space before tab) in dxgvmbus.h and d3dkmthk.h
- Replace DXG_ERR non-debug macro do{}while(0) with direct dev_err call
- Change -EBADE to -ENODEV for global channel duplicate detection
- Remove MODULE_VERSION as it is not recommended for in-tree drivers
- Add explanatory comment to guid_to_luid() cast
- Update MAINTAINERS email to iourit@linux.microsoft.com

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 MAINTAINERS                     |  2 +-
 drivers/hv/dxgkrnl/dxgadapter.c |  8 ++++----
 drivers/hv/dxgkrnl/dxgkrnl.h    | 13 +++++--------
 drivers/hv/dxgkrnl/dxgmodule.c  |  5 ++---
 drivers/hv/dxgkrnl/dxgvmbus.c   |  5 +----
 drivers/hv/dxgkrnl/dxgvmbus.h   | 26 +++++++++++++-------------
 drivers/hv/dxgkrnl/hmgr.c       |  3 +--
 include/uapi/misc/d3dkmthk.h    |  2 +-
 8 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fe0b3501931..493c65a02b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9772,7 +9772,7 @@ F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
 Hyper-V vGPU DRIVER
-M:	Iouri Tarassov <iourit@microsoft.com>
+M:	Iouri Tarassov <iourit@linux.microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
 F:	drivers/hv/dxgkrnl/
diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 6d3cabb24e6f..d395fdcb63fa 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -136,7 +136,7 @@ void dxgadapter_release(struct kref *refcount)
 	struct dxgadapter *adapter;
 
 	adapter = container_of(refcount, struct dxgadapter, adapter_kref);
-	DXG_TRACE("Destroying adapter: %px", adapter);
+	DXG_TRACE("Destroying adapter: %p", adapter);
 	kfree(adapter);
 }
 
@@ -271,7 +271,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 			kref_put(&device->device_kref, dxgdevice_release);
 			device = NULL;
 		} else {
-			DXG_TRACE("dxgdevice created: %px", device);
+			DXG_TRACE("dxgdevice created: %p", device);
 		}
 	}
 	return device;
@@ -720,7 +720,7 @@ void dxgdevice_release(struct kref *refcount)
 	struct dxgdevice *device;
 
 	device = container_of(refcount, struct dxgdevice, device_kref);
-	DXG_TRACE("Destroying device: %px", device);
+	DXG_TRACE("Destroying device: %p", device);
 	kref_put(&device->adapter->adapter_kref, dxgadapter_release);
 	kfree(device);
 }
@@ -1103,7 +1103,7 @@ int dxgprocess_adapter_add_device(struct dxgprocess *process,
 
 void dxgprocess_adapter_remove_device(struct dxgdevice *device)
 {
-	DXG_TRACE("Removing device: %px", device);
+	DXG_TRACE("Removing device: %p", device);
 	mutex_lock(&device->adapter_info->device_list_mutex);
 	if (device->device_list_entry.next) {
 		list_del(&device->device_list_entry);
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index d816a875d5ab..4a4605f45736 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -27,7 +27,6 @@
 #include <linux/pci.h>
 #include <linux/hyperv.h>
 #include <uapi/misc/d3dkmthk.h>
-#include <linux/version.h>
 #include "misc.h"
 #include "hmgr.h"
 #include <uapi/misc/d3dkmthk.h>
@@ -719,7 +718,7 @@ bool dxgresource_is_active(struct dxgresource *res);
 
 struct privdata {
 	u32 data_size;
-	u8 data[1];
+	u8 data[];
 };
 
 struct dxgallocation {
@@ -769,9 +768,9 @@ long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 
 int dxg_unmap_iospace(void *va, u32 size);
 /*
- * The convention is that VNBus instance id is a GUID, but the host sets
- * the lower part of the value to the host adapter LUID. The function
- * provides the necessary conversion.
+ * The convention is that VMBus instance id is a GUID, but the host sets
+ * the lower part of the value to the host adapter LUID. The cast reads
+ * the first sizeof(winluid) bytes of the GUID as a winluid value.
  */
 static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 {
@@ -1029,9 +1028,7 @@ void dxgk_validate_ioctls(void);
 #else
 
 #define DXG_TRACE(...)
-#define DXG_ERR(fmt, ...) do {					\
-	dev_err(DXGDEV, "%s: " fmt, __func__, ##__VA_ARGS__);	\
-} while (0)
+#define DXG_ERR(fmt, ...)	dev_err(DXGDEV, "%s: " fmt, __func__, ##__VA_ARGS__)
 
 #endif /* DEBUG */
 
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index c2a4a2a2136f..435dc60511b8 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -158,7 +158,7 @@ static void dxg_signal_dma_fence(struct dxghostevent *eventhdr)
 {
 	struct dxgsyncpoint *event = (struct dxgsyncpoint *)eventhdr;
 
-	DXG_TRACE("syncpoint: %px, fence: %lld", event, event->fence_value);
+	DXG_TRACE("syncpoint: %p, fence: %lld", event, event->fence_value);
 	event->fence_value++;
 	list_del(&eventhdr->host_event_list_entry);
 	dma_fence_signal(&event->base);
@@ -788,7 +788,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 		if (dxgglobal->hdev) {
 			/* This device should appear only once */
 			DXG_ERR("global channel already exists");
-			ret = -EBADE;
+			ret = -ENODEV;
 			goto error;
 		}
 		dxgglobal->hdev = hdev;
@@ -969,4 +969,3 @@ module_exit(dxg_drv_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual compute device Driver");
-MODULE_VERSION("2.0.3");
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index abb6d2af89ac..4b1ccaac440c 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -246,9 +246,7 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev)
 		goto cleanup;
 	}
 
-#if KERNEL_VERSION(5, 15, 0) <= LINUX_VERSION_CODE
 	hdev->channel->max_pkt_size = DXG_MAX_VM_BUS_PACKET_SIZE;
-#endif
 	ret = vmbus_open(hdev->channel, RING_BUFSIZE, RING_BUFSIZE,
 			 NULL, 0, dxgvmbuschannel_receive, ch);
 	if (ret) {
@@ -1482,9 +1480,8 @@ int create_existing_sysmem(struct dxgdevice *device,
 				   dxgalloc->pages);
 	if (ret1 != npages) {
 		DXG_ERR("get_user_pages_fast failed: %d", ret1);
-		if (ret1 > 0 && ret1 < npages) {
+		if (ret1 > 0 && ret1 < npages)
 			unpin_user_pages(dxgalloc->pages, ret1);
-		}
 		vfree(dxgalloc->pages);
 		dxgalloc->pages = NULL;
 		ret = -ENOMEM;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index a7e625b2f896..22246826d2f1 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -313,12 +313,12 @@ struct dxgkvmb_command_queryadapterinfo {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	enum kmtqueryadapterinfotype	query_type;
 	u32				private_data_size;
-	u8				private_data[1];
+	u8				private_data[];
 };
 
 struct dxgkvmb_command_queryadapterinfo_return {
 	struct ntstatus			status;
-	u8				private_data[1];
+	u8				private_data[];
 };
 
 /* Returns ntstatus */
@@ -391,7 +391,7 @@ struct dxgkvmb_command_makeresident {
 	struct d3dkmthandle		paging_queue;
 	struct d3dddi_makeresident_flags flags;
 	u32				alloc_count;
-	struct d3dkmthandle		allocations[1];
+	struct d3dkmthandle		allocations[];
 };
 
 struct dxgkvmb_command_makeresident_return {
@@ -405,7 +405,7 @@ struct dxgkvmb_command_evict {
 	struct d3dkmthandle		device;
 	struct d3dddi_evict_flags	flags;
 	u32				alloc_count;
-	struct d3dkmthandle		allocations[1];
+	struct d3dkmthandle		allocations[];
 };
 
 struct dxgkvmb_command_evict_return {
@@ -476,7 +476,7 @@ struct dxgkvmb_command_updategpuvirtualaddress {
 	struct d3dkmthandle		fence_object;
 	u32				num_operations;
 	u32				flags;
-	struct d3dddi_updategpuvirtualaddress_operation operations[1];
+	struct d3dddi_updategpuvirtualaddress_operation operations[];
 };
 
 struct dxgkvmb_command_queryclockcalibration {
@@ -627,7 +627,7 @@ struct dxgkvmb_command_destroyallocation {
 	struct d3dkmthandle		resource;
 	u32				alloc_count;
 	struct d3dddicb_destroyallocation2flags flags;
-	struct d3dkmthandle		allocations[1];
+	struct d3dkmthandle		allocations[];
 };
 
 struct dxgkvmb_command_createcontextvirtual {
@@ -639,7 +639,7 @@ struct dxgkvmb_command_createcontextvirtual {
 	struct d3dddi_createcontextflags flags;
 	enum d3dkmt_clienthint		client_hint;
 	u32				priv_drv_data_size;
-	u8				priv_drv_data[1];
+	u8				priv_drv_data[];
 };
 
 /* The command returns ntstatus */
@@ -768,7 +768,7 @@ struct dxgkvmb_command_offerallocations {
 	enum d3dkmt_offer_priority	priority;
 	struct d3dkmt_offer_flags	flags;
 	bool				resources;
-	struct d3dkmthandle		allocations[1];
+	struct d3dkmthandle		allocations[];
 };
 
 struct dxgkvmb_command_reclaimallocations {
@@ -778,13 +778,13 @@ struct dxgkvmb_command_reclaimallocations {
 	u32				allocation_count;
 	bool				resources;
 	bool				write_results;
-	struct d3dkmthandle		allocations[1];
+	struct d3dkmthandle		allocations[];
 };
 
 struct dxgkvmb_command_reclaimallocations_return {
 	u64				paging_fence_value;
 	struct ntstatus			status;
-	enum d3dddi_reclaim_result	discarded[1];
+	enum d3dddi_reclaim_result	discarded[];
 };
 
 /* Returns ntstatus */
@@ -804,7 +804,7 @@ struct dxgkvmb_command_createhwqueue {
 	struct d3dkmthandle		context;
 	struct d3dddi_createhwqueueflags flags;
 	u32				priv_drv_data_size;
-	char				priv_drv_data[1];
+	char				priv_drv_data[];
 };
 
 /* The command returns ntstatus */
@@ -833,7 +833,7 @@ struct dxgkvmb_command_escape {
 	struct d3dddi_escapeflags	flags;
 	u32				priv_drv_data_size;
 	struct d3dkmthandle		context;
-	u8				priv_drv_data[1];
+	u8				priv_drv_data[];
 };
 
 struct dxgkvmb_command_queryvideomemoryinfo {
@@ -879,7 +879,7 @@ struct dxgk_feature_desc {
 	struct {
 		u16 supported		: 1;
 		u16 virtualization_mode : 3;
-		u16 global 		: 1;
+		u16 global		: 1;
 		u16 driver_feature	: 1;
 		u16 internal		: 1;
 		u16 reserved		: 9;
diff --git a/drivers/hv/dxgkrnl/hmgr.c b/drivers/hv/dxgkrnl/hmgr.c
index 059f94307a0e..95879f59133e 100644
--- a/drivers/hv/dxgkrnl/hmgr.c
+++ b/drivers/hv/dxgkrnl/hmgr.c
@@ -467,9 +467,8 @@ void hmgrtable_free_handle(struct hmgrtable *table, enum hmgrentry_type t,
 			entry->next_free_index = i;
 		}
 		table->free_handle_list_tail = i;
-		if (table->free_handle_list_head == HMGRTABLE_INVALID_INDEX) {
+		if (table->free_handle_list_head == HMGRTABLE_INVALID_INDEX)
 			table->free_handle_list_head = i;
-		}
 	} else {
 		DXG_ERR("Invalid handle to free: %d %x", i, h.v);
 	}
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index db40e8ff40b0..a58b2513dfd3 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1612,7 +1612,7 @@ struct d3dkmt_opensyncobjectfromsyncfile {
 };
 
 struct d3dkmt_enumprocesses {
-	struct winluid 		adapter_luid;
+	struct winluid		adapter_luid;
 #ifdef __KERNEL__
 	__u32			*buffer;
 #else

