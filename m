Return-Path: <linux-hyperv+bounces-5360-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D2AAB894
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6D9172357
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4556132AB9E;
	Tue,  6 May 2025 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="lw2pwBbH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EFB350141;
	Tue,  6 May 2025 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493013; cv=none; b=jPAHdoaZ1SSPTTcVlFDopu1W+Hf4p89pV6zuuCdwEsSQgqhexWqugmNk1hwU3SeaPOmGYKdr6eY6njF9ujjwpg5Cc/23luwno/6n7RfDKQ1IKhGDI3KExgbaLAmjp7ojEA8Px1LnAKF6Tz7+O9BbQ1Z4WTKRrlPq2oE45d9p/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493013; c=relaxed/simple;
	bh=+OL/J5iI/IZyyfqUWRcvylHqsCK6N6ObqpoSB+oKM4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cz80qbYvBuHdJy1GeU/RhPD9FnY5YKl55Vr3sg8BTWdNEFsu4fJrCFrcCZsgNifs9Taw6XN0jrz/sbn6QECiTiXT/Z1VahQTTZmeR1Y2MRZ0ft9adZhH03DWgj2maG+LeX+v+6wyPe30lE9KzDvGIdPzCXOUgMRZQLjft/i8jM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=lw2pwBbH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 353F92115DC4; Mon,  5 May 2025 17:56:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 353F92115DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746493005;
	bh=vVyQcEwBGYmE+cSxfvdI6O2L9frTYHcEH9sNNAqwQo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lw2pwBbHJJrOMBab+V6kJdq1VXiU1MdVm02B7AlSpf25KM6iIR5xIGUnc0mOq4n1a
	 fNIRdG7m/BWPxcnginVQTn/e3wRO/Evjsb24FDCajFTmQ9SNQLcXd0BVd/DQCnRFsS
	 WsjCCb82tXZoclPGKFXd0hAwJh592n5UD6Dx878g=
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
Subject: [Patch v3 2/5] uio_hv_generic: Use correct size for interrupt and monitor pages
Date: Mon,  5 May 2025 17:56:34 -0700
Message-Id: <1746492997-4599-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
This can be different from the system page size.

This size is read and used by the user-mode program to determine the
mapped data region. An example of such user-mode program is the VMBus
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


