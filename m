Return-Path: <linux-hyperv+bounces-5385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C7AAC53B
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD9F170215
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EC5280CF1;
	Tue,  6 May 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWinR1X6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55563280333;
	Tue,  6 May 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536841; cv=none; b=smUtW2YtuWgslJN2zYqzLX+wwxr3UCnQ+Sku61OBhca2p9mDm1xYV2a1yWcxIby+Osu2Byhex3VftOUGAyYte1PtrJl7auECwuoMtVWZqx+tgEuEWAW4fhRX4WNzR/pDWp0efRXdsVQrTX2U+G1/Vj8VNzr5zQM7iYBhGINmG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536841; c=relaxed/simple;
	bh=NkScaICs7o20/6naaUqiycD2MfVrELfEiIr40gkcANg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fy8uMvm0EFAB5sdXXgjr1FbXn3T4tBR8av5xVI0yvTm6zY1Lc4DAjgZWLnklegjPmSL/aEhSf89oIT0du3aDHEhX93uNL+msF6ZBq7Yp/NFgU1Iser6RZgRmkgK+Q4MtuhgrfLKyzCngX+mn7NgVPqK4jyqSO1Qhcq4K59COb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWinR1X6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af50f56b862so3841943a12.1;
        Tue, 06 May 2025 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536839; x=1747141639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnNcXDG2eUvQs5/YETNjdxrW+iw5ovzhYfKEu2gYvX4=;
        b=LWinR1X6jfwP+IqP0ddI5hxD3XEuPVQiTZfNI5fH+YRm/JFrr3FLz8lFbtk8bEc/hf
         iWHaGtZCQXGBQrViRkQgjPHigbJHZ3KEVYCy4CVjAynzuEDPTvA9cVk22SiVw0kAnJx5
         JRsd2ToaOThSdlQeMxSOin80da8+M4DnGNTW4Sk8OCfn2z35x/m/l38gg/KTpJTCq+Oz
         KLsBtZAME2rIFm4E3rlBzvVKZ5B7Rq3OxnGr2y6CiDFsJA/RG5OMWPXa6YBg4lS9wXx4
         j5qoPvNi5kWdRHiDy/h7RmPaVTb/Ezno1a2WK6O1JMpxoal2qTS90DSBhw+Ugyiq90jq
         sTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536839; x=1747141639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnNcXDG2eUvQs5/YETNjdxrW+iw5ovzhYfKEu2gYvX4=;
        b=O/RaeeCsOr59wdLUTJXjODVMFB9bH33vMMh20iiPPhUa2OxgKbGRjgXGMrRGSNeaH3
         FarSaqzxSTI94JS+mvMNTWMEivNKslL7tr8TV9hgsZVNstUklC04Ql/ASlNhXzJa2NJe
         GfGx7t//e9Rjkpt1/+Mnbr+dyNvFx+iLEmn8DRD6rx0bMVVZI3RFXNCFdfB6YK1qTO5G
         0E0XFMCgramyH0eRY7lHmFAEBDzVkHn0D2wrkhfnHq0+u8O9O/Azyv3nCfva1ZAyofYs
         xaEIIJJuhZiGlnUjjUv7kF2ksFFff6aPCx7cE4T1z1lAtnCHtnyLQF6NJbFS37ww4Svq
         gC5A==
X-Forwarded-Encrypted: i=1; AJvYcCWCLmlr2YQsSumQCCOm0hVrkZGOw2wiJc0m3p+iKtyt+Qx7JR3ARNolM1AsMVEIOLExQXL8hkTRQhhpTIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVbhgRHYQfBtgjuqPa8unGnxMiVYccgy0BO0MkTBgFI7hwltO
	TnYZLlNq+yfzKG6KGjZoetjGMh0wxfi9ziUlru9pcTTY8aKkvcNw
X-Gm-Gg: ASbGncu2Yl4aReqNoY1/RgOKF18uO6Hh6pfp89CvWx32uvqgcYPrJtn1MCMGBkiDHgq
	ZUidkZdMvjd1HYfU0Z+0AR5x1jvaZC8evznVbA9y7jtqTBU+cAtSsoT63SqcmCTZFBYh47hrdcP
	poOl6l1qslMduPKZzbM5zB06Qzl94agj+uBje1aBXGeZOAWepfOhkSoUP9KnJI2nhoQW/KSIUlK
	OzqtfqFPmQRep50Nt9twQ0x7FAFXrsHelPLfrHzTS5gb+PfL4IE7RWow/yCTqpZen4u23f1VJHi
	sypp3YzT2nXxH0qL+bPmn/9sT5kV7izN/rnmD/tG3Go9aiNRctsE9Lq2CXRXMAHhMgaj3RWDQI6
	0NB1/SQ==
X-Google-Smtp-Source: AGHT+IHpnxywhA4mHFlVLZT1FOg8n/bu7KnlCs1mLC75TH0bETRtrHEAux42CWRtlkY1ESqKRPZVyQ==
X-Received: by 2002:a17:902:ce8f:b0:22e:50e1:746 with SMTP id d9443c01a7336-22e50e108d4mr11355955ad.36.1746536839230;
        Tue, 06 May 2025 06:07:19 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:18 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
Date: Tue,  6 May 2025 09:07:10 -0400
Message-Id: <20250506130712.156583-6-ltykernel@gmail.com>
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

Hyper-V doesn't support auto-eoi with Secure AVIC.
So Enable HV_DEPRECATING_AEOI_RECOMMENDED flag
to force to write eoi register after handling
interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3e2533954675..fbe45b5e9790 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -463,6 +463,9 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_identify_partition_type();
 
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
+
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
 		pr_info("Hyper-V: running on a nested hypervisor\n");
-- 
2.25.1


