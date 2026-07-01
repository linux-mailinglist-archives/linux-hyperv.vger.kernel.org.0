Return-Path: <linux-hyperv+bounces-11723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LEnTNktLRWrj+AoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11723-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:15:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF26F0420
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="MJX+jwl/";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11723-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11723-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC2B9302B74B
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAC386C20;
	Wed,  1 Jul 2026 17:05:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678F385D67
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 17:05:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925542; cv=none; b=WtySFaR31nXvqM6m9I94pbvQ4DaIv5h2mmP2zGHylsWfRCUHp6kXFJ9tuL9olfAzf8Pjt0DYLkX4L23f9PEe0KfwJOigSd/lCA+0WFwUc5E3PbrckLHAxIdGpXNND/JhRzvsteHnh0VyrZPDw++EbPr1dWSxIMbqFSq5exxNncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925542; c=relaxed/simple;
	bh=i6kOt2YoYOTS3UNjaVCpuG2OLA3vhViUK1uSLAS/Pz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRT4WaqETFvCMF4QH0s7Q/CKBEDUl/WYLmD/p4VpX5o7mbvLQHPCEnTfWJLeiHKcAWmoqDHgOfZl95vXjrdxbMl1ljoRNoqhkMuE+aqs2WB4a6seZ81VJAHNhKkeAVFUc1IwhD0NyRf0IKocGV7PAL9TqLmH1aa7MWaOamYlbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MJX+jwl/; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47248615e4dso908877f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782925540; x=1783530340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gf3UKUdDckwJ0S32IeJydKrzo8cm0OFmgo0J+PNmpU=;
        b=MJX+jwl/+s7fT3DKW1aYyDoYTL/2CdKJyJznQvw5/ZfsM8u48scQR6G/0ZzN3PNSOn
         5d0RwNy02pEfc7m2NAats2yrsX1KIvRKchUft26POcWqJ6B/ms9hS1X/fsdGLKa7j5CL
         t28EGQuM3Mqrr9Y4sY8KqXm0bD+4eQxqMZIVy3oE3/XWVIw8Ilr+HpwXnhQte7X02tUA
         kmUf+fS7jKNasn/1aqcZO9OPqPL9JugbrSms1vlncO0W2t2B3HIgx0D/EqSev6EXB6D5
         0ftDzlBRv+dXZwIo46tb2DeIYjETOBwtkD3q2yz5wUrs746tgJkBsQI2hZ2CJZicbdAW
         rhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925540; x=1783530340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gf3UKUdDckwJ0S32IeJydKrzo8cm0OFmgo0J+PNmpU=;
        b=GhpCcDFEBCX8utCH1rCg1Kez9xAh1Juo51b5SZF3+BT+GqzjH47euL11wn2IcOBwiC
         +yhwsPLw8MGefFkye/5B6CmKghbiTcGYszkLmN1KJhu78Brvz4Rc2cxFRNoBl7H4mQ9I
         85SNZqT881DtarVtMXZuMc2/I1rHyAik4d5XRW+PHZJKM3IWtBM5nrE7fazW9islKC1v
         f5ElR1app55gLBniCBT0XLjFSzRD1BOQZG6IRAfCPKgyi1dxIBUZlXWxnMePWr9E8hKr
         l/2QBhIqv1zFhIhCGBLXuuD7pg/Tfjnz2ZUTFm28hIQEcMvjT0ZPp3MTdbWSgLUsmSAb
         EugQ==
X-Gm-Message-State: AOJu0YwVjGBBnHFFBqmHP/sVuKmOaPGT64/A69Uhzd7dLMF+PFGtNbCX
	OUlSEFzh0ys6mV+6hqKrfBEW4b3RzGh4uYGtVWNCo6J3tmsrmMOh2qqL4K8lMz2LMyg=
X-Gm-Gg: AfdE7cnjAD7+Lc5adaYXITkx+gc5UFx2yGhRlQueaAKYE3nXHYT3HFvrfFvmhPL7oq5
	m46Fk3V4g4TMfePUbsBksWjcW8P7bWCQ+ir8HQ9tbP8qDWhFp0mTdv06lWUbSfgSDFYjDOn9xl2
	BRxZ6ktMygyluX3Gseeo3iumr6rnjbriyOTtL0B3hUAm9cZCqpawT3/4YKeBdeAHzG554xSp7IF
	B3Sps8tpxoRdgxMqRqIDZNA/Omycmq02pG99SWi7fv2XPE2gI2fCSWYfm8Tqxw63aa1R+BXz4Dg
	ht+s7n7l9wLwoLrxPOLJkAEg+huTJY02+edMgKXuBBVJk6SkysC3qokKu1gq7ot3GVyL6QY4NrC
	YYQOZOK+OGH9p3V+c67q/Pd4PkzijNwwo+SgKrWIbfvC+6+qDFlgXeSuAImIMxdbVch/j4uZZ1C
	+QZamDRsYEBAxpH4Gc/9eOd/3bjdmom4kiW5EK7OqFWCe+gwLMK3WWsIF8Rdt9QQLs4PM6Mp1Z/
	4Dm
X-Received: by 2002:a05:600c:6d0f:b0:493:b6c2:cd96 with SMTP id 5b1f17b1804b1-493c2b4aaddmr23283325e9.12.1782925539685;
        Wed, 01 Jul 2026 10:05:39 -0700 (PDT)
Received: from localhost (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493bef1807asm58557995e9.1.2026.07.01.10.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:05:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and subdevice for pci match array
Date: Wed,  1 Jul 2026 19:05:20 +0200
Message-ID:  <019450ffb519d02821364afca32b9f48bcd8d2b6.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=i6kOt2YoYOTS3UNjaVCpuG2OLA3vhViUK1uSLAS/Pz4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjThIFqHXG9zdoMtK7kK980Ppa+ht6Sofbha 6k2UnGDf8eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVI0wAKCRCPgPtYfRL+ Tg0pCAC4VMts/wpBY1P1Xxjfc9pRZSMqPVzxiIewQ940MT0UEQZeWMqEfHkODhvzG2CoNrvfO1M UvGG5vGQ4G7ulx0zL4RqwpGVqRGwv6ZzlVpgMazmBe/w5GT+nktfRYWRMJ5vp/95INopyieXodq 1lQCn9sKvrivaSqbVwEnDNbwdGGBwtkT+TdiAeD4lYen2tGPALvhoB6xuBm5OHIuVCzs6pJOk0x AywmPpLzK2VUbIwPHGVcLo18+BuJFLACqKjxiYo604o9XSdEB3DmnrpnCQEDGuT4FaqvEXnyzno lvyx+0i5U1dYo4NqHKStyrbfxz867rFHc4xDDjh3XexFr4hM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-11723-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5BF26F0420

.subvendor and .subdevice were set to 0 implicitly, so only devices with
these two values set to 0 in hardware can probe automatically. Make this
requirement explicit.

While touching this array item, also make use of the pci macro designed
for that case.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 2e75fb793495..e766d87b7a9d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -51,8 +51,8 @@ static void hv_drm_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id hv_drm_pci_tbl[] = {
 	{
-		.vendor = PCI_VENDOR_ID_MICROSOFT,
-		.device = PCI_DEVICE_ID_HYPERV_VIDEO,
+		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
+				0, 0),
 	},
 	{ /* end of list */ }
 };
-- 
2.55.0.11.g153666a7d9bb


