Return-Path: <linux-hyperv+bounces-3792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2EA211EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 20:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D481886493
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400519D081;
	Tue, 28 Jan 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SD5kJoIL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFAB748D;
	Tue, 28 Jan 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090906; cv=none; b=oG/KNYt66RbgOZVs2h0fWtmBbJfK9/8oaaisWiFkbbbhzPK/ynfKXQK9tz1/8NA85LV6dMMfgm+FuttzKGGC7halqGSVNu/KuyW65XCrMEiyveRVqrTKeIypwfSg3MMIc3j5INnCB7tt2OhFxegKYjkJ6Tr3IliK0pNrzUoBaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090906; c=relaxed/simple;
	bh=G3yHZwe1qvH8ljeHQDRj2sC0mlKxxSqCKF4ThFFV6AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ebk/ejhzVhJIGXIZ+ENPXWKOOrQi35s64rgcEApwci9Lvg24/zIiTjFSZ+q2/PUyAgKYr9a23kaUiBWSqg/VCe3FtYeQmCQLQSuGuKG4jjIGfTNZftMs+5Sql0uGw7UxLEey5T63XGdhduNzB1CFChyun2Lx2sGqawvXKikd59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SD5kJoIL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 368BF203718E;
	Tue, 28 Jan 2025 11:01:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 368BF203718E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738090904;
	bh=yGwU/o2uwBqXvjNervGipCyOPt+3st//1cF53Rf4Op0=;
	h=From:To:Cc:Subject:Date:From;
	b=SD5kJoILiXSQzqAjqYDUv4SOlLbZo+VlKhd9SZvgKX1JytNyUvLRRpry8PbEFa2uj
	 Oui8mUaVR7py69g04nmIDt1EOHKcEjOj4RO7LPmuZVNGehBCntdseAJxmnvcjLsdCq
	 N73BGxEBdHNPl21mzgxxULu9IQZGMhd9rSBmcVbQ=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH] PCI: hv: Correct a comment
Date: Tue, 28 Jan 2025 19:01:40 +0000
Message-ID: <20250128190141.69220-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6084b38bdda17..3ae3a8a79dcf0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1356,7 +1356,7 @@ static struct pci_ops hv_pcifront_ops = {
  *
  * If the PF driver wishes to initiate communication, it can "invalidate" one or
  * more of the first 64 blocks.  This invalidation is delivered via a callback
- * supplied by the VF driver by this driver.
+ * supplied to the VF driver by this driver.
  *
  * No protocol is implied, except that supplied by the PF and VF drivers.
  */
-- 
2.43.0


