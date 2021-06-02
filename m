Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA45398E28
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFBPSM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 11:18:12 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40517 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhFBPSL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 11:18:11 -0400
Received: by mail-wr1-f45.google.com with SMTP id z17so2683030wrq.7;
        Wed, 02 Jun 2021 08:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nG2h+dsXOe28vkZpaDbeym2PJCsPOYRsxGnjFtvlKgQ=;
        b=DlpmpZi94ktt+VaFNUSDRWJ574JoV+bqABDFDvzY7JgJ3tJNCpHak1peEFF1sD50xh
         Lr+z4zJs/SdWJDQ826vk9QR/M3U6LJKor3NcxhQsykl07KwRlNEXH3G4Fjo0CyxVkxqZ
         gfL65GC34BV+EmwN53B7f4fEb879EVgxK0AxSBdPeWU3kEhKN9RjiqJ0mb9CUh0vseBb
         jYEzO7Ep3JvlBU35MISPd9dh7CxlWjJqw3DMUpQVQm/10Ejo1AnCYWSEiL+n0dkACLHx
         bwyx+LXn8EOkhyjRDTB8myYl5frIGHz6QRUizOc3qioZ6Vk9b9RjZBsQFG3EnRJ7xmgb
         2zRw==
X-Gm-Message-State: AOAM530iqVX4aGAoJTbiwML4zpEa8h9IT49IzqRTeADZTXzxv3iLaxsR
        91PUJw9eBDYKIoV8wZTReWs=
X-Google-Smtp-Source: ABdhPJxu4W9eU4IekY+OKY0b69pZvGTHUneXL0vHN1e92pb37CF2UI6bcWeZCMnMFY4reeYNjr45YA==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr33389490wrz.256.1622646974413;
        Wed, 02 Jun 2021 08:16:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y2sm3563646wmq.45.2021.06.02.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:16:14 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:16:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, nunodasneves@linux.microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: LP creation with lp_index on same CPU-id
Message-ID: <20210602151612.7wz2ni4iyw7uzufm@liuwe-devbox-debian-v2>
References: <20210531074046.113452-1-kumarpraveen@linux.microsoft.com>
 <20210531105732.muzbpk4yksttsfwz@liuwe-devbox-debian-v2>
 <572da60e-714f-b207-a89e-6dc40209e2da@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572da60e-714f-b207-a89e-6dc40209e2da@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 31, 2021 at 04:31:04PM +0530, Praveen Kumar wrote:
> 
> 
> On 5/31/2021 4:27 PM, Wei Liu wrote:
> > On Mon, May 31, 2021 at 01:10:46PM +0530, Praveen Kumar wrote:
> >> The hypervisor expects the lp_index to be same as cpu-id during LP creation
> >> This fix correct the same, as cpu_physical_id can give different cpu-id.
> > 
> > Code looks fine to me, but the commit message can be made clearer.
> > 
> > """
> > The hypervisor expects the logical processor index to be the same as
> > CPU's id during logical processor creation. Using cpu_physical_id
> > confuses Microsoft Hypervisor's scheduler. That causes the root
> > partition not boot when core scheduler is used.
> > 
> > This patch removes the call to cpu_physical_id and uses the CPU index
> > directly for bringing up logical processor. This scheme works for both
> > classic scheduler and core scheduler.
> > 
> > Fixes: 333abaf5abb3 (x86/hyperv: implement and use hv_smp_prepare_cpus)
> > """
> > 
> > No action is required from you. If you are fine with this commit message
> > I can incorporate it and update the subject line when committing this
> > patch.
> > 
> 
> Thanks Wei for your comments. I'm fine with your inputs. Please go ahead. Thanks.

Pushed to hyperv-next. Thanks.
