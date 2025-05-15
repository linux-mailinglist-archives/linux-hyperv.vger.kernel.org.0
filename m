Return-Path: <linux-hyperv+bounces-5525-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B3FAB842D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15951BA28DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7CF297B88;
	Thu, 15 May 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keshLTyi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADD1CAA98;
	Thu, 15 May 2025 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305636; cv=none; b=gVXkJQ6RB0NkplEE7PyhXYOG3STcB45MEqCUnTkCYmg0bl3VqRGI/R0aQaqW7saOFPazyig1xuguK8vgyepQRZhYg2lBN22HnvCvBGCbvucMT6z/QI5bcQQ5BwrJqMN2sZfmAo3mC7QJjXahr2tqqI5EHZYdpBFFNgqHAxx1RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305636; c=relaxed/simple;
	bh=C7BeG1l8PBNf2eJXA3PIC6BMI5imJHZFw1LpZu9SI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI0N0GpLxSCOlN1E3EEU9AoNv383mwUiM+YUMC5rB0tWkyZUbowVILzxuflvpxcIVIIOzsbNzOyMK1PO7djCuEDtKKQq6+jVnGXt21OHgJ5QDzIx+j+alayKdU3ChdlQzIF72IUobeu3DW7ch9kK/UoYBCk+876lFVED2kJ8w2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keshLTyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FAAC4CEE7;
	Thu, 15 May 2025 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747305634;
	bh=C7BeG1l8PBNf2eJXA3PIC6BMI5imJHZFw1LpZu9SI4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keshLTyiFMWJLwrK5XlQdStpo7/2rsDOuzqXdPMMKExvjpJCjmJSmu+hFzuT+am7u
	 QbZrD2UKeNs9RXn4d9T+bWqlACMcifE86fz7RaZP1mewTqKkLVCRAHW9/W1u+NLlq3
	 dQbqlEwlNS0tN/sCTH8uHGfD5OTTK7dN6xHVuykmwZX0g6L2oJfjecKJWGglzf3KCM
	 HUNOXYDM+mUY+sQhxuHKTQ4wC13OtB9LnwsO+no9D2eMlgexPz+0ZjoTnGkpj0EDL/
	 KK4/7Bga2Ip59ZGcspTDakK3W7W2DZONRYL4EoutUbh6DsxKLRUmYOQEl+RTJkPT52
	 USKpbq4sYY/dw==
Date: Thu, 15 May 2025 11:40:28 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/5] hv_netvsc: Preserve contiguous PFN grouping in
 the page buffer array
Message-ID: <20250515104028.GQ3339421@horms.kernel.org>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-4-mhklinux@outlook.com>
 <20250514093435.GE3339421@horms.kernel.org>
 <SN6PR02MB41573F3B4A06DA86758F59F0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573F3B4A06DA86758F59F0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, May 14, 2025 at 03:42:19PM +0000, Michael Kelley wrote:
> From: Simon Horman <horms@kernel.org> Sent: Wednesday, May 14, 2025 2:35 AM
> > 
> > On Mon, May 12, 2025 at 05:06:02PM -0700, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>

...

> > >  	for (i = 0; i < frags; i++) {
> > >  		skb_frag_t *frag = skb_shinfo(skb)->frags + i;
> > > +		struct hv_page_buffer *cur_pb = &pb[i + 2];
> > 
> > Hi Michael,
> > 
> > If I got things right then then pb is allocated on the stack
> > in netvsc_xmit and has MAX_DATA_RANGES elements.
> 
> Correct.
> 
> > 
> > If MAX_SKB_FRAGS is largs and MAX_DATA_RANGES has been limited to
> > MAX_DATA_RANGES. And frags is large. Is is possible to overrun pb here?
> 
> I don't think it's possible. Near the top of netvsc_xmit() there's a call
> to netvsc_get_slots(), along with code ensuring that all the data in the skb
> (and its frags) exists on no more than MAX_PAGE_BUFFER_COUNT (i.e., 32)
> pages. There can't be more frags than pages, so it should not be possible to
> overrun the pb array even if the frag count is large.
> 
> If the kernel is built with CONFIG_MAX_SKB_FRAGS greater than 30, and
> there are more than 30 frags in the skb (allowing for 2 pages for the rndis
> header), netvsc_xmit() tries to linearize the skb to reduce the frag count.
> But if that doesn't work, netvsc_xmit() drops the xmit request, which isn't
> a great outcome. But that's a limitation of the existing code, and this patch
> set doesn't change that limitation.

Hi Michael,

Thanks for addressing my concern. I do now see that the check
in netvsc_xmit() prevents an overrun.

And I agree that while not ideal dropping oversize packets is not
strictly related to this patch-set (and is indeed much better than
an overrun).

With the above in mind I'm now happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

...

