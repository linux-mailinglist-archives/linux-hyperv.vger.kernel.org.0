Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56BB7EE7
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404229AbfISQR4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 12:17:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43594 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404228AbfISQR4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 12:17:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so2615785pfo.10;
        Thu, 19 Sep 2019 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsRBtfClCNm1ql8yg5rRkSFQz9KGIB6s6PLgGq7UHrc=;
        b=bb8z0jfXc77frU0TGE2lnmHZ5//Rk9Ccs+BnFrDFhcStAjAFTB/OTJjcyicg+ppcCh
         5RDeDscCIZE8NuyO/LTbhUmLt1Y/eSId+zfRwPoCUfr/JlZkdi/UutP4rlDIj/BmpYKi
         fCZmkftP528a60aeDOYPfAaqJNKoYQYHRsLjX3ecJqKGjAiVgoitPaj2pRjREIJvFi6F
         tUeBsYMwkPHNgkpvqQZ1XfNp6+SG+tzk17vDo5r2KQT5Q8IXWGP2F3u/+rSWElVA0KFL
         SfQpRA9wXGcyVPwuPNRxUhmic+9i+S8OjLKSsLYSZCiMV86XfUumgue0pqJE0qKOuPzL
         NFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsRBtfClCNm1ql8yg5rRkSFQz9KGIB6s6PLgGq7UHrc=;
        b=F3utIEnz6xVqW449F45VJPExR+35aaqrS6Oq0jftaIsgM2Y9ipRtBIlwSYHL9PGkYa
         yVWEo5kMcpjQgWVCbj9R00/MObjQ0vA8hcZOAM8oZsLUyR+3lr6uBOy19Os5pXt/jaOr
         qywNuZP8Z30TGxPbewt4Eodlg+SEAJWfIVdGzGIkjz2AQEGTS7+uS+UP/oWTgbkQDB71
         EbEP2p5VWFxrnyB8n321B4fbHRoxS+je52rTCSUQyrU9Jbwun8Pz0O/XV0EBludYF3eL
         LGuC2vk1DH4Ib+SwXybGnHgmII6ziYXi0JIqJVIge4g++hec1TAvYBYgokubJnk/1eXS
         exfQ==
X-Gm-Message-State: APjAAAXrxHlF+PkDWphafPsPBxd6feVVHiPg2l0gFD+TUFWGTxaM9BM3
        WioXFhlgDK+VYWN+tJEsB2U=
X-Google-Smtp-Source: APXvYqwr7TnX7/h8TuJ2AbWRBE/w0UkboPYNOKIQh6b88uOYZH0KW5HFBXvxBuO+DHn7exS2JjTaZw==
X-Received: by 2002:a63:db50:: with SMTP id x16mr9539842pgi.87.1568909875356;
        Thu, 19 Sep 2019 09:17:55 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n21sm5979264pjo.21.2019.09.19.09.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 09:17:54 -0700 (PDT)
Date:   Thu, 19 Sep 2019 09:17:52 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Message-ID: <20190919161752.GS237523@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568244975-66795-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dexuan,

On Wed, Sep 11, 2019 at 11:36:20PM +0000, Dexuan Cui wrote:
> We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event() call
> does not prevent the system from entering hibernation: the hibernation
> is a relatively long process, which can be aborted by the call
> pm_wakeup_hard_event(), which is invoked upon keyboard events.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> This patch is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
> Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> 
> I request this patch should go through Sasha's tree rather than the
> input subsystemi's tree.
> 
> Hi Dmitry, can you please Ack?
> 
>  drivers/input/serio/hyperv-keyboard.c | 68 ++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 88ae7c2..277dc4c 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -10,6 +10,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  
>  /*
>   * Current version 1.0
> @@ -95,6 +96,9 @@ struct hv_kbd_dev {
>  	struct completion wait_event;
>  	spinlock_t lock; /* protects 'started' field */
>  	bool started;
> +
> +	struct notifier_block pm_nb;
> +	bool hibernation_in_progress;

Why do you use notifier block instead of exposing proper PM methods if
you want to support hibernation?

Thanks.

-- 
Dmitry
