Return-Path: <linux-hyperv+bounces-9318-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDzJDT9GsWlCtAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9318-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 11:38:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA32625C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9877C305B033
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3033CFF79;
	Wed, 11 Mar 2026 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keKphpry"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B33CFF74
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224850; cv=none; b=eM4D7L1rIxYRNhUl8FxsGeccSg4OChPB+gBU/kyNyVsuHmJPAS3HdwCB9CJ55p9EcktYRNcHlNkyIPd86M6g5MJC+B4i1ECR1a9udX1eIO0vAhy7S/3BgbYHOLi1JkBvJCtEP4+DlEgVKSJyEIMz35R2NhMqZXPIwrF1XruyoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224850; c=relaxed/simple;
	bh=D/sUWWa4J99T6ZZWlhDyVBs9TPTN6piAaeskN+Sa/YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyLNfrIPUPsZO9vJAqWJ0m6UytM1W1oYmhJ7ALzKDh7jDoaoSo51h4GYdVkYHYBLc+7jBOWMMVXqjr3t+gfq8yD5E68nUUE+0dqubnTO4cSRuEkGW45TDcSgBASsbGbrq77vehwZKvQDG5eZACGnvDxT3YMX1zcyMej6ydw5PKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keKphpry; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-485409ab264so5862715e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773224847; x=1773829647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=940oY3G5/la7E98Q1Gx5pCrHN3lxgObP5JoXKnt40o4=;
        b=keKphpry91BMH/R3gJIQCuWRAw98OcjnhBf4Q60I72ODjfWrPr+6xEsGMFNEIahLpA
         djN0dpHqOwZYnQzKD91lc3fxzFIeLIZISkdcskRLrFmfuhcYH8aCn/qA0hREucKrULEd
         M+mO2zSZcGremzTtpYkPZfrJDEz191NNWE05A0MEjtnH+dlNjdMoxFClWxM4+7+n8/xE
         FLuLPgscSYGw5zrIaBbp9ANMM29U9FJapdZHBiQejxsVrNsPHjf/fsxWmOKE5Li7jiaz
         NRYJ0yGKkNJQHw7H4n+Nj8pYU3vgh3R6Z5eVCQMzpf7YvdPXKjdExOITL2YiOq3ZrLFA
         SZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224847; x=1773829647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=940oY3G5/la7E98Q1Gx5pCrHN3lxgObP5JoXKnt40o4=;
        b=sgzT+k+QPgde5AXstHuk6XRIAkfB5eOtfOMBRUL5758+F9QZM0Fkut4xnsjR4+C3wp
         f0MzwIt42+5PStYf6nBuDMnWAXt51atX25UFZZpZ0qbOSwanHo1UBZ/kJgakyrFj+o0K
         F6Ejq+2KBvwwE/YsNZ2S3dNf5CA3kExAFJIsMpEsVpqHrk72Byk9Kfx7CGe/hF4Ms4x6
         MyNrsuf0AVwlZKeCgKnUl5/Oyfqk1zP1VgbiVsr3YRjYrxVxemjIOcz7hFWiTtjI/7Xh
         X7j0sMGDA0qw9cuVjJ6DZrqTgRBvh4ofltaSlwxxRrc1paPfoNL2Wbrjq26vda4GTjyZ
         jOhw==
X-Gm-Message-State: AOJu0Yy+kxAO+OuLSgdof0Uc6OhzFToT1jAfRsVeYtaDTrSdALnDOAeh
	kZKI6cmsZ7pSeP7LK2YrKajiqL8I3rz+5MFC1xfqBZOYn05ehcja5ivGfnrQzR8TCnI=
X-Gm-Gg: ATEYQzzIStSLK8tmQA+zSr1/7U9y7rCPlGl+Qy69V73iiiBxAGJYxa7C770JInaXvUA
	b98arg+Ux3IPy22b2b7YcVl9tHixK4tj69/1ZO4g5ND2S+bWOQsLzUsf1rK/SmwBhjzV3vs8y4S
	xc5xqpX5tsVJugYuCmxbb7vTMPRiNd4g/amFbUy0cyq8D7wL6Oifx40zSdUPZV+qHbqcU255vPJ
	+gQibXWIqBHfGCC4X5tIrlpbaE9gJ7ovAN4Dp6GkSSqwvBBWyI5QwTgsUivkLr1h2Ixd0E074HM
	rLtZ/dbSFZ5nnKaXJgmGjPf3PW+ipzgS3I/PJH4ivyYXHX+loSki4tNn2T1ew77dSwHNU/hTuIk
	i6ZJF5LlErWWga703kxfLhim/5aSpj9Iriae6olmrbl5K1ck7y3+fWFv3QlW0bL6vl5LRv3H7+d
	cocwz50zS6SyEkcFKI818q6G4iIaRwxNpfi0lNZx2niEFXb7dkSM+xQW3qsFOgrpKZGx19GkgAD
	+zNCCTWsQIzge6t11c58uHImZDDhG2OfposEQWpMsu1
X-Received: by 2002:a05:600c:45c4:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4854b239e06mr31262465e9.4.1773224846448;
        Wed, 11 Mar 2026 03:27:26 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm44534915e9.6.2026.03.11.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -hyperv 3/3] x86/hyperv: Use any general-purpose register when saving %cr2 and %cr8
Date: Wed, 11 Mar 2026 11:26:00 +0100
Message-ID: <20260311102658.215693-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311102658.215693-1-ubizjak@gmail.com>
References: <20260311102658.215693-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BFA32625C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,alien8.de,linux.intel.com,zytor.com];
	TAGGED_FROM(0.00)[bounces-9318-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

hv_hvcrash_ctxt_save() in arch/x86/hyperv/hv_crash.c currently saves %cr2
and %cr8 using %eax ("=a"). This unnecessarily forces a specific register.
Update the inline assembly to use a general-purpose register ("=r") for
both %cr2 and %cr8. This makes the code more flexible for the compiler
while producing the same saved context contents.

No functional changes.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/hyperv/hv_crash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index d0f95a278fdb..5ffcc23255de 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -204,8 +204,8 @@ static void hv_hvcrash_ctxt_save(void)
 	ctxt->cr0 = native_read_cr0();
 	ctxt->cr4 = native_read_cr4();
 
-	asm volatile("movq %%cr2, %0" : "=a"(ctxt->cr2));
-	asm volatile("movq %%cr8, %0" : "=a"(ctxt->cr8));
+	asm volatile("movq %%cr2, %0" : "=r"(ctxt->cr2));
+	asm volatile("movq %%cr8, %0" : "=r"(ctxt->cr8));
 
 	asm volatile("movw %%cs, %0" : "=m"(ctxt->cs));
 	asm volatile("movw %%ss, %0" : "=m"(ctxt->ss));
-- 
2.53.0


