Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76544DE926
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Mar 2022 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiCSQBA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 19 Mar 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiCSQBA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 19 Mar 2022 12:01:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47219A561;
        Sat, 19 Mar 2022 08:59:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d10so22212355eje.10;
        Sat, 19 Mar 2022 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8GTIMWQve+g7wKIIsMEJALGjWCTbDmifDv5C0pWR1mM=;
        b=a5xvYHlvl3R8AQ0C3wjzNthnrBkCQ64fZ3NdgDvpeo2sYFWR7vVKJxfoSVjIaUbb91
         LjBEAxQ5S5Tv6q3nZpqzXHad4YPtjl/t2UFLepYBbYvx6KKq/jfa0jZzxNllid6J/SjI
         oadBNva70xUediy4wrvv4SZAm67TaFAT5ngoanjGKCa8N+j7mBIaJyoMtA/oS+Or62vG
         siGcZpt6qslVh0wqMBcxmxvWwOVbHiORwiRgTUKDYTR+SUjKEp5JGKIBecSxrvwnefh3
         t8Mbf2q8dHMSa9Vb1gqWG3vMSqxzl6y7eUu8oIwgeL2Y3hrPFhef1F9eH39mhMw69Cdu
         SXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8GTIMWQve+g7wKIIsMEJALGjWCTbDmifDv5C0pWR1mM=;
        b=PmfmicZePT/7YpKtaJAAXMYeLuCatQWcvrwqx3jYz482lHeE3fN5n98amcRZ25cw1U
         ikkXNekxrRg8I9/psiYSqNmnrBgCAXFZBbJ/M5CB1Lh51dVM+mRgh0ocAtwsI/Kvy0LT
         8QyO9mngaJ/4UkP+/ocqXY/jTiSw1nIt/ZhUQAU7vOIg1tA4BQrtx3ot0Nz5bojQikQA
         13WUzIMsvanIQHSTPbcRhsVvmwqF3+rejdp2L2QHAuQB8WojpFOh9XiyePSyzFtsr+Gw
         itUVP/KFnnlFqHlhwcDGwPra0fIPv9coUCKaqasMinJygQqbEEhg24H7S3ncIF36vTFX
         4BvQ==
X-Gm-Message-State: AOAM5300M98Ngui8pjbNkbJgwr5sYFUM8cLUPtgV+zfbTPLRj7/upqhO
        8+aSBUrvdlX1ZffiPJVCSvE=
X-Google-Smtp-Source: ABdhPJwnka6fXpm7aOvyQf5QPKnfzcNr+LOOu0fmSGTuddcAPR24PWqME2x4vz2NG03ZCY5yOnmjOg==
X-Received: by 2002:a17:906:6886:b0:6df:8b7b:499e with SMTP id n6-20020a170906688600b006df8b7b499emr13801188ejr.289.1647705576710;
        Sat, 19 Mar 2022 08:59:36 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b006ce04bb8668sm4902499ejh.184.2022.03.19.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 08:59:36 -0700 (PDT)
Date:   Sat, 19 Mar 2022 16:59:28 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transaction
 IDs for VMBus hardening
Message-ID: <20220319155928.GA2951@anparri>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
 <KL1P15301MB0295879FF28B67F3C521FFB3BE149@KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0295879FF28B67F3C521FFB3BE149@KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -1208,6 +1211,27 @@ static void hv_pci_read_config_compl(void
> > *context, struct pci_response *resp,
> >  	complete(&comp->comp_pkt.host_event);
> >  }
> > 
> > +static inline int alloc_request_id(struct hv_pcibus_device *hbus,
> > +				   void *ptr, gfp_t gfp)
> > +{
> > +	unsigned long flags;
> > +	int req_id;
> > +
> > +	spin_lock_irqsave(&hbus->idr_lock, flags);
> > +	req_id = idr_alloc(&hbus->idr, ptr, 1, 0, gfp);
> 
> [Saurabh Singh Sengar] Many a place we are using alloc_request_id with GFP_KERNEL, which results this allocation inside of spin lock with GFP_KERNEL.

That's a bug.


> Is this a good opportunity to use idr_preload ?

I'd rather fix (and 'simplify' a bit the interface) by doing:

static inline int alloc_request_id(struct hv_pcibus_device *hbus, void *ptr)
{
	unsigned long flags;
	int req_id;

	spin_lock_irqsave(&hbus->idr_lock, flags);
	req_id = idr_alloc(&hbus->idr, ptr, 1, 0, GFP_ATOMIC);
	spin_unlock_irqrestore(&hbus->idr_lock, flags);
	return req_id;
}

Thoughts?

Thanks,
  Andrea
