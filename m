Return-Path: <linux-hyperv+bounces-3857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FAEA2CFD3
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 22:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64807A6888
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8CE1DF984;
	Fri,  7 Feb 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="qMFRJrRt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333D1DEFC5;
	Fri,  7 Feb 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964193; cv=none; b=YLPCjTOofcGLSNomglTKTv7uUE384+oLotBPwPwtbdUbUbSHan9eCCmziHnQGibnGEgm+oBSfb5Gebce839sMgyj4V55RrE6gMAQsXr0t6NyBUDiDxj+SNX2vrviMjSWeHMaxTjVi4G24ydsDnHJxCSpegcHcrENu78G7BTl5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964193; c=relaxed/simple;
	bh=kBk5n7e7YJCpfbGRhK9SaKPheVXPph07wJ/EAM2JhEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pD0evOmTwX37HfjDE3/6pbdnIQw9zhCzPglsG8fZdSfVW5Mj5m9w65RUWa3uxk8+kNRRfHTav0zR3/EBUHHfih0mrvvr9W82sy8lqvvSYWMyRnwwZDYVPDTGuitUogcfQp7ib9cs8T6kZhZ4M5vFqz7oNEHp10Kh/f17aCY38E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=qMFRJrRt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 51F60210730A; Fri,  7 Feb 2025 13:36:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51F60210730A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1738964191;
	bh=S2tBTsh8o3n5q7814riIx8uxj6+JAvTpQ4Ij2rHolYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMFRJrRtSTypiO6DnFUMFLldt9lp0LJN/QwtwebqRQTQWXP1YRsy93vmMx73/OKzp
	 jc8cqd9vV4/JQmtSZ0LQy3R/KLrzQ7Mm1rbXXOvFKmnPSx2SQE3gXDlGRVFz4yuyp1
	 ms+Q/QR1ftsnbPcmMhtq16vkFVDEnFuVMdSMxsUo=
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
Subject: [Patch v2 3/3] IB/core: Add default IP when a slave is unlinked
Date: Fri,  7 Feb 2025 13:36:18 -0800
Message-Id: <1738964178-18836-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
References: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When a bonded slave is unlinked, the current code doesn't add a default
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


