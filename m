Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED94C39E0
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 00:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiBXXwk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 18:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiBXXwj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 18:52:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1487B458B;
        Thu, 24 Feb 2022 15:52:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9541661CBF;
        Thu, 24 Feb 2022 23:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD98FC340E9;
        Thu, 24 Feb 2022 23:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645746728;
        bh=zVAGv3GzIY0CmGHccO6MTpPuZ0cGji1luXzfksNlM2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kCSNhdmjCNFp4p3nEZo05DvtkYaTYatl89i6A6bnh2GoE1LafejZW2+LdT+xyn9p9
         vFysfr3uU3CN1goYGDWRGNKLLknLWL4gwXq4LwSu/xs2AfSKORCBht3dm2YESZuJkC
         QTihOOdWAM03oTBu5HCC9wQYShduFbcLphU9XZZOZ2w+HR8xeoLGBBRX0Da60zkFuO
         Gw55uOtn72xOyN5dsOgPR66lVXrDqagidhgfw1lK88dhzevhVz/lXIRWDLrY+G2rDT
         B2vC1ShfZifdcQml58IDHz2aBNdppV0ayqFTRcbx14EaEZyzuuUqWcpsrE30jKvDVw
         +pVWnNSGt5bFQ==
Date:   Thu, 24 Feb 2022 17:52:06 -0600
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
Message-ID: <20220224235206.GA302751@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7347531-8aa4-c011-d405-dea93e29779f@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 24, 2022 at 08:49:15AM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2022 22:51, Bjorn Helgaas wrote:
> > In subject, to match drivers/pci/ convention, do something like:
> > 
> >   PCI: Use driver_set_override() instead of open-coding
> > 
> > On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
> >> Use a helper for seting driver_override to reduce amount of duplicated
> >> code.
> >> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
> >>  				     const char *buf, size_t count)
> >>  {
> >>  	struct pci_dev *pdev = to_pci_dev(dev);
> >> -	char *driver_override, *old, *cp;
> >> +	int ret;
> >>  
> >>  	/* We need to keep extra room for a newline */
> >>  	if (count >= (PAGE_SIZE - 1))
> >>  		return -EINVAL;
> > 
> > This check makes no sense in the new function.  Michael alluded to
> > this as well.
> 
> I am not sure if I got your comment properly. You mean here:
> 1. Move this check to driver_set_override()?
> 2. Remove the check entirely?

I was mistaken about the purpose of the comment and the check.  I
thought it had to do with *this* function, and this function doesn't
add a newline, and there's no obvious connection with PAGE_SIZE.

But looking closer, I think the "extra room for a newline" is really
to make sure that *driver_override_show()* can add a newline and have
it still fit within the PAGE_SIZE sysfs limit.

Most driver_override_*() functions have the same comment, so maybe
this was obvious to everybody except me :)  I do see that spi.c adds
"when displaying value" at the end, which helps a lot.

Sorry for the wild goose chase.

> >> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> >> -	if (!driver_override)
> >> -		return -ENOMEM;
> >> -
> >> -	cp = strchr(driver_override, '\n');
> >> -	if (cp)
> >> -		*cp = '\0';
> >> -
> >> -	device_lock(dev);
> >> -	old = pdev->driver_override;
> >> -	if (strlen(driver_override)) {
> >> -		pdev->driver_override = driver_override;
> >> -	} else {
> >> -		kfree(driver_override);
> >> -		pdev->driver_override = NULL;
> >> -	}
> >> -	device_unlock(dev);
> >> -
> >> -	kfree(old);
> >> +	ret = driver_set_override(dev, &pdev->driver_override, buf);
> >> +	if (ret)
> >> +		return ret;
> >>  
> >>  	return count;
> >>  }
> >> -- 
> >> 2.32.0
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
