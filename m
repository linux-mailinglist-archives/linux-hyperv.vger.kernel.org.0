Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3518D11FC17
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLPAUH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:20:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45417 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfLPAUH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:20:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so3866764qkl.12;
        Sun, 15 Dec 2019 16:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7S615KofXaQ1yUG/3GM94cEkec6rvE87OWT0R1mkHVE=;
        b=nqPgX5mFOvAOvhSP8TsLpj5UaQakaOAGyTfIYXnrJ98dEtbMpEP8y70bY2krwxvBGv
         3sK8HR/8589X7H4aSpRQYDfPVFxXCiHAWknqhsEK4Dqnmtom1eCmt/84ndxMicvGc0tX
         SK1DtIiUK/u/cmwstnoeopb3cfXxGD4PGhoanmWF1wQx39CgqDz+4kssxSIdbFWyWPOB
         y63NGEJciBnX0t8sIT3OXdy/PBOf6jMsRpwBBJWBXrJ9vblwvEfFYeeNeGZ2SeNxLe1f
         oSONG29STbtZuutO4OQ8C6uyMnSUAFvzBbOaI53Zjw4vhBWJIWjfAI2QyCTMnpNHF0F/
         6NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7S615KofXaQ1yUG/3GM94cEkec6rvE87OWT0R1mkHVE=;
        b=qMWfwPLe3kwErVCcmZUZ1Xyr9KktPkeZVoWYve63ZsT2GdpCKj6FK5T+KtM6Lezd02
         +H+NfxcTf8KabF2SP7Lwbl/vAHYNaoc61hEd2G/QTi/kHJpcMOO59vPCqnh9xXbzo7mu
         eek/FIoYVOYJN2NjqO6RQC+NJkMXZ35jREDPeHsjjaCnL8c66+0r0WqFG7DQ22fcQ4Mj
         EjvaL7lYqXFpY5FZL/rkPM3lmvKZqWQE9PFTUQIx+JWM+VoCn+ghqs4OFrt9DpCjwnhH
         henotN2T/vW1P5g9lTXlU6mZyqgQvl0c7CuygijXYp9Jbl1s+we9f3lW6AxBXxTbQdzM
         s5YQ==
X-Gm-Message-State: APjAAAU5CDHpkKeBnVJidKofZm/HlP97rgEbF6ofbARS73Ttt8oMp+tp
        06TAjRhIkj5siH4Ztfy36jo=
X-Google-Smtp-Source: APXvYqw+Sd5f8LCDwfYgXxyt3Pq91Kobn432DMObcmpR4URJPQMO29VkBjNnlDH47LvcwB6Snoz7LA==
X-Received: by 2002:a37:684a:: with SMTP id d71mr22545035qkc.201.1576455606206;
        Sun, 15 Dec 2019 16:20:06 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h1sm5312169qkc.38.2019.12.15.16.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:20:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 18F2B22442;
        Sun, 15 Dec 2019 19:20:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:20:04 -0500
X-ME-Sender: <xms:s832Xf_utJ7BzzzxXT8sbRHR_jIVZkfwcioGr8KILEE-3_xWYJBHKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduheehrdduuddurdejudenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:s832Xaf6uB8opnROUrWBVo_oq9K0wWLiPN_7SZTDlz-uaVSDV_V5-Q>
    <xmx:s832XclLRpyr1FDzNKmXKAtYVIdNduUR00tMwI8SBw9qloS3PHxvIg>
    <xmx:s832XVwgiH4W1-JxHD2H0dy8J1UrSR2HXikSjfrgI9BuAUt7nedTCg>
    <xmx:tM32Xdbw_MsAUFdQXzs8LV5BQT0Fa223mJ-DPb6TdsQ2b8XitXSIMLuE1VQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69CB980063;
        Sun, 15 Dec 2019 19:20:03 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 6/6] arm64: hyperv: Enable vDSO
Date:   Mon, 16 Dec 2019 08:19:22 +0800
Message-Id: <20191216001922.23008-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216001922.23008-1-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Similar to x86, add a new vclock_mode VCLOCK_HVCLOCK, and reuse the
hv_read_tsc_page() for userspace to read tsc page clocksource.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm64/include/asm/clocksource.h       |  3 ++-
 arch/arm64/include/asm/mshyperv.h          |  2 +-
 arch/arm64/include/asm/vdso/gettimeofday.h | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
index fbe80057468c..c6acd45fe748 100644
--- a/arch/arm64/include/asm/clocksource.h
+++ b/arch/arm64/include/asm/clocksource.h
@@ -4,7 +4,8 @@
 
 #define VCLOCK_NONE	0	/* No vDSO clock available.		*/
 #define VCLOCK_CNTVCT	1	/* vDSO should use cntvcnt		*/
-#define VCLOCK_MAX	1
+#define VCLOCK_HVCLOCK	2	/* vDSO should use vread_hvclock()	*/
+#define VCLOCK_MAX	2
 
 struct arch_clocksource_data {
 	int vclock_mode;
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 0afb00e3501d..7c85dd816dca 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -90,7 +90,7 @@ extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
 #define hv_set_reference_tsc(val) \
 		hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val)
 #define hv_set_clocksource_vdso(val) \
-		((val).archdata.vclock_mode = VCLOCK_NONE)
+		((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 #define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index e6e3fe0488c7..7e689b903f4d 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -67,6 +67,20 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
+#ifdef CONFIG_HYPERV_TIMER
+/* This will override the default hv_get_raw_timer() */
+#define hv_get_raw_timer() __arch_counter_get_cntvct()
+#include <clocksource/hyperv_timer.h>
+
+extern struct ms_hyperv_tsc_page
+_hvclock_page __attribute__((visibility("hidden")));
+
+static u64 vread_hvclock(void)
+{
+	return hv_read_tsc_page(&_hvclock_page);
+}
+#endif
+
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 {
 	u64 res;
@@ -78,6 +92,11 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 	if (clock_mode == VCLOCK_NONE)
 		return __VDSO_USE_SYSCALL;
 
+#ifdef CONFIG_HYPERV_TIMER
+	if (likely(clock_mode == VCLOCK_HVCLOCK))
+		return vread_hvclock();
+#endif
+
 	/*
 	 * This isb() is required to prevent that the counter value
 	 * is speculated.
-- 
2.24.0

