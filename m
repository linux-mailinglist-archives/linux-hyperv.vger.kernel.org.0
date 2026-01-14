Return-Path: <linux-hyperv+bounces-8289-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42097D2069C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7343007C7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA227FD51;
	Wed, 14 Jan 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiT9Lvm4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93262857CC
	for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410087; cv=none; b=BvtIxepZi07yxVOqc7L1PxxSR6xmJ6rjbgGnWYbSV/8UZyj2p/NXPowozYoKYJNL4EN17T/j/5ViUIEnkDHZbZxmfptodF7p7kqtejAEjYT0Z6DH/MUFD7fKlVqbgdat0sa3uUQm21i661oMxa5dFws36h7X1TOz8MLaAeazCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410087; c=relaxed/simple;
	bh=32+KbSU+C/+4RoIvG+cmqU+nzpA71iEPfyKd4r/EvO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbfZr3aOQubUCwbeCPa66l4IewhgwVQr5tHMLOWIbDx7EJZYJh18xcIqjKH+C3Rc2nJidQ2g32cPktIcGELWwbNHDTNqEMw72Hy4Zr4PqOlxqtG8NNXzdF0MBv8DcSc8L1GKbQQO9h/KMhJsLgxDpK3NCNiXFvXixNquHfB49sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiT9Lvm4; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0bae9aca3so424955ad.3
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768410081; x=1769014881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLHkoZcf5k+PDGpju0fWjh4ERD3YSbGkdU0XXav4POY=;
        b=OiT9Lvm4BSZSgIC4O4L8W9EEqP8oKqHcvIuTjVeOO2Z4wePx2/aSbllZ/yEhnsc6p+
         z70KlesSoXHFgKcWd3itB8QjYMx1fOap6McSjpcmtVQofXbtSBE2ba4xRv7TwPvijvUh
         RYpa1I46+8bxLG1eWZlG7lboVmG1zQ74n9ZG9QXHGK0ddAAAbzjngnvMtN17Lm93MI5E
         aavwNGmO4O1ws0OvDQCgnru2XTo8T0B/HOqRwZykcr4nFq0vaxaBkvghoC8c+5M6r2OV
         T0/53mb6SA1xlskiwwMsPAhipoSnmIStpRtbB4MhqCMyADsk6bl1w+6I0QcXRkYwY621
         ODiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410081; x=1769014881;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lLHkoZcf5k+PDGpju0fWjh4ERD3YSbGkdU0XXav4POY=;
        b=PAYJ2gKQCaPjbIN4YVENx6beQyBbDVdEHZA0xlbW30jfMuOBpKdcjOoTpuO0ZcuxoM
         jothjGpLJZXw8dqsP+SSI3eU6KNStLPq8Ue2JPaWoDP0QzsBdHFwf1uCHv1UUCZqKegP
         XhkwVOcaCV1IQSMeSNVOXfcgStaafbYQjbKJVG8ERT/D3NlCgNk20j6AH5dJVsyuPbu5
         O2YB1xp0BI6wo2XUJPCe3WbkdvMJFvzCQdMoMsh46BSWXW9rWeRETFzSeKsQilXETIkY
         OpN46rDrWKCHLhXg7ScDFN1hozgdIB6vjIJjl+XTKbJ5oC+pVooRua9f0omzeYiOEHzH
         lsUw==
X-Forwarded-Encrypted: i=1; AJvYcCUu3lEuy0G2RNqBR1h9xZA4VJX4+tkiyEcuJeQgqLmoOSLY9TFPC7lQ8u70R846ecbgLZqslvJJ+JRfQ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7HBEAJ+k3jOe8lF6eI0L4KjQ53UGxdAQv+WDalU6ONBcsooy
	kEswOjqXEhB98H1dXZzGF8MeHyO0i60TdQd2yTaWD3Qrpd9WGErk6gq2
X-Gm-Gg: AY/fxX6pHNk4lvS9iNjIy6spJeFH5wFaDLtwo4rvJCOZ0i3LWo2VIdbo89OBnuLVNeN
	R2MrMhV8B498d3dW+x21/5zT3TYCnHb3F31OhLsTqmKvBC1yOMLnKkIIrss5RCAZ2TdN3NnqdBQ
	iVgMFu7FCQiRomNUw8y0ktPXiRemwvNqadRaNM/u8LRA2FyKQUqUFu7/eV6letyp1EUs67SAlh5
	jPqA+9mZv+YGS/CylFzTOdLie5S64/B2AuyCvQXgwTXxVCEJolfbHP7qVnfYBIiwPQiQIlvtiSP
	sTFijbXMHr8Ok0iNwHtNCPEiQRXvANCLQno7p1jtnNHdYAwdiv7M7cLBSF9qZdY4nrJFU2jFBmg
	fzmoJEAQ3UVHtnNUyvwZ86+GI+YXAOmwwyRJe76ZoZWJ/luBAXKgkG5vp1FbIadMu6NYt/orcnu
	ZiwJwMGi6NdPTPS833unstLKW/Ox/9MV3LDi2wm7hMuTWS30NN+sX5HM2hR3+3m9v2WbO+1l/E1
	+06
X-Received: by 2002:a17:903:2443:b0:29a:5ce:b467 with SMTP id d9443c01a7336-2a599e5b158mr31084535ad.54.1768410080917;
        Wed, 14 Jan 2026 09:01:20 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2906sm231144965ad.87.2026.01.14.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:01:20 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mshv: Store the result of vfs_poll in a variable of type __poll_t
Date: Wed, 14 Jan 2026 09:01:12 -0800
Message-Id: <20260114170112.102673-1-mhklinux@outlook.com>
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

vfs_poll() returns a result of type __poll_t, but current code is using
an "unsigned int" local variable. The difference is that __poll_t carries
the "bitwise" attribute. This attribute is not interpreted by the C
compiler; it is only used by 'sparse' to flag incorrect usage of the
return value. The return value is used correctly here, so there's no
bug, but sparse complains about the type mismatch.

In the interest of general correctness and to avoid noise from sparse,
change the local variable to type __poll_t. No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512141339.791TCKnB-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This change is not marked with a Fixes: tag as there's no value in
backporting to older stable releases.

 drivers/hv/mshv_eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index d93a18f09c76..0b75ff1edb73 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -388,7 +388,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 {
 	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	struct mshv_irqfd *irqfd, *tmp;
-	unsigned int events;
+	__poll_t events;
 	int ret;
 	int idx;
 
-- 
2.25.1


