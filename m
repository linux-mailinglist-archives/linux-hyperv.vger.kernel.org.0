Return-Path: <linux-hyperv+bounces-5078-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD7A9A07B
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 07:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133A61945E3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 05:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31A1D6DBB;
	Thu, 24 Apr 2025 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CTUtAQcy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC719D07E;
	Thu, 24 Apr 2025 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745472943; cv=none; b=uUumpqpiROwBZwuS1XFUPzGDipl6wCVqAm4JodKEx4BfUuGoZ8/IZGvPBOWPP/WGdlZ23b6ZbAWiLK4PamR7rns9A6JeOGgKL7VOkRJYEVLjUglR6FNv7x96HEW0Ap1EGDBN5FfO3kRd0Ya/ldZ2UjcJmfPgOnpuAibsPfRQy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745472943; c=relaxed/simple;
	bh=vI+t7xBE2JttxJLKgx5fIj9YQjyxTPcTMcLeVlHSb2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lih4MQWMuoDPiMDQirArumWRkBISL++tF0/oTgDjYm7aTsdhs07AHtXIBufwM31eebjFmBwH8VIJ5VBLnF5wE3sT/MRO6gMcWsJHdQT5u9WLCY/nSLrABrqVk943JNJ2L0N9W4ZfLDYVRYVsfw2vfXt6hL5wtegE+TR+J8A1NpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CTUtAQcy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9FAA2113097;
	Wed, 23 Apr 2025 22:35:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9FAA2113097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745472941;
	bh=fqa1sTjYUvxdV7vVYGzpiz4VvhzlqCpOvK6Qq6h9Ko0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTUtAQcy6cBJ4E2iZ+xIGHg5nvKGvvVdIuHn2bdW9UMdXuSwKmEGnJJJkhy/5QIrE
	 pc/hU5H8pZIqWxGIjEUGMLDUWn0hnAeHdvQQ9wQGLrpDUnv4vLvV0zzOyig2JL0sX8
	 sUpSgq/Q8lgwsK3CU/Au/95Wy+Ea973guD/J9EQM=
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
Subject: [PATCH v6 2/2] Drivers: hv: Make the sysfs node size for the ring buffer dynamic
Date: Thu, 24 Apr 2025 11:05:24 +0530
Message-Id: <20250424053524.1631-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424053524.1631-1-namjain@linux.microsoft.com>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e2827079da89..15b085df95c8 100644
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


