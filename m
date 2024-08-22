Return-Path: <linux-hyperv+bounces-2794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6E195B37A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 13:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545751C22B95
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB018308D;
	Thu, 22 Aug 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JMPNcONo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864B17C7C1;
	Thu, 22 Aug 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324970; cv=none; b=McKZeEjzkl4cUG4NLcBWjX5HX9YUFPzsFThlrcBd/YwyTz1zuSksbWqjpsvxg1j59zQC1ZMPs/S4hLQaRAeGWlvn0qcYsmnLoR0Ffw48YA+oKlbGVHJ2Fzr6qPBCAV5rlQhCkBhZRxahWmqTHpc3B/UmZsPcfX4f+ECLyqosg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324970; c=relaxed/simple;
	bh=XYyx2Zhilje759kmJ/0m5vPjTaBs9TyC4cnRsuE2nn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/q8+wBiNZ3x0lJ6FC2w/D962U8kSxpZVbgLQqfE+9bcRjTQAAJp7pVrgp52s4r6n1zzwTI1eMPu8DsG5WD6vqSMD008+vGxT+oNkM9F2pmKydEpms5XEFR/1AXEz3YtenDCi6zXjOqeeSqBaOXnLc5O3ea04CBSKgUFN5UPOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JMPNcONo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id 10AE420B712C;
	Thu, 22 Aug 2024 04:09:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10AE420B712C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724324968;
	bh=9xsXr4nxiccxyjCDNqEYAMRuj7s+uFEXt6/g/gSu1iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMPNcONo24HJkAcf14guWm6Nn02xeaJUd2bQcFLRK9ftuNC+buMMFrI9cMHVASAFG
	 5Ac4iPXAdqPq3sqLJl8zpTQa2zhIFK6Dwy8fpmm5LVyBahyYQVRXeS7O1zytbCnbeQ
	 XvVgrqIToWCoWDcK2rYvP+vySFivZnqsProT07Bg=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic
Date: Thu, 22 Aug 2024 16:39:12 +0530
Message-Id: <20240822110912.13735-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822110912.13735-1-namjain@linux.microsoft.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rescind offer handling relies on rescind callbacks for some of the
resources cleanup, if they are registered. It does not unregister
vmbus device for the primary channel closure, when callback is
registered.
Add logic to unregister vmbus for the primary channel in rescind callback
to ensure channel removal and relid release, and to ensure rescind flag
is false when driver probe happens again.

Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c       | 1 +
 drivers/uio/uio_hv_generic.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c857dc3975be..4bae382a3eb4 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1952,6 +1952,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 	 */
 	device_unregister(&device_obj->device);
 }
+EXPORT_SYMBOL_GPL(vmbus_device_unregister);
 
 #ifdef CONFIG_ACPI
 /*
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c99890c16d29..ea26c0b460d6 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -121,6 +121,13 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 
 	/* Wake up reader */
 	uio_event_notify(&pdata->info);
+
+	/*
+	 * With rescind callback registered, rescind path will not unregister the device
+	 * when the primary channel is rescinded. Without it, next onoffer msg does not come.
+	 */
+	if (!channel->primary_channel)
+		vmbus_device_unregister(channel->device_obj);
 }
 
 /* Sysfs API to allow mmap of the ring buffers
-- 
2.34.1


