Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2A443566
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Nov 2021 19:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKBST2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Nov 2021 14:19:28 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33555 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhKBST2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Nov 2021 14:19:28 -0400
Received: by mail-wr1-f44.google.com with SMTP id d24so4085042wra.0;
        Tue, 02 Nov 2021 11:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9F53UeZxts0KkuS7BqmAGiTCh9kaqx5yW63C8WAYLFw=;
        b=mR696zBfkeavtqqnVr+dI8pfTJnRwiSHimzZXxEvYE7SigilxfCsX02JNRf9PjXsYC
         xA+Tw1qx2aQHimKU2nEWPYDhL/D0rQ/PRfDN6TqpaO3hpoJhhLabehHBcqVqkwu+zUbr
         ykZJvwK/67yy/E2q0HDofi3cpIV3WKJh5/nGEeUA39qBAUidjkLGTS2h0Mxg1ngF++b0
         V9F1/DCFUIlpQw3WHA6p5YCJpSGBKDjjZ7fXAYGXADeTa5KLL/HyxFrUMSFq1kU0ocUY
         RlpRk9cfYXo1RFjBNUEn7V2zrWY62a554Ia/4Fs0JxBQQ0l8p7llgt/0F5kGEQr7A/hs
         uCfg==
X-Gm-Message-State: AOAM531eU/QJrXcx1Rva3S+BY6dKLyTI39tWE1EUutb0lELrZ/3S9nLl
        /iVcogBauPsQkVq1HzPYlrA=
X-Google-Smtp-Source: ABdhPJxNyvZyA2AhEaG/1YewkpF0r0p8qpWN4UzY6LfmlZLhM8es3U+1krASA3TaDA18GHS6vyJuAA==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr13151325wrj.325.1635877012210;
        Tue, 02 Nov 2021 11:16:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a4sm1915867wmg.10.2021.11.02.11.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 11:16:51 -0700 (PDT)
Date:   Tue, 2 Nov 2021 18:16:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.16
Message-ID: <20211102181649.pc3nhrajmyhd4fnq@liuwe-devbox-debian-v2>
References: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
 <CAHk-=wges7MttbFTQ9=YykWmn=B4F5pQsZNKNuxmyA1CUM7hNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wges7MttbFTQ9=YykWmn=B4F5pQsZNKNuxmyA1CUM7hNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 02, 2021 at 11:11:29AM -0700, Linus Torvalds wrote:
> On Tue, Nov 2, 2021 at 6:13 AM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > There are two merges from the tip tree: one is because of Tianyu's
> > patches went in via tip/x86/sev, the other is because a tree-wide
> > cleanup in tip/x86/cc conflicted with Tianyu's patch.
> >
> > Instead of requiring you to fix up I thought I'd just do it myself.
> 
> Please don't do that.
> 
> Merging a pre-requisite and having a common branch that you merge - that's fine.
> 
> But don't hide merge conflicts from me by "pre-merging". It's not helpful.
> 
> And to make matters worse, both of those merges are BAD.
> 
> They have absolutely no explanation.
> 
> Christ.
> 
> For the millionth time:
> 
>    IF YOU CAN'T BE BOTHERED TO WRITE A PROPER COMMIT MESSAGE FOR A
> MERGE, DON'T DO THE MERGE
> 
> I'm getting really tired of having to say this multiple times every
> merge window (and often in between merge windows too).
> 
> Your merges are bad, and you should feel bad.
> 
> I've pulled this, but at some point I'm just going to have to decide
> that "bad merges means I will not pull your garbage".
> 
> Merges need commit messages that explain what is going on, just as
> much as any other commit does.
> 
> In fact, arguably they need *more* explanation, since they are subtler
> and don't have the obvious patch associated with them that may clarify
> what is going on.
> 
> So a merge message like
> 
>     Merge remote-tracking branch 'tip/x86/sev' into hyperv-next
> 
> is *NOT* an acceptable merge message. It needs an explanation of what
> that SEV branch contained, and *WHY* those contents needed to be
> merged into hyperv-next.
> 
> Again: if you can't explain the merge, or you can't be bothered, just
> DON'T DO IT.
> 
> And no, the "hide conflicts from Linus" is _not_ an acceptable reason
> to do merges.
> 
> I do so many merges that I can do most conflicts in my sleep, and
> often do them as well or better than the submaintainers do. And I
> write proper merge messages, and when a conflict happens it means I
> *know* about it and am aware of how different trees ended up
> interacting with each other - all of which is good.
> 
> Again - I've taken this pull request, but I'm not happy about those
> merges. Even the merge that was perfectly fine to do wasn't done well.
> 

Okay. Noted. Thanks for pulling in those patches. I will keep what you
said above in mind for future PRs.

Wei.

>                Linus
