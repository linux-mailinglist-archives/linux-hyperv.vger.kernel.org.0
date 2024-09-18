Return-Path: <linux-hyperv+bounces-3038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75297B86A
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462D8284B47
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A878171E76;
	Wed, 18 Sep 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie079k6Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CD171E73;
	Wed, 18 Sep 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643893; cv=none; b=cJZvsmmYm9fHigVQj3S3KpXRvHEut6HT+ps/+N462Zhr9WatZkv8RUtLqoLkVIrRGe0KfWrlDuQDBv/OXgL5hsyCd7l0kPnCLyt/nMwgqR8ZeApi5amsbcMADtQo7bwDp7a8w50ZoUKfQGDOPzeLBe1aq+hermu7Z2GsiP63fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643893; c=relaxed/simple;
	bh=b83PALrm5dN5U/QYTi2BMuin1oO/BIsTDiAk5yojC4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwBhGgimS7YVTYU0/ECZL/TZeXKTuR6ryXZECVzbXRQ1DGGQ0OKHrv+w+0Ufq+XZQ4z7LR30DilVYsS/m8yPfUD9nW8KQEhcuRfrgtVh46l9pxjj7VxzCBww0WetqXfHVW4miEUtOB2qiW/OnUifUh9Uj/cOvW2Q2O9AiuWn/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie079k6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B392C4CEC3;
	Wed, 18 Sep 2024 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643892;
	bh=b83PALrm5dN5U/QYTi2BMuin1oO/BIsTDiAk5yojC4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ie079k6Q2kPSKAXziLFM/zMW2rjD7Uw4n4lA5cI2iaTEswEaiFuRJ3wKAG+vx4vvv
	 1CZalXZYabZG5LCBw23i3wa+BnlCV3lxhdVZvqYwn1cvIrCV3kRVDrjc9jLydAUfxb
	 IBSnlexBD6kn865Nxrw3kNr4CYKZ8M36cY7yw7MIWp+dYuISJpBpnEC7AW8xJ7k8U8
	 nHhrO0YQ7uiZTdu6cND4M4UC4Q6Hyr0YJ1Vkg9RIP6/InZePx9M0iLdgbcQL8oeqn8
	 ubz9vlBNSc+9pMCwXXR5p8vWPCDvuOqLuT+DsQd5/MfIUkCnzKsaQRqsEFPjxoeHNs
	 LvN39gRHZje0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	sthemmin@microsoft.com,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/2] tools: hv: rm .*.cmd when make clean
Date: Wed, 18 Sep 2024 02:36:27 -0400
Message-ID: <20240918063628.238885-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918063628.238885-1-sashal@kernel.org>
References: <20240918063628.238885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.51
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

[ Upstream commit 5e5cc1eb65256e6017e3deec04f9806f2f317853 ]

rm .*.cmd when make clean

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index fe770e679ae8..5643058e2d37 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -47,7 +47,7 @@ $(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(sbindir); \
-- 
2.43.0


