Return-Path: <linux-hyperv+bounces-3199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BCB9B3A31
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86FE28231A
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E963B1E0DEF;
	Mon, 28 Oct 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ekaVkzpT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4A1E04A1;
	Mon, 28 Oct 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142677; cv=none; b=cnDYcJlJSVx0zt+9eIj514ea4exCGLEXWy3S4fPyNIT6gDSxdku8HrqXZ6rHKK0dgCagDvgRfxxWODmk8+RF5ngJ/5g0TwTljEhKqnJ1YDPFuFvLfiYijROut7Qzn3sVu0sI2UviVRyccb4MXLCMNOZWk1N/jse0MKNtnMBBOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142677; c=relaxed/simple;
	bh=Zamm+dS6vWj9FlovPpEhCl8cnLO29vOQ+wblAfbIfg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=auAD/+OVfb8PZaf8P5SaUbGVlFgzRYVaHry37Y8FbrENMY4e3l0phlSfuHVzM/1vIk1Cvb50tXGvRCGa0UBcTY6Lw79zELfW9uszekU9RDK7dYER0jaoiKtGxUat8WYeYUzuRi6CnU+NDy4rW5lHavYRM+40TffCEzJfI2NuN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ekaVkzpT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 21C2F211F5EA;
	Mon, 28 Oct 2024 12:11:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21C2F211F5EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730142675;
	bh=D6rAHUfG9QmCyecaEsx/FHrgepDcCKlq7nBVqWErTHU=;
	h=From:Subject:Date:To:Cc:From;
	b=ekaVkzpTr9W6UUc/GBOFDGfyolCzVYct+GjshPNUK+izYTum4ADk1F9pVUSmmOv4R
	 6YKVZ9dz/7nvj5ZGVttRtuCks2xEFE/Va/0EMVkvI9tTDPDKHm05iztt+DoB/AmGfq
	 Ia26+o+ypT2zumPb38cxAzLR6Jgu8KOmUIAHLfgE=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH v2 0/2] Converge on secs_to_jiffies()
Date: Mon, 28 Oct 2024 19:11:01 +0000
Message-Id: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXhH2cC/03MTQrDIBBA4asE1zXopPmhq96jdGF0UgeqE9SUQ
 MjdK111+S3eO0TGRJjFrTlEwg9l4lgBl0ZYb+ILJblqAQquWsEkecUoLTt0slBA3kqWg7Ojnee
 hH8GJWq4JF9p/18ezekkcZPEJzf8L9NR3fdeCmpQCLbVE400ib+5vitveBrKJMy+ltRzEeX4BP
 uM0Rq0AAAA=
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.1

There are ~1150 call sites for msecs_to_jiffies() that:
- Use a multiplier of 1000, or MSEC_PER_SEC, or
- have timeouts that are denominated in seconds, i.e. end in 000

There are yet more sites that use (secs * HZ). Provide secs_to_jiffies()
as a new member of the *_to_jiffies() family and convert a few instances
as a first user.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
changelog:
v2:
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

 drivers/hv/hv_balloon.c   | 9 +++++----
 drivers/hv/hv_kvp.c       | 4 ++--
 drivers/hv/hv_snapshot.c  | 3 ++-
 drivers/hv/vmbus_drv.c    | 2 +-
 include/linux/jiffies.h   | 2 ++
 net/bluetooth/hci_event.c | 2 --
 6 files changed, 12 insertions(+), 10 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241028-open-coded-timeouts-6dc7cbb6572d

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>


