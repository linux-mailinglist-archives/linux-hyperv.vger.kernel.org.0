Return-Path: <linux-hyperv+bounces-3204-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D09C9B43A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 09:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5E11C2170D
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE6202F9F;
	Tue, 29 Oct 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FBrfpFHS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FD203703;
	Tue, 29 Oct 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188925; cv=none; b=NPfqH77WDRNBlo+E15k+yWUGeo0Fa50DPZUHyqDovftSLxvp03gTAUE8Jc9JJ/ZEb4KWIMCHbjYXuHP7AV3NITPETIYqz9ToUFRVtAbzV08EsrClQgSUjVMpCx8mKrKrcyOeSzz4lK2ewfqbZxm6g99TVdYknJdWVUgqRn1rpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188925; c=relaxed/simple;
	bh=1rl/lez8CFnzaNZuPtfeemJlstaZ1uN0hD0AIak9kJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SnOs3Xb5z8RVMaZtfcB0oFPnEr3oeVplchtfoSLPCxIbvT7xyOCGQei0RNFUlL+lOvMaQ4k+VAtxxUo+5fV/FqdX1JWFCBJcd2X0WuiwDbMVhMXQ2+DQRQukw78oLGHHbEel8oppAomBHRFcjDtaO1pnjhgogbN2WQq/WsIVkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FBrfpFHS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88D46211F61F;
	Tue, 29 Oct 2024 01:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88D46211F61F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730188917;
	bh=iTXxgBCvn0vPQ4tASHjUMzxYi2O0NmCVnCZ0QLDgtm4=;
	h=From:To:Cc:Subject:Date:From;
	b=FBrfpFHS5Dy8O3lTMmj9Y+XjOzq9tLDcHhbzwi3OTFILRyRDaOLCNfDzzFg8ZueDM
	 x2BMD2V9DGJ45pgxQ+2eyoK6KLTnxJfDXB9KtDDc9zz472c8zd2kCDs4i5cLJTaHc1
	 mdOnRRPsfK4JDYRgopNsp81+y+2wGhm/M4JOgr9A=
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
Subject: [PATCH v2 0/2] Drivers: hv: vmbus: Wait for offers and log missing offers
Date: Tue, 29 Oct 2024 01:01:45 -0700
Message-Id: <20241029080147.52749-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After VM requests for channel offers during boot or resume from
hibernation, host offers the configured channels and then sends a
separate message when all the essential channel offers are delivered.
Wait for this message to make this offers request and receipt process
synchronous.

Without this, user mode can race with VMBus initialization and miss
channel offers. User mode has no way to work around this other than
sleeping for a while, since there is no way to know when VMBus has
finished processing offers.

This is in analogy to a PCI bus not returning from probe until it has
scanned all devices on the bus.

As part of this implementation, some code cleanup is also done for the
logic which becomes redundant due to this change.

Second patch prints the channels which are not offered when resume
happens from hibernation to supply more information to the end user.

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
  Drivers: hv: vmbus: Log on missing offers

Naman Jain (1):
  Drivers: hv: vmbus: Wait for offers during boot

 drivers/hv/channel_mgmt.c | 55 ++++++++++++++++++++++++++++-----------
 drivers/hv/connection.c   |  4 +--
 drivers/hv/hyperv_vmbus.h | 14 +++-------
 drivers/hv/vmbus_drv.c    | 31 +++++++++++-----------
 4 files changed, 61 insertions(+), 43 deletions(-)

base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
-- 
2.34.1


