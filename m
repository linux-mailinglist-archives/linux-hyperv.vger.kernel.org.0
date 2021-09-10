Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8D407100
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Sep 2021 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIJShr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Sep 2021 14:37:47 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36721 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJShq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Sep 2021 14:37:46 -0400
Received: by mail-wr1-f47.google.com with SMTP id g16so3949271wrb.3;
        Fri, 10 Sep 2021 11:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhtx2jHO2Z87aFol24mA1+eiErkclDQsj/2ggqYevms=;
        b=IJcvhgoyiIEtnGUTZ7grhq5MvXYuvsC0O4vUHZUG3/Fjh1+gjUhzCnSGP+uhI0ERNY
         HU0EJBjaOrGN6GFn5EGAAlaa5zW/ccQlo6yNUci2kexZIUT/LDGMj9pCuA5L5Uz2/k6p
         mAhGiTV81GBvboq7fD4DgvxggxKb6QMAzhHFgNtf/OwOcQMJ3RqJ24RcVI1s9kLt7GGS
         /nZTbv8gwe+TYBYF/4tBc3K642xjmhRy3aUkm8uHNv53v6kbd0ApAB32yKmpKdr8PtII
         iaSPMa4U3IvT3CJiKY7Lgkn9IL/CNS0TLhLGfe4d3CJiQo/EyoOu8chMwpjfShmest+N
         I8+A==
X-Gm-Message-State: AOAM531txRWPPgXYZTQJ4VtUzMAjAnSMX/E+xfaLIj0m0LcOXCxa6uI2
        xkadwOdFxk+m0qvCIvYHmTK1dJnsXsY=
X-Google-Smtp-Source: ABdhPJw49kqTX5ZE+hOsXE6q2wqhkBshZthOchkIq4owsNW4+zNW8ybPgW92FUEKnLKirDYcqWQYlQ==
X-Received: by 2002:adf:e10c:: with SMTP id t12mr11455948wrz.36.1631298994269;
        Fri, 10 Sep 2021 11:36:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l16sm6135813wrh.44.2021.09.10.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:36:33 -0700 (PDT)
Date:   Fri, 10 Sep 2021 18:36:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Message-ID: <20210910183632.5i6lu2h23ljofdru@liuwe-devbox-debian-v2>
References: <20210908194243.238523-1-wei.liu@kernel.org>
 <20210908194243.238523-3-wei.liu@kernel.org>
 <MWHPR21MB1593AE1097D5312649A1D3B4D7D69@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593AE1097D5312649A1D3B4D7D69@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 10, 2021 at 05:25:15PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, September 8, 2021 12:43 PM
> > 
[...]
> > -static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> > +static bool __send_ipi_mask(const struct cpumask *mask, int vector,
> > +		bool exclude_self)
> >  {
> > -	int cur_cpu, vcpu;
> > +	int cur_cpu, vcpu, this_cpu = smp_processor_id();
> >  	struct hv_send_ipi ipi_arg;
> >  	u64 status;
> > 
> > @@ -172,6 +177,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> >  	ipi_arg.cpu_mask = 0;
> > 
> >  	for_each_cpu(cur_cpu, mask) {
> > +		if (exclude_self && cur_cpu == this_cpu)
> > +			continue;
> >  		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
> >  		if (vcpu == VP_INVAL)
> >  			return false;
> > @@ -191,7 +198,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> >  	return hv_result_success(status);
> > 
> >  do_ex_hypercall:
> > -	return __send_ipi_mask_ex(mask, vector);
> > +	return __send_ipi_mask_ex(mask, vector, exclude_self);
> >  }
> 
> This all looks correct to me, except for one difference compared with the
> current code.  In the current code, if the cpumask passed to
> hv_send_ipi_mask_allbutself() indicates only a single CPU that is "self",
> __send_ipi_mask() will detect that the cpumask is now empty, and 
> correctly return success without making the hypercall.  But
> the new code will make the hypercall with an empty input mask (both
> in the SEND_IPI and SEND_IPI_EX cases).   The Hyper-V TLFS is silent
> on whether such a hypercall is a no-op that returns success or is an
> error.  We'll have a problem if it is an error.  I think the safest thing
> is to enhance the cpumask_empty() test at the beginning of
> __send_ipi_mask() to also detect the case where only a single CPU
> is specified, and it is "self".   This could be done using cpumask_weight()
> and checking for zero as the "empty" case.   Then check for "1", and if
> exclude_self is set, check if it is the "self" CPU.

Sure. Making this change should not be too difficult.

Wei.
