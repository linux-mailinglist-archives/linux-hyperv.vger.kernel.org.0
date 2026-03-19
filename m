Return-Path: <linux-hyperv+bounces-9589-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BS/HRVcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9589-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9102D2169
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8C533045006
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C783FA5F6;
	Thu, 19 Mar 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBJaMfT4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D743F9F39
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951939; cv=none; b=bhKMthm50MFDfiRag6T9qrmbBcSq/BQrcDeoBsTOn46O3YZjQ9FR1/AXNWHwkSidr9G6SebNQpo2sh8Ow4PGIp/hBhIpbR1w3evKVIrcJu3IBNlNZPqUJ248qPouXlzozoyp5AVYqCUz0rf3ZKtcpKY0d01iphOd/qOozNcgFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951939; c=relaxed/simple;
	bh=W1uuEZiz/+T8ghB5Y2XB2MXA9ljGH13IJKVKFMxX2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rX6/X4FsqQUxWjNrPAXg8ewnvtuIwUk+xiXXhs8Y00N0f+w7k/+J+5QaD+Xp1vLYQDhW1ZdUzGE84uxM9yH5WnhjLKiDyztIaUHBttCS7IA+9aWhNKJ6zo9AbKk7PeaJ05O/OJtJVMbpRHzesAvuTLhHCq0btpjU3Gg9KL8gw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBJaMfT4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486b9675d36so9247215e9.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951933; x=1774556733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wknvwOJ0/2AENft5MRaRZPXzn2YmZTEafI5amLocXhs=;
        b=aBJaMfT4nvJFtyTbnLPR5Veo9VqaC0bt6e/LfQm1Glx/TKIo5wEvmd1mBY/76pRHDO
         jU3Kg8QxTP9Der4ICUcoFTfs65t/cIazI2roUWlrbVo1oLKahG8sArT2gRJ9By++Gu8x
         c28995gobZdwtK+oWyz0oQenu3J+7MVizHdcgkonFUFUiLGUpVFJXeNggXpQXP0hQJZ4
         OEviEV/FH+5n0OBPILPE2oiuaM1kZWScvv/HNcw4uN1gQmKsNURlFseY41gegNlOvKpj
         qIzraRZb+r6tALWe6YUIAzJpCyXsGuQv+AZpsxkegtBgdEUM8CZk2Y1Gso0m8lEsUHA8
         c+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951933; x=1774556733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wknvwOJ0/2AENft5MRaRZPXzn2YmZTEafI5amLocXhs=;
        b=q1uaFwM0fEcCiqQHETUoJrV304gw9O/yM732/58zzTwvuxdBF4RoKon6i/ayUTlPNU
         BMxS7OtxZ2b1j+4DU3yKfMdTZXWLVf+UzBm+Ke++dDSLRu5uooyo8crwc3QYOC0UqU4c
         qYKn59plTJQ1OrvSTH21q+X0bQLJwVTB6gL52jk5yLLTiyHFBDKOBhpvPrBPvOja/+qs
         YYKS6H/9/JTQkqQyRbt2mE8xA6GAmgX+7C+QfQeAhlSQAtPlz8gNLs/FungKeQTNhiLq
         U9UhSpFibZ0sEvO4pGlAmVCwwbLJ/UGgNJsnzDhYztCFxpzy2ikw/IEtfr8k/jQhjnVK
         JBWg==
X-Gm-Message-State: AOJu0Yw6n6RnCmWH2xnILu//6jGq2eBAgWca9vgzlI/qIWUigyk3nKtj
	mC2/JJ1kAOIlHUen0KreYHBmf7nkd3IN64V+yqrryZ/J6/cGMVWkYTmKbm+vZOJ7FCw=
X-Gm-Gg: ATEYQzzrDsJre1EIvHrrfndSW5i/ZmeVpaFYCDu2G7g5Bi9xmUHU/HaA9FNPovVBDjj
	SLelEljnpu245MixFKd8n4uJvF3rlcPapuDAQQ8qC/Cq2dZ5pinCq0LmtTq+KxL2lIfTcIcguEr
	zfVvL/opQmGJwdxAY1H2C2d30Sbs6+OBcQwMaH4NVP95XTSuzjGo4Kj9pK494lFQOB1KtZhX51/
	vdfk15w8BZ54zGGdEhJkjQGRtiaKn988D1881QyK4Nrz6C/uX5Lf/SHBgoSFqK00muRbsZNaane
	PQoUXNn2gqTynixNip1Hai420PquZdzRvQgMbTH8I72Lhdb8cQ5M2JDZSyukkySOeN29QNoseIN
	htU9Th8Pf6iRCgCcgBrSvAr1rTTgD2oZP/olSXnZUMoZUetJ/ReySaX4sKWYH3xCPNKVKz9cLE2
	/rJ9BVNgj4It3O78DZvjvp8mSyB7mK0t0VxLhb7x1V9Ta2Qk/T
X-Received: by 2002:a05:6000:25c7:b0:439:df25:b707 with SMTP id ffacd0b85a97d-43b6428ab94mr1149378f8f.55.1773951932532;
        Thu, 19 Mar 2026 13:25:32 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:32 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 16/55] drivers: hv: dxgkrnl: Query the dxgdevice state
Date: Thu, 19 Mar 2026 20:24:30 +0000
Message-ID: <20260319202509.63802-17-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9589-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 2B9102D2169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the ioctl to query the dxgdevice state - LX_DXGETDEVICESTATE.
The IOCTL is used to query the state of the given dxgdevice object (active,
error, etc.).

A call to the dxgdevice execution state could be high frequency.
The following method is used to avoid sending a synchronous VM
bus message to the host for every call:
- When a dxgdevice is created, a pointer to dxgglobal->device_state_counter
  is sent to the host
- Every time the device state on the host is changed, the host will send
  an asynchronous message to the guest (DXGK_VMBCOMMAND_SETGUESTDATA) and
  the guest will increment the device_state_counter value.
- the dxgdevice object has execution_state_counter member, which is equal
  to dxgglobal->device_state_counter value at the time when
  LX_DXGETDEVICESTATE was last processed..
- if execution_state_counter is different from device_state_counter, the
  dxgk_vmbcommand_getdevicestate VM bus message is sent to the host.
  Otherwise, the cached value is returned to the caller.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h   |  11 ++++
 drivers/hv/dxgkrnl/dxgmodule.c |   1 -
 drivers/hv/dxgkrnl/dxgvmbus.c  |  68 ++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h  |  26 +++++++++
 drivers/hv/dxgkrnl/ioctl.c     |  66 ++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h   | 101 +++++++++++++++++++++++++++++----
 6 files changed, 261 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index a39d11d76e41..b131c3b43838 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -268,12 +268,18 @@ void dxgsyncobject_destroy(struct dxgprocess *process,
 void dxgsyncobject_stop(struct dxgsyncobject *syncobj);
 void dxgsyncobject_release(struct kref *refcount);
 
+/*
+ * device_state_counter - incremented every time the execition state of
+ *	a DXGDEVICE is changed in the host. Used to optimize access to the
+ *	device execution state.
+ */
 struct dxgglobal {
 	struct dxgdriver	*drvdata;
 	struct dxgvmbuschannel	channel;
 	struct hv_device	*hdev;
 	u32			num_adapters;
 	u32			vmbus_ver;	/* Interface version */
+	atomic_t		device_state_counter;
 	struct resource		*mem;
 	u64			mmiospace_base;
 	u64			mmiospace_size;
@@ -512,6 +518,7 @@ struct dxgdevice {
 	struct list_head	syncobj_list_head;
 	struct d3dkmthandle	handle;
 	enum d3dkmt_deviceexecution_state execution_state;
+	int			execution_state_counter;
 	u32			handle_valid;
 };
 
@@ -849,6 +856,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct d3dkmt_opensyncobjectfromnthandle2
 				    *args,
 				    struct dxgsyncobject *syncobj);
+int dxgvmb_send_get_device_state(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_getdevicestate *args,
+				 struct d3dkmt_getdevicestate *__user inargs);
 int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
 					struct d3dkmthandle object,
 					struct d3dkmthandle *shared_handle);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 8cbe1095599f..5c364a46b65f 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -827,7 +827,6 @@ static struct dxgglobal *dxgglobal_create(void)
 #ifdef DEBUG
 	dxgk_validate_ioctls();
 #endif
-
 	return dxgglobal;
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 67a16de622e0..ed800dc09180 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -281,6 +281,24 @@ static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
 	command->channel_type = DXGKVMB_VM_TO_HOST;
 }
 
+static void set_guest_data(struct dxgkvmb_command_host_to_vm *packet,
+			   u32 packet_length)
+{
+	struct dxgkvmb_command_setguestdata *command = (void *)packet;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	DXG_TRACE("Setting guest data: %d %d %p %p",
+		command->data_type,
+		command->data32,
+		command->guest_pointer,
+		&dxgglobal->device_state_counter);
+	if (command->data_type == SETGUESTDATA_DATATYPE_DWORD &&
+	    command->guest_pointer == &dxgglobal->device_state_counter &&
+	    command->data32 != 0) {
+		atomic_inc(&dxgglobal->device_state_counter);
+	}
+}
+
 static void signal_guest_event(struct dxgkvmb_command_host_to_vm *packet,
 			       u32 packet_length)
 {
@@ -311,6 +329,9 @@ static void process_inband_packet(struct dxgvmbuschannel *channel,
 			DXG_TRACE("global packet %d",
 				packet->command_type);
 			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SETGUESTDATA:
+				set_guest_data(packet, packet_length);
+				break;
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
 				signal_guest_event(packet, packet_length);
@@ -1028,6 +1049,7 @@ struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
 	struct dxgkvmb_command_createdevice *command;
 	struct dxgkvmb_command_createdevice_return result = { };
 	struct dxgvmbusmsg msg;
+	struct dxgglobal *dxgglobal = dxggbl();
 
 	ret = init_message(&msg, adapter, process, sizeof(*command));
 	if (ret)
@@ -1037,6 +1059,7 @@ struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
 	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_CREATEDEVICE,
 				   process->host_handle);
 	command->flags = args->flags;
+	command->error_code = &dxgglobal->device_state_counter;
 
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
 				   &result, sizeof(result));
@@ -1806,6 +1829,51 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_get_device_state(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_getdevicestate *args,
+				 struct d3dkmt_getdevicestate *__user output)
+{
+	int ret;
+	struct dxgkvmb_command_getdevicestate *command;
+	struct dxgkvmb_command_getdevicestate_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETDEVICESTATE,
+				   process->host_handle);
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
+	ret = copy_to_user(output, &result.args, sizeof(result.args));
+	if (ret) {
+		DXG_ERR("failed to copy output args");
+		ret = -EINVAL;
+	}
+
+	if (args->state_type == _D3DKMT_DEVICESTATE_EXECUTION)
+		args->execution_state = result.args.execution_state;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_open_resource(struct dxgprocess *process,
 			      struct dxgadapter *adapter,
 			      struct d3dkmthandle device,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index c1f693917d99..6ca1068b0d4c 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -172,6 +172,22 @@ struct dxgkvmb_command_signalguestevent {
 	bool				dereference_event;
 };
 
+enum set_guestdata_type {
+	SETGUESTDATA_DATATYPE_DWORD	= 0,
+	SETGUESTDATA_DATATYPE_UINT64	= 1
+};
+
+struct dxgkvmb_command_setguestdata {
+	struct dxgkvmb_command_host_to_vm hdr;
+	void *guest_pointer;
+	union {
+		u64	data64;
+		u32	data32;
+	};
+	u32	dereference	: 1;
+	u32	data_type	: 4;
+};
+
 struct dxgkvmb_command_opensyncobject {
 	struct dxgkvmb_command_vm_to_host hdr;
 	struct d3dkmthandle		device;
@@ -574,6 +590,16 @@ struct dxgkvmb_command_destroyhwqueue {
 	struct d3dkmthandle		hwqueue;
 };
 
+struct dxgkvmb_command_getdevicestate {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_getdevicestate	args;
+};
+
+struct dxgkvmb_command_getdevicestate_return {
+	struct d3dkmt_getdevicestate	args;
+	struct ntstatus			status;
+};
+
 struct dxgkvmb_command_shareobjectwithhost {
 	struct dxgkvmb_command_vm_to_host hdr;
 	struct d3dkmthandle	device_handle;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index ac052836ce27..26d410fd6e99 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3142,6 +3142,70 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_getdevicestate args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int global_device_state_counter = 0;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
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
+	if (args.state_type == _D3DKMT_DEVICESTATE_EXECUTION) {
+		global_device_state_counter =
+			atomic_read(&dxgglobal->device_state_counter);
+		if (device->execution_state_counter ==
+		    global_device_state_counter) {
+			args.execution_state = device->execution_state;
+			ret = copy_to_user(inargs, &args, sizeof(args));
+			if (ret) {
+				DXG_ERR("failed to copy args to user");
+				ret = -EINVAL;
+			}
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_get_device_state(process, adapter, &args, inargs);
+
+	if (ret == 0 && args.state_type == _D3DKMT_DEVICESTATE_EXECUTION) {
+		device->execution_state = args.execution_state;
+		device->execution_state_counter = global_device_state_counter;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	if (ret < 0)
+		DXG_ERR("Failed to get device state %x", ret);
+
+	return ret;
+}
+
 static int
 dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
 				    struct dxgprocess *process,
@@ -3822,7 +3886,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x0b */	{},
 /* 0x0c */	{},
 /* 0x0d */	{},
-/* 0x0e */	{},
+/* 0x0e */	{dxgkio_get_device_state, LX_DXGETDEVICESTATE},
 /* 0x0f */	{dxgkio_submit_command, LX_DXSUBMITCOMMAND},
 /* 0x10 */	{dxgkio_create_sync_object, LX_DXCREATESYNCHRONIZATIONOBJECT},
 /* 0x11 */	{dxgkio_signal_sync_object, LX_DXSIGNALSYNCHRONIZATIONOBJECT},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 895861505e6e..8a013b07e88a 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -236,6 +236,95 @@ struct d3dddi_destroypagingqueue {
 	struct d3dkmthandle		paging_queue;
 };
 
+enum dxgk_render_pipeline_stage {
+	_DXGK_RENDER_PIPELINE_STAGE_UNKNOWN		= 0,
+	_DXGK_RENDER_PIPELINE_STAGE_INPUT_ASSEMBLER	= 1,
+	_DXGK_RENDER_PIPELINE_STAGE_VERTEX_SHADER	= 2,
+	_DXGK_RENDER_PIPELINE_STAGE_GEOMETRY_SHADER	= 3,
+	_DXGK_RENDER_PIPELINE_STAGE_STREAM_OUTPUT	= 4,
+	_DXGK_RENDER_PIPELINE_STAGE_RASTERIZER		= 5,
+	_DXGK_RENDER_PIPELINE_STAGE_PIXEL_SHADER	= 6,
+	_DXGK_RENDER_PIPELINE_STAGE_OUTPUT_MERGER	= 7,
+};
+
+enum dxgk_page_fault_flags {
+	_DXGK_PAGE_FAULT_WRITE			= 0x1,
+	_DXGK_PAGE_FAULT_FENCE_INVALID		= 0x2,
+	_DXGK_PAGE_FAULT_ADAPTER_RESET_REQUIRED	= 0x4,
+	_DXGK_PAGE_FAULT_ENGINE_RESET_REQUIRED	= 0x8,
+	_DXGK_PAGE_FAULT_FATAL_HARDWARE_ERROR	= 0x10,
+	_DXGK_PAGE_FAULT_IOMMU			= 0x20,
+	_DXGK_PAGE_FAULT_HW_CONTEXT_VALID	= 0x40,
+	_DXGK_PAGE_FAULT_PROCESS_HANDLE_VALID	= 0x80,
+};
+
+enum dxgk_general_error_code {
+	_DXGK_GENERAL_ERROR_PAGE_FAULT		= 0,
+	_DXGK_GENERAL_ERROR_INVALID_INSTRUCTION	= 1,
+};
+
+struct dxgk_fault_error_code {
+	union {
+		struct {
+			__u32	is_device_specific_code:1;
+			enum dxgk_general_error_code general_error_code:31;
+		};
+		struct {
+			__u32	is_device_specific_code_reserved_bit:1;
+			__u32	device_specific_code:31;
+		};
+	};
+};
+
+struct d3dkmt_devicereset_state {
+	union {
+		struct {
+			__u32	desktop_switched:1;
+			__u32	reserved:31;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_devicepagefault_state {
+	__u64				faulted_primitive_api_sequence_number;
+	enum dxgk_render_pipeline_stage	faulted_pipeline_stage;
+	__u32				faulted_bind_table_entry;
+	enum dxgk_page_fault_flags	page_fault_flags;
+	struct dxgk_fault_error_code	fault_error_code;
+	__u64				faulted_virtual_address;
+};
+
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
+enum d3dkmt_devicestate_type {
+	_D3DKMT_DEVICESTATE_EXECUTION		= 1,
+	_D3DKMT_DEVICESTATE_PRESENT		= 2,
+	_D3DKMT_DEVICESTATE_RESET		= 3,
+	_D3DKMT_DEVICESTATE_PRESENT_DWM		= 4,
+	_D3DKMT_DEVICESTATE_PAGE_FAULT		= 5,
+	_D3DKMT_DEVICESTATE_PRESENT_QUEUE	= 6,
+};
+
+struct d3dkmt_getdevicestate {
+	struct d3dkmthandle				device;
+	enum d3dkmt_devicestate_type			state_type;
+	union {
+		enum d3dkmt_deviceexecution_state	execution_state;
+		struct d3dkmt_devicereset_state		reset_state;
+		struct d3dkmt_devicepagefault_state	page_fault_state;
+		char alignment[48];
+	};
+};
+
 enum d3dkmdt_gdisurfacetype {
 	_D3DKMDT_GDISURFACE_INVALID				= 0,
 	_D3DKMDT_GDISURFACE_TEXTURE				= 1,
@@ -759,16 +848,6 @@ struct d3dkmt_queryadapterinfo {
 	__u32				private_data_size;
 };
 
-enum d3dkmt_deviceexecution_state {
-	_D3DKMT_DEVICEEXECUTION_ACTIVE			= 1,
-	_D3DKMT_DEVICEEXECUTION_RESET			= 2,
-	_D3DKMT_DEVICEEXECUTION_HUNG			= 3,
-	_D3DKMT_DEVICEEXECUTION_STOPPED			= 4,
-	_D3DKMT_DEVICEEXECUTION_ERROR_OUTOFMEMORY	= 5,
-	_D3DKMT_DEVICEEXECUTION_ERROR_DMAFAULT		= 6,
-	_D3DKMT_DEVICEEXECUTION_ERROR_DMAPAGEFAULT	= 7,
-};
-
 struct d3dddi_openallocationinfo2 {
 	struct d3dkmthandle	allocation;
 #ifdef __KERNEL__
@@ -978,6 +1057,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXGETDEVICESTATE		\
+	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
 #define LX_DXSUBMITCOMMAND		\
 	_IOWR(0x47, 0x0f, struct d3dkmt_submitcommand)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \

