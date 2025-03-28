Return-Path: <linux-hyperv+bounces-4717-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E6DA7435D
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 06:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1505178F4F
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 05:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7E211489;
	Fri, 28 Mar 2025 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M8ersrKB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112171E1DE8;
	Fri, 28 Mar 2025 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139683; cv=none; b=sQ284bhsmCoJcBajxT6BAmc1Cf9ayPqctzLm1d77zE8n4qG94soVV+MCuNjGkfYPE8lGpmAHYbAmQPZVYZSzuJeSpuaakuvjgrezhLHseqxow1Bd5PSHYe7Q7/MRhVZWB2o4rtEErEr9ZOqlXOhVmMAT2Pze1CEhoFkndRAb78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139683; c=relaxed/simple;
	bh=R5wbeoQym1xBQc9PLi+RBTjtBEJc9COul6VDmElbiUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P19T7+kHUTpbeoFUMyHVEAvFF2DbaMhmADlEkx+2zCBt6JNvV5dfURIVZAXan5/KVOR6EQFkLBOKMeDogEG3OIzh2qrLF04TvP/4h8OWqVuVtDTXRkJf0FeseVmvkFoAA9vJW6vvA0b+PojvV5StdDO1fRn8iuo4ceU1AlvJY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M8ersrKB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F6E8202564B;
	Thu, 27 Mar 2025 22:27:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F6E8202564B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743139681;
	bh=WMsAqOqY2QM6fWwHfYgf3OxZGqcbrF7fiheOMYN5O50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8ersrKBSBWPT7mPwm8FSmMNPw5R0Kbl3YZ1v3sIXS+ZcoG0Uf6HBPHhVN1RlhawU
	 tO16TSyi45ILkFuMKvnMmOWCTzquP02BsWTeqfS0O+eqqKWQds7pPMTTrBM8KYi/r2
	 JWFVmTie/5GAiVPUgOAxYYd/G52/dv6oigMHaIi0=
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
Subject: [PATCH v3 2/2] Drivers: hv: Make the sysfs node size for the ring buffer dynamic
Date: Fri, 28 Mar 2025 10:57:45 +0530
Message-Id: <20250328052745.1417-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328052745.1417-1-namjain@linux.microsoft.com>
References: <20250328052745.1417-1-namjain@linux.microsoft.com>
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
2.34.1


