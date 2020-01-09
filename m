Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37B135DDE
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2020 17:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgAIQNF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jan 2020 11:13:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42678 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgAIQNF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jan 2020 11:13:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so7960502wro.9;
        Thu, 09 Jan 2020 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6yj/7YzjyQLNXZxnms2P7cgL7F7rs/s3UQWjrOh43+M=;
        b=kG4db/UlXTZTtrXORtrdw0qjW5GSB/oI1yoHqtyCKe5w1V0xdEvFji7JXxeNi7/9gq
         WKknDUKq0fWfzzKlsNbDxJzuMB2ddozV8I4blStX/mY6liPmlKZa58s4/4gLaEJZ3wxi
         K9hNxynYWjq0bZxBYcTQ7Nar+MnPQC1lFAip5OaqxoseMEwEpqgblyO2eXU3exoQ55vj
         op0cQq6WM3ZI0stiQdTw9X0s49/ZWg9xhlzXa6EiPRzCtmbHVyAetl25FyCXLWA2utU/
         5HGdKD0gfOz3Bnv0GAfYKf7X9gkj5ortU4/AeRXtnDx+aIa/4KVUNv7AZlcpvbneaqtl
         MVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6yj/7YzjyQLNXZxnms2P7cgL7F7rs/s3UQWjrOh43+M=;
        b=aUd4mrU69zenWgIlh2odpfs2L7DvyTN20LKnElxfikS/FDzkKsfpEC6HTnQQGMSi2e
         B4zc82pzbFeU2+eruIbjHU1eFEd9+VECqKdr0FyNh526nYpAUAlD4kCKr4Yi7jDwT5oK
         8TsKOFX7NwgI96itJirJxcYBaZwgbw3ARD0JIVPGL3U/rqisI1FIh4qg5JPtMr9KxjPb
         QdUUoKJPDqOzG7//HqAdqV+YIGKx2/bKBdx3Vqs6Rr+TXLdq2WsaLDj8cRvFnMWrtJKz
         X9lx98kL1QAcoBL8ITGT4Oe2iEN8vGUXwZz5CvF3L3dZSZXMNV8/D/STVkn4HfbvpQ/N
         4BQg==
X-Gm-Message-State: APjAAAUBmDy1h/BVNI1/0AIT4ouXXNN+HsPoP9HlFPjL5Tsk2+HE4BF8
        cj6wxCOJqLiag/7G1mlM87JAIH7OSwSzROQ/
X-Google-Smtp-Source: APXvYqz/XsB+7WKpfDYPN9KlZHkXtMjU9SVQU7TYvChK4c06DMBhMUujcTYbpkxMDPbZ8CFxvnbACQ==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr11737489wrn.384.1578586383105;
        Thu, 09 Jan 2020 08:13:03 -0800 (PST)
Received: from andrea ([159.253.226.36])
        by smtp.gmail.com with ESMTPSA id z6sm8467573wrw.36.2020.01.09.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:13:02 -0800 (PST)
Date:   Thu, 9 Jan 2020 17:12:57 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 0/2] clocksource/hyperv: Miscellaneous changes
Message-ID: <20200109161257.GA16332@andrea>
References: <20191210093054.32230-1-parri.andrea@gmail.com>
 <20200108133344.GA8179@andrea>
 <7069f7ce-4ff7-3569-0d7e-615d1399283a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7069f7ce-4ff7-3569-0d7e-615d1399283a@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 09, 2020 at 12:40:04PM +0100, Daniel Lezcano wrote:
> On 08/01/2020 14:33, Andrea Parri wrote:
> > Thomas, Daniel,
> > 
> > On Tue, Dec 10, 2019 at 10:30:52AM +0100, Andrea Parri wrote:
> >> Provide some refactoring and adjustments to the Hyper-V clocksources
> >> code.  Applies to -rc1 plus Boqun's:
> >>
> >>   https://lkml.kernel.org/r/20191126021723.4710-1-boqun.feng@gmail.com
> >>
> >> Thanks,
> >>   Andrea
> >>
> >> Andrea Parri (2):
> >>   clocksource/hyperv: Untangle stimers and timesync from clocksources
> >>   clocksource/hyperv: Set TSC clocksource as default w/ InvariantTSC
> > 
> > I'm wondering if you could route these patches via tip; for reference,
> > 
> >    https://lkml.kernel.org/r/20191210093054.32230-1-parri.andrea@gmail.com
> > 
> > Both patches got Reviewed-by: Michael (even though I can't find his replies
> > on lore ATM).
> > 
> > Also, I realized that this series has a minor conflict with Dexuan's:
> > 
> >   https://lkml.kernel.org/r/1578350617-130430-1-git-send-email-decui@microsoft.com
> > 
> > (added to Cc:); please let me know if a rebase/resend is needed.
> 
> Yes please based on:
> 
> https://git.linaro.org/people/daniel.lezcano/linux.git timers/drivers/next

Done: https://lkml.kernel.org/r/20200109160650.16150-1-parri.andrea@gmail.com

Thanks Daniel.

  Andrea
