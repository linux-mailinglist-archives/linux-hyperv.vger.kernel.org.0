Return-Path: <linux-hyperv+bounces-4173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB11A4A5DF
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E480A189C173
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07311DF726;
	Fri, 28 Feb 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="e+S8EPIK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5BA1DE88B;
	Fri, 28 Feb 2025 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781523; cv=none; b=dmwSeRoC9beCiD+FqUTKmSUgdfF04diph2oGPFPV//zG5JWBNntRH/b+pCz6Q1DbFD5rx37U/LGQidrmDmsdxz4va3lT7LlZ6/gkMm3Tf0WjJ4TlY3ueH17CGlKbvTO3yXQg+t70+IGszmKrkFIJo4pu6dY1cX+7VYSwuutWpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781523; c=relaxed/simple;
	bh=1obOMr1Rmb8R+h1EQDNEXYfeQUcnlviZ5c7bzgYHXOM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t5Ug91PDwhbPemoPsng4tayxzqjAl787kBTMYBfGxtZ+l5/K1bnuefBJudDRymxyUmNk9XDniPvyr5mJNN2DWQFnZN3KOzqol3FFKwYKcTb88up3qXj0a0twAwDNUrLdCjEhL9wSODjbx7EyVKR1x98ZPMBNSgmPXSU6dWBEHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=e+S8EPIK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id C7544210D0EB; Fri, 28 Feb 2025 14:25:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7544210D0EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1740781521;
	bh=gckZXDWAjiG2ABDpx5tWE9GOBieJFQc592HWfvAcwyE=;
	h=From:To:Cc:Subject:Date:From;
	b=e+S8EPIKSTxcKfVTfs45fE8DXvCE5wLn8L7ydpmmJVRfahBF40Q4FNvCqeUFbYFGI
	 sGLAC2/bgQh1hTP31vyloJ8N4IRyKLWqnfmlQ77KT4s/E+2HtqBwPWDD6vo0o+8tGS
	 NZYDdk066vEo8fewWUpSuXaCjGj4fP/pb2Zwn3ng=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH] hv_netvsc: set device master/slave flags on bonding
Date: Fri, 28 Feb 2025 14:25:13 -0800
Message-Id: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Currently netvsc only sets the SLAVE flag on VF netdev when it's bonded. It
should also set the MASTER flag on itself and clear all those flags when
the VF is unbonded.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d6c4abfc3a28..7ac18fede2f3 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto rx_handler_failed;
 	}
 
+	ndev->flags |= IFF_MASTER;
 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
 					   NULL, NULL, NULL);
 	if (ret != 0) {
@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
+
+	/* Unlink the slave device and clear flag */
+	vf_netdev->flags &= ~IFF_SLAVE;
+	ndev->flags &= ~IFF_MASTER;
 	netdev_upper_dev_unlink(vf_netdev, ndev);
+
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
 
-- 
2.34.1


