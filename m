Return-Path: <linux-hyperv+bounces-2003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830D8AA81F
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 07:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DE61C210F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4674B666;
	Fri, 19 Apr 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r6B0P9eN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918DAC2D6;
	Fri, 19 Apr 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506268; cv=none; b=HuMG0pQ3jxOKLTMSw7to0U8FfP2BKsf+DxsPdHx9ELC17SAp+cScAcRiI2Ces6D9X6OL3J7jRTedW2yuzG2gckaQfJ/kkwIm3sx42nS2Mi/7yQknC66F4YTOw6RAzufROknKChUP3uICWXZvh29p7fx4+rR9JgIBMSDunO+VLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506268; c=relaxed/simple;
	bh=z201jFrS5jKsZKS6W4JbGz0MWMjnlrTns08t9Q853po=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A1m4DaI/6OFmZVOzAOBDrOu0sQr3tt5JYye9G/rurBvIX3TmQQq9rHRmx/xtfeTZyrqlN+9u3MZ1Fq+YdtR9zUuB/sB+HJ622EnO+13vD4L4hdm1Auei3HgYi1agIple+6HXrE7I+o4Y4+xly63uoJKXmtKbocXGXixXiAqzf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r6B0P9eN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7176A20FD937; Thu, 18 Apr 2024 22:57:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7176A20FD937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713506261;
	bh=+ZB7e7XUe5wkh7tS8rGga34HlZkrVOtd1SGLeJlloyw=;
	h=From:To:Cc:Subject:Date:From;
	b=r6B0P9eNHYfL8Eln2mmTF6UxcVFR1zOPHRLT9COPU9WZu8v/C59hpfUO/CmAnBRAh
	 wvrIwWayjRRKawXSxcd5/lYl9xmBG2lOmmnsU6GlSA98uHIOhsmOWfHr07L2A9FXaJ
	 8wNyWnMvJmB4u7hO/a1w+ipPwmMPykYvPKZ/fFXA=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH] hv/vmbus_drv: rename hv_acpi_init() to vmbus_init()
Date: Thu, 18 Apr 2024 22:56:49 -0700
Message-Id: <1713506209-937-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

As the driver now supports both ACPI and DeviceTree,
rename hv_acpi_init() to vmbus_init() and
change comments accordingly.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a707ab73f8..e140cbf8d4c7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2609,7 +2609,7 @@ static struct syscore_ops hv_synic_syscore_ops = {
 	.resume = hv_synic_resume,
 };
 
-static int __init hv_acpi_init(void)
+static int __init vmbus_init(void)
 {
 	int ret;
 
@@ -2620,7 +2620,7 @@ static int __init hv_acpi_init(void)
 		return 0;
 
 	/*
-	 * Get ACPI resources first.
+	 * Get VMBus resources first.
 	 */
 	ret = platform_driver_register(&vmbus_platform_driver);
 	if (ret)
@@ -2707,5 +2707,5 @@ static void __exit vmbus_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V VMBus Driver");
 
-subsys_initcall(hv_acpi_init);
+subsys_initcall(vmbus_init);
 module_exit(vmbus_exit);
-- 
2.34.1


