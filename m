Return-Path: <linux-hyperv+bounces-9592-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPHRD/VcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9592-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D16722D2283
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8DE3259BA1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AC3F9F56;
	Thu, 19 Mar 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6wRcKbE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE313FA5E2
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951943; cv=none; b=HxfHNkKLlUWw/Emgn64mJWJILts7RsWksZSPH/PwgRMpsXJUqcOu6eysxCcX6yvAog40kd32Q5Y/3zC9d2e71o0sEGBzVTrScx8p5UM7D54qn6Bi/jVDGkp7ejmRmLLjaormdWOeaN4UkLTPUiezJouGFZ6ePnFYRl5iB9NFxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951943; c=relaxed/simple;
	bh=JSyEBFM7jldu6kjAQplAK3yqus2O6kfa1DeMHqQHv4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cISYViVaivs53iI84zKZFaOVuJp7kM2Pqp34tLxlVzJxcshd2axmfAxHxFBpUMQOBaMwEQa02ZnQ/24AosmNqGJlhZVNdv2zN6LUhij4qXmPRbOCB/phvNuXmqqckGvYDaXPTVrJ7H/KgVpLNXzdvX0+Gvo27CK5ggyLQPgSKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6wRcKbE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso1312826f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951937; x=1774556737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXo/15R90aCs7ovxarZsZGx/BAt8UKSFyqYHwOlOjpI=;
        b=b6wRcKbEut0E8iDYg9vSckFTr04txJEtyAWlo3qOqD7M0ieAnqiIRzJr5an3dbSvaL
         K5pkcxUd5/Y5NnAoe0ROFC3u3v1FwkuHujShvHTGn2PGPUYpRTMom7BdPc6i8wJezh2G
         GoL2sxCcS40W5p6hxStIprkkyfOnmayOkS+ZXPLb2e0/H+m+dEBt+pFsBeNkwYxpZi0v
         cdsxx0/aO+wH9kP85jEq1PGYqN1z4NXFwAflErock1PjY+7pAmnhZWU9deEE9gMuK/TE
         1HIIoKi3F8nQtxkMfGWnBQlOXMyUMRy8nAcrODBjn2IyE7lpERZTmJUaeIy+oVmVZiGo
         lE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951937; x=1774556737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXo/15R90aCs7ovxarZsZGx/BAt8UKSFyqYHwOlOjpI=;
        b=pNDvLFletsgc0an1N331GZfKdU9oSVvPO3SnSjqjXl5A7WJwYhOQOerz3Eu6Bb8V5l
         qfWTDuYt79+oayyYN4LZZpgx2kj5zl/a58RxA8Dv4YbhU/PXEZxUXYFZfaTA5uy2m7e8
         OEYZs3bPmBD8FLj7KY3g9lvsNAI6ugvm8ET2OKFnHbhV4szqTs4vuJnEh3Vu3unKFUAb
         //Ro3+/9xx0abGU1j3JDPVYNaSAJxolH06d0lAcwPpYdyHAL91MOgVdZRjezq/Aq8eJ6
         /zBS084SdaI+V1H02UGAr9L3XoK9zOMEMvSd2Ng2Sja1MHwbh8epLeJqGkb2Mqy9LNZ2
         /EmA==
X-Gm-Message-State: AOJu0YzpLE2nc+fj15br5WMDUJ3aofMjQO9Jv4XZ4fuTS/SJERMbJ6Fp
	+ummgnRTUYJ3cDb5Bu5b1me6l5g41gFQjgAgzmeezymJgoSSBkAA/TWFGLuebv85F3Q=
X-Gm-Gg: ATEYQzz/ET5a1prT6y2GxYPMM3h2L2KfOLlLnkN/0EJCuQa6Q6C8SEUHWit/Pjj6g2O
	qlzJzieqwKvjo5lVGbeOYjMTd3Q7PauqWqNYBiaoOopgfwFIPqWGWP7PW/0Xz7Zd/ckXMJM+r1O
	qgWWwTGU9J6vG7rdWwbBq2t4OLtloOeaiJzxQj9STpm8xZcWxRpfi6R7LYr6rhVmQocdGygIngv
	ZH9ZLLq4D6RCMplyrbM2Ggm+pIKHBpNUxigHNB1RIYQnt04nz7J/LLKVQzYZ0ftHW7rO2crdaxh
	G/ZCF/cVIiGyiyHEDK/KFCrXZyqM3zEcIAQIlq6spQIPRW6XfYqD5IePx75skzvmX+8v9EN4obJ
	lOzDJaq2hxF55ho0n7D2jL/tGlXum2uQgjkggci1SW5+X/w+aMIIEDsS0I5MiqH7GCmdMyzqSDb
	onOSkWlgBRku47SQKdrW7LelJyuJuH/huFRm2W3pEOMNrrpX4z
X-Received: by 2002:a05:6000:24c3:b0:439:b60a:b400 with SMTP id ffacd0b85a97d-43b64263f07mr1140495f8f.31.1773951936809;
        Thu, 19 Mar 2026 13:25:36 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:36 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 20/55] drivers: hv: dxgkrnl: Query video memory information
Date: Thu, 19 Mar 2026 20:24:34 +0000
Message-ID: <20260319202509.63802-21-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9592-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D16722D2283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the ioctl to query video memory information from the host
(LX_DXQUERYVIDEOMEMORYINFO).

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  5 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 64 +++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h | 14 ++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 50 ++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  | 13 +++++++
 5 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index ced9dd294f5f..b6a7288a4177 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -894,6 +894,11 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
 				      *args);
+int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_queryvideomemoryinfo *args,
+				  struct d3dkmt_queryvideomemoryinfo
+				  *__user iargs);
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 928fad5f133b..48ff49456057 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1925,6 +1925,70 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_queryvideomemoryinfo *args,
+				  struct d3dkmt_queryvideomemoryinfo *__user
+				  output)
+{
+	int ret;
+	struct dxgkvmb_command_queryvideomemoryinfo *command;
+	struct dxgkvmb_command_queryvideomemoryinfo_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   dxgk_vmbcommand_queryvideomemoryinfo,
+				   process->host_handle);
+	command->adapter = args->adapter;
+	command->memory_segment_group = args->memory_segment_group;
+	command->physical_adapter_index = args->physical_adapter_index;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&output->budget, &result.budget,
+			   sizeof(output->budget));
+	if (ret) {
+		pr_err("%s failed to copy budget", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->current_usage, &result.current_usage,
+			   sizeof(output->current_usage));
+	if (ret) {
+		pr_err("%s failed to copy current usage", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->current_reservation,
+			   &result.current_reservation,
+			   sizeof(output->current_reservation));
+	if (ret) {
+		pr_err("%s failed to copy reservation", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->available_for_reservation,
+			   &result.available_for_reservation,
+			   sizeof(output->available_for_reservation));
+	if (ret) {
+		pr_err("%s failed to copy avail reservation", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(DXGDEV, "err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index d232eb234e2c..a1549983d50f 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -664,6 +664,20 @@ struct dxgkvmb_command_queryallocationresidency_return {
 	/* d3dkmt_allocationresidencystatus[NumAllocations] */
 };
 
+struct dxgkvmb_command_queryvideomemoryinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		adapter;
+	enum d3dkmt_memory_segment_group memory_segment_group;
+	u32				physical_adapter_index;
+};
+
+struct dxgkvmb_command_queryvideomemoryinfo_return {
+	u64			budget;
+	u64			current_usage;
+	u64			current_reservation;
+	u64			available_for_reservation;
+};
+
 struct dxgkvmb_command_getdevicestate {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_getdevicestate	args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 8b7d00e4c881..e692b127e219 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3547,6 +3547,54 @@ dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryvideomemoryinfo args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.process != 0) {
+		DXG_ERR("query vidmem info from another process");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	adapter_locked = true;
+
+	args.adapter = adapter->host_handle;
+	ret = dxgvmb_send_query_vidmem_info(process, adapter, &args, inargs);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	if (ret < 0)
+		DXG_ERR("failed: %x", ret);
+	return ret;
+}
+
 static int
 dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -4287,7 +4335,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x07 */	{dxgkio_create_paging_queue, LX_DXCREATEPAGINGQUEUE},
 /* 0x08 */	{},
 /* 0x09 */	{dxgkio_query_adapter_info, LX_DXQUERYADAPTERINFO},
-/* 0x0a */	{},
+/* 0x0a */	{dxgkio_query_vidmem_info, LX_DXQUERYVIDEOMEMORYINFO},
 /* 0x0b */	{},
 /* 0x0c */	{},
 /* 0x0d */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 873feb951129..b7d8b1d91cfc 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -897,6 +897,17 @@ enum d3dkmt_memory_segment_group {
 	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
 };
 
+struct d3dkmt_queryvideomemoryinfo {
+	__u64					process;
+	struct d3dkmthandle			adapter;
+	enum d3dkmt_memory_segment_group	memory_segment_group;
+	__u64					budget;
+	__u64					current_usage;
+	__u64					current_reservation;
+	__u64					available_for_reservation;
+	__u32					physical_adapter_index;
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -1204,6 +1215,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXQUERYVIDEOMEMORYINFO	\
+	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
 #define LX_DXGETDEVICESTATE		\
 	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
 #define LX_DXSUBMITCOMMAND		\

