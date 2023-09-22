Return-Path: <linux-hyperv+bounces-150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268907AA767
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 05:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 241BE1C2093D
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6EEB8;
	Fri, 22 Sep 2023 03:45:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5181E
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 03:45:34 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E459FE8;
	Thu, 21 Sep 2023 20:45:33 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 23CD7212C5B4; Thu, 21 Sep 2023 20:45:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23CD7212C5B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695354333;
	bh=NMNgZixFawrFHkja6vAm/CPSiWXDvRG8KizcyBOmbC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ezqh8fLYi0jq4DHGJLtyzms4myNKOcuxAWmfU94TUB1yZgq78Ao2AWJCSeQ/99DuQ
	 p1cBmG7vwRJPML7h7sDa97QYD3tp2xObZoUWiK9WtMn6ehN6SH3E5YvvHQLB8gh5qN
	 mFWL+qNnFrnIVnkuDEn2bV+Ulfe2l+hjbUurQRx4=
Date: Thu, 21 Sep 2023 20:45:33 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mikelley@microsoft.com,
	ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Message-ID: <20230922034533.GA17734@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
 <49e81d87-baee-4ba5-873c-ba32615beab0@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e81d87-baee-4ba5-873c-ba32615beab0@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 08:27:09PM +0200, Mathias Krause wrote:
> Missed it in my review, but the kernel bot already noticed it, so....
> 
> On 20.09.23 06:52, Saurabh Sengar wrote:
> > [...]
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 033b53f993c6..83019c3aaae9 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -340,8 +340,10 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
> >  
> >  #ifdef CONFIG_HYPERV_VTL_MODE
> >  void __init hv_vtl_init_platform(void);
> > +int __init hv_vtl_early_init(void);
> >  #else
> >  static inline void __init hv_vtl_init_platform(void) {}
> > +static int __init hv_vtl_early_init(void) {}
> 
> static inline

Thanks, will send v2 fixing this and the other typo in commit

Regards,
Saurabh

> 
> >  #endif
> >  
> >  #include <asm-generic/mshyperv.h>
> 
> Thanks,
> Mathias

