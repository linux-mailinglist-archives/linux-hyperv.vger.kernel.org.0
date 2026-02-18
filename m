Return-Path: <linux-hyperv+bounces-8900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cELKLWYOlmmNZQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8900-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 20:09:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71C158F0B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 20:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA53A3014665
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BF346774;
	Wed, 18 Feb 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh2HQ8G+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FF34575F
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441764; cv=none; b=XIKSl1Vx+2gBgOnbnGAYytnhWgkLBJadsJ1Lk3YOin27CjGNSm5q6R9E6DHkXogKGEcRUNTkfuGU4dsOB20c7xTYqQcQ2AU4b77rwjutUHs3rkMDiv05nQL9mjDwwQcvJuyPR3xyWhrzG65Jp3gIDGN2k3zYXz+NUcfjap3oods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441764; c=relaxed/simple;
	bh=+jdOyEDd7dgKfXWQTh8+egO7d5Cs5XS/fiyz0bK2mwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qg01zkFL58BIKdTNeNkXwkMWoxs8QOQOFE/Rrp/5RZZwaR3Jj714Wml0GzSB7IvwbzjIorzdBNPVcYvly4kHWEsXS99UqaHsXAsrr1tzyPbcZbDU+utooa9W+C0faY3j1WCAlwBx8kCsHD88eDB7CjazgZmjVH+xaf9sVvaaf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh2HQ8G+; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae222d87dso105142d50.2
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771441762; x=1772046562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0ZCsOK0QpjL7gyeytvdHiQWsLRK6hVybiMxwZYY0xQ=;
        b=Rh2HQ8G+6Mc7NYHkrWR9E9ajzO7PTlIk7D7gNbVtsGVwvvtDkeYO3WFv/N9sn80GT3
         zNwelKY/BSef48barKPNYn7Lfr/3vwHyTZcZsSdBVa39kW3C8CAgGvIEoVuTwmBFL5um
         6/KxRUpIbXrMIb83SZKA/nJVJVspEuXS7uPu+BqWfc4PK33aZR4FoAvGr3YwR/aKYc3J
         +Fx8QYxnpZYKsk/bRNf5yg3Fxope21nf17u0P1rIg8buQRm6mBHVP1g0zK6Pfqo9Ome4
         Fmhrgrs/jDd7odYb2okzCDcUjitS92Fk9+3QEoIRHcQlrDoLr5z32d0RwOYIQWjIaLfF
         1iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441762; x=1772046562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0ZCsOK0QpjL7gyeytvdHiQWsLRK6hVybiMxwZYY0xQ=;
        b=mcRhacSadcsN2BMFTEP/LpwiZgWmpqCqNEHaINgyihRFluagFx3BNOw4m6kwFOB5xH
         HXfth20eTWX8GfBs6ve4f+VNbqO6xQ/QWtUE1NwYEDtLsnC/poZlmL3g9rsRtLJxXmPH
         jZaZeiuVnta2uXMDteOYfYTm3+UelOuTk7zcVZk9YXZc0mLiZU/ty+IEVPJX6hVM1Nt7
         VNZRTK+RcxzY/ifv0fl3mPS9WFFAW+2uMGg2Ue873gm+z4z5Tfl0WUykTFlpfk+KnaS5
         4VmsZLD8T/6k41Tsn8HMNZ8z4/n1aSAsofhyv2pwM/piJSdjlXeYT35+35ODbB3CN3Bu
         wpeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/F6PSNwQXnD2c4IaQAfqbfAaAL8MBdB8MD0TDQaDmFsA0+vw8WznWzha9k7ociKk44P9XLNIPll7vC4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXw2gxJODKheOzdISm7Ac/csJh+mOYPy5ZU2sAjsV4SQ39DXS
	UaJnZcjx07DLcY/IBMqkkE3czxZ17csRg1QUxpTicpoSizw6Ca3Wu2th
X-Gm-Gg: AZuq6aLW3/LjzgupBNxmvApLH92+VY9zsk65xMX9ShCzDxOHX7PfWxWqepuV1G2sdl4
	eFzeFNUwrwF6QVH/t4CEi3NxSYXI5/3YKsd4r06LNhTI5BSjtHqRZNuKuBA3tCJwp5djPiwlz7Q
	LIPwbBZAFpfJNZRw3FhK0rtBA2ugwEt6+XbAoAICQH4ACUlGTHEuprqi50o1eUFWIT3qyuEplcQ
	vHp36emnuRfSqjdt2dnA2JO4P54Xp7YFlN5Gdbgi4GQ4N4qy3oGbS2y0/lBu5S5FhbzIqjupbPW
	oc3lsJojluv0UZecjuaFqUiPt1H+zwfQSjNEXYq1NVyomeOMDAsTBq662eGw6lYOYAQW+GuYFx2
	gDLLBAlB2K4FP92AJ1RqBzRc24p5jQ/QslO311Om7N7ZeyG0xbAWl+eQaeWt7TEINIg1mcwaTO8
	4nOubn0M045F9KxacyGujhdnwoYBOMxuxl/tpRs+HhH3j1h1RcpZzw8Gmsp/lOPnx4AFzZ0qVjU
	83o8hLavfRiioHOJbwVOk1Lz5LAMrCwI3rgYzf3Nf8=
X-Received: by 2002:a05:690e:1246:b0:64a:dcf7:c13e with SMTP id 956f58d0204a3-64c55563073mr2467484d50.17.1771441761829;
        Wed, 18 Feb 2026 11:09:21 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22f89f75sm6379914d50.11.2026.02.18.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:09:21 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mhklinux@outlook.com>,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] x86/hyperv: Fix error pointer dereference
Date: Wed, 18 Feb 2026 13:09:03 -0600
Message-ID: <20260218190903.7874-1-ethantidmore06@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,outlook.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-8900-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D71C158F0B
X-Rspamd-Action: no action

The function idle_thread_get() can return an error pointer and is not
checked for it. Add check for error pointer.

Detected by Smatch:
arch/x86/hyperv/hv_vtl.c:126 hv_vtl_bringup_vcpu() error:
'idle' dereferencing possible ERR_PTR()

Fixes: 2b4b90e053a29 ("x86/hyperv: Use per cpu initial stack for vtl context")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v2:
- Fixed typo.

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


