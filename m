Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1C534CEC
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 May 2022 12:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiEZKED (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 May 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiEZKEA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 May 2022 06:04:00 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D461FAF337;
        Thu, 26 May 2022 03:03:59 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k30so1514290wrd.5;
        Thu, 26 May 2022 03:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDRmsRg9eHIRMMIJkb1fiFBKJkrJH57+pbLbM0Gs91g=;
        b=dyRhNK6jtTWT3zxI/mL873sTVokc1tUxdZmempgaU1FgHEb20OtgFEFYO0scFX2TQm
         P72yEdsfxkey1z/YEN8PpSYgrlEk4rNUR2rwPj37tjTKs/0hZnScfXmHu8bHeMS6oP/i
         s1a6+0+hop+3HQyogY0ASd7ewUKBjNPwiLm9YjYXGC1oeSdlua9zwV0eI4odIxfybF7j
         CSXm41mRwGB388E1W+2vjbmvEDF1wWlS0yLG7CGjWBOQhOn07RTkVaE4E8A6PfwGAQR/
         X2jINUCtNqkzjFhNrEs0mh50fEZnT43uLLQJnZZbMhxpow6l9fnUyqoOazuHZHX61aea
         jNHA==
X-Gm-Message-State: AOAM532dV56i2Ie3Xl9z60/oMl61kl22zbANxB3euw8h43gPqSAPT8jY
        7RJQWho/7WlKQF+EWKD8V0s=
X-Google-Smtp-Source: ABdhPJyrqvqG/bHULPa78r/6vh6qWdO5aa9YtzHtKfOQ3Jh9att+19mGOVmh8MsXZZzJzP6O2+AiDQ==
X-Received: by 2002:a5d:6c61:0:b0:20f:ef37:a9d0 with SMTP id r1-20020a5d6c61000000b0020fef37a9d0mr10939895wrz.140.1653559438419;
        Thu, 26 May 2022 03:03:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b003942a244eebsm1276081wmi.48.2022.05.26.03.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:03:57 -0700 (PDT)
Date:   Thu, 26 May 2022 10:03:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] scsi: storvsc: Removing Pre Win8 related logic
Message-ID: <20220526100356.qwvc4qe2rkaja5wm@liuwe-devbox-debian-v2>
References: <1653478022-26621-1-git-send-email-ssengar@linux.microsoft.com>
 <PH0PR21MB302574301005664B719B5196D7D69@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302574301005664B719B5196D7D69@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 25, 2022 at 01:52:01PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, May 25, 2022 4:27 AM
> > 
> > The latest storvsc code has already removed the support for windows 7 and
> > earlier. There is still some code logic reamining which is there to support
> 
> s/reamining/remaining/
> 
> > pre Windows 8 OS. This patch removes these stale logic.
> > This patch majorly does three things :
> > 
> > 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct is
> > same for all the OS post windows 8 there is no need of delta.
> > 2. Simplify sense_buffer_size logic, as there is single buffer size for
> > all the post windows 8 OS.
> > 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
> > as there is no separate handling required for different OS.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > v4:
> > * Removed sense_buffer_size variable and used STORVSC_SENSE_BUFFER_SIZE directly
> > in all places
> > * Removed the comment along with sense_buffer_size and placed a more simpler
> > comment for STORVSC_SENSE_BUFFER_SIZE
> > * Added back WIN6 and WIN7 protocol version macros
> > 
> >  drivers/scsi/storvsc_drv.c | 155 ++++++++++---------------------------
> >  1 file changed, 39 insertions(+), 116 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Fixed the typo and applied to hyperv-next. Thanks.
