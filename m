Return-Path: <linux-hyperv+bounces-9611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMUpHj1fvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9611-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB62D24BD
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4402B32B5927
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB03FFAD8;
	Thu, 19 Mar 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7ACAmSK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5F3FEB34
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951965; cv=none; b=EB95F1LZVFUQ+foKLP9QxYWtj/PVFkAqO0hNR1NL/YwkfjGtPXj9FoiSrDq6xJsPltRQu+8uf7BI1iRRauUyX/Y1a2TEutqIIir6+cr7SCkA4YmOls2y8lOyIvFsxE/D2Hw99m7/kcI9mczWjSbxqP9GXAkFW1BRdwh5RZeu+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951965; c=relaxed/simple;
	bh=nGQEUYXMbIpENLhAOSk8xQWfjI3kmrYM3QvmNVStmhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM0FSMkgbWy5/J/WZmgJb/phcyRSuPc2OSZdddGL524Kb5vO5eIfd1LV2oEZS1a94Oc5CyhRdMW6CWWsTcVieKXXmJS1aSyevalOZBCjRWf3UK8bRE3328AdEX/FXcxj/huRWQHNVoEkPsGKVJOBJhBQmHQnfZNFSYGB8J4Lauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7ACAmSK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b4d73463dso946468f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951959; x=1774556759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjOW9NEQVjgaApfYoWy4DLUz7WyMSSyTvWEPSEVJm70=;
        b=H7ACAmSKstFHJYV+ediGGpf6r7+EVQTrlLBnQOvNrSy5FJG8uFzrBoaxwocmg3mWq3
         +fydPRz4GXaQXCnVZAyWKjHH93JC0TvKRBq5m75B1t6WjgcieNO/0aNBzbtbuycI2bnr
         X3u85blQ7HbymCggcWGwxUD9kwuVNslcb5IYpoI7830wdQIcfKDpFXSCMPU4ZXhsryTM
         3DbnovfyC8QkNqLutwRfykmJT23QXFxvRGEpuXGpkpxYix/VTxa5vehOus8S2Pu1Zaop
         R6nybt3EFiMSjUom/zX2BfSCQy9NWmMVucr7ilU4OCXGCPFh5nqdds3HMAr7jNredX1i
         dWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951959; x=1774556759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjOW9NEQVjgaApfYoWy4DLUz7WyMSSyTvWEPSEVJm70=;
        b=M7EeSj8jNmrBnccn4rqwOVci3F6oj+GySbbd0rW9jsq/wQaka7H4Ghm4xiZwiTdbrz
         G0QieA4YphHxicx7JlJ0GFoKSAneM/XR+rWw+yoQPcUMk24mn3CVhwaFSe7V9GU3G+Ps
         8BC6zcADVQVB4LuQXis1/uGvN0ZnSeWhT96gmthgedch9wBeqOpAvDA0W7kDKDC2JNZH
         i1RXCcyYAxkGhLbrV77VWVRp+iKWYsbZF+DnYlbSAi7HHOWbf8oxg0K1lBi+TDddiD2p
         rNVGW13w5af2gvcd5trn49wmhWiaFBBOxJtAtGSuoFzCIVl2k/nobgN4FTN9tEA6W7j2
         XJfQ==
X-Gm-Message-State: AOJu0YywrSb70tNcs2wMkTHxHYq9Ayj9+r2ZQJMoFLp3oMfgEmx/nBvl
	FFZ9MmhERDbM+MgRJxc9IBLpwxa3IbavmiQRmNvzjbOphCXEXruXYIaQRgOvz6RkoSw=
X-Gm-Gg: ATEYQzwByFkhDa6Aii1tfeSC9nXRu5gdNKHoV8HFCZUULSHQSX/R8OZ9qPrkuL+1xAF
	tuacyYEXoVw2FJ0y2YP3f8Ms7pNwxFQ7oCwxSGMFKpF5ccZqfUIAM0w1S7gZxnpHGj+MN4Fwuzd
	WxQ+CLZWxgHUe47gJUdcKoxJomdK8kP9iTWbW6K9l/UoOUNcIFojamZv5EHPHD2gYOjD7CGkxC4
	jexTbpdRLXfjoDaa1YvzUJGWGve+ZBdPo8hj8OY0xJNLh9jGA34pg2RBAo3dkhWr8ImqonWOs+7
	htoXhoY8a0+7s3fFB0GiCWBd6EhByXLQs12CCYr6hvo+eRo6kBhw+2uC9RnoRAFz4ZwTm6QgdJc
	pa1IXzYsxEh9DnZOUXwH0x0jGvpWRzJb+HdxgiOC7VT+zp9q25h4hbFluFfYTAr97KkFJM6NI5Q
	JqyIFqVhKAC+/LSJXkryGRQoNAzfOX9R2tNuMZ37v2rwTmIw51
X-Received: by 2002:a5d:5d86:0:b0:43b:3e0b:721e with SMTP id ffacd0b85a97d-43b64281744mr1116157f8f.40.1773951958654;
        Thu, 19 Mar 2026 13:25:58 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:58 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 40/55] drivers: hv: dxgkrnl: Added implementation for D3DKMTInvalidateCache
Date: Thu, 19 Mar 2026 20:24:54 +0000
Message-ID: <20260319202509.63802-41-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9611-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: D3EB62D24BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

D3DKMTInvalidateCache is called by user mode drivers when the device
doesn't support cache coherent access to compute device allocations.
It needs to be called after an allocation was accessed by CPU and now
needs to be accessed by the device. And vice versa.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  3 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 27 +++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h | 11 ++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 49 +++++++++++++++++++++++++++++++++--
 include/uapi/misc/d3dkmthk.h  |  9 +++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index d20489317c0b..e7d8919b3c01 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -989,6 +989,9 @@ int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  u32 cmd_size);
 int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
 				struct d3dkmt_shareobjectwithhost *args);
+int dxgvmb_send_invalidate_cache(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmt_invalidatecache *args);
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr);
 int ntstatus2int(struct ntstatus status);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 5f17efc937c3..487804ca731a 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2021,6 +2021,33 @@ int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_invalidate_cache(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmt_invalidatecache *args)
+{
+	struct dxgkvmb_command_invalidatecache *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_INVALIDATECACHE,
+				   process->host_handle);
+	command->device = args->device;
+	command->allocation = args->allocation;
+	command->offset = args->offset;
+	command->length = args->length;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index b4a98f7c2522..20c562b485de 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -125,6 +125,7 @@ enum dxgkvmb_commandtype {
 	DXGK_VMBCOMMAND_QUERYRESOURCEINFO	= 64,
 	DXGK_VMBCOMMAND_LOGEVENT		= 65,
 	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES	= 66,
+	DXGK_VMBCOMMAND_INVALIDATECACHE		= 67,
 	DXGK_VMBCOMMAND_INVALID
 };
 
@@ -428,6 +429,16 @@ struct dxgkvmb_command_flushheaptransitions {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 };
 
+/* Returns  ntstatus */
+struct dxgkvmb_command_invalidatecache {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle device;
+	struct d3dkmthandle allocation;
+	u64 offset;
+	u64 length;
+	u64 reserved;
+};
+
 struct dxgkvmb_command_freegpuvirtualaddress {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_freegpuvirtualaddress args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index f735b18fcc14..56b838a87f09 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -4286,6 +4286,8 @@ dxgkio_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
+
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4333,6 +4335,49 @@ dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
+
+	DXG_TRACE_IOCTL_END(ret);
+	return ret;
+}
+
+static int
+dxgkio_invalidate_cache(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_invalidatecache args;
+	int ret;
+	struct dxgdevice *device = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EFAULT;
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
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_invalidate_cache(process, device->adapter,
+		&args);
+
+cleanup:
+
+	if (device) {
+		dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -5198,7 +5243,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x22 */	{dxgkio_get_context_scheduling_priority,
 		 LX_DXGETCONTEXTSCHEDULINGPRIORITY},
 /* 0x23 */	{},
-/* 0x24 */	{},
+/* 0x24 */	{dxgkio_invalidate_cache, LX_DXINVALIDATECACHE},
 /* 0x25 */	{dxgkio_lock2, LX_DXLOCK2},
 /* 0x26 */	{dxgkio_mark_device_as_error, LX_DXMARKDEVICEASERROR},
 /* 0x27 */	{dxgkio_offer_allocations, LX_DXOFFERALLOCATIONS},
@@ -5243,7 +5288,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x44 */	{dxgkio_share_object_with_host, LX_DXSHAREOBJECTWITHHOST},
 /* 0x45 */	{dxgkio_create_sync_file, LX_DXCREATESYNCFILE},
 /* 0x46 */	{dxgkio_wait_sync_file, LX_DXWAITSYNCFILE},
-/* 0x46 */	{dxgkio_open_syncobj_from_syncfile,
+/* 0x47 */	{dxgkio_open_syncobj_from_syncfile,
 		 LX_DXOPENSYNCOBJECTFROMSYNCFILE},
 };
 
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 1eaa3f038322..84fa07a46d3c 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1580,6 +1580,13 @@ struct d3dkmt_opensyncobjectfromsyncfile {
 	__u64			fence_value_gpu_va;	/* out */
 };
 
+struct d3dkmt_invalidatecache {
+	struct d3dkmthandle	device;
+	struct d3dkmthandle	allocation;
+	__u64			offset;
+	__u64			length;
+};
+
 /*
  * Dxgkrnl Graphics Port Driver ioctl definitions
  *
@@ -1647,6 +1654,8 @@ struct d3dkmt_opensyncobjectfromsyncfile {
 	_IOWR(0x47, 0x21, struct d3dkmt_getcontextinprocessschedulingpriority)
 #define LX_DXGETCONTEXTSCHEDULINGPRIORITY \
 	_IOWR(0x47, 0x22, struct d3dkmt_getcontextschedulingpriority)
+#define LX_DXINVALIDATECACHE \
+	_IOWR(0x47, 0x24, struct d3dkmt_invalidatecache)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXMARKDEVICEASERROR		\

