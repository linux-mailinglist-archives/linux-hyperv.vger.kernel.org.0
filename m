Return-Path: <linux-hyperv+bounces-3270-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E8C9BF1EE
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21AA28579C
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97EF204934;
	Wed,  6 Nov 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXMcC7lV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E212038C6;
	Wed,  6 Nov 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907795; cv=none; b=ljdbvTw/+Nr/aKl0rVpwYCcnz9yAyUub8DsZGA2Q7cL7r1FAQPYymzWq16XEa22reWmLiAjhCOSDRMjMT2mG7CI2jEr1Cd4AHDnTiS3Qo/cMKCpyjRAb8erVJzOJEyEbCGQd67OMt81ri5hAHRDh4fd2Q2rZ4HbBnp4YD3qoqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907795; c=relaxed/simple;
	bh=XGi7BRfY0KVls2acmoQQYaBUdaC8qiG96OclMknjWwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t10uIrCZ0z5okJxk5ONIGloR+vePo0yZejqx6CnG3ypP20vcDTscy5PwectSNqdGDaBoTSdbRMZsg5arzWepq2S6Rh1dtD3Isl1RGWNS5EGYr/VKDC3NgznTbLNEVHXgFfoQq31ImnOsHIOyghVGv6w9tcSDJrpNPT9+8Z+WFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXMcC7lV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso5398027b3a.3;
        Wed, 06 Nov 2024 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907793; x=1731512593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wtS8KUZc7HiS+6QKE3XMtdxXK2mRPt/KTa43TMAkQcA=;
        b=QXMcC7lVbO/zIaaRHSlou3KjguNmsVXk8hsaLYYx8PqGx8ZTgpfzbmEyoKT9m67IFL
         c2ds4PI7ThZlIYnLaLBXW45EzK0ABl8KasomJIoNFeLznI1tk5Z4bXAe04jd5DWrKLD1
         PmGcPbhlBZ/KtHzd8UONzKB+zg3+pRSx0adRKEtVg9lF4rhQ/ZgujIkrNKltM/1hYcy9
         1ccHd0rGXJfOqi5sSi0i6EPK+LoGUghfDdpzCx5YG5Bx+ihqUtVWIKBQEyi8V0js7GiZ
         s8gwX1oW/3Ed31Mhzj7HBtz0N3Mu7r44PObiGyjOn3jFIdA1WrGcZpwwuFRuuSx7/6Pw
         /njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907793; x=1731512593;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtS8KUZc7HiS+6QKE3XMtdxXK2mRPt/KTa43TMAkQcA=;
        b=Hkrh/Cvbu0h8nrGsIj2AvyQ/x2juUSxnOWLrft3xLMZ0fgR/55B2zOh+lOnO4ACxWD
         wSySGyFOQTdPcZpbCBiB31ISqFYr3Q2QcVYvsOwY5m253SJ704VIqYhsq85r2DpJCO+f
         IyxKHumodIKtzIMa2pwzbwLX/H+wpcIIWogaqs6oYvqBTR7uZjLdqcLVvEB5BuM4e4ea
         pUos8SUZ63CKizAJ919zbnRtSWPtuVlX0VyjykVbtYxe9ySCs542bK+CS9UprlEkUo/w
         N1169UatqjqY2w8qlbe/fpRPzTnt1RkxhfS3MtWcUD5SQMccAtBmIsmFVLpKDF+OO7Dy
         P/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXS9mUhOSTRcx2jlFyub42/a9CTN7fOToDShQoszTIUR/DpI+T0oYwKTZ186x7FlX5LIu6B/GOUzqxmnBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjh5QA3U4qfDymmZTzpoiFDi2vzJYAlXiLa0xVafG6nqEllIwd
	weB4vyh+k0rMj0O4FxV42iE920IcUiUdu4ImgK+PWNAw66ZHwEmND+qz8A==
X-Google-Smtp-Source: AGHT+IGEZsipgsh26rteEWDDgOowRw9ntHlN6sgpT6c1G/w19NjxozpuOnI/4lVzayWkvp0lmz7kgA==
X-Received: by 2002:a05:6a00:2389:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-72062f82516mr53113858b3a.6.1730907792490;
        Wed, 06 Nov 2024 07:43:12 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2e9203sm12159431b3a.142.2024.11.06.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:43:12 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet
Date: Wed,  6 Nov 2024 07:42:47 -0800
Message-Id: <20241106154247.2271-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106154247.2271-1-mhklinux@outlook.com>
References: <20241106154247.2271-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

If the KVP (or VSS) daemon starts before the VMBus channel's ringbuffer is
fully initialized, we can hit the panic below:

hv_utils: Registering HyperV Utility Driver
hv_vmbus: registering driver hv_utils
...
BUG: kernel NULL pointer dereference, address: 0000000000000000
CPU: 44 UID: 0 PID: 2552 Comm: hv_kvp_daemon Tainted: G E 6.11.0-rc3+ #1
RIP: 0010:hv_pkt_iter_first+0x12/0xd0
Call Trace:
...
 vmbus_recvpacket
 hv_kvp_onchannelcallback
 vmbus_on_event
 tasklet_action_common
 tasklet_action
 handle_softirqs
 irq_exit_rcu
 sysvec_hyperv_stimer0
 </IRQ>
 <TASK>
 asm_sysvec_hyperv_stimer0
...
 kvp_register_done
 hvt_op_read
 vfs_read
 ksys_read
 __x64_sys_read

This can happen because the KVP/VSS channel callback can be invoked
even before the channel is fully opened:
1) as soon as hv_kvp_init() -> hvutil_transport_init() creates
/dev/vmbus/hv_kvp, the kvp daemon can open the device file immediately and
register itself to the driver by writing a message KVP_OP_REGISTER1 to the
file (which is handled by kvp_on_msg() ->kvp_handle_handshake()) and
reading the file for the driver's response, which is handled by
hvt_op_read(), which calls hvt->on_read(), i.e. kvp_register_done().

2) the problem with kvp_register_done() is that it can cause the
channel callback to be called even before the channel is fully opened,
and when the channel callback is starting to run, util_probe()->
vmbus_open() may have not initialized the ringbuffer yet, so the
callback can hit the panic of NULL pointer dereference.

To reproduce the panic consistently, we can add a "ssleep(10)" for KVP in
__vmbus_open(), just before the first hv_ringbuffer_init(), and then we
unload and reload the driver hv_utils, and run the daemon manually within
the 10 seconds.

Fix the panic by reordering the steps in util_probe() so the char dev
entry used by the KVP or VSS daemon is not created until after
vmbus_open() has completed. This reordering prevents the race condition
from happening.

Reported-by: Dexuan Cui <decui@microsoft.com>
Fixes: e0fa3e5e7df6 ("Drivers: hv: utils: fix a race on userspace daemons registration")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:

v2 is a completely different approach to fixing the problem compared
to v1 [1]. v1 adds synchronization to deal with the race condition if
it happens. This v2 reorders initialization steps so the race condition
can never happen in the first place.

Note: we would also need to fix the fcopy driver code, but that has
been removed in commit ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
in the mainline kernel since v6.10. For old 6.x LTS kernels, and the 5.x
and 4.x LTS kernels, the fcopy driver needs to be fixed when the
fix is backported to the stable kernel branches.

[1] https://lore.kernel.org/linux-hyperv/20240909164719.41000-1-decui@microsoft.com/

 drivers/hv/hv_kvp.c       | 6 ++++++
 drivers/hv/hv_snapshot.c  | 6 ++++++
 drivers/hv/hv_util.c      | 9 +++++++++
 drivers/hv/hyperv_vmbus.h | 2 ++
 include/linux/hyperv.h    | 1 +
 5 files changed, 24 insertions(+)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..77017d951826 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -767,6 +767,12 @@ hv_kvp_init(struct hv_util_service *srv)
 	 */
 	kvp_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_kvp_init_transport(void)
+{
 	hvt = hvutil_transport_init(kvp_devname, CN_KVP_IDX, CN_KVP_VAL,
 				    kvp_on_msg, kvp_on_reset);
 	if (!hvt)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..397f4c8fa46c 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -388,6 +388,12 @@ hv_vss_init(struct hv_util_service *srv)
 	 */
 	vss_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_vss_init_transport(void)
+{
 	hvt = hvutil_transport_init(vss_devname, CN_VSS_IDX, CN_VSS_VAL,
 				    vss_on_msg, vss_on_reset);
 	if (!hvt) {
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 370722220134..36ee89c0358b 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -141,6 +141,7 @@ static struct hv_util_service util_heartbeat = {
 static struct hv_util_service util_kvp = {
 	.util_cb = hv_kvp_onchannelcallback,
 	.util_init = hv_kvp_init,
+	.util_init_transport = hv_kvp_init_transport,
 	.util_pre_suspend = hv_kvp_pre_suspend,
 	.util_pre_resume = hv_kvp_pre_resume,
 	.util_deinit = hv_kvp_deinit,
@@ -149,6 +150,7 @@ static struct hv_util_service util_kvp = {
 static struct hv_util_service util_vss = {
 	.util_cb = hv_vss_onchannelcallback,
 	.util_init = hv_vss_init,
+	.util_init_transport = hv_vss_init_transport,
 	.util_pre_suspend = hv_vss_pre_suspend,
 	.util_pre_resume = hv_vss_pre_resume,
 	.util_deinit = hv_vss_deinit,
@@ -611,6 +613,13 @@ static int util_probe(struct hv_device *dev,
 	if (ret)
 		goto error;
 
+	if (srv->util_init_transport) {
+		ret = srv->util_init_transport();
+		if (ret) {
+			vmbus_close(dev->channel);
+			goto error;
+		}
+	}
 	return 0;
 
 error:
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index d2856023d53c..52cb744b4d7f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -370,12 +370,14 @@ void vmbus_on_event(unsigned long data);
 void vmbus_on_msg_dpc(unsigned long data);
 
 int hv_kvp_init(struct hv_util_service *srv);
+int hv_kvp_init_transport(void);
 void hv_kvp_deinit(void);
 int hv_kvp_pre_suspend(void);
 int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
 
 int hv_vss_init(struct hv_util_service *srv);
+int hv_vss_init_transport(void);
 void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 22c22fb91042..02a226bcf0ed 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1559,6 +1559,7 @@ struct hv_util_service {
 	void *channel;
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
+	int (*util_init_transport)(void);
 	void (*util_deinit)(void);
 	int (*util_pre_suspend)(void);
 	int (*util_pre_resume)(void);
-- 
2.25.1


