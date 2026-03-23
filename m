Return-Path: <linux-hyperv+bounces-9697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIBIEGx2wWkQTQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9697-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 18:20:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C52F9BFB
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FE3230C2568
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4C3C2798;
	Mon, 23 Mar 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6gMHxuI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D53BD22E
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Mar 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285072; cv=none; b=JK4Yc3pWh7M+p2hors4rekKUGTruyJQen/JaLAGiVKFlKoqxe/5G1H27sqhIDqgoHS3VFUYZ/3ZeDGE2JCTD56qWTae1T5TEuREftfHlVJDfM8Grz62nV1edCh/gonGEUQUfXein335pcGgabnDVmRb/T4/RLB/hrswamd6Rs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285072; c=relaxed/simple;
	bh=HaKS3N/t/8+2h/Pc8TJ2Vb22p+n4if8KpkCVDIHQAXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rxyru+ndD/403O3+JYejviqsugAhIUJXk9rxJws0tfKnqIHe+gnMCkh40esJfDxEIQ+Canq/u7O92hmGcNRkIXw8MYUlmnuXxXUtsHYYFnVhax8bCjHT+s1AxZUdCRpXDdYntPfx4LFMsJc1QNvtQU6WVuuCBQj/pcbu4geedh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6gMHxuI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358ed696623so1437769a91.0
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Mar 2026 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285070; x=1774889870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZEofwQC58MPpqn9prf+xK4zUFx1LJf9Y6fgKZotzZc=;
        b=W6gMHxuINpmkk1y+5VslwAOuEjlg+NwOK1UUVjsCllKPuEMXqzhUzVruKjme8dM2Yo
         rFgEl2mCNsCHA2Uu0Dvi61vuKaxQvI9GPgWi8LuCBIAZMcYlkHOdZPuSGXVlUkX3xgjp
         7qAwF0/jUACCQ98tU/HRb0UFLOtLxCIWg4M/0Ucxw5IqrJtXpniZB+fT/Ja/SssbIGRB
         b5RZF6Cay1HyKNELdvYQfR40MWxHwKzSAojPTAla6XvZBL0a3Ob7HFMJ0nRE688UF8T/
         s6uLlt8ccaK4fvxjGxBpRkcs2ILreI6mzv34nBNMNMUxKy7dATRVq2w8MsZsxr3f4gp0
         ShdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285070; x=1774889870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZEofwQC58MPpqn9prf+xK4zUFx1LJf9Y6fgKZotzZc=;
        b=LoxX6rNYixX5/NkTRunfMvwWVwwFH8GyzphYOvMsh/U8wKu57oH4eI1pnhUq0dxcZk
         MZfZk8aQk/u1PRXGVrTG7qPjEw2mCJWYXplbuFzIp7JAaoJrFLGsXxWMvbSfsvqfki5l
         Sv1SPfQTvpRU1YpY5fPN4kEaF45x1hb0/Xa+vH+CfZoaVHV0DlKyKbbngFAOea2xTYrR
         pOCYiRjkBHGDtRfp3+hRGKAl3Qro5RJpqWWhPI9yEojdgx8ftC5XdE/Jrvf4J1G5AnCY
         h3xYPKI5cUE7G0AU3uZZo/CYP0ckz6LPqwbTyuXyb+0b+WR4H/w9KdxRoQsqgjIviHin
         m4zg==
X-Forwarded-Encrypted: i=1; AJvYcCWjjjKYmfOE9GfeueClcOdQRgAGsMESuJCGuE+9WAX6UaIn3/3kVG9uGQ/i0ftOgkZTnpvpadPj57sUsKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmiPUwykgpZuTVwEVnyqoJWNgpCstiHCx7bMuFmdUhQPfHMF+3
	XvO/MPnVcubujH4XQjEelt/m+7mtScBH9gbVVj2o8hgsYqP0v3xNaFjQ
X-Gm-Gg: ATEYQzwoOu3AR6teOHnd2/dreBbboSDfegMg1MjZbzTVcSzOKSleWLv2zz1qkKlvGbQ
	eQtOLWLKYRHHUzIzvsG7ijZ2Lf72a4B97dceWC8ECLdk0SU6uclR+l5W/q/4FoF55azTdjh6M0A
	UIufn80X7RhKPQBRUaGeATTKq9aasVTAGfKx9aNHx9meYNg1Qe9SAQOl5/khZIhy9ec3fMousns
	XiCgPvjUMJC7UM42wvLeyczqm9864kwOwg9EvGM5XyVeciv9sRiI4IDYjGgYh8W2OGs3AYmOxnY
	3vDbXp5J5TOC++1Le9zdkwYGIB+igigWFZc165Ds/2YqilwKBSjfR5vRqhMGzC/BVyUHCkz1XxL
	+8Bu5VbfkY+GW57aT96L0gZwWsPf6fr2pzFlvTmRII0k1uKAshASo89uEJT8r9Gl4dQ41D8bAjt
	uG/9xpW0S6fH1Q5Dw=
X-Received: by 2002:a17:90b:4a50:b0:359:fc88:fa99 with SMTP id 98e67ed59e1d1-35bd2d39c11mr10734530a91.26.1774285069752;
        Mon, 23 Mar 2026 09:57:49 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4109c3bsm10185767a91.13.2026.03.23.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:57:49 -0700 (PDT)
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
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PPATCH net v3] net: mana: fix use-after-free in add_adev() error path
Date: Tue, 24 Mar 2026 00:57:30 +0800
Message-ID: <20260323165730.945365-1-lgs201920130244@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9697-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DC8C52F9BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
auxiliary_device_uninit(adev).

The auxiliary device has its release callback set to adev_release(),
which frees the containing struct mana_adev. Since adev is embedded in
struct mana_adev, the subsequent fall-through to init_fail and access
to adev->id may result in a use-after-free.

Fix this by saving the allocated auxiliary device id in a local
variable before calling auxiliary_device_add(), and use that saved id
in the cleanup path after auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - explain the UAF in more detail
  - retarget to net
  - preserve reverse xmas tree order for local variables

v3:
  - rebase onto the current net tree

 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9017e806ecda..d03f42245ab8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3424,6 +3424,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 {
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
+	int id;
 	int ret;
 
 	madev = kzalloc_obj(*madev);
@@ -3434,7 +3435,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
@@ -3460,7 +3462,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);
-- 
2.43.0


