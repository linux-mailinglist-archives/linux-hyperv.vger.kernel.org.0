Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6668E9C52
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2019 14:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfJ3Nby (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Oct 2019 09:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJ3Nby (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Oct 2019 09:31:54 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7108C20856;
        Wed, 30 Oct 2019 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572442313;
        bh=18iDLXageGOL+c+Fls3ArC5buu0vCBpPAh4iOmj3UdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGok/hqHg8b/5uBWCLPHDj8cuP9XVU++EDHjZvsoV0l5rJp1kNtq5oK5MgApRVs9Z
         yB0VobkpYMYZTEiZFrLpqBOyk+hmoaUdL4l+M/3J3DkM3Go4bNduXg/xvJlDUa/a7S
         PtDMQqeDb+QjRTm9cRrS3ozAeeyVZoVWXNKEa3RI=
Date:   Wed, 30 Oct 2019 09:31:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Hyper-V commits for 5.4-rc
Message-ID: <20191030133149.GN1554@sasha-vm>
References: <20191030113703.266992083E@mail.kernel.org>
 <CAHk-=wgx_pSBtvmQE9zuNB6aoP52z601SG1pQDtrhm9ZMHNPMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgx_pSBtvmQE9zuNB6aoP52z601SG1pQDtrhm9ZMHNPMw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 30, 2019 at 02:15:08PM +0100, Linus Torvalds wrote:
>On Wed, Oct 30, 2019 at 12:37 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
>
>No, Sasha, I'm not pulling this.
>
>It's completely broken garbage.

It is, appologies!

>You already sent me two of those fixes earlier, and they got pulled in
>commit 56c642e2aa1c ("Merge tag 'hyperv-fixes-signed' of
>git://git.kernel.org/pub/scm/linux/kernel/git/hyper>") two weeks ago.
>
>Fine - of the three fixes you claim, I could do this pull, and get at
>least one of them.
>
>Except YOU HAVE REBASED your branch, so I see the other two fixes that
>I already got as duplicates.
>
>WHY?

Honestly, I forgot that I sent you those two commits two weeks ago, but
still - you must be asking yourself why the heck would he rebase those,
right?

As I was working on the branch a few days ago I messed up and killed my
-fixes branch accidentally. To fix that I figured I'll just pick up
those 3 fixes again from my mailbox since they're grouped so nicely
over there and I haven't sent them to you yet.

Except that I did. And now they ended up with different IDs.

I then did a merge attempt before sending them to you, expecting that
things would blow up if I messed something up, but it didn't because the
commits themselves are identical, so I haven't noticed it then either.

Anyway, sorry about this, I'll resend it with just the relevant fix.

-- 
Thanks,
Sasha
