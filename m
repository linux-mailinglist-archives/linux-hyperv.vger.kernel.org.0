Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0094EF7E0
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Apr 2022 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiDAQaM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Apr 2022 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348714AbiDAQ2A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Apr 2022 12:28:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1B22513;
        Fri,  1 Apr 2022 09:00:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so6836121ejb.2;
        Fri, 01 Apr 2022 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jHgBZFPUit49TSD+W0vcWqdUpO3LWDl0zvqR1OYTQU=;
        b=BsOyCfH9ORI2nZzbH2g35bwoxed+qvcrU4SidE+0rO+cW4Q2BiKEdUfs1IOK65bqQJ
         kmBeDHc1KB2uUHHtgRmqtotncTR3ZXPqkihXVwYZna8VX0gsPmFgakoNB1nAjXZq5W/4
         pIf5ucClXaSqWIZUNRBZ7EEUm5ZwArgN4Cun0Z0lkiDUmxEWsOFIegHUCP0IKu/6fNDI
         wiypDEWT0b+cGAUjXeD/zbLlw5jnPl86pgSD4bcbF6x/8sakRcLTQQhTy2EGQiW3rTVV
         0ky9PxC4fjOmxjMdLz1ytCREtWe2yJf5t7EJCP+WvJbwwdKDVUR9ssFocXMD3yaI4vAy
         PcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jHgBZFPUit49TSD+W0vcWqdUpO3LWDl0zvqR1OYTQU=;
        b=KKzlvucaLBC8ZGXlEfJfCkLh3zio02Gwq3Ba46Cz1r81ZE/DnxCejBW9MH8HxnapOM
         zpUj4X+d24NBdHpewncrAqgJk0YW454bF/75PYRZQK615fq9AjJT5lD31H/+qklxysR6
         H/klzghEJMoOr7M0BsbIrt8UxIz9mDEnNwSgk8soN3GRSlKkHo8THp0q7GtbbK2WJuyZ
         GWsri8a9xJzOyvpOg3NgT8rXTcoJnYYTKavgWhVteyBo91OOWwtEE0hl2BmIjgDV83Ir
         EkWCZkixPSKs4Yris9Gn/wM+2mfuFqQysedpPGK099xrc2quMqV9ySPLXGTz+bTBsCJ0
         5l/A==
X-Gm-Message-State: AOAM532rK9OontEJHvg/LKcIJBb3yP98G/AJ0MjY+nqEaTG9vJflSZQA
        QB4S4VoOF+hhcp97Ne+jn+Y=
X-Google-Smtp-Source: ABdhPJxwTLUF5gE9o2QdBV/5AMlb7dmQqN2evGxOiB/eEU3n8mrZHqeb4+4NLQr/Tt3aBF5S/5txwQ==
X-Received: by 2002:a17:907:7ea5:b0:6e1:13c3:e35f with SMTP id qb37-20020a1709077ea500b006e113c3e35fmr409386ejc.99.1648828845097;
        Fri, 01 Apr 2022 09:00:45 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm1162174ejc.218.2022.04.01.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:00:44 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:00:36 +0200
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
Subject: Re: [RFC PATCH 2/4] PCI: hv: Use vmbus_requestor to generate
 transaction IDs for VMbus hardening
Message-ID: <20220401160036.GA437893@anparri>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-3-parri.andrea@gmail.com>
 <PH0PR21MB3025A45FCFD77242EB9EAB27D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025A45FCFD77242EB9EAB27D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -91,6 +91,9 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
> >  /* space for 32bit serial number as string */
> >  #define SLOT_NAME_SIZE 11
> > 
> > +/* Size of requestor for VMbus */
> > +#define HV_PCI_RQSTOR_SIZE 64
> 
> Might include a comment about how this value was derived.  I *think*
> it is an arbitrary value based on the assumption that having more than
> one request outstanding is rare, and so 64 should be extremely generous
> in ensuring that we don't ever run out.

Right, I've added a comment to that effect.


> > @@ -2696,8 +2699,9 @@ static void hv_pci_onchannelcallback(void *context)
> >  	const int packet_size = 0x100;
> >  	int ret;
> >  	struct hv_pcibus_device *hbus = context;
> > +	struct vmbus_channel *chan = hbus->hdev->channel;
> 
> Having gotten the channel as a local variable, could also use the local as
> the first argument to vmbus_recvpacket_raw().

Applied.


> > @@ -2743,11 +2747,13 @@ static void hv_pci_onchannelcallback(void *context)
> >  		switch (desc->type) {
> >  		case VM_PKT_COMP:
> > 
> > -			/*
> > -			 * The host is trusted, and thus it's safe to interpret
> > -			 * this transaction ID as a pointer.
> > -			 */
> > -			comp_packet = (struct pci_packet *)req_id;
> > +			req_addr = chan->request_addr_callback(chan, req_id);
> > +			if (req_addr == VMBUS_RQST_ERROR) {
> > +				dev_warn_ratelimited(&hbus->hdev->device,
> > +						     "Invalid request ID\n");
> 
> Could you include the req_id value in the error message that is output?  I
> was recently debugging a problem in the storvsc driver where having that
> value would have been handy.

Sure.

Thanks,
  Andrea
