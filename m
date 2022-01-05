Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA148525E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jan 2022 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiAEMXt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jan 2022 07:23:49 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43744 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiAEMXs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jan 2022 07:23:48 -0500
Received: by mail-wr1-f54.google.com with SMTP id o3so24436981wrh.10;
        Wed, 05 Jan 2022 04:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3vGTuWVHs0jAZJPZmVYXJHdNt84L1PDEmSZR/VjnEFM=;
        b=kLJZFrw/CkL13K1UhXaXfjPYBUz8yi5UCt9bxk5MghqFMhJci9HPWEHy8HPiual5XZ
         nPi1tAHciUAi0Z/+8q/lC14q54uTONBUSnqTPiWe8Hw7/zlCkKZRY1WVAd8BrkPcjB/w
         mpDzEtoHPjERAFcis7ndhd7lcqG366Uw7Lpj7r8YWWHzLBLgrYnZt2H1Ize3qv0UkdfK
         dSbReiGxY0sjrDYMGTVMo8s3rog8o73dST3MsrcGQFyotaS4Yv6FcD9SEJfQhyKf55z1
         lFcR8Bd5M93bztavw/SoAFyCeU/WXgIE2sGodk9rV0A3Q9d9kCP//sF26/Voj2A0DqGg
         wgIQ==
X-Gm-Message-State: AOAM530qOskZlq9P43XhqO6f9lSgoThN/fEkEh7n/iW1PTvN7I6zaApI
        2WJAGu9MDuLKmjeXczIa5tM=
X-Google-Smtp-Source: ABdhPJytrxWG4YRfNcP5E3R86MxwQk61VG41q2ECBIwykw2jHAbzUhtzIKzidXOJ6z7sJGugTa1KFw==
X-Received: by 2002:adf:fbcf:: with SMTP id d15mr34871393wrs.132.1641385427221;
        Wed, 05 Jan 2022 04:23:47 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l14sm36041756wrr.53.2022.01.05.04.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:23:46 -0800 (PST)
Date:   Wed, 5 Jan 2022 12:23:45 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com, mikelley@microsoft.com,
        Tianyu.Lan@microsoft.com, longli@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] scsi: storvsc: Fix unsigned comparison to zero
Message-ID: <20220105122345.f5qlp5ftirglk7og@liuwe-devbox-debian-v2>
References: <20211227040311.54584-1-yuehaibing@huawei.com>
 <yq135m2zqw1.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq135m2zqw1.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 05, 2022 at 12:41:31AM -0500, Martin K. Petersen wrote:
> 
> YueHaibing,
> 
> > The unsigned variable sg_count is being assigned a return value
> > from the call to scsi_dma_map() that can return -ENOMEM.
> >
> > Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for
> > storvsc driver")
> 
> This should probably go through the Hyper-V tree - I presume that's
> where the offending commit is sitting?

Hi Martin

I will pick this up.

Thanks,
Wei.

> 
> Otherwise I can take this after -rc1 is out.
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
