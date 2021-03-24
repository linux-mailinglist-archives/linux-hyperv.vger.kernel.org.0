Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765E3347754
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Mar 2021 12:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhCXL2Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Mar 2021 07:28:16 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45039 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhCXL2N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Mar 2021 07:28:13 -0400
Received: by mail-wr1-f44.google.com with SMTP id c8so11156790wrq.11;
        Wed, 24 Mar 2021 04:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KU6Dop6apks1kihX2YOTKvNWDKeXQ1Kugy0fdGkesUo=;
        b=RQlvlYRLezr7U+O3czo3zDVKnUtg4dbCrFfTf/LVt+gI+FVrrjAxAzulBGkkFzOUi0
         baCcPYu7KluymLwAWdVNOI23Qg4dcKigb3yv7tzUY4Wm4CEhg9HIU5NQknbUmNf9TSUA
         gvtMRoUdW9Mz0gzRmwC1kLNCWdEp2ba0xlglMAytPY60QypPyrqN0E9vkiM7US562gEh
         fj+/Yk/EKasXK5H/jp1w8H/1IMCM6n5bGbT0795rHJxcyDH9ru9ATGxdhM1RNee9p5Nb
         A/QIwGMpaOVyF17WHRUix//DREIkFuYWqdT9fHsDMkVo4+ViZP2bLQrpxKJ5cQb/fM/8
         dtWg==
X-Gm-Message-State: AOAM532m51B2eZKiUD3IDoGJUs1yuzwlTxoBgVLFzvUnE0+36ivg7mDG
        uGSrNYO+kCGP7AYxgWv7i4c=
X-Google-Smtp-Source: ABdhPJyprfHTGT03IVPxhkqw3jBH7YUkK5fWR9U6uwyBT311htVyjfE/HL884+ZtcLB4mkY4Yyl+6g==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr3140552wrw.70.1616585291877;
        Wed, 24 Mar 2021 04:28:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i16sm4663531wmq.3.2021.03.24.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 04:28:11 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:28:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com, heying24@huawei.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Message-ID: <20210324112810.lkeu3ffv6dv7fbab@liuwe-devbox-debian-v2>
References: <20210322031713.23853-1-xuyihang@huawei.com>
 <20210323024302.174434-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323024302.174434-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 23, 2021 at 10:43:02AM +0800, Xu Yihang wrote:
> Fixes the following W=1 kernel build warning(s):
> arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable ‘msr_val’ set but not used [-Wunused-but-set-variable]
>   unsigned long msr_val;
> 
> As Hypervisor Top-Level Functional Specification states in chapter 7.5 Virtual Processor Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr privilege (refer to section 4.2.2) may trigger entry into the virtual processor idle sleep state through a read to the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read is necessary, msr_val is not uesed, so potentially cast to void in order to silent this warning.
> 
> Reference:
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>

Applied to hyperv-next. Thanks.
