Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F04EF84A
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Apr 2022 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348714AbiDAQq5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Apr 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349519AbiDAQqu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Apr 2022 12:46:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC87170084;
        Fri,  1 Apr 2022 09:30:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bh17so6945606ejb.8;
        Fri, 01 Apr 2022 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4pIkLo492sJgn0Tf5PhOvHnbsFGJpe4T4zxP4i8IhZ8=;
        b=eJ7zC+euchPUgDMoXaWTQCW7vfXQStXEn1D8Dq4IVZcxPuYjYzt0EBr649lpuwLDhw
         i176K1V1oqZfdTdS2tNQm4ICUc+vrLusSPSI4b2/mwtv6AIsB/Damt8/C/nZdWmbEAbh
         R6aQj1xI8iejSzxLOeRPxrGMGOQPb8IRrD+3ASkMuDGqGro9g972js4U8jq5KGpoMHNk
         ENikHv3l5mskWlqd3E4c7cuQ0t2GB+VhGQgeC0cqv19Yo66ZQeaf246o5AwDiem9Y+mc
         D1v1/H7CgrQqx3Be7xJMLCeTLpCfaAJOfmbHheaXXhTVCwEsCGI7kSferCQqoT8zLi34
         lGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pIkLo492sJgn0Tf5PhOvHnbsFGJpe4T4zxP4i8IhZ8=;
        b=ZdZqoLV0AwqdxAqjmXqfzq3m85d9+76TAAazUKopwN19yjFTiX9gADlR1aisSxiL/n
         AdKUP040R3HI3xlyG8cpMlnAsZsdoE/IyAuizR01uy7TsiNFz668jYgFMWltoHwoxl6Y
         N441R443Jdz1vQMlglsO3Hu+FnguzNkI2xJwuY6y8ezhJhvMam6S3mF5Bt8CafBgk5ty
         cqA5pAnZFNr+3IcOS5Yjw8z2ssJl7b1P9iq0foWFXw9SL2i9eBRE7mQEIsMnyJITKKIq
         LAfKbtJg+DaNh0L4oPuX+kzD3ypKAXKl6N9C89uyu+Bwcr30nPo3P7LFC87TY7SUDcc+
         DGag==
X-Gm-Message-State: AOAM5337RGEdy6YAvim8wRj8zmjhXwwczc2dwrWCOKpD3Ivxc/yAha4F
        JhO1quxdDU0r/4PhrL647/Y=
X-Google-Smtp-Source: ABdhPJwwKTx/Rq9p1R4bFoYOHcHDYCrElfThpYQj1HJFm/AhAXq1BAVKn9QLCAV+OsKEVUWIbbJJTw==
X-Received: by 2002:a17:907:97cc:b0:6df:83bc:314c with SMTP id js12-20020a17090797cc00b006df83bc314cmr515522ejc.587.1648830618325;
        Fri, 01 Apr 2022 09:30:18 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090611c800b006e4de0c89bbsm607804eja.198.2022.04.01.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:30:17 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:30:15 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] PCI: hv: Fix synchronization between channel
 callback and hv_compose_msi_msg()
Message-ID: <20220401163015.GC437893@anparri>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-5-parri.andrea@gmail.com>
 <PH0PR21MB302522DE89BB5A0F59B1C29AD7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302522DE89BB5A0F59B1C29AD7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -1662,6 +1662,55 @@ static u32 hv_compose_msi_req_v3(
> >  	return sizeof(*int_pkt);
> >  }
> > 
> > +/* As in vmbus_request_addr() but without the requestor lock */
> > +static u64 __hv_pci_request_addr(struct vmbus_channel *channel, u64 trans_id)
> > +{
> > +	struct vmbus_requestor *rqstor = &channel->requestor;
> > +	u64 req_addr;
> > +
> > +	if (trans_id >= rqstor->size ||
> > +	    !test_bit(trans_id, rqstor->req_bitmap))
> > +		return VMBUS_RQST_ERROR;
> > +
> > +	req_addr = rqstor->req_arr[trans_id];
> > +	rqstor->req_arr[trans_id] = rqstor->next_request_id;
> > +	rqstor->next_request_id = trans_id;
> > +
> > +	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> > +
> > +	return req_addr;
> > +}
> > +
> > +/*
> > + * Clear/remove @trans_id from @channel's requestor, provided the memory
> > + * address stored at @trans_id equals @rqst_addr.
> > + */
> > +static void hv_pci_request_addr_match(struct vmbus_channel *channel,
> > +				      u64 trans_id, u64 rqst_addr)
> > +{
> > +	struct vmbus_requestor *rqstor = &channel->requestor;
> > +	unsigned long flags;
> > +	u64 req_addr;
> > +
> > +	spin_lock_irqsave(&rqstor->req_lock, flags);
> > +
> > +	if (trans_id >= rqstor->size ||
> > +	    !test_bit(trans_id, rqstor->req_bitmap)) {
> > +		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> > +		return;
> > +	}
> > +
> > +	req_addr = rqstor->req_arr[trans_id];
> > +	if (req_addr == rqst_addr) {
> > +		rqstor->req_arr[trans_id] = rqstor->next_request_id;
> > +		rqstor->next_request_id = trans_id;
> > +
> > +		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> > +}
> > +
> 
> Even though these two new functions are used only in the Hyper-V
> vPCI driver, it seems like they should go in drivers/hv/channel.c
> along with vmbus_next_request_id() and vmbus_request_addr().
> And maybe vmbus_request_addr(), which gets the spin lock,
> could be implemented to call the new version above that
> assumes the spin lock is already held.  Also, the new function
> that requires matching on the rqst_addr might also be folded
> into common code via an optional rqst_addr argument.

Noted.


> > @@ -2747,17 +2808,27 @@ static void hv_pci_onchannelcallback(void *context)
> >  		switch (desc->type) {
> >  		case VM_PKT_COMP:
> > 
> > -			req_addr = chan->request_addr_callback(chan, req_id);
> > +			spin_lock_irqsave(&rqstor->req_lock, flags);
> 
> Obtaining the lock (and releasing it below) might be better abstracted into
> a lock_requestor() and unlock_requestor() pair that are implemented in
> drivers/hv/channel.c along with the other related functions.

Seems like these helpers should go 'inline' in <linux/hyper.h>, let me
do it...

Thanks,
  Andrea
