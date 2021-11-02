Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B95A443071
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Nov 2021 15:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhKBOei (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Nov 2021 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKBOeh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Nov 2021 10:34:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B22C061767
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Nov 2021 07:32:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f8so16466807plo.12
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Nov 2021 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sfdEDvXwBfyh9X1MMTqoUt0k0LCQsti+5vw3CstDg6I=;
        b=fpV2wr2nfOkJENh5GPNzdEdCpOoSv7KEImh08l1BLqnbouJNadYoYOtYHYmgsdOz+d
         k2tm+f39aCRMMDeno0DiD4m/DVcXnihQNLxLFeBLgWDaTqSgr4dBeZPwQ5ZVbDAFSR8p
         Qp6q8friWW5eeeOAjKu1mgxjACfJsE5ZWLzIQfheEafp3agOIJ7402PFa3a7cMbOMNgp
         hGHCfrHhKCuAbnVeIGh+IaZ6opZMxolbwRjEgp8veduChgRbZRw0uizT5eX9ZbDcpdkP
         SS4gZj3P9+XKv50TSfxLSS+7wdNCG4fEMduzjMlko9zIBv84pkx4mqzZC2aZvCH1udXv
         WDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sfdEDvXwBfyh9X1MMTqoUt0k0LCQsti+5vw3CstDg6I=;
        b=OEZbGMrsu7DJrWtpZ5TggYXstCH84Emn+435dRKe4lFxkp8cl/kk0AXku2btFpPF8Y
         7//XnQAKh6v1wXg8IIbDKD6NfOnvUxLFxs00YQExVSbL57zVHv+VjBTBlXDxs7hTo7+q
         0jAVG7hgmy2uMda6QPT94hnF9Ypjn3XYogAnBp21nihMCpPqHMTjWTqVFgWMDHVwaRhS
         I+Ar8+ah7OqSwTlQSnJe78pbGSbG6Jqm3KA4tuYixODJwOP0k2BIGP2PVZRzUjX+Qfi6
         HqEU7i+yJIvrSfGIrP9HWMkqq4jpvU/HEqVzZ0FdiTp1WqO6doRnLqOGCEhTwkw4VXsS
         PB7w==
X-Gm-Message-State: AOAM531egdUkF2z2iIy6zclCrjbGVIZAcURD6zmy1o8Vs9YIM1XaJ5If
        fS6mONheIXCxA27eOyxuX3vupg==
X-Google-Smtp-Source: ABdhPJxo78La3nWCPVfAP6VVzmt2f/FOYVcO1Q90/SHB4mTNVDivnL0IMMv9iIWrqUuM9AIqpDWsZA==
X-Received: by 2002:a17:90b:38c5:: with SMTP id nn5mr7062831pjb.220.1635863521609;
        Tue, 02 Nov 2021 07:32:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f20sm19337716pfj.108.2021.11.02.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:32:01 -0700 (PDT)
Date:   Tue, 2 Nov 2021 14:31:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
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
Message-ID: <YYFL3ZElxEBDMudH@google.com>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-2-seanjc@google.com>
 <87tuh0ry3w.fsf@vitty.brq.redhat.com>
 <20211102121731.rveppetxyzttd26c@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102121731.rveppetxyzttd26c@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 02, 2021, Wei Liu wrote:
> On Fri, Oct 29, 2021 at 11:14:59AM +0200, Vitaly Kuznetsov wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > The patch looks good, however, it needs to be applied on top of the
> > already merged:
> > 
> > https://lore.kernel.org/linux-hyperv/20211012155005.1613352-1-vkuznets@redhat.com/
> 
> Sean, are you going to rebase?

Yep, I'll rebase.
