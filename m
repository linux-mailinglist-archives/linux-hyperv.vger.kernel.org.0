Return-Path: <linux-hyperv+bounces-5912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDA8AD93E9
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A5C3B9E02
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7122D4C5;
	Fri, 13 Jun 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="kLU+ljCi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D429229B1F;
	Fri, 13 Jun 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836768; cv=none; b=U8pFZX2ZeMVzfDPkzA4Zuqf9jS97sVFyAB9XwE6xJaxOL43A0HlbUwyOf5EajaEd6ohFt0wPxeFp4WKF5mZFPN3vXyvLBTrDVNCChzZdTV1qsW6u2ektaBFwtP5vs7m1EFALjyAdinm3AEDQR8uWuCnQu0jwa9pRsCf+RIhuBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836768; c=relaxed/simple;
	bh=9/OROHOU0d5H6AaQmhQJwXfenk0HE8Iz8C97u9uaoas=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UPBMLhsIrBLLDJE9Tr1jgD04cZjcBbEM4e1aSWmBDVEr++pFE+TcyubjK+rssn6kgg/3+mQayDpg6cM+d+RDCm7rQvYEyaUjDgoLIglYB2ezHrv+6Vd8/HSyX1VN0cx7LUWcIJOdR+FWn8iVycsUIsvTbKAH8Vk+epPIB2H3XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=kLU+ljCi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D3E812115198; Fri, 13 Jun 2025 10:46:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3E812115198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1749836766;
	bh=rodYPJvZe1E9/OuzpNcjCvCD37LtJfgG2pZAezDxKpM=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=kLU+ljCiwonkzBrHYoXeiCJwBuGj0s1P8xJ/qmSpqywUW3C/olx+FdemyGspFjfWc
	 AQmKX8Kllsc39Lpg4l+1EC654WsJueo9c85WxBDti/Q9cFFplxTj/3wPb5nkYQWhrn
	 wDSU/Vo1Dy0ZN/cEQWNWFrXj8oIeLiP9Vmjc8pI0=
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
Subject: [Patch net-next v2] net: mana: Record doorbell physical address in PF mode
Date: Fri, 13 Jun 2025 10:46:05 -0700
Message-Id: <1749836765-28886-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

MANA supports RDMA in PF mode. The driver should record the doorbell
physical address when in PF mode.

The doorbell physical address is used by the RDMA driver to map
doorbell pages of the device to user-mode applications through RDMA
verbs interface. In the past, they have been mapped to user-mode while
the device is in VF mode. With the support for PF mode implemented,
also expose those pages in PF mode.

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes
v2: add more details in commit message on how the doorbell physical address is used

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 3504507477c6..52cf7112762c 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -31,6 +31,9 @@ static void mana_gd_init_pf_regs(struct pci_dev *pdev)
 	gc->db_page_base = gc->bar0_va +
 				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
 
+	gc->phys_db_page_base = gc->bar0_pa +
+				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
+
 	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
 
 	sriov_base_va = gc->bar0_va + sriov_base_off;
-- 
2.25.1


