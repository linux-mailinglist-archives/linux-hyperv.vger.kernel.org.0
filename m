Return-Path: <linux-hyperv+bounces-4859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C9EA838F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AD17ADC0A
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4F202979;
	Thu, 10 Apr 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X5sh2WPh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD01DE8BF;
	Thu, 10 Apr 2025 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265342; cv=none; b=nR5BrkBYO+NliyOAIpV13CyDlLcN03I+l5lZQ7ACng95/TLRRl8jTnHtypzzBm8PLzXgBb1x8/5cLShGgnlzcgK1LozpxnlUJ42w8HXwe3ll2o2PhMl8KYrzN8nUjDyEFvb+LdXwnGoqH7OYTXYfwUHRAZ/R0c5PvESJlgzlbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265342; c=relaxed/simple;
	bh=iEnz87p9jiJqM8ldDHqp1iiLYm1wFZ0SmPihFwK4bjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPAMOOVJCsCaGAS+tcM4lYQOs4auh9YEsXLAYcwQlKxOoepT9/uTJ1ifwofkvzIr/7GFqOb2F75BRyLyx8jW/CSs8prmtj8Lb1kwBMo7Brvd25aNUCxOzPr3h6OIWFOCaQ+HBvxV3tP2CTzTJ4dqkZ7PNx/T7h00YHwvRaqVIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X5sh2WPh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id B532D2114D9C;
	Wed,  9 Apr 2025 23:08:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B532D2114D9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744265340;
	bh=HioKhu/DG0UhW1UkIeNOikgiTMcLB+zmLCq1ChIRWtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5sh2WPhSVvYwYbwjCdDlPmz26Bab+Cz6v7JTsi2VPWgI+Hlu23HbnehIR4c7750i
	 V4Vay8bBYpDpDtwZ6+wJK1iUEIxKL/SiNPrTnUAeUcj0ueTIgGfxPuBJDzYRhEZQ90
	 r9U4VSb9pHnToe8wsubHoLKohiI0Z0yBt8G39zrw=
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
Subject: [PATCH v4 2/2] Drivers: hv: Make the sysfs node size for the ring buffer dynamic
Date: Thu, 10 Apr 2025 11:38:47 +0530
Message-Id: <20250410060847.82407-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410060847.82407-1-namjain@linux.microsoft.com>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
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

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 66f1c21050d4..c7be85606031 100644
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
2.43.0


