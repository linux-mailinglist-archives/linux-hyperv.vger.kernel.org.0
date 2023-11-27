Return-Path: <linux-hyperv+bounces-1054-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DB7F9A71
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 07:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D82B2080E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB129DDC6;
	Mon, 27 Nov 2023 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2B13D;
	Sun, 26 Nov 2023 22:59:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 968A268AFE; Mon, 27 Nov 2023 07:59:28 +0100 (CET)
Date: Mon, 27 Nov 2023 07:59:28 +0100
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Merging raw block device writes
Message-ID: <20231127065928.GA27811@lst.de>
References: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 25, 2023 at 05:38:28PM +0000, Michael Kelley wrote:
> Hyper-V guests and the Azure cloud have a particular interest here
> because Hyper-V guests uses SCSI as the standard interface to virtual
> disks.  Azure cloud disks can be throttled to a limited number of IOPS,
> so the number of in-flights I/Os can be relatively high, and
> merging can be beneficial to staying within the throttle
> limits.  Of the flip side, this problem hasn't generated complaints
> over the last 18 months that I'm aware of, though that may be more
> because commercial distros haven't been running 5.16 or later kernels
> until relatively recently.

I think the more important thing is that if you care about reducing
the number of I/Os you probably should use an I/O scheduler.  Reducing
the number of I/Os without an I/O scheduler isn't (and I'll argue
shouldn't) be a concern for the non I/O scheduler.


