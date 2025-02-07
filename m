Return-Path: <linux-hyperv+bounces-3853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7099A2CC49
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 20:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA0E162E8B
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6923C8B4;
	Fri,  7 Feb 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dp7LmQzP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E510E5;
	Fri,  7 Feb 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955245; cv=none; b=fF+lHV6/63S1G/Jas3BJ+L3PUVnHm7aWT8TU35XklgnKk40a6UwpbL9VYME7Pqu0L/eSS90rtH+D2Zsffwq7+YF8m/8gsjkffmfCYBkAJ2sESNAXwo0X+WFNSEWcIHeGG/eGlScx0LQmhHqa0zsXQ9yuChgKnqFhUC4IE+wWbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955245; c=relaxed/simple;
	bh=DIFFc6UFvJKV/A+9+6SpdN6wzeCHC8/prkcb55YWB2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vm5NEcMeys07viR0i8LAeRb0y4WvGX475c87mvEe95icotccA0wGWP22PZSyB8sgTJC2HECvLs3siOUbgR8WwSI5Pg14qst1W8JRjID1Y3oxoPRUGE2227LMW+CF64EsEZ2iFtT6DSbA3goh96M4nkHpqyoL4g3tc/r9VsIKjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dp7LmQzP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19F312107309;
	Fri,  7 Feb 2025 11:07:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19F312107309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738955244;
	bh=kZHoMsysHTHsGGd4IK8twS8qLeZgFV/7GRStir4bJRU=;
	h=From:To:Cc:Subject:Date:From;
	b=Dp7LmQzPaPXgB1pkwNgBKRyKS31mxJfL9m4U0XaOsREwOvZ/BojAU+H4pGR97Gw5p
	 sgupD85fHcP/6bODrEAHK1dKxLHvBeAk0uV38kKTx1M0Zt8W5pcNoUpGEJb9kiW6mS
	 FR0nexYujnQ1ggN7sJXwZ3XDG0CBatHLMQRBsJj4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	Hyper-V/Azure@web.codeaurora.org, CORE@web.codeaurora.org,
	AND@web.codeaurora.org, DRIVERS@web.codeaurora.org,
	"status:Supported"@web.codeaurora.org, PCI@web.codeaurora.org,
	NATIVE@web.codeaurora.org, HOST@web.codeaurora.org,
	BRIDGE@web.codeaurora.org, ENDPOINT@web.codeaurora.org,
	SUBSYSTEM@web.codeaurora.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH v2] PCI: hv: Correct a comment
Date: Fri,  7 Feb 2025 19:07:15 +0000
Message-ID: <20250207190716.89995-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VF driver controls an endpoint attached to the pci-hyperv
controller. An invalidation sent by the PF driver in the host would be
delivered *to* the endpoint driver by the controller driver.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6084b38bdda1..3ae3a8a79dcf 100644
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


