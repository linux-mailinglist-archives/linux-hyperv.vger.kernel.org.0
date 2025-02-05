Return-Path: <linux-hyperv+bounces-3836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DCA28353
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E0B7A28C2
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 04:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E73215175;
	Wed,  5 Feb 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DgyAxN+r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579D21481F;
	Wed,  5 Feb 2025 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738729264; cv=none; b=Phpp4AuX/n1vMEFqP9hjiP73UatQIrxjFrdfOaH/DVRbh9/juDWDe95EeZ5q8aDGAEpcwp3SGOJ5L6r2VjXgogGuq4c/E9PWoGRVPHprRrQ7lKQke8eGMCM/G5T7rCrtXvwr0vLE/kVMlEeZ0EwN3CJR4GHBHlCtmmmvMbhlTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738729264; c=relaxed/simple;
	bh=Ncnwhdnai8F2UFNn0ceZPOYMh3yxbZjif05p6VUmy1k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=u4NY6PVDg6eu14GuqfHxtCpYJtEWjPiIqx/15W6i9VR/W89Ekb7qxxzZDoP7T0Qqag/AskRSg2B2HlfQG/EX+OiLxhNiVQPeoZpILR5KZ15VAZNvxMOn+lSLi2mZRbbizRYCi/w/+OAH1/Ljt9WH4cPf3wnF6NLLbT2csYJQv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DgyAxN+r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 06F38203F584; Tue,  4 Feb 2025 20:21:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06F38203F584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738729262;
	bh=i4lNRCzC3NTgrbCCA6ZfJRi1ePZ5nC2wD7kfolAi8zY=;
	h=From:To:Cc:Subject:Date:From;
	b=DgyAxN+rFBS0FtLW8rhieBeVGIKjzi7ljgQbL5tnDXBA876q8Bl2ZORyS4WBWaJCa
	 O7sbK/DbCDLLVfyhJMdHjUi0XQoReD0h1PYPVz0EvseRoMg+EqP6W0dB3eKiC6xI8b
	 p8vgp8dH+yX14ZIPKNpG4uPry2+Yj4xGtLUpqnNk=
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
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH 0/2] Enable Big TCP for MANA devices
Date: Tue,  4 Feb 2025 20:20:57 -0800
Message-Id: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow the max TCP segment size to go up to GSO_MAX_SIZE for MANA NIC.
On Azure, this not possible without allowing the same for netvsc NIC
(as the NICs are bonded together).
Therefore, we use netif_set_tso_max_size() to set max segment size
to VF's tso_max_size for netvsc too, when the data path is switched over
to the VF

The first patch allows MANA to configure segment size of up-to
GSO_MAX_SIZE

The second patch enables the same on the netvsc NIC, if the data path
for the bonded NIC is switched to the VF


Shradha Gupta (2):
  net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE in MANA
  hv_netvsc: Use VF's tso_max_size value when data path is VF

 drivers/net/ethernet/microsoft/mana/mana_en.c |  2 ++
 drivers/net/hyperv/hyperv_net.h               |  2 ++
 drivers/net/hyperv/netvsc_drv.c               | 15 +++++++++++++++
 drivers/net/hyperv/rndis_filter.c             | 13 +++++++------
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.34.1


