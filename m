Return-Path: <linux-hyperv+bounces-5538-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE1ABA6CA
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 01:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E456FA084B8
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 23:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131E281359;
	Fri, 16 May 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04bjgrV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184A280CFC;
	Fri, 16 May 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439907; cv=none; b=KlQPTg7wvkZuZwfx+O3a/vV2Oi1lQXNF6A5JlHs4S97SVdC4im3kqk8r8JYAqrHSsRoLcK24ndxrvucKfDnQT3Hlm9aEcO8HTvO5TAIM1v3tI1kKNT235JGOu0asyQ1zHT+m6MRsDzddymMxl42VwqLyx9Tfwq+qUmh7gq687Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439907; c=relaxed/simple;
	bh=dLPWo8p5S7jXhx6lzUieTQUgtP82f+SlggtlT5yC8Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PHAA25H7ZxovmQb/W783HpROMuyGlA7FMiDsRC7grlwLDLz8Dbbc2wMumQ2Y/NhknXR0G1pEFTzlhdaJtc1SClRv2j59Id/h9qH1+cAwCfbHotSfqrNKpE4zsilCB/l/iakOWpNyYVCi6CV5N0VWetRGzbA/GfzgIZfudKdbEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B04bjgrV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399838db7fso2673404b3a.0;
        Fri, 16 May 2025 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747439905; x=1748044705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bwuoRfOPo8GFKpgN2X+lU2AEPJyJuQqDV19M1X8gq8=;
        b=B04bjgrVCjlAbk0W7KnYgZqiJ7nZk/3my18dF08xS1CT84XJs1GaM0zGhDe4+dCowc
         iRZYmaDqvMvUbujiY7qD+kYwmdQvos+ml1q4CF/8FseQxEXcEDn9JE7Xv8TxJsFWD4l5
         yUEUaFtIo6YsIzCMC3KfHANfuqh5LukRy0uPJ1NQ6VO/MfuF4PsQkYT7S6dqzZxbaOcW
         7cNjznMEt9U4QdajTVOteAJXZDcSNc4CMU5ptjLC/oxEFdenf3AwbnLJCOb1E23uXhi/
         GePvyzdaiVjqOYdvMrw+dzdy0Ezy+a3G0y/bHXpE4PWA3ms90L7I73TY0t2lBdfnlgt5
         Mi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747439905; x=1748044705;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bwuoRfOPo8GFKpgN2X+lU2AEPJyJuQqDV19M1X8gq8=;
        b=wkV73oK1e5cLBB+WTewgQkvFHEww3Kcvt6QW+HMl22BQXE0qcQUz5FxWua9xtSRMCp
         cEueGPA1Iiz3CTTzw66Zrk4FLV0xpSaQgm7FPZZ5gKspIq7cjzWUQbblllWFxR8S7f5J
         kh5HghBu6IvRH6oysxcpEJdTqdUumIbE5fpXw8sOC9KroqPN8HuYQpcysgXeTXpKd6Hu
         kGF0T23ZbBOvS42Z33d+L8xnYEh6W7TJEKQUA0mW2Julw/LX+T/qvm4hs1OTIbd4prtG
         eH1ghM8qk80xlbGTm3PN3GIctZAn6izXVdlw25Anx6mVB1Rwrsf7Z+8TiQsywl4rn3D8
         gL5w==
X-Forwarded-Encrypted: i=1; AJvYcCWuQTpMEIpZUDiZIMEexZ7sCrDEvN7a5pZcthqFvhGGlPoa4qynrRBHJmDswVbg3W8qUaZsa9+mABIvFNY=@vger.kernel.org, AJvYcCWxnqLwx3r4NpquM1LBsZzVK6a5ffvA+IzUZzyw2P05acTQbYjCJsk/KP36tL2aBAjYBz3NdOY7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyppl6g2uDM/8Bb5EImrZVObZSfjXcn23TfxB7obx0I9sokAZfv
	niJNizv28Nc6SwExYJxLUQSJujN20E27ovHBoEsWpjdbQ1Zv7ht30gIvdHggog==
X-Gm-Gg: ASbGncvfPDUE2Blg/9LAnX9llhZcV6dxjJhRJ2CBRNmBEKiM9U5U5+BY6Q9lnEzCMf+
	WJiGHaU9Sxglxyww8yRQj3dn5GZTVyxvDpzl9vUzXWfP8VOEnRjPZ6JzXmEJOOghEX2siW9PMvH
	D3GPQMZCpuFNbxjFqiD0zee/k83LO6SNk0RjG0iyEDz+ckXxKFe0fDZ+rmnm5VLNWJL2sP4ocht
	+Zw9Fdak3ogpssd38tZNCttb44x8fwVamJ+ihs1DjJs7gEFOmW7LeYbM8rGBqz073rjUznyeyDb
	hU+Yko88iwLrfOMWGkh5kmagdJa7isaafaqk7g8+FOB1dZHoRDIqE9t3AYeFJdKb3SBEexgmGKk
	BCYt4hXNB3EdJ+nSI2cxOzz2S0faU5g==
X-Google-Smtp-Source: AGHT+IEhHv7yJ+DgYkwgW0OYv77eGcF1FGJ+fusJqwHGrATVTu65OV660tL3/jBUEMicSLLtGkyXBg==
X-Received: by 2002:a05:6a00:3c89:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-742a9b16af5mr6755800b3a.11.1747439904877;
        Fri, 16 May 2025 16:58:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a987677dsm2157153b3a.132.2025.05.16.16.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 16:58:24 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	javierm@redhat.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
Date: Fri, 16 May 2025 16:58:20 -0700
Message-Id: <20250516235820.15356-1-mhklinux@outlook.com>
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

The Hyper-V host provides guest VMs with a range of MMIO addresses
that guest VMBus drivers can use. The VMBus driver in Linux manages
that MMIO space, and allocates portions to drivers upon request. As
part of managing that MMIO space in a Generation 2 VM, the VMBus
driver must reserve the portion of the MMIO space that Hyper-V has
designated for the synthetic frame buffer, and not allocate this
space to VMBus drivers other than graphics framebuffer drivers. The
synthetic frame buffer MMIO area is described by the screen_info data
structure that is passed to the Linux kernel at boot time, so the
VMBus driver must access screen_info for Generation 2 VMs. (In
Generation 1 VMs, the framebuffer MMIO space is communicated to
the guest via a PCI pseudo-device, and access to screen_info is
not needed.)

In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
the VMBus driver's access to screen_info is restricted to when
CONFIG_SYSFB is enabled. CONFIG_SYSFB is typically enabled in kernels
built for Hyper-V by virtue of having at least one of CONFIG_FB_EFI,
CONFIG_FB_VESA, or CONFIG_SYSFB_SIMPLEFB enabled, so the restriction
doesn't usually affect anything. But it's valid to have none of these
enabled, in which case CONFIG_SYSFB is not enabled, and the VMBus driver
is unable to properly reserve the framebuffer MMIO space for graphics
framebuffer drivers. The framebuffer MMIO space may be assigned to
some other VMBus driver, with undefined results. As an example, if
a VM is using a PCI pass-thru NVMe controller to host the OS disk,
the PCI NVMe controller is probed before any graphic devices, and the
NVMe controller is assigned a portion of the framebuffer MMIO space.
Hyper-V reports an error to Linux during the probe, and the OS disk
fails to get setup. Then Linux fails to boot in the VM.

Fix this by having CONFIG_HYPERV always select SYSFB. Then the
VMBus driver in a Gen 2 VM can always reserve the MMIO space for the
graphics framebuffer driver, and prevent the undefined behavior.

Fixes: a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index eefa0b559b73..e3b07f390c03 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,6 +9,7 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
+	select SYSFB
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
2.25.1


