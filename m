Return-Path: <linux-hyperv+bounces-3958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26964A37A1E
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Feb 2025 04:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC6E16C4B8
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Feb 2025 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B414F9E2;
	Mon, 17 Feb 2025 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RESYF2nt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E714830A;
	Mon, 17 Feb 2025 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763726; cv=none; b=An+WjrZPl2zzmmqzdUOhk4noOtHIzc+pllRQVIyhPQsmzvl6tVnV4KmhGy1Yd1JxcjMmjHdg54a0nSt5u6ZIF+oUxJHVSpRdWgxLbwWhD1XaxAmXd8WVmSQeFmu6Sc3nJ/8VSMPAFPgJGB519QDS9UNTV5O3oh+bGXkYiRiebPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763726; c=relaxed/simple;
	bh=nFRz33pZDdYKoIgCSNbmAjNPXKDpTgw5xS0fOwY6650=;
	h=From:To:Cc:Subject:Date:Message-Id; b=j/GV65xGHgJTITr7Nw9JvaxF2XDjR0sQ6WYyfgUcpuMVKe4Q/jfFT+mDl9sb4thSAtA2XkQSEzn0SoGiAVaHE7xUu/iLA+gDRWV1X2+FlP5lIb4IalMB6pSFSLDibQ0Sk5M4UzpJXuA9SyEBJ8/vdvqs7dLOVR5Zw/b/tAOokck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RESYF2nt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id EE619204E5B1; Sun, 16 Feb 2025 19:41:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE619204E5B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739763717;
	bh=fe/NmGDSrG9kSdwdZWOkLN7uCK3xvQGUhrEoj3ZtctQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RESYF2ntx+iJ/gVz9DuCYezo1Nr+GY0O5DMbKDAmZWG31eQyV9PesH9dYtxI+1Vmw
	 N6/batbsLxomziPM4VM4OIvMLcBKv4EN8cSAcgKljSTUDumahuD3YCwAtbPMkdCyTr
	 40exGezdp+HLN/BcuDI3jW7eLFulYDNEtPCBxZck=
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
Subject: [PATCH v3 net-next 0/2] Enable Big TCP for MANA devices
Date: Sun, 16 Feb 2025 19:41:55 -0800
Message-Id: <1739763715-28412-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow the max gso/gro aggregated pkt size to go up to GSO_MAX_SIZE for
MANA NIC. On Azure, this not possible without allowing the same for
netvsc NIC (as the NICs are bonded together).
Therefore, we use netif_set_tso_max_size() to set max aggregated pkt
size
to VF's tso_max_size for netvsc too, when the data path is switched over
to the VF

The first patch allows MANA to configure aggregated pkt size of up-to
GSO_MAX_SIZE

The second patch enables the same on the netvsc NIC, if the data path
for the bonded NIC is switched to the VF

---
 Changes in v3
 * Add ipv6_hopopt_jumbo_remove() while sending Big TCP packets
---
  Changes in v2
  * Instead of using 'tcp segment' throughout the patch used the words
    'aggregated pkt size'
---

Shradha Gupta (2):
  net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE
  hv_netvsc: Use VF's tso_max_size value when data path is VF

 drivers/net/ethernet/microsoft/mana/mana_en.c |  5 +++++
 drivers/net/hyperv/hyperv_net.h               |  2 ++
 drivers/net/hyperv/netvsc_drv.c               | 15 +++++++++++++++
 drivers/net/hyperv/rndis_filter.c             | 13 +++++++------
 4 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.34.1


