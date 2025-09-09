Return-Path: <linux-hyperv+bounces-6801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC1B503C3
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2451543478
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB635CECF;
	Tue,  9 Sep 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Omi0gRG+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68760341AD6;
	Tue,  9 Sep 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437153; cv=none; b=JgEOFdNdk4dSVGiO9ObEFu1mIibLulLTF0gHqmwutEW33Ow/cmABDJub48gZjRXIQ7e0laM53nCIXGESJ0qu5R59MgBrSsKw96d9KkoeH6Ma9K8KiF3hw4VakXdYUmMC2Y1ZYF6YmilEFPlGUnDC5BBLrbQjGAAqtAlX0JCBBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437153; c=relaxed/simple;
	bh=ZZ6h6s/kyy3xQ8JlkCmckRgcZVn5cM1jBnRr8sHoj6w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=P8QDxpDr7TroniBnw6JPoi4+J/KAm/x218DoCcoE3m3IxUBc/yYZbmmdfpM1YvHTanYteqGU8hp/5iXPDNESsWIqtfs+nujyclun9+AmT1KA3eaS4ujmxAZ+HKH3roIvYioUA5Jsr/bRnaOq/Lv/jZ/XFkIuzLyN7qbIEnLeMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Omi0gRG+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C917F211427B;
	Tue,  9 Sep 2025 09:59:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C917F211427B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757437151;
	bh=HutMKDH+93t1zilm55KCYspIVdDm6Yre0qvMHILA2xk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Omi0gRG+GHuN+xkUdkysoHLbaKfaTJ9jgsEooUjSf30wolZv/1XMmtbuwTUgXMxkn
	 LBY/bHNP3tWlE65sPf1Qkp+6YJJZWXoHfXQ/jVaqKzokQI3eTF0hMBpyUtPwkKgm/Y
	 70iZEZjAjZYl7tO10+MZFeb78PxpHcwL6cIfIwHY=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ptsm@linux.microsoft.com
Subject: [RFC 3/3] Drivers: hv: vmbus_drv: Remove reference to hyperv_fb
Date: Tue,  9 Sep 2025 09:59:07 -0700
Message-Id: <1757437147-2713-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <E2D7F2119CB4>
References: <E2D7F2119CB4>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Remove hyperv_fb references as the driver is removed.

Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2ed5a1e89d69..5ed523b4e951 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2298,8 +2298,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
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


