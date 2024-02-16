Return-Path: <linux-hyperv+bounces-1549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E568586A7
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BF12811B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1421386B0;
	Fri, 16 Feb 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6uSvDHD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48211384B5;
	Fri, 16 Feb 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114975; cv=none; b=DuCSN9EsGQU+dmrdTNbQnaW6vQGctPE1Esibv79zQToh+/VQay9navhBDk6C3J8Y7oUZ2/hvkMAtCr9CEslPgdCRDPWpGXk2NHj5rjofT8T9mYNdtp9rIt7nnBL+9S3ZgGWPKLwY8qo/4XcrxwAEH+fhlpx8lQGkZlcXIgcVgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114975; c=relaxed/simple;
	bh=4PYSs4dleB3/NFv00OZmfg/mp6ic+ohpvdY3ebs4U9U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KSwlVCvIhlG/sz2fHLQV9qbJkeY7x43Nh05M4l12UwvOvjMoXvVYomGoMpDpnHEGd1ySlbwwyi5cQH49wngvqrppQ7D1777jmbd7Kf2hI0tExOthkLJuTs+3Fg+3s0pIKTIDU8pNJjP/Zbv5Fya505494LdplNVJ2r6hkWQtdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6uSvDHD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e141a24ba1so569103b3a.2;
        Fri, 16 Feb 2024 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708114973; x=1708719773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eU81Q2BIgD5tYrvXfgv/ucxZ4EAgYPkPtfRpCQEtrgQ=;
        b=A6uSvDHDifXaNhJE+omMflnMznumPrdVKH/4mp0XRC65qS7Lc6t/tMjFF+cMiRSJ9x
         NfdwFIU0Yu8dOvIzEEcM4WlaFlWR30cf2ClUNijb5eMPcuz17QYCxluyf/M7jgjbu34n
         Pg0JwqF87pHEgbY0n4iDZ8glHUmGaXJJziXb1V5pOTvbbYbWpBNPGAppmxia6/E6uYmS
         c8nbGqCzabf15bfAe4qeUVGb+0fqYwickMJDbXyE1pdUW85f90P+nfOzrL3qpeLkKsFW
         tXbOO9hTuJg7sP+lekp858ydco+kcgM+S7Pj4i2yo66F15bnre976tQd3U4gEzGwjWJH
         aWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708114973; x=1708719773;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU81Q2BIgD5tYrvXfgv/ucxZ4EAgYPkPtfRpCQEtrgQ=;
        b=r5G6E5+jOUzpyI5oggIVBN+2UnGUdxuXpb3zY50xzTdNZ1YLPsSOcAT99P0kGudNPL
         UT1lwizArl6DwGWkZ9L6O8Cl9aWyM0TZjymuvF0Lb/f7fpLtrKVUR2jrqZiju3tb+M6i
         RPWDp2WrmWOilHoHTbjRAD2ZO1SSeoZ0SfWD5djw2SXedih9qF1GDTV/LbipKImIqLTs
         MEZ73SI9aldK95lrG12T7B54qC9Cx2vWNOUsD0OjI041kZeACGFYWuPlIKQzpTCo/So2
         WwE21c4QPdF5g9I9E1du0lu9EwzOqosdfRODcYBbD9tNDo0xoAM9CMPw6Mw9saYm6GoF
         Ih9w==
X-Forwarded-Encrypted: i=1; AJvYcCVM2LE1SRql0XXixRHsNuWFlUAWWE/zN/As20vch/hErHqm440jEIowYCoH7dWN4jg0JYM7kia/tWsktt6eyy9vYi4omuspbfltxY39uK4+6ADVlbMnMJKuGnq8caHRFgtcVMgFoBZNW3Saq+KiNbafin+REBa1WGA4AASrdl9970nTI2Vu
X-Gm-Message-State: AOJu0Yw1+t/VbVGBzESqil4mkNQKTEXYZ+vjReuujqGsx7oWGpaiomLU
	uj9OKSrLX3GDTs28UGheLE8TfQF1y5rwjlrJ7yP6vRuaWwwCMtXN
X-Google-Smtp-Source: AGHT+IEL2CDAl8m9TiNWfNbu7Vk5I4kYXLmLqswmwlh3NHCOrqSBtIKU6QO374pmOPIxQSEgD24QcQ==
X-Received: by 2002:a05:6a20:9f98:b0:19e:ca3a:612b with SMTP id mm24-20020a056a209f9800b0019eca3a612bmr6613211pzb.54.1708114972731;
        Fri, 16 Feb 2024 12:22:52 -0800 (PST)
Received: from mhkubun.hawaii.rr.com (076-173-166-017.res.spectrum.com. [76.173.166.17])
        by smtp.gmail.com with ESMTPSA id fk10-20020a056a003a8a00b006df50bbbaecsm352146pfb.86.2024.02.16.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:22:52 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v3 1/1] PCI: hv: Fix ring buffer size calculation
Date: Fri, 16 Feb 2024 12:22:40 -0800
Message-Id: <20240216202240.251818-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

For a physical PCI device that is passed through to a Hyper-V guest VM,
current code specifies the VMBus ring buffer size as 4 pages.  But this
is an inappropriate dependency, since the amount of ring buffer space
needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
is used for only a few messages during device setup and removal, so any
space above a few Kbytes is wasted.

Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
header is properly accounted for, and so the size is rounded up to a
page boundary, using the page size for which the kernel is built. While
w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
64 Kbyte ring buffer, that's the smallest possible with that page size.
It's still 128 Kbytes better than the current code.

Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>

---
Changes in v3:
* Add #include of sizes.h
Changes in v2:
* Use SZ_16K instead of 16 * 1024
---
 drivers/pci/controller/pci-hyperv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1eaffff40b8d..5992280e8110 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -49,6 +49,7 @@
 #include <linux/refcount.h>
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
+#include <linux/sizes.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -465,7 +466,7 @@ struct pci_eject_response {
 	u32 status;
 } __packed;
 
-static int pci_ring_size = (4 * PAGE_SIZE);
+static int pci_ring_size = VMBUS_RING_SIZE(SZ_16K);
 
 /*
  * Driver specific state.
-- 
2.25.1


