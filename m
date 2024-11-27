Return-Path: <linux-hyperv+bounces-3371-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C549DAE0D
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A65166A86
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 19:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04732036F4;
	Wed, 27 Nov 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="MA1D0sOD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040D20127A;
	Wed, 27 Nov 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736634; cv=none; b=roXIsahTRKJ0B1Z/+2a70QJajiK5llT6/6/Zi9qBGxZ0P6v9C/09TBvZekieJ4jihz4llDqnaEYwTep3BqTEVh/Up9uZaDRuDAB6rSKBtQ8irDlft1F5dd6ePyNZ0g32SnFD/RjBnTl1M0ihrWt7+6fxTHFMVpx897s4LhLj7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736634; c=relaxed/simple;
	bh=VjdZMSBTqQmt8MS8VcgzWUrywQMhF+ejjUTwAdLn8g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CYQkNtnJnSEu0Jo52LJWvA90Zw45FTxmwGaEpYvyoB3Tp8FMVuur8S/wtgNlentE9Opf6mISNgyGS2IuWxbzqM/7xV50SGLb22tEdWlDnM2yK/ykeLReKY8Ab5ZgHK/PT4xwIA1Ybtcy6HX5OzrXQNAtcSukN9IFbI2yAXI5qKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=MA1D0sOD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 24A512053044; Wed, 27 Nov 2024 11:43:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24A512053044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1732736633;
	bh=+ReGDBRQsglb0WbCjD6PRcmDNwnpaJULXY2QpsVOiw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MA1D0sODyVYYwKU5Jg+AGPAaESDYsj7UtZWJJebWZh6kdtJ9foPhgWANrfq6RMOp9
	 VXJqAJv7dMZ6yKwHMZ8W5XJX7H/hfQyQhdRM6V2HIE6DgJYb6SPhOVPyVzRJTwTY1n
	 sqMEAUrYJ+bYYQd0aX7Q0yi0lGVoBbPoOkgL+Ti0=
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
Subject: [PATCH 2/3] RDMA/core: Use upper_device_filter() to add upper IPs
Date: Wed, 27 Nov 2024 11:43:38 -0800
Message-Id: <1732736619-19941-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

add_cmd_upper_ips() is used to add upper IPs on a bonded slave. Its
filter function should be set to the same as upper_ips_del_cmd() in that
it looks for upper netdevs for GIDs.

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


