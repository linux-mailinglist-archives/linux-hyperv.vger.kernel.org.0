Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67F2D7253
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfJOJaV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 05:30:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfJOJaV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 05:30:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so22951280wrj.6;
        Tue, 15 Oct 2019 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0k1UhNt+lnCy4opmNo9Jk1dZr1UqF/QzrkJNC+Z0nRY=;
        b=iFC9tJUZqSToJ0033lhSNVo46R+jGHoh0U/T3BNvPE+/yn6Bk0+vfg0/1c3bPzpC6E
         SLsGVDB3HXBqF/SSUY61mOnYxpcxJfoxWd61W2oNrve2Z95ODT8E+jdIle/2sVpgKLYa
         x0m9WoNe4xWtEYNuMdbD1uV4innoVvHrKYYahl4s/af6syoEqkcKdAwhwzjb57juHyjo
         10RKkBpi/x06srTOxbzIYsG2eaEDw0LmY2qg+UgK3rxqk3c09Bwf09q3gx00h5GWtiob
         k16dgqUAwtCYlBJQSZ+27D6MA9Lfdh/xjTvLx3rb7Y7b6PVI0LZQVpm1KKmaIo2YAEpB
         eC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0k1UhNt+lnCy4opmNo9Jk1dZr1UqF/QzrkJNC+Z0nRY=;
        b=czM7VHM8ywgGHFpEIP89wxmXKeLy0nwAtCGTy3OpUH6HA9MzSoC6p+i88wxX/CQti7
         zcKUHnoU93hT8TmLItZ7pmJQ7nwN+KbTg0CqLqnSBi5RxJsrLuYil8pOGZ2qjPJ62sum
         Q5gV6cvav068Ytn2LZNz6j4VVjDVTI2nL9BNGpcIk08WXZ9eG1MNrZhbRJ/0RqCB2UI8
         l/MF52D0qIMFk+vS/JIqZ2m5r0E8b1s29Z4Z5xC5chEd0/QguIhmtDoC2fftxeP/0Bpe
         0A9pzw7thZ3GMYBsTy9bllATxm3Nj1y9mknugEcmDEdGTbajXRDeprRlEHFCLhFfO06l
         vr7g==
X-Gm-Message-State: APjAAAUmmXxk92hQGDjU3ysg2aOQIa78jTkyN58iDnKha+ComPNj88NI
        fZKRALJtC4/16heRWqh/E3SYcA2yaALIeg==
X-Google-Smtp-Source: APXvYqzakWtHMGDPcymqrM9kOdXZ0F/wCvxoDTJ1C9gzFiLUqN7UJzPh2k3Q/17f+2CXntTOWVbQ/Q==
X-Received: by 2002:adf:9102:: with SMTP id j2mr27723909wrj.136.1571131818356;
        Tue, 15 Oct 2019 02:30:18 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1012:8d40:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id 63sm31786877wri.25.2019.10.15.02.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 02:30:17 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH] x86/hyperv: Set pv_info.name to "Hyper-V"
Date:   Tue, 15 Oct 2019 11:29:37 +0200
Message-Id: <20191015092937.11244-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael reported that the x86/hyperv initialization code printed the
following dmesg when running in a VM on Hyper-V:

  [    0.000738] Booting paravirtualized kernel on bare hardware

Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
with this addition, the dmesg read:

  [    0.000138] Booting paravirtualized kernel on Hyper-V

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 105844d542e5..c7d1801fa88b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -154,6 +154,8 @@ static uint32_t  __init ms_hyperv_platform(void)
 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return 0;
 
+	pv_info.name = "Hyper-V";
+
 	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
 	      &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
 
-- 
2.17.1

