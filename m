Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443CA4452F7
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Nov 2021 13:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhKDM1b (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Nov 2021 08:27:31 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51797 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhKDM12 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Nov 2021 08:27:28 -0400
Received: by mail-wm1-f53.google.com with SMTP id z200so4375723wmc.1;
        Thu, 04 Nov 2021 05:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKlTQegofiRIXde3I+n3/kYwmsLXXUXy5fuu78XfdFI=;
        b=pw+RBR7dYljLmulDrBk/DEJHf4AdkbLah5jQmYUUWlhUhRDk091nncQx7VLyBKx50W
         OUd96pXohMjpFJ/5Lwgzkc6r79ZBUZRNrnD4Dh215eTaAUzzKGwqFDpFXUR3OBWxF436
         hqTIXSCMW/kpdwFNGS7FfAjM48r4rVP8rn0tkE5/XqpDjOweHGlUPdz1Ter5lYE8yP2O
         wN5kKSyg/0V8xE5dRoK/adgvQQpqlvREt4f0y6vnKO4gdD4eqJsgtoF1jNhyd94iPjjO
         j7xGMwNc9RsV8evWIJ5RYOWMUmMyzphVJ3WttXSQAVQOHBSvjQl5q7kYWwgRH6HmftZO
         uwyg==
X-Gm-Message-State: AOAM531QDrV6a7u5mygTbrdTlEeYL3Szbw15IGAuFu6tGjZ3BWyync+c
        eYrlIkjJya5tzLAugfb/Xh4=
X-Google-Smtp-Source: ABdhPJytqW8mp8sofqo3RsrlVEU6eDTBNT7gv0jXtAPrvKOhdDG/CKvaQ/mGTzSRrbeQfSXnknRfBA==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr22946882wmc.176.1636028689497;
        Thu, 04 Nov 2021 05:24:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l2sm4632303wmq.42.2021.11.04.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:24:49 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:24:47 +0000
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
Message-ID: <20211104122447.tfeyzlu5oyv6fzpc@liuwe-devbox-debian-v2>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-2-seanjc@google.com>
 <87tuh0ry3w.fsf@vitty.brq.redhat.com>
 <20211102121731.rveppetxyzttd26c@liuwe-devbox-debian-v2>
 <YYFL3ZElxEBDMudH@google.com>
 <20211104121030.sfmmmum3ljant3wg@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104121030.sfmmmum3ljant3wg@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 04, 2021 at 12:10:30PM +0000, Wei Liu wrote:
> On Tue, Nov 02, 2021 at 02:31:57PM +0000, Sean Christopherson wrote:
> > On Tue, Nov 02, 2021, Wei Liu wrote:
> > > On Fri, Oct 29, 2021 at 11:14:59AM +0200, Vitaly Kuznetsov wrote:
> > > > Sean Christopherson <seanjc@google.com> writes:
> > > > The patch looks good, however, it needs to be applied on top of the
> > > > already merged:
> > > > 
> > > > https://lore.kernel.org/linux-hyperv/20211012155005.1613352-1-vkuznets@redhat.com/
> > > 
> > > Sean, are you going to rebase?
> > 
> > Yep, I'll rebase.
> 
> Thank you!

One further note: Vitaly's patch just hit mainline two days ago, but
v5.16-rc1 is not tagged yet. Feel free to base you new patches on
hyperv-next or linux-next. I will handle the rest.  Or you can wait
until v5.16-rc1 is tagged and base your patches on that. Your call.

Thanks,
Wei.

> 
> Wei.
