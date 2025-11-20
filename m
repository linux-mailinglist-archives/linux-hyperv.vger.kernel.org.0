Return-Path: <linux-hyperv+bounces-7714-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE3FC7459B
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BC48E31205
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA599341063;
	Thu, 20 Nov 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipg5iMWK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF13376A3
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646077; cv=none; b=X4G0MZHsoR3UwoFlLxjUy44qw23ol4ExV6I5WD9K358bUKdedGHuvoSK3X7QUmWdhGyQ9xwCFjP5tsz9UNSzXk7qqM02MoUh+YoB0Zh6faVFDxxRKmHLAIiMmVZFjOfGnUmNTWi60nEYX5DcmGj+oGBWqgHGEIqfXGr0XlPUNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646077; c=relaxed/simple;
	bh=YV8q2uNSdAc2J9BYMqPoV6gVpmxvZmVkhCQLq2n/rbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mjf7upeOjpJcelUi82RQRVzgTmvKAi6FS1AnxPS3AwJUDtniQnS1PPI1Na3X/I+TVYaB/LpolgfQ1nKjPZUyU22PYpL6QKf378O1n3P/HDNRav6NPZxbbwwKEvNtEKnXSOEs/jc3ZM6qXq3nxdL+9i/N6odNGH5BQidZ5KpI3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipg5iMWK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso1533714a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763646074; x=1764250874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKDIIE6aVQ490bUzFQo3Wbj63IjfmfQRtf39NN/b5Is=;
        b=Ipg5iMWKkZ++3Jim1/d8m5ScyQTHIwIGo8yHCV9tqx9+BqMGpJHmViLlpJfSy0Q77s
         gN8jyVjLVulpzvs1k9rP4zHeaMveMWqbatsqgVNHlD+ak7QSgTjWCgE5R2rNJndC+rLv
         yeJ0ncei5s2GGOOz1Qhn+tyIgCthsoChYz+HI1v62W4ryAfcnq5W713BvQKKBtiFZfqq
         8tpgJMs/NyRzBJpIXz65sUD/uZQt6QlEI6TQ+gmDJi/zNPG6kc9wMjuD8VzB/YNiXVGv
         c7iJ0sUKvLzdHLOlOXMCo7TfLThrrJoYrLl2OpfpBdc5tmfkoN16dqDPCTF5wcKibgUm
         uJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646074; x=1764250874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKDIIE6aVQ490bUzFQo3Wbj63IjfmfQRtf39NN/b5Is=;
        b=rBA2DZVHd4Ggz8RCZ1sSVAgq5LZH9ZLYANyOx86nfLVml5bbC8TJ2i2RctW67VeEqM
         AX5wbUSjJnGKJwfn99T3srw4X7RBjhqZ7N1NMFC2T1blMCwqoejjSSp8kVTtaOPplbad
         bCR6878YkBsfOXxzy6laCshHVY0B9YgEZ23WuAKB4uIRk0YW3MZQ0XgQtK2xlOlpsIuE
         sfB+ZonEaEBRN3PJY+jvl2GnELqKMsCwCRLcO0nff8ruZzzZ5CKZ2A+k2JGF5YKRl2F7
         8Boq8wXYuwxYvvFCMT+cwPbbszAQLYgxrQ6/C5S0YQWssxXmduhShrYFmP3labkwnayo
         PPBA==
X-Gm-Message-State: AOJu0YztqSB1pukdk2aUJ2BxO4iFUl3SCqoaVdDlpoMW428Kx/oejQKa
	/7/T3WXxf3WWJ+FokGCaMUlIAlEgnRwOL+VRwy9CsZ5dp4Lxosb1hPg/c1kIYLfS
X-Gm-Gg: ASbGnctPC2fZDnnn+d/2J0yZLBFmLBZzVM1Wdn00l0XTpGrtdGtveDQDsJtbQmowZn6
	ouSAh4SHbi1JrnG2tdomzPf4/WltlN972tW/0hFXa4TI5xaUqvRGl/GZd7fVkry5qiMSkFBUdJg
	tu7ToCvWpSRhgUb3sdakp8ZgqhhsxHVJ6ouqzkGVfQ9/H0NArc1AFSgmkTi5V6IUgG5cb865DWQ
	RXYaMDXOzifIIFo4QzN94DHvgrT16n4iNxSUzkeDEvHIdaHWBj17L9H5TO1UEidD5TeGQuiQUG2
	hXe8PVaOIU9I11Eg1pGR7IcdnW/9jsnV6r0AC07QqpYtjX1TcwEoDfEEKB+/UHgXKX1xy8Jp8tw
	AooDz5ZXMsf2DblATjWbHnsYMXSXJg8kPvk6npAxV2/QjsDEO1u6v3vZQGXLlzCC4O/IL8yf2yc
	Fj8dmCh+ERMmM=
X-Google-Smtp-Source: AGHT+IEJbdZfZ68AcLwk3uB+v4rhFJOb3fa5G8W3YPaf2eNwkkCxBroXy31G9Afa7rpoBsH4few3tQ==
X-Received: by 2002:a17:907:72c2:b0:b72:e158:8234 with SMTP id a640c23a62f3a-b765525814dmr151266666b.3.1763646073805;
        Thu, 20 Nov 2025 05:41:13 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd62bsm215930866b.5.2025.11.20.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:41:12 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] x86: Use MOVL when reading segment registers
Date: Thu, 20 Nov 2025 14:40:22 +0100
Message-ID: <20251120134105.189753-1-ubizjak@gmail.com>
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


