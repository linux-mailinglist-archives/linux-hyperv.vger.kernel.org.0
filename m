Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5434F9AB9
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiDHQg1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiDHQg1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 12:36:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86F10E55E;
        Fri,  8 Apr 2022 09:34:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x24so5698581edl.2;
        Fri, 08 Apr 2022 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poKLZdLjyeVK1eiFPw1FYejqrhv7pft5yH4/kZaOek0=;
        b=BSyQ3rrkoLXhiF1cWehL6RkJ+44AWoRmS0X58u2EnISwJ9ArpoYtI8ZJSvhYlIHne/
         YfYD24VX6I2WbFgLJdjSRN0HfhTvVJ3JXifT61rUMf6wRBzldhPhsnT7gUFnUM5i9dAt
         R9hqUoQmgiCujTCJZAR4ffg8WDLqlfSo5fpAZaUuI3dRljzEtMwBhBDy+xQcXYF/y/B3
         yHyDD/wbvRBWNLf3pq5sTcTGTP0iviaOp5gwUkzzkRFJHViPcDjmpTmcBQWwrQWpJ7NA
         Dy6mzb4x4NzprlEWOYmqL17XeC0EdG1jx445V7NG30LflidIbH3TyLAzPJ/gkXCNGUmR
         OGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poKLZdLjyeVK1eiFPw1FYejqrhv7pft5yH4/kZaOek0=;
        b=7fenFMYeVQdLscSC8/oHvE1XqtijvAZ87dwYIfIaAYtkMcucEON2Y5b3mEs/ZZh+Eq
         iRmwRtS12KwtpfBxu+vNfUcGiHw9FhTd4YSMpNZEgsEE//+pn0/7jOHSpiUAhb2lgEGA
         QV2cMGvEeXN9FdnLoVqoPVykkM+CZAURSKbu6/1uYvSv/VJ05Z2dyzU+LF+vSHfMcY+W
         NHBQb2M7aGXf6YbdP1TwLmxCwu41oFY51qpUX6/jqrDq28tzRvn+6Uochv6LrKmlls5M
         MpKXBzZ6KBFMHTrr/cr6GUOi+O5G/mPv6BhNt52n4+lpgfg5brKpJzf3EC1bQJvAYqFu
         5RDA==
X-Gm-Message-State: AOAM533LNbD5uhUdl324kNVl3L7EBb8LsLdbYC+HOUPGx8Hsg0/YfCb8
        sTdBaj5Z6iAQMJzfMFpbVSo=
X-Google-Smtp-Source: ABdhPJyaMeOaFIlBInvrGXRQlh91hN4yI/Bg2JAqNpRoSUtb6ERSanHR0k2G0vqMIjgsesU/H6ZWFw==
X-Received: by 2002:a50:cd8d:0:b0:416:63d7:9326 with SMTP id p13-20020a50cd8d000000b0041663d79326mr20297238edi.233.1649435660944;
        Fri, 08 Apr 2022 09:34:20 -0700 (PDT)
Received: from anparri (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm8891181ejk.119.2022.04.08.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:34:19 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:34:11 +0200
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
Subject: Re: [PATCH 2/6] PCI: hv: Use vmbus_requestor to generate transaction
 IDs for VMbus hardening
Message-ID: <20220408163411.GA206695@anparri>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-3-parri.andrea@gmail.com>
 <PH0PR21MB302542ADED8A99414518ADA4D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302542ADED8A99414518ADA4D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -2743,11 +2751,14 @@ static void hv_pci_onchannelcallback(void *context)
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
> > +						     "Invalid transaction ID %llx\n",
> > +						     req_id);
> 
> This handling of a bad requestID error is a bit different from storvsc
> and netvsc.  They both use dev_err().  Earlier in the storvsc and netvsc
> cases, I remember some discussion about whether to rate limit these errors,
> and evidently we decided not to.  I think we should be consistent unless
> there's a specific reason not to.

Well, this 'error' is hardcoded in hv_compose_msi_msg() (as described in
patch #6).  But no strong opinion really: let me replace with dev_err().

Thanks,
  Andrea
