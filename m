Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549CF1343E2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2020 14:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAHNdy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jan 2020 08:33:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHNdy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jan 2020 08:33:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so3370980wrw.8;
        Wed, 08 Jan 2020 05:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZJSVYNQ6Oy2yohdwnFTpWTZieC7lv6lLzf5cBqKG5M=;
        b=jmzULinctn02LS9XjgIufxPcMVlHa47Le3KjyFyn9PZrbVQZ/BRPc1xW7HYcdflG+4
         JFPr5zf3HsXcYhJPL0PrMXhnfpuWBHiXPt5Lc8WrccSerUl05v7EkCsLVdlybyyzBNxh
         nON4u2MBGGEYyth/LxpbOSoulyUk73B/FocA7vgiDtC2Aos/xh5lNLiVaEBCva2uWWjt
         qSeKrTHP0ug9dAIjucCfNyEOp0fuvyNXGOXi8CF3ZT3IbVZ5hxw7+gx/xCrD6uFbaKCS
         sI6DLKCaI78OwBVnvSlCohj1XMu+X9TyCGsgsX01QbnRDp4ueCQ8vRzWurvjD/UPGAMJ
         LgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZJSVYNQ6Oy2yohdwnFTpWTZieC7lv6lLzf5cBqKG5M=;
        b=Hh83NcO41w7+Tav1ep/8nSPb06+QrPm7/gxWTdXbdwQHHkP/idcsILmuLQ8pKrNkN4
         3HR4X7tf6C7uUjImq5rAhQ738EV7O17fe1vy4JEHGTibUpsbldPwDQxWO9eSIGUqf1qA
         Jupa1Rg3/b5QUjcrz5JldujXVQdr/CSEDc6WWIVs8ZkF6t9jdLbpnk8xr+HEb7PV7Qmm
         PEsg+PNRxVWpRH3EVNbJILdZwM1Jsn0LHUmHt6SXF1EQM0kRe6JoVmYC8CUEQu44oeAk
         o9NeQ3XN0Jxw9xAV7xYVVvN7jawQl3e+maWxEkossVwIGRw1lDZ9fQAGtCxq+LRQDKlW
         pjqg==
X-Gm-Message-State: APjAAAWv7mrsZEQMF3zZWprLGKxNKooAJVCRpN92zela2j2pv8QibCXw
        oTm/ecvvB5fk/g0f8/m0QFTzjl5T/oAx/vnq
X-Google-Smtp-Source: APXvYqz4W0s7vTXDbgpe0PRyebUwpIgzfkqP1VFQ7DsEQrjKsbD14p5nfH1bnGouYQ3ble1B5l8YLA==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr4687877wrt.367.1578490432114;
        Wed, 08 Jan 2020 05:33:52 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id e18sm4301043wrr.95.2020.01.08.05.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:33:51 -0800 (PST)
Date:   Wed, 8 Jan 2020 14:33:44 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 0/2] clocksource/hyperv: Miscellaneous changes
Message-ID: <20200108133344.GA8179@andrea>
References: <20191210093054.32230-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210093054.32230-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas, Daniel,

On Tue, Dec 10, 2019 at 10:30:52AM +0100, Andrea Parri wrote:
> Provide some refactoring and adjustments to the Hyper-V clocksources
> code.  Applies to -rc1 plus Boqun's:
> 
>   https://lkml.kernel.org/r/20191126021723.4710-1-boqun.feng@gmail.com
> 
> Thanks,
>   Andrea
> 
> Andrea Parri (2):
>   clocksource/hyperv: Untangle stimers and timesync from clocksources
>   clocksource/hyperv: Set TSC clocksource as default w/ InvariantTSC

I'm wondering if you could route these patches via tip; for reference,

   https://lkml.kernel.org/r/20191210093054.32230-1-parri.andrea@gmail.com

Both patches got Reviewed-by: Michael (even though I can't find his replies
on lore ATM).

Also, I realized that this series has a minor conflict with Dexuan's:

  https://lkml.kernel.org/r/1578350617-130430-1-git-send-email-decui@microsoft.com

(added to Cc:); please let me know if a rebase/resend is needed.

Thanks,
  Andrea
