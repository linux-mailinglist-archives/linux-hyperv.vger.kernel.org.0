Return-Path: <linux-hyperv+bounces-5384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0AAAAC539
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0464517067C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D7280A33;
	Tue,  6 May 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYtvOv3M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A80280036;
	Tue,  6 May 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536840; cv=none; b=i6rmgHV/XS1qECSqNtcXNXVneSRVo/gEHDoxWZVSpmtwi27TAzty2qFnQ4uFpY6FMNUglpeVe2jvHbPSL7KYoyl3W3RpubNpAN4+9NGXLt0h2bBrsa4FePTCHEPIr5ZH/o1uEADH+tzO7SiQH/76MYn+jaYqwZQnUEwFh7IvrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536840; c=relaxed/simple;
	bh=6ol08QsW5KtrjtLaoCDOTYhW6X9+VyStX3Uq+5shMMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klqMLMNvE/o6bjugT+NbCzrIKP3Dm9hU0cyr6GmuuBve6oLr9YanFqmheH9JAlHs6fvMyQCceQTwyfV1Yqu5sB3CamB6SRquW3tbCwtyk/xXTm92ZtqgZ75uw/0b2XoujTciMbiGEv1kVqe8VKIjAgxOqJ81/qTaJeimHz+Mu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYtvOv3M; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fcb97d209so2068395a12.1;
        Tue, 06 May 2025 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536838; x=1747141638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOoejVfer1yIcu5sSZWVe+lsfjP71eKhOQHPyl3cYx8=;
        b=aYtvOv3MMDYFKC2MtX2Q9piwnGErgug4n4YZu28hC2IWiYUxuG5C+ZcoB3ma7UJ4Rp
         mRjIuP0MonhtalH7+hQvHTcGyozj2QIkZEgcyRbA42I2N/L8IAbIhNc3GEQwWAj6aj/m
         e+pRIPQkK7B9Zpxsrm1NNbllMLzTvtE6xStiboGyagZ+Z62Lu8vNqiR8nbgf7JUfbuBl
         /hXkJ8FywJsmIhsw2wIqRmBCU4O75696VbXkFUinVZfWHbBENK8nQQkC8AwuKMCw0QJC
         eFjZSKhpz2cmQuN3Cz9EjZBpYCYcMM6y9WNV0IkfdTBi/Yus3XoBrYwpOUS7JAsGnY5b
         6jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536838; x=1747141638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOoejVfer1yIcu5sSZWVe+lsfjP71eKhOQHPyl3cYx8=;
        b=G/++dl4FPuP/+kqmIZ2dVsSM8/Pv04zbsU2LZWr3DNeZ11axXsmR0ka4fCd7S0KVqx
         ZYSDZZJKkFhhT4SzpuqxHHEQGPIjwyvg/xh6J3/RI+wckHMSeEXxpV6rrY/23Kd06esY
         1Qo31HE5cJbaTfd8UyW0QAAR2JVIWeh5Z9RVuw5CoFHu85OkX/fro/0NL2+Mq+KQcrHE
         Q//hK78xCf1sczJZNSjq4LHIZE9ZchSy/zO/AMGbGudHRJNtBe0FQEF6aoa7kB5PfZW6
         4lg/CIS1EIm9raUWoHVsIgfJiWLrKOu1JIWMM9ViBU/+Ms0DfTNLpWi0TSz5E3bWha6Z
         vJKA==
X-Forwarded-Encrypted: i=1; AJvYcCXBMjGYQn5v/f5kyICdiRakifjOeFYf6wSQ80sjve2YHlPao96q9GNrk0TNAh2BqrhX8+RYq32+CfqRsJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMQ5rCcg7Z41JQm9tKKiEiIvb136bIbjvYLM9ILTWsxD4xohW
	7L4I0+ezsFAeOwGRLRlbhkB8VY8QH5sgHVnYvS23/w7h8WnRtC6wXouEuw==
X-Gm-Gg: ASbGnctzjXQQZ6XPuQUn6Qc7i7RJoQCO93BkHDHh1i+8ehIvN56nJHuNrX8EoF7NQdD
	XspTaVqddga8sOokXwb7YNGTJ4Dtf/XCu/O6jFizMEzyUoxEfkywUbuZBjQKebGUpohE8pgj0+Z
	SQWqQhnMMvT8izLKiKQIxFUtbF5tcCozZOSRIewqrio8UQAQfzinsJPssKBxLDD4QX47fr2ofLB
	Oq8NbQvKhBXgVgSY7VIkpCeLW6x9dmiDxwTQjoHZAPPSK8HvbqYHvi5Lht4ca86wrOEveGcNWcv
	f+2xLzZc8aKUdCIsW1JbFPQdSa12uWoHiX1jgB+Gupv4/KbfOY+1YNp+VVOwIYSZS2Xo9EqHLZv
	2dgF9+sj15v1Kqd7C
X-Google-Smtp-Source: AGHT+IGhIbOKui0wAWHcu/0qXDi6gq9875VkaQSHSgEa5LULBeVBHeYlmLz71zRMMA8ykoihSwCKNg==
X-Received: by 2002:a17:902:f60d:b0:225:abd2:5e5a with SMTP id d9443c01a7336-22e32776c1fmr41344535ad.4.1746536838367;
        Tue, 06 May 2025 06:07:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:17 -0700 (PDT)
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
Subject: [RFC PATCH 4/6] x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
Date: Tue,  6 May 2025 09:07:09 -0400
Message-Id: <20250506130712.156583-5-ltykernel@gmail.com>
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

When Secure AVIC is enabled, call Secure AVIC
function to allow Hyper-V to inject REENLIGHTENMENT,
STIMER0 and CALLBACK vectors.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ddeb40930bc8..d75df5c3965d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -131,6 +131,18 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
+	/* Allow Hyper-V vector to be injected from Hypervisor. */
+	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT)
+		x2apic_savic_update_vector(cpu,
+					   HYPERV_REENLIGHTENMENT_VECTOR, true);
+
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		x2apic_savic_update_vector(cpu,
+					   HYPERV_STIMER0_VECTOR, true);
+
+	x2apic_savic_update_vector(cpu, HYPERVISOR_CALLBACK_VECTOR, true);
+
+
 	return hyperv_init_ghcb();
 }
 
-- 
2.25.1


