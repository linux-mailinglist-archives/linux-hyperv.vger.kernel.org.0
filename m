Return-Path: <linux-hyperv+bounces-9576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJNXI+lbvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9576-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB32D211C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47ED9317C756
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47323F7E8B;
	Thu, 19 Mar 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxxTcgZt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC5387368
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951922; cv=none; b=duorW7OQx33ZVLRu7UjATWfOhInlFYPtNMRDW0Kck3mGVnxlBuRUAQeyhuWuiDnvY9VN1KB5eVjmZkMZzAiByxm8JsW4y6GCb9egjLdYbgLh6wgf+tvbGyxrZSR9xkuRDRq3kHiUoygT478fgG6FJ8C5AwgKRQ5gT+mI9vdLRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951922; c=relaxed/simple;
	bh=qGghHzSatalMogZ7g0RJU9cqxZSAkZm+ZhQKC+AJAtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5B7Uo4dV8hORt+B7VxOT5nZBC/0AabGYw+dIQoy9q4HVPVzuz+z8OGpY9wB42C6RpvaashfyPDgnT3tCyYb/LQBNBl/t80Unrb9O4lS8KbJHuOrEbKmjDBZvEpWZPAMOR3nU5d1JlbxEwTTyf+b2+OsFCJt2wAJPDGh8rAz8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxxTcgZt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so1071421f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951919; x=1774556719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RvrOs3oIfDFuvp3whx4JprpZOSJFy7Rydge9ZS5yPI=;
        b=bxxTcgZtX3Y0+iAAeqIzz1b7En2aM2NixnGmS3ILcrrM93Hc+T/wDJO7Sn8ROJiW/f
         rT3uvL8LUzeGp8Mh5qRblPDt2xM6GcYd45Utg5n6hObU++cJAYTp4QCYG03SG9rG0pNw
         8sYSgdzynOYVpR5YdYiDM9qQ8ABahmbgF36KPLCG6XeAmnv+q34dOw91EXctHg+KNZpf
         fAjwys6HQ4eBHuxeHRzKG74L0VNSI1v6CEb/YpGHG7hcJLDM7WG8G+s4LqhTF7uqxUge
         7bxraZN48p2Zdnd3IfExRKAcCD28o7QPjCAVlcCimW2oWnqgmZU6+bKRKncGQRtTXG1+
         EQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951919; x=1774556719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RvrOs3oIfDFuvp3whx4JprpZOSJFy7Rydge9ZS5yPI=;
        b=sKcwUljEE+V4X3akcH3Jywj+LavyMceP1D0G7U2hgH6RuTBTmYDJojXDYKGbchK/LE
         dkN9vf7H8LxPUvgCl63eog1HtHGQ9O6LbRZXAbD0z5EIRdAntcrvDpo08KWRgGfo83Cm
         oiRDPcJ4iIq8S2pO6YWf0O12FSNNEnZu5OPge7lirBx/TSY0eFZ8IVmyjkbllXQPkD5l
         p2CWVCrQgWnrxquoOEfB/SocCEfA8KjhA1EUIjmC8LV9AQcBrIUwP73vZpPsRNFWuNt7
         Qn7PftAjTq9RGoAtkrFBi4DKmWJMmcoGdNcEc3EvF1oKcepCl9KEa8zR7C868w5qOhfe
         qfcg==
X-Gm-Message-State: AOJu0YwZ60m1DLixdk2o0l+i93h6aoz4apfF8PpT14ip7ziS+LJmLj9G
	iBUNVobqAy7xXe9x/71h9fimDKKezZrYBZT1FrgMOj5pYYzrOYq2E3U0yC9OFPjdWJU=
X-Gm-Gg: ATEYQzyVgOWKiy7308k5+KyV6Lmd8yRLjElkxvQa/ZQt1iR5mHRtHnJvQR9Y9wWRlWX
	Dt5D/45g9TtRPLaYDicPYI/ZCCSDp4L9BZReOlJeY9pi4iqsnmnryyWIa7Ti/oocEMFzE/Lf6VI
	u7QGBlElCNV3inZjW4eOOp8PdCmKMFhvcDAYIeyzZW0WrgqzhosATHmU5aDm6cnf7mTZTZZ6DLU
	aFB4sPsnlVp5wAPdj4quCy6DF7437F8NA/3Zix7gCDBfDi56kf7mFGw4vLJRFOjpVyBZNPLNqfM
	GKpNod1Vn7Hm17ma8dVAjqpcfkZYJu9lsE5J0TQBELxBs2zl6Q6DjQwLkRfSOpaSjRN1nT5af/L
	1GbY6uomyz/045QJpsbRk3ooxzmexL+vFWWZFrVB85SzsgNvfO+i1cupxIJdNV/vTKEc3GvTZ7j
	+47SppUdgeiaLdux7yuMzPT9Ml0GtAvX98n1N4rwphhyC0qWA/MM87ENvnTOQ=
X-Received: by 2002:a05:6000:2409:b0:439:c078:9a57 with SMTP id ffacd0b85a97d-43b6428769cmr1354629f8f.25.1773951918685;
        Thu, 19 Mar 2026 13:25:18 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:17 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 05/55] drivers: hv: dxgkrnl: Enumerate and open dxgadapter objects
Date: Thu, 19 Mar 2026 20:24:19 +0000
Message-ID: <20260319202509.63802-6-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9576-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.968];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7FB32D211C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to enumerate dxgadapter objects:
  - The LX_DXENUMADAPTERS2 ioctl
  - The LX_DXENUMADAPTERS3 ioctl.

Implement ioctls to open adapter by LUID and to close adapter
handle:
  - The LX_DXOPENADAPTERFROMLUID ioctl
  - the LX_DXCLOSEADAPTER ioctl

Impllement the ioctl to query dxgadapter information:
  - The LX_DXQUERYADAPTERINFO ioctl

When a dxgadapter is enumerated, it is implicitely opened and
a handle (d3dkmthandle) is created in the current process handle
table. The handle is returned to the caller and can be used
by user mode to reference the VGPU adapter in other ioctls.

The caller is responsible to close the adapter when it is not
longer used by sending the LX_DXCLOSEADAPTER ioctl.

A dxgprocess has a list of opened dxgadapter objects
(dxgprocess_adapter is used to represent the entry in the list).
A dxgadapter also has a list of dxgprocess_adapter objects.
This is needed for cleanup because either a process or an adapter
could be destroyed first.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgmodule.c |   3 +
 drivers/hv/dxgkrnl/ioctl.c     | 482 ++++++++++++++++++++++++++++++++-
 2 files changed, 484 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 17c22001ca6c..fbe1c58ecb46 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -721,6 +721,9 @@ static struct dxgglobal *dxgglobal_create(void)
 
 	init_rwsem(&dxgglobal->channel_lock);
 
+#ifdef DEBUG
+	dxgk_validate_ioctls();
+#endif
 	return dxgglobal;
 }
 
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 60e38d104517..b08ea9430093 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -29,8 +29,472 @@ struct ioctl_desc {
 	u32 arg_size;
 };
 
-static struct ioctl_desc ioctls[] = {
+#ifdef DEBUG
+static char *errorstr(int ret)
+{
+	return ret < 0 ? "err" : "";
+}
+#endif
+
+static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
+					void *__user inargs)
+{
+	struct d3dkmt_openadapterfromluid args;
+	int ret;
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_openadapterfromluid *__user result = inargs;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("Faled to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			if (*(u64 *) &entry->luid ==
+			    *(u64 *) &args.adapter_luid) {
+				ret = dxgprocess_open_adapter(process, entry,
+						&args.adapter_handle);
+
+				if (ret >= 0) {
+					ret = copy_to_user(
+						&result->adapter_handle,
+						&args.adapter_handle,
+						sizeof(struct d3dkmthandle));
+					if (ret)
+						ret = -EINVAL;
+				}
+				adapter = entry;
+			}
+			dxgadapter_release_lock_shared(entry);
+			if (adapter)
+				break;
+		}
+	}
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	if (args.adapter_handle.v == 0)
+		ret = -EINVAL;
+
+cleanup:
+
+	if (ret < 0)
+		dxgprocess_close_adapter(process, args.adapter_handle);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkp_enum_adapters(struct dxgprocess *process,
+		    union d3dkmt_enumadapters_filter filter,
+		    u32 adapter_count_max,
+		    struct d3dkmt_adapterinfo *__user info_out,
+		    u32 * __user adapter_count_out)
+{
+	int ret = 0;
+	struct dxgadapter *entry;
+	struct d3dkmt_adapterinfo *info = NULL;
+	struct dxgadapter **adapters = NULL;
+	int adapter_count = 0;
+	int i;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	if (info_out == NULL || adapter_count_max == 0) {
+		ret = copy_to_user(adapter_count_out,
+				   &dxgglobal->num_adapters, sizeof(u32));
+		if (ret) {
+			DXG_ERR("copy_to_user faled");
+			ret = -EINVAL;
+		}
+		goto cleanup;
+	}
+
+	if (adapter_count_max > 0xFFFF) {
+		DXG_ERR("too many adapters");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	info = vzalloc(sizeof(struct d3dkmt_adapterinfo) * adapter_count_max);
+	if (info == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapters = vzalloc(sizeof(struct dxgadapter *) * adapter_count_max);
+	if (adapters == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
 
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			struct d3dkmt_adapterinfo *inf = &info[adapter_count];
+
+			ret = dxgprocess_open_adapter(process, entry,
+						      &inf->adapter_handle);
+			if (ret >= 0) {
+				inf->adapter_luid = entry->luid;
+				adapters[adapter_count] = entry;
+				DXG_TRACE("adapter: %x %x:%x",
+					inf->adapter_handle.v,
+					inf->adapter_luid.b,
+					inf->adapter_luid.a);
+				adapter_count++;
+			}
+			dxgadapter_release_lock_shared(entry);
+		}
+		if (ret < 0)
+			break;
+	}
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	if (adapter_count > adapter_count_max) {
+		ret = STATUS_BUFFER_TOO_SMALL;
+		DXG_TRACE("Too many adapters");
+		ret = copy_to_user(adapter_count_out,
+				   &dxgglobal->num_adapters, sizeof(u32));
+		if (ret) {
+			DXG_ERR("copy_to_user failed");
+			ret = -EINVAL;
+		}
+		goto cleanup;
+	}
+
+	ret = copy_to_user(adapter_count_out, &adapter_count,
+			   sizeof(adapter_count));
+	if (ret) {
+		DXG_ERR("failed to copy adapter_count");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(info_out, info, sizeof(info[0]) * adapter_count);
+	if (ret) {
+		DXG_ERR("failed to copy adapter info");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret >= 0) {
+		DXG_TRACE("found %d adapters", adapter_count);
+		goto success;
+	}
+	if (info) {
+		for (i = 0; i < adapter_count; i++)
+			dxgprocess_close_adapter(process,
+						 info[i].adapter_handle);
+	}
+success:
+	if (info)
+		vfree(info);
+	if (adapters)
+		vfree(adapters);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_enumadapters2 args;
+	int ret;
+	struct dxgadapter *entry;
+	struct d3dkmt_adapterinfo *info = NULL;
+	struct dxgadapter **adapters = NULL;
+	int adapter_count = 0;
+	int i;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.adapters == NULL) {
+		DXG_TRACE("buffer is NULL");
+		args.num_adapters = dxgglobal->num_adapters;
+		ret = copy_to_user(inargs, &args, sizeof(args));
+		if (ret) {
+			DXG_ERR("failed to copy args to user");
+			ret = -EINVAL;
+		}
+		goto cleanup;
+	}
+	if (args.num_adapters < dxgglobal->num_adapters) {
+		args.num_adapters = dxgglobal->num_adapters;
+		DXG_TRACE("buffer is too small");
+		ret = -EOVERFLOW;
+		goto cleanup;
+	}
+
+	if (args.num_adapters > D3DKMT_ADAPTERS_MAX) {
+		DXG_TRACE("too many adapters");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	info = vzalloc(sizeof(struct d3dkmt_adapterinfo) * args.num_adapters);
+	if (info == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapters = vzalloc(sizeof(struct dxgadapter *) * args.num_adapters);
+	if (adapters == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			struct d3dkmt_adapterinfo *inf = &info[adapter_count];
+
+			ret = dxgprocess_open_adapter(process, entry,
+						      &inf->adapter_handle);
+			if (ret >= 0) {
+				inf->adapter_luid = entry->luid;
+				adapters[adapter_count] = entry;
+				DXG_TRACE("adapter: %x %llx",
+					inf->adapter_handle.v,
+					*(u64 *) &inf->adapter_luid);
+				adapter_count++;
+			}
+			dxgadapter_release_lock_shared(entry);
+		}
+		if (ret < 0)
+			break;
+	}
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	args.num_adapters = adapter_count;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy args to user");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(args.adapters, info,
+			   sizeof(info[0]) * args.num_adapters);
+	if (ret) {
+		DXG_ERR("failed to copy adapter info to user");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (info) {
+			for (i = 0; i < args.num_adapters; i++) {
+				dxgprocess_close_adapter(process,
+							info[i].adapter_handle);
+			}
+		}
+	} else {
+		DXG_TRACE("found %d adapters", args.num_adapters);
+	}
+
+	if (info)
+		vfree(info);
+	if (adapters)
+		vfree(adapters);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_enum_adapters3(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_enumadapters3 args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgkp_enum_adapters(process, args.filter,
+				  args.adapter_count,
+				  args.adapters,
+				  &((struct d3dkmt_enumadapters3 *)inargs)->
+				  adapter_count);
+
+cleanup:
+
+	DXG_TRACE("ioctl: %s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_close_adapter(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmthandle args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgprocess_close_adapter(process, args);
+	if (ret < 0)
+		DXG_ERR("failed to close adapter: %d", ret);
+
+cleanup:
+
+	DXG_TRACE("ioctl: %s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_query_adapter_info(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryadapterinfo args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.private_data_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args.private_data_size == 0) {
+		DXG_ERR("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	DXG_TRACE("Type: %d Size: %x", args.type, args.private_data_size);
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_query_adapter_info(process, adapter, &args);
+
+	dxgadapter_release_lock_shared(adapter);
+
+cleanup:
+
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static struct ioctl_desc ioctls[] = {
+/* 0x00 */	{},
+/* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
+/* 0x02 */	{},
+/* 0x03 */	{},
+/* 0x04 */	{},
+/* 0x05 */	{},
+/* 0x06 */	{},
+/* 0x07 */	{},
+/* 0x08 */	{},
+/* 0x09 */	{dxgkio_query_adapter_info, LX_DXQUERYADAPTERINFO},
+/* 0x0a */	{},
+/* 0x0b */	{},
+/* 0x0c */	{},
+/* 0x0d */	{},
+/* 0x0e */	{},
+/* 0x0f */	{},
+/* 0x10 */	{},
+/* 0x11 */	{},
+/* 0x12 */	{},
+/* 0x13 */	{},
+/* 0x14 */	{dxgkio_enum_adapters, LX_DXENUMADAPTERS2},
+/* 0x15 */	{dxgkio_close_adapter, LX_DXCLOSEADAPTER},
+/* 0x16 */	{},
+/* 0x17 */	{},
+/* 0x18 */	{},
+/* 0x19 */	{},
+/* 0x1a */	{},
+/* 0x1b */	{},
+/* 0x1c */	{},
+/* 0x1d */	{},
+/* 0x1e */	{},
+/* 0x1f */	{},
+/* 0x20 */	{},
+/* 0x21 */	{},
+/* 0x22 */	{},
+/* 0x23 */	{},
+/* 0x24 */	{},
+/* 0x25 */	{},
+/* 0x26 */	{},
+/* 0x27 */	{},
+/* 0x28 */	{},
+/* 0x29 */	{},
+/* 0x2a */	{},
+/* 0x2b */	{},
+/* 0x2c */	{},
+/* 0x2d */	{},
+/* 0x2e */	{},
+/* 0x2f */	{},
+/* 0x30 */	{},
+/* 0x31 */	{},
+/* 0x32 */	{},
+/* 0x33 */	{},
+/* 0x34 */	{},
+/* 0x35 */	{},
+/* 0x36 */	{},
+/* 0x37 */	{},
+/* 0x38 */	{},
+/* 0x39 */	{},
+/* 0x3a */	{},
+/* 0x3b */	{},
+/* 0x3c */	{},
+/* 0x3d */	{},
+/* 0x3e */	{dxgkio_enum_adapters3, LX_DXENUMADAPTERS3},
+/* 0x3f */	{},
+/* 0x40 */	{},
+/* 0x41 */	{},
+/* 0x42 */	{},
+/* 0x43 */	{},
+/* 0x44 */	{},
+/* 0x45 */	{},
 };
 
 /*
@@ -82,3 +546,19 @@ long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2)
 	DXG_TRACE("unlocked ioctl %x Code:%d", p1, _IOC_NR(p1));
 	return dxgk_ioctl(f, p1, p2);
 }
+
+#ifdef DEBUG
+void dxgk_validate_ioctls(void)
+{
+	int i;
+
+	for (i=0; i < ARRAY_SIZE(ioctls); i++)
+	{
+		if (ioctls[i].ioctl && _IOC_NR(ioctls[i].ioctl) != i)
+		{
+			DXG_ERR("Invalid ioctl");
+			DXGKRNL_ASSERT(0);
+		}
+	}
+}
+#endif

