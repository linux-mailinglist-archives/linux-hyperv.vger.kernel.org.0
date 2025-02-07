Return-Path: <linux-hyperv+bounces-3856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF391A2CFCF
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB1166904
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764111DF26B;
	Fri,  7 Feb 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="kxhJqypL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F21DE8BE;
	Fri,  7 Feb 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964192; cv=none; b=VKc20oxZFJKI+oZAM6Qhews+qexUSxURDq7GaaRW2emSwGD42jGEObD+lArRDIS3L0EGAKlfZl74HQrJFfsHoEAnf51+YAL7hZsrYvQfq8TWrBQw1PVtCVfELkOX0rl8Z9cfIqt0GIPmGkE+mSQ5VuKoPhaD7/4UAuemV+sRnnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964192; c=relaxed/simple;
	bh=Y7JShV87JQui8z8Kq0zo04B7QAsEUBHZ8lK3Bey/muM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=O0Jdvil1/5W2Vv/FvcsqRSBO4V8Izhb9GbCfcWy6R8g9Gd9wgWOe+24rPs402F9MtO+ZO4lxM+2/612GTy0JqgpsytbCaHo+zmCt2UQURz49fOM7xSN/mtuGt7+0NMF68uSH1Bv1T4jTl8zFr2B4x2yloP6160OYGoAQZUiqf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=kxhJqypL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 99EF5210730B; Fri,  7 Feb 2025 13:36:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99EF5210730B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1738964190;
	bh=VAlHqRuRE25gELVSBtg9v7fPPGM97BHmG3MoyZtc4mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxhJqypLbKEVeqmTA+DrpV05WekEdic3XZZQJxvhEQ1as1Mq6ahUwnMx5gZvyNONk
	 wNcDQybVqHllhpraO3M7ojw0HeTiQaI7cIct9Tobt7rR/hcNYMv9qbVEk6rg2DN2Jm
	 QEWukpT7FLRVSCRlTwDPIzD070gaMUUkcJm+G81M=
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
Subject: [Patch v2 2/3] IB/core: Use upper_device_filter to add upper ips
Date: Fri,  7 Feb 2025 13:36:17 -0800
Message-Id: <1738964178-18836-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
References: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

add_cmd_upper_ips() in ndev_event_link() is used to add upper IPs on a
bonded slave. Its filter function should be set to the same as
upper_ips_del_cmd() in ndev_event_unlink, in that they both look for upper
netdevs for GIDs.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 27a3ffed11b9..827a50dbd308 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -689,7 +689,7 @@ static const struct netdev_event_work_cmd add_cmd = {
 
 static const struct netdev_event_work_cmd add_cmd_upper_ips = {
 	.cb	= add_netdev_upper_ips,
-	.filter = is_eth_port_of_netdev_filter
+	.filter = upper_device_filter
 };
 
 static void
-- 
2.34.1


