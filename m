Return-Path: <linux-hyperv+bounces-4969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D876A92EE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 02:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAB1B6348D
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03C7082A;
	Fri, 18 Apr 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="iMl3HJCE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE140BF5;
	Fri, 18 Apr 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937003; cv=none; b=IJR+GRLr+DL7FdH3sDKNePPXQDU1V91MwgQT6Nbe4PRER5QmxkDWp9qzLxOw6+SMRWSNf155E60ydtGc5l+9krWoXR7y08Y1E1gheLkojyxSlu3q0c1kiTV/SQvTyA7Nl4GI2ny3UqjOuU2Vku7779VWEUFsHBoPhYJIaE3pjiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937003; c=relaxed/simple;
	bh=ZmeHa/eLY/2hqMCCompH7uxOi3TbVn1s/vd0kwInBNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qE0VnocBQaxZ8KCwQ11gvmsvlFUK/K8KPEi9pSpsxsFS2kHXu5Q/ic1RJB5tiRFl2/zWiFhCoDDYqmAhUWRomq+k6PR3SQjItl4vNB2aRnnyNJSXxQmJuS9ExqYzBdFmCccezwlCBRQc4Y1w1CjwXtdNlHwrypGNM2huUlxD7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=iMl3HJCE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9C61B205251C; Thu, 17 Apr 2025 17:43:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C61B205251C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1744937001;
	bh=mNvIVtrs1E3+/vYev9vOXbdbYKPz8ifiqQUnVtJsDDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMl3HJCELH+e0LQIwLEQOrF/pAdWIs+Hq5XC58tSDDgT4rsaydSVZHr3iijyG96G4
	 Xepbzin2iUEB1aKYyaviVx+jWkXsJHfiL7bqOOS+qHf4rrbYfD1A3jmHbzOvMOeAEL
	 afZQmH+86ER4B3WPonsbAwpyQu3ZAw8ZJ/eYMelg=
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
Subject: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and monitor pages
Date: Thu, 17 Apr 2025 17:43:17 -0700
Message-Id: <1744936997-7844-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
This can be different to the system page size.

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


