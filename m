Return-Path: <linux-hyperv+bounces-6863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B8B56F1C
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Sep 2025 05:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015253A3508
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Sep 2025 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93A26B2D3;
	Mon, 15 Sep 2025 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fpSUvaDH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF48CA4B;
	Mon, 15 Sep 2025 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908706; cv=none; b=iStSWY+jK9tFJ4g1088PRo9RX6cXOb5/PknuppoTp1ZVzQPUc/lQw1H2LgyUGtH0fCPmGhAgWVuf7cB5DfqHExzKGcpFxfuMD+Cfu3068MAsrBd26M5qOKZQdSYOtTnsn+w4kKAGtfIov2/nddApdrIZshHSshLN1rAxiJmgOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908706; c=relaxed/simple;
	bh=eQXd8WE1slsqzQ4D/oh533MIIe4WbrlpnsbNNf1j6bU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dy7FfJpQCvznS9k3PI/NhO03Vs5eIMD3xujNGFDpO4lvaGXWuw6pa71aOjiHbxTAcbo4b0G9mglco0rV2k7xgn+W+mgehFAmRwnSLejLYVeSkAKygVkyBfURKFY8B3BuI4sgwob/1WIDRQCc7yFZ0R5L35pLvhjNQzWFBOkfhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fpSUvaDH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C5F522018E7E; Sun, 14 Sep 2025 20:58:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5F522018E7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757908699;
	bh=qYawJ8GkKFZFNfk+9P8j7vr67iRHbv579PHSqOV62PE=;
	h=From:To:Subject:Date:From;
	b=fpSUvaDHnsb1daVaOhLz7WzmNG1pDW2IcV4MfcwbSJRecOKFKs0WL4d0q4Ui/X35E
	 3DM4AbFOpC6SMxctSW6o6sBlHEXTrsUI+2cOG1klaXyn/lXCxJbpVRLOfGxNRVbeea
	 o5qmdG5cP32jj86TvmvrtsxML7MLgBxUlJ1lslaY=
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
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	ernis@linux.microsoft.com,
	rosenp@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 0/2] net: mana: Refactor GF stats handling and add rx_missed_errors counter
Date: Sun, 14 Sep 2025 20:58:16 -0700
Message-Id: <1757908698-16778-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Restructure mana_query_gf_stats() to operate on the per-VF mana_context,
instead of per-port statistics. Introduce mana_ethtool_hc_stats to
isolate hardware counter statistics and update the
"ethtool -S <interface>" output to expose all relevant counters while
preserving backward compatibility.

Add support for the standard rx_missed_errors counter by mapping it to
the hardware’s hc_rx_discards_no_wqe metric. Introduce a
dedicated workqueue that refreshes statistics every 2 seconds, ensuring
timely and consistent updates of hardware counters.

Erni Sri Satya Vennela (2):
  net: mana: Refactor GF stats to use global mana_context
  net: mana: Add standard counter rx_missed_errors

 drivers/net/ethernet/microsoft/mana/mana_en.c | 103 ++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  85 ++++++++-------
 include/net/mana/gdma.h                       |   6 +-
 include/net/mana/mana.h                       |  17 ++-
 4 files changed, 131 insertions(+), 80 deletions(-)

-- 
2.34.1


