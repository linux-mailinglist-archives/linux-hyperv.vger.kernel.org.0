Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EC74DCFF
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jul 2023 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGJSEK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jul 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGJSEJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jul 2023 14:04:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C84195
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Jul 2023 11:04:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-766fd5f9536so336619485a.3
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Jul 2023 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689012246; x=1691604246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BT8anRcoBomkCL3eLhDuSMG7VrJUf8etAybJpx2cUmQ=;
        b=P3qkNZJyr3B9iPQ6tzo+Oph7KFNgQR48WP4GUaBG7LO2uQevnfZqahEoF65sPAugnn
         MNhWEMJae9jMmX7YMUOhnYiRDETA0ZxJsxaJ3VfekaJodPQ0XE7/CMmAauDvYrE75B7W
         e6Reiouu8KjXUJZm8YbqiHVuOqgKFmIz9g/N3BOq4+MfXFB+VobVN9UMSj1yq/bM+FvH
         2vmlEzf/kW7afVr8b6ghNyN0dOyVHo4CIbT0AOP08KVkn04tBq6MnrtyGey8uRxlttek
         mfECNBxhrEl971vEGY6ftU/fY4U3a2UcgpcCRczCcddHUAy7XCE4ihu65DPMtVkNd2IB
         CQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012246; x=1691604246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT8anRcoBomkCL3eLhDuSMG7VrJUf8etAybJpx2cUmQ=;
        b=MATkB8omBcXfGgoClqceTYy9Z9ZVAUtvk/QX2x48N6wsk2PXbnXTXEs7slfyHvKpef
         2Rv+/qRAozQlVi0cY/WfWEQACHZ6U1VfftUzyCNyhgOOUFzHtxo95dZ68V+cf8X2SgGy
         ugOBtmi4pgrWjyfK8KKGvZvRjTzZqXo50EROeB7AyvYENhn+2gP9r63XDF5Z7BUMcRG+
         zyF8cDc5LyF4gdXeFVkJbEKYIlp/BjUOk0BmflPx0f446qzFiVntc5jX3S0raczdpwPw
         coFvkL+LobrecvSa4/PUvtny7srBPrH8tKlV2Q8G087SAwhE5mKp1QwLHZaSiA7p4JTG
         a5gw==
X-Gm-Message-State: ABy/qLZkiDIBs5WsQI9fRdYD6P9WJRvPlb24zBDFXXzjcyHX9dB5h2ca
        KdRW8IOrsa0rIi2QO3deZHXISA==
X-Google-Smtp-Source: APBJJlEkdizBr7UJSHKmwk1Pw53s9bGXZHen90PgCZoTRA4bGUaUV/2iylwD9yRi/UQu94OEzqbZDw==
X-Received: by 2002:a0c:e108:0:b0:628:6879:ee48 with SMTP id w8-20020a0ce108000000b006286879ee48mr11363899qvk.50.1689012246035;
        Mon, 10 Jul 2023 11:04:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id r17-20020a0c8b91000000b006360931c12fsm65717qva.96.2023.07.10.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:04:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIvEy-0004U3-Vv;
        Mon, 10 Jul 2023 15:04:04 -0300
Date:   Mon, 10 Jul 2023 15:04:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Message-ID: <ZKxIFK2nQqV9AvIA@ziepe.ca>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
 <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <c7e4a416-9da4-7ff2-2223-589fd66f557d@intel.com>
 <PUZP153MB0788C7D2376F3271D77CE826CC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <cd36e39a-ebb9-706a-87c3-2f76de82f7ca@intel.com>
 <PH7PR21MB311670231963DE8661C2F178CA2CA@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB311670231963DE8661C2F178CA2CA@PH7PR21MB3116.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 06, 2023 at 01:54:35PM +0000, Haiyang Zhang wrote:

> > This waiting loop is needed to let the pending Tx packets be sent. If
> > they weren't sent in 1 second, it most likely makes no sense already
> > whether they will be sent at all or not -- the destination host won't
> > wait for them for so long.
> > You say that it may happen only in case of HW issue. If so, I assume you
> > need to fix it some way, e.g. do a HW reset or so? If so, why bother
> > waiting for Tx completions if Tx is hung? You free all skbs later either
> > way, so there are no leaks.
> 
> At that point, we don't actually care if the pending packets are sent or not. 
> But if we free the queues too soon, and the HW is slow for unexpected 
> reasons, a delayed completion notice will DMA into the freed memory and 
> cause corruption. That's why we have a longer waiting time.

Aieiiie that is a horrible HW design to not have a strong fence of DMA.

"just wait and hope the HW doesn't UAF the kernel with DMA" is really
awful.

Jason
