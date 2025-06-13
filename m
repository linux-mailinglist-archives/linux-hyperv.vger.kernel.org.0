Return-Path: <linux-hyperv+bounces-5901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90CAD8A35
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2E8189BF08
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBA2D5C79;
	Fri, 13 Jun 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nmZYjc+2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43E1DF258;
	Fri, 13 Jun 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813631; cv=none; b=LwEEaEqexKTSwUINe1KIrZ9rhyy+y6cP9iM4KG9vXuGIhCp9WDF+cs+oQHkY9A03OM8ui8y2Vv7Diz4zu+oQOqWYJIY+GnYEpmwrvSOKPmFWc7mvp39hnFLH1JZFYeygRz/L7jkQ9WA12Dsz43NMdi6mhQhzDx8r7cm/QFeEEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813631; c=relaxed/simple;
	bh=YFL0KvvYSxPtW6cWPQRbh9UKr+0LsCtTqDFE29TqjiM=;
	h=From:To:Subject:Date:Message-Id; b=aU16USjymsp/iZTZTcbSpGkJIyX7jPa3N2OmnUREqLgkHCgBvAVJkCEafT+xSvGv1z540IoRtO1aZrBt6Fugoo9DTn1w36VY/TD7lj7acehbU3YnpXinyjVe1ZKp3HEiDcYMa+swFbb8lbavBsjFxlVa/shNCdlCqqBhbWE4RzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nmZYjc+2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 35C52203EE35; Fri, 13 Jun 2025 04:20:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35C52203EE35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749813629;
	bh=3a1gAuEbwTI+8JwlIvaZK19uNGJ1iK1P1/Xir104Ikk=;
	h=From:To:Subject:Date:From;
	b=nmZYjc+2xeMeGixVvs92OpjPM90ypwqEHxdSYk4oiImjXfNqhgJm6F1u4g5X+kv9m
	 OLYZwyCyIj9yX2//xGO8II41QHSKN1cZE/Pv1hom8/8bmkR7xy6rBBIcU4AXQZsh+p
	 sj2qbDM1NfebhSXqsAEIChEoY97JTos2rhCTlX/Q=
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
Subject: [PATCH net-next v2 0/4] Support bandwidth clamping in mana using net shapers
Date: Fri, 13 Jun 2025 04:20:23 -0700
Message-Id: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
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
 drivers/net/ethernet/microsoft/mana/mana_en.c | 197 +++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |   6 +
 include/net/mana/gdma.h                       |   1 +
 include/net/mana/mana.h                       |  42 ++++
 5 files changed, 241 insertions(+), 9 deletions(-)

-- 
2.34.1


