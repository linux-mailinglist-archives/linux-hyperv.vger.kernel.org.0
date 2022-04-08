Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBF4F9AEE
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiDHQtc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiDHQtc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 12:49:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272353980C;
        Fri,  8 Apr 2022 09:47:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k2so10688536edj.9;
        Fri, 08 Apr 2022 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t8q1mb2r1daoD0X8Pgg7NHUJG3G6lULJ9/LW201Nhgw=;
        b=qzTYkaWxtZ8iLlLFZQffRs4Plu/wvnFGIC6icbwjeBqMmXzISyGEQvUNDhdFh5fo9W
         EO4gXSMa9hMkJi6z7TViTTIAb7TVfa59nfQEokpGHdpgKpBrxOEtPrJNG9Wys3irAzpR
         5e9Ko4ZCQcnPCVYcTRyzy2lL7xTAdeb7285R1ErXflHLlM4wgktM1GjQdX+/yGuBLsti
         KAASwX5Cwgm/eFjiLjfrcTN35iivbHmb7MSVDIwr0mRl4u/86RpzKg36ePK95Tmx1oAs
         /10QL62tTDW7WqIqkep2mEzAbp9SvhMcjg0NSBnVqsuKMHTYX9LP5byySzQhiVE/AjFD
         yXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8q1mb2r1daoD0X8Pgg7NHUJG3G6lULJ9/LW201Nhgw=;
        b=bA6dL1ed1fUACq4uaG+X1wwCnoUX7ShKrFgunbLB61PKqolGiDdOSfyO122ZT1AWYj
         aortlU4Y4kWz3R5/QnMGmcqQXOgQKu0Isr60Ggln0/3QhN8tn5yqZFNKymbvdH2c1ty9
         QODE+axDNT22YAk9FR6cVKhhDViHrlFBrGLhN8UALuqJ1nJwTUkatpTMEWES1yUwvdDT
         zyiW9h5lF0yi0rQjYPnpbJZiMtFaLRloxMIjNVrKmSkWmEW4nzCrP/VLCfw64mXh5rCN
         1nra0qUC4Pmm7ive6IZIu+T2sYrUaPCo/35pXojeGy4I5dzaCqpZLb7wuPnrKNA0+6yM
         02fQ==
X-Gm-Message-State: AOAM531LJb2chFAy9uajezbEIOPBobxFatM1/s7PC5iyuq6cTkI62PQm
        ArVgKQlQ+CffZ6FU+hfscDQ=
X-Google-Smtp-Source: ABdhPJwqV/XFUm3/Fd6r0GVLiLk58Sln38ZUP0mAuI0yZtBUDk8IgjV9d2vtqteXpGiprLvi9eBOUw==
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id z22-20020a50e696000000b00419998d5febmr20729805edm.122.1649436446492;
        Fri, 08 Apr 2022 09:47:26 -0700 (PDT)
Received: from anparri (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id c1-20020a50cf01000000b0041cb7e02a5csm8833146edk.87.2022.04.08.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:47:24 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:47:17 +0200
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
Subject: Re: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Message-ID: <20220408164717.GA206777@anparri>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-5-parri.andrea@gmail.com>
 <PH0PR21MB3025D745B0F3FA8893B32B39D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025D745B0F3FA8893B32B39D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -1300,25 +1294,60 @@ u64 vmbus_request_addr(struct vmbus_channel
> > *channel, u64 trans_id)
> >  	if (!trans_id)
> >  		return VMBUS_RQST_ERROR;
> > 
> > -	spin_lock_irqsave(&rqstor->req_lock, flags);
> > -
> >  	/* Data corresponding to trans_id is stored at trans_id - 1 */
> >  	trans_id--;
> > 
> >  	/* Invalid trans_id */
> > -	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
> > -		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> > +	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap))
> >  		return VMBUS_RQST_ERROR;
> > -	}
> > 
> >  	req_addr = rqstor->req_arr[trans_id];
> > -	rqstor->req_arr[trans_id] = rqstor->next_request_id;
> > -	rqstor->next_request_id = trans_id;
> > +	if (rqst_addr == VMBUS_RQST_ADDR_ANY || req_addr == rqst_addr) {
> > +		rqstor->req_arr[trans_id] = rqstor->next_request_id;
> > +		rqstor->next_request_id = trans_id;
> > 
> > -	/* The already held spin lock provides atomicity */
> > -	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> > +		/* The already held spin lock provides atomicity */
> > +		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> > +	}
> 
> In the case where a specific match is required, and trans_id is
> valid but the addr's do not match, it looks like this function will
> return the addr that didn't match, without removing the entry.

Yes, that is consistent with the description on vmbus_request_addr_match():

  Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR if
  @trans_id is not contained in the requestor.


> Shouldn't it return VMBUS_RQST_ERROR in that case?

Can certainly be done, although I'm not sure to follow your concerns.  Can
you elaborate?

Thanks,
  Andrea
