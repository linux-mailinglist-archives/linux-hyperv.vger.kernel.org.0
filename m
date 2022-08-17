Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D7596AA2
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Aug 2022 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiHQHvl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Aug 2022 03:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHQHvk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Aug 2022 03:51:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99967A515;
        Wed, 17 Aug 2022 00:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59B11CE1B94;
        Wed, 17 Aug 2022 07:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AF1C433D6;
        Wed, 17 Aug 2022 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660722693;
        bh=iWwfXuklbTOD8tVpuV3XjT6Wa57Mj01ZLbe2IkbtdKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2eph+kYna/HuHPyA/igO7h9P+7F2b0o8WDm4OrL0ynZwGSdrfx+cYjwJ5gJwounJ
         NNDhAJUY+DleGgqjH+/qi0OVe1DtS9o/uN9EIm2g8OvrEa/1I2W3nM5e0gcGyF4Uqs
         fKNIAzA7NLRzL8tXlkyTOEaP6kboP274qKMN+2Dim9FjzxSDwf+A89MikbaA+e71rM
         q2CoB/a1EuJaC4vyt0w1wu/EzTRkSrLddYbEy6WOyj6BSM+th77MDWdIercFxdNvz2
         X25jolRrEVoDzivDpaqyx5KbRgv1diJ5/ERtnF2YNZJU+qgjNc5YegYlamnZHXbnMm
         nhgdJP5IK0/kg==
Date:   Wed, 17 Aug 2022 09:51:24 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
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
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: Re: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <Yvyd/OoDWeDil/Tm@lpieralisi>
References: <20220804025104.15673-1-decui@microsoft.com>
 <20220816155122.GA2064495@bhelgaas>
 <SA1PR21MB1335FD78A02C0CE2632E532BBF6B9@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335FD78A02C0CE2632E532BBF6B9@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 16, 2022 at 09:13:26PM +0000, Dexuan Cui wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, August 16, 2022 8:51 AM
> > To: Dexuan Cui <decui@microsoft.com>
> > 
> > This has only observations with no explanations, and I don't see how
> > it will be useful to future readers of the git history.
> Please see the below.
>  
> > I assume you bisected the problem to b4b77778ecc5?  
> Yes.
> 
> > Can you just revert that?  A revert requires no more explanation than
> >  "this broke something."
> 
> It's better to not revert b4b77778ecc5, which is required by Jeff's
> Multi-MSI device, which doesn't seem to be affected by the interrupt
> issue I described.

You must debug it, there are no two ways about it.

We can't apply fixes on a hunch, more so given that I am not convinced
at all this patch is fixing anything, it is just papering over an
underlying bug that is still to be pinpointed.

> > I guess this is a fine distinction, but I really don't like random
> > code changes that "seem to avoid a problem but we don't know how."
> > A revert at least has the advantage that we can cover our eyes and
> > pretend the commit never happened. This patch feels like future
> > readers will have to try to understand the code even though we
> > clearly don't understand why it makes a difference.
> 
> I just replied to Lorenzo's email with more details. FYI, this is the link
> to my reply:
> https://lwn.net/ml/linux-kernel/SA1PR21MB1335D08F987BBAE08EADF010BF6B9@SA1PR21MB1335.namprd21.prod.outlook.com/
>  
> I just felt the commit message might be too long if I had put all the
> details there. :-) Can we add a Links: tag?

Commit logs must describe the issue you are fixing, thouroughly and
concisely. To start with "Jeffrey's 4 recent patches" is a very bad
start for a commit log, it means nothing, try to read your log as
someone who needs to understand the commit years down the line please.

Now, back to this patch: we are at -rc1, unless Bjorn is willing to
do so I am not inclined to apply this patch till next merge window
(and actually I am not inclined to merge it at all).

This gives you folks time to debug it (and it must be debugged), the
fact that it works for one multi-MSI device does not mean that the
bug isn't still there - I am worried that the issue is with
b4b77778ecc5 and the interaction with core MSI/IOMMU.

Thanks,
Lorenzo
