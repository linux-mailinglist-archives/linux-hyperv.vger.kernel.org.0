Return-Path: <linux-hyperv+bounces-9595-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJPgLz9cvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9595-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A1B2D2182
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB3373054B92
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8BC3FB7E9;
	Thu, 19 Mar 2026 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp1VzVVa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DC3FA5C1
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951946; cv=none; b=AZxgpJzkvlsnJYq5NiYdGtf/fnqzHgAWRjCXZ9GNf50j0H39PBPMb37YpX+5WjzTDdoHD2GLedFzepbBBopiup+VsVd9DxmrLLF4KjghiZv09dUwsBwA65vHHa7d3CL+SD1Pvds+3AL4spUXNGxiB2enund7wEJRhe/48Ry/79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951946; c=relaxed/simple;
	bh=G5yS/0Ks2668HL0F929eJ2RnsQeUhgHqOkkBonyENwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6GaDj2Bqgphd8VRSw72WaokRtTc9D3FuPEkU9P3hERMDjcTjOW7G+JOfILG7k4vXj1tlLg547SHLnrSNDoDMuodPBWR2/qIzxa+Cv/MytjMdndIbZQssUcnuhxvHSKAsb4zAlLsnoLtCCujkuwy6ap6LjgPK39MKTkOG6BDKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp1VzVVa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7c2788dso776110f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951939; x=1774556739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gpXwUuuqUKCEuabXGr3mbEIEr9EepzLK4R1EIs1rd0=;
        b=Gp1VzVValD8gVa2YZH0HJYNR5MSHLfTCiRalkgEJi5ltJJdKzD2hdB/qwJnBI1zxLJ
         8hp/qCi5B/DupdqTq0Pq8oURN3KqpapxYXm4TteoRx6cbPxJvNdGXp/+fbhIbkDfn9Ux
         SdklvUa7UG/PXeqtC4K78slgjH2Gv+JtKQQYmdlqHrv67rWPe24DUANL95bWbsMLkQef
         RwVMR3AuCcgoj8tm0SVKom9yWgcMjlpVrGraDMhWAzh+M9FWaEyNtx0SO+BFaCCwkaZF
         +VZL+9tAI0swpMUufPL4lWlw9zQCQ9iGYvrg3ef9n4ePlsa9rf+VXuSYyfK7Idi+tikg
         jacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951939; x=1774556739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9gpXwUuuqUKCEuabXGr3mbEIEr9EepzLK4R1EIs1rd0=;
        b=LeP11Wv4ZwT1mfXYcxQ1lHQ3J8lopi2WF8sB/6OkQK1jJ/wjChd37qv096rxxXsKok
         0toZN2OyIZ0ieHNe+3++vaOHEE5qK61CGGwb97S4ywAZoSlGzFGjW7QJDqJgrURYdC7a
         b8uTcMcKcuWzLR1rwE4ZTYfKqRuM3v5IQmEg6XOSdGExTSLblUud1bREk0fv09rOnC7+
         wlC51eOCTRflZAsw1XQQxt4vW+e8Tn66qQQluaw+2Y8vGext2FU62PJID56oNVLyReMq
         RzRTW4T40oj0CjvHO4erG4/T0CEWUXVMvf/9h34Q7CS2UjGk8JPXBLO3JENUZnowjmS7
         IDcQ==
X-Gm-Message-State: AOJu0Yz0htIWW95lUGVumop3f2OatGteqynJeY1dv9UmCOC4mfjlDczG
	DgV+lMbw0pll2M2XzfnnDkd//tenfzbMFiXX8KIDBwKRe1J/W3Df0xMxJy+8fu2YgFA=
X-Gm-Gg: ATEYQzzAIPjYUkWk8pz+GHiBy4nX6ePqshTAu2ffhKhnbWb/hq0ESDCnDIDTaMbSJJP
	sd/ZVFk0+jWn80GB4WkLsegz9XHxt0SvhSLs30USsGs3DAKEa/DJ0u309OUbzCcrLRej02up5mr
	VAwFGhYhwmJJwnNeorR8JDbaUCaoipvRF8XqH6w7DmmIqtNDyhFjkX9QKlzdDq6iVzK8wZzBYTy
	09j3+LQCdUOvMIx7CL5bbXKCqRGE1NZXkkklqDwrbSNMZRP9GgN6n6SHB1SpTOPc6cNRWynrWhR
	MRHD4ZpNfNAe+nqkfdw36ymlqygpS33nwBfGoQnrch7Tufhhj0fbELxlGRQnefoA/bZk1OSo3LE
	6sxeOOLyzcIOh9v1uAGfPfW86X2oa2c4NMM570iClicaRwU0WCgb0Yf1DW8pjEYI2hPsucbLWU5
	dHRm2tmjYMDdS+R4DFkdo3QHacRr4yPV2hxZ7/YmizCimSpQ6x
X-Received: by 2002:a05:6000:2584:b0:43b:4e01:4aa9 with SMTP id ffacd0b85a97d-43b64242a6emr1209662f8f.10.1773951938920;
        Thu, 19 Mar 2026 13:25:38 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:38 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 22/55] drivers: hv: dxgkrnl: Ioctl to put device to error state
Date: Thu, 19 Mar 2026 20:24:36 +0000
Message-ID: <20260319202509.63802-23-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9595-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 37A1B2D2182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the ioctl to put the virtual compute device to the error
state (LX_DXMARKDEVICEASERROR).

This ioctl is used by the user mode driver when it detects an
unrecoverable error condition.

When a compute device is put to the error state, all subsequent
ioctl calls to the device will fail.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  3 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 25 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  5 +++++
 drivers/hv/dxgkrnl/ioctl.c    | 38 ++++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  | 12 +++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index dafc721ed6cf..b454c7430f06 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -856,6 +856,9 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 				      struct d3dddi_updateallocproperty *args,
 				      struct d3dddi_updateallocproperty *__user
 				      inargs);
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args);
 int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_setallocationpriority *a);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 8bdd49bc7aa6..f7264b12a477 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2730,6 +2730,31 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args)
+{
+	struct dxgkvmb_command_markdeviceaserror *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MARKDEVICEASERROR,
+				   process->host_handle);
+	command->args = *args;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 				struct dxgadapter *adapter,
 				struct d3dkmt_setallocationpriority *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index e1c2ed7b1580..a66e11097bb2 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -627,6 +627,11 @@ struct dxgkvmb_command_updateallocationproperty_return {
 	struct ntstatus			status;
 };
 
+struct dxgkvmb_command_markdeviceaserror {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_markdeviceaserror args;
+};
+
 /* Returns ntstatus */
 struct dxgkvmb_command_changevideomemoryreservation {
 	struct dxgkvmb_command_vgpu_to_host hdr;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 78de76abce2d..ce4af610ada7 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3341,6 +3341,42 @@ dxgkio_update_alloc_property(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_mark_device_as_error(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_markdeviceaserror args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
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
+	device->execution_state = _D3DKMT_DEVICEEXECUTION_RESET;
+	ret = dxgvmb_send_mark_device_as_error(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkio_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
 {
@@ -4404,7 +4440,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x23 */	{},
 /* 0x24 */	{},
 /* 0x25 */	{dxgkio_lock2, LX_DXLOCK2},
-/* 0x26 */	{},
+/* 0x26 */	{dxgkio_mark_device_as_error, LX_DXMARKDEVICEASERROR},
 /* 0x27 */	{},
 /* 0x28 */	{},
 /* 0x29 */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 749edf28bd43..ce5a638a886d 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -790,6 +790,16 @@ struct d3dkmt_unlock2 {
 	struct d3dkmthandle			allocation;
 };
 
+enum d3dkmt_device_error_reason {
+	_D3DKMT_DEVICE_ERROR_REASON_GENERIC		= 0x80000000,
+	_D3DKMT_DEVICE_ERROR_REASON_DRIVER_ERROR	= 0x80000006,
+};
+
+struct d3dkmt_markdeviceaserror {
+	struct d3dkmthandle			device;
+	enum d3dkmt_device_error_reason		reason;
+};
+
 enum d3dkmt_standardallocationtype {
 	_D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP	= 1,
 	_D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER	= 2,
@@ -1290,6 +1300,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
+#define LX_DXMARKDEVICEASERROR		\
+	_IOWR(0x47, 0x26, struct d3dkmt_markdeviceaserror)
 #define LX_DXQUERYALLOCATIONRESIDENCY	\
 	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
 #define LX_DXSETALLOCATIONPRIORITY	\

