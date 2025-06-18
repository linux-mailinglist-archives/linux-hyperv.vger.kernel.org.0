Return-Path: <linux-hyperv+bounces-5942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3EADE0B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 03:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC93A3D8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 01:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4953191F66;
	Wed, 18 Jun 2025 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="DYQSFL0K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB54A1D;
	Wed, 18 Jun 2025 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210612; cv=none; b=j2CGyFyBVQQI9AJ+cf2V/8M4HygFDAoepIB4xO6A76eb40jb8DvFpQUf3XI6m+UgbNyTKctSXQaG1V0NqoyANbj/ldR5NMnMuSFg45cOAVcgvICk7utEJw3WYncDXfJZJzhZTGZ+dCWhn89R1LrlNgcb0UdNlcLSb4u2/vC/I4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210612; c=relaxed/simple;
	bh=0YXcTlTA8MQJecj8M0ciHnHSxcN58n9/4eqEv7wyl8w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fTYXHzdajNNHBSqTRM48AjDX3ekS4rS3Q8ZF6wFVqMagcHcKw7PQ9iK3Y2dgd44ag+Akck900eKKtZTOn9EfVgOgMzfX5NHaSAn20ZpaHop8QhpZKs2v+UgnYQLGVKLgFptNumeYti+yT2IHGD3P6jxYfSi3xQjf/DX4RmfBkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=DYQSFL0K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id CABE0201FF46; Tue, 17 Jun 2025 18:36:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CABE0201FF46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1750210610;
	bh=1h0AInxYHYfF4/KB+FPDZESjCJlmWWe6zwOwKGbLEP4=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=DYQSFL0KzEfpSDh+MpS0jQgGHPN0cyzAZRe5jfVhgtP6OrFYIAYzqsmTJWJGwI5TM
	 tyjblO/eNd7CVbKIDRXpJ8/xStjpyJQ+w2nkKiy5FLraqilAs9BCEshakh7F3nQdQd
	 87/NM5r3pt52sJSiz4EUT17udVQUCtNWjjT0TT0s=
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
Subject: [Patch net-next v3] net: mana: Record doorbell physical address in PF mode
Date: Tue, 17 Jun 2025 18:36:46 -0700
Message-Id: <1750210606-12167-1-git-send-email-longli@linuxonhyperv.com>
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

Support for PF mode is implemented in
290e5d3c49f6 ("net: mana: Add support for Multi Vports on Bare metal")

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes
v2: add more details in commit message on how the doorbell physical address is used
v3: add the early commit detail where the support for PF mode is implemented

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


