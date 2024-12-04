Return-Path: <linux-hyperv+bounces-3394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F919E334E
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 06:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BCEB21587
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82717BB0F;
	Wed,  4 Dec 2024 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="awHI/dA7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132E155398;
	Wed,  4 Dec 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291355; cv=none; b=RyZAE9qLY9c5vnVrbJjWOr3MBJm3G+vSDEPI2F7HL9b/mLVPztEIl0VMrMgBIIXDsYhNP9Q/J37Slj1pmjRxrcS1GghifuZQ4NbrBxdAoG9DONTHwKZg3P+nJ0LPrJPVeFBxjXYPLpoHpdXE4RLiNaBUdatBRGZzaCq3PycEsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291355; c=relaxed/simple;
	bh=IkEZtadZftKjRqH9yhts5fEPqBDe38sXpY9gxB7o5Mc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dKKBqaYPE2kMJAJgZFQDxANe8ceKzvoX4Un9r63YJniKOJhLM6AgkhAahsxCC0Fdh0P4CbPDb/TPzb76vErZtfwccNe0+sNoJEBzq4+G6D+AAp84u/+AQPsfO/QvkxnNQTdLgoR2lwBjL76PvBt/zqEoe7sSz48ZBE/3zV+zmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=awHI/dA7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E66E120BCAE6; Tue,  3 Dec 2024 21:49:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E66E120BCAE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733291353;
	bh=WO1k8Du3NxHFMes7jiIFdn5k2SdK8KHlt0QIB6oFTsM=;
	h=From:To:Cc:Subject:Date:From;
	b=awHI/dA7tv/s5c6Ko1jjxO/b8h9g0EdFwF3Gko9BwbyI3WTUOmtJq+tiIgbtAlNWB
	 0ML7L58npWa3taJFWWeXKCkwhndc55LCdO3wx1zye7sOi1SOk8kaZmxtbx5pSF0Uwb
	 /2rnkyZsXPFKIoQiT7hd+mULCXskH/aDyOTvuVFg=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net :mana :Request a V2 response version for MANA_QUERY_GF_STAT
Date: Tue,  3 Dec 2024 21:48:20 -0800
Message-Id: <1733291300-12593-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The current requested response version(V1) for MANA_QUERY_GF_STAT query
results in STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR value being set to
0 always.
In order to get the correct value for this counter we request the response
version to be V2.

Cc: stable@vger.kernel.org
Fixes: e1df5202e879 ("net :mana :Add remaining GDMA stats for MANA to ethtool")
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 57ac732e7707..f73848a4feb3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2536,6 +2536,7 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_GF_STAT,
 			     sizeof(req), sizeof(resp));
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
 	req.req_stats = STATISTICS_FLAGS_RX_DISCARDS_NO_WQE |
 			STATISTICS_FLAGS_RX_ERRORS_VPORT_DISABLED |
 			STATISTICS_FLAGS_HC_RX_BYTES |
-- 
2.43.0


