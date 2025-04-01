Return-Path: <linux-hyperv+bounces-4763-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F8A78184
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEB63AF760
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DEA17B418;
	Tue,  1 Apr 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OuGjMhWv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F69461;
	Tue,  1 Apr 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528745; cv=none; b=ihlbulVo41GFOAtKedJTrPXiCLk/gOaYozbpeMLnvkdvlyLntjLK+5afuZKxmbFi+aqDXz97Poz1xFHntw9oB6TIpygLqLuOQh1pUL9CsvrqOmPvyMZyYmcVSiN450302yTgvR40L+Hknx7NWTpKsKcpbz7dXxvmsfK/iMEAeP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528745; c=relaxed/simple;
	bh=iGj3hLfOyeA8TgY9n8E2dRMwkMAXZHG4SCoURBixbTU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=to8FIeTMKt9GsZhobq9EfLG+z4Egw0WQCPSQtZzpuk+fnXgKNrcO46C9GqxNpvffHEah7po4cnwnbVwyKu8xRiuk9YVx1faYtwRNpNFhU8XZSAWuVd7xviLr/vkTSX97BcmwdzTwfnJfDTLqJqtMKXLwdxvD0ay/QTIlaKiEgw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OuGjMhWv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 9CBD520412F8; Tue,  1 Apr 2025 10:32:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CBD520412F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743528738;
	bh=3A+eNuTXGknZYwsRt07FpiUQvMRsP9gizaYf5bJhTCs=;
	h=From:To:Cc:Subject:Date:From;
	b=OuGjMhWvqTnWD0t0mMUoWXh+sDuIZ0pWd+0Awmf3ElekuGVtOiscYpSXw2YuOcold
	 YCLvFPqdJ2xUG8xQyaLLOGMwWujFyjIGCjaLnGGPLZaNEx3ONKFzRISBWWOx48KXJJ
	 7cLsRoPqWS0tVRFIRINF+H75k4gPYirP4VJMnYFE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei.liu@kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	mhklinux@outlook.com,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] Drivers: hv: Fix bad pointer dereference in hv_get_partition_id
Date: Tue,  1 Apr 2025 10:32:17 -0700
Message-Id: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

'output' is already a pointer to the output argument, it should be
passed directly to hv_do_hypercall() without the '&' operator.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
This patch is a fixup for:
e96204e5e96e hyperv: Move hv_current_partition_id to arch-generic code

 drivers/hv/hv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index b3b11be11650..a7d7494feaca 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -307,7 +307,7 @@ void __init hv_get_partition_id(void)
 
 	local_irq_save(flags);
 	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output);
 	pt_id = output->partition_id;
 	local_irq_restore(flags);
 
-- 
2.34.1


