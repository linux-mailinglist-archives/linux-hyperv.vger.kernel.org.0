Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40E44898A6
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jan 2022 13:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245528AbiAJMcn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jan 2022 07:32:43 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:46812 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245522AbiAJMck (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jan 2022 07:32:40 -0500
Received: by mail-wm1-f47.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso6502363wmd.5;
        Mon, 10 Jan 2022 04:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3LQhWJAJKsb68e/0rFUgtYKcFHxmU2zF5dMcfIjv78=;
        b=UmmM1+eLwWqjmo+5+Ho3+2pw/RUbUbf1P+BF7/yVzZlH2uUEVptpwvjZCFth1brN7H
         LROz/9AZxpkNAbTDQPXdhsEE5cGyFiwR6JXU105LDDDbVopxP3TG3UT9o51hjz6DpN8u
         MklFp1LRUYHXqi6oelj4lVAf2M2eI9AGrjZc/P5jMDShEGuu03uIneEP+yYVJnvfVfAp
         gzmULmb5XguiEQ45Sb4pPRyJcPjtwqfX1Fa7JQ13r9h90SU2uT4hgqCLz/bMhV7UpSCi
         LgtzDvAyyG212K5Zn/SSyRGEhAou/8ya3b/syjCqScDrgm0rhaj8TH/n6C1gYWDgqcYP
         rI+g==
X-Gm-Message-State: AOAM530seAGSYWte7FOA3zrJSRpFaqf2oNqLXTznBOGyxAS8v8Kh3jY2
        Sne+UHukPhJMgnvwqkKrcfE=
X-Google-Smtp-Source: ABdhPJyqu61Adly8ssPLGPb66LI05B4lJ1Un8xtFd/gv0BCZRYog8byk1oHZtN/QHtaT4O8onvAWrg==
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr21950758wmq.175.1641817959405;
        Mon, 10 Jan 2022 04:32:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g12sm3024240wrm.109.2022.01.10.04.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:32:39 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:32:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Juan Vazquez <juvazq@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Fix storvsc_queuecommand() memory leak
Message-ID: <20220110123237.ujsfx7anhk3eqhcf@liuwe-devbox-debian-v2>
References: <20220109001758.6401-1-juvazq@linux.microsoft.com>
 <7354695e-a8dd-8c6c-ee7e-764280184863@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7354695e-a8dd-8c6c-ee7e-764280184863@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 10, 2022 at 08:13:33PM +0800, Tianyu Lan wrote:
> On 1/9/2022 8:17 AM, Juan Vazquez wrote:
> > Fix possible memory leak in error path of storvsc_queuecommand() when
> > DMA mapping fails.
> > 
> > Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
> > Signed-off-by: Juan Vazquez <juvazq@linux.microsoft.com>
> 
> Looks good. Thanks for the fix patch.
> 
> Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Applied. Thanks.
