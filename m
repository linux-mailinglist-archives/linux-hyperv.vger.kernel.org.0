Return-Path: <linux-hyperv+bounces-9613-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIK1NkdfvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9613-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA232D24CF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B1332BF5C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8F3FB06B;
	Thu, 19 Mar 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL4NG0vh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50873FF8A5
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951966; cv=none; b=NViyJMkcgCfLDomzqta1twQjNB34Y6nvD7L+XdwfUIQ9bQdkHW0I30qMmfAn2N5jFxu8V2UKQVum5OQJQr4g1B6l0iLML0LXAur9nt2wg87NhZaDCTY5SR+YvqZSTFgI4z91r1hOeS8Em9TJQJ8+DdQPEu8CFCxFMX9ZDJcpTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951966; c=relaxed/simple;
	bh=9EotiCR3a/bxXyYpH48uROjU7TaRXAUW+3QQzC9Rnbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK7+aicqY5pB9JqPSaslZzDFCJGB+CMALxq50tp3KpE2VD2gcJi4GhXC5AM4nKEssrb76xP3Qn0mugwAkxqxpie9k5rMqcK2Up9K/eymu2/qq4fhl8MIOrpq1Tf4Yb/3Gn7MPA9kFRfocQwQLQyR4sQKb5QOVSPMx399sbfHPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL4NG0vh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso14098455e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951961; x=1774556761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOXddkLS+afnHqsg7GZzmCZXh9PBt2zVroRp0TwjKzA=;
        b=nL4NG0vhsgX6T8bi4rvzNOeki73cfUhydz5DeZXY3Urc/SWsNzwETkpluYeut9rhRS
         FItW5/49a1EfED+YXcPV+9bv3xxtW99ogBvgd1f1cs3eVl2QcjgGlQK40wrjMlfO8w1X
         nZ6ZCz42+IMcqcP5EWmpaeRN7JhoG/dzD74/8qtQ8yBeHtBieG77qzT9Jpuul7c1D/gP
         vQa9GpbO6XyHK0fn3St7t4KXlZEDSRiZaCHq2ll5V8Rn15yEwMTN/KklbgG+sTFgDtPt
         XJTpXkW2vJAIOiZptfKzysu5MrtFApe2OmaVWW+fXCcPhJhvrRWdAWsGPoKf9cplOTNk
         k8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951961; x=1774556761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOXddkLS+afnHqsg7GZzmCZXh9PBt2zVroRp0TwjKzA=;
        b=OddSTVOy45iiZ4AuZTQHtnguC6I4Wz9TSGBoNK8f+NcxsByG9fsDjbY3pBK60D7kpg
         peD1wDXKhqwiSJgQcaIPJIxzR7bi8onlhEIlpc1dgQsizrYRN2+BXvjFazNEX+36iash
         6K8C0s/1efYLLO4zmagZ+xh+BA2JQ4Xn7/Ww6cowsNW1dZ3C9nILgBoeGVfu0v/ajk8Q
         hbr9zpLkSYjfyyEKADhiu9wwxO6EOxLTGAzmmjlAqCpW+5o7jy0xTRRDJyREj9tQeLqt
         G5NMM+TOtwBHXz6Nv3ifrZx9v+kPPWIc1RjUKWbKd6yk9avZJHEvTO3ojJydHOYFYIl6
         vtmg==
X-Gm-Message-State: AOJu0YzhQp/ctC84wnbyg/j3YuEY1RQsXfapbfRy6Kfmb8xdbf2mm24d
	BlUY/+ErNI3x3nalnwReUwFfJ0yY2arUU7ln7GiyH3f4xAjTdxjw+JvN1u+oYxiuaBY=
X-Gm-Gg: ATEYQzySRkqDNI5BimSJcb2GGUJcbsB3EHHPYwQREzfygPUzZUiH8tYVDHz6xkQa+2b
	dEXkEyvl7ith0wGeqzhScwMcmdcVulD7WbCYyQ+pXlR3zUBRNuRx4ntsUBz6RTFoVUHcH/S4sVF
	E+3aWQomGgPqeSTMUFU4ZPrF0ksxBf0aVa3+oF2kiEFh5YzQJSKIS/lXVbZBEVe2WT+WWSq44+b
	6MtVGjEL9YfH37+Qxpmbc6loL7vKRG+af/cMYCXVBl+BUgxI1G4yIDgObOeeVWEZ8fRREFrLycO
	x59V8SDgkf1tL3acTCOucp5quJLRUhWL/Ae9Sz+uNdkN0Zy23OGH78eAo0J7lCpj9jFEMVWpNlw
	Oe+jFSXZrzZZSJDX9GfYgwtFt7eSZiICXg+vGDdEgU/myRSFX+RoKUEDidKKELaCEjuxQRacx77
	71UqgZNIEec/V94WPETP4rKP2M1SI4om7kl2BdIweBdtBiWDHi
X-Received: by 2002:a05:600c:c48f:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-486febb60c6mr7537765e9.2.1773951960885;
        Thu, 19 Mar 2026 13:26:00 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:00 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 42/55] drivers: hv: dxgkrnl: Implement the D3DKMTEnumProcesses API
Date: Thu, 19 Mar 2026 20:24:56 +0000
Message-ID: <20260319202509.63802-43-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9613-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EA232D24CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

D3DKMTEnumProcesses is used to enumerate PIDs for all processes,
which opened the /dev/dxg device.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h    |  1 +
 drivers/hv/dxgkrnl/dxgprocess.c |  2 +
 drivers/hv/dxgkrnl/ioctl.c      | 81 +++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h    | 12 +++++
 4 files changed, 96 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 6af1e59b0a31..90bcd5377744 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -387,6 +387,7 @@ struct dxgprocess {
 	pid_t			pid;
 	pid_t			tgid;
 	pid_t			vpid; /* pdi from the current namespace */
+	struct pid_namespace	*nspid; /* namespace id */
 	/* how many time the process was opened */
 	struct kref		process_kref;
 	/* protects the object memory */
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 5a4c4cb0c2e8..9bfd53df1a54 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -13,6 +13,7 @@
 
 #include "dxgkrnl.h"
 #include "linux/sched.h"
+#include <linux/pid_namespace.h>
 
 #undef dev_fmt
 #define dev_fmt(fmt)	"dxgk: " fmt
@@ -33,6 +34,7 @@ struct dxgprocess *dxgprocess_create(void)
 		process->pid = current->pid;
 		process->tgid = current->tgid;
 		process->vpid = task_pid_vnr(current);
+		process->nspid = task_active_pid_ns(current);
 		ret = dxgvmb_send_create_process(process);
 		if (ret < 0) {
 			DXG_TRACE("send_create_process failed");
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 466bef6c14b3..24b84be2fb73 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
+#include <linux/pid_namespace.h>
 
 #include "dxgkrnl.h"
 #include "dxgvmbus.h"
@@ -5238,6 +5239,85 @@ dxgkio_share_object_with_host(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_enum_processes(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_enumprocesses args;
+	struct d3dkmt_enumprocesses *__user input = inargs;
+	struct dxgadapter *adapter = NULL;
+	struct dxgadapter *entry;
+	struct dxgglobal *dxgglobal = dxggbl();
+	struct dxgprocess_adapter *pentry;
+	int nump = 0;	/* Current number of processes*/
+	struct ntstatus status;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	if (args.buffer_count == 0) {
+		DXG_ERR("Invalid buffer count");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (*(u64 *) &entry->luid == *(u64 *) &args.adapter_luid) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	if (adapter == NULL) {
+		DXG_ERR("Failed to find dxgadapter");
+		ret = -EINVAL;
+		goto cleanup_locks;
+	}
+
+	list_for_each_entry(pentry, &adapter->adapter_process_list_head,
+			    adapter_process_list_entry) {
+		if (pentry->process->nspid != task_active_pid_ns(current))
+			continue;
+		if (nump == args.buffer_count) {
+			status.v = STATUS_BUFFER_TOO_SMALL;
+			ret = ntstatus2int(status);
+			goto cleanup_locks;
+		}
+		ret = copy_to_user(&args.buffer[nump], &pentry->process->vpid,
+				   sizeof(u32));
+		if (ret) {
+			DXG_ERR("failed to copy data to user");
+			ret = -EFAULT;
+			goto cleanup_locks;
+		}
+		nump++;
+	}
+
+cleanup_locks:
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	if (ret == 0) {
+		ret = copy_to_user(&input->buffer_count, &nump, sizeof(u32));
+		if (ret)
+			DXG_ERR("failed to copy buffer count to user");
+	}
+
+cleanup:
+
+	DXG_TRACE_IOCTL_END(ret);
+	return ret;
+}
+
 static struct ioctl_desc ioctls[] = {
 /* 0x00 */	{},
 /* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
@@ -5325,6 +5405,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x46 */	{dxgkio_wait_sync_file, LX_DXWAITSYNCFILE},
 /* 0x47 */	{dxgkio_open_syncobj_from_syncfile,
 		 LX_DXOPENSYNCOBJECTFROMSYNCFILE},
+/* 0x48 */	{dxgkio_enum_processes, LX_DXENUMPROCESSES},
 };
 
 /*
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 84fa07a46d3c..f9f817060fa9 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1580,6 +1580,16 @@ struct d3dkmt_opensyncobjectfromsyncfile {
 	__u64			fence_value_gpu_va;	/* out */
 };
 
+ struct d3dkmt_enumprocesses {
+	struct winluid 		adapter_luid;
+#ifdef __KERNEL__
+	__u32			*buffer;
+#else
+	__u64			buffer;
+#endif
+	__u64			buffer_count;
+};
+
 struct d3dkmt_invalidatecache {
 	struct d3dkmthandle	device;
 	struct d3dkmthandle	allocation;
@@ -1718,5 +1728,7 @@ struct d3dkmt_invalidatecache {
 	_IOWR(0x47, 0x46, struct d3dkmt_waitsyncfile)
 #define LX_DXOPENSYNCOBJECTFROMSYNCFILE	\
 	_IOWR(0x47, 0x47, struct d3dkmt_opensyncobjectfromsyncfile)
+#define LX_DXENUMPROCESSES	\
+	_IOWR(0x47, 0x48, struct d3dkmt_enumprocesses)
 
 #endif /* _D3DKMTHK_H */

