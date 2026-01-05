Return-Path: <linux-hyperv+bounces-8141-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354BCF2A24
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 10:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D61B0301B416
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357733375C;
	Mon,  5 Jan 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEQ0a+5z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D7333445
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Jan 2026 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603881; cv=none; b=AjheuUM+sHWdISnsyfgguzAwvBGqoTwOT9c6HnjPT7oNziG11psS29pEZw7dh3xiPafJ/6f6/VNbZMC4qZpv7amYmEAh6QbLqkUBr06GvuvuUk+gLWjpPNSs9Bkhuy7cMH0JMQgZ3vuY3egplVPA5XOKyZyQEWQ/yCHmEASQ6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603881; c=relaxed/simple;
	bh=cF0HqpOjPFVBzYPhHAhvX3LaVUpaHrS55tPoqFcFmRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejDG6uJw9VAP+LAouEOde876GXNd9N1wtGiRw1cyXVns4a8FPpx8OyHzPXJHWsDoaw4pabQWHNMzLyx5ShwyMhteyIGIWRELsYU9BT5gyZT8pzlp2K95TCQs1T/D8rxA827Hy2oMlNhUdDjlVtZNglQf0NvQxhz3JixmXLq0ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEQ0a+5z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso2551994866b.2
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jan 2026 01:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603877; x=1768208677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib9jpmX7sNQQB8uf2G1Nm3PDrzKBuAb2KF+Gs046Th4=;
        b=JEQ0a+5zGyzewxQ4cN/Xd16iCiC2XzLdUEQh6ZZZO7rHadnkTK2TTpFJQaipebpnd3
         NNrT/lGGcuxUeHLXP1KLMkDCGvc6CB2rVCX0PJxr3wlRPt5C4TygzDjjgWzXxMYd8cAL
         K7nNLlr6v+Hs/+Bt1cO+xYWJDWqEZ+4Sc+mIMtpZfjG8btmn0bFWinumeQlEUZVkEfeB
         T8GhSpuwtrXdQGJkr3T5NzjAfrZaVRJ+w+nbB6UKJyYxWMvuVew/fTvyQlaOnVe2JbrQ
         yhIDl8jvMrVd38I1tX7rtAOVMCI5+/BLTRF0yGc7Z2hAYhF83yYHVFd7PJI64NKhAZc6
         vvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603877; x=1768208677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ib9jpmX7sNQQB8uf2G1Nm3PDrzKBuAb2KF+Gs046Th4=;
        b=giImGx/2xXvigXAkAGeqUehZgnO0ObY0PfrnQakgPBj9E1pJeLdNUg/23cCa5c2M/K
         UTRI5AgWpgQVlQbJxrkcZBcLHgQzYNkqUg8f7KOEj5FuWmeFRxJbp9MpRUKzV8bYZ5vU
         p796uyGmDGSEUG3K53J7T1xaFondLItgGEmYu1dELFUHQnhSBAlkOBVEzAMsoUZyIFzI
         C7s+K5+VFwLrk+C4bT4O9wu33zoyZGeVtyHkR8Au6mcqlT9CDb+vKzsM80HFqo3avuDD
         IoN+E/O3jVZGybFk09Lj/LVvbvUGz3x+SwEIoWz+hKeru10G6k0vbKblfhIgwoOrUouO
         sjIg==
X-Gm-Message-State: AOJu0YxD73ldlrAyr2ps86B8tFvIG1VgMsQLgxlh7RSHt5ZlcNXj5W6z
	0GXxh6vqOdh+PoYDJAeDTsPa7Li3VNw4OH3BGhD4Ili7k+fTgBfLYp3p16091A==
X-Gm-Gg: AY/fxX5/rvp9AHDmC/DMCmPgVMLpY4PZngLQEprsiNlHJsdgOh+bCHsy/fHPTDVe8Kh
	afZNXcrHVWlSfTh2EjWtRiqRphcKUDV6YPD5rpGj41o6QJfecPSLtUG1ZcQYVfuJHqih/iI48gr
	BTQrAzKU64WTy4FL8XytbLVMIQypvxtcF2Fpv8MocW+n5qUsX9r/AUJ0WG9TnldWbE7eqxdiNsl
	4M9yJNj5ALNiseg1CgeHJiDaKzFYu62GvwS8j/WkteAWyx24784kvIgBl9olHz280Q4eWe2svKS
	VD4vLtMs/w4JV7mGws5ZX/vhSeLhQE7KPQ0ViU7JiCJGjbG/EhNUjSY5ajXVw3CicClp6crm/Re
	srPwrtOCjUKcpI1mYIzJ/zGyXiM5Lw6xVg2QnDJ6binSp0BKiE2Loug9M4xesCcyZQ3yN0dj4Z5
	NO1yQWwN/ikoNtnWeoyVt1LVichU0mZrds+AKv4OW/7XQ=
X-Google-Smtp-Source: AGHT+IFOiCERt1NZCR4+Z8iIL46M+Y6pZisWGWoycfh6mZ3Sg82rc/1tH4HUJRB0QF6kN1BwWwW6mw==
X-Received: by 2002:a17:906:6a1c:b0:b7c:e320:522c with SMTP id a640c23a62f3a-b80371d4499mr5498240366b.53.1767603876170;
        Mon, 05 Jan 2026 01:04:36 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de0de1sm5521794766b.40.2026.01.05.01.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:04:33 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND v2 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with VMMCALL insn
Date: Mon,  5 Jan 2026 10:02:34 +0100
Message-ID: <20260105090422.6243-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105090422.6243-1-ubizjak@gmail.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike CALL instruction, VMMCALL does not push to the stack, so it's
OK to allow the compiler to insert it before the frame pointer gets
set up by the containing function. ASM_CALL_CONSTRAINT is for CALLs
that must be inserted after the frame pointer is set up, so it is
over-constraining here and can be removed.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Expand commit message and include ASM_CALL_CONSTRAINT explanation
---
 arch/x86/hyperv/ivm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 7365d8f43181..be7fad43a88d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -392,7 +392,7 @@ u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
 
 	register u64 __r8 asm("r8") = param2;
 	asm volatile("vmmcall"
-		     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+		     : "=a" (hv_status),
 		       "+c" (control), "+d" (param1), "+r" (__r8)
 		     : : "cc", "memory", "r9", "r10", "r11");
 
-- 
2.52.0


