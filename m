Return-Path: <linux-hyperv+bounces-3564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369779FF99F
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 14:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666C81883738
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14691DA5F;
	Thu,  2 Jan 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K7M/zoGX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD51C36;
	Thu,  2 Jan 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735823243; cv=none; b=G6ei4CZxTraR0fjP20t4tp5YdrPhZvnyHn3O17bzUDlKhYxkElYhSRCnoyiYFczFBoHTF4a+WlrvIGiBHau4SnS7s4FmR7qJSmJFZBD+5H/9RwWmrgbEdrHdu5WVJ4PoqWdWdJwPeKChnZe3dCWZvlPTcIbcCEGUr31LDmY9trg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735823243; c=relaxed/simple;
	bh=7Whcdj1P5GY/E7HAcQTCJAyBGWc5fPf3XvNPVZ43E2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBgdZQAFj4FnjeVnO/flMVmqzu1BlW6d8fr+NVeV4CRaz+oLt22yLu3tuXwvo3huF+rTO/XICtgoRAJvZjXQ57r6CqAjYvYvP1DYCzYTdgnjuiHgxuKC5NrysyNKc+VTWIzfZCwGiHP5/dCjrsjW2jq12s7CWI9qkY7fFtW9ZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K7M/zoGX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE9572066C27;
	Thu,  2 Jan 2025 05:07:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE9572066C27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735823236;
	bh=Y+4Tr3S47ugC5r73gu79nGWNevgvID/Re9o8ZKorWBI=;
	h=From:To:Cc:Subject:Date:From;
	b=K7M/zoGX2ooBuaWRmRj0FrPiXJRdrihMLCoKtBWG7sETitldAyleL0YB9jBfvyVO0
	 KrFo1wxpfmFW2xuV5etgeL0CyFnLQmJzPdxAUyoe2GBL3oveMMQwmVefhc5ob59+wy
	 5iEMQvRsm4EyNhSpLdtvozOWufS7S4eVDN9djQKM=
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
Subject: [PATCH v5 0/2] Drivers: hv: vmbus: Wait for boot-time offers and log missing offers if any
Date: Thu,  2 Jan 2025 13:07:09 +0000
Message-ID: <20250102130712.1661-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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

Changes since v4:
https://lore.kernel.org/all/20241118070725.3221-1-namjain@linux.microsoft.com/
Rebased on latest tip and added Michael's Reviewed-by tag.

Changes since v3:
https://lore.kernel.org/all/20241113084700.2940-1-namjain@linux.microsoft.com/
Fixed checkpatch style warnings coming with "--strict" option,
addressing Saurabh's comments.
FYI, I kept code style same as earlier for below, to keep consistency
with other similar fields in the code and because of lack of options
due to 100 char limit.
***
CHECK: Lines should not end with a '('
FILE: drivers/hv/connection.c:37:
+       .all_offers_delivered_event = COMPLETION_INITIALIZER(
***

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


base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
-- 
2.43.0


