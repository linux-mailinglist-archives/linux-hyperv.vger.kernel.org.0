Return-Path: <linux-hyperv+bounces-9623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA2QIqJfvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9623-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:42:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E044F2D2517
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2640932F473D
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E77406269;
	Thu, 19 Mar 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcgHMAuy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0F4035BB
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951974; cv=none; b=LM57PR9R2yHeuLB1DljNwxZECTEr3vpvmN4bcy6Kcr6Vwx0OTc1xaKUoOdmqCNfoCh8N/tDmlSMdzB03I63icgWDdmeAJQLMN4+ZPulnYpVvm9YJa++LSAJhQODDrxYLdTrPWBIx20sdMXngsuErKwpa51miH9dA8ot6PeV+wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951974; c=relaxed/simple;
	bh=outTnRIBQAyg28okb66wf80x45Mq14FYSPhGHqeYDkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCVdMMKlSIkT2kInR/TupEBqTh6D7LCmiFj5TPc+qD6wu4ZIOboYAdJSbiFc7UcSsF43iywBtSnqhtIlRccBkCg4k7Waux09Kws4pGwhYftv5QCsXv1h35omadNvrb9jNmhDHa64/n2bMQyBhc8hipovb94wP55ezcnzwZ0eoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcgHMAuy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1478201f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951971; x=1774556771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZHA0FJqnrMUZiDF+/x51qEC2Ygiwx2MeXeyqpq00vs=;
        b=RcgHMAuyJ8YvIZIq+2P28HVdGFD6nmf2vvZ5VMckttp9d38qdL6LB8t+UVJc5kYSS3
         CTaX6ph9Po40Kou7I4kEEN7DeDjEclynwT3wgQ6LZD9pUGuoa9H8jJq8re2v7nDxEby6
         pBsXdg14a1kaut+xfe8xiVHW7DFaiUOwhusg0D/vkqPZPve8oX+EmH1oPDjngo527RlM
         YLfEW2eemq7fqGmBMmdcPULngCrKhmvAQGltpMwoRDmQqrw4W3YLVvA6rx+mrP9/HUa5
         eF5KHeUacMz9wphgA0zqI8YUjWGFFs9LLsAW5vPuZvZIQi37DPoD16vB0R7k3gOiK+Ym
         JHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951971; x=1774556771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZHA0FJqnrMUZiDF+/x51qEC2Ygiwx2MeXeyqpq00vs=;
        b=oD+UAVaaTScQ11yZVK3nO3EfXpO0OwCbzdAt3jMyrcvnGujsoATgdBTW2N7bMMAn/0
         5MAOVdDqo960SiAbmY92bGCI3XgeMxORDk/Rrn4H4muTzNYhTNocvXGB/2MlC3p+kp0L
         EUOoIk48u16nHfnAkXawUAE38CMWMBOXlipgPCngA/G2gQN2m0VNBN8MRNgoEGyB6GaU
         5+E7cxaQuOq/xoz4X/Eyk7365Aqx7PcuMPgZqs3qU/hIdouUkOEVk7c3/H2zlsUD7Hc1
         fkPMKy4COGA6pj6RUI7h8SeeMG1IFyEofeD5A2wAFATeUEe0UTY00Ti/AgPZ6JElmC8U
         dikg==
X-Gm-Message-State: AOJu0Yyz1jB1vWwfAI37bUa3j7vm0e1NVy2a4xV9+XAl7h8ZyjQnjJmI
	yFLUOSdew5JePBoMvq/JFRlZgIbG2DMMy9yUcj43/yVvURycM9KRTqS39W5LsS2FoB4=
X-Gm-Gg: ATEYQzxLz0JxwAij7v8XPIAFdGNVxD6kB17nu4BbO+lH5EO9Yd5u4xMdIIpAezvVpAW
	l/x0r2K7RXaMoDWMxkvAGr1N964tDSyChk7QAKpaxtWPA1DMmheOHmF5GNJw4yrLHwKFjxWjqf+
	xf3d7VuNvVHsTaAhsO7N6GrxT32Ep3x4irBXegSls48VwlifHhYo+hVSH+HTt/b3eJAr1ZACB/h
	iNVx4uV7eqZSMq9K74ZBE0EdmRWqY+/OD3SScHk+3FKoZXuZUpq9n83dUP7Pebnr3BjKQA8WRSl
	tyIOjHvdjsGtzkqYlOBh7dsbJVvyBvQ7499xjWe9aK6QOZfT74wIzIsHecY9O2ulVnhiiuXjaRQ
	OUkkQILSAYCKNriXHZ7+h3Y1VIFVULOaYpRmNqr3isN+KmKfOAs3NqyFxJ9ZZzaGjmTyQndycs3
	MoG6gFBjkxBPq+RWbKYWMRfvoH7VyNMWvjZMaVSopM2vhguTz8
X-Received: by 2002:a05:6000:24c4:b0:43b:45d1:f449 with SMTP id ffacd0b85a97d-43b6427cde9mr1224789f8f.51.1773951970522;
        Thu, 19 Mar 2026 13:26:10 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:10 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 51/55] drivers: hv: dxgkrnl: Implement D3DKMTEnumProcesses to match the Windows implementation
Date: Thu, 19 Mar 2026 20:25:05 +0000
Message-ID: <20260319202509.63802-52-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9623-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: E044F2D2517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

The behavior of D3DKMTEnumProcesses on Windows is that when buffer_count is 0 or
input buffer is NULL, the number of active processes is returned. The Linux implemenation
is updated to match this.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgmodule.c |  2 +-
 drivers/hv/dxgkrnl/ioctl.c     | 29 ++++++++++++++++++-----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index e3ac70df1b6f..8f5d6db256a3 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -965,4 +965,4 @@ module_exit(dxg_drv_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual compute device Driver");
-MODULE_VERSION("2.0.2");
+MODULE_VERSION("2.0.3");
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index f8f116a7f87f..42f3de31a63c 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -5373,7 +5373,7 @@ dxgkio_enum_processes(struct dxgprocess *process, void *__user inargs)
 	struct dxgprocess_adapter *pentry;
 	int nump = 0;	/* Current number of processes*/
 	struct ntstatus status;
-	int ret;
+	int ret, ret1;
 
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
@@ -5382,12 +5382,6 @@ dxgkio_enum_processes(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 	}
 
-	if (args.buffer_count == 0) {
-		DXG_ERR("Invalid buffer count");
-		ret = -EINVAL;
-		goto cleanup;
-	}
-
 	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
 	dxgglobal_acquire_process_adapter_lock();
 
@@ -5405,6 +5399,19 @@ dxgkio_enum_processes(struct dxgprocess *process, void *__user inargs)
 		goto cleanup_locks;
 	}
 
+	list_for_each_entry(pentry, &adapter->adapter_process_list_head,
+			    adapter_process_list_entry) {
+		if (pentry->process->nspid == task_active_pid_ns(current))
+			nump++;
+	}
+
+	if (nump > args.buffer_count || args.buffer == NULL) {
+		status.v = STATUS_BUFFER_TOO_SMALL;
+		ret = ntstatus2int(status);
+		goto cleanup_locks;
+	}
+
+	nump = 0;
 	list_for_each_entry(pentry, &adapter->adapter_process_list_head,
 			    adapter_process_list_entry) {
 		if (pentry->process->nspid != task_active_pid_ns(current))
@@ -5429,10 +5436,10 @@ dxgkio_enum_processes(struct dxgprocess *process, void *__user inargs)
 	dxgglobal_release_process_adapter_lock();
 	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
 
-	if (ret == 0) {
-		ret = copy_to_user(&input->buffer_count, &nump, sizeof(u32));
-		if (ret)
-			DXG_ERR("failed to copy buffer count to user");
+	ret1 = copy_to_user(&input->buffer_count, &nump, sizeof(u32));
+	if (ret1) {
+		DXG_ERR("failed to copy buffer count to user");
+		ret = -EFAULT;
 	}
 
 cleanup:

