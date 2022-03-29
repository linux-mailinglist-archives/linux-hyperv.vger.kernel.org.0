Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29254EACCF
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Mar 2022 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiC2MEO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Mar 2022 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiC2MEN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 08:04:13 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0108B6302;
        Tue, 29 Mar 2022 05:02:29 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id q20so10152485wmq.1;
        Tue, 29 Mar 2022 05:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=meM4Sz+j94jn44eNRkkMHVcnjIIc4XP3Is91W3/UqCY=;
        b=H1z56RXqNUdTzA/kdQW75TbfP66qiF0Fy6EWyYE6d+niColNB8EMC4vFpUUBF5Nsyp
         1RndmRZNBbe+O0seypjDadIdRj/lPtdvFIGVfD6/7ruhrOBeKICxqZ1RUKE0RWuyIsLV
         orhgUihkzsyuURAbRBjgwcVCMWfPor+I8O0MqTV/8X8ryhlQAdq4lLyFiJoREIvCGvLO
         IaXQYEKF933y+27EhLNSzkhpATH/TC7KRgLSmuxXec11SMfGaWJqjXVwj58HE8VqY9Xk
         Fp+uGnTFd9Ab25W1F3lY9lq/lE56Ip9MVp+nZzMgzCSddk2ySe61aP1twowMUCh1KyJd
         Gfjw==
X-Gm-Message-State: AOAM532Li7TiA6HySr1WdwfUOeWxKt67xDpevWqNkh/I7Vrka6BEPSJd
        lw715n8I0a6D2ui4oYs1MoA=
X-Google-Smtp-Source: ABdhPJxAtav4m2jx06zMSUjFBzexXcpuWcn/Yf5t2l5AWfAXEGoejtNP+y8CyPZdxo9qBKVUI9ZlRw==
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id q10-20020a1ce90a000000b00381504eb57dmr6454196wmc.177.1648555348478;
        Tue, 29 Mar 2022 05:02:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i31-20020adf90a2000000b00205ad559c87sm9720622wri.21.2022.03.29.05.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:02:27 -0700 (PDT)
Date:   Tue, 29 Mar 2022 12:02:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg
 by default in isolated guests
Message-ID: <20220329120225.nmk2repiwmxumtmq@liuwe-devbox-debian-v2>
References: <20220301141135.2232-1-parri.andrea@gmail.com>
 <BYAPR21MB1270C0B7E709B218E67B0D32BF029@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1270C0B7E709B218E67B0D32BF029@BYAPR21MB1270.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 08:29:43PM +0000, Dexuan Cui wrote:
> > From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > Sent: Tuesday, March 1, 2022 6:12 AM
> > ...
> > hv_panic_page might contain guest-sensitive information, do not dump it
> > over to Hyper-V by default in isolated guests.
> > 
> > While at it, update some comments in hyperv_{panic,die}_event().
> > 
> > Reported-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-fixes. Thanks.
