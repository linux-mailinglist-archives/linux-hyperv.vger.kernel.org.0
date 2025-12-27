Return-Path: <linux-hyperv+bounces-8085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CCCDF42A
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Dec 2025 05:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B185300726A
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Dec 2025 04:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7C2459D7;
	Sat, 27 Dec 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CCzu1oew"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823F239E63;
	Sat, 27 Dec 2025 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766809624; cv=none; b=p7cxOhZ7dLHiPloUwvr6+GquZ4Vd80BdMbFjR+KuACd5v8/pGVJeH5BYV8CP1OorNgJUX0k4tfxjH+jmsSulTctwFwsKJ0XL099WKeNb5C8afVas9tWigIFaGz8H/zBi/x7US39hY1u6FwsYSzr7tiPoDPfIRH5ucoa6bnaGeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766809624; c=relaxed/simple;
	bh=v88zmxHPxDJ29Z1CJhjKvIeLbCId9F8pCOiEW1LEOIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G3aKAfupxkMsQSvkTvUD2WCIWMPo2McBfDnoK0NXMFVChzlvWDtISSSD1C6bF0VS+zqh6IBhShBtQfnYC2jGOIEs9gTfFv+yMTccoktJ4qbBxMJIa/BKwb/3/6sEeVN/X/jCJk2u6jPZuBFh8XAXe2TtFsqR6NB8lXieHz8+XWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CCzu1oew; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D1BDC2123F18;
	Fri, 26 Dec 2025 20:27:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1BDC2123F18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766809622;
	bh=vBZbghx61KW1MVY+joi05o+puQFtkIaOkwWOtkWpqWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCzu1oewr9kzU7LUoC6wszdXdrtHgWHq2Gl8ZXDDF/GUOdM4lFtLcPjJrAzoCYBZr
	 rZ+Qij4DCB/XqAk0lJQPZPg+92d8mZhlG8iPWp7yO3Z+GGL7AKGzwCq+zqxtJXi2HY
	 Dr4546m9Ag9o9yztS+UhWwYwwq5lRckhI3/CgxYs=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	longli@microsoft.com,
	decui@microsoft.com,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drivers: hv: vmbus_drv: Remove reference to hpyerv_fb
Date: Fri, 26 Dec 2025 20:27:02 -0800
Message-Id: <1766809622-25388-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1766809486-24731-1-git-send-email-ptsm@linux.microsoft.com>
References: <1766809486-24731-1-git-send-email-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Remove hyperv_fb reference as the driver is removed.

Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a53af6fe81a6..7758d7e25a7b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2356,8 +2356,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
 		}
 
 		/*
-		 * Release the PCI device so hyperv_drm or hyperv_fb driver can
-		 * grab it later.
+		 * Release the PCI device so hyperv_drm driver can grab it
+		 * later.
 		 */
 		pci_dev_put(pdev);
 	}
-- 
2.49.0


