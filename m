Return-Path: <linux-hyperv+bounces-2456-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488BA910FEA
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03740284BFA
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405471BF337;
	Thu, 20 Jun 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVupu5/H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD051BF32D;
	Thu, 20 Jun 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906271; cv=none; b=VawZVzNUnDZroT4cPLSwEnO6Y07CMrqxkxrgL1ivB6Vl2jWhPjzMswD9BJhvS5VLooaA73myia/S2KbMMzF13qOt97SkghNuJt5kJQJe9BYCDuRs3GiN4DTvmO0vBGRzZlBZWkodh/WM+sHaIC1Rufs1vxxCWAoySlO8Xtq1Ty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906271; c=relaxed/simple;
	bh=XG2GU2+zFp405uZad/oPORvyyKH9S5jaQ4HWX9leIiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e15OaC6HtrEaW3QgA147Hp9EqWydEZ17nNc0HG167Mv8f5kwdeFOhRysqDafBxl6Wr6O+ByLclOvmjKkrQsOzlataXbRL3bxmFdsYbAFO4v7Nl1xCxcQwjyemHWwaiOsuaXvmF3pIaVIcjgXviyRHP5Gz6m/e231lmpC2nuh04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVupu5/H; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so1044678a91.3;
        Thu, 20 Jun 2024 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906269; x=1719511069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh6DBCUzBIXsYTBDCp5GIVtLCP64sJqenVlYmZsGDjI=;
        b=hVupu5/H5+dZneVBgBWN4KCPLGzYbfc6+CEbUbh0rNl9ajM2oNoots6DCrchcKm7mr
         VDFEcXh4pqAsxRpcqdcunlL9V02dKuBwtKmuWwLRt5d0RCX4UMFjZ7zL2ajQZKl7R3Ks
         zkbrbL41U+sL+FraDGlNuWjFNbFVY2d59Rbvv30iRzD4Y2gWoTJNcPgUaJnagYio8rbC
         J/fQyMVbWOmu1MYbJuYQJyj9rOb3QfIgvM4pK4Lt3ssdQrkjWUVSxOaCdrvwXeQhTucr
         Ajit/NsdNIR1oVVdAn3TYZvF92lAJmjk0V2R7T+KSl4Lb6qlint5m8d1IZFpuryzF0a3
         sJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906269; x=1719511069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh6DBCUzBIXsYTBDCp5GIVtLCP64sJqenVlYmZsGDjI=;
        b=FjfvfT6swsg30ptzVgygZqko0kwWjukO2+7lbpcDTEteRCanntocZZIAgsXCrCeBEp
         GMz7vefABQYYg0itcK9suBZQKS6YJ5YJKfIOeNBUDJTnLtYIM1GhOcH2hVNGuPutyZna
         ydIsv2r1vbZMv2Dlc4GO5pXpASfmayF1+E7n8D2KVsA8R6loIKNPeJcoUVRGTzLob6n0
         lZLLMbD3Ka6nmmViuDiUe442Mk0rA9kLpRNbwNAjjP0qkx5P7orz8/R03aS82t35a6w4
         xZkYOugBtDSy82tudfeRunraDisRqXXClqhtoVoK6JI6vjlLLc+JY+5HCQF0q33HUnNn
         1ZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVksFpp5i3t8egpWEroYU2QOGq/1kO3uPiQuc46+wyfcyFclwM9gGqb22be1aNB+rm+0ei9YJoHhAAdveBuQgmh/xIIVwBO02BdIE+htx75ycj0PkzqI3+26VsrFT86lALPbF78d5Vw
X-Gm-Message-State: AOJu0Yz5TETUKK4RYpvtel4hO2LdWPXHRasus1/JLVc7d1Jd6zrT5qaR
	l+Ye95o/1Bjqf/0DA1qiigQ2ks3P6uvrQTAt3oNrBgP5+pg0j5NH+BFytqUzN0o=
X-Google-Smtp-Source: AGHT+IG83Pia9Bm6gkce/miVZL5B0kwBeKxwmNQd+rjCKpzPOZ8JsfwHh5KI+bHzYlygVmWjL4TSuQ==
X-Received: by 2002:a17:90a:d58a:b0:2c7:c6a1:42d9 with SMTP id 98e67ed59e1d1-2c7c6a144d7mr4361713a91.49.1718906269090;
        Thu, 20 Jun 2024 10:57:49 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e58d041dsm1993578a91.38.2024.06.20.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:48 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v4 14/40] PCI: hv: Optimize hv_get_dom_num() by using find_and_set_bit()
Date: Thu, 20 Jun 2024 10:56:37 -0700
Message-ID: <20240620175703.605111-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function traverses bitmap with for_each_clear_bit() just to allocate
a bit atomically. Simplify it by using dedicated find_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-hyperv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..d8a3ca9a7378 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -37,6 +37,7 @@
  * the PCI back-end driver in Hyper-V.
  */
 
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -3599,12 +3600,9 @@ static u16 hv_get_dom_num(u16 dom)
 	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
 		return dom;
 
-	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
-		if (test_and_set_bit(i, hvpci_dom_map) == 0)
-			return i;
-	}
+	i = find_and_set_bit(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
 
-	return HVPCI_DOM_INVALID;
+	return i < HVPCI_DOM_MAP_SIZE ? i : HVPCI_DOM_INVALID;
 }
 
 /**
-- 
2.43.0


