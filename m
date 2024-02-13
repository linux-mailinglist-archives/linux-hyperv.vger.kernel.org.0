Return-Path: <linux-hyperv+bounces-1537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DC8528CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Feb 2024 07:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0BE1F24F51
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Feb 2024 06:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555013AE8;
	Tue, 13 Feb 2024 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRiVg+nO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D812E59;
	Tue, 13 Feb 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805162; cv=none; b=GZCeLaDHGHWnrwzGUKwZkPIoInZ8v3NW2VAyyyXAtO/FfVruF5UziS5AD6XlvUU+IoTCDkHlTGzk0H3Sk4lcTuBgmN9C3pMfohJ0KBi1QI20qo/MLeM2F6iX8TIFEC0yFhmxvLyQpyFf0XPDSCeCZqkanQna8HtT9zhFTzUyWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805162; c=relaxed/simple;
	bh=Bq6I128bvmfP7CIPbKWfRx5XljFIN1hpkee+rcCuW0g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PZes3KE+ueLX9hH6FbiiKrxqq3IrI+0xAnK3Lqs5hR3f7qYYmUKI0HaHQPOvQEIGGGEC2KS8tQEBo6fx4Rh/OiWnAZfmnfvNIb3cNwm29kDv15fU8hPiu3wB4CdP3fcbvk4JJMOHHVEZIs7Hsrw3pk7I7mcu1TueZt9f9VGWRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRiVg+nO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e09aada5fdso1452842b3a.2;
        Mon, 12 Feb 2024 22:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707805160; x=1708409960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSUXxf9rKIZ5QHJT17kboCjddB2OwzgjJk8RE9Ix4hs=;
        b=lRiVg+nOsUdlRrN+4Fx/8z36EupMGQBfytx15FBWUtSGRFcAavJDff14e9NEF2p4+p
         R45bK2UJWU++xY41rU7UBGvXk7xyFWLJwRxqD9ywhIZ8wMSw+nbEwdoqh9kMUtgbGY4I
         vBObv30V+RcxnZ+LYWWG//Cw0aoA+3S5Gx+8bqPb6QDW8HiCatxagn2by8bXUkDq6lOX
         cd1Y1gNHFOgRPTEdZs+r44wcLmCP3sjrRlu9z4jkmHROJihZTDWocCo0rWmsznSlWx9s
         /nxSfFoqk4CJpcLHUtTOWh/iF5Ix8fpEWEnYKA7ch9LL+Sw28EjpcXsg7TnUkiwaJf2E
         wFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805160; x=1708409960;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSUXxf9rKIZ5QHJT17kboCjddB2OwzgjJk8RE9Ix4hs=;
        b=vveUK+1MrpH59+Jg8j+eOF7Gm1BCGzHkiu8/lw4k5zo/vv8IwQ8ObKJe6aYgzuCZz7
         9jEdWvsK6q2bu32HoKQf1OwX5XCIYo+OhnSDNg5thsIpwfx0IeNc/rCmd3Tfu1LCqiS4
         jme6CiGFxVzif/xYU+yfGvudvTEKVQO2u0g+IIGgojfa88tcJ+Zt8fhvPlB2T91Dv5Ew
         XiP8IKZEYVKmQhHeCh+4PuhUjrGbcArdwkj5IFG9hoxV8ejDrDMjTsT78fbcZM4tP4zB
         NVxZ6WkcDfd90Z8rLJcQfxgGyuro4HbvzWUjGu2Htz4UN/N22IAUDM4ey2AW2bSok0He
         Jxjg==
X-Gm-Message-State: AOJu0YywwzcJzeafkNCdbeOMyMtQIooaUhCXb2uozdoWh/7SukrFlxIs
	LtIhrmTJ2+ZG146n0WfcegmOuVuaVL0MgWHATFzo5pCFUYXhlJ+i
X-Google-Smtp-Source: AGHT+IFb9qEI5aDNOFETMlf8ChN7RcGGnNFlSGRIfhszVaPMtK8xMjyklgPBTZNZmR8K0M8dn/xdvQ==
X-Received: by 2002:aa7:8814:0:b0:6dd:8a07:6969 with SMTP id c20-20020aa78814000000b006dd8a076969mr8113667pfo.5.1707805159836;
        Mon, 12 Feb 2024 22:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIz6JYz+XlZe1sf3x+i71yopgigoDCFglxMi3mzhK2vX5j+U2gDCfWMH2a69rcKoxZeNP6DAodAXivquITdspmLCoMCz7K8730GC6BUp3L1hKO1wrWiAIDxcp70Yk7PJnEbVTeZUI7/mhAiLQIJNRYg0ARtQsfA3sIrXU47DXnYQVQBJHJfRHO0mRN9R4p1ttYKydrSiK8SFaU1XQL52h2GmzCj5jDAqnIPAsd0ogV2e3qcuY/8r3KgCVsVp1nmkU9qLag4WH4SaAZjAiT8TFTyYg8wMhesUp/+O6v/PPJHeZNdH7el0YZSBw21dRaKV9nQM2bWfKXBSo=
Received: from mhkubun.hawaii.rr.com (076-173-166-017.res.spectrum.com. [76.173.166.17])
        by smtp.gmail.com with ESMTPSA id j20-20020a056a00175400b006e04553a4c5sm6595921pfc.52.2024.02.12.22.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:19:19 -0800 (PST)
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
Subject: [PATCH 1/1] PCI: hv: Fix ring buffer size calculation
Date: Mon, 12 Feb 2024 22:19:10 -0800
Message-Id: <20240213061910.782060-1-mhklinux@outlook.com>
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
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1eaffff40b8d..5f22ad38bb98 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -465,7 +465,7 @@ struct pci_eject_response {
 	u32 status;
 } __packed;
 
-static int pci_ring_size = (4 * PAGE_SIZE);
+static int pci_ring_size = VMBUS_RING_SIZE(16 * 1024);
 
 /*
  * Driver specific state.
-- 
2.25.1


