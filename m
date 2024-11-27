Return-Path: <linux-hyperv+bounces-3372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3879DAE11
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CFBB21038
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B382203710;
	Wed, 27 Nov 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="ZCFj8yN/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E62036E6;
	Wed, 27 Nov 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736635; cv=none; b=P85bPC1u8SHUPn5Yn5045XdqASrylVGD1IbJlbpH4KHREDygFJ/ZfYkhCFhgQiKxzSISo/uBw5Vz0883Cmor3YFrbHVvNqjf5Q++hkNdLNLrOi+MYOh4zEd8XvwlxYX6XuKQxuavm4/n9TrbEYDPqCIO2NQQ54YQiGvqVAGAArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736635; c=relaxed/simple;
	bh=amMeqmNncw4zHhFLJX1U/wYVj/cTe9YiRbOJPdQevvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TgS2iB1Ml5ZtNN4LaTCv1J+0NtN0F5Mm8XM+/aujIEj5bP3xbd57LkB/fympscvezoVUIgCyxcJ/34uX3k4XyTfiOf0usI8tJrpYZR1pfymOFPioh/kpgLW4UaQsA4Ct+V/HkhXMCskxUpl41iSkDUciGkp16AAxwoRazhDyA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=ZCFj8yN/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id F01092053040; Wed, 27 Nov 2024 11:43:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F01092053040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1732736633;
	bh=NYZtFCtgQTLWuJKAyORzm41pdlgZLp3R3Mvc0/Z+xms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCFj8yN/I+MnnJRrLrIOF4qHOrvZntNbPxccTPPCuyX21zsK6ugv0ReiVCEdisVqD
	 9PrDOGXzaG8qDEOiXiMl8LaOoHkyzTogcYAHm3PyO2h5qeIC+XmTcDUuPcZJxyWVM1
	 pp0fX3mXF60sWKsGTU8nbwQMcixeJSbIisZLp0OM=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH 3/3] RDMA/core: Add default IP when a bonded slave is unlinked
Date: Wed, 27 Nov 2024 11:43:39 -0800
Message-Id: <1732736619-19941-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When a bonded slave is unlikned, the current code doesn't add a default
GID for the new unlinked netdev.

Add a default GID for the netdev.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 827a50dbd308..3fa2740fa0d2 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -692,6 +692,11 @@ static const struct netdev_event_work_cmd add_cmd_upper_ips = {
 	.filter = upper_device_filter
 };
 
+static const struct netdev_event_work_cmd add_default_gid_cmd = {
+	.cb	= add_default_gids,
+	.filter	= is_ndev_for_default_gid_filter,
+};
+
 static void
 ndev_event_unlink(struct netdev_notifier_changeupper_info *changeupper_info,
 		  struct netdev_event_work_cmd *cmds)
@@ -704,7 +709,8 @@ ndev_event_unlink(struct netdev_notifier_changeupper_info *changeupper_info,
 
 	cmds[0] = upper_ips_del_cmd;
 	cmds[0].ndev = changeupper_info->upper_dev;
-	cmds[1] = add_cmd;
+	cmds[1] = add_default_gid_cmd;
+	cmds[2] = add_cmd;
 }
 
 static const struct netdev_event_work_cmd bonding_default_add_cmd = {
@@ -751,11 +757,6 @@ static void netdevice_event_changeupper(struct net_device *event_ndev,
 		ndev_event_unlink(changeupper_info, cmds);
 }
 
-static const struct netdev_event_work_cmd add_default_gid_cmd = {
-	.cb	= add_default_gids,
-	.filter	= is_ndev_for_default_gid_filter,
-};
-
 static int netdevice_event(struct notifier_block *this, unsigned long event,
 			   void *ptr)
 {
-- 
2.34.1


