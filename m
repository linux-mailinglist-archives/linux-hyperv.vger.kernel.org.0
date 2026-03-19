Return-Path: <linux-hyperv+bounces-9600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ7oLyBcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9600-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 693BC2D2179
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4D96300A336
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB13F9F3A;
	Thu, 19 Mar 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh8HIKvn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC63FBEA0
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951952; cv=none; b=W/09EsT55Kk/wGwT+gQlymRDarPmYCX+uY+aqKojHjJZigycTeIbacMPjUgAn6M/U2DZ58A4tA2HIo+WsSEDX2C19in20C8tlKgGgUF4SPfUHLV8kRq/zBMbNEFhiZc50rhUf26gbnIkN4jxd/PRAWDTwqZuNgaaXUebcAWVYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951952; c=relaxed/simple;
	bh=0mnqW+0YxMPWWQ5hYRM9j1JibATge5yEVOcZ4JbBf18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zd+PvINAUeXNMvoo187XactTB75SMc6aXtMEApRaAF5Lrki4gcE0RfPYxcx1E49sTf0vRq9p3GjXWAMw9opJVimHwvMpNGBHDTzNt06TH9R1WNvvbQjgkxsvbiYSs/hv4px/1WO9xGSpUSL6m4KJ//NJ4xky/QdGzRNp1dB2nZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh8HIKvn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so978835f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951946; x=1774556746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzkntaQrinqqPXBhUAC5ve0qVCkj/uMJtIw3Tw3VCWE=;
        b=Bh8HIKvn+bkd9eZgWfGIy3JOhwXPb5sSZQ9lCaZ6wHRYb6V/VxswkhRZqFcofbYVdq
         KY3rLjSXOcxnu3RquP/PQNS5qvN/i3+sp7BUVGlKjjLCOulyE443U20R2tJQPtWuzB2X
         bx5n8O0ZaD2CPCmAgb2kpNPT3lTAR7Uatez2xd3gQGWp02Vi58rOofL6dp1Zt11ZrTgs
         68W6qefD2clUynPXPowSUfYitKk82ulUXaowuNnjhNtDB2JfwCLADs74xv68vxZaB3Vr
         dFLu2ABCkhr8NkucWRrFNpIkp8xSo8Okg9E+tJgKGN9b+nvaRGNZkJEDuEgRKLofnBm6
         1Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951946; x=1774556746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzkntaQrinqqPXBhUAC5ve0qVCkj/uMJtIw3Tw3VCWE=;
        b=HSEvpRvBjubLF1kF4MtrAq/TIJ5qJkWfNe2bUjEPrSZQ+nYfj0k2P0EEvJdqNyDA4I
         AqZ6kidy/n91gzEI6c3mSUqMoZxjYX0oVnf1UE21Qp/DB92Tz8BpEsdXOjpPJSvOYltO
         grKwjXzpVmKxbu+RKr1V0kdTiQErlI7E1XP//9aeAB/+zwYfcS+0OUGwDuABibhx2ug5
         AW7sHYYyLBlplMJvzxgrEmBJcudplVobp3HxumpPpzRcD37d6yEwd1Pj1jggA5zVDzVC
         iBZCSg2mVx5KcxKJ947OlsQBtUIFPLJ3N2Adqadug1BlNjXC3K4hijga9slhlTxTI2kQ
         dNoQ==
X-Gm-Message-State: AOJu0YyRe+4FEIbMotxuzdZzBPe+ZiCup2dXki7OFgTJ82xKs/AjXPlC
	bLhosSY+i1iAswBZo2zwzpSVDcr1/4OkKwpxaMW6TEYeXDX6zY94yRcjj9P/Fp5oEAQ=
X-Gm-Gg: ATEYQzyaiihL3idbfou+0Z0yU/nlisu4Y1wwpCjTnn1+n+36UYWx/ThPsfeqEJLdcJh
	RuuypfH8hINVTJ4XwWFSYYYKLb0bJ1B1NzqA1/SX6P08efY+M0Y/V2Re6MgQrjUMPMU0n84F0Rs
	Mk1XDY6XydtKl7gNYJBU9/WEPcUKyk6JZ7MXKRyrhiaj0qv1GzPUB/atOTbN6X6mKVxYvkTbtJX
	+bkQZvBgq2mgHhn+bfgaxaTVopjOP2XilQE3BcY8PD1ErwLliZpb61awTpFLVUBeaU/1iNg4+1k
	6ALZ9k90XIPDKQMhyZTT+pllFaWqLJJA9R0oMrlStFe4hCCeXtaBkmebs80Jy8G1YzNdVkRE2va
	pVV2ekzWTLaiNZk3bCnaYZfz/TOrGELatfc5JhJKha5ZTfxR5Smyh8MUQh1C1VGmET6vZCdus5m
	5lmk8A5AEadw0m60dmgtnwX5XRT55HO2r1Pigbkrn5H6ks2Jie
X-Received: by 2002:a5d:64c6:0:b0:439:df03:f300 with SMTP id ffacd0b85a97d-43b6428178emr1154879f8f.40.1773951945847;
        Thu, 19 Mar 2026 13:25:45 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:45 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 28/55] drivers: hv: dxgkrnl: Add support to map guest pages by host
Date: Thu, 19 Mar 2026 20:24:42 +0000
Message-ID: <20260319202509.63802-29-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9600-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 693BC2D2179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement support for mapping guest memory pages by the host.
This removes hyper-v limitations of using GPADL (guest physical
address list).

Dxgkrnl uses hyper-v GPADLs to share guest system memory with the
host. This method has limitations:
- a single GPADL can represent only ~32MB of memory
- there is a limit of how much memory the total size of GPADLs
  in a VM can represent.
To avoid these limitations the host implemented mapping guest memory
pages. Presence of this support is determined by reading PCI config
space. When the support is enabled, dxgkrnl does not use GPADLs and
instead uses the following code flow:
- memory pages of an existing system memory buffer are pinned
- PFNs of the pages are sent to the host via a VM bus message
- the host maps the PFNs to get access to the memory

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile    |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h   |   1 +
 drivers/hv/dxgkrnl/dxgmodule.c |  33 +++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c  | 117 ++++++++++++++++++++++++---------
 drivers/hv/dxgkrnl/dxgvmbus.h  |  10 +++
 drivers/hv/dxgkrnl/misc.c      |   1 +
 6 files changed, 129 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 9d821e83448a..fc85a47a6ad5 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
+dxgkrnl-y := dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 93bc9b41aa41..091dbe999d33 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -316,6 +316,7 @@ struct dxgglobal {
 	bool			misc_registered;
 	bool			pci_registered;
 	bool			vmbus_registered;
+	bool			map_guest_pages_enabled;
 };
 
 static inline struct dxgglobal *dxggbl(void)
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 5c364a46b65f..b1b612b90fc1 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -147,7 +147,7 @@ void dxgglobal_remove_host_event(struct dxghostevent *event)
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr)
 {
-	struct  dxghosteventcpu *event = (struct  dxghosteventcpu *)eventhdr;
+	struct dxghosteventcpu *event = (struct dxghosteventcpu *)eventhdr;
 
 	if (event->remove_from_list ||
 		event->destroy_after_signal) {
@@ -426,7 +426,11 @@ const struct file_operations dxgk_fops = {
 #define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
 
-/* The guest writes its capabilities to this address */
+/* The host caps (dxgk_vmbus_hostcaps) */
+#define DXGK_VMBUS_HOSTCAPS_OFFSET	(DXGK_VMBUS_VGPU_LUID_OFFSET + \
+					sizeof(struct winluid))
+
+/* The guest writes its capavilities to this adderss */
 #define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
 
@@ -441,6 +445,23 @@ struct dxgk_vmbus_guestcaps {
 	};
 };
 
+/*
+ * The structure defines features, supported by the host.
+ *
+ * map_guest_memory
+ *   Host can map guest memory pages, so the guest can avoid using GPADLs
+ *   to represent existing system memory allocations.
+ */
+struct dxgk_vmbus_hostcaps {
+	union {
+		struct {
+			u32	map_guest_memory	: 1;
+			u32	reserved		: 31;
+		};
+		u32 host_caps;
+	};
+};
+
 /*
  * A helper function to read PCI config space.
  */
@@ -475,6 +496,7 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 	struct winluid vgpu_luid = {};
 	struct dxgk_vmbus_guestcaps guest_caps = {.wsl2 = 1};
 	struct dxgglobal *dxgglobal = dxggbl();
+	struct dxgk_vmbus_hostcaps host_caps = {};
 
 	mutex_lock(&dxgglobal->device_mutex);
 
@@ -503,6 +525,13 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 		if (ret)
 			goto cleanup;
 
+		ret = pci_read_config_dword(dev, DXGK_VMBUS_HOSTCAPS_OFFSET,
+					&host_caps.host_caps);
+		if (ret == 0) {
+			if (host_caps.map_guest_memory)
+				dxgglobal->map_guest_pages_enabled = true;
+		}
+
 		if (dxgglobal->vmbus_ver > DXGK_VMBUS_INTERFACE_VERSION)
 			dxgglobal->vmbus_ver = DXGK_VMBUS_INTERFACE_VERSION;
 	}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 425a1ab87bd6..4d7807909284 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1383,15 +1383,19 @@ int create_existing_sysmem(struct dxgdevice *device,
 	void *kmem = NULL;
 	int ret = 0;
 	struct dxgkvmb_command_setexistingsysmemstore *set_store_command;
+	struct dxgkvmb_command_setexistingsysmempages *set_pages_command;
 	u64 alloc_size = host_alloc->allocation_size;
 	u32 npages = alloc_size >> PAGE_SHIFT;
 	struct dxgvmbusmsg msg = {.hdr = NULL};
-
-	ret = init_message(&msg, device->adapter, device->process,
-			   sizeof(*set_store_command));
-	if (ret)
-		goto cleanup;
-	set_store_command = (void *)msg.msg;
+	const u32 max_pfns_in_message =
+		(DXG_MAX_VM_BUS_PACKET_SIZE - sizeof(*set_pages_command) -
+		PAGE_SIZE) / sizeof(__u64);
+	u32 alloc_offset_in_pages = 0;
+	struct page **page_in;
+	u64 *pfn;
+	u32 pages_to_send;
+	u32 i;
+	struct dxgglobal *dxgglobal = dxggbl();
 
 	/*
 	 * Create a guest physical address list and set it as the allocation
@@ -1402,6 +1406,7 @@ int create_existing_sysmem(struct dxgdevice *device,
 	DXG_TRACE("Alloc size: %lld", alloc_size);
 
 	dxgalloc->cpu_address = (void *)sysmem;
+
 	dxgalloc->pages = vzalloc(npages * sizeof(void *));
 	if (dxgalloc->pages == NULL) {
 		DXG_ERR("failed to allocate pages");
@@ -1419,39 +1424,87 @@ int create_existing_sysmem(struct dxgdevice *device,
 		ret = -ENOMEM;
 		goto cleanup;
 	}
-	kmem = vmap(dxgalloc->pages, npages, VM_MAP, PAGE_KERNEL);
-	if (kmem == NULL) {
-		DXG_ERR("vmap failed");
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-	ret1 = vmbus_establish_gpadl(dxgglobal_get_vmbus(), kmem,
-				     alloc_size, &dxgalloc->gpadl);
-	if (ret1) {
-		DXG_ERR("establish_gpadl failed: %d", ret1);
-		ret = -ENOMEM;
-		goto cleanup;
-	}
+	if (!dxgglobal->map_guest_pages_enabled) {
+		ret = init_message(&msg, device->adapter, device->process,
+				sizeof(*set_store_command));
+		if (ret)
+			goto cleanup;
+		set_store_command = (void *)msg.msg;
+
+		kmem = vmap(dxgalloc->pages, npages, VM_MAP, PAGE_KERNEL);
+		if (kmem == NULL) {
+			DXG_ERR("vmap failed");
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		ret1 = vmbus_establish_gpadl(dxgglobal_get_vmbus(), kmem,
+					alloc_size, &dxgalloc->gpadl);
+		if (ret1) {
+			DXG_ERR("establish_gpadl failed: %d", ret1);
+			ret = -ENOMEM;
+			goto cleanup;
+		}
 #ifdef _MAIN_KERNEL_
-	DXG_TRACE("New gpadl %d", dxgalloc->gpadl.gpadl_handle);
+		DXG_TRACE("New gpadl %d", dxgalloc->gpadl.gpadl_handle);
 #else
-	DXG_TRACE("New gpadl %d", dxgalloc->gpadl);
+		DXG_TRACE("New gpadl %d", dxgalloc->gpadl);
 #endif
 
-	command_vgpu_to_host_init2(&set_store_command->hdr,
-				   DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
-				   device->process->host_handle);
-	set_store_command->device = device->handle;
-	set_store_command->device = device->handle;
-	set_store_command->allocation = host_alloc->allocation;
+		command_vgpu_to_host_init2(&set_store_command->hdr,
+					DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
+					device->process->host_handle);
+		set_store_command->device = device->handle;
+		set_store_command->allocation = host_alloc->allocation;
 #ifdef _MAIN_KERNEL_
-	set_store_command->gpadl = dxgalloc->gpadl.gpadl_handle;
+		set_store_command->gpadl = dxgalloc->gpadl.gpadl_handle;
 #else
-	set_store_command->gpadl = dxgalloc->gpadl;
+		set_store_command->gpadl = dxgalloc->gpadl;
 #endif
-	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
-	if (ret < 0)
-		DXG_ERR("failed to set existing store: %x", ret);
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+		if (ret < 0)
+			DXG_ERR("failed set existing store: %x", ret);
+	} else {
+		/*
+		 * Send the list of the allocation PFNs to the host. The host
+		 * will map the pages for GPU access.
+		 */
+
+		ret = init_message(&msg, device->adapter, device->process,
+				sizeof(*set_pages_command) +
+				max_pfns_in_message * sizeof(u64));
+		if (ret)
+			goto cleanup;
+		set_pages_command = (void *)msg.msg;
+		command_vgpu_to_host_init2(&set_pages_command->hdr,
+					DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES,
+					device->process->host_handle);
+		set_pages_command->device = device->handle;
+		set_pages_command->allocation = host_alloc->allocation;
+
+		page_in = dxgalloc->pages;
+		while (alloc_offset_in_pages < npages) {
+			pfn = (u64 *)((char *)msg.msg +
+				sizeof(*set_pages_command));
+			pages_to_send = min(npages - alloc_offset_in_pages,
+					    max_pfns_in_message);
+			set_pages_command->num_pages = pages_to_send;
+			set_pages_command->alloc_offset_in_pages =
+				alloc_offset_in_pages;
+
+			for (i = 0; i < pages_to_send; i++)
+				*pfn++ = page_to_pfn(*page_in++);
+
+			ret = dxgvmb_send_sync_msg_ntstatus(msg.channel,
+							    msg.hdr,
+							    msg.size);
+			if (ret < 0) {
+				DXG_ERR("failed set existing pages: %x", ret);
+				break;
+			}
+			alloc_offset_in_pages += pages_to_send;
+		}
+	}
 
 cleanup:
 	if (kmem)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 88967ff6a505..b4a98f7c2522 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -234,6 +234,16 @@ struct dxgkvmb_command_setexistingsysmemstore {
 	u32				gpadl;
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_setexistingsysmempages {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		allocation;
+	u32				num_pages;
+	u32				alloc_offset_in_pages;
+	/* u64 pfn_array[num_pages] */
+};
+
 struct dxgkvmb_command_createprocess {
 	struct dxgkvmb_command_vm_to_host hdr;
 	void			*process;
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
index cb1e0635bebc..4a1309d80ee5 100644
--- a/drivers/hv/dxgkrnl/misc.c
+++ b/drivers/hv/dxgkrnl/misc.c
@@ -35,3 +35,4 @@ u16 *wcsncpy(u16 *dest, const u16 *src, size_t n)
 	dest[i - 1] = 0;
 	return dest;
 }
+

