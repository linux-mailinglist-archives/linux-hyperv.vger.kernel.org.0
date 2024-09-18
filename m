Return-Path: <linux-hyperv+bounces-3036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF997B860
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6141F22A6E
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553815E5CA;
	Wed, 18 Sep 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyA96TJm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55A16DC0E;
	Wed, 18 Sep 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643879; cv=none; b=qg8tj0eEOGD+wUlhhH3NFnjeu9zBO6Lv9i4OJ+gY4kb2+ziUuUtJOmkAt99urIbSjPF6gnkjth8plYVmCsT/WcOmnzLfYpCGD/2NrUt1UfZyGt2kZ4BA7yHLxslz/4TKI99MK6rGrFaa0We0DiaESR8zunoJ2W6lvPfzccvt/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643879; c=relaxed/simple;
	bh=mbokiQWjB+GffoHWwGMrCP6yvyFiJTax/PyVtwe+Nro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDEbj/bMBaJ74Hhim8wBEAtXhFEOjkunewsEZTFh5/gC2f416NbCNkWN3cOIs953ac6shIsxfx5RbohysH9Q1BPKoRDmJFsgGPqkCEQLCt0uEt89I4y/sPd4EBRm5WFpXikY1qNN1MLrQFb+fTW9voNyt0LFtJkeUNRA/uv2HIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyA96TJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914D9C4CECE;
	Wed, 18 Sep 2024 07:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643879;
	bh=mbokiQWjB+GffoHWwGMrCP6yvyFiJTax/PyVtwe+Nro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyA96TJmZHerCj/i9Jk/9WKZezsgt2FzOtz9jhf1hunv4iATZP27AMKSItswDeSTP
	 hmaIW+3gfszKyWrd/y7Xqzw0dMgka1NUGKL1Fk+vquZCHQsEhdfnZUpial4A7/sNoo
	 jaNDtNEgKYhrFn0C2kVSoo/v6MmG3nE3BQL2My8bLCU+xhqi/2E8iwj1oDlVK4opr0
	 ft5xd/Bw72B8WqbeKLk91W7zHcby0IxOaZeGn4BIGjFt30/wbSuqp51d9S8Cf4/aY7
	 3kwyBll1xr7Re+dqAwtZRUIqGc/KhwJSomclPzN+mdDi9qsNBob3nvJJbSisxvtHSi
	 J2kgl1oIWJv7A==
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
Subject: [PATCH AUTOSEL 6.10 2/3] tools: hv: rm .*.cmd when make clean
Date: Wed, 18 Sep 2024 02:36:10 -0400
Message-ID: <20240918063614.238807-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918063614.238807-1-sashal@kernel.org>
References: <20240918063614.238807-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.10
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
index 2e60e2c212cd..34ffcec264ab 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(sbindir); \
-- 
2.43.0


