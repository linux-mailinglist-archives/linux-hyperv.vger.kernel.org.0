Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7AD7321
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfJOKZg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 06:25:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46869 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfJOKZg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so23104170wrv.13;
        Tue, 15 Oct 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hs18HuLQlgBABYesmo7IPm5KuxOAJYfK6ga//A893aY=;
        b=OkgWOtemW9nA/ZipwE4kOKLVI4eGEGdocKmL4HLlgOULjPLJIUK5OJfZyJWNEl5c8v
         qmSd+yrQm2a9vQNujY32vp3w4ZCWdXdGBHJpI+o0IXJjJS8bVtIrM9ehDwfB6ZD6lbTX
         sHKgiMQfS+Q6yB5VOvrGmtc54YveKPHy6qee3HB43Mu3Tsiq+Jn2dmhHDDLwbFJMojhT
         XZMgEFxG4AiJIfb0VwJ5+z9fuf0NbjAea2piH63VJm38SZpSZrYiBVHrmEkv54PV2pen
         yrB+OLcLMIE8UiVPoubhjXW0vSSRogWRjPLsyi8GYWHDXHZMazQAoUv5h8tyE5VFjv+i
         +rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hs18HuLQlgBABYesmo7IPm5KuxOAJYfK6ga//A893aY=;
        b=MDrs9uEPp0kiXydnIjACKitKGUEp7RRcIAaY2lv5+77HBg/mjjWIp0vKxGZGm9r9nd
         W7UC/6h6NRW+D+sI1l7gtSaCkvIlnrHjy3cXVOQIhL1YC+9THWj9ZaCHYpuRJWCxCIfG
         lVyPzKCkzjsgv7BCUN1kXksfrgKTYL/+X3LWsxPScJgipT2BC4Nmhlz4sPGdp6gMQqdl
         f6hhXtCx5Y5ST3txoa+6FZS9a0tr8vpPZuyMsGg7BAcBJGUigWfcIK/kBYW82v3uVE5x
         irKD1efc2IBEOQ52aSM37MkUQuo6qvo8Tq7TCCKggPRq2yBnQJ8gXL+C7029CLqs0oHr
         Q1mg==
X-Gm-Message-State: APjAAAWlLpvpFMmALEMaJ7UGdgjh0jZ4puYQtunv2Ti1sDljM0vgPyQr
        XATFaSj2MzLF/zZ6h3brOnE=
X-Google-Smtp-Source: APXvYqxL0dyh9xwdUkfgUwlxcAfzfOeWzotdyra9eCE+RCoTeujCdgXqU2QpDj6SRa9lEBtldGJdBQ==
X-Received: by 2002:a5d:518f:: with SMTP id k15mr28782850wrv.328.1571135134302;
        Tue, 15 Oct 2019 03:25:34 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1012:8d40:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id o18sm1779059wrm.11.2019.10.15.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 03:25:33 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:25:27 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        x86@kernel.org, "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: Set pv_info.name to "Hyper-V"
Message-ID: <20191015102527.GA12412@andrea.guest.corp.microsoft.com>
References: <20191015092937.11244-1-parri.andrea@gmail.com>
 <CAHd7Wqxn3sQQWkzOBrJ1KYm8eUpwa_9dcSYRDfPGAMWm=qvbag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd7Wqxn3sQQWkzOBrJ1KYm8eUpwa_9dcSYRDfPGAMWm=qvbag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -154,6 +154,8 @@ static uint32_t  __init ms_hyperv_platform(void)
> 
> This function is for platform detection only.
> 
> >         if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> >                 return 0;
> >
> > +       pv_info.name = "Hyper-V";
> > +
> 
> At this point we're not sure if Linux is really running on Hyper-V yet.
> 
> Setting pv_info.name should be moved to the init_platform hook, i.e.
> ms_hyperv_init_platform.

Thank you for the review, Wei.  I'll move this to the init_platform hook
and re-submit shortly.

Thanks,
  Andrea
