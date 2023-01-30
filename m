Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAC6816EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjA3Qva (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbjA3Qv3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 11:51:29 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9860D3D924;
        Mon, 30 Jan 2023 08:51:28 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 545E520E9F90; Mon, 30 Jan 2023 08:51:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 545E520E9F90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675097488;
        bh=Rre807gZOD8p3UjEPIEDW03aOt59zeNQl9BBuzqfJEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVGOuGrQcD9FeB99Y2w7DhbLdk5fP+8qpcUKdTU62R8tBsyKuLpz6sI4v6/NlW8dX
         NvQGyCzW1L4zCTqRT1ktmHEXfdOWqW+AaoCg3UPP5xdzq4J0wOpDs2KBkhI2mMAKTl
         +T7ZzjIP0llz6bMj7OBnHGBplAF96j6oXZ4cpPmM=
Date:   Mon, 30 Jan 2023 08:51:28 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 3/6] x86/sev: Maintain shadow rmptable on Hyper-V
Message-ID: <20230130165128.GC27645@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-4-jpiotrowski@linux.microsoft.com>
 <BYAPR21MB1688B068954CEB8A2B4DEA73D7D29@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR21MB1688B068954CEB8A2B4DEA73D7D29@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jan 29, 2023 at 04:37:24AM +0000, Michael Kelley (LINUX) wrote:
> From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> Sent: Monday, January 23, 2023 8:51 AM
> > 
> > Hyper-V can expose the SEV-SNP feature to guests, and manages the
> > system-wide RMP (Reverse Map) table. The SNP implementation in the
> > kernel needs access to the rmptable for tracking pages and deciding
> > when/how to issue rmpupdate/psmash.  When running as a Hyper-V guest
> > with SNP support, an rmptable is allocated by the kernel during boot for
> > this purpose. Keep the table in sync with issued rmpupdate/psmash
> > instructions.
> > 
> > The logic for how to update the rmptable comes from "AMD64 Architecture
> > Programmer’s Manual, Volume 3" which describes the psmash and rmpupdate
> > instructions. To ensure correctness of the SNP host code, the most
> > important fields are "assigned" and "page size".
> > 
> > Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> > ---
> >  arch/x86/kernel/sev.c | 59 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > index 95404c7e5150..edec1ccb80b1 100644
> > --- a/arch/x86/kernel/sev.c
> > +++ b/arch/x86/kernel/sev.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/amd-iommu.h>
> > 
> > +#include <asm/mshyperv.h>
> 
> The code in sev.c should be generic and appropriate for use with any
> hypervisor.  As such, I think we want to avoid sev.c having a dependency
> on Hyper-V specific code, such as the <asm/mshyperv.h> include file
> and the ms_hyperv.nested_features variable as used below.
> 
> Instead, create a boolean static variable in the sev.c module along with
> a wrapper function to set it.  The logic that tests hv_no_rmp_table()
> should test this static variable instead, which would default to "false".
> Hypervisor-specific initialization code can call the wrapper function
> to set the variable to "true" based on whatever logic is appropriate for
> the hypervisor.  This approach reverses the dependency and hopefully
> is usable by other hypervisors that want to offer nested SNP support.
> 

ok, this makes sense. I've added a call to the wrapper to the init_mem_mapping
callback added before so that it is enabled together with allocating the
rmptable.

