Return-Path: <linux-hyperv+bounces-5271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3376AA57D9
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 00:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634C44E18A8
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA02248A4;
	Wed, 30 Apr 2025 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="a2mpgc2X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374E22331C;
	Wed, 30 Apr 2025 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050765; cv=none; b=fR2UpaTW4fR16C3GJNlDbvktuJHtU+3cKU/PpnUD2qkQ9iXeAyr0lPicqxTRg0Kzqba4rjBSJ8VWORdPIAIsI0dJQuqVn8XdbQIZMUt+BbGwZ2FoQ92KM4mwR9fYdW+ej/QujjpSidf4IR43rdbd1KxP0pb0HXJfwi8g+QO0ZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050765; c=relaxed/simple;
	bh=CcTWI7FuPMWJcnrhBbCO+CeRY9DtaORQiOzNsDkNitc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cO5wUkcOxOzuhCMPorzS/rGU14Du1JIA+fHDEc21s4HTqcTaSr11j+c52S6jTB5NVC5aSsGJMArVScqxmvdy2vgPRVKESeTR2M9OZFKacTj4h7yQQhqq4V3yqQokYBZLWxLcbFC+NXRhQl17hLnHq0acXJiiXtNRb/2DEHMJW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=a2mpgc2X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D3D6F204E7FD; Wed, 30 Apr 2025 15:06:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3D6F204E7FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746050761;
	bh=Tv99LGSGPSCu8e4+xjFTlVcnfQVc8DLTvncQgdvLHFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2mpgc2XJgLHFUTTxEns3eEN2FCDa6f/4gn0EFkCO7zuF/6nG0scerSL0jE908ewf
	 v90IqT/BD7mBctbrBFKZ7okYtrCRmwaB6tTNVPGgdOYpMAh/IGjEeBioObQfFqn1Ja
	 TfHgYO5cqTOLVK4KJE4tlypehLN+PSGTGyaowjPM=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [Patch v2 2/4] uio_hv_generic: Use correct size for interrupt and monitor pages
Date: Wed, 30 Apr 2025 15:05:56 -0700
Message-Id: <1746050758-6829-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
This can be different to the system page size.

This size is read and used by the user-mode program to determine the
mapped data region. An example of such user-mode program is the VMBUS
driver in DPDK.

Cc: stable@vger.kernel.org
Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 1b19b5647495..08385b04c4ab 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -287,13 +287,13 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[INT_PAGE_MAP].name = "int_page";
 	pdata->info.mem[INT_PAGE_MAP].addr
 		= (uintptr_t)vmbus_connection.int_page;
-	pdata->info.mem[INT_PAGE_MAP].size = PAGE_SIZE;
+	pdata->info.mem[INT_PAGE_MAP].size = HV_HYP_PAGE_SIZE;
 	pdata->info.mem[INT_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	pdata->info.mem[MON_PAGE_MAP].name = "monitor_page";
 	pdata->info.mem[MON_PAGE_MAP].addr
 		= (uintptr_t)vmbus_connection.monitor_pages[1];
-	pdata->info.mem[MON_PAGE_MAP].size = PAGE_SIZE;
+	pdata->info.mem[MON_PAGE_MAP].size = HV_HYP_PAGE_SIZE;
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	if (channel->device_id == HV_NIC) {
-- 
2.34.1


