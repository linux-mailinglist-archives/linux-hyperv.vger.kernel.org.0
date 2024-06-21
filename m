Return-Path: <linux-hyperv+bounces-2478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E11912F0F
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DBA1F24133
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E616631B;
	Fri, 21 Jun 2024 21:00:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D362374C3;
	Fri, 21 Jun 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003628; cv=none; b=UqWkG+AY5DHlavRPR9eEYzEkiz5m0k8ay2su9VfLUFACN3J/LNP936GOE2zItYW++DwuxuFMTMk3jpML/q4BbJMsLXXuU4GNC00qNWHV+2QN1tkVR3WfDX8tIE1WtB+XW1ioGroYtFl2xdCasDBsN8AP+WG6SW1FwJxd2rJ6yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003628; c=relaxed/simple;
	bh=SYIOb/iA6VW4YoMV5zsPyNKNQtQ9kkt5Bi7c7qbFgO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQz+spCuWkUaMsmz/1Ytn3NCp2G3aUpWeVChFOeRPweXsqvaRBOMJm7hG2rxzUgKAGFcDFAlWvOZfrSaeUuIP6hSPH4X3eXau0S9j0UGi0Og7cMSnbD4CShBtHgZ5HTnCTMR/3+/x2HxNHMmImndn2DXHMPa6acqV7C60Rei+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so17021065ad.1;
        Fri, 21 Jun 2024 14:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003626; x=1719608426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmyjYpeZqGULeZcRGKfGB3jNg9toSNiwNYkzvaff/ZE=;
        b=pES+Irozky1LwvhlKtBFN0YHin6BComO2h/NGXpSpQ5XIrH1J1BsvdMwFApHX8IFOZ
         +Gg2o8hXHz4SR1Ed4ZasuwxIL0azD48zxfZtzLSYZZbQQBu7p4RFx2VwFUbOW2RZIocr
         O+hvl8YUfZemtZxJ0Fysdd4RsLRetxyBxkZ0l7ZDV/+40Qqt5XOTrd91S8c+lmC2kA65
         2p7iytOdgBIy50jWigZ4FGdL8GsO3DwBvrizGRL5CyezNtppwMnGfnCzmbT5OteCG/5X
         nLZRs8sO2kuwIgTu3WGjoE4fLL/wAhDYFHbiZhhmkFMy0GRyPY+ul4AYZqVZabTlV44w
         TRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUWhUZEuDlXwzfeGUIKVdnqdJ5rFmf9neg2PvshKij6nsGcS+W0k5MdHNFRrCssYy7dZBocFl9jukxAPTymxq0g1hSFpBxY7dJvchvoh/aKyKrS9yePRkbHjwGERJbJR5TkCl2zR0Uz
X-Gm-Message-State: AOJu0Yxj4YZRLS58YfsRvOsMuo+IzwA3nU5/jPc/YI0speCdtn5x/93V
	rH53jN5wdZUYeFxRGalMUc1GhZesW1PTYBAJ/GpXsW1z8sNxNcaw3fKyVw==
X-Google-Smtp-Source: AGHT+IFp2pV7UyQPGRHifCinU43JMn7qFh8JPsjZ+lX8g3RD0XOKYAB9yq8SDJwGaM6fDPnmiE3xxA==
X-Received: by 2002:a17:902:e84c:b0:1f9:e3fa:d932 with SMTP id d9443c01a7336-1fa04ab5304mr13526725ad.9.1719003626488;
        Fri, 21 Jun 2024 14:00:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb323641sm18380425ad.101.2024.06.21.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:00:26 -0700 (PDT)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	stable@kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: hv: fix reading of PCI_INTERRUPT_PIN
Date: Fri, 21 Jun 2024 21:00:18 +0000
Message-ID: <20240621210018.350429-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent of the code snippet is to always return 0 for both
PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.

The check misses PCI_INTERRUPT_PIN. This patch fixes that.

This is discovered by this call in VFIO:

    pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);

The old code does not set *val to 0 because it misses the check for
PCI_INTERRUPT_PIN.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Cc: stable@kernel.org
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v2:
* Change the commit subject line and message
* Change the code according to feedback
---
 drivers/pci/controller/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..cdd5be16021d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 		   PCI_CAPABILITY_LIST) {
 		/* ROM BARs are unimplemented */
 		*val = 0;
-	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
-		   PCI_INTERRUPT_PIN) {
+	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
+		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
 		/*
 		 * Interrupt Line and Interrupt PIN are hard-wired to zero
 		 * because this front-end only supports message-signaled
-- 
2.43.0


