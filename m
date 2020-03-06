Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3817BA2F
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2020 11:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFK3J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Mar 2020 05:29:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37393 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFK3J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Mar 2020 05:29:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id 6so1718038wre.4;
        Fri, 06 Mar 2020 02:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kPmvm5eep4b15mdjBsaFZDnjDCC2+N4EYbDGpSejUoI=;
        b=eyunxr9X2CcqC055epinyd7TPLTWSX3qdUKqbxUgTJgzC4OmqDHh35TURP5XgCN+8a
         g2/3HkjOs/EeJhAO3rPEEmD85NtOnL/B4HzUmtEDzGnAx1mDUFRe703nTHZJPgqIV6yV
         oVcJDCLsBsRYVxTbnERCA7qs608UbJQYsCYDc/4ZyOGkhybszlH8+kZ0LszvlvHSrZ3v
         J9y+Fbaz9M4/wn6y4Vm3IuI/e6NEme832uD7I0wlOGxyG2uh/Zgvbu2s/ysAau7cVHc9
         xXp5oefkXl3zH9FKbr2f1K58iBAUurgDsE7NRznk8+DN3buteIeAxFqAgwTbp/8BWZC2
         WKkw==
X-Gm-Message-State: ANhLgQ0l300C8RnGmfocfZ4S6aXIbpoCwa+kJsjLZx+PML9BT8YmmxMf
        ag6kxW93ukSmYfKEEc87dBQBKWph
X-Google-Smtp-Source: ADFU+vuf9OdMAReh9/+brhM7Nvsa4VH/zzToHxnC+7vV4GfFUX3cG99oYOKa0H9UBCPR0ORcGMisKw==
X-Received: by 2002:a5d:5224:: with SMTP id i4mr3143044wra.285.1583490547034;
        Fri, 06 Mar 2020 02:29:07 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id i6sm15429541wra.42.2020.03.06.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:29:06 -0800 (PST)
Date:   Fri, 6 Mar 2020 10:29:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        Sasha Levin <sashal@kernel.org>, haiyangz@microsoft.com
Subject: Re: [GIT PULL] Hyper-V commits for 5.6-rc
Message-ID: <20200306102904.625skxmfbne2zwbp@debian>
References: <20200305155901.xmstcqwutrb6s7pi@debian>
 <CAHk-=wisKNsaOOCO8TfigKwmuqX83+KvntYeGq-KbOcSPunQbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisKNsaOOCO8TfigKwmuqX83+KvntYeGq-KbOcSPunQbg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 05, 2020 at 12:28:48PM -0600, Linus Torvalds wrote:
> On Thu, Mar 5, 2020 at 9:59 AM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > This is mostly a "dry-run" attempt to sort out any wrinkles on my end.
> > If I have done something stupid, let me know.
> 
> Looks fine. I generally like seeing the commits being a bit older than
> these are - you seem to have applied or rebased them not all that long
> before sending the pull request. I prefer seeing that they've been in
> linux-next etc, but for soemthing small like this I guess it doesn't
> much matter. Next time?

Ack.

Those patches were applied not very long before sending the pull request
because I thought simple patches should be fine.

In the future I will let patches go in linux-next first.

Wei.
