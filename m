Return-Path: <linux-hyperv+bounces-1509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB65848F60
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Feb 2024 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D75EB22568
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Feb 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6610249F0;
	Sun,  4 Feb 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="h50To4vN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215C249EF;
	Sun,  4 Feb 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064657; cv=none; b=GEcq9lT0eYTzHhXwenJryYFyOp0WS3FvIN3bBlCTjDTtWu+ovfceE8k7ZWrccYAPyga/rtEdgZInOind4TPhkkDcNm5WnUXcGlTqApysCNjwPSRdZ/Lr6YjKrG7KhjPnGyX4ySkGNAVUILz1Db2Mjkv3VrpJGBo9sKzwF+sdW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064657; c=relaxed/simple;
	bh=3G6GdpQvGcMU6GrYP4m78WRclDepncCFqt0pc6FRrO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qWTm37sx6P0eCitBNBW1ieWeilViC1g78FvAfftQ1UbmGPuGAUKli4FAoYcvFtE2M1OaEUL/DGlaoXpUpHnrTDQLzCwsXHbU9j7U6fIEByqWddttgzXopW+d7wxAXw1L9SSI0pZD7tn2YTvTIPmOEUQv1+qmHrMELJiwkJx6354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=h50To4vN reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2965b7bcc89so804188a91.3;
        Sun, 04 Feb 2024 08:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707064655; x=1707669455;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ0lEvjdmBFBNPHoZy7QFocIylJbISzcWHhdTatUO5I=;
        b=muXE7Loid/nfUME1sgn3xezKHMdsdcttNexFHHEVP9SZfvGC2J3EKSO5zGlA7e4YJd
         LaccGmA5vrpEIq0cfKJ6Cp4MdCBAsBe4Zq8lN7eLXbzlpOwEHfFTtYoHnTQM5S7BV4Ur
         oCuQ3Xn1YV5xJObR9B9UNs2rnq3w3vWUQN/PSWB0k7hMjmtAq+L40zxU9GxxrEKJcSyM
         AdAPxwNdvAaH7Fuuiq0KFLSxoVf9VwO2+RrkRrgqdYq5qZwaMWKcQXfja8jiGGjaXqfa
         aqHn3gbuiVSZZnJG5Y4g+DDoGnaFwDuMIXQWjT/SNuizbyg2VpIN7q/BpdYjc4IVoZrU
         PXdQ==
X-Gm-Message-State: AOJu0Yzp5IueKQlg13aq62Dc3xWT5v46dbchhszgOv1xApPXi9S8OMf+
	Q6Kci9RHyKtbi/rYHr+jmWmCS39U2kk3U7b1gaNuhjFhfxMcVhYB
X-Google-Smtp-Source: AGHT+IF6sriXiSq3rscsCsCBQ2mdGsuU0bUMVJxN8UYdjmVJDjsKInpE6VzDlxp/QjpjQZ7Cnyp//g==
X-Received: by 2002:a17:90a:d103:b0:295:eaff:78f3 with SMTP id l3-20020a17090ad10300b00295eaff78f3mr11979622pju.8.1707064655354;
        Sun, 04 Feb 2024 08:37:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMZV3Sv+lJKSbk1Qk+EFdVZFi/j9IchwiaK+++go0DkJuFpAeev1njNimjxq6aGAhSNjSXVDkpObQAfXcOcl9D51q1raw+PlbEIMbBDUnTZLKEBHuNrRdOaZZ3Z34xWpGxL+xGkTguTQqGlWxGw3wk5lU03sfq109rUuzEGaaZv6aSUxLOSiEQnhNd3jo1Qz6NGcKARLePFZSJ1TkYChkjuO7csjZ+NJRz
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090ac89000b00290f9e8b4f9sm3416585pjt.46.2024.02.04.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:37:34 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707064653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJ0lEvjdmBFBNPHoZy7QFocIylJbISzcWHhdTatUO5I=;
	b=h50To4vNneCIKOuEO/8D/efzkZvX7cBRhHkLp7C8RGpS0IQMsXlr6KH76Z2PKBODl1T/K2
	ro/SfR2HyhbWpRRGt8qyw/SlM70y8VcdDoXqtq5iCqLd3QsI1ps1mbM8Xnia3zNKeoaTAI
	Ikbe8ap8DoKC+Jz49SxTCEMVQLKUh4kXciZbNwk5inueJwa4TUScdrAs+qTL4I3R19qaGl
	4jJL11M97Eci8rbvDJ0oukb/99TuutthN3N1Cx+ArNruotAEuu9d/T+/klvsN4y3SEU1hT
	ZsaRA8EB2xi1k1anBokWqcXjGFS0kVp+/VicOyDHj+Dh6RevyghoIGPzlq5QJA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:38:02 -0300
Subject: [PATCH] hv: vmbus: make hv_bus const
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGm9v2UC/x3MQQqAIBBA0avIrBPMJKKrRITalANhoiiBdPek5
 Vv8XyFhJEwwswoRCyW6fUPfMbBO+xM57c0ghVRCCsVNTpu9UPscuCtcWj1pNYoBjYUWhYgHPf9
 wWd/3A6Cl7SVgAAAA
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=3G6GdpQvGcMU6GrYP4m78WRclDepncCFqt0pc6FRrO0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv71sGx29pojSTD9LZBXjDM1C4KQaFPoMXD6q9
 t+k2ay1NdyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+9bAAKCRDJC4p8Y4ZY
 ptL7D/4nVxnScbzNdjn9HV6sMToBG3S5ebYXmH6WapZnzOsR1+R/Hhn3zZ9ZLFnjXLs8BYbRb0c
 fverS72RS8knP9yhr0hJE4uu9+jJrUha9jNnAljcMBN08qbhVSGFlBNBiZRzXFCfqm5iWDT7Jd2
 R4hdnzrKS+fOK2enHGqJ24LItGKD/9VQXEnK0ZzlgP/TlFSXkWzv0cxmmQAqD4uNT30tqOWeQlH
 GDgyf28PrcGyw/OWoP6Ve663qJLbeN0VWjDY99iOiVuHsqpjO7VNIWZ+OHE0rQXtZUGkUl8lDEx
 G4ekb8j7X98g7Z9N34MLAFwsUxqFImQ+WTl3s/ow7tdDGOs/STM//FxsJ5YfXYQiLOpoxIJPzFD
 MpN/Lf55AQFcPWgp3R2tnuKEFP17jZGy0AVUMQ/xI6z/D3i64gEFtN6tDcEvTqv9ujVZleH+w+f
 m1itQEz9oPt/+TUD8oAKZAzpZEnki60pATdNC/eGWKB/LpW4RqMpAgbNXn2+e9/XuFrk4iPxVeq
 CkQQ3FDiXTV9oSu0IskWDpe6sotzyRvTjSvdd+RZCv8bpFAROfwvxJYDakvJD7u606DnRuy5EBn
 IYWbiQFYeYByadiZl5rGsavmqJ5qR7zYLTQClC18PJIocezWhu3cTMiXL2G7vPKzMyqJ4NMyLbT
 SuKZNoQWaQbjm0Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the hv_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index edbb38f6956b..c4e6d9f1b510 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -988,7 +988,7 @@ static const struct dev_pm_ops vmbus_pm = {
 };
 
 /* The one and only one */
-static struct bus_type  hv_bus = {
+static const struct bus_type  hv_bus = {
 	.name =		"vmbus",
 	.match =		vmbus_match,
 	.shutdown =		vmbus_shutdown,

---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20240204-bus_cleanup-hv-2ca8a4603ebc

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


