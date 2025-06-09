Return-Path: <linux-hyperv+bounces-5816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC3AD2A4B
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00885170DF6
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DBF227BA5;
	Mon,  9 Jun 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="ZH1AqCgd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2AD226D09;
	Mon,  9 Jun 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510597; cv=none; b=AizPRPhifN2kJ+ptVjR9j8HhHUdiiCqKJBw/9+3Fiao4AaAhGHSrcu2M4atB2BE20jvkcdtyJvIu0O6r6WULxkUJ7JAto/H7xHG6OF/131lQv9kOLetfwKLSyRBOBqDvYRxKO7eNwseVyOGUbFIhPP9PWIWOuG29xDpdJ7nWt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510597; c=relaxed/simple;
	bh=TJHn+xrGIoG5X5uuAIOvVOsYlBHH6Fh+hKmZRMoOHF4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r8BXqIXPKCKmJXS4r0lDtgT7sQLgnlITPK7o4uGJKkqdeDnvsp+GUagx8ggD/rcmdcZswO5AGrz/+dZZ+1gdQv8mdYa6lC//rAJb7VQ1bHnhCG9/kYeW5eQ2Z9wlRXjgacLDinMkIl91LHb9kZg7PH1VmWzG35bGsa+8Ji8Q8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=ZH1AqCgd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id BF4582117585; Mon,  9 Jun 2025 16:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF4582117585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1749510595;
	bh=o4TJdFyGSavIpC6NVIXpJYvJt9fYZsYcucpFDPtb1k0=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=ZH1AqCgdgKQQpNUXcLrN9QnH6K6JjugB2TUsOFvP53brqkxVV1jcxJbadsbAxvbfW
	 l/zGRCD+hts4sDWr+hs/WbdqpHSIpT4kJ9HrSaSzrXyo0pmL7fw9pJJfoLspD6LhRd
	 UPDogOP8n1N4ao8PhmyaZtpmrWt2gn0ZD1NPtomc=
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
Subject: [PATCH net-next] net: mana: Record doorbell physical address in PF mode
Date: Mon,  9 Jun 2025 16:09:40 -0700
Message-Id: <1749510580-21011-1-git-send-email-longli@linuxonhyperv.com>
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

Signed-off-by: Long Li <longli@microsoft.com>
---
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


