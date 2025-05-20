Return-Path: <linux-hyperv+bounces-5567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0DABCE0A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 06:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC74717E882
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA41E570B;
	Tue, 20 May 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA9/Ym2J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA971E51FE;
	Tue, 20 May 2025 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713709; cv=none; b=FUAfOyPmwSH9eJISuBfnCpNgcfIWqNU0/e5D/Sf70O0NL1DWo9Z4dfLJqctQCkk1DuEaICoXOIHRrAvx8RoXhz4WelOszNKJ3ZsE30BFSUttfbBRbiD8vejhcrqA9kpyKJWIB7IFdxLB10TPAED6nYDehMo3fZBAEU8deCBCwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713709; c=relaxed/simple;
	bh=MIvXUOnMPSdi5zoVIlxm5KaWG40huaNQe6PyC6jCeoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmibiDi/eNt/XW8JvewVuo5RndjqmRwp3rPsPNBwLocDWuyAztGIwtOHc1qqZszILtJrajiq13q2PF5SNyQ/CY/9ySv3efFLaAy+65C/ae4B/Zpwo81M1gtIcshsW/Kuphqc2NaUR2r5jFEX/+D/us9ZHL85KevIY6HXaw5DZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA9/Ym2J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4983007b3a.2;
        Mon, 19 May 2025 21:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747713707; x=1748318507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQFyxFeCf4QFGfYKfS18VbINdnTgdEdPG+DnfYGm8vA=;
        b=YA9/Ym2JrHX3sMzCnK5kVt21/R05fQ5n52MoaKIMDTnaLsKXjKkkR8enKgMHI7Npwe
         VmFZaf3gMM3ed5J8MnJQNdzKOgHq43RoFehaD71+Ybxg6oVkE3Q0/M55BEcEvgwCYm2p
         QGYnflPqPtRfnH4GhHZ0EjkILfYald1b/vJS3NwzToCsP9Vu71HK09bICtW5QQnzAt1s
         8OzAop0KvibhrSPsofMudA4tDwmhRyeDq16bbFdNivOSJH7NKPA1zSUEsL530RIKJkb9
         kAu9Hmqca3X8P0kWiSex/NQpm1UigGSDZ9fB8H6g223CCvauLEWllGPvbUh2yjR9+N/9
         frWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713707; x=1748318507;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQFyxFeCf4QFGfYKfS18VbINdnTgdEdPG+DnfYGm8vA=;
        b=trJZMsbN/+Veazmc7aTm0k9ndqwkPU/n96ZZY5b/NeLahPHWLvVTkLHq60qAEm+HUl
         XIli4PnHUFzm9utetMyD08pXyhQ1ke3EfKdfgxhymTv11ghvhH7CJ2oeGetCndB+DKSQ
         nZY6C/OcRHqjHu9QYN1Q7XVY0aPOvao38SP20piG+YIGGigAbE1tP9a1SyVgvQy0RpTI
         tRtL+5Wqx4220lZYVmp8jjtEvHxZGU9VslxaxMBy3Ggi2enxxME14qowxQfIH2eKJEtL
         ChUvQPOPqWWwiCHp2jxFieP1baxpcIaKQr9M8Eq7Wcd1NXodUBsCPVo8CmhlOYj539E7
         l6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV0YiH5ZbJ7EzrRj4TcwIgMOtyc+jRl9+i8rfltymQjbbessVQ6Vgf4bFoHAcmB+KLjUFymgrNVPrVOJiA=@vger.kernel.org, AJvYcCVNdglmj0TQlPGclJNrpjCLt2eIQnV1r6nVMewG5jAoqbESvl5tVDMyuHNV1Uzq47wYxGTHMZmW@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlIFFgWYGJCIX6KwmSppUyB2IAKywW4eYtsuJ+bk/TPWs8I+I
	Mhyz1Rfx/v6JTXI5kRRxpF8Ms+mD8bSOAcRZ+pjBZROc45QW3FPBP833
X-Gm-Gg: ASbGnct5lD8/a6qTF9GKorvrMxdZyzN48s1mOC5xulXGqtCgzjocQx/dkFLZhDPmGH8
	I6Ia5dX8Zp+elckW2SsQq/2jKukBcq2KxNTkyG6IR4uD77MfdN4qLgyp8wzBF4ESBJ8537NmCvF
	dTjAbyF79ZHllBo+9omPt+iVtSoiH2Dxu3C/1IIFlM33IIAONCEkmIfqfn5Y7eq5vs+9tLwKCVo
	rAnUREMEFKwY9qTesPQzduQ5c1PP8ceDfoDYZlKPD9Or2qWjNlzSeTiPduQt/ePTAAieDOYvx9n
	nEsdRvIVDcqCifFj8ADAQH407E76jQ0j7bS6BdjIlZKu/XWEnGo5LyQK+jijkQULMppQhltv9VJ
	CgOnT8Nsn9WnwuqAYukdbsKm8GvRXJg==
X-Google-Smtp-Source: AGHT+IFP4Cbo8/KuRNTms2PVLrIoYUdA/qTJAcnF3gJz5vdQ9Nn+4KkqyBWfkU1oU7YU7tFDSsOCHA==
X-Received: by 2002:a05:6a00:a06:b0:742:4545:2d2b with SMTP id d2e1a72fcca58-742acc8d18amr22090011b3a.3.1747713707097;
        Mon, 19 May 2025 21:01:47 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96de0e5sm6986740b3a.25.2025.05.19.21.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 21:01:46 -0700 (PDT)
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
Subject: [PATCH v2 1/1] Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
Date: Mon, 19 May 2025 21:01:43 -0700
Message-Id: <20250520040143.6964-1-mhklinux@outlook.com>
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
the PCI NVMe controller is probed before any graphics devices, and the
NVMe controller is assigned a portion of the framebuffer MMIO space.
Hyper-V reports an error to Linux during the probe, and the OS disk
fails to get setup. Then Linux fails to boot in the VM.

Fix this by having CONFIG_HYPERV always select SYSFB. Then the
VMBus driver in a Gen 2 VM can always reserve the MMIO space for the
graphics framebuffer driver, and prevent the undefined behavior. But
don't select SYSFB when building for HYPERV_VTL_MODE as VTLs other
than VTL 0 don't have a framebuffer and aren't subject to the issue.
Adding SYSFB in such cases is harmless, but would increase the image
size for no purpose.

Fixes: a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
Changes in v2:
* Made "select SYSFB" conditional on not being a build for
  VTL mode (Saurabh Sengar)

 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index eefa0b559b73..1cd188b73b74 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,6 +9,7 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
+	select SYSFB if !HYPERV_VTL_MODE
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
2.25.1


