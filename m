Return-Path: <linux-hyperv+bounces-7367-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC337C19D79
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C446A1CC1668
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744F2FFDEB;
	Wed, 29 Oct 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jrrgSFug"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8681C861A;
	Wed, 29 Oct 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734275; cv=none; b=Idc1fkttb60AmZRvLjHpFnWaO+UfXDRxe/cnJ3XWB+TZrf5AxmMGZ1P8d6hc0I4fHLH2rgF0ZWlWkI/vFV2rXDib6UGAS74akMUx+g2x8CNFMV/KU4K2MDfvhXShW2vOPwDjXXxamT/I1q/2DFeGqTjHLQkIkdMDNjx+ffa/a7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734275; c=relaxed/simple;
	bh=Ipt2kJVMfyBC6vavSVsAP+eR+Q14fkhSx3nka6tuAbQ=;
	h=From:To:Subject:Date:Message-Id; b=bnOXeX1cKPsHonDowAJvCp+wkstT+vnSxL7i3spcsjxm8tEjjDPSqT2dDSwGAvspIIUqIZRANWvpCWZCr1gQUrgnT/1vcLKkJnEhLJEv88E8YUaWvyaz307YWUhDPHfPE/yocIRxmBJ64Un6DBzAIZT5k2BYwwwjl5PsngVTbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jrrgSFug; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8121220145DE; Wed, 29 Oct 2025 03:37:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8121220145DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761734273;
	bh=80h6HfrWORE7PTyumoXAiEIcX58NZJwYv6oowTzV7NU=;
	h=From:To:Subject:Date:From;
	b=jrrgSFug6DT/Jo5m0hQ8ydaNGvYn3XC98/x1i/80B1FmvOTIzRdMtH/AqiUzCNjMW
	 hipdXIDs0AwVI8tMivRc8gJR1mCK2WaTa5+8nmLPqFqZEyA5RNAd2GvUEZU4RkzFzE
	 nruiNa/EWMfMvR9dgegpVaIaSriZzVd7bOXrqSDk=
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
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	rosenp@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: mana: Refactor GF stats handling and add rx_missed_errors counter
Date: Wed, 29 Oct 2025 03:37:50 -0700
Message-Id: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Restructure mana_query_gf_stats() to operate on the per-VF mana_context,
instead of per-port statistics. Introduce mana_ethtool_hc_stats to
isolate hardware counter statistics and update the
"ethtool -S <interface>" output to expose all relevant counters while
preserving backward compatibility.

Add support for the standard rx_missed_errors counter by mapping it to
the hardware's hc_rx_discards_no_wqe metric. Introduce a
dedicated workqueue that refreshes statistics every 2 seconds, ensuring
timely and consistent updates of hardware counters.

---
Changes in v2:
* Update commit message.
* Stop rescheduling workqueue only when HWC timeout is observed.
* Introduce new variable in mana_context for detecting HWC timeout.
* Warn once in mana_get_stat64 when HWC timeout is observed.
---
Erni Sri Satya Vennela (2):
  net: mana: Refactor GF stats to use global mana_context
  net: mana: Add standard counter rx_missed_errors

 drivers/net/ethernet/microsoft/mana/mana_en.c | 111 ++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  85 ++++++++------
 include/net/mana/gdma.h                       |   6 +-
 include/net/mana/mana.h                       |  18 ++-
 4 files changed, 140 insertions(+), 80 deletions(-)

-- 
2.34.1
--

