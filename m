Return-Path: <linux-hyperv+bounces-3369-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7949DAE04
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ECF281454
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1D202F60;
	Wed, 27 Nov 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="HkPep5Ah"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF08140E38;
	Wed, 27 Nov 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736627; cv=none; b=VBQOQLawLanTyS0p+krB4YlzydUAgMFzXmDEqGY0jlyf//4Ciz2RCnmetG0q+RdgIWYENvhC2NL2g7h5K/y6yB8rTs2G0eDVYv9me3dXhp0CZ4f7Z/PN/PkLo12v68LRU5ylgZjEWhEzGTe7pRVDlYJNI/5fCmTNpLUAVn5hzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736627; c=relaxed/simple;
	bh=B/qu1WrdEwSkKI4jj4obY/PvsecyApEC/RL44xsaADk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HwaRQHyB8BqVnl+VMGGVRN+gHb2kIr6YU+eqtLO2QGOzO0jIAhZdJSbqXd1Ls+mx4Ci5s7/VQzY29iRBFnEt2zuJXT2VVoTOSUjwgxP6nMsSL1Gqg4+9qfqLD7vayPU4cwUHCUd4Zf3YHo3fooZbGKm3m9BorYJ//75IydcozPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=HkPep5Ah; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7F6DC2064AE8; Wed, 27 Nov 2024 11:43:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F6DC2064AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1732736625;
	bh=jkI17VqvzA8ChaHeNeFWrLsb7si+GzmH/qVd0R1oknw=;
	h=From:To:Cc:Subject:Date:From;
	b=HkPep5AhZSlUVxAwwQaaQe3/zEJsTcHF3CoyKhxNzbOn0DQuuDX7BzoQORaaP8Qt9
	 6uwxuZTqA948BXaGysVJkqzwdCGReRnhKdL5YBKVAxk1da0ucke2OVaDX+pS8aVIQU
	 F06V3Dsb1VPZHUW049INNV3l/fjLebpA1TDE4Lek=
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
Subject: [PATCH 1/3] RDMA/core: Do not use netdev if it is a bonded slave
Date: Wed, 27 Nov 2024 11:43:36 -0800
Message-Id: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Filter function is_eth_port_of_netdev_filter() is used to determine if
a netdev should be used for assigning its IP to GID cache. This function
should filter out bonded slave netdevs. For bonded slaves, their master
netdevs should be used to cache GIDs.

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


