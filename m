Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77944352C
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Nov 2021 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhKBSO2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Nov 2021 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhKBSO1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Nov 2021 14:14:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF6C061714
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Nov 2021 11:11:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 17so33197579ljq.0
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Nov 2021 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UouM5URc7sS4x+3y3XOGOAo1iVE4ApmJUu+krC+yBpc=;
        b=HLsdjknpIhOMABwxYbLjXJcnZ/bMt4DoSa6O/3xXiAa0qKfsxqz2D77XsgjfLcogNP
         YMlxc1jF4TSWKIrhkbjvWu1q8x5sCrTaYAZ+uW19tDUPWj8JHI9zx9A7nANuNoVnGT4q
         qyh0hAYFDtr8spvo6DJvfU1qiKLwK1iNSoSQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UouM5URc7sS4x+3y3XOGOAo1iVE4ApmJUu+krC+yBpc=;
        b=OAmwLhd1S8bHyx+oSBNvtnvQn4YGUhZzSCz7G4UNI0nLvs59JuGJxehhY2olkWHXyT
         jAscNS207WVtg4GySkggz0Nu35azn+P/2ZpNdWp62yA+XNQmuf8O0NOKiw3YcN/tJRi9
         2KsPp3l9q/Y9vK/PA8ekoZEIqP7SzNm2wb48UYQ0VhmTfFGsmlmsy33OSueZnJZaSOnn
         M5VmMvUiKbr8cEAEhF7KB4ruLi458aQEfBnPsKb5Z7wKvsScyUeij2QICAaoiI1EHpI3
         Jhb0cDqvT75mpjO9xqEn9VOJzwmr7YcKfDixfVhvIr/NpxfJI7/ymjTiEOGweKyYmYae
         5ThQ==
X-Gm-Message-State: AOAM5318mDl6VH7zLMGRrNFjs5tsRZVECqFsxMi6ejja9W5Gea+1lFm4
        iya2tYKMeoC4sfDwp5IlW+UU5fh1aBXfi5x9
X-Google-Smtp-Source: ABdhPJybBm7mjgMAL801z9c1JvuyhSvaltonzqeP43yULcIvk/NzuTbGOr836pk2bxoFe+SjNsAMLA==
X-Received: by 2002:a2e:9e53:: with SMTP id g19mr41400348ljk.389.1635876710268;
        Tue, 02 Nov 2021 11:11:50 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s17sm1981561lfe.10.2021.11.02.11.11.46
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 11:11:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id d23so34954934ljj.10
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Nov 2021 11:11:46 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr41624398ljk.191.1635876705721;
 Tue, 02 Nov 2021 11:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
In-Reply-To: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 11:11:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wges7MttbFTQ9=YykWmn=B4F5pQsZNKNuxmyA1CUM7hNQ@mail.gmail.com>
Message-ID: <CAHk-=wges7MttbFTQ9=YykWmn=B4F5pQsZNKNuxmyA1CUM7hNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.16
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 2, 2021 at 6:13 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> There are two merges from the tip tree: one is because of Tianyu's
> patches went in via tip/x86/sev, the other is because a tree-wide
> cleanup in tip/x86/cc conflicted with Tianyu's patch.
>
> Instead of requiring you to fix up I thought I'd just do it myself.

Please don't do that.

Merging a pre-requisite and having a common branch that you merge - that's fine.

But don't hide merge conflicts from me by "pre-merging". It's not helpful.

And to make matters worse, both of those merges are BAD.

They have absolutely no explanation.

Christ.

For the millionth time:

   IF YOU CAN'T BE BOTHERED TO WRITE A PROPER COMMIT MESSAGE FOR A
MERGE, DON'T DO THE MERGE

I'm getting really tired of having to say this multiple times every
merge window (and often in between merge windows too).

Your merges are bad, and you should feel bad.

I've pulled this, but at some point I'm just going to have to decide
that "bad merges means I will not pull your garbage".

Merges need commit messages that explain what is going on, just as
much as any other commit does.

In fact, arguably they need *more* explanation, since they are subtler
and don't have the obvious patch associated with them that may clarify
what is going on.

So a merge message like

    Merge remote-tracking branch 'tip/x86/sev' into hyperv-next

is *NOT* an acceptable merge message. It needs an explanation of what
that SEV branch contained, and *WHY* those contents needed to be
merged into hyperv-next.

Again: if you can't explain the merge, or you can't be bothered, just
DON'T DO IT.

And no, the "hide conflicts from Linus" is _not_ an acceptable reason
to do merges.

I do so many merges that I can do most conflicts in my sleep, and
often do them as well or better than the submaintainers do. And I
write proper merge messages, and when a conflict happens it means I
*know* about it and am aware of how different trees ended up
interacting with each other - all of which is good.

Again - I've taken this pull request, but I'm not happy about those
merges. Even the merge that was perfectly fine to do wasn't done well.

               Linus
