Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C19366854
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Apr 2021 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhDUJsI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 05:48:08 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:44590 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhDUJsE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 05:48:04 -0400
Received: by mail-wm1-f50.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so878730wmf.3;
        Wed, 21 Apr 2021 02:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=byAleODMDPoZQ0ntwl50w8DGq+7YdYY2oogVoOwN1t0=;
        b=Kfqtz3RtUsST8oQpu7PaJMRINU41FED7F+OBVnV90o86fSHXZWmuyzl+ExaWOXEGPS
         tGeEw9zyDZkIF7UqBZCa4qJZOvKcf97uK+Sh53VRG0E1cH6vRWXoYBljUx8J6ccMeKUG
         /M2f4EXOk9FcxsFVV+rknd8x5mgGmp8ANxg+h01X4QnFDtNrZDkwBiI64kSo0xuqyFQb
         8N284wT5RwmXTLimF7OE6oPYepMGJNc9vvJOHpIW+THfZiOctWL4GoJkKhUqCRma4RA+
         IiFZL9DPOvKfudNU7P4KCnAWPA4khinXaWOuaJMjZ1Cwpgv1cFZro3+jNu/9F7sjqZie
         Hcxw==
X-Gm-Message-State: AOAM531O0STVmeCPFVbWO9IpUPgK9uXdJHkJVrgOVOkxyQqRjNn0RPmh
        npJ6B/lqAilO7EKhgnbTJwc=
X-Google-Smtp-Source: ABdhPJwu+jKQAjkPs7VBs01BQFt4ujQlYYi5kjduQzYA+hVEfu0Fy0Fu60i/Th8cfHeOhkB5+LvwHg==
X-Received: by 2002:a1c:f618:: with SMTP id w24mr8881161wmc.93.1618998448809;
        Wed, 21 Apr 2021 02:47:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o17sm2530062wrg.80.2021.04.21.02.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:47:28 -0700 (PDT)
Date:   Wed, 21 Apr 2021 09:47:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drivers: hv: Create a consistent pattern for
 checking Hyper-V hypercall status
Message-ID: <20210421094727.ulbzt7uktpxfw4hg@liuwe-devbox-debian-v2>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
 <1618620183-9967-2-git-send-email-joseph.salisbury@linux.microsoft.com>
 <MWHPR21MB15936E55F2A6FD6994DC4F34D7489@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15936E55F2A6FD6994DC4F34D7489@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 20, 2021 at 09:30:08PM +0000, Michael Kelley wrote:
> From: Joseph Salisbury <joseph.salisbury@linux.microsoft.com> Sent: Friday, April 16, 2021 5:43 PM
> > 
> > There is not a consistent pattern for checking Hyper-V hypercall status.
> > Existing code uses a number of variants.  The variants work, but a consistent
> > pattern would improve the readability of the code, and be more conformant
> > to what the Hyper-V TLFS says about hypercall status.
> > 
> > Implemented new helper functions hv_result(), hv_result_success(), and
> > hv_repcomp().  Changed the places where hv_do_hypercall() and related variants
> > are used to use the helper functions.
> > 
> > Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_apic.c           | 16 +++++++++-------
> >  arch/x86/hyperv/hv_init.c           |  2 +-
> >  arch/x86/hyperv/hv_proc.c           | 25 ++++++++++---------------
> >  arch/x86/hyperv/irqdomain.c         |  6 +++---
> >  arch/x86/hyperv/mmu.c               |  8 ++++----
> >  arch/x86/hyperv/nested.c            |  8 ++++----
> >  arch/x86/include/asm/mshyperv.h     |  1 +
> >  drivers/hv/hv.c                     |  2 +-
> >  drivers/pci/controller/pci-hyperv.c |  2 +-
> >  include/asm-generic/mshyperv.h      | 25 ++++++++++++++++++++-----
> >  10 files changed, 54 insertions(+), 41 deletions(-)
> 
> Wei -- I have gone through these changes reasonably carefully, but
> your review of the Linux-in-the-root-partition changes would be a good
> double-check.  It's too easy to get the sense of the tests backwards. :-(

The code looks correct to me.

> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks. I will apply this series to hyperv-next shortly.

Wei.
