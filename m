Return-Path: <linux-hyperv+bounces-3091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33EF989D06
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634191F23941
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E517C21B;
	Mon, 30 Sep 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WQ7N/4gy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB517BB34;
	Mon, 30 Sep 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685711; cv=none; b=U8wG1lsGAoKiG493Q+MHTePV+GbMsFziXVix1xqvIZ7UQw34aLx+RE/FO/xhOJ7Sj5+KR5BazrhK33FbDbs8rJot+GBC1TGC+H+dsnHHou1LH/s1etb2UjhbUbiMLBFRisZ1ZIkLQzN4erJIAq9rzZtriR6vXSgM3qyNafxxrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685711; c=relaxed/simple;
	bh=k0inenRsQdLM8kjq3Vtb89hksJy4Iy07Cnuk6LFCDH4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NKBRQ5NzonTHPI9Bt9uY4Ycmk8KV0ebfcPo9nzSEF+aPzlKURZWEGcMCV+BDwE7aNHX5xo/ksXeiTUOv2CRJFwB4+cBGAUzQ2KhJmaHJH7sdKxf57lqtF+4jTnlOXrppdI1J0abEvgOJg4tkSAXvmnKf4iwZhSN41A06f2127v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WQ7N/4gy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 826A320C8BD6; Mon, 30 Sep 2024 01:41:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 826A320C8BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727685709;
	bh=Uo3K65bEBS5TlGxxZy7heiLcFXhjzPHT12XW0+LyZ0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WQ7N/4gyoMscG232xbIFkPUfAGBtoEmm7ntXs9JJ09fsrnaTrsCk6nuS+wA+TaiON
	 sDHbjI56mkD2WkxFXGu2xYXp3xrOLNv3yhOrnDPFu553RgNgcW6twE4joWs6kDX1fH
	 UcHTnkJ5FPGu4CRSfRVn5mWu4wzbUh2GL5WyGs44=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	mikelley@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v3 0/3] Disable Suspend-to-Idle in Hyper-V and Fix Hibernation Interruptions
Date: Mon, 30 Sep 2024 01:41:45 -0700
Message-Id: <1727685708-3524-1-git-send-email-ernis@linux.microsoft.com>
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
 drivers/hv/vmbus_drv.c                | 16 +++++++++++++++-
 drivers/input/serio/hyperv-keyboard.c | 12 ------------
 3 files changed, 15 insertions(+), 19 deletions(-)

-- 
2.34.1

