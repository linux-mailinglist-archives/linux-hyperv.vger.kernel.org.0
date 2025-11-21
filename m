Return-Path: <linux-hyperv+bounces-7753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD9C7A20D
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9829A4F42A5
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C56346E46;
	Fri, 21 Nov 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWBx0aBU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1E2737FC
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734534; cv=none; b=ZzaF4c+47FATX/LNVU9j/KRIFDhH4LuiHHr/sg6d7se/ueussFnnBFThy3vRyCtA17XZyUz8CQEcgbMtJAbntJvRhT7jjV2lCTUwL2mgDvnl+1JRCpSY6ytky7qoBfq8OghfCh+tsrdtBPq/54kPJrvUlTp7zlpNh/xMvi6f6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734534; c=relaxed/simple;
	bh=c/GIB0NMFz1GaOvPPHuK7+SFO3/uiqV6JjjGXpNTXDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQG8+Ao6d3izlBSFaTDvmMaJkJ7GZfqQbuVz8u10GU2th6WgEyyu+v1IYuMEeSTt/BL4aKuPBg+n2Ni+vpjE1zl2ALldwyt+w1Fs9dYkeIovbmaHqunbAWo2ok6TxwtwOhjvyMKYdKq2/I7WOjJxObMboRH7fT0Nmvi/i7gwDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWBx0aBU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso3261464a12.0
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734531; x=1764339331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TywsEwmt+/rINnNqDJuGI9kGhbFCkWQAPPlE59IP+OI=;
        b=kWBx0aBUWme8zrZf38fFx3+JiWhddoG/qaaYElR+Ft9UQNvHso3CjWNpypUijGoRoQ
         HASaurL7Tz1O2MsweSMeklVdKp6riv6sInG7UiEL2rCt35xrZx6rRQNjDYtRM85yeVHl
         lCgtp9jbtGlhQ4aWHYVaTP2B1OoSFRkK90C4Bh2mOT1GvxkWGJnKEbaIWgEFQ4o7K8HP
         Qm2rvkSA+WUpt/UUMltvg8ifNwbV8KOACpQF/ZAEc4Fk9Y9rhEIWlkSnlkd/8QuPh+Ql
         KqQxB4nhV8gHDdR+JgBkx4k78FkXroB9hGLd3vF7+jfpShkebCkVpkuQ+81gPtUQ43lp
         oOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734531; x=1764339331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TywsEwmt+/rINnNqDJuGI9kGhbFCkWQAPPlE59IP+OI=;
        b=lj2811/dt/L3GA0KOec3inplHyjekMJ183epNOAFArvj9rwYwb0xZ+bCvLZtenq9SI
         AilAgqlKWslfPPtxgc2JvX2rDqKXuxcYrcXAvl4ZbPmK/X17WHawClhDoLxZtVjWjHPB
         Aygb4j1CRcsUu71PAtEfEWr7B677cByBCog+JpVkIK7HqrtB57M0fxkYxby+T83wK81V
         O2cJvuirsrQsBaR7wWUN3moFLxqc51oJa5AH+YZGoR8q5aocI7Dpgzs27pp6fTg5ucxV
         uVaTj0/dbs1wgrgnHWmzohlGoJvXi/crW/pEGxeCyiR3LpQuFTymsZ7MbpA5tXQklEjI
         xfJg==
X-Gm-Message-State: AOJu0YywZherF4+RrEJPNTrbVDHajx7eNhS17lHlkQQGNsYsE/61oI/F
	HunyILc20xDALiQfV9HJerUeN2mn0Aojq+s/ETnRAxY9K6VtopV6sldKeEMEwSFO
X-Gm-Gg: ASbGncvNjreTxSWJtjZtrh6skP0eKnOuW71K/6W6SwOG3M+6FzzW2MvG1idk077agGz
	R8p8l4pC4jH8ECX7D8m47Yb+/8U8Mb5Qc/JNg2hIbHasx/fy6zXyFZ5q/VC7p8Hmj0qs0nMlNcX
	wS6KdyH0BFUZscgs9SjF2BqkHER9hdaBIkZZfPFi4Y/Tt7H5z6LIuR0mekXpZCVzLXHtEv5wwru
	DLpwTT8wahJ1vKlgi9vWZSNqQ1WQe2uVumykxWfUgmaH/sSNcCI0p8EnZiKpXrhhhaOTRUmp1XO
	gbM5cey7uJUejqVEjYQe2iWHlVqoV7dDXOvodm7b3od1gb9Eqi9ErFDEbDRZ/yiIy+jYH9kXOpI
	+89tPAxVift+LHCNKAlFqB3SqAR2k1Q6JoM/1mLZRmgbiO/MH0lpz3c7BSVJi9IknVhOc1Iz2qt
	rjDy3A1o7YUCM=
X-Google-Smtp-Source: AGHT+IFHEnXbUAFMNJCVw5joHPJrSyJK8BFgIjywZWOsL7YOOtpKVWiyp8DVLOsc3A1yHVgCwK4EJw==
X-Received: by 2002:a05:6402:42c7:b0:640:b07c:5704 with SMTP id 4fb4d7f45d1cf-645550f2186mr2539674a12.15.1763734530513;
        Fri, 21 Nov 2025 06:15:30 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ee1sm4609936a12.34.2025.11.21.06.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:15:29 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/3] x86: Use MOVL when reading segment registers
Date: Fri, 21 Nov 2025 15:14:09 +0100
Message-ID: <20251121141437.205481-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use MOVL when reading segment registers to avoid 0x66 operand-size
override insn prefix. The segment value is always 16-bit and gets
zero-extended to the full 32-bit size.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index f59ae7186940..9f5be2bbd291 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short value)
  * Save a segment register away:
  */
 #define savesegment(seg, value)				\
-	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
+	asm("movl %%" #seg ",%k0" : "=r" (value) : : "memory")
 
 #endif /* !__ASSEMBLER__ */
 #endif /* __KERNEL__ */
-- 
2.51.1


