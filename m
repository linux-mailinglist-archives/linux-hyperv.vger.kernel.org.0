Return-Path: <linux-hyperv+bounces-2909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED755963C53
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87461B23B90
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B31173336;
	Thu, 29 Aug 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NHbKXNN3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECEA16C86D;
	Thu, 29 Aug 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915614; cv=none; b=QMDwB/vTshJgP5KhjoJYeq53QcJxmiPnsj/XwRoTQVqo2hyvGUA0BRGJiXXsR9hgKXygi29dMJba8CQbw3jBI3swHH3hDRZ+DTHtjdMTtWUbVQUHinnKGK+5rc1mwLb5/nGhSqckuWdlTvngxGVOUv8bcHtocbpAnvswWpMfNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915614; c=relaxed/simple;
	bh=s1/4HKit9dSyhZkSL0rQTHpnyOYZ9xWwZEfcXsLqo6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZ7ZH32GCzXauX56MBox3Sp/QQMFQHboVIFM5DLReSwFExuJ2MFRHCg2Oo1OLHPncDqALc5njal6WqDhelGczX9AVMiW7QN50QljfQIbFP6WxnCtbbrQ/aq/Hxm9H5O46AcscL8JGfXKE+3uEpU1tUH5CMwXpUsMmw/AWjpqFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NHbKXNN3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA3EA20B712C;
	Thu, 29 Aug 2024 00:13:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA3EA20B712C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724915612;
	bh=6GoNotYZxN8p/FiKL5H0w/+Gi4edkJwlbdA1lxuTIjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHbKXNN3iTzzgYKTziTbCrbqh3viV52L0e/ZV6Fu8P+r+LGtkbFEKCjMIOO1MmPEL
	 OxLuMFYagVrP7V/UzoirbJFCMRspve+f8thGDqUHgGpuen5de9hUFzNzjKsb8cyY5T
	 BbtfC0i6DCuZr4Sy5PIgh44SAVd4WKJWvmioWCdQ=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic
Date: Thu, 29 Aug 2024 12:43:12 +0530
Message-Id: <20240829071312.1595-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829071312.1595-1-namjain@linux.microsoft.com>
References: <20240829071312.1595-1-namjain@linux.microsoft.com>
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
registered. Without it, next onoffer does not come, rescind flag
remains set and device goes to unusable state.

Add logic to unregister vmbus for the primary channel in rescind callback
to ensure channel removal and relid release, and to ensure that next
onoffer can be received and handled properly.

Cc: stable@vger.kernel.org
Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c       | 1 +
 drivers/uio/uio_hv_generic.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7242c4920427..c405295b930a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1980,6 +1980,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 	 */
 	device_unregister(&device_obj->device);
 }
+EXPORT_SYMBOL_GPL(vmbus_device_unregister);
 
 #ifdef CONFIG_ACPI
 /*
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index e3e66a3e85a8..870409599411 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -121,6 +121,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 
 	/* Wake up reader */
 	uio_event_notify(&pdata->info);
+
+	/*
+	 * With rescind callback registered, rescind path will not unregister the device
+	 * from vmbus when the primary channel is rescinded.
+	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
+	 * Unregister the device from vmbus here.
+	 */
+	vmbus_device_unregister(channel->device_obj);
 }
 
 /* Sysfs API to allow mmap of the ring buffers
-- 
2.34.1


