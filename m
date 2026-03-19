Return-Path: <linux-hyperv+bounces-9597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CZRKAxcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9597-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C62D2152
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA646300D4D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD63FBEC0;
	Thu, 19 Mar 2026 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPjnLyUi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D43FB043
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951948; cv=none; b=gRP3GJQi4fxu+Yr7t9tWE7dZxUp+K83W8ybZtbUhxIqd5EPRsAWQJYpOD6OpO/iwIh/UiT5wlclVbz5Blz/9gT0coNlGDwztmjtfXFNOE07/fhOSDyeNz+t8IRoBGWPb1QX9Ybi+t/n2m0Aq5kO7xipwNWqyCMjcHcR6T+gH8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951948; c=relaxed/simple;
	bh=g4L+OyJnGZxRY1AKRn2XRN83HmJ0OAzYwZNM3pOegCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljqR8WEQEhb95TCe76DO/rfZHrYZhooMlnERlD4CTlLUd8hjv3XTMaiSrST1u3qQs4IFG0G99e1jS7aqWVgELHxM6PrrZtJW1EuFebflcSFsa8Y/DRGC7l/F73zhNmDNAxDq/7S2aORALXd+6Tc50vw1bks/ekIfiOrtjJGMBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPjnLyUi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b4d73463dso946347f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951942; x=1774556742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE4eBljE5ZE2/a2micJBTWEOpKIwWswMpcHBB41Pl6s=;
        b=MPjnLyUi6kf4mH98ayOY1grvlv6E5inow0ECZL7MQAO+cGHuaAmeW3YuxZDqfimU9Y
         D98/IE4AjH1LleYL3vkDehg9Eb/T5d+WpBgj3IuyDO39oLuleK08F+8gnNYwMNNyVZN7
         T1QPzOH2VRKHLaAAXK5y/q9EKMv8wIAVhw++DNCeC/oOkSAOTZbxstVWuWSopUZ4yc+T
         8NQBd3zVHFkYA00jbq5jD8S2LgMP/3PhyncpqF3Qk9gNfEUpCGr4PZPkN+ZkrPH0VWnb
         z/uUvMoPNe91uoDyT74jj3vEZRZZSac0queH24k2Cqo6jJ19PLhKRSkf1Ta3H/COt9y+
         fZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951942; x=1774556742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE4eBljE5ZE2/a2micJBTWEOpKIwWswMpcHBB41Pl6s=;
        b=PFMNRdovLhQpXNYwEHZDw2C/q4su9tZnvr96BzW34SMz5MoXt3yYY0TSMjHtatwZjE
         yd8ePGOyAdnV1aTzcoSSJmBu5Pv/jU8pGGZ3u1xk1PwaeXou+n0XLsScfnKNFggo3+Hd
         NZaOaWMHaKSJFrTKQDlvgawbdXnyuNg7mRuWar6rD89r7eK+o9MF08f4HdANkLnURz9V
         cM7RFemw6aJLpP0QkfNe4wR/Seu3CX+V6PNxCwq7RucaiMJFp0zCwgET8gN3rE3zUTCe
         uGl1qJNzIwVTTWeam6mF44/znko+8bt8P7So7Xc1QqnWwQQ0SuTvxINrKm4NhkGmWz1g
         2hMw==
X-Gm-Message-State: AOJu0YwsafyPw6deHp6H/pv7UBjrMCC4OZlRBHBAN7mzTxGV9ylNHPhw
	Ea2fwZdF9ANdaoq3B+HgUP6qEMHGktGZS3HG4aFSesfgJGsDte4k37MI+Ha5k/XQ8oM=
X-Gm-Gg: ATEYQzyfYlfnXAJsCiNJvzkA7blfQ/ZSGYgdJs3OJevGA/MF4Z9FfT2+tYN9/oEvf9o
	Tc2aHzBhcRZI/Ujp0mCv5DHbwRaX7kQoLamij5d8Axg00jHkFl9vQao/gN3Mv5CHO8PtJObGexO
	4QSxqfKJnjvxdV7io0qMYP1hgUTq+6t9RgcoZl5aOeruANfQbCDVztgvAFQwTb8JNZRq2cKuoBH
	m5FK5apPqVj04Gs0amW7OlruTWPVxkvCFfj88jmJmxiI98l5mPBAtm7R9Z5HbhIoJRVOYOlh3Qg
	xy4MV0sDd/SgbX3EOAYhb/ZeMLa+cW6/LYgm281PAZ6Of6hpy6JONNG9xmuA7u7Nm6pKhXWp4fz
	TF2jW9ZoEz9mstxhjc/6vIlh1ESB9jtwvKDWwG/Z8Xc4i1rLoi8AcvHNZc2IilNguDSWSPfnxys
	RV8liMuOCQwdHEtXyTzkidG+sQWfbQXVyB/fhCXlI+zrKeuKIi
X-Received: by 2002:a05:6000:184d:b0:43b:3bf9:e008 with SMTP id ffacd0b85a97d-43b6423f92emr1297004f8f.11.1773951942305;
        Thu, 19 Mar 2026 13:25:42 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:41 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 25/55] drivers: hv: dxgkrnl: Ioctls to manage scheduling priority
Date: Thu, 19 Mar 2026 20:24:39 +0000
Message-ID: <20260319202509.63802-26-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9597-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 670C62D2152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement iocts to manage compute device scheduling priority:
  - LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY
  - LX_DXGETCONTEXTSCHEDULINGPRIORITY
  - LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY
  - LX_DXSETCONTEXTSCHEDULINGPRIORITY

Each compute device execution context has an assigned scheduling
priority. It is used by the compute device scheduler on the host to
pick contexts for execution. There is a global priority and a
priority within a process.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   9 ++
 drivers/hv/dxgkrnl/dxgvmbus.c |  67 ++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.h |  19 ++++
 drivers/hv/dxgkrnl/ioctl.c    | 177 +++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  |  28 ++++++
 5 files changed, 294 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 494ea8fb0bb3..02d10bdcc820 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -865,6 +865,15 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_set_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int priority, bool in_process);
+int dxgvmb_send_get_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int *priority,
+					 bool in_process);
 int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_offerallocations *args);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 8448fd78975b..9a610d48bed7 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2949,6 +2949,69 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_set_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int priority,
+					 bool in_process)
+{
+	struct dxgkvmb_command_setcontextschedulingpriority2 *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SETCONTEXTSCHEDULINGPRIORITY,
+				   process->host_handle);
+	command->context = context;
+	command->priority = priority;
+	command->in_process = in_process;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_get_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int *priority,
+					 bool in_process)
+{
+	struct dxgkvmb_command_getcontextschedulingpriority *command;
+	struct dxgkvmb_command_getcontextschedulingpriority_return result = { };
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY,
+				   process->host_handle);
+	command->context = context;
+	command->in_process = in_process;
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret >= 0) {
+		ret = ntstatus2int(result.status);
+		*priority = result.priority;
+	}
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_offerallocations *args)
@@ -2991,7 +3054,7 @@ int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 cleanup:
 	free_message(&msg, process);
 	if (ret)
-		pr_debug("err: %s %d", __func__, ret);
+		DXG_TRACE("err: %d", ret);
 	return ret;
 }
 
@@ -3067,7 +3130,7 @@ int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
 cleanup:
 	free_message((struct dxgvmbusmsg *)&msg, process);
 	if (ret)
-		pr_debug("err: %s %d", __func__, ret);
+		DXG_TRACE("err: %d", ret);
 	return ret;
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 558c6576a262..509482e1f870 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -331,6 +331,25 @@ struct dxgkvmb_command_getallocationpriority_return {
 	/* u32 priorities[allocation_count or 1]; */
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_setcontextschedulingpriority2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	int				priority;
+	bool				in_process;
+};
+
+struct dxgkvmb_command_getcontextschedulingpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	bool				in_process;
+};
+
+struct dxgkvmb_command_getcontextschedulingpriority_return {
+	struct ntstatus			status;
+	int				priority;
+};
+
 struct dxgkvmb_command_createdevice {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_createdeviceflags	flags;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index fa880aa0196a..bc0adebe52ae 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3660,6 +3660,171 @@ dxgkio_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+set_context_scheduling_priority(struct dxgprocess *process,
+				struct d3dkmthandle hcontext,
+				int priority, bool in_process)
+{
+	int ret = 0;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    hcontext);
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
+	ret = dxgvmb_send_set_context_sch_priority(process, adapter,
+						   hcontext, priority,
+						   in_process);
+	if (ret < 0)
+		DXG_ERR("send_set_context_scheduling_priority failed");
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgkio_set_context_scheduling_priority(struct dxgprocess *process,
+					void *__user inargs)
+{
+	struct d3dkmt_setcontextschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = set_context_scheduling_priority(process, args.context,
+					      args.priority, false);
+cleanup:
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+get_context_scheduling_priority(struct dxgprocess *process,
+				struct d3dkmthandle hcontext,
+				int __user *priority,
+				bool in_process)
+{
+	int ret;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int pri = 0;
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    hcontext);
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
+	ret = dxgvmb_send_get_context_sch_priority(process, adapter,
+						   hcontext, &pri, in_process);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(priority, &pri, sizeof(pri));
+	if (ret) {
+		DXG_ERR("failed to copy priority to user");
+		ret = -EINVAL;
+	}
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgkio_get_context_scheduling_priority(struct dxgprocess *process,
+					void *__user inargs)
+{
+	struct d3dkmt_getcontextschedulingpriority args;
+	struct d3dkmt_getcontextschedulingpriority __user *input = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = get_context_scheduling_priority(process, args.context,
+					      &input->priority, false);
+cleanup:
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_set_context_process_scheduling_priority(struct dxgprocess *process,
+					       void *__user inargs)
+{
+	struct d3dkmt_setcontextinprocessschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = set_context_scheduling_priority(process, args.context,
+					      args.priority, true);
+cleanup:
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_get_context_process_scheduling_priority(struct dxgprocess *process,
+					       void __user *inargs)
+{
+	struct d3dkmt_getcontextinprocessschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = get_context_scheduling_priority(process, args.context,
+		&((struct d3dkmt_getcontextinprocessschedulingpriority *)
+		inargs)->priority, true);
+cleanup:
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
 {
@@ -4655,8 +4820,10 @@ static struct ioctl_desc ioctls[] = {
 /* 0x1e */	{},
 /* 0x1f */	{dxgkio_flush_heap_transitions, LX_DXFLUSHHEAPTRANSITIONS},
 /* 0x20 */	{},
-/* 0x21 */	{},
-/* 0x22 */	{},
+/* 0x21 */	{dxgkio_get_context_process_scheduling_priority,
+		 LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY},
+/* 0x22 */	{dxgkio_get_context_scheduling_priority,
+		 LX_DXGETCONTEXTSCHEDULINGPRIORITY},
 /* 0x23 */	{},
 /* 0x24 */	{},
 /* 0x25 */	{dxgkio_lock2, LX_DXLOCK2},
@@ -4669,8 +4836,10 @@ static struct ioctl_desc ioctls[] = {
 /* 0x2c */	{dxgkio_reclaim_allocations, LX_DXRECLAIMALLOCATIONS2},
 /* 0x2d */	{},
 /* 0x2e */	{dxgkio_set_allocation_priority, LX_DXSETALLOCATIONPRIORITY},
-/* 0x2f */	{},
-/* 0x30 */	{},
+/* 0x2f */	{dxgkio_set_context_process_scheduling_priority,
+		 LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY},
+/* 0x30 */	{dxgkio_set_context_scheduling_priority,
+		 LX_DXSETCONTEXTSCHEDULINGPRIORITY},
 /* 0x31 */	{dxgkio_signal_sync_object_cpu,
 		 LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU},
 /* 0x32 */	{dxgkio_signal_sync_object_gpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 46b9f6d303bf..a9bafab97c18 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -708,6 +708,26 @@ struct d3dkmt_submitcommandtohwqueue {
 #endif
 };
 
+struct d3dkmt_setcontextschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_setcontextinprocessschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_getcontextschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_getcontextinprocessschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
 struct d3dkmt_setallocationpriority {
 	struct d3dkmthandle		device;
 	struct d3dkmthandle		resource;
@@ -1419,6 +1439,10 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
 #define LX_DXFLUSHHEAPTRANSITIONS	\
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
+#define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x21, struct d3dkmt_getcontextinprocessschedulingpriority)
+#define LX_DXGETCONTEXTSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x22, struct d3dkmt_getcontextschedulingpriority)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXMARKDEVICEASERROR		\
@@ -1431,6 +1455,10 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x2c, struct d3dkmt_reclaimallocations2)
 #define LX_DXSETALLOCATIONPRIORITY	\
 	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
+#define LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x2f, struct d3dkmt_setcontextinprocessschedulingpriority)
+#define LX_DXSETCONTEXTSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x30, struct d3dkmt_setcontextschedulingpriority)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \

