Return-Path: <linux-hyperv+bounces-3855-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95906A2CFCE
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 22:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889947A6638
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E71DED73;
	Fri,  7 Feb 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="QLnsWFc9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170151DED59;
	Fri,  7 Feb 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964191; cv=none; b=s5VAm4UVZLQPCIpdnRKrE91FFJ0Ai3Xtt6ot5PcLLw+SKdJu4ICOjI0rfiqVGBePHdPh2DXLL+fPcA6sDM/gxZseHHTy5ATpljVo69f8teD/GVBpSkzHrUzuINgeVNU0M9ahvmmGYFo8mP137Z586FqqfPSQQnlkww5oGUqaUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964191; c=relaxed/simple;
	bh=fUqDe7cZ8thgwnV6PvYj/xBO91HIMA9ZeF/Fs78UA8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HzFJx+9NKg7JIm6tOxtaSA06bWFozKdQCCfSRXJPZh1qi+4XrEBm4oesnR50D6LOtRw32CWqA/vI4+YbeDSYlA52izba6L8S2YekAzc8S5dBUtlnYbUeXLvI7bUkDNPDmNRSqt/6B+0CNP8gjhOAOqA5sqmUVlORopjfchVjhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=QLnsWFc9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id B82C42107309; Fri,  7 Feb 2025 13:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B82C42107309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1738964189;
	bh=S5jAkLUptiFKhzApn3CtSlg4k9H2uw5xSxtSyuCu5d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLnsWFc9jyw/fhewq+PwXSrnOqkC2xlMWkmGmyzuQPwc0zMWYkyc6PgO8tIY47O3g
	 9N8/SJLMJVTdw6uDfaiLQ1hd0S+dQI9jZAESaSy2/UzTuPwBWIOtk9KWcUyXLa0zkq
	 cWQeBqiFhiLkk7V3brQYwloC/IVdbb/fwYSHMyF8=
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
Subject: [Patch v2 1/3] IB/core: Do not use netdev IP if it is a bonded slave
Date: Fri,  7 Feb 2025 13:36:16 -0800
Message-Id: <1738964178-18836-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
References: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Filter function is_eth_port_of_netdev_filter() is used to determine if a
netdev should be used for assigning its IP to GID cache. This function
should filter out bonded slave netdevs.

For bonded slaves, their master netdevs should be used to cache GIDs.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index a9f2c6b1b29e..27a3ffed11b9 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct ib_device *ib_dev, u32 port,
 	res = ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
 	       (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_dev) &
 		REQUIRED_BOND_STATES)) ||
-	       real_dev == rdma_ndev);
+	       (real_dev == rdma_ndev && !netif_is_bond_slave(rdma_ndev)));
 
 	rcu_read_unlock();
 	return res;
-- 
2.34.1


