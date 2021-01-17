Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565352F9389
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Jan 2021 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbhAQPXl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 17 Jan 2021 10:23:41 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40041 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbhAQPXY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 17 Jan 2021 10:23:24 -0500
Received: by mail-wr1-f51.google.com with SMTP id 91so14069824wrj.7;
        Sun, 17 Jan 2021 07:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGscHCEw5N5o3xmGm70EwkaDpcwR5MuhDnNAvC0qCfc=;
        b=ktyYHjoleFyI2Ax30UXFkMsr+U29nKaPdXbbqpOb8sO1dD6NfCV1ZS6/OQ21Q4JNPS
         p+rB1iFuD26Q6gxTTl372khq/fh7JrJgFbUNhaWExSezWCi5x3QoHuSs8naoEx0UfaKm
         3u1LPr5Razqy4DwyoMQ2bqgFUbORi68VYn/IElDXswaIl8IgRqxOfd/p2ISnlRKvULJe
         l6OgvjwhfPPAaBON3Do/gjlVzGbHZpRLH51vZ8y9RFWtLt/a84G+1AkqwY+SX58Jn5fR
         trzzAZMAeERBpCGpSu4+RNWatGzxhYeBP8ElTt0JIQeyVGbJUzsPmFKoc2jUkLB06NkX
         2NHA==
X-Gm-Message-State: AOAM531MkaWl4/loSnmEvzMJHuScWNGLVJyXJ0yY+lI1k+XD07cbiNaf
        MNBtCPgkwHvxUBUNyIJFMp8=
X-Google-Smtp-Source: ABdhPJz1s6wb3ww0xx8K/IvH8oII2tLJXBOfM+HfbIl23+qO0UXoQcxzrdTVd3cf/4RfCi36k9E5Ug==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr21978390wrc.224.1610896958694;
        Sun, 17 Jan 2021 07:22:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 94sm26084841wrq.22.2021.01.17.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 07:22:38 -0800 (PST)
Date:   Sun, 17 Jan 2021 15:22:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>, g@liuwe-devbox-debian-v2
Cc:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "ohering@suse.com" <ohering@suse.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] x86/hyperv: Initialize clockevents after LAPIC is
 initialized
Message-ID: <20210117152236.nyoxxcs4c2hontm6@liuwe-devbox-debian-v2>
References: <20210116223136.13892-1-decui@microsoft.com>
 <MWHPR21MB15930BECFDF0251D36CFBB98D7A69@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15930BECFDF0251D36CFBB98D7A69@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jan 16, 2021 at 10:48:04PM +0000, Michael Kelley wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 16, 2021 2:32 PM
> > 
> > Fixes: 4df4cb9e99f8 ("x86/hyperv: Initialize clockevents earlier in CPU onlining")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> 
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.

> 
