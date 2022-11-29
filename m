Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04563C6E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Nov 2022 18:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiK2R5P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Nov 2022 12:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiK2R5N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Nov 2022 12:57:13 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1945EDA
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Nov 2022 09:57:12 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 83-20020a1c0256000000b003d0683389e1so1513351wmc.4
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Nov 2022 09:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bJ5FKB9ItsrBNl53cQqwvM2p3FO/A+2KW/Bk5cYg5c=;
        b=dXlskLyZsZtsQbrALvrrkwr5ruuUugvJcKO6cfhPuPwK+WvQf/NlzNccQtdqq3aYEX
         uVGFwNKL/TjuDeJcN+fefwC/ptEbZKqvvsJtCu0reBckmj4eQwPcUnQt/n+8lswEVwLt
         ll403SIBFKCHk/ExGx+bCrTlbZrUOYBQGPV6E1JqyrMgjPQR15mWK+5azvYNxYMwwakX
         62G15ZlSqp+NAnXYAP09THd8CPxN6iw6qK827Ogeg04oXbVCLxt+MaHAQTTr736xfsVn
         wAKPfUJnyd1LBGNhZFDnGdyWGXg2esNavejVqaOFe4195chKdmpmNOO/5jvQTipH/APW
         F77Q==
X-Gm-Message-State: ANoB5pnwo8VeXKADUMDgDGaG1LzSC7vPIeM7Fp6H7fVYyiwYi3RViypt
        L5MaEQnEaVxx6rT1lgwNznaQQumsB28=
X-Google-Smtp-Source: AA0mqf6SBjtF+Um8yg4W4PggsCCtnpEozpc3xBoRZxYg3QNdrOngOxYTmBwbGnXmakvksGsdLonVHA==
X-Received: by 2002:a05:600c:21cd:b0:3d0:68eb:2230 with SMTP id x13-20020a05600c21cd00b003d068eb2230mr2521224wmj.22.1669744631028;
        Tue, 29 Nov 2022 09:57:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c301600b003b47ff307e1sm2530535wmh.31.2022.11.29.09.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:57:09 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:57:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Gaurav Kohli <gauravkohli@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v2] x86/hyperv: Remove unregister syscore call from
 Hyper-V cleanup
Message-ID: <Y4ZH9KU7CFgZduoH@liuwe-devbox-debian-v2>
References: <1669443291-2575-1-git-send-email-gauravkohli@linux.microsoft.com>
 <BYAPR21MB168846312294BFCD2437B4D6D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168846312294BFCD2437B4D6D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 28, 2022 at 07:23:32PM +0000, Michael Kelley (LINUX) wrote:
> From: Gaurav Kohli <gauravkohli@linux.microsoft.com> Sent: Friday, November 25, 2022 10:15 PM
> > 
> > Hyper-V cleanup code comes under panic path where preemption and irq
> > is already disabled. So calling of unregister_syscore_ops might schedule
> > out the thread even for the case where mutex lock is free.
> > hyperv_cleanup
> > 	unregister_syscore_ops
> > 			mutex_lock(&syscore_ops_lock)
> > 				might_sleep
> > Here might_sleep might schedule out this thread, where voluntary preemption
> > config is on and this thread will never comes back. And also this was added
> > earlier to maintain the symmetry which is not required as this can comes
> > during crash shutdown path only.
> > 
> > To prevent the same, removing unregister_syscore_ops function call.
> > 
> > Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>
> > ---
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
