Return-Path: <linux-hyperv+bounces-6345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB142B0E754
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 01:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E247A564813
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767828C85C;
	Tue, 22 Jul 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Igjw8yTG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B6288C06;
	Tue, 22 Jul 2025 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228276; cv=none; b=hzknzrf8DgA7jEmHSqwrTMs563yrovNwl9GEpTHU8aFYwBW+pSAu9ZiavgFei0MvMnuULB0EHHgxVfVMJTsKOkCpILXxBfx7RyTpVkOXj1F+3X3kMcQ4N8l99kJTqA+JlTxbtzX9REsvqO8/WMlzQ+hEykBxs4NCSkzM6gI0eJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228276; c=relaxed/simple;
	bh=ijTQWhPIA2Tnlw+nK405RPB6WZWPAIX5VpUHzN9GbKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KrxLYmgLeejDcYq+nqF5PXi8wEHqRVlDzTXDVx1Sck48XpKJsSidwRsV6mdKidWdkvIi80D2e/2PdPRRE+2lYmmfRB05qFkkoWgCmmCbz5U5eybC2rvq9EbKsRK+dK6OG0ivGi3Gbvrfxjt9m6D4DCtN70KVduS2BCu0ovQmjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Igjw8yTG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 97DF821268B0; Tue, 22 Jul 2025 16:51:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97DF821268B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753228274;
	bh=UB1jTBbJaAAWaieKZkkKW8JaCkBj3vgYKs3ASIhN36s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Igjw8yTGl/LJ0ResWzuYWG1kzXKXNjXo7B2ph79AXQOtKUitFAVasPGVDqu1eQnhM
	 LH+y0GKvVqJg1TuwmLIgTGxlsmPXLFYEGfrfrXXZzxMwXaXf7HwHU2IvIKWbpO6dc1
	 gzgRJfoCZQ1zR8RSPkbI8nhGHCooFy7U3bh22XoU=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	sd@queasysnail.net,
	viro@zeniv.linux.org.uk,
	chuck.lever@oracle.com,
	neil@brown.name,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net, 1/2] net: core: Fix missing init of llist_node in setup_net()
Date: Tue, 22 Jul 2025 16:50:47 -0700
Message-Id: <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Add init_llist_node for lock-less list nodes in struct net in
setup_net(), so we can test if a node is on a list or not.

Cc: stable@vger.kernel.org
Fixes: d6b3358a2813 ("llist: add interface to check if a node is on a list.")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 net/core/net_namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index ae54f26709ca..2a821849558f 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -434,6 +434,9 @@ static __net_init int setup_net(struct net *net)
 	LIST_HEAD(net_exit_list);
 	int error = 0;
 
+	init_llist_node(&net->defer_free_list);
+	init_llist_node(&net->cleanup_list);
+
 	preempt_disable();
 	net->net_cookie = gen_cookie_next(&net_cookie);
 	preempt_enable();
-- 
2.34.1


