Return-Path: <linux-hyperv+bounces-4978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E29A94C90
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 08:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D263AAB25
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318B20D4F9;
	Mon, 21 Apr 2025 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L2V2YCr8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3932110;
	Mon, 21 Apr 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745217225; cv=none; b=j28XLFQqan2MiH5y5yaesNb065l9/THjiehXJIAnFqoJTlQ6JDBte3K1Xe/Tfq+K5lpES3bgp3VKNvKsrJHfFzh6JJojNPlHKfHu8wdhVxSxjIJ/eFJ14HygByqsOkcUXUV16Ais/yfAeq2NWZqv8TZhnnjLz4M7I0oo86oDi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745217225; c=relaxed/simple;
	bh=j/Vw2G+VjM1+h4gptLRgRv/M5MBFTvylxUyExbCn99s=;
	h=From:To:Subject:Date:Message-Id; b=P/ui+Hjgho4+jqNfLaczvQFQzuxeIuVYe7xSaudsKNcsqFCtr/DKYjsEhjRTib1NdJKsmwzDHuFiIH9ckENdIPRcfJyavDlWPPIlcr5R5nmyt3Noprtg0bhAkDkpO3LdeBoD9EN4hdQdkWlac806M3kfziFlUpFMVweEzLB9CRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L2V2YCr8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C01F0203B848; Sun, 20 Apr 2025 23:33:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C01F0203B848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745217222;
	bh=SuSunARB7xTcRbogkHTN30O8aKzzfUDRXpW52WZtbTs=;
	h=From:To:Subject:Date:From;
	b=L2V2YCr8LMiSiS21+xgeRnvYrhTnk9jGE0gnVaN10ZXy1nAWSyBnK+7G8yyUmO5fz
	 9ZB8+MbsQeYYemnBCAp3N4IiDtgFfqMylUqX4KGp8aqIGjUBIpmywqW4suupnIbeiP
	 Zx67wy+MprsmIPfPQRltmOFaQMaunlOYSC7RAuMc=
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
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	mhklinux@outlook.com,
	pasha.tatashin@soleen.com,
	ernis@linux.microsoft.com,
	kent.overstreet@linux.dev,
	brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	leon@kernel.org,
	rosenp@gmail.com,
	paulros@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v2 0/3] net: mana: Add HTB Qdisc offload support
Date: Sun, 20 Apr 2025 23:33:37 -0700
Message-Id: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Introduce support for HTB Qdisc offload on the mana ethernet 
controller to enable bandwidth clamping for egress traffic.

The controller offloads only one HTB leaf to support bandwidth
clamping on the hardware. This involves calling the function 
mana_set_bw_clamp() which internally calls a HWC command 
to the hardware to set the speed.

The minimum supported bandwidth is 100 Mbps, and only multiples
of 100 Mbps are supported by the hardware. The speed will be reset to
maximum bandwidth supported by the SKU, when the HTB leaf is deleted.

Also add speed support in mana_get_link_ksettings to display speed in the
standard port information using ethtool. This involves calling
mana_query_link_config(), which internally sends a HWC command to
the hardware to query speed information.

Note that this feature is not supported by all hardware.

---
Changes in v2:
* Use -EOPNOTSUPP instead of -EPROTO in mana_query_link_cfg() 
  and mana_set_bw_clamp()
* Change link_speed to link_speed_mbps in struct mana_set_bw_clamp_req.
---
Erni Sri Satya Vennela (3):
  net: mana: Add speed support in mana_get_link_ksettings
  net: mana: Add sched HTB offload support
  net: mana: Handle unsupported HWC commands

 .../net/ethernet/microsoft/mana/hw_channel.c  |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 191 ++++++++++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    |   6 +
 include/net/mana/mana.h                       |  36 ++++
 4 files changed, 237 insertions(+)

-- 
2.34.1


