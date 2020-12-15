Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17792DB1B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Dec 2020 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgLOQnj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Dec 2020 11:43:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38960 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgLOQna (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Dec 2020 11:43:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id 3so19131337wmg.4;
        Tue, 15 Dec 2020 08:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L1u7EdyvwjxUG6AtNBhGBQuSsNPPWKR8uMS0CeSCWPI=;
        b=tKHDhk6Na/4Fvu356sigICGFDeEDt69aVB+b0l2DvIbd1N/24nJ32hDpklYIrqZMUN
         x8xkSBKei+GPVjLDgN2DQmgpnTKdm619L3f81dF+1tPhIos+IeQiNUpTYgeg2pE8zgz3
         DlGxigc6NwKPUuXDnaFBprdh2bw/6q4Da7G+OORzklmks3hsgQ5cGheIvsOKNF6cHG5U
         VESI0mcrTlQMBaWvO8sqljFG1KgT2i281UCCcTqI6h2CZedIaysZbJV4mJcrp735n9Gm
         GFHGsMZUP7dp7NsWrxi1WJHk4nX9/qi3/9QchG1zx0o4mbdjPeMXREBxCSPVZBbDh6ZO
         eEow==
X-Gm-Message-State: AOAM533LGiC1GtJFihEKoTIyS0zMhM9huDW+4tU1LQDaXXTeblal+2Pq
        Rv7hxs0GeZgUzOXGp+puIVw=
X-Google-Smtp-Source: ABdhPJwgY7ozOUvVEU2mB6HgEBLM+BmFB6W5nXAhhCCRGC8cO7GIumbuf96N4iTTB9cRb1PUX8fSIQ==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr33871783wml.50.1608050567677;
        Tue, 15 Dec 2020 08:42:47 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b13sm31680755wrt.31.2020.12.15.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:42:46 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:42:45 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        sameo@linux.intel.com, robert.bradford@intel.com,
        sebastien.boeuf@intel.com
Subject: Re: [PATCH v3 00/17] Introducing Linux root partition support for
 Microsoft Hypervisor
Message-ID: <20201215164245.yrorpipw2476w35e@liuwe-devbox-debian-v2>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <227127cf-bfea-4a06-fcbc-f6c46102e9e6@metux.net>
 <20201202232234.5buzu5wysiaro3hc@liuwe-devbox-debian-v2>
 <87d94c39-e801-fbc6-8f7f-1f1b00fa719d@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d94c39-e801-fbc6-8f7f-1f1b00fa719d@metux.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 15, 2020 at 04:25:03PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 03.12.20 00:22, Wei Liu wrote:
> 
> Hi,
> 
> > I don't follow. Do you mean reusing /dev/kvm but with a different set of
> > APIs underneath? I don't think that will work.
> 
> My idea was using the same uapi for both hypervisors, so that we can use
> the same userlands for both.
> 
> Are the semantis so different that we can't provide the same API ?

We can provide some similar APIs for ease of porting, but can't provide
1:1 mappings. By definition KVM and MSHV are two different things. There
is no goal to make one ABI / API compatible with the other.

> 
> > In any case, the first version of /dev/mshv was posted a few days ago
> > [0].  While we've chosen to follow closely KVM's model, Microsoft
> > Hypervisor has its own APIs.
> 
> I have to admit, I don't know much about hyperv - what are the main
> differences (from userland perspective) between hyperv and kvm ?
> 

They have different architecture and hence different ways to deal with
things. The difference will inevitably make its way to userland.

Without going into all the details, you can have a look how Xen and KVM
differ architecturally. That will give you a pretty good idea on the
differences.

Wei.

> 
> --mtx
> 
> -- 
> ---
> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schlüssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
