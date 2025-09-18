Return-Path: <linux-hyperv+bounces-6938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D20B856C2
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43181C83841
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3E22E004;
	Thu, 18 Sep 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnbL51My"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADF1A76BB
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Sep 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207667; cv=none; b=SiU5u7lPzBqMiM5IRkR8WJ+Ml6H4ypPyvrm+MYwoMo6/NEdXc38el6GtIjHKOLgLTd+DH2TRZmCHYo/z3JRmaWRB/FTMkMTTkg/HC7g6bUq6mT4JjyT6YW/w9/JXtFemxekIsJw2RqP/OGg38tzytonMCtBNysSkK9Eg+GCFnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207667; c=relaxed/simple;
	bh=AHhSMOoeWjfl0vFPCrm0Cux2fhk1nlNWkzKPRjm+gHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rKqVrS/LZwzGhJkeTkHxo9V+FxEo40T6iXj/c8tHHnqW5NhS8zC1yMFA1mqzSK25YuQsXbmQtcywzoDhk0sgWAC7ypdgVCq+UqqOv5oolRz7B3gjd7rIsh1R8QyhMbDsvpIk8Od7FDoT5WMfeK3YrGMDQ/EqS9h82cyoEAQh9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnbL51My; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54ff31192aso758388a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207665; x=1758812465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71og1L1moGnEtlU3hPRTvSfcrOKYYypZv/voq78BbaA=;
        b=JnbL51Myep+r2FeN86BTbSqthH2ADfhbuRbB2eY0raq3hVyfIuglZPLWoE32xwOjGA
         KsSgSITKcBajErxgHC/daZJJMEf+eXA4UF/+SyWq5f44S4tIOFTz97tEfd/Ig+FjeCAv
         cnaMMfwXEIsw2+JX9mtCvLEksP82y98n5Xr+o8cMzT5pckYTWtw7SYr8bdwwF3Vfhxk1
         VZV0N45ZBGfNQumG7zfm/G6fBFaeNzDd8YVIT5qPTHAiuzDBlR/XK+k5CAIpRAZaJj/z
         0Xj2KCH3Q1Dww4odh5RAgTLmQfp0faSGqmSMNF9Kjjedu6w0HclhDuKqvrtCjxBZ0vFj
         jokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207665; x=1758812465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71og1L1moGnEtlU3hPRTvSfcrOKYYypZv/voq78BbaA=;
        b=OfUqRNFFpMkJgXY0SVf1BzCjC8hH4B3WjvSYFvnnmgIDfEL85BHo+spoBTcIaBxk5h
         /BXZJldc3u951JrwisB7SkYMrRPOPhDVLLfqg+FXxaoRrywG43bAdWoAD+91czt+EBtw
         fZdBK34Jvurw9ZDICPLPUBSzFfS7hpnescXEhq1sRXc/imistg8tNb+avj//rorONfUH
         kl33NCaq2d26fkI/7vxKyRd09H2Ha1km5rFm1EBQjJ66lE9vRI3XDzVZQ4TfOjGNSqyW
         +DzJ5oFTukKCTgru/hDFJ+Sopn2OjV67YZ5tjsUJk2QGZJQEJ+MsZAbVejzORWvSMMUK
         NR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpLKvxZWyhcwzHkfljETL5pU1NehvJT3JRmDM/ihsXwdsC34zX1O7cHvFd+B/JvOaT9NBgD9/dzOy5eWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrKcT5g5R3nvpamfNr5sVsUoz1FGpshqgd8jzTdR1GSojPBkB
	tIc1rFYqI56HgyhacVZulFXiQLfVlmaARuIB//YH0d9AIJC6nuc+rUJz6RyxJo5C
X-Gm-Gg: ASbGncseOjWUWXAyromnxzE431Xv9TrsHRIGhkd1h6K+pCursJSmaLXnrXpAIq0TnyC
	B/2xaO7gm+Cp4LXDtVn2lans+pknGT7Ji3RpO8EfvJa9QKWiM78r5W77LdIngKBTGyQwfstEui5
	8moinI83hlvYoa5l6QViq1vy6JQC7jMjXXJs8zWIUJCLDY1kW5vHAjg3KBWLy3jaGA4tDIbtELe
	qRb0YQ3WsRihnRGTpaMCaDSrGCiejHmAev8lmAUYUMvARriGArqxYZaOAHHqFZhobzJx0/MmQUx
	7UfFbyhPB9AKM+lJ9WjhHvkLeM9ZH1x5LcsyPXJ8vikDVeS0Hpnmwx+z+cVFnTSk4Hc6e2/jXN9
	1vCbxU15jlHBnRE3vU6ZY/rPFoUD7wdd52WzCkuHNYaJ3983KDjWQBSY7UhVAkkz3Pg==
X-Google-Smtp-Source: AGHT+IFF4QX2AbWB9fcEg1ekWHfAYk3ZX29fzrI+wOrqeGz5H2M50u4oTVO4eAHdSnCMCh9Ij/n/0w==
X-Received: by 2002:a17:903:2c7:b0:267:4b13:c855 with SMTP id d9443c01a7336-2681217a94fmr72904825ad.14.1758207664287;
        Thu, 18 Sep 2025 08:01:04 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:03 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
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
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 0/5] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Thu, 18 Sep 2025 11:00:18 -0400
Message-Id: <20250918150023.474021-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
platform. Patch "Drivers: hv: Allow vmbus message
synic interrupt injected from Hyper-V" is to expose
new fucntion hv_enable_coco_interrupt() and device
driver and arch code may update AVIC backing page
ALLOWED_IRR field to allow Hyper-V inject associated
vector.

The patchset is based on the tip tree commit 27a17e02418e
(x86/sev: Indicate the SEV-SNP guest supports Secure AVIC)

Tianyu Lan (5):
  x86/hyperv: Don't use hv apic driver when Secure AVIC is available
  drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/hyperv: Don't use auto-eoi when Secure AVIC is available
  x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
  x86/Hyper-V: Add Hyper-V specific hvcall to set backing page

 arch/x86/hyperv/hv_apic.c           |  8 ++++++
 arch/x86/hyperv/hv_init.c           | 31 ++++++++++++++++++++++-
 arch/x86/hyperv/ivm.c               | 38 ++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  2 ++
 arch/x86/kernel/apic/x2apic_savic.c |  9 ++++++-
 arch/x86/kernel/cpu/mshyperv.c      |  3 +++
 drivers/hv/hv.c                     |  2 ++
 drivers/hv/hv_common.c              |  5 ++++
 include/asm-generic/mshyperv.h      |  1 +
 include/hyperv/hvgdk_mini.h         | 39 +++++++++++++++++++++++++++++
 10 files changed, 136 insertions(+), 2 deletions(-)

-- 
2.25.1


