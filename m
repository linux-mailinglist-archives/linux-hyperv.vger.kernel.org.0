Return-Path: <linux-hyperv+bounces-3483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD89F4199
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 05:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F247A3BD8
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 04:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E25513DDB9;
	Tue, 17 Dec 2024 04:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PUSjk9Uy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27220EB;
	Tue, 17 Dec 2024 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409037; cv=none; b=uNLeeiXCsCiFSMKhmqKCxUs24T6N5v+Nt8H95rEJWlHz9CprvC+JGU4Yz0UwHYQGnXXYECwcB04+HF0HEbjnM4uvKugKg9B2f1h3iDuFF0rYlnMWJ2xiGrsHjnDN39xfYZ7GxX66rxTC4yR+o3FXkabp3oPHkQV2gWGuNPQIe6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409037; c=relaxed/simple;
	bh=mv/hJGnHXuS3Iq+PPpUn6L9H1CjyIPwhVsdPxhm7K8s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AL4RLoYeWLRFzSIuOwDpnsRFCEs+8/KsbpUfCvcNsaXFvWIDryBtLDtz841NDhFudHDS1QzbIPAKAfT6lDvig0JOMPce97ZQnNYaTh10OVp8JQQhb/sGqC9DgEzFoaXiF7iB3SO4tqYMZOuVFmK4BYxvX7OEhMsXVrbWV7YEjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PUSjk9Uy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 5B109204720E; Mon, 16 Dec 2024 20:17:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B109204720E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734409035;
	bh=+/ViDxWzfryU9ikDOGTZKHRT/qPhCdKFZa62Pz1646k=;
	h=From:To:Cc:Subject:Date:From;
	b=PUSjk9UycGclagIquLhKwv37mvmqSAZuxsDBszbf6PbEjh536oRfd50GHeMQzcfKk
	 MpynYyIN2NCLALG831tr6Emg1nUBWgpN+JGCoJHY9sOVWAy78nXVlSKzbBAnDf2X+r
	 /kyompQLxRPQsCw0f174h5d1Lb+vBDXTR0Wilztc=
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
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v4 0/3] Disable Suspend-to-Idle in Hyper-V and Fix Hibernation Interruptions
Date: Mon, 16 Dec 2024 20:17:06 -0800
Message-Id: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
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
---
Changes in v4:
* Make keyboard and mouse wakeup capable by adding 
  device_set_wakeup_capable but not enabling them as wakeup sources.
  https://lore.kernel.org/lkml/Zv-j0qtWXsDz4Hah@google.com/
* Remove device_wakeup_init() call in mousevsc_remove()
v3:https://lore.kernel.org/lkml/1727685708-3524-1-git-send-email-ernis@linux.microsoft.com/

Changes in v3:
* Add 'Cc: stable@vger.kernel.org' in sign-off area.
v2:https://lore.kernel.org/lkml/1727683917-31485-1-git-send-email-ernis@linux.microsoft.com/

Changes in v2:
* Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not 
  enabled.
* Change commit message to clarify that this change is specifc to
  Hyper-V based VMs.
v1:https://lore.kernel.org/lkml/1726176470-13133-1-git-send-email-ernis@linux.microsoft.com/
---

Erni Sri Satya Vennela (3):
  Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
  Input: hyperv-keyboard - disable as wakeup source
  HID: hyperv: disable as wakeup source

 drivers/hid/hid-hyperv.c              |  3 +--
 drivers/hv/vmbus_drv.c                | 16 +++++++++++++++-
 drivers/input/serio/hyperv-keyboard.c |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1


