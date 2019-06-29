Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC35A948
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Jun 2019 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfF2Gut (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 29 Jun 2019 02:50:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38215 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfF2Gut (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 29 Jun 2019 02:50:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so3696001ple.5;
        Fri, 28 Jun 2019 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aT8yS1f8zu7gIaeWTUIp6sbTg4VXV0oDXYNI0tw7bjo=;
        b=a1HZ2pZUdPntMMwkXLl5kH4fKhJesWaeKJq2HaL3jWfMgZz5exlYIKLDi4L/2uO1AL
         lRe58iBwOM75v5dERnCZKBDyeUSf3LLh4CD2JFosrPJoClIff4+0zxZZCuF5TW77bzg+
         312oQ9fVg6jgV6FU9RCGbFLa1AdrZy20BhwgWINDFX5mQuI0Mfarw6FPcJk7/nUN3v48
         jE6uM68sKF9KOBdDPYS/GlZZ5GMkYzq5tyHZ23eMmwvvZztmE8ngb7I0QJNV29+rV4xF
         3X+6Mh4sm7V6zVWVYID+nQpB0qVnKuJNCs/Fh79vbrFEYVQEoIkCriXIQYQ/ewK+Ni8e
         fPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aT8yS1f8zu7gIaeWTUIp6sbTg4VXV0oDXYNI0tw7bjo=;
        b=Eg7OAPcXiCPIZt61JtyJ2LW3JkjaexkCD+kZyn0lYT98KncIFWaGJqcSc9xm23eGsW
         jq21EjWUd1Tr3DC7bOKSHf7TzudNv3tocuo6hdr9hs5knIXPchUHVg2QO7LMhjD5PCiy
         PTQxcpH+0yI0LevsQXFIHrM2yjsco8kt/QtJ9p7Pxb90dNfQzLlf6+PFnti1LJGz8/Eq
         p4IiTsxA/5lGE6KF74s/LUJRMenYXD7i8kxkcgs/IRdjfz1swG7HXs49hGYQIxWeFaBX
         4DDvcxKye/GN6kh7qulo1Omoimpa80VH14OpDTFaYms0U9rLo4K4QmJArzMtyTKVe49s
         TTUA==
X-Gm-Message-State: APjAAAVcoeO/tsDfpxHbJP48E8Q21U8Bz+UWJ2N1/jCaEIU72YqSQh6t
        PLSxKqF86CIPw38KWSpY+Hzvsv3M9nU=
X-Google-Smtp-Source: APXvYqxcQWrbKx1bfH2VeHwhwp1sEAA+Sg368l4EWApXd2geM3Xtog+YRICICXqCf3MVvMLWbJ21Pg==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr15684481plb.183.1561791048825;
        Fri, 28 Jun 2019 23:50:48 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id h21sm3225675pgg.75.2019.06.28.23.50.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 23:50:48 -0700 (PDT)
Date:   Sat, 29 Jun 2019 06:50:47 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] x86: hv: hv_init.c: Add functions to
 allocate/deallocate page for Hyper-V
Message-ID: <20190629065046.GA20171@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
References: <cover.1560837096.git.m.maya.nakamura@gmail.com>
 <d19c28cda88bf1706baff883380dfd321da30a68.1560837096.git.m.maya.nakamura@gmail.com>
 <alpine.DEB.2.21.1906272334560.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906272334560.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 27, 2019 at 11:38:14PM +0200, Thomas Gleixner wrote:
> Maya,
> 
> On Tue, 18 Jun 2019, Maya Nakamura wrote:
> 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 0e033ef11a9f..e8960a83add7 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> >  u32 hv_max_vp_index;
> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> >  
> > +void *hv_alloc_hyperv_page(void)
> > +{
> > +	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
> > +
> > +	return (void *)__get_free_page(GFP_KERNEL);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> > +
> > +void hv_free_hyperv_page(unsigned long addr)
> > +{
> > +	free_page(addr);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> 
> These functions need to be declared in a header file.
> 
> Thanks,
> 
> 	tglx
> 
Thank you for pointing that out, Thomas. I will resubmit my patch set to
include a header file with the function prototypes.
