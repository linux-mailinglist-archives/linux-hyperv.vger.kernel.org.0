Return-Path: <linux-hyperv+bounces-6353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E34B0EB2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 09:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745BB1C8233F
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 07:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C04267F58;
	Wed, 23 Jul 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FCUIMrnu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE32571B4;
	Wed, 23 Jul 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254133; cv=none; b=bmTqALL1jTpBdPLN2c1UbTGtIN4Y21a5YHkNxs4qZ9mjxXDh43qItHdL9Gd2YRvMRGqFnP1AB46U4KN08gTPBwXYCIIRdAuHAkYkgrDZ6e/GOu8u5nn+7tsgdAQ5vBuhiXLB+lS2k1PALID2Y6QsIGaWkSFA7HCkx3Q64+ZIvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254133; c=relaxed/simple;
	bh=sMSWpuL3NbrBKZm2iT8FUES5vNyP6oZOFwZ2CCguIug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dTy82wvl7RWqF0xOODKGjH/A6gEsMVmv1Q/7IdnXkfBQZBP6T5kBhK+vZm6tgnqwzWF7vfjv/In7JdTUVNCbmHyYtKpSqfhjzFF0V9PJ3YV+No1wBMA5HNDgS2BvXshsq6+126QLEdvx+Lb86y43ADDF994PgWI+05WZIMMfpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FCUIMrnu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FFCE2126891;
	Wed, 23 Jul 2025 00:02:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FFCE2126891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753254131;
	bh=AdQWIoxaEDYaHE+B2o2jADCLoSIJqb1hT+F8ZeUMGxI=;
	h=From:To:Cc:Subject:Date:From;
	b=FCUIMrnu7EVKAlnkmu5sGdSICICeMJrXUdbDxxlFtJg74YedEr/DpiJzGLgH0yjdA
	 53+KhXnmDY7aEi2CogctNOpXtxaAdRvyW6AyAxaeGuvonK7r0v79fqSo4icL+J1C+X
	 v8pORf8PhKBFwKiBRNdwbkmxmJnZwPi+M/pcUIBc=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux@weissschuh.net,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring buffer dynamic
Date: Wed, 23 Jul 2025 12:32:00 +0530
Message-Id: <20250723070200.2775-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ring buffer size varies across VMBus channels. The size of sysfs
node for the ring buffer is currently hardcoded to 4 MB. Userspace
clients either use fstat() or hardcode this size for doing mmap().
To address this, make the sysfs node size dynamic to reflect the
actual ring buffer size for each channel. This will ensure that
fstat() on ring sysfs node always returns the correct size of
ring buffer.

This is a backport of the upstream commit
65995e97a1ca ("Drivers: hv: Make the sysfs node size for the ring buffer dynamic")
with modifications, as the original patch has missing dependencies on
kernel v6.12.x. The structure "struct attribute_group" does not have
bin_size field in v6.12.x kernel so the logic of configuring size of
sysfs node for ring buffer has been moved to
vmbus_chan_bin_attr_is_visible().

Original change was not a fix, but it needs to be backported to fix size
related discrepancy caused by the commit mentioned in Fixes tag.

Fixes: bf1299797c3c ("uio_hv_generic: Align ring size to system page")
Cc: <stable@vger.kernel.org> # 6.12.x
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---

This change won't apply on older kernels currently due to missing
dependencies. I will take care of them after this goes in.

I did not retain any Reviewed-by or Tested-by tags, since the code has
changed completely, while the functionality remains same.
Requesting Michael, Dexuan, Wei to please review again.

---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1f519e925f06..616e63fb2f15 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1810,7 +1810,6 @@ static struct bin_attribute chan_attr_ring_buffer = {
 		.name = "ring",
 		.mode = 0600,
 	},
-	.size = 2 * SZ_2M,
 	.mmap = hv_mmap_ring_buffer_wrapper,
 };
 static struct attribute *vmbus_chan_attrs[] = {
@@ -1866,6 +1865,7 @@ static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
 	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
 	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
 		return 0;
+	attr->size = channel->ringbuffer_pagecount << PAGE_SHIFT;
 
 	return attr->attr.mode;
 }
-- 
2.34.1


