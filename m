Return-Path: <linux-hyperv+bounces-7716-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94FC744D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 14:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D5DE82EC36
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B42342519;
	Thu, 20 Nov 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWvDHR37"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B9341AB8
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646080; cv=none; b=X7pnkTRKQEPEwe8EPI6+xY4II9FR9k11uWA300sLqGK+2Vl2UcOsfcPfd+o2yw/xw0bO4YDsqna8Cr335nslUQwKK5/Xa2waOVIfuBFVUsoanh+coSeIQn4iDE4JNe6M7X2/RmTj9WH44X0NU6W+9GH2q5JnIMqr++Kxm8ZcRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646080; c=relaxed/simple;
	bh=RcGY6j0LS/M7+46NuiCzk719M/aIrtPUEXFR27eLK8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT5rKnU2XFTOpuB5x8vP80KWG5WsC/nTcBpoRU0cC7rE889mC6iyz5KJkN9V4bEKcpF9WLhwOD1P55gtkzkHFMIHNLJuB30wp0lHscy/daCcwfZzyC1wc2cIoPr1vUBnsm4sPPmBd0ZBNwCbo90t7qdW1Ml5unSLzYMgIljlV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWvDHR37; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b736cd741c1so166452966b.0
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 05:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763646076; x=1764250876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqzK8K+Q7yG7g2bJhm7p6PiHEBrmEOA8l47A7V0lkNA=;
        b=VWvDHR37f8OnaPe7xdCwGaFUqfWEX9Ci4ofEHt4vGtx+CefEx0oAZAfI0lZhjGrbNA
         7VP1RJtkcRnmNECE/LUgb1X/x4rg4ud8UdFmoFvlh5x4kf0tFVWjZVhyWF4nFJHfqkYF
         QJvA5Wxw0F1oKkGqUtVuBI8fmI06DQYgGnt97u6WFYABCiLabm9M17HDa7Lruth9+27i
         Hv7llWvHEnhVW82CG3/tUMl+jBwve1MBb4SdSfTqHQeeNUAlswQFBQh/8qAabCgISZi+
         x3JR0UcbHdDLbginhhon5OBZg7PmiNV25LnMUICPJQmhanUZwbMN5kFxP4Xw2JKrafUX
         ur8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646076; x=1764250876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqzK8K+Q7yG7g2bJhm7p6PiHEBrmEOA8l47A7V0lkNA=;
        b=fzi3IHG3/sAMdB1yp4zXZOZHAUaSCO7LxD39fLwxuwfJa/NGR0nJzy5x16WELjaLR4
         NuapfIWQwrxpF4zkQwJK4M/QmPxNVWZteOuSn2ZPBB/q0PhkgwzvrjpxZpLVbcF3gQ/R
         ZfT6rHYxEOE/SHH9sTAhA68i/djArPvkrZHWgVgifDxX8KAI+lPbXlOu7HROyBVxR7P3
         nEKZFdXpxn/XCTJIbwgC8ly79I689QghI9/E7Z6sAYXSheOPwpz80ujd7v2+lAMwKVaq
         jqxVLtYacGK5kxBnqJeqYznP/37OEagmQPOigKl4XJ/7oXsKLPvkLDMkaJI55KTbQFfv
         hAXQ==
X-Gm-Message-State: AOJu0Ywf6l1s8ISCtIbjVtBlRacry+bd6+H7CtkkUwcvN0tXXoINXP+j
	WRGeokgbGhCHznD/mlspc4T+ywuhm4GEYFbN9NNNyPCkB381FkMlCPjGfTzTvHQx
X-Gm-Gg: ASbGncvBGG43AMJGmO23N9cqjr4AGdCkWOo2shZ433MYiAqp5Lh4ZO1UyWLHoK4/IvI
	EqI53XSBidHi3aeoyVitA/janumrvVhjzFR7Zz2cddmMayxzzL0hW8MiLx3BA3ZuMUWgTHkdpH1
	Dhhqiobn2RNL9jN/7RmkCsEv7Bb7pm5cNZXMTdTB6W7PTaPHdkuowFMp39AdR2nOKWJK6WNEdsJ
	ZXkZk6oNk0ac9C0X174YuyNFqZ80E46pLfYcg3w0L7u0KbFcEUXSd4QDqQm1YKIi81aL4G8UptN
	UI0J7jxCp7GjKGU7T3wTXR3Yq4E8ujO1NAn6U00qfbbtU7Q4ROxdiZdiU0faJhrLfe5naMw5J7v
	V/e3lmf8uGzFxUJjD6yVMh63Q17FSX+qo1gPytffL79NDyV76Xu4Oi5voF6CgACkLcrR82/myvJ
	Bh0MpoZCcGLVI=
X-Google-Smtp-Source: AGHT+IHO7aGezyXWUAu/GwQW7+a3Oa3goDpEQbGJV+lutiE2M8K3NnmHU3q3AHSwrWWoC4iD6W5SJQ==
X-Received: by 2002:a17:907:3ea0:b0:b73:5864:f317 with SMTP id a640c23a62f3a-b7658917c87mr257998666b.54.1763646076357;
        Thu, 20 Nov 2025 05:41:16 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd62bsm215930866b.5.2025.11.20.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:41:15 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with VMMCALL insn
Date: Thu, 20 Nov 2025 14:40:24 +0100
Message-ID: <20251120134105.189753-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120134105.189753-1-ubizjak@gmail.com>
References: <20251120134105.189753-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike CALL instruction, VMMCALL does not push to the stack, and may be
inserted before the frame pointer gets set up by the containing function.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
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


