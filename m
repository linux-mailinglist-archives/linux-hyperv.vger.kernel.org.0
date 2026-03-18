Return-Path: <linux-hyperv+bounces-9528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMc3AvDJumm6bwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9528-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 16:51:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B92BEA08
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 873F43105B07
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAE3B7B76;
	Wed, 18 Mar 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYIVxUZr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1D3358D6
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848463; cv=none; b=ZHpKJIknYXUjZIvy49C75BJC8ZBlCAan0OPaWIAMbQ3WyYnzM+EWrLJ1uMPpvI2jrnDbNrZ+4Bji7RkuWBSseNR/K6YbaWuCAVrxpKlC5TvsfPYg13IAcIuNL5zJeKo5EtqaJP0U227htTMD7z9my//RsUN8t3Q7Y0j9TUhemv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848463; c=relaxed/simple;
	bh=KxCg9HM2B8Sqb5kfUOUvgEPx1OUj+gKVqH0z2u8OunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIHmU30t5rskOfIA/9+LMYBDcDwDYuwDyRXIV44tWbAz3cBDcygcfuEdP20kHtq4RwLOsEo7UQ+h0hcBaCqbc8lkCHlZLwvhM9EXxjuyn/oyW441GIAmPJuKyOEwY/GNOaiJ4a5frWde05Tsbpl0kNCBQIjLfVpsvjBbUbRanWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYIVxUZr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04fc8851cso41222935ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2026 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773848459; x=1774453259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9y+pNa6bjnkhcSISFIIKI60hKR4+nSBy2ZBJr+2i9Is=;
        b=bYIVxUZr09EzR3Cu7oZttNU4TSOCLtAOzoOtqE8W3vUUxi62s39Qd/lpcHaD0mh3b7
         evw3Y6erkX+UeuFiUVaDISglwS1NByfWCmJgGAIJt/tVyHEwXfiI79d2gKYQCAGlYLQS
         0U9Pgy8TYXesYyT4H11l+/TVFofs2oL6QYKHjQS8hrYWUqSgK4JXm1xp6wquZlyOuAqf
         Ntqj1HTwfVRGWSp92cu9aggcGfhoA3jx73hKVGGrlLEV0CspkjzEsr4B6MOthohDQyTG
         oMSVTmrRStg2Ph9I9M3WlVbVQs19rdKjOT8FGV3QNJeaWEBUxPaqyRwZSAgUcdYEIln7
         KYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848459; x=1774453259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y+pNa6bjnkhcSISFIIKI60hKR4+nSBy2ZBJr+2i9Is=;
        b=POb1YegqXZVmcBa6Fm8GxFdDWhdzLbE8/4dgmqFsFLZrEnxh0uxKm+uJGXphrwx+B8
         wRk3T2fufBWK4/i86QmPATAsvWrKxVxBj8OnXbfh5qtBarPJbNrGaxhM3PoUYgKLM5Pl
         w8iAoiVO3CiK37xciKQgB45ra2tkieaIHCfZeZvU6Mi/kBqH3tv73eCHngXcq6Hcocyt
         SbRnVIW2iqbmLGqXLLyV9rJyJIXWNJSL/UHAjh5NXxYZozBi364WYJOR2G8L2bpEqLo3
         oUSMuvq4Le+Tmn0nmuEiv79TG1H79ncmmAP5b6BbG8pxSNilFyZnFZfvSXJcQOrf1cgu
         0VTA==
X-Forwarded-Encrypted: i=1; AJvYcCVS+1/nLK264uZdjgPxxi1MRsENRl+6Yju/vZtGeVe6TBQtbAYC9n3wu9821zpOemhPn37yOnmFWrwNQlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5X3RZ4+/x2czxJXYlOoGvC8iWPExWKNjhIzjoRDbxfVaaUow
	2ceeJx03xnTpVsHYdtL9FeB46tUGLnPRQ7HHYt9e7f+a38EOoEdrbYfd
X-Gm-Gg: ATEYQzwJUOIpAkviodNGhatAqtRJiOGDl31Yg+PZpPD6oIhcx51GdJGKq2fSC6CqYgS
	X76DsKz9SM8cchO59EResRnpO4EgSaDRiXaBq9wqZwMaxtQ1gmlorkpSBpLBoKMBDcFhpsYlcxf
	AdYIslTKJFYhEcIiBhgcuPwFkXEmIAsRoUc4Gw7xrRe1xYWnQ26d9P0NNJTMk/hRFJINnTmkBpZ
	JpMKa62J0GHCkmKMZyWapi/6SDpOTFbWvvWIX3l3W+WegIxskpkjC+ji7C7u4nEnB+zJHDGLZDo
	DOR7rTtAHsLQL90DVJ2HIrSYMmdgUdWTrZ6Y3T+Fd4IqtUE8tA6Deod2OZaiGn9btnPXhlRGZNl
	jL4tLMYPMUxocSvZrDbYG+dhwMYXcTapILdcw7FgcoYM0aL7xUuPUgZAm/gBlMsLyJBYr9VSwpY
	EFwShyLoguAxiXwg==
X-Received: by 2002:a17:903:2f0c:b0:2ae:4847:cace with SMTP id d9443c01a7336-2b06e3ca490mr40674705ad.28.1773848459371;
        Wed, 18 Mar 2026 08:40:59 -0700 (PDT)
Received: from lgs.. ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e431c1asm31772365ad.24.2026.03.18.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:40:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: mana: fix use-after-free in add_adev() error path
Date: Wed, 18 Mar 2026 23:40:41 +0800
Message-ID: <20260318154041.638747-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-9528-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.852];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D0B92BEA08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, add_adev() calls
auxiliary_device_uninit(adev), whose release callback adev_release()
frees the containing struct mana_adev.

The current error path then falls through to init_fail and accesses
adev->id. Since adev is embedded in struct mana_adev, this may lead
to a use-after-free.

Fix it by storing the allocated auxiliary device id in a local
variable and using that saved id in the cleanup path after
auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..70d71594c599 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3362,6 +3362,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 {
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
+	int id;
 	int ret;
 
 	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
@@ -3372,7 +3373,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
@@ -3398,7 +3400,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);
-- 
2.43.0


