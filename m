Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47A4343EC4
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVLCv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 07:02:51 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51935 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCVLCY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 07:02:24 -0400
Received: by mail-wm1-f49.google.com with SMTP id p19so9225170wmq.1;
        Mon, 22 Mar 2021 04:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BiMK781eStD+pPVhDiy7PA0LMsxXNJAo0Ygpgg62UGc=;
        b=YgxXTmNZLa//f+TIt3uDgAHrQGabu77DxS0d9JqN7kyktOq7gbBtkOXyq9wbsmOdMx
         3+DqawMfRiCr4NecqEjgmsVOhMvOOt1SijF5VUGVhwnIg0ajvooVQQjYtPhRmEjlOYvp
         gDTb1mKUCPoLw67bKDkGOdocR+rcqRrqYNns8hiOyPZCGYEsEiog8vVNS1Ot4hZWVnna
         i4GnwXg1FJthio9RKyLsgYnQZ/B6yAUuS7qm1det2HaclbS6G+p3ziTDfWGCO3p39eXu
         Vl588h5V9kiua/gGw6ufPeGMsTrGG8dRuThQrcEsP4gxDiJgwdTAQkmpcshHjofhGOcH
         eVDw==
X-Gm-Message-State: AOAM530HRtTpKHikeuYRNIyUoy11NyIAbLqhGEMXiePJWiq3XtZGO1UG
        dLw196UaR+hyE385ny46x8wDUUxQTlQ=
X-Google-Smtp-Source: ABdhPJz64NssYErwjK847VbkVBbj7UBwVEf8zwqFhxxnmXCPfQXBGaIAbQB9YhD1BpOxKDP9nl/wZA==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr15517329wmb.62.1616410942357;
        Mon, 22 Mar 2021 04:02:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y16sm19549425wrh.3.2021.03.22.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:02:21 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:02:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com
Subject: Re: [PATCH -next] x86: Fix unused variable 'hi'
Message-ID: <20210322110220.ovhqoykjdoptu6gr@liuwe-devbox-debian-v2>
References: <20210318074607.124663-1-xuyihang@huawei.com>
 <20210322035426.71169-1-xuyihang@huawei.com>
 <20210322035426.71169-2-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322035426.71169-2-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 22, 2021 at 11:54:26AM +0800, Xu Yihang wrote:
> Fixes the following W=1 kernel build warning(s):
> arch/x86/hyperv/hv_apic.c:58:15: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
> 
> Compiled with CONFIG_HYPERV enabled:
> make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> make W=1 arch/x86/hyperv/hv_apic.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> 
> HV_X64_MSR_EOI stores on bit 31:0 and HV_X64_MSR_TPR stores in bit 7:0, which means higher 32 bits are not really used, therefore __maybe_unused added.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>

I slightly modified the commit message and queued it up for hyperv-next.
Thanks.

Wei.
