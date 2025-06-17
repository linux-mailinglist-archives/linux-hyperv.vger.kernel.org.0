Return-Path: <linux-hyperv+bounces-5928-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27483ADC30E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 09:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06673A486C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3728CF61;
	Tue, 17 Jun 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B57Lma2R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF619047F;
	Tue, 17 Jun 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144659; cv=none; b=VEb923QR/mXGGFSIfIUQvke4gYw547xUa3pe5BGmowf0PkeWLaKk6PxhgA8JoWQi31Ed32QhN3mrUTq0skiGeJ75ngq7x+kzqjmcHeqxzKFsuCPY20ytGRPLrV9h1Kg5m6gg+/ZW2MHlkabrlKr4MvtckdawF0z5z1M0zi0wzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144659; c=relaxed/simple;
	bh=2rfjUwljpq6lfP6aRy48nPemWSdSPNEnk5Y8LaQi5PQ=;
	h=From:To:Subject:Date:Message-Id; b=fbqileCAELp2Kdb4aqRytsyXPFkoR7Mvt1Ym1sVnHvXYrqbctYmYNa1O83t5A1j7+hxLmIy+7XwKh33SMkPpTqgokpZLyRzOMIhrOSOa0FKC0ohe6bHc5M59AzvAn5TkeHBI8ikVOgb+7OghmEVteyxL3aF91jMzMZSkhdts1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B57Lma2R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id E084921176CF; Tue, 17 Jun 2025 00:17:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E084921176CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750144657;
	bh=weF3yKoTKdcOMTc4ydobzbEwibvl4cotrKvGlNXjCMU=;
	h=From:To:Subject:Date:From;
	b=B57Lma2RP49kAiNdItVFVkyNpPlhmdbWUgWwXVb6YQMeA7n3pOAcyxE7wgtTha3mX
	 Z///KoidxMFUdPaeUHb+gWHRVix77BWrVN1g8ydlXYJ9kM6++2wxVomafuP+g9Qm34
	 8JRb1LxCPPMWcg89tGpMtuT/M23GJOk8k+xLft2Q=
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
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	gerhard@engleder-embedded.com,
	rosenp@gmail.com,
	sdf@fomichev.me,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 0/4] Support bandwidth clamping in mana using net shapers 
Date: Tue, 17 Jun 2025 00:17:32 -0700
Message-Id: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This patchset introduces hardware-backed bandwidth rate limiting
for MANA NICs via the net_shaper_ops interface, enabling efficient and
fine-grained traffic shaping directly on the device.

Previously, MANA lacked a mechanism for user-configurable bandwidth
control. With this addition, users can now configure shaping parameters,
allowing better traffic management and performance isolation.

The implementation includes the net_shaper_ops callbacks in the MANA
driver and supports one shaper per vport. Add shaping support via
mana_set_bw_clamp(), allowing the configuration of bandwidth rates
in 100 Mbps increments (minimum 100 Mbps). The driver validates input
and rejects unsupported values. On failure, it restores the previous
configuration which is queried using mana_query_link_cfg() or
retains the current state.

To prevent potential deadlocks introduced by net_shaper_ops, switch to
_locked variants of NAPI APIs when netdevops_lock is held during
VF setup and teardown.

Also, Add support for ethtool get_link_ksettings to report the maximum
link speed supported by the SKU in mbps.

These APIs when invoked on hardware that are older or that do
not support these APIs, the speed would be reported as UNKNOWN and
the net-shaper calls to set speed would fail.
---
Changes in v3:
* Rebase to latest net-next branch.
Changes in v2:
* Rebase to latest net-next branch.
* Edit commit message in
  "net: mana: Fix potential deadlocks in mana napi ops".
* Use netdev_lock_ops_to_full() instead of explicit if..else statements
  for napi APIs.
* Define GDMA_STATUS_CMD_UNSUPPORTED for unsupported HWC status code.
---

Erni Sri Satya Vennela (4):
  net: mana: Fix potential deadlocks in mana napi ops
  net: mana: Add support for net_shaper_ops
  net: mana: Add speed support in mana_get_link_ksettings
  net: mana: Handle unsupported HWC commands

 .../net/ethernet/microsoft/mana/hw_channel.c  |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 195 +++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |   6 +
 include/net/mana/gdma.h                       |   1 +
 include/net/mana/mana.h                       |  42 ++++
 5 files changed, 239 insertions(+), 9 deletions(-)

-- 
2.34.1


