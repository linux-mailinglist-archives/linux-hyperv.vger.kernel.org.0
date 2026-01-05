Return-Path: <linux-hyperv+bounces-8139-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAEACF2A2D
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 10:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3AEF3051E94
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C81933291B;
	Mon,  5 Jan 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuvEc2An"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037F33290F
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Jan 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603875; cv=none; b=ITjQ5H75y4BdaeuzlQNtZ/7DRgkQ1X3HXW1hCf9+F5Ap0QJxDEgt6pf8gAFd1ForhfH9vrhbJRTmsEsBIN2/rVwLd3o+GiuaHM7xf80cA4tzYpkl3p+fN1ATCyH77IwFVs2En9RtREYs8UiCdqFLDaqR1Lo8pE1Z3FeF4Eu7mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603875; c=relaxed/simple;
	bh=R4clijMfXf9pEMkScB8soyXVDj2wSwmGGzISe1C6424=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCXOb0BZTAZvpdTXlUAYKEzCBEo+E21v5MfQ3ygMvXxIELjeGXkjO7NOtOb/maEzLeJGCJ4rzraZC/5SGQDd5O6rgfeuQqGIG241yiRO5/yVtm7f8WZ67woOaTK/oW1VSMiDtTdTOJk39xhgOydoMGsl8B3ljO7lRF+/4gM9VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuvEc2An; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so3391949466b.2
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jan 2026 01:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603871; x=1768208671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UodVpuqflOW5Y3875SY4/RwwgPqPyc7YLec6uToVJ8=;
        b=AuvEc2An4eF1eQcZMtlgnBst4eYuVWV7T1FNKLzcwC+0z8vCm1wA0Zija2DQOJcMlx
         Opmza/xpcnYqo35re+d59ocODdlj4VFDngrk1TnCP1YKVPS3BtGTW287C6I6J/XBmrV+
         cscuHcsflAYDvGGTyjABZqFDjRAmRvG1Y2Q9Ei2UQ4hUzIsDPlQHuvV45GMM/KFMbB9Q
         2mNFxioopuWf0asqNBzKsyotz4NsAvOaLbHVsLXNRPwRkQUSK0Lqt80FHX4bNjW3HsWq
         JflghYgTAVz+DBu9qTgqwwHxbDm3uqqIsiMVZEVcDoK/POQWDURlrxxha8wiYZ8+uHyQ
         Sadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603871; x=1768208671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UodVpuqflOW5Y3875SY4/RwwgPqPyc7YLec6uToVJ8=;
        b=vVv7LzlgfCACNz+Y0KTPRVgYxcBpeB2a3RYjBxeWLiwYZUXYdzCoJ8GO/6fYyRsLj8
         y4PKB4WUN6OS9qwN5BD9XhedSXSxwVx+hVEfT6KBwhYqAk6GoTE0sfjI3DLGfO7Ir6iv
         zz1rC7hRY4EA1WIeLlGtrXrdg2YtOg/3NvMMYqRxjvVGD1YAZrhWZ/wFhG5U9yibCFkF
         JLjOkwXdCiXM4xt1AC6RDEH8n0SpHQlNtPvOww9WmVyyoMmkk5y1ik0yEyHtTr4Fl9UG
         H/mKjaSCnqDuHBS0xeDTQYIELMWPkwD2u/w9qyQnqNlZ5YlDaZO//F7WwsS/XywNJfoQ
         3WPg==
X-Gm-Message-State: AOJu0YxfN97ka7W7uePpQEWn39DeA5bZSm52HG5NuxwpeDrtcFB8S9br
	sRuYpz+paNsTfzy0qM+g0/eksFWxfiCClLQF1jOmrJCyVY0iI84bLjC26P/AHA==
X-Gm-Gg: AY/fxX4gRPsrfLtfKQ2mZ5MUb3oSsG7ylujgkTN2X6BQHQ8+fOF2rEdA0Yrm9kALAil
	EgWp4r5B7pSlSg4rN5hg3xkRlgm7Es1qc5Q019ydNbxX55BNJYjwewAqBEQfOptDBmL9n8F9TPM
	S72Lj17wyek79UHGk2YekhzzcuZxzESE/C5f1ivGDXVpMRbLr2muwjf92z2uxuMfkM7UEroOJhR
	9kWMGUKAtBJoahXObtSDhav6vw1xnIOYnlv/s82Dwkc9SqbbtZhCfLpm0GgANNgC9/DIcFZH+BT
	bwfpcFGEDaqF+R8gEV00FV/Slpf+GhBl0/CQAOeFEog6xG8B/C15JLrQLw5hdhFZweXJ1fem1OU
	t/67TZb1lkBWf12QNIBD9md5+Jv8LkMAsAy9mVOyb/XayOjx3acKe53PkyBvGL0FQIkAiq9z+dq
	KjUhlEydpqbZ9tvmNkpcspJzYVB5HivyNIVeHZmknUuSI=
X-Google-Smtp-Source: AGHT+IFeoDZ61XsF6hTg8Gaby4QB1QRbCTEmVadFwWGWUphQ600xzp6SLnCdx3ZgO7HmQt1mDojaMg==
X-Received: by 2002:a17:907:9686:b0:b4b:dd7e:65f2 with SMTP id a640c23a62f3a-b8036ecbb91mr5279372166b.5.1767603870965;
        Mon, 05 Jan 2026 01:04:30 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de0de1sm5521794766b.40.2026.01.05.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:04:30 -0800 (PST)
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
Subject: [PATCH RESEND v2 1/3] x86: Use MOVL when reading segment registers
Date: Mon,  5 Jan 2026 10:02:32 +0100
Message-ID: <20260105090422.6243-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
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
2.52.0


