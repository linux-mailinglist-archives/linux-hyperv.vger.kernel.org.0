Return-Path: <linux-hyperv+bounces-7755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F9FC7A219
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B18A94F4722
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06B34D4CE;
	Fri, 21 Nov 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQV7Cy+K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6734320A
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734537; cv=none; b=qJuhNAuxo7CkszK1V6PwlpnWF2NHpyFaGisyP0fiw7szhi/H17hlA7XMEojmagCt+JcQC+scCz/enMH/cBICUOCzxgzOs+Os+Pk6iJmP2v22nr0IW4pktpOiyXg8yNPpd/49QuA5JoOD2WR3gYzf1jwRzj+XRl1Hw5ZRG+YcNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734537; c=relaxed/simple;
	bh=MjfA5fnd7L66DjdZNfmVNygHdADGZXy3k+4/elL7V4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMROWMQvhamUqFHC0SbIdIS/hmeCL7rwoQ7i2UjAgeMe7EvbQcsQlMNiD8/gErRZNvFqPfRB5Y1hLoSUfHBdXB5DZyNGkBx4XtLNXamlWRQ4b2Hzw0GNeEi6BPxoI3Sgfq6EEIJDgHMblM5Mk+npOqG+ApYCyEDus8Lg+254RU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQV7Cy+K; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso3183061a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734533; x=1764339333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGPLXtn2HPM/8PhvpiWP2NBl0sy58Zy7a6LjUqe07Hg=;
        b=BQV7Cy+Khu9E7bQuC3lzcSByEM0HxnKjZvVPETrcMjcuTY17+trX0JunRgCgqhq7o3
         s/YSgBkcYD3VaXxpzhlk74BFFkkUSNj5HtlrvlJ14TwuRDii+4HT6z7iZJXJi5hPHU4W
         rBFQlPZDApZsO7V68aROUzTHQH69fYDrORe9iaAUSzf7hHJIhO1/x4c5KRme2St2BBbM
         QWRr6b+eYL9QXVHl9NvkCr2/QUA39JWuKzGhvr+HiwzCwMT9UdiWgqk+DzRx4dUhIs0Y
         4p0SJ4MUNrfQQyFO7qUPsBlvgpNnqK8L5byVVuUmgoupqoKzkgty1Rjt1ITcoUIHw0UI
         z33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734533; x=1764339333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGPLXtn2HPM/8PhvpiWP2NBl0sy58Zy7a6LjUqe07Hg=;
        b=oDV7AISY985wfqOaxF44vr7a/KFUR+sqZTwflwlkL+TxPOmEhkbRnglrXOPmNIor/s
         BK7cRQDyyHuL3XfWQy25fY771gOfaUqKcCye+lqs0Xb8uWBSyrj1LFuacHH4b/wrqemF
         0SA5UywyB9XwdnzblJEVoKbkIARC0AEcUx36Pf1tSjOXxT10/Xac6OtaP5cAhWekjba+
         OqE77zyuanjkJtL4UEWqz+MqaUEIJwSs4RJnO6VUh5kSUdXpBW0DaF/XJbWQvk6Z/5hG
         lAfq7Vh7WES5rAMrJmevpWgHgalk/c9U21ss45hzNqmNRrqaohejhiNES8g/1Q07s+1L
         OKeQ==
X-Gm-Message-State: AOJu0YzpoHEZZcH/d/a7VQePg91k7hM2t0pny0m0KnavJwMGGQWKtALg
	YJIg5DraSvS/fE27M+zzGfPvgfwOMeJdOw2+hzfjm8J3mffQoSQRFD+qfHaHnPKEqxg=
X-Gm-Gg: ASbGnctne5mqjsorWpqYWm89Lwz6SYwtFrUQfwyg2FXOWfq1cZIsffz9B+uylKAFg1q
	g9C6oC5z/ao+k7c3scR8xe7sApKhLzC0lF49D/gnMxZjVgDIlx0wyahluzMp06rNcAVS8BdJGx+
	TPf2gDQ1UFQgOd05QCO41S9WewJ0UvdEFQ9/XVNvEaOsNjJLmQyWHKKfYpYq3Ep785ZGFAZWkmh
	LFvndswUE10YtZPzXcEMF4lydN5FUHdERMdwbaOZsNZrn0drfRrNpHfr2XpetLn3mAuKy6WCEGV
	27mI19AN80LOVLhwY8BVJaS/KlYCJkwaKplNFy2NnRDZBkpAaWPyPUB8IYJP7jAmcvvEyscF76D
	PWMean1hA43tbgayy/sMzFRgTrIj4BozEeg+D8066o+XR0J9Bj6QnRwkRweSrCXWx0wM2gWxLv/
	XxC/A3IUCPfVIgHVd/63vLrw==
X-Google-Smtp-Source: AGHT+IGmg4tnLFkhi55pDseSzAGW4nxyBLH/othiodg9XOfmMcc675OBQjO5zvq+RYwA5nQUFYx2nA==
X-Received: by 2002:a05:6402:50d4:b0:640:9b62:a8bb with SMTP id 4fb4d7f45d1cf-64554677ab5mr2145552a12.22.1763734533412;
        Fri, 21 Nov 2025 06:15:33 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ee1sm4609936a12.34.2025.11.21.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:15:32 -0800 (PST)
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
Subject: [PATCH v2 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with VMMCALL insn
Date: Fri, 21 Nov 2025 15:14:11 +0100
Message-ID: <20251121141437.205481-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121141437.205481-1-ubizjak@gmail.com>
References: <20251121141437.205481-1-ubizjak@gmail.com>
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
2.51.1


