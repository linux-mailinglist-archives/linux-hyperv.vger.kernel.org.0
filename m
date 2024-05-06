Return-Path: <linux-hyperv+bounces-2079-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22508BC710
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 May 2024 07:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C721F24A9F
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 May 2024 05:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC941C62;
	Mon,  6 May 2024 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mSTuCBml"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495218E3F;
	Mon,  6 May 2024 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973952; cv=none; b=RF/N6w9XK9FQgcMR0x9qRBwjlPhI41IlZXNdZp85ra3/7csl+KfGeMArznzUglVXr3MbFeHyaJEl3IdrgbSR/oKmz39dMjrYHxZwczzO8QLysav76KR27S2zrba6LENvJrJaN3Da69RxCofR2bX76XNj2Ur+yVNRMiA9ACX7VRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973952; c=relaxed/simple;
	bh=tEvumqwd3KGmnqz/DKjUD8+JIVJDhi1tLnPm2ljTvEM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ErkcpUmoqV9ZpTr5ekfuq+xEWbNiSheIGFok+o8M2r/39Hj0zO/rK+hTQ1Gc8Z9847uyxyJ/UoLwNVRMhYGWrKMbmDdIisYPGcK0IiHeRLmK+YIkZjQx6DMIX4H2ZfpCh0N5lZGaua+F9IMpO77hfNq0sxfJX2s0aTjMjhyr+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mSTuCBml; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D471720B2C82;
	Sun,  5 May 2024 22:39:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D471720B2C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714973942;
	bh=bfHIOF5qZceUtl1oIJPlt2YVFrRSH8tcL6/+A6DJaig=;
	h=From:To:Cc:Subject:Date:From;
	b=mSTuCBmluUSglx1eiKBWdbqEpLlHFLHPNcq9cxCXLOQlhi48cXfu2EjNk2s5CJqVa
	 cWWDRW1qcXgrXKYcrTCw4cnSjBJ0icmJGW9FpWdwTijbxMS8sknmdf/eoofhgmnYTJ
	 f3TQ27SLePpoKsbusZbCpzhGWlFCsByHvF0Gpfh4=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com,
	maryhardy@microsoft.com,
	longli@microsoft.com
Subject: [PATCH v2] tools: hv: suppress the invalid warning for packed member alignment
Date: Sun,  5 May 2024 22:38:58 -0700
Message-Id: <1714973938-4063-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Packed struct vmbus_bufring is 4096 byte aligned and the reporting
warning is for the first member of that struct which shouldn't add
any offset to create alignment issue.

Suppress the warning by adding -Wno-address-of-packed-member flag to
gcc.

Fixes: 45bab4d74651 ("tools: hv: Add vmbus_bufring")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2] Added 'Fixes' tag

 tools/hv/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index bb52871..2e60e2c 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -17,6 +17,7 @@ endif
 MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
 ifneq ($(ARCH), aarch64)
-- 
1.8.3.1


