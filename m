Return-Path: <linux-hyperv+bounces-3216-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB239B6B43
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 18:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4411A28233D
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBD1C9EB4;
	Wed, 30 Oct 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IINGcAT3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA4019AD8C;
	Wed, 30 Oct 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310477; cv=none; b=Akz0LREehxe74LqWObh+NsbTGLa+814KLFzKC1ndzQqd8nmypt1mM78wx8gsNxoatgsUKlffxDtsgiFXwMzcXAUaIFhzlCng+Z4Y44R9vbT78JNwbiGzWwvdULkncO304HhEaquc2qrzaR2vkpyso3/cRzJnPhfrDmW9v9dY7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310477; c=relaxed/simple;
	bh=WtwZnbvi+UBDTFfDcKkC2guEG6v41vMIbNztSHxNFNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p1TrybpfwBhgpfY6xSSUmpoO3BERafqBO9DF12SkmBFMh3YXhERIWWuefqPxKqAg9RvHFLqvq9DiZlAiEY3bJYhrdhgSpDZpbUD8ZLWFOAINZltN4VR4x01XjGUsOnb+KlojzPQzlEtVsRimG2e6Xb9u8TIiWlPFpy8joFtlmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IINGcAT3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E5712054B67;
	Wed, 30 Oct 2024 10:47:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E5712054B67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730310470;
	bh=c5fztDOgsym1DJ7QBsGXM7Ths9fN7jyPu9Jt/dMD7Qw=;
	h=From:Subject:Date:To:Cc:From;
	b=IINGcAT3Lck41ZlgsexPmwoat1Szemy1XyjOa+UWjmlzJNGlpDIf3QvFugAU2bm06
	 iGlVPWYcR8Sp7W/2sI8JkMWdyKMDKKf/NvGkr5+EcPvWEbx3HrPJelFo05ZMvS4Y/c
	 LWiOH4LGuC1iSIxHGV/ygLAg3Ewfxb9mkdhrtmG0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH v3 0/2] Converge on secs_to_jiffies()
Date: Wed, 30 Oct 2024 17:47:34 +0000
Message-Id: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZxImcC/33OQQ6CMBCF4auYrh3SDiDoynsYF6Ud7CTCkLYSj
 eHuoisXxuW/eF/eUyWKTEkdNk8VaebEMq5RbjfKBTteCNivrVBjZTS2IBON4MSTh8wDyS0n2Hn
 XuK7b1Q16tS6nSD3fP+rpvHYfZYAcItlvC01bl3VZoG61RgMGyAYbOdjjlcfbvRjYRUnS58LJ8
 HYDpyzx8Tk741v//2tG0OAa3Fdd11a1NT/h87IsLwD6UiUIAQAA
X-Change-ID: 20241028-open-coded-timeouts-6dc7cbb6572d
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Praveen Kumar <kumarpraveen@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.14.2

There are ~1150 call sites for msecs_to_jiffies() that:
- Use a multiplier of 1000, or MSEC_PER_SEC, or
- have timeouts that are denominated in seconds, i.e. end in 000

There are yet more sites that use (secs * HZ). Provide secs_to_jiffies()
as a new member of the *_to_jiffies() family and convert a few instances
as a first user.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
changelog:
v3:
- Pickup Reviewed-by tag from Luiz Augusto von Dentz
- Add kernel doc comment for secs_to_jiffies() (tglx)
- secs_to_jiffies() is defined as a macro rather than a static inline
  function due to its potential usage in struct initializers, where it
  wouldn't work per Geert (documentation in changelog requested per tglx)
v2: https://lore.kernel.org/r/20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com
- Add a cover letter
- Define secs_to_jiffies(s) as (s * HZ) instead of msecs_to_jiffies(s * MSEC_PER_SEC) (Anna-Maria)
v1: https://lore.kernel.org/all/20241022185353.2080021-1-eahariha@linux.microsoft.com/
- Move secs_to_jiffies in include/linux/jiffies.h
- Use secs_to_jiffies in drivers/hv
RFC: https://lore.kernel.org/all/20241016223730.531861-1-eahariha@linux.microsoft.com/
- Convert open coded timeouts (secs * HZ) in drivers/hv to msecs_to_jiffies()

---
Easwar Hariharan (2):
      jiffies: Define secs_to_jiffies()
      drivers: hv: Convert open-coded timeouts to secs_to_jiffies()

 drivers/hv/hv_balloon.c   |  9 +++++----
 drivers/hv/hv_kvp.c       |  4 ++--
 drivers/hv/hv_snapshot.c  |  3 ++-
 drivers/hv/vmbus_drv.c    |  2 +-
 include/linux/jiffies.h   | 12 ++++++++++++
 net/bluetooth/hci_event.c |  2 --
 6 files changed, 22 insertions(+), 10 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241028-open-coded-timeouts-6dc7cbb6572d

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>


