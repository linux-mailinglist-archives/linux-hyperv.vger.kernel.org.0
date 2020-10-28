Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8429D9BF
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Oct 2020 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389978AbgJ1XCO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Oct 2020 19:02:14 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39208 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389971AbgJ1XB6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Oct 2020 19:01:58 -0400
Received: by mail-wr1-f50.google.com with SMTP id y12so787134wrp.6
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2020 16:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yXl8l4BrsVKV8QmthfUAWk0SK0mccjdd63M9IFR/LAQ=;
        b=kyqamxjN9W0XonIeQkEx3pNMF1Nwfy1J3Pm52n+6AwH4zDyUKlJDXQm1+IQGzbE5jE
         hOv9Iq2djCVgsfhD34/xR+lfwY0hZtirsAJoPC/Wn2b41A6AyZ1fH4X4dx/Xa7GMIf6P
         jxYxgK/VuoiF2yGm7+sEnJtkmmRU1PDuetN/S6mPKHDxXqj55bvvuO5DfKF08Gg+Smvp
         0YhO6jNLYbmEFUcLxSRCfCgJEUHjmPrCnLw8uiQr86JGi4eRcHtX5sRzmoj7nDvh/3MV
         w04tznG4O8qZYu8wPhT/z2dwry9P9aRC/jiS1YxI9qu6lDNOZdRovg9ZchlFlpZuaGhp
         z2LA==
X-Gm-Message-State: AOAM532i6u4mXDOC0Ht4Yk76+T7LcoM/Vru7iDfjwy9EklEWnis0Phqx
        a75Gc+qtqK7gODax40qjIpsyOdb7qQs=
X-Google-Smtp-Source: ABdhPJy5LgrBi2j0XRrIYr+sC9vYq1sRGa+7CTitH5zNofNtwvJKjeEBy4joHI2DNonj/i6tTuBdCw==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr9191172wro.88.1603897405703;
        Wed, 28 Oct 2020 08:03:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q12sm4407256wrx.13.2020.10.28.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:03:25 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:03:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Field names inside ms_hyperv_info
Message-ID: <20201028150323.tz5wamibt42dgx7f@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all

During my work to make Linux boot as root partition on MSHV, I found out
that a privilege mask was not collected in ms_hyperv_info.

Looking at the code, the field names of ms_hyperv_info are not
consistent with the names defined in TLFS. That makes it difficult to
choose a name for the field that stores the privilege mask.

I've got a local patch to make the existing fields closer to TLFS. The
suffix "_a" means the value comes from EAX.

Given that this structure is also used on ARM, so having x86 suffix is
probably not the best idea. Do people care?

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c57799684170..913af5e93cce 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -26,9 +26,9 @@
 #include <asm/hyperv-tlfs.h>

 struct ms_hyperv_info {
-       u32 features;
-       u32 misc_features;
-       u32 hints;
+       u32 features_a;
+       u32 features_d;
+       u32 recommendations;
        u32 nested_features;
        u32 max_vp_index;
        u32 max_lp_index;

Any comment on this? I'm normally bad at naming things so any suggestion
is welcomed.

Thanks,
Wei.
