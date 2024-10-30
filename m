Return-Path: <linux-hyperv+bounces-3217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 249FE9B6B44
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 18:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81A6B2075D
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272FD1CBE99;
	Wed, 30 Oct 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tCCRp7Bb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A1199FA0;
	Wed, 30 Oct 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310478; cv=none; b=ooB7/y73xlhyGj1ptocOT95SaPxqu/V1XUXQJJTZ4i29M3vCBrvxPawaBsjp+Du4rWbhL5CV9PomblJAOs85UDkls31eVr0VW3TvnvO+r3FlhIcetDTgK65DzciOtiC6wXOIAheLtYAjqdE0h/LgIpMiG6ywyJlF6KF8HAGJ7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310478; c=relaxed/simple;
	bh=Sy/XcrnSG/n3m2XPnVo6TJ1sAr986PE5hlaj5H9ahsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tndFdA21f9mGs5/LLfWhZyI+iZUHhRYxxA7WjZXubQWgAlxWEWf/gUTLgAsEX2HogGCmN/WsFVi3V0sAspBk8PGynEMNdOGOmIkWyuaEsowkRpRODvRmultzhqd5RsPAYTm0rH0zFCV3b+Lz/WgiQRfflbimX9W+QEBl38JA3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tCCRp7Bb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C60E2054B68;
	Wed, 30 Oct 2024 10:47:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C60E2054B68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730310470;
	bh=mrrwKYSM5C8NsFUuz9eD0QAcHgQ/zcwrN5HhAbKheYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tCCRp7BbtrTVmfK05wpvWDk/LSQlwAxWacYodBBq7jlVVJcbvqxQHe+Cp57/p3SiC
	 vsCbrBpkmYoYPXGfQs0exj1WHQ9LXJfYFfosuvAaz6OZ7itEaZbF+DKuQUsvPucVBd
	 T9Zr5xKvjc9VnaYadxN7zUnvUISkpH0OtQ0nE+yc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 30 Oct 2024 17:47:35 +0000
Subject: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
References: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
In-Reply-To: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
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

secs_to_jiffies() is defined in hci_event.c and cannot be reused by
other call sites. Hoist it into the core code to allow conversion of the
~1150 usages of msecs_to_jiffies() that either:
- use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
- have timeouts that are denominated in seconds (i.e. end in 000)

This will also allow conversion of yet more sites that use (sec * HZ)
directly, and improve their readability.

TO: K. Y. Srinivasan <kys@microsoft.com>
TO: Haiyang Zhang <haiyangz@microsoft.com>
TO: Wei Liu <wei.liu@kernel.org>
TO: Dexuan Cui <decui@microsoft.com>
TO: linux-hyperv@vger.kernel.org
TO: Anna-Maria Behnsen <anna-maria@linutronix.de>
TO: Thomas Gleixner <tglx@linutronix.de>
TO: Geert Uytterhoeven <geert@linux-m68k.org>
TO: Marcel Holtmann <marcel@holtmann.org>
TO: Johan Hedberg <johan.hedberg@gmail.com>
TO: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
TO: linux-bluetooth@vger.kernel.org
TO: linux-kernel@vger.kernel.org
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 include/linux/jiffies.h   | 12 ++++++++++++
 net/bluetooth/hci_event.c |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0fbe5bf9fb6c559b4efd603db3e97db9b65..e17c220ed56e587fd55fb9cf4a133a53588af940 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -526,6 +526,18 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+/**
+ * secs_to_jiffies: - convert seconds to jiffies
+ * @_secs: time in seconds
+ *
+ * Conversion is done by simple multiplication with HZ
+ * secs_to_jiffies() is defined as a macro rather than a static inline
+ * function due to its potential application in struct initializers.
+ *
+ * Return: jiffies value
+ */
+#define secs_to_jiffies(_secs) ((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bbad90ddd6f87e87c03859bae48a7901d39b634..7b35c58bbbeb79f2b50a02212771fb283ba5643d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
 
 static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,

-- 
2.34.1


