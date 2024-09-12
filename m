Return-Path: <linux-hyperv+bounces-3005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F2977396
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 23:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A238BB23602
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9281C2DBE;
	Thu, 12 Sep 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ln7kqXZX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCCC1C2DA7;
	Thu, 12 Sep 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176491; cv=none; b=f5AbeINnfMjECWHW1qVPqJiFkX/7zhxlwx16FC5THEYUV7HiFmjIX3wTzJSWq47w7AzpkLQBD5Ul7a9UHixLdJq7xV0q7yRsji0Th7E/4727VH5p9RTBZWrBETOHzKLj6Hs4ShPwxSVPKjimW0GxyQGLnCQYTd90D2I6hSv19tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176491; c=relaxed/simple;
	bh=C7XbjCELO9b8718ABF4Pzuyiw2pSGATDaH/DxB4X+30=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aAjf45kq4UYKvuugNDJiZc/iNoedXDlkwEiDszsM+l2B5VgvpxB9NhtfxMuSh8Jjm+hDEtKKyrfKeiniZSezT5KjXlOC1OmMUGfYc3GH8lH0iD9KqKHzi1RvKVXzVHvim08ErmGdxyhFzpgmbr41JJWuO6hQSHUMyEksWR6RW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ln7kqXZX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id AB9E620B9A7D; Thu, 12 Sep 2024 14:28:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB9E620B9A7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726176484;
	bh=jSJQNC6GxWwq5I5VVIIkK62UJY6lZWhK4VWrbz/5itg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ln7kqXZXUesNJIpKtxY+DYX//HDqts3VfhqbO0VnAbiVObmee5+9mk592IxDzGRT6
	 mrpUXBAcM32t4KGy/dHHxCteusaIp+HHQEJc4bX2ERRIt5suo6DDw5rMdu5tQXBtCi
	 17LIpGwXQj7L+/COC312GXD9xFmvLAaMZoRsyuRI=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH 0/3] Disable Suspend-to-Idle in Hyper-V and Fix Hibernation Interruptions
Date: Thu, 12 Sep 2024 14:27:47 -0700
Message-Id: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

It has been reported that Hyper-V VM users can unintentionally abort
hibernation by mouse or keyboard movements. To address this issue,
we have decided to remove the wakeup events for the Hyper-V keyboard
and mouse driver. However, this change introduces another problem: 
Suspend-to-Idle brings the system down with no method to wake it back up.

Given that there are no real users of Suspend-to-Idle in Hyper-V,
we have decided to disable this feature for VMBus. This results in:

$echo freeze > /sys/power/state
> bash: echo: write error: Operation not supported

The keyboard and mouse were previously registered as wakeup sources to
interrupt the freeze operation in a VM. Since the freeze operation itself
is no longer supported, we are disabling them as wakeup events.

This patchset ensures that the system remains stable and prevents
unintended interruptions during hibernation.

Erni Sri Satya Vennela (3):
  Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
  Revert "Input: hyperv-keyboard - register as a wakeup source"
  Revert "HID: hyperv: register as a wakeup source"

 drivers/hid/hid-hyperv.c              |  6 ------
 drivers/hv/vmbus_drv.c                | 15 ++++++++++++++-
 drivers/input/serio/hyperv-keyboard.c | 12 ------------
 3 files changed, 14 insertions(+), 19 deletions(-)

-- 
2.34.1


