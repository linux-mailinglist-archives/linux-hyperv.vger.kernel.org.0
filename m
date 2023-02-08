Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2668F190
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjBHPEO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Feb 2023 10:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjBHPEN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Feb 2023 10:04:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89C3431D
        for <linux-hyperv@vger.kernel.org>; Wed,  8 Feb 2023 07:04:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso2575893pjt.4
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Feb 2023 07:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URD/oshFPOwr0qbJ4yDAwjjjTXrKyLyD0kda/kmQ/qY=;
        b=K8MgyWD3MIU6ok+xTR3BhW+QKeqoZ8MtVD3Afe65IQwKxzaYbGmA9HwSx1GPX+/WAb
         9HRtbUfGav2tnPu+YueWkutowxOvgB5W5lZvJsyX2SIcHcWRiOsjgge3zh1WGkkDr5AP
         iIeVnLH4lBUWzAKVa3H2Sw4Oo2goPu4IH95yLcL4APzYQrKmmrD/zgQgl3HZwSSvyrBR
         tXsz4AYUCSrCmT6OZY4UoTGKZmWsSNbsrlcizwdIrO+lAWVMF5CiVQnwdJlmWjNc9lcu
         cq9flmAffLtOdE2fZks9k00losBRxTXI1HvvF7IaZGBz2hsip12REeNNh3rev8AKPAxp
         RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URD/oshFPOwr0qbJ4yDAwjjjTXrKyLyD0kda/kmQ/qY=;
        b=S5ovJIpjiMTBm1W45mT4/1PS+z2mz3132N01b5/J4IIWZQT/tyDGSfPZ7rIE82v7iO
         MunXVVz7T6IU/gKGCKcMNPeRD2Lol4KpNm5RFcv/TFe3CI0k7bkPehvGSx4kJlRK1GJA
         BA7+CSMvVxX0bvWW1N8Khy31AOeZ8ldCD7b4R9SghypSnnf09O4pQFsuErb3A1IeZDmO
         deGslKiygconOjpyMC9Y+xR0fcsEu36LjBgEshChBtrBz+ILy3W+nZrYgI+0kZpEk60F
         SJA08o3JcarvDlMsHqd8rRTv51iw2tFTvC1BiyMwcxQC9ScMS/KOoSD7Q0+utWATnQqR
         8Caw==
X-Gm-Message-State: AO0yUKWs1Pet75Q71PVrCclPxYXfujj6Y0E2iSuqLZsW/ZSvlKgoQHj/
        GHoQmDeMVQutin8iWAAfwQW+wg==
X-Google-Smtp-Source: AK7set/cSc9giVDzrOn6jlQqCZW1Ic+uotyR57MWGDOOUieEi8LrPpYHOIq4+38jKE77ziWeDxqYtg==
X-Received: by 2002:a17:902:d4c9:b0:198:af50:e4ec with SMTP id o9-20020a170902d4c900b00198af50e4ecmr246944plg.18.1675868652255;
        Wed, 08 Feb 2023 07:04:12 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b00196896d6d04sm11117262pld.258.2023.02.08.07.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:04:11 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:04:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "lirongqing@baidu.com" <lirongqing@baidu.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Message-ID: <Y+O56OXIuARBhsg2@google.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <BYAPR21MB168840B3814336ED510845C0D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168840B3814336ED510845C0D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 08, 2023, Michael Kelley (LINUX) wrote:
> From: lirongqing@baidu.com <lirongqing@baidu.com> Sent: Monday, February 6, 2023 5:15 PM
> > 
> > Zeroing the counter register in pit_shutdown() isn't actually supposed to
> > stop it from counting,  will causes the PIT to start running again,
> > From the spec:
> > 
> >   The largest possible initial count is 0; this is equivalent to 216 for
> >   binary counting and 104 for BCD counting.
> > 
> >   The Counter does not stop when it reaches zero. In Modes 0, 1, 4, and 5 the
> >   Counter "wraps around" to the highest count, either FFFF hex for binary
> >   count- ing or 9999 for BCD counting, and continues counting.
> > 
> >   Mode 0 is typically used for event counting. After the Control Word is
> >   written, OUT is initially low, and will remain low until the Counter
> >   reaches zero. OUT then goes high and remains high until a new count or a
> >   new Mode 0 Control Word is written into the Counter.
> > 
> > Hyper-V and KVM follow the spec, the issue that 35b69a42 "(clockevents/drivers/
> > i8253: Add support for PIT shutdown quirk") fixed is in i8253 drivers, not Hyper-v,
> > so delete the zero timer counter register in shutdown, and delete PIT shutdown
> > quirk for Hyper-v
> 
> From the standpoint of Hyper-V, I'm good with this change.  But there's a
> risk that old hardware might not be compliant with the spec, and needs the
> zero'ing for some reason. The experts in the x86 space will be in the best
> position to assess the risk.

Yep, my feeling exactly.  My input is purely from reading those crusty old specs.
