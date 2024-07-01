Return-Path: <linux-hyperv+bounces-2514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB191E98D
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DE71C20DF0
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E48171074;
	Mon,  1 Jul 2024 20:26:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE742AD0C;
	Mon,  1 Jul 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865580; cv=none; b=a03mz81wQXvjjn/KSnHmsjVybCKhSNxDOIUX/Bic5LI+4Set0QlNN28s02cwTx4xNWc8DqHYD/hYLNXKdXmfrrj/+ABcHxz/vgCteqm6uTmjfrxIK1fmJCXhycpxfZIpQCmZzxBN624x/MDrIze0Slz5m/PrXPByoYtQE+DZX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865580; c=relaxed/simple;
	bh=eR3hh1+XS210oQnDU9n0EMfkctIm37rEsxObT0XcN7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+kVWQFRWz7tpCom7XOgRGB14UyZdd7uzdaIxo7/Cdd1D0pm0lXZKuZ6urSPySsnbqHwn4TkFubnKViM1+LJZ+2kZSOM7WxTaophLIjZ/7bdCdeMl3XoYq83//24mJBc4gMYcfZwqKYbIFBjJDaajyKBwWnMqmli3i3FrA76DnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9b364faddso19921735ad.3;
        Mon, 01 Jul 2024 13:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865578; x=1720470378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdHPbFHUncvFeJ/DAqyKKSF/mF1oyNKAV5RldPg7OyM=;
        b=VkrCmTCc0RB9S80A+L8yaDBgEgbncwa7WNWLZzRe1CWZezq8sHWHA1f80curxo1N2l
         ixwNroUxBcX7rd1H3eZlhGsyErD1TtYB6rChbCLwYwwlcKW3Kr91CpU8uoPLVUKVux9P
         4ZKfy3qLGXoxiQupFDq6XGr0vZl6x1EYdZ91CXECY3Z8A2jq5QYzibm6QOTccy0Ahuzp
         74zlz4kgqn2Ss3xmBzHspslbSzCzGN6iYV0U+9973dz1LxLwzhhLpq9G2ZhY2JRnKifK
         pYSdNnYCO+FnCk6mhKVx6eE3ufCZsKFHNCtENXU2n88QHZGMRS9HY0iEHCB9nf3c0BV0
         GxFw==
X-Forwarded-Encrypted: i=1; AJvYcCW0/XNKC91LvHxioUG7++0rPBVTXNdFhDVj5Pbhq1nQgboqa6ElvfAl8xZ44IMbr5sI6m1GbvdiRKvp4VtSf1edpS/XQ9Rjv2h0+R2geny6BppQE5gKB24fN//VLgVx4J7Vckxs4DCy
X-Gm-Message-State: AOJu0YyLpt94B+KbycCPVrjcJKzsoctVonTmDcotORPtAFtYibweNnfS
	jMpo5jTOuZffiW77rj9rtI1Z6OfIi7kR50X/mXegPZMjHnN3QFGJgtdPHw==
X-Google-Smtp-Source: AGHT+IFXsgetXTOH0qwRvAUhLUDyzqZQeQTG3maWudj/BKSHy5rle/iQ6aEa2iMUR5UuJP0Ll9kUvg==
X-Received: by 2002:a17:902:f60a:b0:1fa:2c91:f004 with SMTP id d9443c01a7336-1fadbc736f9mr46987895ad.16.1719865577690;
        Mon, 01 Jul 2024 13:26:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596920sm69135615ad.268.2024.07.01.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:26:17 -0700 (PDT)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	stable@kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
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
Subject: [PATCH v3] PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN
Date: Mon,  1 Jul 2024 20:26:05 +0000
Message-ID: <20240701202606.129606-1-wei.liu@kernel.org>
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
PCI_INTERRUPT_PIN. Garbage is returned in that case.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Cc: stable@kernel.org
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
v3:
* Change commit subject line and message per Bjorn's suggestion
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


