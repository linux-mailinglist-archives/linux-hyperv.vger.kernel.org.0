Return-Path: <linux-hyperv+bounces-11684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jO9BEA9wPWqd3AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11684-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:14:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926476C81F0
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:14:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HDV29m6q;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11684-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11684-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8690302C91E
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273B30BF6D;
	Thu, 25 Jun 2026 18:14:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86827B32C
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 18:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411273; cv=none; b=Cru9pHzExvjJJOVG5zI9vU9xLqicoMgmWWgMa65wyX6s6lJ6XGvFUgjE+qABEy0t5VRIuV9fKSbPAT3gh/iIxWrRTrfJgpm1tAqCTgXneur4x/nKC/MFCTbmcYz4iTSvlyTUqluZ0FAf7p0DpaXm3Xs/akMDTSCHeu6jC0NLirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411273; c=relaxed/simple;
	bh=oCDgq258AMaW4NdaSF471eM9Gj3tYv+ywa96wXZCOz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwZYFg0YfSmRKN6sshpKm821+IZopSIuCA9C+Y03gmUhxQaOrxuFXYf4MasZmnyg0kpL6OaCumjcVtY1zrw+aH9Xu8ilZGx8LOcJjLx9ABtbcpPi1dfWqKndfCd2HBWwLgGrScs3/6wXcTuaAK01dJNVBFk3NCN0LF/YFcGCYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDV29m6q; arc=none smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8000e21f014so2912827b3.2
        for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782411270; x=1783016070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0001ivkwixrdliONYVWWSumm3/LwuGYj6UIz947Dh9M=;
        b=HDV29m6qrDEJf8MCE6ymG1K3Bu+s0p+vKcMIW8JmWBesqvp28sn0kVr5H6khDaIWwu
         y4Y0jbOtDD5sBjp9aZ/UBol9l6KN5ukGekTJ5vI/OTmkPU+6NCI8iaVqdxUA94omMneW
         L+FiR2L5m6Vja6ScKCOIw3m1RWxzx60zak50Y9Dmm5Ip86Mb40ryM1yWvvNPvge1NuB0
         +GKVDBlD/SMM4OQd2AhsmPaZZbkkfTc1PvFdn+vy6Gs/pG4eQhrlGJW7M3rWlyZZl4ts
         2cbeBknrcA2D8RWHDFa9hAnx7V1QvXKnWrl16HKWviavgQiQcKI9NiI5YEPZf9LjuPhP
         nPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411270; x=1783016070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0001ivkwixrdliONYVWWSumm3/LwuGYj6UIz947Dh9M=;
        b=ZlLECcAgoHt8rJEQ0lgC4nTcmsDSh2uT4flXrkxP39NjiPw1nLasdDNPDzVXjxHx/z
         KbsJfiyj0TznjHYWmGaL6xmY7Gyxej+Oy+xVnmrxovWbNmNIOcmosTlPueRlDRG6HotV
         whi/TmXf4xnTHE85+KlNX3YpDdnEXSPB2UD+q8QR2bCTPWXw4CTwNOyCShSg1r5GqMEQ
         rRMLSS/5MunNco9onZY4uzc4TOjQEQd/BDp+Dud1wzZhWRTgyg5CTD+b7GGIcrmpa2U9
         WHbTM1iL5ImmS6RpLELxWja8L6PWgVE+6G1ng2DnMnqrsnLvJMwkFPf1Yw8L56iOJ2xB
         wWbg==
X-Forwarded-Encrypted: i=1; AHgh+RokQ2YQfmSCJlN6Y3tEH8oNQbpE9GMJgvaH+kOBy7Za1tzc/WqRT84RckfStxUSsR/X/UZS3/Kwt1ToVYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqfffpaW3d87qXurly48EVzqTQC0OU6ySXuNvq2PgZ8WgNZjJ
	80NoDtrFusVHozqc4+i7hFbdN40st9WifneYZ1l6RIF1+CZw1tr9zxxR
X-Gm-Gg: AfdE7cnnGoYn4XDeatjWfMgKCEomfq10Wjvnd1O4gUqtTe3uMF5EyAtk2T8SYPXKSHO
	VPkxcm5WapRYoWC37AoP0AD1115fmJWONgiTPyYQDQYkASH0CNY6KhrP2/HCnwhms3nEbum59AP
	TsCvz67VANChshflA+6buVdT1rtNFuU2dXWYuK15O62ZxR3H95I22XZxA2S0Gzf7SbXyLdq1HbK
	FLeeZdzY4xQDYcS7l+aapLeXG9HttWz33A+WPewuQq/8vkrzFTQMydl+q1uSdfZT3n/KjInfrZx
	v/LrfSN6v0NwOEh9aXIwy3PYjfds02RNB3rFpVfyl2RvT4xcjoyAJehs5Epue3yghJe5fx0/oTa
	h9QlgGGVUJ8H5QLMrIxZxWj9/d5ImtR4SfjTr4jfWHAxBYSWbtC77w7IpBn+42x0khuBjAYNCNM
	/w04BKA7o1PFKZjYaIsEX0/RjO+g==
X-Received: by 2002:a05:690c:9690:b0:80a:30dd:c91b with SMTP id 00721157ae682-80a67dff343mr38354657b3.16.1782411270190;
        Thu, 25 Jun 2026 11:14:30 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8079ef5c533sm29882317b3.41.2026.06.25.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:14:29 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] mshv_vtl: clear hypercall output before copyout
Date: Thu, 25 Jun 2026 20:13:14 +0200
Message-ID: <20260625181314.1399-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624172157.2790-1-alhouseenyousef@gmail.com>
References: <20260624172157.2790-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11684-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:mhklinux@outlook.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 926476C81F0

mshv_vtl_hvcall_call() copies output_size bytes to userspace.

The output page is freshly allocated. Userspace chooses the copyout length.

If the hypercall writes less, the tail can contain stale page data.

Clear the copied range before issuing the hypercall.

Also check both bounce page allocations before either page is used.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Use the mshv_vtl subject prefix.
- Clear only the requested output byte range instead of the whole page.
- Add a comment explaining why the output range is cleared.
- Keep free_page() calls unconditional.
- v1: https://lore.kernel.org/r/20260624172157.2790-1-alhouseenyousef@gmail.com

 drivers/hv/mshv_vtl_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 0d3d41619..dbf03b667 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -1148,12 +1148,22 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
 	 */
 	in = (void *)__get_free_page(GFP_KERNEL);
 	out = (void *)__get_free_page(GFP_KERNEL);
+	if (!in || !out) {
+		ret = -ENOMEM;
+		goto free_pages;
+	}
 
 	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)) {
 		ret = -EFAULT;
 		goto free_pages;
 	}
 
+	/*
+	 * The caller supplies output_size, so clear the range copied back to
+	 * userspace in case the hypercall writes fewer bytes than requested.
+	 */
+	memset(out, 0, hvcall.output_size);
+
 	hvcall.status = hv_do_hypercall(hvcall.control, in, out);
 
 	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_size)) {
-- 
2.54.0

