Return-Path: <linux-hyperv+bounces-5838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFB6AD470B
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7236189C358
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971D28C025;
	Tue, 10 Jun 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P0+Z0f4B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987B2868AC;
	Tue, 10 Jun 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599531; cv=none; b=CBqYI/fY7HUzhAGbbaRqXcKCBv4FeX0kM9unpe4h4JsBbNcsQyfE6RiMKnPgW5OglZv2aq1OgY9irBcZrrQp30e9Z6/QA4UHQVfZezC/kVPP9ZSBYyHvo0q9WLDjrBYbpH4F/qC8us21N7tWLtZlQBUaVMXRp2+c0CSmhWayHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599531; c=relaxed/simple;
	bh=37HPHA9RfOtlboXAsLA3xyjUIs+4gv/UlcQmD0ikOZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CNzJRyLOMbZ7gK8UtkV8KrELO2V58F/WnzPvGgDu/d3NxfjIZWuYQ0Al8r4qitzrkJRi6RqQw7EmJqa8DUjcb0TxyUP6gjZUYty4RM/lMC79wBiDjdmuRUSNNi38oLSg+BeU5RY0wMr3KpGXEa/0Un3VNLUuYQ+cQBfjG3Zomvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P0+Z0f4B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 53E3E2078616; Tue, 10 Jun 2025 16:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53E3E2078616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749599529;
	bh=puB6cQFE/rhFTMv5Zzq0obpGjYzCvE7tXTvZDEqP3mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0+Z0f4BKYWK/KShVT6OLBOzCiYr/h6meeLZkwn4DDq55vb5NYJWA3EY+zs+CFuak
	 hYOn+YkHhCvZkEj3mTZK7nHjaLpFt42zgQ0Zkyg2FDSteIySCpVJz1/H2sc3jCGC7v
	 MkT40l/z1WnTDuczGpq4nhCmhCg7gIaudSF+ljqo=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 1/4] PCI: hv: Do not do vmbus initialization on baremetal
Date: Tue, 10 Jun 2025 16:52:03 -0700
Message-Id: <1749599526-19963-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Mukesh Rathor <mrathor@linux.microsoft.com>

init_hv_pci_drv() is not relevant for root partition on baremetal as there
is no vmbus. On nested (with a Windows L1 root), vmbus is present.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index b4f29ee75848..4d25754dfe2f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -4150,6 +4150,9 @@ static int __init init_hv_pci_drv(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	if (hv_root_partition() && !hv_nested)
+		return -ENODEV;
+
 	ret = hv_pci_irqchip_init();
 	if (ret)
 		return ret;
-- 
2.34.1


