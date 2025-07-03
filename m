Return-Path: <linux-hyperv+bounces-6096-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2FDAF83BA
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B688D1CA0901
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C772BF3D7;
	Thu,  3 Jul 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UShXlfxH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670D7263F;
	Thu,  3 Jul 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582692; cv=none; b=J1x38s7aRDdfhvaWf/vT7QfRAGkioO+BaCHYXF6XjAXWI9Glr8X6sgrwXlPzuOsbLw12TPJCYUU9WiYCWzQc4WKaBa7xBg16XWNfO3Ow4dcHj/SkfQpDiAUjFgBwuju4hJOLQlnIkqkU4JICeegdaH7ST++17blYh6JVYChqfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582692; c=relaxed/simple;
	bh=WpZytQMrPGzw6xWGqoVz9pIbjS7pWkaHK+uTiyZ+pEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=njnxZAub2RFOTwgBFEn1U1vf6mvterJl/76MUhMBfds7uh8ivvJVuMEUE1SpuMAm6dt8ZuOY6KOBBlpCklLkxgMT0m5Ijx4FjNrCrUPzUq95ICeJnMzBU55QT9nMccSSuyqrtv3sANYUY0Uv4gZfkmnin5PtK73ubmd2UhZiCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UShXlfxH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 656EC201657A; Thu,  3 Jul 2025 15:44:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 656EC201657A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582690;
	bh=Sr/aIsRtVZTTmdi0MYbRiz/Hji+Rbh1yrHyYblC7Xtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UShXlfxHkXNG+/p6Ib7AxuHsBUIW7JFqBhlADi7hQCc+vtt/Ur/1j3nh6AhR89UuE
	 XLNznSCEjpeN94Fclp5X/o1R13niEshvr1UqmyP+o5tRzadYLsSWlWJXnFx04wD7Qm
	 JcLMRZviYW3FZAldMYu7zn8/oQnB9ZRNzDB2JyD4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 1/6] PCI: hv: Don't load the driver for baremetal root partition
Date: Thu,  3 Jul 2025 15:44:32 -0700
Message-Id: <1751582677-30930-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Mukesh Rathor <mrathor@linux.microsoft.com>

The root partition only uses VMBus when running nested.

When running on baremetal the Hyper-V PCI driver is not needed,
so do not initialize it.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
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


