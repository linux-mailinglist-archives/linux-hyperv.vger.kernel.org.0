Return-Path: <linux-hyperv+bounces-5848-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254ADAD4EBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 10:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8337A8469
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04A23E336;
	Wed, 11 Jun 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SSoLiBgd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3BE2356B3;
	Wed, 11 Jun 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631597; cv=none; b=afY54103yRFjeU8KyDEiSrkLRW/MCUZ+iCkh6RK9RoM8v3qCZGjSTvywsgd6GdLocIxYDKShZFYnIUhn9rAnClNwj59e0u2ToMW0gxn3bvrKsHbyhSv9Sz18L8LToE5JtwAl+O757OXsFiOQiBhLtZGB9S1n+cxHIU1fR5OA3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631597; c=relaxed/simple;
	bh=cqBsvbs3ZIZUC1fgKw3lNAA9UC/rDOE185dFBlKN6mY=;
	h=From:To:Subject:Date:Message-Id; b=phYFCXiUaltmZxLS9W3PKTDY9Gq+ksYllYPFogTMvE2Y/VGuY8h+qYyX793cKdhUaXN7uY7czXzKXGiN2fPet6mo3PUaS3edRyqv8ySx+6WzjjK2iXcQaudKSLsY24gZHbXrMYqRV2vC4N9en3fkCVxWDtEO/OketU+Kg46mkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SSoLiBgd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D406D211518E; Wed, 11 Jun 2025 01:46:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D406D211518E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749631593;
	bh=rhXJ8UOaDpBNqaNF5dD19m9QLA6SObM7FO5Ob+MlG/Q=;
	h=From:To:Subject:Date:From;
	b=SSoLiBgdEpXnbPeqvMCYffckyK0qT1LvSp54+2ur9+zIAHkxc0PGAXatOeE3aE1pA
	 z+cNjkjIWS1uuYhano4XmpkptU4NPccNhPYH6MkB5uGpQ4GwrjotTp+oIzmWDYwuYv
	 Edyck9+lux9P2Hvoin37dH56XiFaSYC2INQpaV4k=
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
	kotaranov@microsoft.com,
	longli@microsoft.com,
	horms@kernel.org,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	rosenp@gmail.com,
	sdf@fomichev.me,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 0/4] Support bandwidth clamping in mana using net shapers
Date: Wed, 11 Jun 2025 01:46:12 -0700
Message-Id: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
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

Erni Sri Satya Vennela (4):
  net: mana: Fix potential deadlocks in mana napi ops
  net: mana: Add support for net_shaper_ops
  net: mana: Add speed support in mana_get_link_ksettings
  net: mana: Handle unsupported HWC commands

 .../net/ethernet/microsoft/mana/hw_channel.c  |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 206 +++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |   6 +
 include/net/mana/mana.h                       |  42 ++++
 4 files changed, 249 insertions(+), 9 deletions(-)

-- 
2.34.1


