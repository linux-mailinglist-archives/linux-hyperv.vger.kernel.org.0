Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35939229F5C
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jul 2020 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgGVSko (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVSko (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 14:40:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B83C0619E0
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2020 11:40:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so1765068pgh.3
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2020 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9NmDFLAg+S5lUz7K2pvf1RhE94Cz0luh7cCv2JHKXA=;
        b=MQp8z9MQbjNzSSgYFwXVflDMZXY4DvuxHtdAXlCmLFxx0hOtegVLhCBZUQ9TLduLz5
         ahZ3TrUoGAUsC1cMno4k0/T8sWa/5T9W9ohDh5NvhVKcAtDnl1MQ/kJKKgKgorwYvdMH
         IgJukohrmjsI1i8pALKgQ2CCs+bl75yZzQseWKIAQ2u0itey7ajZ2NsPdWB528iAEyNN
         9i9gQ+MK49i5GAVGKtTrWlcFURx/zBexDaIR5Bkow+ASqjSS1QvNtQsT0PewqGa4UHoC
         KUWrDiFfrrigWke+quMV9W7DkPWApb7WxckAiF9APlR49Q9UnuT4d01yBiFAknTR8HC6
         yX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9NmDFLAg+S5lUz7K2pvf1RhE94Cz0luh7cCv2JHKXA=;
        b=R72Ba/u1qp648nmnkZiYDWR+Z5FJgF4pUwnCV+F9x5wpuWmpsUWKaPO5lmyPs4++m8
         l3Cp/bb5Kwv2BDlsBeci+8LUs0IGUcHXw5ZI07S3MmYsdrTrYmsu/kspNpoYbLpdodXk
         9MH0QiLTheF+AehBLOJgYmi9W34aMFjCghUc5NzsbakPzTVa5Oovh0LGZr+C4gA08O8J
         8wWscAKYvMaWiFTOoRZwVzl6QXVln1gLKvGoy8an29/z8UAPobKG6rdk2mUPtwXzm6iH
         +Y3gQqo7DcPDkRqvG3SN7bz0IkS8USWeIXTWLN5UeSPGhyaK8sgVLuzxMojPIUd2XWm6
         afhQ==
X-Gm-Message-State: AOAM532+E6mLEkpWlsC/XsBz8Wz5f6tl6TeUkVpkMXDoQMZtrrC5hJ6o
        1yEb1BxuTs+jUYu8UEFhc3xhuD6n1tik+g==
X-Google-Smtp-Source: ABdhPJxio2fC0vpPrfbEyyEzIA8d296ammbTqFH+Pc8D13bMlX4ePTOLEEh2mfXOOZ3yAf9ENDEjwA==
X-Received: by 2002:a63:c58:: with SMTP id 24mr963125pgm.343.1595443243660;
        Wed, 22 Jul 2020 11:40:43 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r70sm324144pfc.109.2020.07.22.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:40:43 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:40:34 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Andres Beltran" <lkmlabelt@gmail.com>
Cc:     "Andres Beltran" <t-mabelt@microsoft.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Michael Kelley" <mikelley@microsoft.com>,
        <parri.andrea@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200722114034.443f5af2@hermes.lan>
In-Reply-To: <20200722181051.2688-1-lkmlabelt@gmail.com>
References: <20200722181051.2688-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 22 Jul 2020 11:10:48 -0700
"Andres Beltran" <lkmlabelt@gmail.com> wrote:

> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
> 
> The first patch creates the definitions for the data structure, provides
> helper methods to generate new IDs and retrieve data, and
> allocates/frees the memory needed for vmbus_requestor.
> 
> The second and third patches make use of vmbus_requestor to send request
> IDs to Hyper-V in storvsc and netvsc respectively.
> 
> Thanks.
> Andres Beltran
> 
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: David S. Miller <davem@davemloft.net>
> 
> Andres Beltran (3):
>   Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
>     hardening
>   scsi: storvsc: Use vmbus_requestor to generate transaction IDs for
>     VMBus hardening
>   hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
>     hardening
> 
>  drivers/hv/channel.c              | 175 ++++++++++++++++++++++++++++++
>  drivers/net/hyperv/hyperv_net.h   |  13 +++
>  drivers/net/hyperv/netvsc.c       |  79 +++++++++++---
>  drivers/net/hyperv/rndis_filter.c |   1 +
>  drivers/scsi/storvsc_drv.c        |  85 +++++++++++++--
>  include/linux/hyperv.h            |  22 ++++
>  6 files changed, 350 insertions(+), 25 deletions(-)
> 


What is the performance impact of this?
It means keeping a global (bookkeeping) structure which should have
noticeable impact on mult-queue performance.
