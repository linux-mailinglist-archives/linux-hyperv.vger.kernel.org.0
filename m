Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40C4452BB
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Nov 2021 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKDMNM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Nov 2021 08:13:12 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42778 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDMNL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Nov 2021 08:13:11 -0400
Received: by mail-wr1-f49.google.com with SMTP id c4so8229863wrd.9;
        Thu, 04 Nov 2021 05:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cyNM+j0qhyxH/tLBZrf3FexYDPueAy0m7pZgh6HtAN0=;
        b=LvIUzjtz6bE3Ddk4visSpivy8lDnPVwdLK9bem1Pg0vL9ZwN1B9o2Q1f9Pcwu2LOh/
         B0Ae8M4ZBZB1OeoJA0dDVnKSjUm+gng8BRAiitwatO1oZfklp8S+dDuIvdOWiX38FhUM
         xa+uAUVnbq3zwJt51wXTQD73w4BUh1B+DPHQGMs8qbilB97MY0hxWlJ2sNeMCIiRr1mX
         zlb2ThTKZAeIiQnII1/ej4IiELBq+SRAoXvq/9f6CMyEofsfQfyxwYfGhPRtdEK2V9QK
         KljWaZ6gm+0PaVBwhWpIJuZ06Oc+8pDbApd2Q/Dfupvbhe5x/UuYKsB5MDELKs9MxaaT
         Dv8w==
X-Gm-Message-State: AOAM532lbvwEqbPmoo/dUJXrZCoSVOBs2E0RzIppdAArCgErbRiwE7RN
        xjK6FMUsCSSdxY0isdB0exs=
X-Google-Smtp-Source: ABdhPJzr0sJpNT01vUktIyle6kJzYfePxWJVjoMQe18F6SajnM/SNRGGD5SWHezxejuRLzVpjk30iA==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr63622157wrp.37.1636027832967;
        Thu, 04 Nov 2021 05:10:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c6sm5301327wmq.46.2021.11.04.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:10:32 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:10:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Fix NULL deref in set_hv_tscchange_cb()
 if Hyper-V setup fails
Message-ID: <20211104121030.sfmmmum3ljant3wg@liuwe-devbox-debian-v2>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-2-seanjc@google.com>
 <87tuh0ry3w.fsf@vitty.brq.redhat.com>
 <20211102121731.rveppetxyzttd26c@liuwe-devbox-debian-v2>
 <YYFL3ZElxEBDMudH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYFL3ZElxEBDMudH@google.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 02, 2021 at 02:31:57PM +0000, Sean Christopherson wrote:
> On Tue, Nov 02, 2021, Wei Liu wrote:
> > On Fri, Oct 29, 2021 at 11:14:59AM +0200, Vitaly Kuznetsov wrote:
> > > Sean Christopherson <seanjc@google.com> writes:
> > > The patch looks good, however, it needs to be applied on top of the
> > > already merged:
> > > 
> > > https://lore.kernel.org/linux-hyperv/20211012155005.1613352-1-vkuznets@redhat.com/
> > 
> > Sean, are you going to rebase?
> 
> Yep, I'll rebase.

Thank you!

Wei.
