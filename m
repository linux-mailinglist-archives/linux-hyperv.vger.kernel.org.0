Return-Path: <linux-hyperv+bounces-3201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F409B3A37
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD161F21C05
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC011E1327;
	Mon, 28 Oct 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ojey8mCB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1489E1E04B3;
	Mon, 28 Oct 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142678; cv=none; b=TpAAXoqRJ/LEFu3ia/e0MDo145O/g07nMejpH+kuUhHJNUkuadTyAdCfKmv5DNSj5quTGeGejhfreKZ0TCjjWalgZCvh9MjwHf5bY7DjMML+JD5efAZZMrBm9B5hPqx1xCfMTOLSMFfFHf1x0mQENGjZwfuOE+aydeXvpNLt5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142678; c=relaxed/simple;
	bh=7LdAF0atlIAeFjBKeUA5igpYjoWw7yVXLZJP3z7keko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BU2MVFXcbRBe60iTY9brr8xi4e1nP1zU2YvEdStII/mlQ1S732T1wt+Bt6jH4yoy94AC7Pt5sC6Damrk0pLaGcNiHRInWSl8FvnmdHLfRWvlaPtvpAt5hdD8bYF9I51AlQzXqYdme8aDma0cd6lEnyMipuXO2aAU80e+haa0jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ojey8mCB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D169211F5ED;
	Mon, 28 Oct 2024 12:11:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D169211F5ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730142675;
	bh=5IWioSIiUCrOJ9tFj6klW/8OTmQbfbizRlqfO9DDr5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ojey8mCBRWpXrGjlmKn9M+N7K2iKvM2oQmqqZKfgrHu0ilrzYoK4Belk+0tYQaVUe
	 jCNc8NI8jwXcB37RVM/FKlvEDnA5vww9hdVkwrrRKonL5LnnBl6+mVSeTAjF8X+gWM
	 MggGqcDeY2scjZLeXdNgffWYsar/cRk+GpC7Jsnw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 28 Oct 2024 19:11:02 +0000
Subject: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
In-Reply-To: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
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

secs_to_jiffies() is defined in hci_event.c and cannot be reused by
other call sites. Hoist it into the core code to allow conversion of the
~1150 usages of msecs_to_jiffies() that either:
- use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
- have timeouts that are denominated in seconds (i.e. end in 000)

This will also allow conversion of yet more sites that use (sec * HZ)
directly, and improve their readability.

TO: "K. Y. Srinivasan" <kys@microsoft.com>
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
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 include/linux/jiffies.h   | 2 ++
 net/bluetooth/hci_event.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0fbe5bf..e5256bb5f851 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+#define secs_to_jiffies(_secs) ((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bbad90ddd6f..7b35c58bbbeb 100644
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


