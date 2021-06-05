Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71339C765
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jun 2021 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEK1l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Jun 2021 06:27:41 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43578 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEK1k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Jun 2021 06:27:40 -0400
Received: by mail-wr1-f43.google.com with SMTP id u7so6296873wrs.10;
        Sat, 05 Jun 2021 03:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m969ISjz0Qg2RicSIh/DLDKZX7B7gGF5mGcynT3qU5g=;
        b=gSTQ2+tued6UiImWuu//oBlJfjpt/gwxvwg29XwT4DnYnd8egzGn/L0o2ogOHSgA6d
         rHBeSymp/nYKxg+oWHFjfFsLqyG42L42QV44U0Fksyf4Cm2MWpuOaSKivHTKx8y4STZ3
         ofZdcOjBjR3hFFiqnQX4kZtjsmUrDCJaF8+yijmZz9b7bmuIakoHxI564DITRTS2a9Xv
         Bc7RrMofn24GuhzVvsF352dyD4JipymAreTUkotBQkS9XBCwyLIyelkc4WakHggRuwWm
         nNaabpWr4/vBxVjYaV5t8RPzXoHEDGP1JPRxXQTE2kxuzC2uSpcBcGbQMXvZN44S29d0
         luxQ==
X-Gm-Message-State: AOAM53297uQpBZUQGmdj1B+AaKbcY1FnYun40G0w8dUQjgUb8jmYInP7
        WsIc5NXOgIGAmNx5WEeQHZg=
X-Google-Smtp-Source: ABdhPJyd9jZ2BL1pEkcDkHDEA9rfDfI2xuCJiemXtQRM4Pul5Z0tJojgoUhXxbGqPt1WZB4KlOCO+Q==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr8155566wry.395.1622888735842;
        Sat, 05 Jun 2021 03:25:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p187sm8242731wmp.28.2021.06.05.03.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 03:25:35 -0700 (PDT)
Date:   Sat, 5 Jun 2021 10:25:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: Move Hyper-V extended capability check
 to arch neutral code
Message-ID: <20210605102533.uzvd4l7el2afes5i@liuwe-devbox-debian-v2>
References: <1622669804-2016-1-git-send-email-mikelley@microsoft.com>
 <MW4PR21MB20040751A1A5AFF8D6C6FCA3C03B9@MW4PR21MB2004.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB20040751A1A5AFF8D6C6FCA3C03B9@MW4PR21MB2004.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 04, 2021 at 12:14:09AM +0000, Sunil Muthuswamy wrote:
> > The extended capability query code is currently under arch/x86, but it
> > is architecture neutral, and is used by arch neutral code in the Hyper-V
> > balloon driver. Hence the balloon driver fails to build on other
> > architectures.
> > 
> > Fix by moving the ext cap code out from arch/x86.  Because it is also
> > called from built-in architecture specific code, it can't be in a module,
> > so the Makefile treats as built-in even when CONFIG_HYPERV is "m".  Also
> > drivers/Makefile is tweaked because this is the first occurrence of a
> > Hyper-V file that is built-in even when CONFIG_HYPERV is "m".
> > 
> > While here, update the hypercall status check to use the new helper
> > function instead of open coding. No functional change.
> > 
> 
> Thanks for taking care of this, Michael.
> 
> Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>

Applied to hyperv-next. Thanks.
