Return-Path: <linux-hyperv+bounces-7403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5357C30F3C
	for <lists+linux-hyperv@lfdr.de>; Tue, 04 Nov 2025 13:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18BF3BF63F
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Nov 2025 12:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC802E7F14;
	Tue,  4 Nov 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy0FXGS6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB02DF12B
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Nov 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258600; cv=none; b=qAHB1XonkSArEk/cxffr0HSut7pCDEhijcwK7JGmceFjEW745CBFR2uj5ZSOQEcWsWTnfaOz7Z8taNdLxLNIecxL9+0wqKtZKauFGzuLs2QhQc4uTVC/1cD8CEttGWwfyzqKycEuo5/Utk8QyD+RlixNFU0aFBfIXCXqQVr5sZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258600; c=relaxed/simple;
	bh=KmF1ild1xRClyDBcecZ5U1luwkLXb/wS/QXdRFfIuPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/JhVtKxm+j8e1M3IXH007kNhEU10YE7NLJOtSuuCWtTnhDx2FJyABPzncujGWBkmEANkyiLJ//lvkSXA/CDgGA1nvrC2KefUuSqKtVmp3v5kIQRI5xguzAg3n5ZdD0NJhiZ1h6rZwFXFh7SVoGJ9DHDJd0iwPc6yRaNXWXVnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy0FXGS6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d3540a43fso53839565ad.3
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Nov 2025 04:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762258599; x=1762863399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qm65bXeCJn5pnj+/OO3CyTJYCu+x03vH4a2TBarzblA=;
        b=Fy0FXGS6ktrvlQLzcPGqcTYCAaYV6Mdyes6xBQtN5mI8x5UKUfAy9twhYHH+zt+ZCR
         mLantyz8udWeEwC7AlnGQtIT3zCWHhOoxZx7CiLV9qD8DdM0rnK5mOa8InBXNbcxuagq
         +DLoGfycDDa7I1SemHjt3c0FiwSAi5gFgy81hb6C9ck6LWb+Lakt7UBjd4ybxz7OAY4U
         s9KL4z03SdZlFErP1ADh3oSMc3E3WnJ2vKrq6lqOJ9cOex6yj0VuTNFSLdAf2RBYXiP1
         KTxlR8FiqhEFW2eyIbkVuW5auCcmpIb/5dzmuaenC/ysWNsuDv5s3oakyB/D0TkLckv9
         /j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258599; x=1762863399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm65bXeCJn5pnj+/OO3CyTJYCu+x03vH4a2TBarzblA=;
        b=OoUXHAI1pa6EnHSIzYUDI0RdC3xu5PmmR5dp7WxyEuKGgXgN+jTTX4v2qzGfrs8YIS
         2URDhWV8PYx6iLxlqWmkat6qmZGMNFx2QNTDRCBP8sFjTBl7t6x0fJUxdOPQT8zp9ADQ
         rRPCp95mn/8MNI91WqVtmmdl1zPeLTPpbZmrg40JSykj9r9AXLRRVehpzncu1uQ/NH+K
         YTw+suEem0fK2LtaNIwOaSYwgvXh/mqsd95NUuYuirYtQ1lQO95SaePNj6liGtDSfZJR
         vePZnqo3VKpiHESmtZxAxIbcNGx5FxYvt9xbMhRTPww+sxraLSkim/CsaUozQzgmG8DM
         X7gg==
X-Gm-Message-State: AOJu0YyEEMNjQJQCdJMGscvnQzq6GOX4GLuqsA8wijmD/v321hRi7hdg
	zL2RJap8LeNv9aHDCEY/sm3+yi1rUy5QBMgZ/EyTEclWzOH6C00osoGN
X-Gm-Gg: ASbGncttC1eDlAzqRMbN/9lnp4049AjJuYldFjTmyoNhs4Rz7aF4Db6SKkSJL42sV2N
	pIDKZtU9vDX/PiavsfcJoQTJCc6h7mDihrSDSHiA03qPYl6hnodU0T6OdFrm7NdGwDCRTFk+bHm
	80i3WgiRjueMctKqHvOzZjqDxwKYrcy3h8Ghk87CbajAmWm3bXcKHbsmj0azCg76H/WRruMMXMu
	yDk24bxdUUh/GLpMTEet/q3mwPOxdZy5jPxHuW1L/naHc5AT8fKENFsicZ+UvKAL0OlrBv4Dn4R
	eGXvRroh2aKdLUHbLaJ18QhKbbfv0pA8TJrXX6tqPKU0VZE7aUWRy2i5vdBoe6H1MYueTyyxsfo
	2nlCanaiOiHKSTTRfyUCFzbtE8FJPgK6QWLpOG6dsVXQcsoQAS6oCKSHjpB3+ip2U2ffYx3dTGF
	RwOhWHERSo/IMsEQ==
X-Google-Smtp-Source: AGHT+IHWfL9ukqE2uuV3u9mjGfvafGL1d6Fs8/ftcpn2dBlsfCsDaAEiDNRs1yYtV7lZN1i+KrcEew==
X-Received: by 2002:a17:902:d486:b0:295:c2e9:604e with SMTP id d9443c01a7336-295c2e96112mr68237335ad.51.1762258598598;
        Tue, 04 Nov 2025 04:16:38 -0800 (PST)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c2e69sm4436715a91.6.2025.11.04.04.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:16:38 -0800 (PST)
From: Rahul Kumar <rk0006818@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] drivers/hv: Use kmalloc_array() instead of kmalloc()
Date: Tue,  4 Nov 2025 17:46:18 +0530
Message-ID: <20251104121618.1396291-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in hv_common.c to make the
intended allocation size clearer and avoid potential overflow issues.

The number of pages (pgcount) is bounded, so overflow is not a
practical concern here. However, using kmalloc_array() better reflects
the intent to allocate an array and improves consistency with other
allocations.

No functional change intended.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/hv/hv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83f..68689beb383c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -487,7 +487,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	 * online and then taken offline
 	 */
 	if (!*inputarg) {
-		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+		mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
 		if (!mem)
 			return -ENOMEM;
 
-- 
2.43.0


