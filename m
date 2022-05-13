Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE45267B3
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 May 2022 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382566AbiEMQ6x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 May 2022 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382555AbiEMQ6w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 May 2022 12:58:52 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702731EAE2;
        Fri, 13 May 2022 09:58:50 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id t6so12231680wra.4;
        Fri, 13 May 2022 09:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szpICPsOHZ4foJXcM4YadkcgVppbA4y8FdPwYx+I+Nk=;
        b=RxfmtBxqmgTTBatfZzR4O52zO/mp7tyo+17FBQhd3gFTdLyIr0cHInc1D2OZBx3ywT
         uH3E+8vXC5Z06foLksINSwKBI1WnGgSxiOEO9KG00DF9lfnby8c7rlplJDP+IZXMlI9H
         mKMMmnSLw0Utl63LtPrRRIzp+pEp4nAP856kPTdhmDZ7ZMgTRRGnc49sL9XraDtE+zaz
         gKmN57h/WKo+p96BllJ+A0kVlN+JujjMTrbnF0z0Di02bUI4DRzBDhjYokkGKzH21NMg
         +jFBnAMNj/Fs+bSB1wFzzFwGrVxhgjF+HOUqHMUbOyc8Jy4iErmu+4DUS1ShUPwYscVW
         +oQA==
X-Gm-Message-State: AOAM5302Iidz3PW9VwcJP2e6Pk+Owo43IWroKBqtJUvU/ErtuF+cDgwS
        LCkXBplPnPfJ/9yVi8hoT+A=
X-Google-Smtp-Source: ABdhPJxx+0X3/RPc7qiKPKSD54S+1Sv0tMWRg59SLF55UdKINyBYtxrCJ1wokLfu3Nj9jXQYYpcvGg==
X-Received: by 2002:adf:e845:0:b0:20c:d4d4:29e9 with SMTP id d5-20020adfe845000000b0020cd4d429e9mr4687198wrn.12.1652461129033;
        Fri, 13 May 2022 09:58:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d7-20020adfc807000000b0020c5253d8e4sm2594882wrh.48.2022.05.13.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:58:48 -0700 (PDT)
Date:   Fri, 13 May 2022 16:58:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: hv: Hardening changes
Message-ID: <20220513165846.ss26oqo3prhk3h3s@liuwe-devbox-debian-v2>
References: <20220511223207.3386-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511223207.3386-1-parri.andrea@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 12, 2022 at 12:32:05AM +0200, Andrea Parri (Microsoft) wrote:
> Changes since v1[1]:
>   - Add validation in q_resource_requirements()
> 
> Patch #2 depends on changes in hyperv-next.  (Acknowledging that hyperv
> is entering EOM, for review.)
> 
> Thanks,
>   Andrea
> 
> [1] https://lkml.kernel.org/r/20220504125039.2598-1-parri.andrea@gmail.com
> 
> Andrea Parri (Microsoft) (2):
>   PCI: hv: Add validation for untrusted Hyper-V values
>   PCI: hv: Fix synchronization between channel callback and
>     hv_pci_bus_exit()

Applied to hyperv-next. Thanks.
