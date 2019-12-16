Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0711FC13
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLPAUA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:20:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34231 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfLPAT7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:19:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so2937925qkk.1;
        Sun, 15 Dec 2019 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=usI7ZLlrtnzO1xtvE7qJdWgNGyWRiX0DoyyW1z56fjQ=;
        b=ZcL1vAcUgKjuyp97OeIAQ0epiqggmuG3QljxDovgnIuPeifT/+ziT7ngleb475gqEn
         9Id1YfFkwJtqKMX0R1rk4968ygu0mENq1hVBHVVJjj7GS6YEfuggH3SpS/odI+aZbuZ+
         wR1yKLxVoaENYO8aHVbpIBMGdc4fc6a0jRTmluYEgR7vyqYJmsDxWaczEy3PKU2+pxMW
         4r5P1g4JLkfLLzURF05vGcUJxbw7J3nbdZaBY2LNdkHfzssQ0qogl+PdzqVn4BSuUfn+
         nbAbEfWsiinDCitUgRfKhjdzIctPFTcitdQwBDqSgMyKeBA1RokL0sW+os4Hxyvm/m+6
         lbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usI7ZLlrtnzO1xtvE7qJdWgNGyWRiX0DoyyW1z56fjQ=;
        b=ZXRWdmH8bJgFbs6je6/NmY8A2hpxRqAQqyo/XA9BF/CKzobhbq/SgyV7USPi6bL/qG
         9UFjFvI3WTWjQKGELbfFpdXnNo7S8r9NoEAQgTK6RSkwcT6Loo/YWOdB6uVhC77NIw/o
         7O22cBAMXQQc/JLikW8yhmK0O+H0P6AEqmCp7SVSszICGs7erhC7pRJIStdmpWdZXAV1
         SzSRyM0xKWfkOiG8DdL2tqAacE+uo9PH/I9CCByr3g/0AOaUFqXCJZzAT9IVdBF4zan0
         ExI0et+ZlryLuv6w7rXLjw+VRD26uW6Mgs8rptpypzLlrv9kKTmCMhkX5CkL5eigkz2b
         sTXg==
X-Gm-Message-State: APjAAAWEVvSeEoG3Tl3x0RwFK1dHSrGBwLBKrw6/VNqxbV+f4xtCTR8k
        1sVS26yrxLEe3Yfa1QVSJ3U=
X-Google-Smtp-Source: APXvYqyuGzwONPf0HzeujWXJY0HQfLDKVVu2G/wH3GBxfrZbbw4VCaxRxyLj5AO/cD1ig93OBJk46w==
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr24635272qkl.44.1576455598605;
        Sun, 15 Dec 2019 16:19:58 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c3sm5440772qkk.8.2019.12.15.16.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:19:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9C34422430;
        Sun, 15 Dec 2019 19:19:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:19:57 -0500
X-ME-Sender: <xms:rc32XeSK_XIhpZp_q6SHBGjzCrk7LYTS0EdnFG89Fi_i0f50st2aLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduheehrdduuddurdejudenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:rc32XX6d4jyRmd4tKl3p9ANUzk8f_g2bkGBtCdx4i3jUIRFJRCMOwQ>
    <xmx:rc32XY0BaUO6RdE8-TbG8yWCGc0H1qf_yj9N5hWRyK05jdyeSAKEbA>
    <xmx:rc32XUnz94HOWgvI1mfW1PO5gpiP854b7tKxdNAYRcyw8TDkcTvztw>
    <xmx:rc32XRUat6VRrm1rGJNTqr5wfVloWQuRubAEE2UNJMw1hd2W28FeOHH7XYQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C0B1306012F;
        Sun, 15 Dec 2019 19:19:56 -0500 (EST)
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
Subject: [RFC 5/6] arm64: hyperv: Enable userspace to read cntvct
Date:   Mon, 16 Dec 2019 08:19:21 +0800
Message-Id: <20191216001922.23008-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216001922.23008-1-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since reading hyperv-timer clocksource requires reading cntvct,
userspace should be allowed to read it, otherwise reading cntvct will
result in traps, which makes vsyscall's cost similar compared to
syscall's.

So enable it on every cpu when a Hyper-V guest booting up.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm64/hyperv/hv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/hyperv/hv_init.c b/arch/arm64/hyperv/hv_init.c
index 86e4621d5885..1ea97ecfb143 100644
--- a/arch/arm64/hyperv/hv_init.c
+++ b/arch/arm64/hyperv/hv_init.c
@@ -27,6 +27,7 @@
 #include <linux/sched_clock.h>
 #include <asm-generic/bug.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/arch_timer.h>
 #include <asm/mshyperv.h>
 #include <asm/sysreg.h>
 #include <clocksource/hyperv_timer.h>
@@ -45,6 +46,7 @@ EXPORT_SYMBOL_GPL(hv_max_vp_index);
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
+	u32 cntkctl;
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -53,6 +55,11 @@ static int hv_cpu_init(unsigned int cpu)
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
 
+	/* Enable EL0 to access cntvct */
+	cntkctl = arch_timer_get_cntkctl();
+	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+	arch_timer_set_cntkctl(cntkctl);
+
 	return 0;
 }
 
-- 
2.24.0

