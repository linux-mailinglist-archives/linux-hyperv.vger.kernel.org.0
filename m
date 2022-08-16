Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55586595F9F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiHPPvg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiHPPvR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 11:51:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9D4CA28;
        Tue, 16 Aug 2022 08:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EAE2B819FD;
        Tue, 16 Aug 2022 15:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DE4C433D7;
        Tue, 16 Aug 2022 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660664861;
        bh=aKvPsohDSBJiB5TXkIrXCiYFnaesf9dXCifjErQ/bac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eb2+6gOzqLdZ2ntVfzTUs91xjwjOpKOPMdF5cKSFodnKDZgNmDwZ8BqZQS3zRkFsm
         DTuLYD52oHbGuFTEKZiGyKa7kvc+/y+rIl2m9En+BMYt74dj7Lus0edrG3/bVqlPLK
         9r5JgmjAfTTKSpYbl22uc9FVE7q9L6ZBJ1SgLRLZ2qwQtOh4aznAbifi5oW+NdHzGO
         eGEq8yJSoBeJQ9HfxxGZs1ShlILf5tG2Q79bWI+xko2RcDoCQe1UvoC0LxWM49t2rq
         YUYhTmqT0HGhot3p7xxHFC7rzwJ/SorzaZ9+TUGuRyGdAcVrZDvG9Z2IKWApChYpoy
         5yrk4d8Ozsvqg==
Date:   Tue, 16 Aug 2022 17:47:32 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: Re: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <Yvu8FJfWkWX3rhO5@lpieralisi>
References: <20220804025104.15673-1-decui@microsoft.com>
 <0f19cc67-ccb1-7cd1-5475-d2ec0e1abfc0@quicinc.com>
 <SA1PR21MB1335D9CF9F0B1C101F15E047BF659@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335D9CF9F0B1C101F15E047BF659@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 10, 2022 at 09:51:23PM +0000, Dexuan Cui wrote:
> > From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Sent: Thursday, August 4, 2022 7:22 AM
> >  ...
> > > Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in
> > compose_msi_msg()")
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> > > ---
> > 
> > I'm sorry a regression has been discovered.  Right now, the issue
> > doesn't make sense to me.  I'd love to know what you find out.
> > 
> > This stopgap solution appears reasonable to me.
> > 
> > Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> Hi Lorenzo, Bjorn and all,
> Would you please take a look at the patch?

I am not very happy with this patch, it is a temporary solution to
a potential problem (or reworded: we don't know what the problem is
but we are fixing it anyway - in a way that is potentially not
related to the bug at all).

If the commit you are fixing is the problem I'd rather revert it,
waiting to understand the problem and to rework the code accordingly.

I don't think b4b77778ecc5 is essential to Hyper-V code - it is a
rework, let's fix it and repost it when it is updated through the
debugging you are carrying out. In the meantime we can revert it
to fix the issue.

Thanks,
Lorenzo
