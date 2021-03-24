Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E596C347777
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Mar 2021 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCXLex (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Mar 2021 07:34:53 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:43948 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCXLef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Mar 2021 07:34:35 -0400
Received: by mail-wm1-f45.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so984610wmj.2;
        Wed, 24 Mar 2021 04:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wm/9a6kZkiuVOFe31z2+1vJJkLjZFaF876IvDwGaMmI=;
        b=aNPIHyGlX6kUhHd3dBqcYvxzqfz7mGQxbCb85IWHVnBdMGeFRa3kfh6PIw3ckDMSk7
         /SpIhiYQqSI3P5xvQIUROOpL+e0BFxZ0Y4xKIjr42YijPzeAaZm1lk7vSEBPHe41C/RN
         JIY2Zc6P5tguVAeDRqIomEFSW8p/hNMXnJvylNnFJFcebqgsBnSgPLYiop/sNFixnhRY
         YjVIGc4IRvH51eErwvyQQaSm+EhxOjMvf8gp7cXmYpU/utQVQ1/X7YiviAUby2PQQG3I
         afbgUIoRfam8Ufq+y6RTrKThTrNv7v2eYZTxN0thkndFViwIi0Yu+DNwFNpVfcwFWgek
         IQ3Q==
X-Gm-Message-State: AOAM5310+aJLkMfbsh15V4zwxGTIQ8xu4/0+0sfJFocrrPyW1C5a/pIY
        +zCsbAbihtCsowtB9ctawyc=
X-Google-Smtp-Source: ABdhPJwPJq3dYlQZdKdJ9R7TCaOjbAYsM9iwM2zP8j2DwSLab0Hc592VNibgh9UFHomwlxclhsnMSg==
X-Received: by 2002:a05:600c:3647:: with SMTP id y7mr2487829wmq.17.1616585668486;
        Wed, 24 Mar 2021 04:34:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a14sm2772901wrn.5.2021.03.24.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 04:34:27 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:34:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com
Subject: Re: [PATCH -next] x86: Fix unused variable 'hi'
Message-ID: <20210324113426.n5xmcqmrsjzrgwrd@liuwe-devbox-debian-v2>
References: <20210318074607.124663-1-xuyihang@huawei.com>
 <20210323025013.191533-1-xuyihang@huawei.com>
 <20210323113250.ktsfwr2wzjycugyk@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323113250.ktsfwr2wzjycugyk@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 23, 2021 at 11:32:50AM +0000, Wei Liu wrote:
> On Tue, Mar 23, 2021 at 10:50:13AM +0800, Xu Yihang wrote:
> > Fixes the following W=1 kernel build warning(s):
> > arch/x86/hyperv/hv_apic.c:58:15: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
> > 
> > Compiled with CONFIG_HYPERV enabled:
> > make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> > make W=1 arch/x86/hyperv/hv_apic.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> > 
> > HV_X64_MSR_EOI stores on bit 31:0 and HV_X64_MSR_TPR stores in bit 7:0, which means higher
> > 32 bits are not really used, therefore  potentially cast to void in order to silent this warning.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> > ---
> >  arch/x86/hyperv/hv_apic.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index 284e73661a18..a8b639498033 100644
> > --- a/arch/x86/hyperv/hv_apic.c
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -60,9 +60,11 @@ static u32 hv_apic_read(u32 reg)
> >  	switch (reg) {
> >  	case APIC_EOI:
> >  		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
> > +		(void) hi;
> >  		return reg_val;
> >  	case APIC_TASKPRI:
> >  		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
> > +		(void) hi;
> 
> I would like to remove the space while committing this patch. There is
> no need for you to do anything.

Applied to hyperv-next.
