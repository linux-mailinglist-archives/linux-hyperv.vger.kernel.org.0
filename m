Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B8651D289
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 May 2022 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389697AbiEFHvu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 May 2022 03:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389679AbiEFHvs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 May 2022 03:51:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D60674F8;
        Fri,  6 May 2022 00:48:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so12893072ejb.6;
        Fri, 06 May 2022 00:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ft3fc9QL1+iQ008reNvM/ifI2x+9VqujLjdVk3BAeKE=;
        b=OZk+O/7KtBby4smjTuDPTjrl3oDJTDhPtG5EGl8/TXE5iHBSCTMIv4DRcnawTyo5dv
         tdYP82kIiXUngTkDdS2y1NofcKP4v/2S1CHtAksTdkCqrHFp1DCbT1v9aoXXIB6vzaCo
         mm6hPQatzFU8dQ1Uca2EkRR7VQAaXdk5IY+JJlVTxktUE+ofK/3BDkRpsL8MBhmNOub2
         Z0IYw6QW1sW8pCmY73iaRLLTu6FJETywMGthz52s6RtQ6kuRpQAurIAYF3zMbCFnrpEn
         zjTd2qO99mmDTGE618ALE3847Y74DtMdLlEO80jFvIXKWHSY4kWT2Lz+pPTzM5oLCEds
         4mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ft3fc9QL1+iQ008reNvM/ifI2x+9VqujLjdVk3BAeKE=;
        b=fKsXpu8ue8QVJO+amlLP0E/pdnu2rYaGljq6JUSRJX5IXTPRELlIJO/INV5kzSerIt
         hZ7+uB2jKjvKVm35mTENMnwDQ8Ja2wLKoMUdu7d92CcEfCwzqsvF5szP8Gj9W+g8nXuh
         ssCZtOt2GomD5TwFyCHV7uk+hgz4R3r9Fc84kdVhOUNNXUB/aK29CuoNNBd0ZqpPZHfY
         SplLM783gSwpnO7tM5sM139OwHkkoxLgwEvSMWjM1UOY5ocSlE3sS8xzA9YdIEHybDaO
         Eq6Ix42BFAock/23VoKpED2CAaOLJNmv0jtL0yl5IfBZOCeZobeetGgiil3lwiobKklx
         a1MA==
X-Gm-Message-State: AOAM532gSMtbfFQ1EbAE1Kw/MMKmYIBl60CgE5IW6yPgxviT8jeIln7i
        vWh+Fam6RvghK5TcUfolqDY=
X-Google-Smtp-Source: ABdhPJxT5lhpMaFwTxXFJilaqKfKKUZHKY6ygUe4sfy0YWuUtl3iNp7QH09j+YPPh1tnTwimBcK+2Q==
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id nd41-20020a17090762a900b006da79534df0mr1858291ejc.316.1651823284534;
        Fri, 06 May 2022 00:48:04 -0700 (PDT)
Received: from anparri (host-2-117-178-169.business.telecomitalia.it. [2.117.178.169])
        by smtp.gmail.com with ESMTPSA id gz12-20020a170906f2cc00b006f3ef214de8sm1602215ejb.78.2022.05.06.00.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:48:04 -0700 (PDT)
Date:   Fri, 6 May 2022 09:47:55 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: hv: Add validation for untrusted Hyper-V values
Message-ID: <20220506074755.GA239213@anparri>
References: <20220504125039.2598-1-parri.andrea@gmail.com>
 <20220504125039.2598-2-parri.andrea@gmail.com>
 <PH0PR21MB302509DA8BE0B347E1916F00D7C29@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302509DA8BE0B347E1916F00D7C29@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> I don't see any issues with the code here.  But check the function
> q_resource_requirements().  Doesn't it need the same treatment as you've
> done above with hv_pci_compose_compl()?   For completeness, the
> fix for q_resource_requirements() should be included in this patch as well.

Yes, indeed.  Will do for v2.

Thanks,
  Andrea
