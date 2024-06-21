Return-Path: <linux-hyperv+bounces-2467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8A291182B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 03:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F9E1F22427
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B482492;
	Fri, 21 Jun 2024 01:48:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94742052;
	Fri, 21 Jun 2024 01:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934506; cv=none; b=n1Ot2a1lSzZMvO6ENBuRaVcs/EO/z3c6xqD42WbyXzXnPJgW4QQMkYqQMxC3LEMkkTtpWbIZFwNwQN5kXKd/TD0MdnpEXzvLkPcXzjwMy4yVfDl96MLAHTTAZ904ftkJMwv5EMOwk7Ta/goMQ51GdAqeSBcS+7vCPNLqbkBqD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934506; c=relaxed/simple;
	bh=ozSdSpLYcsECV2qiy+CpvQj/rueQOr66KhVYdebDG1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2agm5gq9KdoCeJwAT8x0Gl3fBXeZUOsdS8lrr+8BLevwFWLUdnXx7dmx7wBurf4uiNw8HsL3gwv4DNz04xvBY86ohL/NB9LdqSbtdn6iFmYPKH5L462Wi+OBQwbw38fSbUVdQS1t9ZXoSBlIisGW1WLw27i8NOKOsOmeQHWJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7163489149eso358655a12.1;
        Thu, 20 Jun 2024 18:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934504; x=1719539304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM7ZghpXpO3rkmhvMsqvJ26wksiPNOA5wfXANwpZtJg=;
        b=S3368HmWTy0sI/1inlfz5E8FO+sKCRKM3Y1w8dy+UtKjHT64YIFXD27wM2nr2e4ueN
         d0vCNKdJgFRmcMSoDGSyhDmqJ/NbNdlhFppMXlWPF4TBXOAiWObHBZsIJzrPw0077ZSO
         uPFjYuJrytWuGEHkQO5x0rnVpPZMaArZlFol9fr5gf6e9EOpxsEWuQOhlhTmmKMMjRK4
         C/9Z1KdmjS5er+PeUSABW/3sRNKKfTyg4RJVyU16/tJbd8K0CbSnXI6bw9ica3IqAA3K
         9scin0LOlrr+GYFGDWr7Afnu6y7mqDkcBUUuZIu7O1j7UmsqOmhvwb0lK+kusnY2ma6b
         gvTw==
X-Forwarded-Encrypted: i=1; AJvYcCWXDBRbbcRVpYDaNEmm090eRNT9BQi2yVMtn/4JOiFaDeYTv6iUnyeXTdKfgjft2cSIFk7ZYiHexfNCnX/FQwTWAEBSqANESxKP7es0fQS9hDm+SObNMrvGNcVYKeN1heOdXYuW9/Eo
X-Gm-Message-State: AOJu0Yz/Np/y7j4DDkHHtsiq6DnIV8sz8Z0fnqzuM20J2cGjecVGU97F
	MjFUMyXIwXYgZjhA5h5jteAgEiABlL+nZHeBE47pDJ5FJrGFG9fgsg3T7g==
X-Google-Smtp-Source: AGHT+IFPJeCguyTTRpovNz6rm4/HvHMTcLXnBOa/l5zBqnP8+mWweZjAlV7Fc+2OoeZ8Te5c763FiQ==
X-Received: by 2002:a05:6a20:30d4:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bcbb45f3f7mr7415400637.29.1718934503487;
        Thu, 20 Jun 2024 18:48:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb5d03sm2759485ad.258.2024.06.20.18.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 18:48:22 -0700 (PDT)
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
Subject: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN
Date: Fri, 21 Jun 2024 01:48:14 +0000
Message-ID: <20240621014815.263590-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent of the code snippet is to always return 0 for both fields.
The check is wrong though. Fix that.

This is discovered by this call in VFIO:

    pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);

The old code does not set *val to 0 because the second half of the check is
incorrect.

Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Cc: stable@kernel.org
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..eec087c8f670 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 		   PCI_CAPABILITY_LIST) {
 		/* ROM BARs are unimplemented */
 		*val = 0;
-	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
-		   PCI_INTERRUPT_PIN) {
+	} else if ((where == PCI_INTERRUPT_LINE || where == PCI_INTERRUPT_PIN) &&
+		   size == 1) {
 		/*
 		 * Interrupt Line and Interrupt PIN are hard-wired to zero
 		 * because this front-end only supports message-signaled
-- 
2.43.0


