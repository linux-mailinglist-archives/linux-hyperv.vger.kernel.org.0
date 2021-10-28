Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13A343E01F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Oct 2021 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJ1Lkc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 07:40:32 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37497 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1Lkc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 07:40:32 -0400
Received: by mail-wr1-f52.google.com with SMTP id b12so5175389wrh.4;
        Thu, 28 Oct 2021 04:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9iGBH0bitmQ2PUPTG4ti18s03rp1E4yJA21sHWqAfs=;
        b=aXv7CWNQjqrxFcBSYXN6cd4eBtjy08b8MLqh1QwUBIeEaQytUchYRO8bu3qTVai1Z/
         Wu7V2elzLWeMSCPqNMaLm7I9xd4vKTf20emLPmRyRXcv2iQxg1a2w57qamwbOsdv51L3
         fpr59sAv2wL6MZZMQ4gx4QbCu4tC/f5fP+3SzQWdwwz6fushKWh1wbffvYyCED2be+ce
         0HN48jwehVE4XdjpcLCapmhkhKbpEnpKKCdSmhzde6Pvj1lUzwSoBo26HT2r5OmZEVyt
         HcgPBYoagSbZnPxvyN5a2RCuF9NppNuQ7p+BQhoX0UyV5v2immSo0P8K+w70XZum5/i/
         wIBg==
X-Gm-Message-State: AOAM532O/BJAo1Tp0jsUh7BbtYyLnhc6C0ejXhIiWEYqh/aVXTtmkq6S
        Iy5QC4xH+p1VQ34HWInOgKBc0Hf9eyE=
X-Google-Smtp-Source: ABdhPJzJ9y3cHuVGs0L8QADNH8gz0yPGriIbyRsqWhOOY2M/Z7K1pW7bqN+1vNL13AvsJfi1h1V56g==
X-Received: by 2002:adf:9dc1:: with SMTP id q1mr4963621wre.13.1635421084391;
        Thu, 28 Oct 2021 04:38:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j9sm6040192wms.39.2021.10.28.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:38:04 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:38:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Remove duplicate include
Message-ID: <20211028113802.kze3rbjdo6z3jlq4@liuwe-devbox-debian-v2>
References: <1635325022-99889-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635325022-99889-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 27, 2021 at 04:57:02PM +0800, Jiapeng Chong wrote:
> Clean up the following includecheck warning:
> 
> ./arch/x86/hyperv/ivm.c: linux/bitfield.h is included more than once.
> ./arch/x86/hyperv/ivm.c: linux/types.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to hyperv-next. Thanks.

> ---
>  arch/x86/hyperv/ivm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 4d012fd..69c7a57 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -6,11 +6,9 @@
>   *  Tianyu Lan <Tianyu.Lan@microsoft.com>
>   */
>  
> -#include <linux/types.h>
>  #include <linux/bitfield.h>
>  #include <linux/hyperv.h>
>  #include <linux/types.h>
> -#include <linux/bitfield.h>
>  #include <linux/slab.h>
>  #include <asm/svm.h>
>  #include <asm/sev.h>
> -- 
> 1.8.3.1
> 
