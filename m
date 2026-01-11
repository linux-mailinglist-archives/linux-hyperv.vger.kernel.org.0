Return-Path: <linux-hyperv+bounces-8215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A396CD0F79B
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 18:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2671E30381BD
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7A7261C;
	Sun, 11 Jan 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUq8J65M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4B500963
	for <linux-hyperv@vger.kernel.org>; Sun, 11 Jan 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768150846; cv=none; b=Vdg7LhHQWl68kE+27vf7cjnyX/TdYsbiTYl2DZXJ1JTygeop28Cn8dpByfM3KHG/blIUDVO7oULxUQMmSlYIoGihu7Z6XsPRODDB8e8kXeljYqkSjkFd4k1Fdu4eCOFwAqjIdmC7jtSSTZ9EGJB6sm9Pu+zbrrQlEVUkjLHy+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768150846; c=relaxed/simple;
	bh=hRpSrENs+exAzLmmyDR9z10zgMQx/BnRWTtqM7vZG+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REv5y7piGY9RbHYoKLrio5f64a4VsWLf8LriOK+AB2I3UfrP7sg5S0Ghoz1yejF/hPuKO8FjLYRiB580IrY9SojA41nB+1lEGEP6WhSujnyS70uBxzwUIAQtLQq7NlLYeEyJdkKEGoZZKlEtVzgMJG9y6xnAIqH/LdKn2Qx99Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUq8J65M; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso5437328a91.3
        for <linux-hyperv@vger.kernel.org>; Sun, 11 Jan 2026 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768150845; x=1768755645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kjR6vJVSaNEP/K31+so/7gi81I0rHPjTD6YqT7uJyY=;
        b=TUq8J65MimOKt5h/a2F+ggaiFTL0YBloJ6YFScfTLef+x1Rk+QZs2u4n8aIWkxLFXz
         2Cfa5tGcR7HGXUkEZzl8ahC9zI+NrbuDZNbO/5jV2illBLNZsFazvYyvBHA7H6mjiT6O
         9NTM/gRhB2B+Qf+I+eEtpmSugFhHUUyouVKLDxBpx81qCVwqLCzr/V5Op5hHMpyZ2zWS
         fALrJe8jKaq/0eCkrmO1PoiUvn/sqd3vFXDkJVqWab1J69wEe1E/jQXjGujLKWFi4tk5
         WMuxmKOaSGX7zgawm2NgnTadXs1eJCmueYtBY/KdpKHmhpJNtn4F/oq0CZtqY3nKuJd4
         JX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768150845; x=1768755645;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6kjR6vJVSaNEP/K31+so/7gi81I0rHPjTD6YqT7uJyY=;
        b=keqjlmseGj2ONqdHT+3dAtz3bRSYZm49SA7Xs+Pg9BsJouJ8l80UefzTwxnn8Z34uH
         jszKJFxmsSaUMTEvrj+xLPwUDQtEdlb4vUxKJNGPd1aw/quq/Kjgw8Hom3VnmCQKm0iR
         KCO3a9bWdfSJ9I8jOzXevm3nClaq5ru/cWy35/uw5X0sUyt67z2lD6py4vPirJA7Jdv5
         dASiX8J65yHEzOp9s00RFlKKbymz/SFuFc2lCWqzx5sUa/QxEF2wGRrdW43VM+kMDbek
         X+4gfdZrbmn8nC0EP4/FA+F/hS0LMUCk4CuhKQeFBO23LrGEZrlDSeSzbkO/4ECFtr3M
         uitw==
X-Forwarded-Encrypted: i=1; AJvYcCV/vMUG/BHFa7O0K+V9aFUA3JRqrWZAc85mZteuVy6AWUWv+JYAOuNOri1+S1weMd+aVa6N2X2knRKNQcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXP46nChnbneXA6rJsfLe3tHwFlqRCAMsaAIcbwD0UH4DhoA/
	r+aSCvFmvBrZCCGa0ai0BpM/L20opkvIgVzqeF9tPVeJ/SgcdGRpPFvxQREn5a6J
X-Gm-Gg: AY/fxX4fy+nE+4DQ1Db/sBWAUGie+pJ0DeUrp0oUJx6Rhg+VVUSXkBZz6M9e8lG5Z7I
	df10rcYqAvgLsfNBDwILG15wt05YjHbpCEaLlkTDy5JTzHDGSSLfsRXA8Y4vuquMbZm/MQX1NBa
	WqilwKxExLIkOpzh0ilsOpFkLJdmTgnZ2CCVxeFp0jH2cYajAM4iNUoDt/TVyKdDgpFQ8EQo4d0
	RnR/CF+b7q3BFD/H+qmj1fXEDAtQlyQO4WiTinejCz5+YPUGzPLpDoZZGFYIQ9kRZ2c/R1mjWaG
	xXy0JjORTVDnMV9v4oVCz4cekXbfi5nB9MJDRA2TKuVGY9IcnopIOCYS3giITi4X18B/eChxNKp
	3kvalnJrTYajRbbSmvcPWEk6MKjg1fnqlRc5tmu27JDACIVDuJ7MSmk/kamh+cMc14v5GqzKmE7
	zE9ny0wreWrJY4l7TqCpQysJU1BewQz3ekq3GzdFu1WBZRgpodaIVZTsEJAupfTG1sKg==
X-Google-Smtp-Source: AGHT+IFt0ORucE5sJv3IM0mkDwpWDLSo+rRqQTXeM/xgroPRzc2ArLXkenT9yyjgZva8oiZUDVKi9A==
X-Received: by 2002:a17:903:298b:b0:2a0:d5bf:b271 with SMTP id d9443c01a7336-2a3ee486f81mr144561425ad.32.1768150844710;
        Sun, 11 Jan 2026 09:00:44 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a507sm150677795ad.3.2026.01.11.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:00:44 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct hv_pcibus_device
Date: Sun, 11 Jan 2026 09:00:34 -0800
Message-Id: <20260111170034.67558-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Field pci_bus in struct hv_pcibus_device is unused since
commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/pci/controller/pci-hyperv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1e237d3538f9..7fcba05cec30 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -501,7 +501,6 @@ struct hv_pcibus_device {
 	struct resource *low_mmio_res;
 	struct resource *high_mmio_res;
 	struct completion *survey_event;
-	struct pci_bus *pci_bus;
 	spinlock_t config_lock;	/* Avoid two threads writing index page */
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
-- 
2.25.1


