Return-Path: <linux-hyperv+bounces-4925-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588FA8A477
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD7C189F41F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20BA29A3DB;
	Tue, 15 Apr 2025 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KEYRW8Xg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB829B772;
	Tue, 15 Apr 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735507; cv=none; b=oPWewtsjiIgqCIjVLUOC/AVYpF1OhJah7dkv35aE2PNPwObjxsHbpTrKhYGmcnMVEFwFSQzaZXc9UWB6RFZnNkkgRg3dDRyXcSH0EYC8uWHkUb6OkIdxEguEXZr0XLwIvtA7r+8sFkKYvG4uNgLZ+MlXjNAy287wUNOpL36NDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735507; c=relaxed/simple;
	bh=J8lu/X3lLuKDP3cqf1zZsh7zscD/5IgaDYnIhZlUs3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pffNXn7cOjBXU/vN+aQLh820sePGRpIC7drO2EVky91EM05P7E6Xq875eEEEfS+n/hlGEgEmA23NSN8qKystUuCnSezhjjK8PuKkofIHR9ope9QwI8E0pdkZJGaga/BH9fkAHXEf/bIZngDbh4iTB/Ts85X4KNdzqjLI4mEA/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KEYRW8Xg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id D8CFF210C44A;
	Tue, 15 Apr 2025 09:45:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8CFF210C44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744735506;
	bh=mUh/kcEUt4luQu4o7NTZ5EU1iGIvJuoZ7W5qUBGmp+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEYRW8Xg+ZFYUw0WWlhjqqMSlMRD4Du48prVydUlK7ccJV2QbxABymrGTVm/LjYog
	 SN4cdpiNtgqxQl9+4QXzc9qgwOco/vQqbw9/HA/kKAnLGndNOWSfIe54KdT1pCfy5t
	 f410wxLhjo7A2SagKYSKLAw+fz1x6r6rD46iUbXg=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH v5 2/2] Drivers: hv: Make the sysfs node size for the ring buffer dynamic
Date: Tue, 15 Apr 2025 22:14:52 +0530
Message-Id: <20250415164452.170239-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415164452.170239-1-namjain@linux.microsoft.com>
References: <20250415164452.170239-1-namjain@linux.microsoft.com>
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
fstat() on ring sysfs node always return the correct size of
ring buffer.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cbca403be2ab..88240b021034 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1820,7 +1820,6 @@ static struct bin_attribute chan_attr_ring_buffer = {
 		.name = "ring",
 		.mode = 0600,
 	},
-	.size = 2 * SZ_2M,
 	.mmap = hv_mmap_ring_buffer_wrapper,
 };
 static struct attribute *vmbus_chan_attrs[] = {
@@ -1880,11 +1879,21 @@ static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
 	return attr->attr.mode;
 }
 
+static size_t vmbus_chan_bin_size(struct kobject *kobj,
+				  const struct bin_attribute *bin_attr, int a)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	return channel->ringbuffer_pagecount << PAGE_SHIFT;
+}
+
 static const struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
 	.bin_attrs = vmbus_chan_bin_attrs,
 	.is_visible = vmbus_chan_attr_is_visible,
 	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
+	.bin_size = vmbus_chan_bin_size,
 };
 
 static const struct kobj_type vmbus_chan_ktype = {
-- 
2.34.1


