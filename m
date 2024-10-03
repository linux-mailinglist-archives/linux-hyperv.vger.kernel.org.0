Return-Path: <linux-hyperv+bounces-3100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345898E8F5
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 05:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4FB1F2225B
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28960433C1;
	Thu,  3 Oct 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/7j2iFR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABE27735;
	Thu,  3 Oct 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927655; cv=none; b=p/+uHeTP11qdXCjf9H0HrXr6pb0vvmzO3RbBgzG9wb4s6UrK90rLmC4huDhJ4c8umStXZ/H6k/tqxGFiJQpa6okRGfWtCwXHgGWOU0251axkGm0MvDnr8gfi2n3KPviDcUtvUzWazmMEQkCzoxZZl2FpCkZvV5ttBpFz0mN3RY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927655; c=relaxed/simple;
	bh=Ls1umv3AoV9OAW7lcwxqmR9VNmxVlUZafJfEKvveDpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=de+F3V1dKtp4j2+y64Bn0/r2fTa8K+PuNREgDyim2hE9TKlxQnzsWOthKKVcYuhzFAauJ1UPwxkg3VBjmyfTPO1TcgkEQk+2qk9NmzShXxynKpadYHjvZebvrCV8KueMdFVnXkVEk8rgMkBupb3sWQqi+2euQ9zkDg24qhoGdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/7j2iFR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20bc2970df5so3155115ad.3;
        Wed, 02 Oct 2024 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927653; x=1728532453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rl3DJj69ip2vtdwvZRZRwJS0N9IcEuELubliNXpPJz0=;
        b=l/7j2iFR0GgCWKDiZ6tv4ZFk0SvKITW1j9dRrXHsZeq7UKyUeNSKIQ7QKTOEC/odQH
         K/x87QqiNLZjWfNyabc+E9NxIKWKEFquK42lkewhwPjQTaOVfko30TEYcp046iHyZ+jb
         yd9YOPjpMPVyYrR5tsv4OKGmgn2c0eAEda1HFMtsupcgtbODB33YaYzlJzey4+wZJh4p
         UnrgsjJRHmEl+DOocL/LhIZrMZoIIKO3AeMC/KKmOO76dnaFLYsfPrVsuOQgFVc35Etq
         ZI3TCP5MYAKTy4AziwKQiSmW0PYZMwuL3vojfv0yMiU6NJOpN3Yy4Ey+q04z28xU1bwZ
         7G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927653; x=1728532453;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rl3DJj69ip2vtdwvZRZRwJS0N9IcEuELubliNXpPJz0=;
        b=aJnurEq3ES6zmuXRa3kgVxtA4Arwm35wRdkUuclr5Q7UwF5Lh6c3zwSJlBJcV/Ylo5
         hvupTtp4OwUg/LY2EJhO7xY9TNmFFOQ4IIxFM97dAlvIiQvNkOOTLB0iu+1BJbLfe/HX
         rl92kJsw7I7YhPlzJGkkFRXAWVv5UubSPI5S68CndJsP9vEWFyx7PaOB9BVji1sd6k+d
         YKdt4JRF+n5SSZReS58sIFv8f2zV5yvQNCzUKp9AW4tnZYHh+WCfhsmcIBzVldFFDITE
         2e08PcdH8Nrk0k8f/uXUu6hGX/WmRYTFHr2ksBgtP414AC4PSfpBCE4v1yjr1V2JKxrc
         9wQw==
X-Forwarded-Encrypted: i=1; AJvYcCV+yTtDhDnlMf2H4fwYfg4xclPfryPCwOWGLnc09+9y3yD+OAvf53468q0M/2w55+0teTH/8V1Y3MVTdg==@vger.kernel.org, AJvYcCVXnOVgsHeUpTcp3MJ1SOg0QiM+492wN+iZpzUbwVLqM9R3Tt5dKpyJHom/bKL/4StY/iIReSzt1zAnDjmW@vger.kernel.org, AJvYcCXH55SsJaZQAZ3flEieV4qeVxUyWsNPT2lPOWyhFVHLD1FR8McUbT4VIVSyZ8fLy+4D50+Ln6/a@vger.kernel.org, AJvYcCXgJA84ecKga8Mi1mp5O/sYrjfVefKyaS3LdqWNI0qrYvC31g/vdWKVLVC8vTnTEP5lfWnYCiU+a+pxqfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6zBCVaWqjdrrLmALATWcy75r8uuGKaXKJXJLAwl4LSM8Rh9F
	mgOrUkhIO5SNmdKElrBtdt1GNz4esXUw1QmHW4atRnRdoB2/hIEw
X-Google-Smtp-Source: AGHT+IHU9fSIrpIZr2B/Cle3Jn+UyUSHLNjXtriJssD67baJWW1ZC7PtSkc/R6T/Z0ZRvy1RrGfrSw==
X-Received: by 2002:a17:903:944:b0:207:6e8:1d84 with SMTP id d9443c01a7336-20bc5a4e9d2mr68426335ad.42.1727927652878;
        Wed, 02 Oct 2024 20:54:12 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:12 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
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
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 1/5] x86/hyperv: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:29 -0700
Message-Id: <20241003035333.49261-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code allocates the hv_vp_assist_page array with size
num_possible_cpus(). This code assumes cpu_possible_mask is dense,
which is not true in the general case per [1]. If cpu_possible_mask
is sparse, the array might be indexed by a value beyond the size of
the array.

However, the configurations that Hyper-V provides to guest VMs on x86
hardware, in combination with how x86 code assigns Linux CPU numbers,
*does* always produce a dense cpu_possible_mask. So the dense assumption
is not currently causing failures. But for robustness against future
changes in how cpu_possible_mask is populated, update the code to no
longer assume dense.

The correct approach is to allocate the array with size "nr_cpu_ids".
While this leaves unused array entries corresponding to holes in
cpu_possible_mask, the holes are assumed to be minimal and hence the
amount of memory wasted by unused entries is minimal.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 95eada2994e1..2cec4dfec165 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -473,7 +473,7 @@ void __init hyperv_init(void)
 	if (hv_isolation_type_tdx())
 		hv_vp_assist_page = NULL;
 	else
-		hv_vp_assist_page = kcalloc(num_possible_cpus(),
+		hv_vp_assist_page = kcalloc(nr_cpu_ids,
 					    sizeof(*hv_vp_assist_page),
 					    GFP_KERNEL);
 	if (!hv_vp_assist_page) {
-- 
2.25.1


