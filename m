Return-Path: <linux-hyperv+bounces-5526-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D54AB8450
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BE69E45EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1571297B81;
	Thu, 15 May 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/WWEWg9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3B2101AE;
	Thu, 15 May 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306239; cv=none; b=U7i1J8l1nzF4WdqLXH1XwOVcubcASGA0v1S8LRYw6l34dMjPV7VldnAevEWYOJK7MxQC3RjJyCfGFWGSv+62M0paaelEyd7MbofODskyTfUgBs5d0myiWkvqRnMPQOFzmk1Sj59V+99i4Ft5+/798Ey9o9JvqKAgR5Scrv+4O8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306239; c=relaxed/simple;
	bh=wT+u7zaXSan0nDn3kznsFYtD2+9D/7UMrhifMQAMXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d16Q381lO5AmcNVpSY5nr4YaKHMqUK72i399Z5Pml6ZtPJmkF4uzK7K5t/NyFqQOTVYDtmP4bEmVfS9OKiXiKTp53u1sF5aK5JPRke1skwKGoSg32EB+mXpOo/j5pzSqG7EARSChaKYoULgEKL5Ckxu+nJGIYiuwoOYL6zceuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/WWEWg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E4DC4CEED;
	Thu, 15 May 2025 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747306239;
	bh=wT+u7zaXSan0nDn3kznsFYtD2+9D/7UMrhifMQAMXoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/WWEWg9UqxrG4dLl6a9cMJc4KKG036GhZZ58EHkipbDPnK77JYFgmkr0kdiU9MRi
	 X/igkxjvUBwl1xl04pAKU9OlDiRnR55gwXmD8esvmhNLq0tXzmNbOF3zO444jXSX5d
	 l8ZbPt9HwBNIvb7zLIaPVZ5+FCuFf+AWqIoIUNPmXVcFOCBnkhxczulcduE3KaOCTF
	 ozolgJgDcEgzfjHjdkGwIgkxA8QQYF/+TejWC738WBLdMu/cf2HIHBS83ZeVne0/5/
	 KQgHXkgPnD+DmCtNzbG+0Axgo0aiMvpCjfUe5u3DcrmyjsGgz1pj5+6Vi26ePQI/X4
	 DMkFSyg0Ri/Rw==
Date: Thu, 15 May 2025 11:50:33 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 2/5] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to
 send VMBus messages
Message-ID: <20250515105033.GR3339421@horms.kernel.org>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-3-mhklinux@outlook.com>
 <20250514093751.GF3339421@horms.kernel.org>
 <SN6PR02MB4157C9EC51BEC1EBCB2B7DC5D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157C9EC51BEC1EBCB2B7DC5D491A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, May 14, 2025 at 03:44:35PM +0000, Michael Kelley wrote:
> From: Simon Horman <horms@kernel.org> Sent: Wednesday, May 14, 2025 2:38 AM
> > 
> > On Mon, May 12, 2025 at 05:06:01PM -0700, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > netvsc currently uses vmbus_sendpacket_pagebuffer() to send VMBus
> > > messages. This function creates a series of GPA ranges, each of which
> > > contains a single PFN. However, if the rndis header in the VMBus
> > > message crosses a page boundary, the netvsc protocol with the host
> > > requires that both PFNs for the rndis header must be in a single "GPA
> > > range" data structure, which isn't possible with
> > > vmbus_sendpacket_pagebuffer(). As the first step in fixing this, add a
> > > new function netvsc_build_mpb_array() to build a VMBus message with
> > > multiple GPA ranges, each of which may contain multiple PFNs. Use
> > > vmbus_sendpacket_mpb_desc() to send this VMBus message to the host.
> > >
> > > There's no functional change since higher levels of netvsc don't
> > > maintain or propagate knowledge of contiguous PFNs. Based on its
> > > input, netvsc_build_mpb_array() still produces a separate GPA range
> > > for each PFN and the behavior is the same as with
> > > vmbus_sendpacket_pagebuffer(). But the groundwork is laid for a
> > > subsequent patch to provide the necessary grouping.
> > >
> > > Cc: <stable@vger.kernel.org> # 6.1.x
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c | 50 +++++++++++++++++++++++++++++++++----
> > >  1 file changed, 45 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > > index d6f5b9ea3109..6d1705f87682 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -1055,6 +1055,42 @@ static int netvsc_dma_map(struct hv_device *hv_dev,
> > >  	return 0;
> > >  }
> > >
> > > +/* Build an "array" of mpb entries describing the data to be transferred
> > > + * over VMBus. After the desc header fields, each "array" entry is variable
> > > + * size, and each entry starts after the end of the previous entry. The
> > > + * "offset" and "len" fields for each entry imply the size of the entry.
> > > + *
> > > + * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hyper-V
> > > + * uses that granularity, even if the system page size of the guest is larger.
> > > + * Each entry in the input "pb" array must describe a contiguous range of
> > > + * guest physical memory so that the pfns are sequential if the range crosses
> > > + * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.
> > 
> > Hi Michael,
> > 
> > Is there a guarantee that this constraint is met. And moreover, is there a
> > guarantee that all of the entries will fit in desc? I am slightly concerned
> > that there may be an overrun lurking here.
> > 
> 
> It is indeed up to the caller to ensure that the pb array is properly
> constructed. netvsc_build_mpb_array() doesn't do additional validation.
> There are only two sources of the pb array, both of which do the right
> thing, so additional validation seemed redundant.
> 
> An overrun is a concern, but again the callers do the right thing. As
> described in my response to Patch 3 of the series, netvsc_xmit()
> counts the number of pages ahead of time, and makes sure the count is
> within the limit of the amount space allocated in the "desc" argument
> to netvsc_build_mpb_array().

Thanks Michael,

I agree that is entirely reasonable for callers to be responsible
correctly constructing the pb array. And that it's not necessary
to add validation to netvsc_build_mpb_array().

Also, based on the above, I'm satisfied that the callers are correctly
constructing the pb array.

With the above clarified in my mind I'm now happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

