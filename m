Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F0525FF0
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 May 2022 12:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379302AbiEMKLp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 May 2022 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379295AbiEMKLk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 May 2022 06:11:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB5312F016;
        Fri, 13 May 2022 03:11:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EFEB143D;
        Fri, 13 May 2022 03:11:39 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.2.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877863F5A1;
        Fri, 13 May 2022 03:11:37 -0700 (PDT)
Date:   Fri, 13 May 2022 11:11:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: hv: Hardening changes
Message-ID: <20220513101132.GA26886@lpieralisi>
References: <20220511223207.3386-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511223207.3386-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

I suppose then it is best for me to ACK it and ask Hyper-V maintainers
to pick it up.

For the series:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
> 
>  drivers/pci/controller/pci-hyperv.c | 59 +++++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> -- 
> 2.25.1
> 
