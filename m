Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2284EF814
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Apr 2022 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiDAQja (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Apr 2022 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiDAQgU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Apr 2022 12:36:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D360ABA;
        Fri,  1 Apr 2022 09:09:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y10so3499766edv.7;
        Fri, 01 Apr 2022 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OsRh1+OUJjafmw1DLalzmHZY/d86wBXtRZCzuhQ9mCU=;
        b=CyaAXZ+IZKz9gQ7HVvoq92nHK87TtxUVRVI+dFs2B2UzLDczPui7Zt+1vUbmgx3Bdt
         dpkGF1v81vHMc3grDBckD5+il7kl40JL+LMt+glIHncxGx42UclHTuL+3qQhARf5up8N
         VYAPCe5GDasxGVJG81cP9vsjjlvjLoYOWgiyObxxMnwnGxPWXeBNFSNTaKqi/FmvrO+n
         cpm0PirjT1Ego1eSZj2BOi3r0ESuibWg+TNdxIiE16r+fJeqD58K2Y2fokGGZxHciWzk
         WijuccdcZfn+O8TFWAdhtCW11jP4jquKrxZZMHZQdWrBmCI7sakO9I41pBw8+JcKMa56
         l9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OsRh1+OUJjafmw1DLalzmHZY/d86wBXtRZCzuhQ9mCU=;
        b=SE8/ecDw2ERYSDtcNTnVxa0uG9QGL1hak47UYukw5vwvflOfHhxXcsDh0RtI68d38b
         TbHTiKXaue5thcli90lTnzgMsgQViml+nEbFDen4hUYutOc8FXTr/iZresHV69uSyMik
         KN7g2HsMiYHTlWufuT2ajBVYB/h+eiL3w/EwB+MR+YYSdnGEe8i7jU5k9rz5d8k9sfUe
         xXzae0k8YMuwczpN9y3k71AuCjJDloX8zVRuMDylkbJQhZsD0k6cUZiXrCVidDFQ7iWD
         mUK15ru7+MDm3R7Onazg68wK/1IeKa1xHHFoCfZAuik8UkGktjhbUwWv0AWbQaT2E3m9
         chbw==
X-Gm-Message-State: AOAM533pCuzN8T0vGuvkeBUGSFL4c4co6Dd4db/sYu8lNuesMuFwV9WA
        g0oeSx1bkgewij65s53aww0=
X-Google-Smtp-Source: ABdhPJzv5bt7f0IiLlBql9Y5PWwGhZWdPagcJ+jWbTiZA17jQAlP+7vQNkZuTUH5vvkRzeIERD4AwA==
X-Received: by 2002:a05:6402:4250:b0:419:5e89:a40f with SMTP id g16-20020a056402425000b004195e89a40fmr21974008edb.319.1648829365926;
        Fri, 01 Apr 2022 09:09:25 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906275500b006d10c07fabesm1158632ejd.201.2022.04.01.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:09:25 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:09:22 +0200
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
Subject: Re: [RFC PATCH 3/4] Drivers: hv: vmbus: Introduce
 vmbus_sendpacket_getid()
Message-ID: <20220401160922.GB437893@anparri>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-4-parri.andrea@gmail.com>
 <PH0PR21MB3025F80C3F90284900C3D128D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025F80C3F90284900C3D128D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -354,6 +354,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
> >  	}
> >  	desc = hv_get_ring_buffer(outring_info) + old_write;
> >  	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
> > +	if (trans_id)
> > +		*trans_id = desc->trans_id;
> 
> This line should *not* read the trans_id out of the ring buffer, since that
> memory is shared with the Hyper-V host and subject to being maliciously
> changed by the host.  Need to set *trans_id only from local variables, and
> somehow ensure the compiler doesn't generate code that reads the value
> from the ring buffer.  Maybe mark the desc->trans_id field as volatile, or cast
> it as such?  Or does WRITE_ONCE() work when setting it?

I'd stick to WRITE_ONCE() (with a comment).

Good catch!

Thanks,
  Andrea
