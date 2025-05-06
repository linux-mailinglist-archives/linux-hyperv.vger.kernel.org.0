Return-Path: <linux-hyperv+bounces-5381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592BFAAC533
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CE37B082F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E2280003;
	Tue,  6 May 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9AoW0XT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0073C0C;
	Tue,  6 May 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536838; cv=none; b=sguTxVXUlvlDWn0SdG0aIa/pf57/4w76OEpeP/3wfRKNyStx3iTQAHgzlah76ZElZXo4wmyRBYrmGDTfU4NbANkMYnCHHUXa9bqje0RLb9MD0n3eOGX+xH5hkkI2gcSixyZqjZgSrKBkbA1uGcsEyLEtuIOordf6YsZ/bMDGPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536838; c=relaxed/simple;
	bh=UJeJVSFNh4lcXzfgRFpncgdT8abklDj1kdOnjgwLHKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgYx4CYB1fAMKs3o10oCN6UFtif6lpxdkUWkKw2Hoq4+KUKsBNq4Rkg/4PWkowHKIOIujuRIVyOgcBG8+aCVmNhBtBYoyJkROLAkIYT7i0tGhlkCABt0dgdvUCDJythAbm7fYEupLk3ghMIGGy2Y3dJW/1/2cxr6SxdmavDz0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9AoW0XT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22928d629faso51231295ad.3;
        Tue, 06 May 2025 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536836; x=1747141636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KYFDtzNZM9kP7gcji5TtXO6orx1giXgP2JzZWeW0dA=;
        b=i9AoW0XTvfpkqmHa4FuV60HBQK+ZBAcwtXXK0s/2hGJ1U8UVSktMi12LH5+YL+Df3M
         6eZPZqCLo03iR/m16JTTfh9SP4lQuRfD1yBPJ8bzoXc4jRfnuAKgGWWO08C3x5deArCg
         TPtV+QKGzUEICKk/qywVGNQpqr53X/oIlS1E7b7zhqxg1eLTsfGWjQ5NjrK+f41mLgRW
         +ndmhMNhuLd2VVRjr17H4a1OKFlz2F7i8MZYwXBoTIxqtKGR9mmJFcKNh9b2+UyM9dnV
         jUjyg2VjeuWKmnn3OI0/pWwgeR10f9KITyFW3vLLi9PlnvIA6OkoFvJJ/DurUTEMVxW+
         HkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536836; x=1747141636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KYFDtzNZM9kP7gcji5TtXO6orx1giXgP2JzZWeW0dA=;
        b=P9AQUf0dYgToB3l4JCEIUufr5XHZFXAunFEeIsnCy2XwDwduZrJPymyTwu7fNjbCHD
         aOQ3zewIvovEvZ7K6NuGaH6UIczzSERTBtumb+sxunCvD1fbHTuoMClugkSKKZcBrOdt
         YG4OAJ+p+7D4ykfmL7ZDfg3RF7/ZEzCPyp9GPCkuh0Vxx+AUnjBu+uhTJEBKFgaYhtS5
         mAyrwJWPk+HgowxHGCzVD8h7/f6R6W2lM2DogUpk+kVc7lfb37T8X0tkBkGFjnkrpXpR
         DZHQyTOseXqZMGQwpRQdnqJ34u2Zq/9FXMLdJrsGNvw/t3jV0rAmiZcLTyrJ3gxQq2z4
         SHmw==
X-Forwarded-Encrypted: i=1; AJvYcCUQPo/c9U4WIPy1EcfxhkQo5/FK8ZvGhCnot/FQVKmmxQ+1lrZRZsNF8rx8Y+L4PJc4XbhuhFfQWe7d4uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMK2MMEs1eUNS95YmkKwyI/B0XbjkezloE3ppgAUZEIVVUzMry
	jSoiSqWqS2xFPwOH+2yppv9B0y/jV4FnJOQM4bfUY8DPof2Eg+tM
X-Gm-Gg: ASbGncsEEdZdaEQYiM9UeAMP3JlCgIbXscj5U2jFshvDiYd54ivUmOvu/Tn/yXXPhCu
	RG8wxftAJUgX4+R4XEbK1RKhvd4McxU4s9H2B7mlOrVcnJGj0QZ/zVktedRoESGG5SSRZdN2Sst
	3amBOHw2utT9mLKnAjNSoYix4TrMaFyV3uDOZUsEuQUjsZYCSneDj4BDkmNGhoXEHzjC7+zoVpL
	w913Qb5BFRmY3Rvj79JW6ZSDbqSxYBqb7TX7zkvVK9NTGs994J3aDgjsC+tCUrdjGUJNcc98Mip
	RXYV2f78xRxc96mXh+L6pelX8EbtxQW9khekyRze5z0xb4XR4Hgd98tljlENuNj81GhJ8xB7/Fp
	U4HQJYA==
X-Google-Smtp-Source: AGHT+IGbTDKPyQxMkntPgpi28M3uMaYuNf0+H1WPLYL4YoxDim9WuUTyASqUupJkQFeN8oeGHakWBw==
X-Received: by 2002:a17:902:d402:b0:22e:4509:cb8a with SMTP id d9443c01a7336-22e4509e0bbmr18538735ad.21.1746536835630;
        Tue, 06 May 2025 06:07:15 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:15 -0700 (PDT)
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
Subject: [RFC PATCH 1/6] x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
Date: Tue,  6 May 2025 09:07:06 -0400
Message-Id: <20250506130712.156583-2-ltykernel@gmail.com>
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

When Secure AVIC is available, AMD x2apic Secure
AVIC driver should be selected and return directly
in the hv_apic_init().

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 6d91ac5f9836..bd8f83923305 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -292,6 +292,9 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
-- 
2.25.1


