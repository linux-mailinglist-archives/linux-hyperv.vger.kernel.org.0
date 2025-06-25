Return-Path: <linux-hyperv+bounces-5999-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB0AE81A1
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB0C3B535B
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060B25B30F;
	Wed, 25 Jun 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UDwmWqK6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B269A48;
	Wed, 25 Jun 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851365; cv=none; b=Lo+bRzZFvIYzb48bz+oxveFV1Dre0HF6o9PdjfQIa4oZfKGdPiMKXKCeBo8lQIsUMscDqmz1JulkvWaOyEXRyTIQZP77C+BtB+SUUfoAM1ezm8GQE22pveL7ogKkR7JTDLWqBzqB67KQJ81/Yb02sObXaDJimlCSovw36pWBPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851365; c=relaxed/simple;
	bh=HPAZP2mDBSUpiPdOgFiFNniYmfiyMSDNC9075WN/XYw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=u1EsOHamwSjpagVTewJqS/pcfNeNF+qDomXIkkj36kIsxRPLlzKsshZK/VicUQhszWwoJV6a1EGbbR08tEOVvva0g9o+MyMjeIYjzlaXRqvbvQpv53CajZsT0AbA7zmF2K1aP5RuofsblaKfFEM1IeFpmELI1aEczuuRDNAz3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UDwmWqK6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B92DF20415B3; Wed, 25 Jun 2025 04:36:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B92DF20415B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750851363;
	bh=gYKM1ICbb6G+pT1X38BoQUl/Ur/WSscTcd4nsAD1m60=;
	h=From:To:Cc:Subject:Date:From;
	b=UDwmWqK69U2+vV8t18P4fWz3rUcUX0xW/Ou29CmOAayf56ErEPrfNbs4jozMTa8yx
	 Cq1bf4cZHCdWFQhyNuzC40Om+obehJ6qYuVKpQt5D1fMfgkp1yc7jkDUluqxsbZr4R
	 cBoqvHTo+fH9ipL4gGHWO8+LBbgxwRyQKQV6Ig8M=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH net-next v2] net: mana: Fix build errors when CONFIG_NET_SHAPER is disabled
Date: Wed, 25 Jun 2025 04:35:55 -0700
Message-Id: <1750851355-8067-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix build errors when CONFIG_NET_SHAPER is disabled, including:

drivers/net/ethernet/microsoft/mana/mana_en.c:804:10: error:
'const struct net_device_ops' has no member named 'net_shaper_ops'

     804 |         .net_shaper_ops         = &mana_shaper_ops,

drivers/net/ethernet/microsoft/mana/mana_en.c:804:35: error:
initialization of 'int (*)(struct net_device *, struct neigh_parms *)'
from incompatible pointer type 'const struct net_shaper_ops *'
[-Werror=incompatible-pointer-types]

     804 |         .net_shaper_ops         = &mana_shaper_ops,

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506230625.bfUlqb8o-lkp@intel.com/
---
Changes in v2:
* Use "select NET_SHAPER" in Kconfig instead of adding multiple checks for
  CONFIG_NET_SHAPER.
---
 drivers/net/ethernet/microsoft/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 901fbffbf718..3f36ee6a8ece 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -22,6 +22,7 @@ config MICROSOFT_MANA
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
 	select PAGE_POOL
+	select NET_SHAPER
 	help
 	  This driver supports Microsoft Azure Network Adapter (MANA).
 	  So far, the driver is only supported on X86_64.
-- 
2.34.1


