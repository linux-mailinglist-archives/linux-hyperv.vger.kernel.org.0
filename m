Return-Path: <linux-hyperv+bounces-9588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NUVJRRcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9588-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B192D2161
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39A003044375
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3B3FA5F2;
	Thu, 19 Mar 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/3X/QHv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2EF3F7E81
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951939; cv=none; b=pFPRS/5PcR92ndF3Gglb35TAM74U9WSWSaljVh+ZHGEBGle+q+dd6j9ExVLzqS+oqw6JYrCJkwnpDWn3zvhZcFVqaZkuyQL+zoRKqhv+UT8x7m2tj1M0TeXzVK9Vgm/1yRQl0grP16r3v2HhGdJY3+dDiJyuapSpJqkCZbvvMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951939; c=relaxed/simple;
	bh=Fbp9q7H4t9EaV4awmwjgI/tqECFvn+++xu/wcX174OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMshFMuAc69NM3qxR5rrPsshx3A6WgDY/AyMDtyeKmuAZdPp1FGHPYnh8CZbVe9wvrnW4BTn0sq6xVwORNa3OCHRQoideC4+T6bC8E3YyCWq6cdsvY/NhUiy/tr9ioz3A8QkrVV+f9ZnUKkxE66oHAh1hfOqdo3F3MekH1R7XUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/3X/QHv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so14219425e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951934; x=1774556734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27zyhUWeckJu0+G+QN/l2H50C9jZ20tZZMg4eAEpV4k=;
        b=N/3X/QHvtZERzhkN1bAD8JZDXyf+9rkGzS878xnsBxaR2dbrYCav56QIaSqthaf95c
         2p7HHi2/LzFjdqJJUPkYr81oVqompp+U5eiD4FBSOAmsTMJKkTvK7KuhdgtiqdNrLckZ
         ow9I11L5pOIKGCd+e2bxxI100w7QGgg0gVjQHKiedcjoD3rDdfvlUZJOOX7YfpnR4tLU
         iRIujbOYHdskd2raFZr3sObbLJoRAv0ilOJjz7917A0SX+o5ZZRL7PoWsvmX5n8LUH9y
         Kdvy/sCMpkzEPdBtUNqF52NcBja2z1mHohFgyxCq/z65Ow4hNRV6t3LGssXQvbJKOUTS
         XL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951934; x=1774556734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27zyhUWeckJu0+G+QN/l2H50C9jZ20tZZMg4eAEpV4k=;
        b=ExG/rVG9QonPiUYyU2UG80D6gybraWspVZrgReF2BAHUXuJBfXXNl7TwqzLPfbSIJb
         twPHD9clOM/oVu1iVjdVJqLYyMGE+MYweuGZJ0iwNvr8D17gBS4hXa8IJ3u8Oc5vdXI2
         hI5PYkKHRwjMao9qTu/MCCE3Nm8F6eAQ4eZB1y91U6PRAB+YUsJHOKhHEFlBpMd4+jC1
         ln9KGXStoeUSb8a9lIlfe18MVm/wk8Dynq+4Ohs/9umxRJyVWDLToR7XZnCvmyTXY4mn
         Rlr+u3teVtwBbFcwxDDmrRX6scdpR9AcIJI7hwyqCw2V0kggCsc9M3UT5Q83jgAFFbJq
         b06A==
X-Gm-Message-State: AOJu0YzRuUKrVDB33g3WdiX+h6itpjKXfnJAwRk0NRwCAYiGRBLTnHoG
	4B5qqUpmf+ZVDhNKzTElL8caBwqfUtT9jAL6feQGPUefe0J27sZ4eZj/XeaJWUgYXQ0=
X-Gm-Gg: ATEYQzyqfRON1zO3vLt9+kvMvwx1Y4kgvoa3A3LOxDXKBrdcnTzsZFKIIhAHwWbHqvO
	4VjzgrEeqFgiLDmzuwM/lskt+mocp0k5WaICRNaEpzW+YEYXhhyORWbogSm8U/wQ2Dzc8b8d7L0
	S1tNmxlwrsgFlaGuS+aoKDb2GvY0th/eR7fp/iQMRM14g2iGW16+s4fi+PTMxagb0P2WRs1rkeJ
	DRpzj4++S+rhXI8v+9Y8jHfs1Gddh/bsiWcx/jY99xkG8Ns1FEexuzyYnwxdPeJBA91OJcXoPdO
	kR2mQtB1hMzt5R0eDnnXSPNzoWvYbYO7dgh/p3DAs0kmoxxPCFkjxVr5xe3R6dRDw0Ykrgwnko5
	A5fssBs0x6xUhj/2u4G3hUBval1crPqc1HpfWW2hbaVU8j2xYed/Bhv0YZskVCgUHSf8BNo87gR
	VlXx0tqZuSxeqEb4JOOr8h0lFOs2KPFXLRpNaJC1pLg2318XJh
X-Received: by 2002:a05:600c:1d15:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-486fedf9061mr6617495e9.10.1773951933549;
        Thu, 19 Mar 2026 13:25:33 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:33 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 17/55] drivers: hv: dxgkrnl: Map(unmap) CPU address to device allocation
Date: Thu, 19 Mar 2026 20:24:31 +0000
Message-ID: <20260319202509.63802-18-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9588-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.964];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid,args.data:url]
X-Rspamd-Queue-Id: D9B192D2161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to map/unmap CPU virtual addresses to compute device
allocations - LX_DXLOCK2 and LX_DXUNLOCK2.

The LX_DXLOCK2 ioctl maps a CPU virtual address to a compute device
allocation. The allocation could be located in system memory or local
device memory on the host. When the device allocation is created
from the guest system memory (existing sysmem allocation), the
allocation CPU address is known and is returned to the caller.
For other CPU visible allocations the code flow is the following:
1. A VM bus message is sent to the host to map the allocation
2. The host allocates a portion of the guest IO space and maps it
   to the allocation backing store. The IO space address of the
   allocation is returned back to the guest.
3. The guest allocates a CPU virtual address and maps it to the IO
   space (see the dxg_map_iospace function).
4. The CPU VA is returned back to the caller
cpu_address_mapped and cpu_address_refcount are used to track how
many times an allocation was mapped.

The LX_DXUNLOCK2 ioctl unmaps a CPU virtual address from a compute
device allocation.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  11 +++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  14 +++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 107 +++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  19 ++++
 drivers/hv/dxgkrnl/ioctl.c      | 160 +++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h    |  30 ++++++
 6 files changed, 339 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 410f08768bad..23f00db7637e 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -885,6 +885,15 @@ void dxgallocation_stop(struct dxgallocation *alloc)
 		vfree(alloc->pages);
 		alloc->pages = NULL;
 	}
+	dxgprocess_ht_lock_exclusive_down(alloc->process);
+	if (alloc->cpu_address_mapped) {
+		dxg_unmap_iospace(alloc->cpu_address,
+				  alloc->num_pages << PAGE_SHIFT);
+		alloc->cpu_address_mapped = false;
+		alloc->cpu_address = NULL;
+		alloc->cpu_address_refcount = 0;
+	}
+	dxgprocess_ht_lock_exclusive_up(alloc->process);
 }
 
 void dxgallocation_free_handle(struct dxgallocation *alloc)
@@ -932,6 +941,8 @@ else
 #endif
 	if (alloc->priv_drv_data)
 		vfree(alloc->priv_drv_data);
+	if (alloc->cpu_address_mapped)
+		pr_err("Alloc IO space is mapped: %p", alloc);
 	kfree(alloc);
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index b131c3b43838..1d6b552f1c1a 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -708,6 +708,8 @@ struct dxgallocation {
 	struct d3dkmthandle		alloc_handle;
 	/* Set to 1 when allocation belongs to resource. */
 	u32				resource_owner:1;
+	/* Set to 1 when 'cpu_address' is mapped to the IO space. */
+	u32				cpu_address_mapped:1;
 	/* Set to 1 when the allocatio is mapped as cached */
 	u32				cached:1;
 	u32				handle_valid:1;
@@ -719,6 +721,11 @@ struct dxgallocation {
 #endif
 	/* Number of pages in the 'pages' array */
 	u32				num_pages;
+	/*
+	 * How many times dxgk_lock2 is called to allocation, which is mapped
+	 * to IO space.
+	 */
+	u32				cpu_address_refcount;
 	/*
 	 * CPU address from the existing sysmem allocation, or
 	 * mapped to the CPU visible backing store in the IO space
@@ -837,6 +844,13 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
 				     u64 cpu_event);
+int dxgvmb_send_lock2(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_lock2 *args,
+		      struct d3dkmt_lock2 *__user outargs);
+int dxgvmb_send_unlock2(struct dxgprocess *process,
+			struct dxgadapter *adapter,
+			struct d3dkmt_unlock2 *args);
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index ed800dc09180..a80f84d9065a 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2354,6 +2354,113 @@ int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_lock2(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_lock2 *args,
+		      struct d3dkmt_lock2 *__user outargs)
+{
+	int ret;
+	struct dxgkvmb_command_lock2 *command;
+	struct dxgkvmb_command_lock2_return result = { };
+	struct dxgallocation *alloc = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_LOCK2, process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	if (ret < 0)
+		goto cleanup;
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args->allocation);
+	if (alloc == NULL) {
+		DXG_ERR("invalid alloc");
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address) {
+			args->data = alloc->cpu_address;
+			if (alloc->cpu_address_mapped)
+				alloc->cpu_address_refcount++;
+		} else {
+			u64 offset = (u64)result.cpu_visible_buffer_offset;
+
+			args->data = dxg_map_iospace(offset,
+					alloc->num_pages << PAGE_SHIFT,
+					PROT_READ | PROT_WRITE, alloc->cached);
+			if (args->data) {
+				alloc->cpu_address_refcount = 1;
+				alloc->cpu_address_mapped = true;
+				alloc->cpu_address = args->data;
+			}
+		}
+		if (args->data == NULL) {
+			ret = -ENOMEM;
+		} else {
+			ret = copy_to_user(&outargs->data, &args->data,
+					   sizeof(args->data));
+			if (ret) {
+				DXG_ERR("failed to copy data");
+				ret = -EINVAL;
+				alloc->cpu_address_refcount--;
+				if (alloc->cpu_address_refcount == 0) {
+					dxg_unmap_iospace(alloc->cpu_address,
+					   alloc->num_pages << PAGE_SHIFT);
+					alloc->cpu_address_mapped = false;
+					alloc->cpu_address = NULL;
+				}
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_unlock2(struct dxgprocess *process,
+			struct dxgadapter *adapter,
+			struct d3dkmt_unlock2 *args)
+{
+	int ret;
+	struct dxgkvmb_command_unlock2 *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UNLOCK2,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 6ca1068b0d4c..447bb1ba391b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -570,6 +570,25 @@ struct dxgkvmb_command_waitforsyncobjectfromgpu {
 	/* struct d3dkmthandle ObjectHandles[object_count] */
 };
 
+struct dxgkvmb_command_lock2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_lock2		args;
+	bool				use_legacy_lock;
+	u32				flags;
+	u32				priv_drv_data;
+};
+
+struct dxgkvmb_command_lock2_return {
+	struct ntstatus			status;
+	void				*cpu_visible_buffer_offset;
+};
+
+struct dxgkvmb_command_unlock2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_unlock2		args;
+	bool				use_legacy_unlock;
+};
+
 /* Returns the same structure */
 struct dxgkvmb_command_createhwqueue {
 	struct dxgkvmb_command_vgpu_to_host hdr;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 26d410fd6e99..37e218443310 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3142,6 +3142,162 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_lock2(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_lock2 args;
+	struct d3dkmt_lock2 *__user result = inargs;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgallocation *alloc = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	args.data = NULL;
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args.allocation);
+	if (alloc == NULL) {
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address) {
+			ret = copy_to_user(&result->data,
+					   &alloc->cpu_address,
+					   sizeof(args.data));
+			if (ret == 0) {
+				args.data = alloc->cpu_address;
+				if (alloc->cpu_address_mapped)
+					alloc->cpu_address_refcount++;
+			} else {
+				DXG_ERR("Failed to copy cpu address");
+				ret = -EINVAL;
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (ret < 0)
+		goto cleanup;
+	if (args.data)
+		goto success;
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
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_lock2(process, adapter, &args, result);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+success:
+	DXG_TRACE("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgkio_unlock2(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_unlock2 args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgallocation *alloc = NULL;
+	bool done = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args.allocation);
+	if (alloc == NULL) {
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address == NULL) {
+			DXG_ERR("Allocation is not locked: %p", alloc);
+			ret = -EINVAL;
+		} else if (alloc->cpu_address_mapped) {
+			if (alloc->cpu_address_refcount > 0) {
+				alloc->cpu_address_refcount--;
+				if (alloc->cpu_address_refcount != 0) {
+					done = true;
+				} else {
+					dxg_unmap_iospace(alloc->cpu_address,
+						alloc->num_pages << PAGE_SHIFT);
+					alloc->cpu_address_mapped = false;
+					alloc->cpu_address = NULL;
+				}
+			} else {
+				DXG_ERR("Invalid cpu access refcount");
+				done = true;
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (done)
+		goto success;
+	if (ret < 0)
+		goto cleanup;
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
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_unlock2(process, adapter, &args);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+success:
+	DXG_TRACE("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -3909,7 +4065,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x22 */	{},
 /* 0x23 */	{},
 /* 0x24 */	{},
-/* 0x25 */	{},
+/* 0x25 */	{dxgkio_lock2, LX_DXLOCK2},
 /* 0x26 */	{},
 /* 0x27 */	{},
 /* 0x28 */	{},
@@ -3932,7 +4088,7 @@ static struct ioctl_desc ioctls[] = {
 		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE},
 /* 0x36 */	{dxgkio_submit_wait_to_hwqueue,
 		 LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE},
-/* 0x37 */	{},
+/* 0x37 */	{dxgkio_unlock2, LX_DXUNLOCK2},
 /* 0x38 */	{},
 /* 0x39 */	{},
 /* 0x3a */	{dxgkio_wait_sync_object_cpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 8a013b07e88a..b498f09e694d 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -668,6 +668,32 @@ struct d3dkmt_submitcommandtohwqueue {
 #endif
 };
 
+struct d3dddicb_lock2flags {
+	union {
+		struct {
+			__u32	reserved:32;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_lock2 {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		allocation;
+	struct d3dddicb_lock2flags	flags;
+	__u32				reserved;
+#ifdef __KERNEL__
+	void				*data;
+#else
+	__u64				data;
+#endif
+};
+
+struct d3dkmt_unlock2 {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			allocation;
+};
+
 enum d3dkmt_standardallocationtype {
 	_D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP	= 1,
 	_D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER	= 2,
@@ -1083,6 +1109,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXLOCK2			\
+	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \
@@ -1095,6 +1123,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x35, struct d3dkmt_submitsignalsyncobjectstohwqueue)
 #define LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE \
 	_IOWR(0x47, 0x36, struct d3dkmt_submitwaitforsyncobjectstohwqueue)
+#define LX_DXUNLOCK2			\
+	_IOWR(0x47, 0x37, struct d3dkmt_unlock2)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \

