Return-Path: <linux-hyperv+bounces-6522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CBEB240C7
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887571BC0960
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33482BEC57;
	Wed, 13 Aug 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQJFFeXg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xx0ZtEXY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755E28B4FD;
	Wed, 13 Aug 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064453; cv=none; b=l/iOQgDQRZOyt4bSh/zOCy9DI7xrEGZjMB9LmXfAC4EplJIbDdUaGifJ1FQ/YyIo9NTHHwHj6dt7UWa26TeJAwpW6Xk1uYyf9fxqyEuuqqk2cnp6hp+KXjweXaYmSlyufepoEFgf0QriuZquLlaBUGDOdSgApsdppcgUG+oc0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064453; c=relaxed/simple;
	bh=I0iVGhWPggrt9AOpE5ZGVa5XTObbUGTxBM/CYcXj6v0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EDTddkOlGAad6+ZNmSpE9VOnEsb6fW81aS2bI1c7tmvZrS4dT2UZpE3hFq8wAeCdQnQwqJ3vjEdsjo2eB3zIQaww5/k6xb1KHlQRAH5ueZSLTme8CaT67BjUI8CPDYUJHwSaHXW1URdlpoL8cA8nEks5+kPeWDb5dcow/JXLheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQJFFeXg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xx0ZtEXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755064443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/PL5bVIhg5YW4tmmR/+KZ4GyDkbwX5QhsYoHH2cH4cE=;
	b=GQJFFeXgpc58dRvrm4F19IdUWWU7Cq8PzyVzCjuA1tQS4pbCr2ccGL0bNbRGJPvfCyCOw5
	iDguNTT32DujjzvMFXLOU39kUsYH5Si2e8uy007pDgrY/iTA7bplyk8nUO0bd9fK0TY2gk
	gJ39r5xfxGjt5bOeIQcnH33gs6r+UXFu8X0UCCKVcNBhT1dhBsug44UJQN+J0Sm+7npDnJ
	h2nbTVtTyOYND8OYrfl/IlcB7z6X3CCrIbS8mG9y0mE/byHWEbz+iQh4W5GvfIRhnToHjo
	mgNYvIcoPJEESX7qbzinCgt7EUn+I5x8zOvGajYsBX+p96cwfHYjK6BJPAI0VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755064443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/PL5bVIhg5YW4tmmR/+KZ4GyDkbwX5QhsYoHH2cH4cE=;
	b=xx0ZtEXYJSGy3JCftzmRZx4LdFVFydzh3dXfxzvmtfoGfl+nQ7O0UZYcSBfw+By/55arWT
	D20R8POHNMEJqMDA==
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] PCI: hv: Remove unused parameter of hv_msi_free()
Date: Wed, 13 Aug 2025 07:53:50 +0200
Message-Id: <20250813055350.1670245-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'info' parameter of hv_msi_free() is unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pci/controller/pci-hyperv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index d2b7e8ea710b..146b43981b27 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1680,7 +1680,6 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 /**
  * hv_msi_free() - Free the MSI.
  * @domain:	The interrupt domain pointer
- * @info:	Extra MSI-related context
  * @irq:	Identifies the IRQ.
  *
  * The Hyper-V parent partition and hypervisor are tracking the
@@ -1688,8 +1687,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
  * table up to date.  This callback sends a message that frees
  * the IRT entry and related tracking nonsense.
  */
-static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info =
*info,
-			unsigned int irq)
+static void hv_msi_free(struct irq_domain *domain, unsigned int irq)
 {
 	struct hv_pcibus_device *hbus;
 	struct hv_pci_dev *hpdev;
@@ -2181,10 +2179,8 @@ static int hv_pcie_domain_alloc(struct irq_domain *d=
, unsigned int virq, unsigne
=20
 static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, u=
nsigned int nr_irqs)
 {
-	struct msi_domain_info *info =3D d->host_data;
-
 	for (int i =3D 0; i < nr_irqs; i++)
-		hv_msi_free(d, info, virq + i);
+		hv_msi_free(d, virq + i);
=20
 	irq_domain_free_irqs_top(d, virq, nr_irqs);
 }
--=20
2.39.5


