Return-Path: <linux-hyperv+bounces-10640-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBy1FlmQ+mk4PwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10640-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 02:50:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F84D5055
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 02:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E695A3026C1A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA441FDE31;
	Wed,  6 May 2026 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qns8Ux4Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F11FF1B4
	for <linux-hyperv@vger.kernel.org>; Wed,  6 May 2026 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028596; cv=none; b=LdPgPsSo2yUvxlRibZ2vVKwt88RifwvzZoga5SH2BuabQY2W1FrdA2DXhQukX4Wdg5nQ6sv4upi8nNE0bwWZwIi34b165b/e+6v3M7BsdI+v+IRoWCNwZVBM7D55l7uC2vVqcGgP6KTK2Md4khU7bP0VVQQAnAbG+yL4By3AIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028596; c=relaxed/simple;
	bh=Gpf4+9j34oWL5b+b4x1Cubu9uotpYGvejQwqPSNXU0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH8ekYGg39Jti31xuHn/WMhsI22y4aN6T8rQlftn3LoP9b6vLOey9VV75WFNiKmseN3PAqlT0+LwTRD4pxfSz5JBvHLAQJPChSy54xLWz75WW5fb99jiZVff2DkNH4eaKSF7X88t97fWTmDBhp1+Kcf5/KeUy3B3Dfk3ptoEreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qns8Ux4Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so6786094e87.2
        for <linux-hyperv@vger.kernel.org>; Tue, 05 May 2026 17:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778028593; x=1778633393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6UNs94UMqznxX8WUEPi0/pShC6Mhozsqf9EWZvlU28=;
        b=qns8Ux4Q5XlmnvXGvcJLQyxk0+dWY/e/PwZ+VVVmY81/DqO6D4mVkXIBr5omVL3+uM
         AnHFKUajoDyKAwKzbjWzem50cDZUrkMQYEoDX5IexVPyF1YWjjARrQRLAiWjiAT7Gl7l
         pjuy9xfdbdDFWfYz9hGGEexqURnCpwIa2rw1bICZrFpycwUOx5KYLURyzSibXtPUbUHq
         Tqhw1QmMX0p+3JaaNDWqOeLJTG3KyuxKLR/6Kq9R1QVyf5cEmnjkf5sFmVigAbRUwCYQ
         LyBiX+fS/yIqzWbtx5oIWdh/4MjBUp5dPsWR6hKXnsTAYRUYOP7yx7ZVuqxhPWVc/4Yk
         3Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028593; x=1778633393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6UNs94UMqznxX8WUEPi0/pShC6Mhozsqf9EWZvlU28=;
        b=QaEUAjpQO790yNvGYPnwgEkIi58c+qYHdyP8093hMbT0eS2nW6qZlOzDZQuGQ7/IW4
         gbj7xnAcq8arAcJqEhZeT9oxihLe8dBkcEcpnr38bG+krP2hgGtjeJTPYE5Dulc4ZykH
         gWu+Ft3xEKpfwW9QSACLy63tzFT7h8EmPwsN7PPUFM3Wt+JwnXSxFDJQWH/83y7oi2VL
         GNtDyJ2IKejKeAbGiR+p8ph5IEWX9takMCPY3DklG119DUKUUzr8DHdvtk9TJ9C7xzLX
         iGUUpRv3LiwPQw90arqk3ljk7PdY/bGRBPrj23sH96B6UxEu7wxEoZznKCKDkoTpRBRj
         2Zyg==
X-Forwarded-Encrypted: i=1; AFNElJ+nlmX6KzqD524zAjQU9uejPOxzhHvnnMV9loiKo6Mny/UXL6yN1uIBvSJp+o5t566ZvNo66fn6+UaWdGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjARZTauBqhpJGpzv3fQBz1tHOTZSPMmSWXEbqdzQrA92CTln
	nAlSLwLhT82rMUaMOCS3cl91g/YDpl7S11vWoDxZhMOzO1aLxV4un0dx
X-Gm-Gg: AeBDietWkga88XKDoA8VwvxeLqXiEGcrbH5Mcf+GHX6xO4DWJOgBqUycZpYJdeuTTKH
	aNFg64hVfSY6YIIsZeD4rWS3TYr1MPuv3gEeJ5Jk+Mn1bhAsvpR3hGVHBF1ZJ2QC4GSIrdAAt5q
	iCI1PWajkvpUwiqpXvjGiNItktmSmUI7fJ6TQTbcdkqJ4ikgi1+wcT61tRvtXCXZDkJfaZ0q2yk
	ZrfkrvWl93noYKcDwZEMQxUYB9X/OJuDHk40NqCWt+CRdhcIoislVmBjzUqpBFY2ygmggXu08qU
	Odl2hIZ6zczbzVhUd+ITHVfAAY/sTfVc2kYo3AM4tiidj3DPaHJxY5gUOP2NBz7GPddJbrC489u
	nvvJ7NBFF5Xhr9zrZwU+wH0fNFcCNhQebZluCZ0GdtDkPZfM7jIPlfyGs7KAWCf4+cOzUiIilY7
	+HnRkMxytUKGaEchOJryhkLOuQp6ly3XBOvLhF+y8vpdHChpAmmL7xpdVDqqueZ3Dnf795Ynz4S
	FQ=
X-Received: by 2002:a05:6512:1293:b0:5a8:82f5:8d1e with SMTP id 2adb3069b0e04-5a887ae6596mr317478e87.17.1778028593080;
        Tue, 05 May 2026 17:49:53 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c230e5asm4379424e87.33.2026.05.05.17.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 17:49:51 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	longli@microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com
Subject: [PATCH v2] scsi: storvsc: Replace symbolic permissions with octal
Date: Wed,  6 May 2026 03:49:48 +0300
Message-ID: <20260506004948.2172-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC0F84D5055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10640-lists,linux-hyperv=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shofiqtest@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Symbolic permissions like S_IRUGO and S_IWUSR are not preferred by
checkpatch. Replace with their octal equivalents:

  - S_IRUGO|S_IWUSR -> 0644
  - S_IRUGO         -> 0444

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6977ca8a0..571ea5491 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -156,7 +156,7 @@ static bool hv_dev_is_fc(struct hv_device *hv_dev);
 #define STORVSC_LOGGING_WARN	2
 
 static int logging_level = STORVSC_LOGGING_ERROR;
-module_param(logging_level, int, S_IRUGO|S_IWUSR);
+module_param(logging_level, int, 0644);
 MODULE_PARM_DESC(logging_level,
 	"Logging level, 0 - None, 1 - Error (default), 2 - Warning.");
 
@@ -345,17 +345,17 @@ static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 static int storvsc_vcpus_per_sub_channel = 4;
 static unsigned int storvsc_max_hw_queues;
 
-module_param(storvsc_ringbuffer_size, int, S_IRUGO);
+module_param(storvsc_ringbuffer_size, int, 0444);
 MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
 module_param(storvsc_max_hw_queues, uint, 0644);
 MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware queues");
 
-module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
+module_param(storvsc_vcpus_per_sub_channel, int, 0444);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
 
 static int ring_avail_percent_lowater = 10;
-module_param(ring_avail_percent_lowater, int, S_IRUGO);
+module_param(ring_avail_percent_lowater, int, 0444);
 MODULE_PARM_DESC(ring_avail_percent_lowater,
 		"Select a channel if available ring size > this in percent");
 
-- 
2.54.0.windows.1


