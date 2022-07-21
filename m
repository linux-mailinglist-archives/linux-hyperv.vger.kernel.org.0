Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83357D351
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Jul 2022 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiGUSc1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUSc0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 14:32:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4468C8D2
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 11:32:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c24so1958555qkm.4
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=plZzkE3sVJKPIrG+ZssvH+Pp4Zt1kfvaJE33dQ+szwk=;
        b=kelmMZW70rspOZ4ve+QL9+UhpuyK/YdrSv3cPlIuZOxR9jxM5vhORgz4O4xPUbp6bE
         kPxLkzJykdA3Uf2YNnBjgGnMvYWVXVxOdHrVdg+bli6CbYeQGRUwerzigJKzzbqXr/Kt
         Sfxy7DfhUTZo7rMVkVUQZyqF++d/QmdP5Ydupe2pptjiCmmeOP2UtJ9g6CyiWcIzlg7A
         5FEo8pauRnJhoqtiEdCdpEsRGrpdN1rGCLVvkS7jU4Yu65aDLKGiMXVjt6A2Mbvb8OVD
         x5o1Cb+v+Zn1Q4D6ygzzCrIaM4oalDcJXqu2V1Az1f/robb6Flr1boURvNHtiXzjlbgp
         YrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=plZzkE3sVJKPIrG+ZssvH+Pp4Zt1kfvaJE33dQ+szwk=;
        b=VSEiYmqk8qh9KIFTgoisFQVWXmoiIqx5JBhhZIZGOq6ttlHjGyvmuAGuypGICT3qgX
         ebHrGy9vo3w8XHHXoGf3EvTxoGsKSJPeI8JAMIMqkKiYXjQf8skMfcrdv6/5CE2biPea
         yL7f/XxN2lDoV219Q54WXBULwsFj2mF5pgzByXhepNErWIAiQHO9LipYNGYkZ47Bry1F
         dtHvcObHEWNpiAAW6UU3vTffeGGeTBr0w9NMbbSuFqqmyC6w1I8kRQwdgMeUPZxGXLxD
         E7qpgzl8rBB9v/CqfVZcr8ePs1l0QC2uUx56HImGuYzCT9AihTSA3ScysV6m62l7mwRM
         amBw==
X-Gm-Message-State: AJIora/CwDpu5UCFpC+8p4Qzek2Cw4CpFzTQd7zK4UkSm4oO9O7QfiYE
        w1ncHWiMOCzkBaKKiJViYnNRGw==
X-Google-Smtp-Source: AGRyM1s1wf2DBh3Ac0CPp9laGRqI69nIHRBtdNRfhtHYjDGfIYlEXSQlXkbTE8vdWpZMN7KD7Xh3KQ==
X-Received: by 2002:ae9:eb88:0:b0:6b5:cc0f:1a54 with SMTP id b130-20020ae9eb88000000b006b5cc0f1a54mr23562612qkg.330.1658428343710;
        Thu, 21 Jul 2022 11:32:23 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id l9-20020a37f909000000b006b59eacba61sm1853932qkj.75.2022.07.21.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:32:21 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEayB-0001np-Q0; Thu, 21 Jul 2022 15:32:19 -0300
Date:   Thu, 21 Jul 2022 15:32:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Patch v4 03/12] net: mana: Handle vport sharing between devices
Message-ID: <20220721183219.GA6833@ziepe.ca>
References: <1655345240-26411-1-git-send-email-longli@linuxonhyperv.com>
 <1655345240-26411-4-git-send-email-longli@linuxonhyperv.com>
 <SN6PR2101MB13272044B91D6E37F7F5124FBF879@SN6PR2101MB1327.namprd21.prod.outlook.com>
 <PH7PR21MB3263F08C111C5D06C99CC32ACE869@PH7PR21MB3263.namprd21.prod.outlook.com>
 <20220720234209.GP5049@ziepe.ca>
 <PH7PR21MB3263F5FD2FA4BA6669C21509CE919@PH7PR21MB3263.namprd21.prod.outlook.com>
 <20220721143858.GV5049@ziepe.ca>
 <PH7PR21MB326339501D9CA5ABE69F8AE9CE919@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB326339501D9CA5ABE69F8AE9CE919@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 21, 2022 at 05:58:39PM +0000, Long Li wrote:
> > > "vport" is a hardware resource that can either be used by an Ethernet
> > > device, or an RDMA device. But it can't be used by both at the same
> > > time. The "vport" is associated with a protection domain and doorbell,
> > > it's programmed in the hardware. Outgoing traffic is enforced on this
> > > vport based on how it is programmed.
> > 
> > Sure, but how is the users problem to "get this configured right" and what
> > exactly is the user supposed to do?
> > 
> > I would expect the allocation of HW resources to be completely transparent
> > to the user. Why is it not?
> > 
> 
> In the hardware, RDMA RAW_QP shares the same hardware resource (in
> this case, the vPort in hardware table) with the ethernet NIC. When
> an RDMA user creates a RAW_QP, we can't just shut down the
> ethernet. The user is required to make sure the ethernet is not in
> used when he creates this QP type.

You haven't answered my question - how is the user supposed to achieve
this?

And now I also want to know why the ethernet device and rdma device
can even be loaded together if they cannot share the physical port?
Exclusivity is not a sharing model that any driver today implements.

Jason
