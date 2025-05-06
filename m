Return-Path: <linux-hyperv+bounces-5380-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507FDAAC52D
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD781709E1
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7B15E5DC;
	Tue,  6 May 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENqc5qgB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92E19D8A2;
	Tue,  6 May 2025 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536836; cv=none; b=fi5pK/o36NpDHPwpq79ySSoDmdytKyxrfc38fPcBmGmLFcBjCgd6huqBwdhLzMYvSzxF55pAW8IiJDZM5/ZsCdTqfxqTVh51WeHwzU+QQSVZ1Za8/a4V68EtYHtts9oDkIQ5i3X5RYXQcjUJFGO+s4jYwmUuJclVnyCrc3R+P5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536836; c=relaxed/simple;
	bh=NCd+Rk0yON50PatoW3j+aYa0Qo8Di3yglY7VIjKW1d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j7TiC5VylH8Ig4bDjcBkGD6N+X/VXxNqNZJa1KPcULbFRogJc197CNYSKhAdgA/P2l0QvArt5nOXlBa4EzrdaZZ/gLa7SwR+nOYWvpxyenPl85FXlyD5FXYBdDnNpH5tA9SHHJOjsg7gtHw/G9oSk9yqQVqtqcaOSi+qPdVuWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENqc5qgB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so4825733a91.1;
        Tue, 06 May 2025 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536834; x=1747141634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1u/gSHkUGxurEllHGf8Eqr+47fxtPXp1Q0ArordZZzE=;
        b=ENqc5qgB+n6AqeJS737omwKLnulmh+MY6I7S9v8DonSvmLHVHR2af+kAaw5IZtXkQ4
         a7PjhTZfZbnYpWFRsqENd1kLmyEBruuH5RuwuvSD6+bx0SYmdJymj1YeCk+pa7tvLYJU
         oQIm0Ev1UOrGdBxS6Sowq73/0ssXwNcP5SBMVdTb3S0QK03f5nZrkkpNdE1c49U4pJTM
         twxGc/MUVIeL0tY6K4jZZ7gWFb8DL3XJI2ZE4Mv4xjcRNyveBPFh7R1GCBr1gTZXU+7b
         NYmQZQx/K5ESoGVIIlt70252oiJfWetqlSPWWcnVxznDwzFN4WIh1UgyB7IKlv3q4npc
         yB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536834; x=1747141634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1u/gSHkUGxurEllHGf8Eqr+47fxtPXp1Q0ArordZZzE=;
        b=gx/b3NF5e88eJdVUGAdH4sHKUC38nLpTZZkRx4gxdJktBYW8SxDsf5ybJSgxMTx+Cy
         NxKAVu3uGLWNid8TRa3xMUanjQDScrA4GJW7JQw1LBLno0z4wW5A0fpJN4x/vMu2WC38
         c+AR0iWXplMBWKNPYoAEiwYwPs1mFfNtCUAOmbEPP4F0VwWbm1LogFEPvz4PydSIm6v1
         SrnGPWHNGc3YrqDR+LmLwzIAEez+iQkwAck1loc6Uwyo5RDmW+LWWqHRD7b22Z4mL2nQ
         pw8FxuLR0ojP8S3MkayOUxHHQGhMLXBcN5un868GL8pncLu5IrkG3BpZFe/1QBl748W2
         nEfw==
X-Forwarded-Encrypted: i=1; AJvYcCUezqF+dbz9IGIEsfqrEX+Cra3NokIsOi5zFbQolwIUTMHzfPmk4KqdAm5rh6Wppa4Dp0J/ERmJ9+G97K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmv6Aacl5z8GPPjPHuV/bDSJ7nWAPo2ORtSjfKTaoP2uuTrb7
	ci+J45B4FvIdoP1XBrdk0y0V3N4tlevGq9TZq+H5iCFOaVqlP2cj
X-Gm-Gg: ASbGncvSxV42z/VBNYU7bPXCc4k3rGfQIwdtKU6mfm34ZlVsjn3+++dY7ghwjDY0PqZ
	sPN0V6mR2tzsr1r/eMECI7y3AXrTyue37oY/qtOb1yMsFwdpeiFa3NBo4R7DsQTWrI/jcIKSk4R
	4l+MvFdXzJ2wwg8wuRhb+ArZsi5vAvXatD77YDm4E8AmIKI07eKfaQaNH3jo6yiM1U9WE2zaFMm
	eXmiTsIOd1nM1YNodQSvnVIcx6dTEOr8t4f6lwNTcxF1T+8JyBYOGro0+vo2I8RcODLE46BLLNo
	zSn3sjrUQy7WaIki5xaAORmywUzhEVGHLd9JVWt7qIgCOkldrpxeDVwIpGZC+JSSBxMUE6aBkI6
	iuwjrcw==
X-Google-Smtp-Source: AGHT+IHEqVfFifBebpMW30BgR0iUSPAb3OzZDObVxdbKOEg2EcflomXArPA4PI9g/Pj+GdEEFHYs0g==
X-Received: by 2002:a17:90b:586e:b0:2fa:15ab:4dff with SMTP id 98e67ed59e1d1-30a61a43f5dmr14754917a91.31.1746536834422;
        Tue, 06 May 2025 06:07:14 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:14 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com,
	yuehaibing@huawei.com,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jacob.jun.pan@linux.intel.com,
	tiala@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Tue,  6 May 2025 09:07:05 -0400
Message-Id: <20250506130712.156583-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Secure AVIC is a new hardware feature in the AMD64
architecture to allow SEV-SNP guests to prevent the
hypervisor from generating unexpected interrupts to
a vCPU or otherwise violate architectural assumptions
around APIC behavior.

Each vCPU has a guest-allocated APIC backing page of
size 4K, which maintains APIC state for that vCPU.
APIC backing page's ALLOWED_IRR field indicates the
interrupt vectors which the guest allows the hypervisor
to send.

This patchset is to enable the feature for Hyper-V
platform. Patch "Expose x2apic_savic_update_vector()"
is to expose new fucntion and device driver and arch
code may update AVIC backing page ALLOWED_IRR field to
allow Hyper-V inject associated vector.

This patchset is based on the AMD patchset "AMD: Add
Secure AVIC Guest Support"
https://lkml.org/lkml/2025/4/17/585

Tianyu Lan (6):
  x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
  x86/x2apic-savic: Expose x2apic_savic_update_vector()
  drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
  x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
  x86/x2apic-savic: Not set APIC backing page if Secure AVIC is not
    enabled.

 arch/x86/hyperv/hv_apic.c           |  3 +++
 arch/x86/hyperv/hv_init.c           | 12 ++++++++++++
 arch/x86/include/asm/apic.h         |  9 +++++++++
 arch/x86/kernel/apic/x2apic_savic.c | 13 ++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c      |  3 +++
 drivers/hv/hv.c                     |  2 ++
 6 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.25.1


