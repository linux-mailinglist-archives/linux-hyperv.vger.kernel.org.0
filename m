Return-Path: <linux-hyperv+bounces-3732-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF8A171D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B12C1888682
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9DE1F12F9;
	Mon, 20 Jan 2025 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l0Re9OoC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F01EF085;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394055; cv=none; b=hqVf/ZGDGuy+ELcVoofSK2AtJmMtARHABKtDFRUw0HPxaqwV42ff+MvcY0umnvfhKcli0D101V3mFCR5Jru1Tf/sAPhXJ+w6+QTybDabVOAw3BVA4zZbqw+ohhG8EWzoebyb50jIZU4XE5ANg0zACXtDn1RMJ1ey+fTsfu+R2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394055; c=relaxed/simple;
	bh=jIzfPIAqIjaxRMRxqyJH4fTGhbSvWwyaslK19lldbGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jRUPEjiW3kM2XM628lAgi+wQ3Ph8aq0VkPVnHiOwsM0S1hSUyEQueTPf1RiGEszoRi1X4t1eUPz+Vcx/oZcZqgjxTxkdHN2XSDMhCLfQ0kWz5Ch3wUJ3JMuP+qAvJNGRnhrfOCF5faku+/Nc3kCce/gvfyt7UxCsS7RaKjAWWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l0Re9OoC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3797205A9D4;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3797205A9D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=ZCD3w92Zk0owMWjZiJnQbmXGQnkMPOm62irZP7iqqIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0Re9OoCN/64jjOS67VhPaGTkuKW9zM7tJ44VpsdKnObV4wc56DLlSlOhxrnENlEd
	 xyUTKUQefaZL3lPpAHBCiaa9Vom+IcZVs1ZLmN7ovFHvsbGKgxCOH1FVGba/+cIsZM
	 yW+SdEgr+jKzJNGq7LqIbXi/SYh/VOHfmi5uz6xI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 13/13] RDMA/mana_ib: indicate CM support
Date: Mon, 20 Jan 2025 09:27:19 -0800
Message-Id: <1737394039-28772-14-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Set max_mad_size and IB_PORT_CM_SUP capability
to enable connection manager.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 114e391..ae1fb69 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -561,8 +561,10 @@ int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 	immutable->core_cap_flags = RDMA_CORE_PORT_RAW_PACKET;
-	if (port_num == 1)
+	if (port_num == 1) {
 		immutable->core_cap_flags |= RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+		immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+	}
 
 	return 0;
 }
@@ -621,8 +623,11 @@ int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 	props->active_width = IB_WIDTH_4X;
 	props->active_speed = IB_SPEED_EDR;
 	props->pkey_tbl_len = 1;
-	if (port == 1)
+	if (port == 1) {
 		props->gid_tbl_len = 16;
+		props->port_cap_flags = IB_PORT_CM_SUP;
+		props->ip_gids = true;
+	}
 
 	return 0;
 }
-- 
2.43.0


