Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D1B8B90
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2019 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395038AbfITHdb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Sep 2019 03:33:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43538 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394985AbfITHdb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Sep 2019 03:33:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so7554956qtv.10;
        Fri, 20 Sep 2019 00:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7v7DniLx9tcNbVApGQTeXXdGqpqeX4Pj6troBXosrk=;
        b=r+qWCyLOp2xKbZn1tJ6A/mSFfrkO7Nbl1BPgH0ttCUA818xUZWmpwgSLjuhiWKyeGu
         VHJxDWsiaoYPKeoWSvc9L1VgKTfOm/nJvNpAD14mQqkcScO5JHjf+J9fE6uecx8WFiz2
         pfWmm9betEjQq7Ax9hSxTtpD7OW4EQ+2bLnmcqpFLXinstaKfnvBwDGNTRkCVVlroP9V
         zcIncGQhi9u9w7FDPMm9NHPrIkn2ah12FOJXtmSUujuaD7eQXR7KTW0X/Hlt+V+B/UKX
         UNYNCNJGPaEJScvUSTydgHHMmg4Ico/F2bgjr7ajFhtPy6xnJUBa9zTEG+a+HvlRxlnw
         Tztw==
X-Gm-Message-State: APjAAAXHSBvrVRcM4AqhO57mLUe7/WOtszdra8REoYUUPXPLEs/tnMpm
        JtcvBagm+lCvs4ODJaS8qFLX5apMINi1woZGUWc=
X-Google-Smtp-Source: APXvYqxzWoo+UkH9tzBr4UGnEdEBfAOVJT2fMAVnwsyhI4L+H0Wvf57ouP3odhhn7Mm+FpyAwpYRRk5348It6xRG7wg=
X-Received: by 2002:a0c:d084:: with SMTP id z4mr11690320qvg.63.1568964810024;
 Fri, 20 Sep 2019 00:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <1568870297-108679-1-git-send-email-decui@microsoft.com>
 <CAK8P3a0oi2MQwt-P8taBt+VS+RTaoeNBgjoYNE7_L2VoQUSaEA@mail.gmail.com> <PU1P153MB016971CD922FC453F3E31E04BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB016971CD922FC453F3E31E04BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Sep 2019 09:33:13 +0200
Message-ID: <CAK8P3a0EvdR0SZdPhRV2o3PrxHo4BpJdWzAjExmKHhwrOsL54Q@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 19, 2019 at 11:38 PM Dexuan Cui <decui@microsoft.com> wrote:
> > Sent: Thursday, September 19, 2019 5:11 AM
> > On Thu, Sep 19, 2019 at 7:19 AM Dexuan Cui <decui@microsoft.com> wrote:

> > I think this will still produce a warning if CONFIG_PM is set but
> > CONFIG_PM_SLEEP is not, possibly in other configurations as
> > well.
>
> You're correct. Thanks!
>
> I'll use " #ifdef CONFIG_PM_SLEEP ... #endif" instead.
>
> The mentioned functions are only used in the micros
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, which is empty if CONFIG_PM_SLEEP
> is not defined. So it looks to me using "#ifdef CONFIG_PM_SLEEP ..." should
> resolve the issue.

Probably, yes. There are sometimes surprising effects, such as when one of the
functions inside of the #ifdef call another function that is otherwise unused.

I would normally try to build a few hundred randconfig builds to be fairly sure
of a change like this, or use __maybe_unused like most other drivers do here.

       Arnd
