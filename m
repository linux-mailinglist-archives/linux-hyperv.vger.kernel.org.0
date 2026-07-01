Return-Path: <linux-hyperv+bounces-11724-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jiVsHa9KRWq5+AoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11724-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:13:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D7E6F0382
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:13:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=ZHEfhP32;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11724-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11724-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82643143F45
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217D38C2D4;
	Wed,  1 Jul 2026 17:05:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5B38AC7E
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 17:05:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925544; cv=none; b=BOfPvojxAoikCSfONb+5Oef4ZK1jsvOaaJ0Ta4GEbTa3SJWxUiLlz6Ci57oygtqYfjZqM0kfZP+QWSK19HpM0JYsD9f4FzRx06AybJESkfSBrh2utWF9sJflGsfrKJXid4vF/X+l1c+WTBM0VAgcZEUMlDdm3a2/apFzYPahFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925544; c=relaxed/simple;
	bh=fUoDHGx0vIkRkk7bgRX+e2vp2YXY3RA6x0vlWQS8YwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHjUf0IZHb4C0VXVHBKNNJrAfwwAZr6f/nDMl2q3VwcGsDyTCFMlq8C3EkpYmDdxtcEwBiQXnMb6z9jMDG3J1cmwRsL0FTD3wKiSJ/Nay0FkfE0sdtWMf2dk5GQxBucOWC0efRLN4b/C70ujvDl7wDpSG5AHBxtopyC5ngOdzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZHEfhP32; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-474e7ba9fd6so539187f8f.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782925541; x=1783530341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvMe6A/UgVrym2bRYUnF2aCflCH0pJThY0gdvMKUcgc=;
        b=ZHEfhP32pnNyIO3ylykAATpZAIzNYbQgPnQHzYmLsTs9TQLb/YM6FbpUe6SGMZ2fxp
         PnFUvf2nMx426FrER6xFHm+iFmx1A94GLBqgO8Hkogy3/dXp2/xERzjyCIp0nOs40dPt
         VN/E63IihvlYofGdqLUgIwx3ZBOM9slEig4AWBjN6WJ6ZhNJmd74pgrRnBcnsTiBpgwK
         UPrQpDt2Kynw6JT5PjnupbegfY/Ryp80pd0e8iaBb5tqBKcaw9UzUAx34BEG7ODB+UEo
         Tb5ulKrcIEJDHjCgfjt4pdrRugow0ERESChuct2Hedm+3efwWaj+1KdM0RjINS3Xp2G9
         w6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925541; x=1783530341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RvMe6A/UgVrym2bRYUnF2aCflCH0pJThY0gdvMKUcgc=;
        b=r8k5LAvWPKZXgOHilHmayAUZIdwKMjrNbLnuiKSaVymuwTvN6gQYwwJbTfTO5HhGxt
         8FI+2zdgEOP+o74p71AovHg84tF7n2IqtxhLSAEKYBmtYwVOX0LAyiCLu5dnGRQTbb1c
         LMjAj7a3nIMaqsSNYlmI4bfPtzrQ0EcWk2a4xQLDq2Ftw6jvbSEG0EsqfRcCtTQ36TXs
         79DZVs/zJ8d3lfVS0gJDK6tpqf5ljYWdOlwrH1vIx1ZzZ9Ah8Dx0yKZzKxFs0IVhXdoO
         H21VZrEudSTdeOjGU2aJ87FWtS0pkOW8wDkYDKkh7UGdc5CASFdnnLt8mTk4Re8s40ps
         nF/A==
X-Gm-Message-State: AOJu0Ywv+B5llk/oXw2MLdfgwyW3S6NBs09uVp9MrrY4/+c+TuSAwzjd
	rvFhIhoUuZojhYR4H6uMjc8kD6i6aEmqfzYN15D+92sOnE3MESHhxzLa5UdAT03vY7c=
X-Gm-Gg: AfdE7ckvhPUtPWCz+PCToltNT2HZihFQVqsA8gfnlzqjtvyzV/VCYIRkjmIY/maw7sp
	xvcKJIURFqK19+b71xGfECohlpg+YN62rIkIgasPl0nLzt08auPpXz2W2SSKHKJGGzGHL5DonXF
	bNBRSNLU0WAuXjkyZHaj7l+EJx0P3Xno4Gr9Zo0nRHg6TjsfTfz5Blsr48QsclLmzn8DpI9Cj57
	m91fqtWjaXIgYOn2DQ+XCN3qft5D/ZJBQMDG1DYPbUGOc2d2vU6xc3ERJjmFuJ2jOlkUPtRO1wE
	la6FBliBMKGpZBkq4IOrLHWVPQHZJnB2EcvhakkiCn9dvF9tKxgq7IcZ8Pu+Mpvnwx4b96j4jII
	VolGH/5q9no/mVoMeiF6pCESM9uTpUIYuH5sGC9Ubtczo88MSvcKFAesgKegCvMQwqzLlddDecN
	GGtjd3kt9rq+fXzdrFwP/06BLgbiZaB6BLuOiBk3xxP3goASG6xM+tt+JVdQIY3TtCkrGbNLHmc
	3ma
X-Received: by 2002:a05:6000:25e3:b0:475:f0f0:9eec with SMTP id ffacd0b85a97d-4775ac9f5a1mr3984906f8f.49.1782925541284;
        Wed, 01 Jul 2026 10:05:41 -0700 (PDT)
Received: from localhost (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-477db3dbb79sm1334344f8f.2.2026.07.01.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:05:40 -0700 (PDT)
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
Subject: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
Date: Wed,  1 Jul 2026 19:05:21 +0200
Message-ID:  <8a85b5f4a5ed8ec35b5a213423d4be40e34f9cb9.1782925276.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fUoDHGx0vIkRkk7bgRX+e2vp2YXY3RA6x0vlWQS8YwE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjWB9MX8EzJiYV20ypG8q4ZDwRP5fPJyrHEQ K+R6HWFg9aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVI1gAKCRCPgPtYfRL+ TsuzB/wLTW0/yBRqnX/rTnGSm2/wzLrOc1svn/RdtcUCCJqJJzoUpA0vstagpmv7W4YnUc9LGd7 Hau4gP9XyAG8CPZKqFmp+oQTm88dXMrM/Qjy2OTvns3CA19E4DqZNQ9vL33gsAYJPvh79+snr9a hbVrK5asZIuftv9GiRBDYxyVZuWmHYGVNoxzNzFDS7H0g9mj9JQ58eKQrcUv2JLhZ+in6mkw6Nu CHi+E21bFzIKBdKj/f9njge+6nU66Q84o1QQgggkaonc3bkrMrnpn/e5/g3SkIp0zgtKjWTDY/l s4tpFj4e/dCWYBnwFf0z8eWtcYT5921cDp+PtzW7bwr5p2LT
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-11724-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: E2D7E6F0382

Having an empty remove callback is equivalent to no remove callback.
(The only minor difference is that with an empty remove callback
pm_runtime_get_sync() and pm_runtime_put_noidle() are called.)

Drop this useless function.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index e766d87b7a9d..e3f41336a831 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -45,10 +45,6 @@ static int hv_drm_pci_probe(struct pci_dev *pdev,
 	return 0;
 }
 
-static void hv_drm_pci_remove(struct pci_dev *pdev)
-{
-}
-
 static const struct pci_device_id hv_drm_pci_tbl[] = {
 	{
 		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
@@ -64,7 +60,6 @@ static struct pci_driver hv_drm_pci_driver = {
 	.name =		KBUILD_MODNAME,
 	.id_table =	hv_drm_pci_tbl,
 	.probe =	hv_drm_pci_probe,
-	.remove =	hv_drm_pci_remove,
 };
 
 static int hv_drm_setup_vram(struct hv_drm_device *hv,
-- 
2.55.0.11.g153666a7d9bb


