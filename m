Return-Path: <linux-hyperv+bounces-8875-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF9tBYgnlWnRMAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8875-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 03:44:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F6F152B98
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 03:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76A430459DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55152DEA95;
	Wed, 18 Feb 2026 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D68Z+vrC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDF1E1DE9
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771382652; cv=none; b=P1sYzhjkZ0Obeo146MVzVPaF+DQHAMApnprL6/TCNt5ADzyS7BcHGIxQIJmKJ8/mSh5ywdCPSq7J2t/6/0JLarhUvZz3vjSH6k9qNtybLQKKJ0rQ7IDIkTCx/vJVMP0PSdduHp6k8kP4jwqPjktX/Dh+7XiCOWKUOCIm+rBpkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771382652; c=relaxed/simple;
	bh=qM96F+m4zeaMT0F3mSDheudUYrXgOUpBnOi12ksTeDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQDtKj+VHAZCtF48z8LT9Yf2u9eAFqRb5dRupGkRPl7aScNIBJXyp96W5wVgj4rLWzeNh+OdKWS3LJD0YBgtiEhWGlmSRICcmC8AYlHZiC7FleCH8uzZb+X33rsk95+dIG97vMQlljt6s+4zXmWO1p/0Aitwz6QPbB/5ZOnMHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D68Z+vrC; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ada2c30a1so4504909d50.0
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 18:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771382650; x=1771987450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lwYCKKks5v0/UTUXbaTWsvyMjdO3lV30MpCD0Gwl1e8=;
        b=D68Z+vrCF5hECZWCnsylkSvMB9CJThyynWjjHRcrt5sKRBa2zOvJCCd9LuAcOCI3TR
         DfSCvR1BWzxl1G/5hF95FSf4GgF9CVVoF3fyPpu1RN5yo5VmKg7eUwdWgBDiom4t33CC
         Vq1eAHOBzjuOmka2g+4z7tT2tVgbGFAmG2PK2rktc8yOnItLoQEbzOSjIGgYG9XEXNEc
         VUO9MoQn8QpfdZXp+xNGw5fn/qYyWY83sP+/fWPDbV1EQyfs0Nl+llySr/54fONGlLCS
         KyfFuewAnIQO5XwuYPAKBP+gxZfA1U/UAwCGUXp9pLoFY/Azcz8p8XyqsrvgYEQ+tA2z
         P44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771382650; x=1771987450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwYCKKks5v0/UTUXbaTWsvyMjdO3lV30MpCD0Gwl1e8=;
        b=jJholbPYXcxt/6b28fA0zL9Skv+YdXbtl3mPrBH3PvgvMb9JOn273YtBHTukfb7Fsl
         5WjhMSUyZG4t1bPLNvud02HxC9+PRIGtc1OmvkbuVu92NZUlOh21j7j+Cb/xQrkfZynP
         IetfWkPnEov1nkehNjhOcYhiVHQmYwxQvC9iuzftUl9FV09wXMElFyJgzCnAS4RrPZ5t
         EcB6UEGmMQRhddZQLLjvejQxN4o7agRP7j42voRnUeCBZ8dt3lkHQ4oouJksYzADgyvV
         u6pAdceWaCl4ug3ulM7tirhYL/ZDXGI94cRkiv90LEG+UOcfGjW8ZNqv9Dx9KY3uTIWp
         BwnA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ygNz35637hHeBtYF1CLpUofwnLqXrRgtXrmx+cpY9Bv24QAGTauSL+7amb7WZxtxNNbhFDVDWDJvUmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuv6D7AEI9I19X7BZrSARKjFHd9QpazLgw7Qkfye7vIti8q9t3
	fSWXyXiP1Qv8lP0xjTONF0WL/C5MUUxcHWPNBnQOkBZWWldWwOZln5jx
X-Gm-Gg: AZuq6aKKXg4Qb8EfhwollAygqnWCAmrqD1NZTcc7/r/L3QHY6OGvuxeXNCjUJbZrzH2
	t7DMsKIshLkxBooIlBGp+L1wIe5Li9Kyvax8vJkB0GN9N23krxTm3lNQJlDcFEli2aW0WR0IH93
	BLqmDAqrx+wUslxTVdwI7sZBIgy5NFPYbEhbcCyX0EsuEewn3SE76YTuwMAVlAsnhL2zENrGBgf
	ESps9+ZR7166Uxfi10iPgGqMvS04LD+acVakBlgUvoLk/DFjPbjtDmowNTixn0QW79DnDsEjWc9
	zVBQel5InuyFbFj8jFWoHyAKmu93+x5+NnowNdFODalP9Gwwr3Z/kbCgQteQvyeAksP+LmihzJs
	SOlzpCrwl5cyQHkq9cDvUSUJkP/1vSKfAuqwWkfDLWKqfxre3Yr0d3lKR8/LhA1VESjbdMDzHjX
	UG4Y/iY/5aG3WFU+mLJ9b9jdeKyhSLhlWEhMfiLiohmZEc6vIEl7D0GHKmyScUZHy5pa0stFrns
	ANjfLOoH8yr0vf4DtMysbq5jbH42nw0WabviOXW/t0=
X-Received: by 2002:a05:690e:191e:b0:64a:d35e:d351 with SMTP id 956f58d0204a3-64c198c5a1emr13335699d50.25.1771382649619;
        Tue, 17 Feb 2026 18:44:09 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22f8a209sm5383145d50.12.2026.02.17.18.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 18:44:09 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	mhklinux@outlook.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] x86/hyperv: Fix error pointer deference
Date: Tue, 17 Feb 2026 20:43:51 -0600
Message-ID: <20260218024351.594068-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8875-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,outlook.com,linux.microsoft.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68F6F152B98
X-Rspamd-Action: no action

The function idle_thread_get() can return an error pointer and is not
checked for it. Add check for error pointer.

Detected by Smatch:
arch/x86/hyperv/hv_vtl.c:126 hv_vtl_bringup_vcpu() error:
'idle' dereferencing possible ERR_PTR()

Fixes: 2b4b90e053a29 ("x86/hyperv: Use per cpu initial stack for vtl context")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 arch/x86/hyperv/hv_vtl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index c0edaed0efb3..9b6a9bc4ab76 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -110,7 +110,7 @@ static void hv_vtl_ap_entry(void)
 
 static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 {
-	u64 status;
+	u64 status, rsp, rip;
 	int ret = 0;
 	struct hv_enable_vp_vtl *input;
 	unsigned long irq_flags;
@@ -123,9 +123,11 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	struct desc_struct *gdt;
 
 	struct task_struct *idle = idle_thread_get(cpu);
-	u64 rsp = (unsigned long)idle->thread.sp;
+	if (IS_ERR(idle))
+		return PTR_ERR(idle);
 
-	u64 rip = (u64)&hv_vtl_ap_entry;
+	rsp = (unsigned long)idle->thread.sp;
+	rip = (u64)&hv_vtl_ap_entry;
 
 	native_store_gdt(&gdt_ptr);
 	store_idt(&idt_ptr);
-- 
2.53.0


