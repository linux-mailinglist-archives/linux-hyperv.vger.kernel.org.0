Return-Path: <linux-hyperv+bounces-578-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E297D4ECC
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Oct 2023 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F2E1C203DC
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Oct 2023 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216D2628D;
	Tue, 24 Oct 2023 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njhyf1s/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454D23A7
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Oct 2023 11:28:49 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA74128;
	Tue, 24 Oct 2023 04:28:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9d132d92cso8264295ad.0;
        Tue, 24 Oct 2023 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698146927; x=1698751727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CX4+doENGmNchlwWpwv+1yjRTi3YVh0wXhBLOXVVrzE=;
        b=Njhyf1s/QWkeaHdK34rzxZqNZRX8tFKGfAjLGyfwmMr+KpKVhSuYdcNr09hhREN+s2
         DFczBtQIiblfsteU8dK9aHdJA6CjBFMgDbeXCz7CCqItxh2epYk45VW+2RiaY6MPJztl
         z+Dp1OjasT6WTc9BeAILGRI2khHOcBP3bXN0pUAKakW+rOtnKuh6sgZbrF6UDkngrOmK
         3GT44PJtAJ1KRye5uSJziKdy+xQDO8PqGo7Ws+cVTII6lGg80Wbyqmxr/tRBY3oMy1rS
         X4SscLmNyAwsJK2YkYz4DMoSoJ9E0GXcAdwgqox0rHly9nDmnJAygj+iRdrnwtb+AbVM
         sEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698146927; x=1698751727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX4+doENGmNchlwWpwv+1yjRTi3YVh0wXhBLOXVVrzE=;
        b=ZWDqFVjAK9OBS1PEEU2CSS1r2jAYXSVCHAyfQUm24hhqeBYOSqsIWPwiTK9tEIYXhh
         9i+1zb/e4o838/h+RSyl++JZRpNL4V9e5eMmxKeojb4f3CXhoLWnNJoemZcGGUFSk726
         q1eSdnSAOBD8z0p5RPfPh3IB4xREDIsdOzDs0RFtw2NALLcNOWOZo/4K2tikIiUDcIhi
         /RWwtyZhKzBpYgYMuynFgJ0ETV7bnP1VgBCjkQNROJjMzpI+yMpE5215mMX3zkxewvUo
         qtNYb3XLPLI4XucvjuWoN4fN038OEeAKo1GRs56b/Y9glWVILDwBRwr70dMH7JGeQ4pV
         nGQA==
X-Gm-Message-State: AOJu0YxkQDPVAy3RhXyWprjPIkTX5+HrJiZLWKlOSy09t+xlQXg90msP
	OMJcloHQKu6vPMBTNQoOTsw=
X-Google-Smtp-Source: AGHT+IHnUt4lOv0br/JRsZPJbyPC+wE41o4TMvkk1en97kacjTGvMMNuo1FHRQVaytnmZikbIAVbCw==
X-Received: by 2002:a17:902:dac6:b0:1c1:fbec:bc3f with SMTP id q6-20020a170902dac600b001c1fbecbc3fmr11428938plx.5.1698146927571;
        Tue, 24 Oct 2023 04:28:47 -0700 (PDT)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090311cd00b001b7f40a8959sm7219640plh.76.2023.10.24.04.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:28:47 -0700 (PDT)
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] Fixing warning cast removes address space '__iomem' of expression
Date: Tue, 24 Oct 2023 16:58:32 +0530
Message-Id: <20231024112832.737832-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes sparse complaining about the removal of __iomem address
space when casting the return value of this function ioremap_cache(...)
from `void __ioremap*` to `void*`.

I think there are two way of fixing it, first one is changing the
datatype of variable `ghcb_va` from `void*` to `void __iomem*` . 
Second way of fixing it is using the memremap(...) which is 
done in this patch.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 21556ad87f4b..c14161add274 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -70,7 +70,7 @@ static int hyperv_init_ghcb(void)
 
 	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 	ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
-	ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+	ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB);
 	if (!ghcb_va)
 		return -ENOMEM;
 
-- 
2.39.2


