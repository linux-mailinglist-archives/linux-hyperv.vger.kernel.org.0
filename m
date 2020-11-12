Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904E02B0426
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgKLLoU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:44:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38540 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgKLLm5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:42:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id h62so5216582wme.3;
        Thu, 12 Nov 2020 03:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UTykdoKscM0sS9MBqMZhmWdVnfXzwZ/4BylVoY+13s=;
        b=feOIwIcQAHbsbEwIgZav7DPYtOzJ0b73CLPW5D17MdSYye7c9c5IEDl7H5Tkg3axAw
         bUdzUdcnSONqJet6LexksdD2DPQKmh2qdRPGP6gujlOnqZY8dgbc+moa/dsJaEuQH9bM
         pUAc0zZWxXBChGMb25ugUjc75WO+js3WjqvKw+T94l6lBpvMv1QXyXir3gqlOYqT7HSR
         i4AzHXWTUjM9grUkgbE3LdHswLWJxRlGpNvT6t5HiXEpwz+vfLw3JUom6Dml9O7Y+4MR
         g9Iv+EG2gffRXvFG86z/rXjFZk87CLRkqsPGjJaPf8YebREuVy//SEBBPCplu0vimDvM
         Qz1A==
X-Gm-Message-State: AOAM532wN5N+DXZWisATqmRvyq7jt4UtZRL7qAq+gcNKzTkLtRD2PWRM
        IjUHeFztgUodV9OaIF/7sRZQkh2EVHg=
X-Google-Smtp-Source: ABdhPJwnINoYhgOIO3/w1vhg7hRKMG+scXHr6/ROX3sPszoncfIUMEEj9dtuYc1uifHmfx4D8NgCqQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr9572071wmh.165.1605181375124;
        Thu, 12 Nov 2020 03:42:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p4sm6560988wrm.51.2020.11.12.03.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:42:54 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:42:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
Message-ID: <20201112114253.hoaeijs55lrueoey@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
 <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
 <20201112112437.lt3g5bhpjym3evu5@liuwe-devbox-debian-v2>
 <2c5101fb-f3de-7b0c-ee76-e5a0e6b32098@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5101fb-f3de-7b0c-ee76-e5a0e6b32098@linaro.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 12:40:53PM +0100, Daniel Lezcano wrote:
> On 12/11/2020 12:24, Wei Liu wrote:
> > On Thu, Nov 12, 2020 at 10:56:17AM +0100, Daniel Lezcano wrote:
> >> On 05/11/2020 17:58, Wei Liu wrote:
> >>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel.

Wei.
