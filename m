Return-Path: <linux-hyperv+bounces-5386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D8AAC53F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706227B18E2
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EBE281362;
	Tue,  6 May 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvv3F026"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB9280A4F;
	Tue,  6 May 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536842; cv=none; b=eluKcYx94xTgEumBsz2/Db+kA7Dy+BhYkWDr1F3XcS+dCVeQGK1AqBcXq+b5uJlU/EfLJ3wRhG5GOkmsfV8XXrBBFys1PkEklmqXrrt0zHTLei6Sm4eqK/jG7Tt7Xz2yLK8K3Bm7OylfSJcsDoxnTKqPxWEq/t9PhvpfEXmYDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536842; c=relaxed/simple;
	bh=43zFPN2YH34gSpQ47hlCG9do+SmRZva27HgZB8F7cbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtCLTkdtVDlkm1md8eQvQcfVSM7wQ/8mYiWL2kjQ49GyyEA9dLkNeXPq1lm3mL60S6QwY68Dy58isAP6A363y31IChAAu9po5iLAuAyNteYjGtlDDJp2JLZvNnyT1skNROnyliWuF9+4yGV+CHokve8A1esmSTcggq1PnsOUC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvv3F026; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e4db05fe8so3326635ad.0;
        Tue, 06 May 2025 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536840; x=1747141640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeJFv9JXOt7lctHtAYTSNLDvkMIl535mzc33ZiJ8Rac=;
        b=bvv3F026E6YTseTuqR8ZPIqkRGb3PxdFnGLb5Z/U2YUkFbGIBBTsryPnfM3zjdiu06
         Y637K2q0BYzDoCWnPkmTKfulwh3owBH2F8v5eUvaw2pOdlPAZFEY5BOAvEFdIAZo+Ke3
         /8IiZNRs81rRH8kVzNjOTj1PfK3jsTlUvfIPwh03yEFKeisPNsTIWO4xO/12tlXOltch
         ML/uo+u7JIcR3R42U7CJSrEXFn2cFjU2ung6Xtu437DEVpypvXxHA3+VrjcwCCDdB+of
         0ujPyJxildXUZVAXg4Vmnx/rAPesjvzKr78Oe8eAUmf1Sk+9v9xqTfVS48/bnzDuNKwB
         0rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536840; x=1747141640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeJFv9JXOt7lctHtAYTSNLDvkMIl535mzc33ZiJ8Rac=;
        b=F7aetce/12Y+BEpCUT//zDbCZ32/0HuWY10B0XmDvkE2EiDIBexv2YbwU0Oj1iGBaf
         YH0nlmS4aMgXifDplxC7F8UWYfD+qYbEiy8Pg5dGdYquylBgew4XJcRFnEx/Y1xmZZTs
         mJSxE9HEx6yR8Z7Ty9qIDQMGegdiCCXbowr4nnICtkwyoHgiuQ8DBtGLOQQF6VNZej2A
         XisBJkKYM/FmsAstWJL9Y3m9zaeUbci1V2ta6AwPxyypmIxcPA06/lc/5cflt/sdlzYj
         Ueem+nwzWm2k//x+OeHlr42kPPPRD8iPMMT2ZMUDNV+pI3tRFZHYuMwlrhJsou7NWJM8
         TDsA==
X-Forwarded-Encrypted: i=1; AJvYcCXqYdTtT7hfGWhY1jnwlqrDfK6AhMvvYPmAkifYBAXac24KmrkHuEzsU7GPZLpz4GqgnPzpZJ3e16NBwc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVW1pysFdykHobgGgrM4R4Fd9QScINabk/q91wDE8i2pHYJ7AE
	L5dlRxc4gqIlOBRH+gX4dxhCQUCtMxnl2DQn6vH3O8h1JymmBCVJ
X-Gm-Gg: ASbGncuET9A0Ek84/ZUeLN5NH2t4geCYs3Mg/5vdJX4dFsbSURp6Ox3v5O2almIQvuz
	FDdLRxiniNo4+GqsAb3cE2pwrRQmG2429jwGe2ddyqtFxYjg3azwOpg0PhHVwSIxQaQBageEn+c
	d8CTiCkxokInsO1YjQbOQrzeiEd7X+jfqJlGKnpK7VVK4BC0PZ0Xmjb49PPjEf4EjhwtOfW/bKh
	twcz3UpMGN6mJ12KTvBmjqmSDR99bSc5hgtlQyBnR2OmUbh/u9Yd2y1Da7GpvoNEF7LU3Bi2tkb
	Ym+zYGwrCAVmr2SBkSBx7MIcBJq3/7pnrJKOQ9jXLsr1qqDa1GR98dfQf1AK4GgleFxVJjZJqWr
	az9sBdg==
X-Google-Smtp-Source: AGHT+IHUy407AXP/D1ROO/LmdxtWq+o+s0QUTPE5kQwX8VwZkbgB5x8WGekrc1Twdd8caKcUaR8xug==
X-Received: by 2002:a17:902:f551:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-22e1eab7501mr168935695ad.31.1746536840311;
        Tue, 06 May 2025 06:07:20 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:19 -0700 (PDT)
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
	yuehaibing@huawei.com,
	kvijayab@amd.com,
	jacob.jun.pan@linux.intel.com,
	jpoimboe@kernel.org,
	tiala@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/6] x86/x2apic-savic: Not set APIC backing page if Secure AVIC is not enabled.
Date: Tue,  6 May 2025 09:07:11 -0400
Message-Id: <20250506130712.156583-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506130712.156583-1-ltykernel@gmail.com>
References: <20250506130712.156583-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is not enabled, init_apic_page()
should return directly.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/apic/x2apic_savic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index 0dd7e39931b0..fb09c0f9e276 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -333,6 +333,9 @@ static void init_apic_page(void)
 {
 	u32 apic_id;
 
+	if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return;
+
 	/*
 	 * Before Secure AVIC is enabled, APIC msr reads are intercepted.
 	 * APIC_ID msr read returns the value from the Hypervisor.
-- 
2.25.1


