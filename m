Return-Path: <linux-hyperv+bounces-3278-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FB19BFD93
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 06:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D7C1F22177
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FFB190049;
	Thu,  7 Nov 2024 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqZ6urMl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE777F9;
	Thu,  7 Nov 2024 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956880; cv=none; b=LENYGg9hdEDWuy1wvheYJ/544oaV4tMKP//gXXHhWPoaYJXiJetWQSCWpALra8mXrI3i+rvGStRehiJqO8gjfJsV1/SzUPZtK5htckjmXYfYZZfrZInz2Le1fluze4xFCqKvSBFaV5wgUtvGKlavxwerC6XakolkLF5EkKf8k2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956880; c=relaxed/simple;
	bh=LcTJNuAS+0u64bln2s0a89deCwW+g5Nrojs1Slddt/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO99nVgrqp4dw8p7qVK2jfBGh9eIGIKpk+5etsZf8dDM4FuysxBcQqw9KiQ50cVPfbyh+tkJ0iWPxTiNl4jjq32Jd09oczcLL3oO5hJbTM4BO+AGpzvwEMvd2nIpBFFZkARR2Qc3MqlHhUGPsC0kbPNRCn7myndMAHw2yhsTfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqZ6urMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064BBC4CECC;
	Thu,  7 Nov 2024 05:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730956880;
	bh=LcTJNuAS+0u64bln2s0a89deCwW+g5Nrojs1Slddt/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqZ6urMldxlvEBhdUM/g9ay6JBw8MxGPCgUReHarZ5Rrrup6qtaAMbkDd8Ut3yIvJ
	 TB3aWEUF8ij6xyiKo01mFPXSemUmYSpWT2Gfca8HAeh7vk2NMp5wXiqsR3jTvujmXl
	 Vml1yQf1y5lU0zvuowqmi415BENx3kOsFR8a5uB8=
Date: Thu, 7 Nov 2024 06:21:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 02/10] sysfs: introduce callback
 attribute_group::bin_size
Message-ID: <2024110726-hasty-obsolete-3780@gregkh>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
 <20241103-sysfs-const-bin_attr-v2-2-71110628844c@weissschuh.net>
 <20241106200513.GB174958@rocinante>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106200513.GB174958@rocinante>

On Thu, Nov 07, 2024 at 05:05:13AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > Several drivers need to dynamically calculate the size of an binary
> > attribute. Currently this is done by assigning attr->size from the
> > is_bin_visible() callback.
> > 
> > This has drawbacks:
> > * It is not documented.
> > * A single attribute can be instantiated multiple times, overwriting the
> >   shared size field.
> > * It prevents the structure to be moved to read-only memory.
> > 
> > Introduce a new dedicated callback to calculate the size of the
> > attribute.
> 
> Would it be possible to have a helper that when run against a specific
> kobject reference, then it would refresh or re-run the size callbacks?
> 
> We have an use case where we resize BARs on demand via sysfs, and currently
> the only way to update the size of each resource sysfs object is to remove
> and added them again, which is a bit crude, and can also be unsafe.

How is it unsafe?

> Hence the question.
> 
> There exist the sysfs_update_groups(), but the BAR resource sysfs objects
> are currently, at least not yet, added to any attribute group.

then maybe they should be added to one :)

thanks,

greg k-h

