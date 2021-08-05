Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785173E1B0B
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhHESQf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhHESQf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 430E460E8D;
        Thu,  5 Aug 2021 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628187380;
        bh=fRMwCzEryajqu2xcp0mEV1Y2KxW3CpaQzsE/wiiybfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1z8mJt/GTpAKS88ThuPPyGJyJBQupScZMqntaDa9Igf0v2pzgnXML0W6mYw4oyqtX
         jlx1lVmUjC4FWjO9yUdDy2ND6Hbl88qvFmLaPEkTFcxlYQHG9WI6PHvpTPqyerqXpT
         28wdqke0BajafjDpnLSssqqbelxZS0QiD7YVN6C8=
Date:   Thu, 5 Aug 2021 20:16:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YQwq8tDGx/Zes/sU@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
 <YQuPJUX4+HZ3FeKC@kroah.com>
 <BY5PR21MB15061507ED1B0CE1CDC7EE3ECEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB15061507ED1B0CE1CDC7EE3ECEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 05, 2021 at 06:07:31PM +0000, Long Li wrote:
> > Subject: Re: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
> > 
> > On Thu, Aug 05, 2021 at 12:00:11AM -0700, longli@linuxonhyperv.com wrote:
> > > +static int az_blob_create_device(struct az_blob_device *dev) {
> > > +	int ret;
> > > +	struct dentry *debugfs_root;
> > > +
> > > +	dev->misc.minor	= MISC_DYNAMIC_MINOR,
> > > +	dev->misc.name	= "azure_blob",
> > > +	dev->misc.fops	= &az_blob_client_fops,
> > > +
> > > +	ret = misc_register(&dev->misc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	debugfs_root = debugfs_create_dir("az_blob", NULL);
> > 
> > So you try to create a directory in the root of debugfs called "az_blob"
> > for every device in the system of this one type?
> > 
> > That will blow up when you have multiple devices of the same type, please
> > fix.
> 
> The Hyper-V presents one such device for the whole VM.

Today, maybe, tomorrow, who knows.  Do not write code that we know will
be wrong if you have multiple devices in the system of the same type.
It takes almost no effort to get this correct.

> I'm sorry I may have misunderstood. Are you suggesting I should create
> a directory "hyperv" in the root of debugfs and put all the Hyper-V
> driver debug information there?

Ideally, yes, if the hyperv subsystem uses debugfs, it should make a
subdir and you should use that.  If not, then do whatever you want, but
do not do something that you know will be broken if you have multiple
devices of the same type in the system, like the current code is
showing.

thanks,

greg k-h
