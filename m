Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A713CB91C
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbhGPO4B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 10:56:01 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36439 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbhGPO4A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 10:56:00 -0400
Received: by mail-wr1-f41.google.com with SMTP id v5so12447466wrt.3;
        Fri, 16 Jul 2021 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4dmYl9QWacuMWa0aGR6yEQBM9o4/Gc+nSoCDp3XJ0s=;
        b=TT8q7YrPw4EOO3cyX0LM5I4kOZBkUyCQXU3Q47kdx/3Zgj8EpqcxLzxWU/1qWDU7bL
         RAhG0W26jlYM0BhDZ52izBrCe9ksx0l5YzXD43aAM+AwDqu/XIg5U3lW2Z5N51M6aF2m
         cfjvjiHILZsAp4mzktm4Q6GYZ5b4eOTQfbpmfdLOKNPvMysF8qe6VSApmggorg6ybFCe
         Q1uB4OUJmlf79cFNiutvfBAfwIw0EdC8nAF1EBjmo0ehUvafnyglmFAhT3yNeQpNAlnE
         knVYT0lh0b+n25bggODmQuEty1sySo59fTm8MRjzNGIIGBveb3j7y2+vajO5ESOEjybZ
         9hDw==
X-Gm-Message-State: AOAM530lDrvb0vTBt28DFP6Tav+sgjR7W4noE2nlPBFTcFQ0TLJM5VHm
        aeeLwlIV/hWkpEBY/va2x1w=
X-Google-Smtp-Source: ABdhPJyw3LNbc2pOV7APqPDvCjy98KRCkDeASged/89nMMY3/b0sNFmAuTENYwNUC4pA5f4jMlENrA==
X-Received: by 2002:adf:a148:: with SMTP id r8mr12438753wrr.415.1626447183978;
        Fri, 16 Jul 2021 07:53:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p7sm5910314wmq.5.2021.07.16.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:53:03 -0700 (PDT)
Date:   Fri, 16 Jul 2021 14:53:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        mikelley@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
Message-ID: <20210716145301.xsho5zb7cqkgb3zc@liuwe-devbox-debian-v2>
References: <20210716133245.3272672-1-ani@anisinha.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716133245.3272672-1-ani@anisinha.ca>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 16, 2021 at 07:02:45PM +0530, Ani Sinha wrote:
> Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
> added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
> of this synthetic MSR will allow hyper-v guests to report invariant TSC
> CPU feature through CPUID. This comment adds this explanation to the code
> and mentions where the Intel's generic platform init code reads this
> feature bit from CPUID. The comment will help developers understand how
> the two parts of the initialization (hyperV specific and non-hyperV
> specific generic hw init) are related.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Applied to hyperv-next. Thanks.
