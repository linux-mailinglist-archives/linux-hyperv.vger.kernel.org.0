Return-Path: <linux-hyperv+bounces-2852-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702295DCDE
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 10:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954021C221A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 08:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539E1552FC;
	Sat, 24 Aug 2024 08:05:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448822C6A3;
	Sat, 24 Aug 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486730; cv=none; b=pWyJ/md+NVD/ak/a/4JpQeZAEVcXR4puqTRatGzWK465ILSRST3Q0AQ7LiUtwILxfgn4heUtrGvzCHZamjWlOn6mJPArwxexH2AbZH+2p5mT8em8xIZB7w1724zx8Esw0sKSs+ZRXH4oNqHkd34/N6Ub/t+56/TQ2Jw+ucxQOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486730; c=relaxed/simple;
	bh=M/BIBnLEhY/rZYFAJjMpvfFC+TI9s3HFHcqI3QGQvGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te+xWNYJvdfRlaXXpSJR/kBvXjajxQI5G0IY8uP+b4eWCaTnSKuGGJ2DkmuHbd9/rxcz27dEieYkacq7TlMwtR8qffKWM4bNLXK5Ft9P3QhzeSenB3g0GbhJvamGlt2UOKz7QU/IIzA5xI25HHIDGf93abKXIhoMJbRs/iFDPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28730227A88; Sat, 24 Aug 2024 10:05:15 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:05:14 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240824080514.GA8527@lst.de>
References: <20240822183718.1234-1-mhklinux@outlook.com> <f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org> <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 23, 2024 at 02:20:41AM +0000, Michael Kelley wrote:
> Christoph Hellwig, or anyone else who knows the history and current
> reality better than I do, please jump in. :-)

It's not just interrupt context, but any context that does not allow
blocking.  There is plenty of that as seen by the moving of nvme
to specifically request a blocking context for I/O submission in this
path.

That being said there are probably more contexts that can block than
those that can't, so allowing for that option is a good thing.

