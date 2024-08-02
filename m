Return-Path: <linux-hyperv+bounces-2674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577BE945EEF
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A65284865
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4AF1DF693;
	Fri,  2 Aug 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BbAwCzb+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2D1E4875;
	Fri,  2 Aug 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606974; cv=none; b=VSmeHBoSTpQne4oMRh/YLydYxNuv0VcNx8henEYEIJC45WoOM0OuUvVqXrBI1FI+P2P97UuBDSiGHjdzdyXcjFoo0Um9/dWBuYxFge0tL6mU7PYpd6y/l+E+CPmjAsITZ3nHQ2HFY25M4NZLnZYW4Wa7WKOJyJI8zjfr7+0tq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606974; c=relaxed/simple;
	bh=VmKErhGLNPdSvFCfFfKzw5bcu6Dk7oPwizBjKNpfpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bidWhMkOxu4tQ1wQX1Dty83Z9eNfkMTJwxsGYLCbWWPBPHabJ51oadd2huCaD6rOr7DCRY8nAkhaH2W9wCnca6+TtW9mpMCak64JGNcJxhxZUAbZFNKNkwNQAAzITgzcK9vXIp1K8W57HLdynbvSEA+tkBSOrhcUUGYcnC0+lRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BbAwCzb+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YygvPNTpQv1mbf3Vhp9DhrD9o1CnlYqQvU0rIy6TD7c=; b=BbAwCzb+Ns3supSKyRYxGP8DCm
	SeB9WatSqxJhC7+NHsYbR3pKyv42HNyaeArtLt2lBTfr/MkGuqg8hqZVRob93CplaBDJieEFbhoqJ
	udJwff3isYe8rMLN0zKKgI8c0juRwjnOLDWUEEnNnuQMFOwWSMpligRfIkqMkqh2XxGxYYGFn47tY
	kPCz0zDECS++Inn6aITXgdt+Eo+n+jUrzsOH8+4vq4HMxHdcX8XgOuW2jka6nWauLvPoA+oZbHbTW
	Pqkfn+nPZDmDIi9SbPk5aZAng2rsJMPN8pjInomblfGC/ktlRvqWYKeTUxgSSjCK/LKLNcHOq7tlr
	3zQV3S9g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZslB-00000005ioL-1mjV;
	Fri, 02 Aug 2024 13:55:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZsl9-00000002My8-38T7;
	Fri, 02 Aug 2024 14:55:55 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: tglx@linuxtronix.de,
	x86@kernel.org
Cc: lirongqing@baidu.com,
	seanjc@google.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 1/2] i8253: Disable PIT timer 0 when not in use
Date: Fri,  2 Aug 2024 14:55:54 +0100
Message-ID: <20240802135555.564941-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Leaving the PIT interrupt running can cause noticeable steal time for
virtual guests. The VMM generally has a timer which toggles the IRQ input
to the PIC and I/O APIC, which takes CPU time away from the guest. Even
on real hardware, running the counter may use power needlessly (albeit
not much).

Make sure it's turned off if it isn't going to be used.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/i8253.c     | 11 +++++++++--
 drivers/clocksource/i8253.c | 13 +++++++++----
 include/linux/i8253.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 2b7999a1a50a..80e262bb627f 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
 
+#include <asm/hypervisor.h>
 #include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
@@ -39,9 +40,15 @@ static bool __init use_pit(void)
 
 bool __init pit_timer_init(void)
 {
-	if (!use_pit())
+	if (!use_pit()) {
+		/*
+		 * Don't just ignore the PIT. Ensure it's stopped, because
+		 * VMMs otherwise steal CPU time just to pointlessly waggle
+		 * the (masked) IRQ.
+		 */
+		clockevent_i8253_disable();
 		return false;
-
+	}
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
 	return true;
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb10b83..cb215e6f2e83 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -108,11 +108,8 @@ int __init clocksource_i8253_init(void)
 #endif
 
 #ifdef CONFIG_CLKEVT_I8253
-static int pit_shutdown(struct clock_event_device *evt)
+void clockevent_i8253_disable(void)
 {
-	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
-		return 0;
-
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
@@ -123,6 +120,14 @@ static int pit_shutdown(struct clock_event_device *evt)
 	}
 
 	raw_spin_unlock(&i8253_lock);
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
+	clockevent_i8253_disable();
 	return 0;
 }
 
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f6f834..bf169cfef7f1 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -24,6 +24,7 @@ extern raw_spinlock_t i8253_lock;
 extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
+extern void clockevent_i8253_disable(void);
 
 extern void setup_pit_timer(void);
 
-- 
2.44.0


