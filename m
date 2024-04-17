Return-Path: <linux-hyperv+bounces-1978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098478A7D9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E9B21440
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F566FE07;
	Wed, 17 Apr 2024 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FOz49k4I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB170CDA;
	Wed, 17 Apr 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340858; cv=none; b=ki9phYpHLt6WErb8zLcHUPN+MGfHKnA1hvTzCYrDW8otl/uneedHpr5j0YPQsZ4zP/Je7r+ISJ2CiyNBuqXEL6rkAQU5SopfVDKaxVv5NO/O5NMxMk4SqKBeeBrKPu1CtAAeWiH5HMhGH0aADNorGAMr5vSjo2axZULA9ZQJOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340858; c=relaxed/simple;
	bh=1nNtPhj9hxzF1XVfv2/BM3L77E4VnHGDfl1nJKWiDwc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o1Eab0jRMqJBjHOuO78H+0/1T0jjbIgvwaJPPpSnRAqlz4QQRAYhE57FEUn2eDm1LvcZLzH3aoj9eT6hIJpO8z2v1k0TdmLJiLIPTL2LR2Wo7QJ3oM/405uXlXNK91Im7BVNCBJj04MFHSsWfT4/1Ak47ODGIYCXS7J9/yPaaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FOz49k4I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A5E420FD4AE;
	Wed, 17 Apr 2024 01:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A5E420FD4AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713340853;
	bh=NRcxTgh9CXUCeKLjqyiddKKqksb1f3wkwo+zMdhzkCY=;
	h=From:To:Cc:Subject:Date:From;
	b=FOz49k4Itw792O7LLjQYalOW1a4m1NhH/5n2zf50K6Sf6xIk6wHNU8kxnVvJ9ythD
	 Rd4e/rUmkt85BxP7CG39soXp8x8UEs6YeN/Ju2zxjmFKmZnZQNccMkNJG4vo2ySEZu
	 ZESnMC2tumU+Ft+2D53xYSde5VGTvjDDdjaIDwqY=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH] tools: hv: suppress the invalid warning for packed member alignment
Date: Wed, 17 Apr 2024 01:00:48 -0700
Message-Id: <1713340848-6901-1-git-send-email-ssengar@linux.microsoft.com>
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

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 tools/hv/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index bb52871da341..2e60e2c212cd 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -17,6 +17,7 @@ endif
 MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
 ifneq ($(ARCH), aarch64)
-- 
2.34.1


