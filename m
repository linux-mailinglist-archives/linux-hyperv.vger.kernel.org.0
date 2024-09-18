Return-Path: <linux-hyperv+bounces-3040-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBC97B871
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69A51F23193
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602216EBE8;
	Wed, 18 Sep 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlE3lc5h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B214166F32;
	Wed, 18 Sep 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643903; cv=none; b=eX8ko9s9gVGOstnY99rgkipQhBOr96iQlm+9VuJF18Iu9PBsqah6hyw0BfDCL7JPgveaZKcuohwujhLjikheietwqHGXMkdMhJrIUxkhkm654FaIZf5Rig/EHU/8cL2QSe+AQ5Ig+MZxDViQ+MtYUyG5tCeszix+mf7NFMUu4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643903; c=relaxed/simple;
	bh=b83PALrm5dN5U/QYTi2BMuin1oO/BIsTDiAk5yojC4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wg9uXsekt3Za1qiqABBheDCntDI0+4DsslqV+vw+YE2z1c3LdeGzkxQHaOwIYKgCkAwVQznM6yeiSYKhmztmrkUR+0xUtA+yUPRPCwgXQZyNLgZomLVxakB0oXbm50azgbi94q0JKfxIXv6ILymFehMWm16pBM4W15C/urrf10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlE3lc5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD42C4CEC3;
	Wed, 18 Sep 2024 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643903;
	bh=b83PALrm5dN5U/QYTi2BMuin1oO/BIsTDiAk5yojC4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlE3lc5hPz8IaI9z5dKethUl/4CLJ0ZysT2lNW4x/Tbw+Wl944Ao8e2f0et+Mq5me
	 bLnj8/zseoHVEao8GCC/dlzhxvoOcTM/LF8uoVtWuE0Hif7oWja5ezjsQdcFEQozk8
	 aD6W6zji/P5t9+RpwhMtqiSQbSMkHIr0XF+ZDQLlhBfU9Dv4yqDotZ3D9eoIqGuSEZ
	 GE0ZqFNxxQTNR3UWUezGoY/nScHRUxPt7YhIbo4qrdxwIFn6/eDcaCz2WxHxV8y3cc
	 kvExLL94WR6fWYj5VDksHVK/uQLzZmu12pMgZGmiFr43mpxv75TipCTvVS7DdKTMql
	 N8UscfbajTkrQ==
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
Subject: [PATCH AUTOSEL 6.1 2/2] tools: hv: rm .*.cmd when make clean
Date: Wed, 18 Sep 2024 02:36:37 -0400
Message-ID: <20240918063638.238937-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918063638.238937-1-sashal@kernel.org>
References: <20240918063638.238937-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.110
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


