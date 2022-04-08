Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82B94F9E47
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiDHUkp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiDHUko (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 16:40:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4610B10FAFF;
        Fri,  8 Apr 2022 13:38:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so19555650ejb.4;
        Fri, 08 Apr 2022 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhNBGBXII9hPPc9k14Zm8Zip5qNjp4bRcFbfG43K/cE=;
        b=btoiSM3bmnF7t/t+vaZsE5sdTYe66QVDfUep5N+ibzP9941+XaDjG4PYlvZHEKqxW/
         kYsG2Ba7DA36xgKQ6fngtKxl/itsetf5Tnnkfgo7+wKWlcdCG418U2FqU6EnVfOUCRhq
         Ku+IwbLLsv60D46CNpn1SfNS/8fR+rtd7GdMtmfJwNLD1hZ1qVK1cIvmdfY24D33Gkjx
         SRmFmnyFWtBt0wtsTcDkp6sdOcdfaIW4b/qIML4uZ1h2drgIWtRgMh/qIgIesNkSaXKw
         qLOhnUFA6e5TErwMNP3474/ZlElGUniKWU7rdtxiGcmPQrFuIlDT7U73c3rGeg72YpD3
         Jejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhNBGBXII9hPPc9k14Zm8Zip5qNjp4bRcFbfG43K/cE=;
        b=KQbMlMD6uWorXnpsFxmOwyp5lkiZiAXNAacexEKwxmoG42jXiFOPRnuRsejgc6zOT5
         klv0piotLp5hetEeAGLaZdKdxD7/z32gxmBi9a2Qb/mB/hTZbLEGlmL4eMkiUNGYg8l3
         g/MkdRLBD+k+9diekej6cRcrsh6/OsAiicKLmKws6WbY3/aV93hdrr5JOQfzoe9lixcz
         AqiCqBkUAwrdUPXLhqutsKzYlca6trspa5+3e4MQvlu7Dsq4Cqj+BTOv0t1ChUk2XRBP
         lxnOe9p8y/JYBlZs5DYSNn4vv/wSXjYyP0hcu+8c0EjwuLZiQ8aWSm/LL9q5Me1wD6XR
         sOLA==
X-Gm-Message-State: AOAM5338erdmK3snC9pUpKQ+ohDtoNPR4iT2PS7EzGKyQDML91XHqPHk
        RpKVNEJeshA9eW90yHoyfIg=
X-Google-Smtp-Source: ABdhPJwI6KYt1e4dC+pOihLjVKdfpXzvTVPpC3/KQRo5Y6Q7ZrD/v9ERhKHh+cSNkkhLqMjWUP5hOQ==
X-Received: by 2002:a17:906:d54e:b0:6db:b241:c0e2 with SMTP id cr14-20020a170906d54e00b006dbb241c0e2mr19730016ejc.724.1649450317632;
        Fri, 08 Apr 2022 13:38:37 -0700 (PDT)
Received: from anparri (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm9158553ejc.147.2022.04.08.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:38:36 -0700 (PDT)
Date:   Fri, 8 Apr 2022 22:38:28 +0200
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
Message-ID: <20220408203828.GA305168@anparri>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-5-parri.andrea@gmail.com>
 <PH0PR21MB3025D745B0F3FA8893B32B39D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220408164717.GA206777@anparri>
 <PH0PR21MB30258AE4C3CD9674E953C765D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30258AE4C3CD9674E953C765D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > > In the case where a specific match is required, and trans_id is
> > > valid but the addr's do not match, it looks like this function will
> > > return the addr that didn't match, without removing the entry.
> > 
> > Yes, that is consistent with the description on vmbus_request_addr_match():
> > 
> >   Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR if
> >   @trans_id is not contained in the requestor.
> > 
> > 
> > > Shouldn't it return VMBUS_RQST_ERROR in that case?
> > 
> > Can certainly be done, although I'm not sure to follow your concerns.  Can
> > you elaborate?
> > 
> 
> Having the function return "success" when it failed to match is unexpected
> for me.  There's only one invocation where we care about matching
> (in hv_compose_msi_msg).  In that invocation the purpose for matching is to
> not remove the wrong entry, and the return value is ignored.  So I think
> it all works correctly.

You're reading it wrongly: the point is that there's nothing wrong in *not
removing the "wrong entry" (or in failing to match).  In the mentioned use,
that means the channel callback has already processed "our" request, and
that we don't have to worry about the ID.  (Otherwise, i.e. if we do match,
the callback will eventually scream "Invalid transaction".)


> Just thinking out loud, maybe vmbus_request_addr_match() should be
> renamed to vmbus_request_addr_remove(), and not have a return value?

Mmh.  We have vmbus_request_addr() that (always) removes the ID; it seems
a _remove() would just add to the confusion.  And removing the return value
would mean duplicating most of vmbus_request_addr() in the "new" function.
So, I'm not convinced that's the right thing to do.  I'm inclined to leave
this patch as is (and, as usual, happy to be proven wrong).

Thanks,
  Andrea
