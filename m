Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9315526796
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 May 2022 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382692AbiEMQvm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 May 2022 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382724AbiEMQvJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 May 2022 12:51:09 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDB546A3;
        Fri, 13 May 2022 09:51:08 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id k2so12204666wrd.5;
        Fri, 13 May 2022 09:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVAC2kQTqq+vwTg/1G3n9h7KQw0WRs3azTYSfPc+fTA=;
        b=APAQGSJmIxc+OctT1qKuX7YSdhDhMxb1fbjgbej+mP6jxioTfF+ny+275ZFGj3Rt6Z
         kXrVP/nkijR6wBxwnYBFus3sS6xi56d4F5nzyYRWPwOkv+KZW/fWzJelVgun16aC8eyv
         vA5SKYHblhMkoNnxGYi8ue3rVmrhSc+ASKmtbvaLCbsgmkIORVKDW78Z2jpZCMtHkdfA
         QHXL+maimg652lNdlyMdyRZRS1WpGn/Wgph3CBMNLkJosp6XWSbzvcsWxEQVXzjfzpcw
         oFrwbAcvu8sa/lL9fY9SX176COc5nZsTFIo7j9IkJeoZDEzhuYYzHYd5uATA3dGeEf7B
         ZJiA==
X-Gm-Message-State: AOAM533Jh4gQPAQa/98LxWcLvWPACm7M+4+mPYBudidW3O/k5CwESIDs
        UBl6KRY5Dv2FtYp+E4H6QFs=
X-Google-Smtp-Source: ABdhPJxxgsTP/GIl6zlNKcGBIqlY0EGUPW3EubrPZUpD3F8LCyVHM5lUQupPCxgpK4MtAjk/8R3JMw==
X-Received: by 2002:adf:d1cd:0:b0:20c:51c6:5d9f with SMTP id b13-20020adfd1cd000000b0020c51c65d9fmr4897430wrd.244.1652460666567;
        Fri, 13 May 2022 09:51:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d16-20020adf9c90000000b0020c5253d8fasm2599882wre.70.2022.05.13.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:51:05 -0700 (PDT)
Date:   Fri, 13 May 2022 16:51:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: hv: Hardening changes
Message-ID: <20220513165103.vaqklaav5yhr6jpl@liuwe-devbox-debian-v2>
References: <20220511223207.3386-1-parri.andrea@gmail.com>
 <20220513101132.GA26886@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513101132.GA26886@lpieralisi>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 13, 2022 at 11:11:32AM +0100, Lorenzo Pieralisi wrote:
> On Thu, May 12, 2022 at 12:32:05AM +0200, Andrea Parri (Microsoft) wrote:
> > Changes since v1[1]:
> >   - Add validation in q_resource_requirements()
> > 
> > Patch #2 depends on changes in hyperv-next.  (Acknowledging that hyperv
> > is entering EOM, for review.)
> 
> I suppose then it is best for me to ACK it and ask Hyper-V maintainers
> to pick it up.
> 

Yes.

> For the series:
> 
>Pending Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

Thanks!
