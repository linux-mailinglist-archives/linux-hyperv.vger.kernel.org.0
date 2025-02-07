Return-Path: <linux-hyperv+bounces-3854-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF1A2CFCA
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 22:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82FF7A6522
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127C1DE2C6;
	Fri,  7 Feb 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="ME+OdEW/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF21B4F14;
	Fri,  7 Feb 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964187; cv=none; b=VFUY5irlTDV+bE3zC19xvz+1iOWu+kkQMu2oe1hn80vH2q0OFKYOad57qXum7cyd4/JzV2E9etQuU5gorL1/lLZRQqz5lNKOsN1/ldX5sRQjeCk0bTWIRE+Y12h/Bo6RtSvXSJRr7bwZ95ZIwBIrAH79BTVHg3SPkkUDzr2LZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964187; c=relaxed/simple;
	bh=dq8AoIefuUIcX+6Fl38jm6DSCoHVqLFOJQoP9AmB4+0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D4f60pJ9sUzlJnJm23d1w9ie0B0oSj5rYOaaCgxA7+GZi/vBf+1khFvhKwSBpWLd7gTKffKkqKjRKUxKB4afZSKcMjCWQsnmQfxSQcjqjU1/WW3USYve3DV/E8R7tiWT57Gclci0r09wM+Jrf+3wWcIWqClVVuTRDfuabkllzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=ME+OdEW/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 5026A2107308; Fri,  7 Feb 2025 13:36:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5026A2107308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1738964185;
	bh=Ghb8m6Qjf7GD05c82JLyKk+8Oh8Ruz05CDBAoS3gH/E=;
	h=From:To:Cc:Subject:Date:From;
	b=ME+OdEW/ia90/o9xyGz0sk85qh9y6omn8JlFSCv7Qamb1NgzbIIbhELZJqLVsqV3X
	 mKjVqwcmE9Mf8qykPLMg4UX/BFAScc240TW5wEmcV01fATNTMN933lCkSa5+HIxJvq
	 avopxRmtZCORl4glanKVDnKDAZbdlwfDMozo9VLY=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2 0/3] IB/core: Fix GID cache for bonded net devices
Date: Fri,  7 Feb 2025 13:36:15 -0800
Message-Id: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When populating GID cache for net devices in a bonded setup, it should use the master device's
address whenever applicable.

The current code has some incorrect behaviors when dealing with bonded devices:
1. It adds IP of bonded slave to the GID cache when the device is already bonded
2. It adds IP of bonded slave to the GID cache when the device becomes bonded (via NETDEV_CHANGEUPPER notifier)
3. When a bonded slave device is unbonded, it doesn't add its IP to the default table in GID cache.

The patchset fixes those issues.

Changes log:
v2: Added cover letter explaining the overall problem and current behaviors.

Long Li (3):
  IB/core: Do not use netdev IP if it is a bonded slave
  IB/core: Use upper_device_filter to add upper ips
  IB/core: Add default IP when a slave is unlinked

 drivers/infiniband/core/roce_gid_mgmt.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.34.1


