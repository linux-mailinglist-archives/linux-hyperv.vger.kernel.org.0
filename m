Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74C4C4BC4
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiBYROR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiBYROQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 12:14:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91AB1A8043;
        Fri, 25 Feb 2022 09:13:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5EE61D73;
        Fri, 25 Feb 2022 17:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E452C340E7;
        Fri, 25 Feb 2022 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645809222;
        bh=4sE4Gtevnk8/TCjMANbcRjCHG8DgJ5S+RZAsg3tQewo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aKNMEZYO9GYS47EsbtSGoBp7jQ6cq+PB2zbte+AwwqqiqpcVRMxGDM0F0Afex5ZJW
         4rYESli2esu86LIUX6eb+GIiQqKG0aJoZCwpzqlHuXkixzO/1AezAk2443Z9c992ps
         XywAbCY1/AWyw1jhDZ3bHZQXnfC+/H1QPWErc949Yi5ixSLpl4/cO2POfTAAfrxKho
         CAVXpDY7lijl79zw4wxpFlP592n7RcY/q2RQ45t4e4X5U4/DfLgdvmThUjLUu/hMNF
         a6Vl3pNKPQMeAYVdX3MJ7TCbUyat1DVH9TvH+imzTBTV3gNbtHMVmiV6Fa05o9r3/n
         oKdbLx9yzFJlA==
Date:   Fri, 25 Feb 2022 11:13:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 05/11] pci: use helper for safer setting of
 driver_override
Message-ID: <20220225171341.GA364850@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aff95ff-5b79-8ae9-48fd-720a9f27cbce@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 25, 2022 at 10:36:20AM +0100, Krzysztof Kozlowski wrote:
> On 25/02/2022 00:52, Bjorn Helgaas wrote:
> > On Thu, Feb 24, 2022 at 08:49:15AM +0100, Krzysztof Kozlowski wrote:
> >> On 23/02/2022 22:51, Bjorn Helgaas wrote:
> >>> In subject, to match drivers/pci/ convention, do something like:
> >>>
> >>>   PCI: Use driver_set_override() instead of open-coding
> >>>
> >>> On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
> >>>> Use a helper for seting driver_override to reduce amount of duplicated
> >>>> code.
> >>>> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
> >>>>  				     const char *buf, size_t count)
> >>>>  {
> >>>>  	struct pci_dev *pdev = to_pci_dev(dev);
> >>>> -	char *driver_override, *old, *cp;
> >>>> +	int ret;
> >>>>  
> >>>>  	/* We need to keep extra room for a newline */
> >>>>  	if (count >= (PAGE_SIZE - 1))
> >>>>  		return -EINVAL;
> >>>
> >>> This check makes no sense in the new function.  Michael alluded to
> >>> this as well.
> >>
> >> I am not sure if I got your comment properly. You mean here:
> >> 1. Move this check to driver_set_override()?
> >> 2. Remove the check entirely?
> > 
> > I was mistaken about the purpose of the comment and the check.  I
> > thought it had to do with *this* function, and this function doesn't
> > add a newline, and there's no obvious connection with PAGE_SIZE.
> > 
> > But looking closer, I think the "extra room for a newline" is really
> > to make sure that *driver_override_show()* can add a newline and have
> > it still fit within the PAGE_SIZE sysfs limit.
> > 
> > Most driver_override_*() functions have the same comment, so maybe
> > this was obvious to everybody except me :)  I do see that spi.c adds
> > "when displaying value" at the end, which helps a lot.
> > 
> > Sorry for the wild goose chase.
> 
> I think I will move this check anyway to driver_set_override() helper,
> because there is no particular benefit to have duplicated all over. The
> helper will receive "count" argument so can perform all checks.

Thanks, I think that would be good!

Bjorn
