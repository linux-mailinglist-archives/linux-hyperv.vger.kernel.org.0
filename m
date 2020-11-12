Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECC2B0833
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKLPO2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbgKLPO2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWIN7/Nq/yeoyKpiKidMDeDSC6wVzNUm+jANJbo9SZs=;
        b=gTt9EwWQSy+HBxxGZGYdpYohCxrfy+kqggJoBVmczwqsyLXf2WemCwAg6+gsd8OsCJAkur
        jgNbXiQxfD4e3QxKAImU5kh0GRF1vETCRJ+FsRJMgDuicqS3bLNxQLnDyDipYVX8gZmNkd
        iVhc7rgWeByvBW6j3qN2A4eL2w0AHfk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-KqFSGR6GNROsp-_Yx9x89Q-1; Thu, 12 Nov 2020 10:14:26 -0500
X-MC-Unique: KqFSGR6GNROsp-_Yx9x89Q-1
Received: by mail-wr1-f70.google.com with SMTP id h29so1961291wrb.13
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fWIN7/Nq/yeoyKpiKidMDeDSC6wVzNUm+jANJbo9SZs=;
        b=KziSodLQm+WvbQBjPTj2iqh+r1b4MnavWB/X9IY8tsUnU75pW3htmvkV3qaaEt6tKq
         cmjgeegRPocYMJOZs+TEKu1MB+UYAoiDc+3JMYl3FiY6RjgV2zJgDQnJw/V/6L4QDnJZ
         Up4e0cB4K5r8f08dNBi5cUmWp90qFJJeA6gbvuTMnlQCBSFCwGKkmpJ+Az7blS7eQqwM
         a0uGaWtEY3INdQQhlVzVtc3VP4RQ/zw0wfgKgd573Ye+1OvroOpwoaR5mG48J9A3p5Xq
         JTtuo1ONlBFpdZzCvOcKx4WLxfjGGXSXOo0iDOkvxZr1L8PHwDIZvezYjXLmvS+dyNeT
         qeQA==
X-Gm-Message-State: AOAM533dLe4nHkjHXz4XOUjUNLr7n7PeseWrhScOwFeYCfG07bPBDQUH
        jI5+dZEmpQv551BasLL6GscMX7FWoNKyTHKkPdldOfz2R96Yh4zPJctqBh/SpYdIMk5vNQsjqvK
        DKiD5TxihJDg9Br4Im6SKZdpG
X-Received: by 2002:adf:c547:: with SMTP id s7mr6950wrf.222.1605194064912;
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCi+qMEnYo3Z4at9GKUxuCuJdHsy/Kwa2RjJxcMb5RiR3KRPrzSMM5oNvlfzZNkCS6x5Cx5g==
X-Received: by 2002:adf:c547:: with SMTP id s7mr6912wrf.222.1605194064609;
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f8sm7541222wrt.88.2020.11.12.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
In-Reply-To: <20201105165814.29233-2-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-2-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:14:22 +0100
Message-ID: <87mtzmy5dd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> This makes the name match Hyper-V TLFS.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/asm-generic/hyperv-tlfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e73a11850055..e6903589a82a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -88,7 +88,7 @@
>  #define HV_CONNECT_PORT				BIT(7)
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
> -#define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_CPU_MANAGEMENT			BIT(12)
>  
>  
>  /*

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

