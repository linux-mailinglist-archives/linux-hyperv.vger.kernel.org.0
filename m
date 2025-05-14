Return-Path: <linux-hyperv+bounces-5504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800BAB67B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E9D1B65D47
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62322CBC1;
	Wed, 14 May 2025 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBYxh0W3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEB22ACCE;
	Wed, 14 May 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215477; cv=none; b=YSPiGqLT6OzUx8NWPDStDgKdnH43pehOZqC9q7CMwQ2tblHfah6Sx/wiyzzqkE1ZocnkptpE+mYivvpo5XJN7kgqoNGDhsY2/nzIexLR+/rcdOS/idDvAxYi97bOJPd21AMIXYX+4DuVRxd6+ykUZfrTKsg91JK6pL0HvY4EGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215477; c=relaxed/simple;
	bh=NurdwnwGbSV9JUS/xzW5xcSfhaak9b3QqCAV7BzFooA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgQvUFNWaIknILT3HxuLtcnu3ILxmaGjPOpKs5MeRHoxan4gp3da0GmzLW4whyPLHAEd13aFd2/0LVCDngW17Zxz2sM3zxBQRm98xmhWa/KCEwfL8IyfelB7vX+cSJ7XKcbESsDpJ+jyAf1EOb7AZNZQ6vT1BAFX5rK7ccAQLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBYxh0W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D65DC4CEEB;
	Wed, 14 May 2025 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747215476;
	bh=NurdwnwGbSV9JUS/xzW5xcSfhaak9b3QqCAV7BzFooA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBYxh0W3tiCiq6Ri/9ZWOL4LFwslxGL8iDU9kKOrVza7U2egvvwsWSjfZWtRhBKED
	 FeuiIqGeiawtU/chMWX+08IyuhK++0NZwI3O7MjcVwqr897AnF6Wcvpx3Hl1BUZ/9R
	 h2U7T8YKt8C+WqrpqxAbRA+LM1ls9BXOf+fy8dS0nEV7XM8VMREff6m9gypZraKL/M
	 /UTXYGUwa3sKzXofDq74PbH+7ZUlQrlYVZVYjJUXOASDGVXvnm+k8BU0TuCiT45UWx
	 tT85cjVrBLNx4n3EhKiRCyFRykqQ6rFY44JxUiy0tqbgjOdItiSugScA/JFqPMxISb
	 K1EDDzvY81d8A==
Date: Wed, 14 May 2025 10:37:51 +0100
From: Simon Horman <horms@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/5] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to
 send VMBus messages
Message-ID: <20250514093751.GF3339421@horms.kernel.org>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-3-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513000604.1396-3-mhklinux@outlook.com>

On Mon, May 12, 2025 at 05:06:01PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> netvsc currently uses vmbus_sendpacket_pagebuffer() to send VMBus
> messages. This function creates a series of GPA ranges, each of which
> contains a single PFN. However, if the rndis header in the VMBus
> message crosses a page boundary, the netvsc protocol with the host
> requires that both PFNs for the rndis header must be in a single "GPA
> range" data structure, which isn't possible with
> vmbus_sendpacket_pagebuffer(). As the first step in fixing this, add a
> new function netvsc_build_mpb_array() to build a VMBus message with
> multiple GPA ranges, each of which may contain multiple PFNs. Use
> vmbus_sendpacket_mpb_desc() to send this VMBus message to the host.
> 
> There's no functional change since higher levels of netvsc don't
> maintain or propagate knowledge of contiguous PFNs. Based on its
> input, netvsc_build_mpb_array() still produces a separate GPA range
> for each PFN and the behavior is the same as with
> vmbus_sendpacket_pagebuffer(). But the groundwork is laid for a
> subsequent patch to provide the necessary grouping.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/net/hyperv/netvsc.c | 50 +++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index d6f5b9ea3109..6d1705f87682 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -1055,6 +1055,42 @@ static int netvsc_dma_map(struct hv_device *hv_dev,
>  	return 0;
>  }
>  
> +/* Build an "array" of mpb entries describing the data to be transferred
> + * over VMBus. After the desc header fields, each "array" entry is variable
> + * size, and each entry starts after the end of the previous entry. The
> + * "offset" and "len" fields for each entry imply the size of the entry.
> + *
> + * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hyper-V
> + * uses that granularity, even if the system page size of the guest is larger.
> + * Each entry in the input "pb" array must describe a contiguous range of
> + * guest physical memory so that the pfns are sequential if the range crosses
> + * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.

Hi Michael,

Is there a guarantee that this constraint is met. And moreover, is there a
guarantee that all of the entries will fit in desc? I am slightly concerned
that there may be an overrun lurking here.

...

