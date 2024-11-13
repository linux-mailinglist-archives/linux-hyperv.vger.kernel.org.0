Return-Path: <linux-hyperv+bounces-3331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22169C6AD3
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2024 09:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EA81F2472F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2024 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322A18A95F;
	Wed, 13 Nov 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a3783b2q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46EC17DFFC;
	Wed, 13 Nov 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487635; cv=none; b=SYfai05BJqcd+mzd9rHgS+H8rny3yfNfCU9D4PDS8ehfC50CJPLxHPvVhMTrQpHagcaicNrgcJVNEExekyTSAy6MAdMnFY8ZnZFVH7IcXo2JsSsVXtNbKJ8SVVNASO22Lal8sEUNBSz4IXTiixcl0PdYDqPRNbGv7u7KOid+GMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487635; c=relaxed/simple;
	bh=dj2j/+GbeBebCExsmXp6+KgVP0ieIsa2ZQqlwQLxk4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPuBQjENK91yRIFqe99B1AixCOb5vCAIDeS/q23hksTP8afTL3MF+bc8VqicuIb3O+A4Xw+et3hRXA9Q9gay4PK9+r6Mur8nWtX46/w65p9vehwJUL1Vkg7AxFH3LQ/eUmKHhCd0RRl8PgtBjjgHcPCl/WI5b8eYDFwIieQ4xmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a3783b2q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id F01B120BEBCC;
	Wed, 13 Nov 2024 00:47:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F01B120BEBCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731487627;
	bh=5ekCycVyIGv7lPjAwHwoxDtRYgLgAEMMdZsg+X4GV8w=;
	h=From:To:Cc:Subject:Date:From;
	b=a3783b2qyvXTCv9ME+bN9JwSeMquHS+hW2SuaqWC559eWmvJgllhVfG7bg0HJcW0l
	 RAOHxQ9/tpbEeKO1oC8fncnA5QsXMAtrWLrmgYLutisuJ3uZub+AZLwlPS63jooq8h
	 yNlKt0S/ksa9XSw8en0wSFzDA5VoukP9UZECEyYw=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naman Jain <namjain@linux.microsoft.com>,
	John Starks <jostarks@microsoft.com>,
	jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v3 0/2] Drivers: hv: vmbus: Wait for boot-time offers and log missing offers
Date: Wed, 13 Nov 2024 00:46:58 -0800
Message-Id: <20241113084700.2940-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After VM requests for channel offers during boot or resume from
hibernation, host offers the devices that the VM is configured with and
then sends a separate message indicating that all the boot-time channel
offers are delivered. Wait for this message to make this boot-time offers
request and receipt process synchronous.

Without this, user mode can race with VMBus initialization and miss
channel offers. User mode has no way to work around this other than
sleeping for a while, since there is no way to know when VMBus has
finished processing boot-time offers.

This is in analogy to a PCI bus not returning from probe until it has
scanned all devices on the bus.

As part of this implementation, some code cleanup is also done for the
logic which becomes redundant due to this change.

Second patch prints the channels which are not offered when resume
happens from hibernation to supply more information to the end user.

Changes since v2:
https://lore.kernel.org/all/20241029080147.52749-1-namjain@linux.microsoft.com/
* Incorporated Easwar's suggestion to use secs_to_jiffies() as his
  changes are now merged.
* Addressed Michael's comments:
  * Used boot-time offers/channels/devices to maintain consistency
  * Rephrased CHANNELMSG_ALLOFFERS_DELIVERED handler function comments
    for better explanation. Thanks for sharing the write-up.
  * Changed commit msg and other things as per suggestions
* Addressed Dexuan's comments, which came up in offline discussion:
  * Changed timeout for waiting for all offers delivered msg to 60s instead of 10s.
    Reason being, the host can experience some servicing events or diagnostics events,
    which may take a long time and hence may fail to offer all the devices within 10s.
  * Minor additions in commit subject of both patches
* Rebased on latest linux-next master tip

Changes since v1:
https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com/
* Added Easwar's Reviewed-By tag
* Addressed Michael's comments:
  * Added explanation of all offers delivered message in comments
  * Removed infinite wait for offers logic, and changed it wait once.
  * Removed sub channel workqueue flush logic
  * Added comments on why MLX device offer is not expected as part of
    this essential boot offer list. I refrained from adding too many
    details on it as it felt like it is beyond the scope of this patch
    series and may not be relevant to this. However, please let me know if
    something needs to be added.
* Addressed Saurabh's comments:
  * Changed timeout value to 10000 ms instead of 10*1000
  * Changed commit msg as per suggestions
  * Added a comment for warning case of wait_for_completion timeout
  * Added a note for missing channel cleanup in comments and commit msg

John Starks (1):
  Drivers: hv: vmbus: Log on missing offers if any

Naman Jain (1):
  Drivers: hv: vmbus: Wait for boot-time offers during boot and resume

 drivers/hv/channel_mgmt.c | 61 +++++++++++++++++++++++++++++----------
 drivers/hv/connection.c   |  4 +--
 drivers/hv/hyperv_vmbus.h | 14 ++-------
 drivers/hv/vmbus_drv.c    | 31 ++++++++++----------
 4 files changed, 67 insertions(+), 43 deletions(-)


base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
-- 
2.34.1


