Return-Path: <linux-hyperv+bounces-5916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B889BAD9869
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Jun 2025 01:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C491BC0CAD
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3871F1909;
	Fri, 13 Jun 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGh7t/7w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC32AE6D;
	Fri, 13 Jun 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749855671; cv=none; b=J/hX/3onmJn+0k/JOQBMVHna3NYFWky/XcOghs/sSDGHMeRsyjWSVa7sIterACq/Ggdd9seAJn6i+fYLFwJsSUPQ7QS89rOKh9JeQ/kJmcr8hNqZXSG0cK/5EkL0HCygpIaGdID+H5Ubwo8jpnM16P4Jcmp+ZIMXMH7iJJKNVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749855671; c=relaxed/simple;
	bh=M9zoKFR+/KDLHxuIuhSXg4LiHYITxg0M35Zs/GI1vr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ASARpQ7vWZFXS0wAOFdZgvQnXY2CkAhdFshAKbYF2yK4znwDwIqkwD70m9XhubYkKkyMAKXFHONGzIqL3PkGmEmufeT3Ujt5zrNmZBNXAUaj8ixbjHqX26rsVDuMZJjra6zPyHTC7/ZovXvDCS4jSS3KLtquWxJol2Z5sfdHDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGh7t/7w; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so23597505ad.2;
        Fri, 13 Jun 2025 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749855669; x=1750460469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+FJZppz0ta9K3Wl+J9gWvV3jQKJq2Aslilwaz9+jD4=;
        b=jGh7t/7w84iNuDpGrLGGD9meVojSF9x+cSh+BZmax19utbrr+II6RuINw8K6rYCu49
         /L2MkzbA1IkDOpjiicp8CEzKTZJegE+rYBuZS/AsoQnehp31wUpqL8SrudhUmflJmgxH
         lLbw9HOLnUDRN8T21AVMKXDDJvxLveOYpDTNpekWna2KcJYt19FpgvWl3AkJdSy03BVH
         TXfWDgZMIHx/6p5MMIlIyJOXTUqfqBCtsa8AsslLTr88ELxWaaIVVX9AeZTsnmcsB84l
         uIL+yj4M4eDI2ifBRsLwh0PNIEqdut7ba2xAf3GtgNbfU4cXXi1UZ/mOJGx/9fApAFw9
         FTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749855669; x=1750460469;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+FJZppz0ta9K3Wl+J9gWvV3jQKJq2Aslilwaz9+jD4=;
        b=E3h7iS2JHaBwKQ/5jnzOUcpDlCCqDq+wt5cX8V3kkUBHNCBWwHgqSfEP6f+oI8aGaP
         EoBB45QdzQ8qaEOyHemqslhpb3KaHgoWJklz8ekM93Iu5z3EwV/cUoOekdI6hGJ1GkTl
         6bGJU5iOdThvYVCzhP+s+n8qniD4A+6m6mT/1oJcJHj8J2Ln568cwVPsxEWflc10OiPy
         mZGlY69li5JfvjcptABh3dFdPNgLZ1wMisVmJfmswQ3g1Crn5RfY24UD/jK3Qr7RN38u
         Mulur6t3P1k8U6gCNwoVVkPcqDHDU1/RqoQNC67E40UGlbj5eOPpnxWFoPbktRtjrRAi
         mDdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZV1ZrgqOL1wB0OOSQEzSd3V1JVbkNsyIsPy5qAeSFmPMnv75Ssspl7UrDTeNhmvooRfmUGvMp@vger.kernel.org, AJvYcCXeQI4Dr5trBgn8lg15imkztzxtP0K58qEVVmkzCas5GTwo6ehED/K9Zg1qrZVBYtZbTbOLe8rOITNgP3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzM4lvDYfMYqTxzKag0NJC4eJBHPayvsvqgFeBhFBAaW5UJ5ui
	NvKYpCGgDuw1j0FvEz6g/YH+OPAGtJujYsKvRGqhP7CB0JHgIdv4L57y
X-Gm-Gg: ASbGncta2QvtqYC1wwj86asrNs3Sl02DHmLuOLeHPQc/6KHfRqsTqHEZzt+yOce97pz
	TNpwK76OluJcWYxaZC0NZUhNto/SYPQQXaAPFExHBFVFGGN/5Qn0l4hV9ocYlgSqErhjWvLmwAy
	mbBhzU9TgWRODRX+h4G4tMft5JAYJG7UDNH3k1t878rjDWQPE97meFU0kcWOdKq2Le4IkfT9M7y
	LYzqN76RixBxSJNuoQEONvg+l0n+Sm5FZGjpJYtaUKWtmxaldPtiuOPNEEQ5oxYHTgwWQQDTriS
	bybk/94oyg8Errvu8wXY9kiOlJauTm4Xa+z83nWr+AMzF+co7lemSkF7X5IemtFhrMTQjKcdHAu
	yg8LVqIVQeBjfbJalIvkileTXM9ucF2SBh+bmyMphxQ==
X-Google-Smtp-Source: AGHT+IGpB75SR8lFqFsi7d8I/dbchwwOmqSOBK5edbSvDoJLr8+M5aVqt59dgbdJq+s1FMTaHrKoTw==
X-Received: by 2002:a17:903:228b:b0:235:655:11aa with SMTP id d9443c01a7336-2366b17b16bmr16815635ad.39.1749855668643;
        Fri, 13 Jun 2025 16:01:08 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89387sm20055835ad.121.2025.06.13.16.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:01:08 -0700 (PDT)
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
Subject: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is enabled
Date: Fri, 13 Jun 2025 16:00:59 -0700
Message-Id: <20250613230059.380483-1-mhklinux@outlook.com>
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

Commit 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB
for Hyper-V guests") selects CONFIG_SYSFB for Hyper-V guests
so that screen_info is available to the VMBus driver to get
the location of the framebuffer in Generation 2 VMs. However,
if CONFIG_HYPERV is enabled but CONFIG_EFI is not, a kernel
link error results in ARM64 builds because screen_info is
provided by the EFI firmware interface. While configuring
an ARM64 Hyper-V guest without EFI isn't useful since EFI is
required to boot, the configuration is still possible and
the link error should be prevented.

Fix this by making the selection of CONFIG_SYSFB conditional
on CONFIG_EFI being defined. For Generation 1 VMs on x86/x64,
which don't use EFI, the additional condition is OK because
such VMs get the framebuffer information via a mechanism
that doesn't use screen_info.

Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-hyperv/20250610091810.2638058-1-arnd@kernel.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506080820.1wmkQufc-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1cd188b73b74..57623ca7f350 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,7 +9,7 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
-	select SYSFB if !HYPERV_VTL_MODE
+	select SYSFB if EFI && !HYPERV_VTL_MODE
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
2.25.1


