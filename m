Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3200572B7FA
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jun 2023 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFLGN4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jun 2023 02:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFLGNz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jun 2023 02:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3DE93;
        Sun, 11 Jun 2023 23:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB5161F6E;
        Mon, 12 Jun 2023 06:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B004C433EF;
        Mon, 12 Jun 2023 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686550433;
        bh=58MbQy7xKDiKseM5d6mW8cUc/YGdsopViJxC6mgqasw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqqmYapoPKherGGRx8hLARAa//bmyZ+dt/X+ZAPtzPZglpSDqTneR/j3kA3uqyNUi
         9PTz0iOSueDU66hcvVYaVsovvg7hBKcYz4wHjVQw+C34oETuB3MyDnyNVbhsoVUQ51
         nRGHLnKEaYDYZDPgb677soAW9dsp7xNFYtlY+oeJyqFzaEocHS8X/TfFyJzZw0Vg+Y
         zKY6Yo9Gip0xKZjM0ygd4u+SAR1dmN0+J/udwPAWKQnMKpYF6+gPKIYB7mrhKFgmOh
         pHXUqYpqTPo2GKG6orVc5WuOEpIZeHZTB8htyUGMq+lxozNIXAfMvO1+973Vbu5fEP
         JW2UJO/qG7JDA==
Date:   Mon, 12 Jun 2023 09:13:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <20230612061349.GM12152@unreal>
References: <20230606151747.1649305-1-weh@microsoft.com>
 <20230607213903.470f71ae@kernel.org>
 <SI2P153MB0441DAC4E756A1991A03520FBB54A@SI2P153MB0441.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2P153MB0441DAC4E756A1991A03520FBB54A@SI2P153MB0441.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 12, 2023 at 04:44:44AM +0000, Wei Hu wrote:
> Hi Jakub,
> 
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Thursday, June 8, 2023 12:39 PM
> > To: Wei Hu <weh@microsoft.com>
> > Cc: netdev@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> > rdma@vger.kernel.org; Long Li <longli@microsoft.com>; Ajay Sharma
> > <sharmaajay@microsoft.com>; jgg@ziepe.ca; leon@kernel.org; KY
> > Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> > wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> > davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> > vkuznets@redhat.com; ssengar@linux.microsoft.com;
> > shradhagupta@linux.microsoft.com
> > Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: Add EQ interrupt support to
> > mana ib driver.
> > 
> > On Tue,  6 Jun 2023 15:17:47 +0000 Wei Hu wrote:
> > >  drivers/infiniband/hw/mana/cq.c               |  32 ++++-
> > >  drivers/infiniband/hw/mana/main.c             |  87 ++++++++++++
> > >  drivers/infiniband/hw/mana/mana_ib.h          |   4 +
> > >  drivers/infiniband/hw/mana/qp.c               |  90 +++++++++++-
> > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 131 ++++++++++--------
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
> > >  include/net/mana/gdma.h                       |   9 +-
> > 
> > IB and netdev are different subsystem, can you put it on a branch and send a
> > PR as the cover letter so that both subsystems can pull?
> > 
> > Examples:
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fall%2F20230607210410.88209-1-
> > saeed%40kernel.org%2F&data=05%7C01%7Cweh%40microsoft.com%7Cb672
> > 4a9f672f47d433ef08db67da4ada%7C72f988bf86f141af91ab2d7cd011db47%7C
> > 1%7C0%7C638217959538674174%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> > C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> > %7C%7C%7C&sdata=amO0W8QsR2I5INNNzCNOKEjrsYbzuZ92KXhNdfwSCHA
> > %3D&reserved=0
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fall%2F20230602171302.745492-1-
> > anthony.l.nguyen%40intel.com%2F&data=05%7C01%7Cweh%40microsoft.co
> > m%7Cb6724a9f672f47d433ef08db67da4ada%7C72f988bf86f141af91ab2d7cd0
> > 11db47%7C1%7C0%7C638217959538674174%7CUnknown%7CTWFpbGZsb3d8
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7C3000%7C%7C%7C&sdata=A%2BjjtSx%2FvY2T%2BNIEPGuftk%2BCr%2Fv
> > Yt2Xc1q8B6h2tb6g%3D&reserved=0
> 
> Thanks for you comment. I am  new to the process. I have a few questions regarding to this and hope you can help. First of all, the patch is mostly for IB. Is it possible for the patch to just go through the RDMA branch, since most of the changes are in RDMA? 

Yes, it can, we (RDMA) will handle it.

Thanks
