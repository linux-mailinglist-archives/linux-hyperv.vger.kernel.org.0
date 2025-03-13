Return-Path: <linux-hyperv+bounces-4465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045FBA5EE80
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 09:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF4A19C0482
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C62263886;
	Thu, 13 Mar 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLYX9ZYa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB7262D11;
	Thu, 13 Mar 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855950; cv=none; b=LdniIcDzI2qJmS6oSRfSkdamlOyHDcbwFHLxrWPu1mY/AjYAZM+/PGWK+C4ZRRegDkJmnummyc7FNU0u4Y7/z4JgMdedNdz1+cv8qvt6/30ZjnofNCb6ecS4H5kttGU5Vbq1338hTJS/lRBQxjcVR26FYkz/PpRvn/ChCcnS1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855950; c=relaxed/simple;
	bh=bsWJBHENirJ6KNcHjp7ijhAQhuddBcS916UmjLeAtLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDPabSD6CsY8XmbGDRoBzZyNHMw6C/9FFnQ483460UAMuqnGMR9wRHRGguglc8be+kXMOZYpQWEmPQdn1HGZWtt1Hft/cMm5KUwysWAgmdFVHCafJxSuatmwM6AmxSBmhshYymsEzYVSglglp0LvsyphvsiDlJa3xnbTLVKDUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLYX9ZYa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so15721575ad.3;
        Thu, 13 Mar 2025 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741855948; x=1742460748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdZMMUWMDqS7xE5EceDiiL8qINCxcfmqx8XegAbr6Rw=;
        b=QLYX9ZYaQTgKxSXQesumWHn3KWBmBQq3eizO6/CPT68TB3M3tU7/pCaOajhwM7t5nF
         5pfhsSE3tnkjS2jVXjqmByLWj/7YShZ9X/Zpq4/fxf6RsDCA0d5UOjEWrmEb+FxPmAkL
         uRvAzdTq1QlL0lH35EboMTC1/81ajUy8IEmWSbpt5kiciyYTgStZn9aOeHbux1l6yOep
         cAJ6/aw9MH82dm4kuvF4SHycxRN9O6FNzE9DG7RmQ+Yg2EmhYeAOMnXBRaCYPWSbaVme
         4OfXW7W6wbGkKkcLp1a2TJcMQENxLfQNaB6clGRFFMzudvLHk8y6uVlebCGNyW2EncKL
         CGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855948; x=1742460748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdZMMUWMDqS7xE5EceDiiL8qINCxcfmqx8XegAbr6Rw=;
        b=uIHjLuVl8XMH6dbGcfQTUGN3YJKCJKg32oheDGZmOf6MufscfVdqYKoHctZe27/VfP
         8RBm9vBwlTEzVaVgzWmcxdzNDxOq6E3eRc08VNUfazUbJ61zGK10MKp4zeWJJ362soNt
         84/g96q9V+PPgl7ofuJ9hF1tabRUAdUNcfIaRbV8ZKWMQxvO6fB4RVoK7UICtj+Pjryj
         PxGvHAu8JcXgalurx3IPxeH7aGPJuqSAK6ZOwMMFsx3fdjo/Ipb5HP0i9fvj7fM1VYHl
         MDA8HhtzY0xmMPqcqs0FTK0chjdCk3BUq1gUjAJDlfg/VOmTiggtuFX1Q8NQ//q0Hauw
         TfgA==
X-Forwarded-Encrypted: i=1; AJvYcCUiaXt0vph3r54ZosYedJLcPagEA92YLHMf0F6riCrYdcE3h8elucHzdYaibVVehSjRXMaYMJZeln37YM8J@vger.kernel.org, AJvYcCWAcrSRT4rmS9S7WPv2yX06PJp4Da8UVGsy+ai13MdYrX+mM5GfP0V3Ba1mfIKX/TRNh09PVuDL@vger.kernel.org, AJvYcCWa2C1zWy95aI7Xh9YDqoamHJV5Rbl4Bl4UPILvBeL4rptZYgpTHaaO32l6aLYMze255KQ7Eo86gWMIqPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWA4H9eVXXCcTuSnuMVbZE3G8DB+8vtx1KWr4laNyJVZnsNrr2
	lxS+6QD439GlMIJ5dd3cALScWqhU7hVB2Ib9gB0SC3AHyyvNevjk9LxlVg==
X-Gm-Gg: ASbGnctGaFiHOatlJa0x83KR3/p2M0jpHp5AXYMi68VmcYqG0FfrJk2wh5kdu0862hp
	cMXQqFvjqIeJXULUQU+Tmg/lUvrpMmLlH0il3Av0gppzZ2tedYeNI6hxLzHfWx1zZoo62icfSKh
	u1jetN+etvt9H6a2Mmck1m1e7b3NbTFyiVP4LUXBO4ANCPCvqb+gw8/ejaUEBCSNAAHbpJNmEJK
	GKUp4dgINyFJ2PVCr7NbJexiZ7PZwG6Rm9JiYxGoJUeoH6U7U8PsTrdcSTpGCv7tJJ6zJQiWXHe
	UQcYSl2A3DVnggpfvt7YHks9hhANwU6XhZQUGFyBPJ/vwmIWC0TS2igqf9O3UFx6HycoK+3C/ZI
	8QpuSwDgT
X-Google-Smtp-Source: AGHT+IECYqlBbszLR2uQD3fg5Wv8tKjptePMqo8A+cMcx/3XxsKLDtVdhXKWVaCJTOwcFG09ArJudg==
X-Received: by 2002:a05:6a21:497:b0:1f5:9024:3254 with SMTP id adf61e73a8af0-1f590246bcfmr14767135637.6.1741855947559;
        Thu, 13 Mar 2025 01:52:27 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:211c:30ca:9a22:6176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9fe51asm799597a12.36.2025.03.13.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:52:27 -0700 (PDT)
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
	hpa@zytor.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/Hyperv: Fix check of return value from snp_set_vmsa()
Date: Thu, 13 Mar 2025 04:52:17 -0400
Message-Id: <20250313085217.45483-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

snp_set_vmsa() returns 0 as success result and so fix it.

Cc: stable@vger.kernel.org
Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ec7880271cf9..77bf05f06b9e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -338,7 +338,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	vmsa->sev_features = sev_status >> 2;
 
 	ret = snp_set_vmsa(vmsa, true);
-	if (!ret) {
+	if (ret) {
 		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
 		free_page((u64)vmsa);
 		return ret;
-- 
2.25.1


