Return-Path: <linux-hyperv+bounces-5503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED70AB67A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197847B25B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421622ACDC;
	Wed, 14 May 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOUn/DAB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE001FF60E;
	Wed, 14 May 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215281; cv=none; b=VDvpM1jXfeXCJDXeAza2nZ8hc9SopiLIa2M5LZhy0kH6XgIeTOONdM78Cq6quLS5PxwtTu+c/Qm6VSnAJ30Cvo3tBQzrHLE56Vs3nZI+2Bf75TXTSnop4V5YUgiJYwmDUUT+3KRyMNx4WgsYy5zbfqbMqZ2MaqHwgZuxykiW3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215281; c=relaxed/simple;
	bh=76DmbZWeHf5F1d6ZdFu0GgcKR3qOGvu+eyBU73UMhCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBOLlfB9M7Pjd/CEFgMcmO7QDXI7ELS+N14a7NtClU7oUAPZ/8KNo1Q41tUwpXpItF9Ry4hlmbrNpB3wr5eI/Fi2nch7b8Ppf81VqIWL9im1YAkyw9Mvf9AkdPStAnHWZVoSEeKcPhbANleli2J/UIzEl2C3rfdsTd7wuKykb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOUn/DAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4F8C4CEF0;
	Wed, 14 May 2025 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747215281;
	bh=76DmbZWeHf5F1d6ZdFu0GgcKR3qOGvu+eyBU73UMhCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOUn/DABAMjd2CdcoRfDRG/WPQvtOrGI0L3IVxc81EAtnCGZnXrTBOsNaRAIxMbW3
	 CzvYACKlP7tOhEeU5h7u4hde0Lv8/yX67eFjs1jcoVuwr8VUPDjZcA2aOLXmY1Ib0m
	 d1bRjsvfEEs4EKWdLALXLtD1C7QvQduFIdc0mmC2rNdM1tT23NeDDEIS5+4ZEuQyCi
	 GQsvgKy08bRQSz3mHIM82bVEGQ35T9XlVXl1Drk50X2WRrscT06liNw8T0VNmONuNM
	 X7U32AOdfmOYU7poa78Ar3lshY73sDETDaLzsxD56At5QQ2STo7XvhbcAnlVeOj/vo
	 KyP6EJvS5q1dQ==
Date: Wed, 14 May 2025 10:34:35 +0100
From: Simon Horman <horms@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/5] hv_netvsc: Preserve contiguous PFN grouping in
 the page buffer array
Message-ID: <20250514093435.GE3339421@horms.kernel.org>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-4-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513000604.1396-4-mhklinux@outlook.com>

On Mon, May 12, 2025 at 05:06:02PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Starting with commit dca5161f9bd0 ("hv_netvsc: Check status in
> SEND_RNDIS_PKT completion message") in the 6.3 kernel, the Linux
> driver for Hyper-V synthetic networking (netvsc) occasionally reports
> "nvsp_rndis_pkt_complete error status: 2".[1] This error indicates
> that Hyper-V has rejected a network packet transmit request from the
> guest, and the outgoing network packet is dropped. Higher level
> network protocols presumably recover and resend the packet so there is
> no functional error, but performance is slightly impacted. Commit
> dca5161f9bd0 is not the cause of the error -- it only added reporting
> of an error that was already happening without any notice. The error
> has presumably been present since the netvsc driver was originally
> introduced into Linux.
> 
> The root cause of the problem is that the netvsc driver in Linux may
> send an incorrectly formatted VMBus message to Hyper-V when
> transmitting the network packet. The incorrect formatting occurs when
> the rndis header of the VMBus message crosses a page boundary due to
> how the Linux skb head memory is aligned. In such a case, two PFNs are
> required to describe the location of the rndis header, even though
> they are contiguous in guest physical address (GPA) space. Hyper-V
> requires that two rndis header PFNs be in a single "GPA range" data
> struture, but current netvsc code puts each PFN in its own GPA range,
> which Hyper-V rejects as an error.
> 
> The incorrect formatting occurs only for larger packets that netvsc
> must transmit via a VMBus "GPA Direct" message. There's no problem
> when netvsc transmits a smaller packet by copying it into a pre-
> allocated send buffer slot because the pre-allocated slots don't have
> page crossing issues.
> 
> After commit 14ad6ed30a10 ("net: allow small head cache usage with
> large MAX_SKB_FRAGS values") in the 6.14-rc4 kernel, the error occurs
> much more frequently in VMs with 16 or more vCPUs. It may occur every
> few seconds, or even more frequently, in an ssh session that outputs a
> lot of text. Commit 14ad6ed30a10 subtly changes how skb head memory is
> allocated, making it much more likely that the rndis header will cross
> a page boundary when the vCPU count is 16 or more. The changes in
> commit 14ad6ed30a10 are perfectly valid -- they just had the side
> effect of making the netvsc bug more prominent.
> 
> Current code in init_page_array() creates a separate page buffer array
> entry for each PFN required to identify the data to be transmitted.
> Contiguous PFNs get separate entries in the page buffer array, and any
> information about contiguity is lost.
> 
> Fix the core issue by having init_page_array() construct the page
> buffer array to represent contiguous ranges rather than individual
> pages. When these ranges are subsequently passed to
> netvsc_build_mpb_array(), it can build GPA ranges that contain
> multiple PFNs, as required to avoid the error "nvsp_rndis_pkt_complete
> error status: 2". If instead the network packet is sent by copying
> into a pre-allocated send buffer slot, the copy proceeds using the
> contiguous ranges rather than individual pages, but the result of the
> copying is the same. Also fix rndis_filter_send_request() to construct
> a contiguous range, since it has its own page buffer array.
> 
> This change has a side benefit in CoCo VMs in that netvsc_dma_map()
> calls dma_map_single() on each contiguous range instead of on each
> page. This results in fewer calls to dma_map_single() but on larger
> chunks of memory, which should reduce contention on the swiotlb.
> 
> Since the page buffer array now contains one entry for each contiguous
> range instead of for each individual page, the number of entries in
> the array can be reduced, saving 208 bytes of stack space in
> netvsc_xmit() when MAX_SKG_FRAGS has the default value of 17.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217503
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217503
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/net/hyperv/hyperv_net.h   | 12 ++++++
>  drivers/net/hyperv/netvsc_drv.c   | 63 ++++++++-----------------------
>  drivers/net/hyperv/rndis_filter.c | 24 +++---------
>  3 files changed, 32 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index 70f7cb383228..76725f25abd5 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -893,6 +893,18 @@ struct nvsp_message {
>  				 sizeof(struct nvsp_message))
>  #define NETVSC_MIN_IN_MSG_SIZE sizeof(struct vmpacket_descriptor)
>  
> +/* Maximum # of contiguous data ranges that can make up a trasmitted packet.
> + * Typically it's the max SKB fragments plus 2 for the rndis packet and the
> + * linear portion of the SKB. But if MAX_SKB_FRAGS is large, the value may
> + * need to be limited to MAX_PAGE_BUFFER_COUNT, which is the max # of entries
> + * in a GPA direct packet sent to netvsp over VMBus.
> + */
> +#if MAX_SKB_FRAGS + 2 < MAX_PAGE_BUFFER_COUNT
> +#define MAX_DATA_RANGES (MAX_SKB_FRAGS + 2)
> +#else
> +#define MAX_DATA_RANGES MAX_PAGE_BUFFER_COUNT
> +#endif
> +
>  /* Estimated requestor size:
>   * out_ring_size/min_out_msg_size + in_ring_size/min_in_msg_size
>   */

...

> @@ -371,28 +338,28 @@ static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
>  	 * 2. skb linear data
>  	 * 3. skb fragment data
>  	 */
> -	slots_used += fill_pg_buf(virt_to_hvpfn(hdr),
> -				  offset_in_hvpage(hdr),
> -				  len,
> -				  &pb[slots_used]);
>  
> +	pb[0].offset = offset_in_hvpage(hdr);
> +	pb[0].len = len;
> +	pb[0].pfn = virt_to_hvpfn(hdr);
>  	packet->rmsg_size = len;
> -	packet->rmsg_pgcnt = slots_used;
> +	packet->rmsg_pgcnt = 1;
>  
> -	slots_used += fill_pg_buf(virt_to_hvpfn(data),
> -				  offset_in_hvpage(data),
> -				  skb_headlen(skb),
> -				  &pb[slots_used]);
> +	pb[1].offset = offset_in_hvpage(skb->data);
> +	pb[1].len = skb_headlen(skb);
> +	pb[1].pfn = virt_to_hvpfn(skb->data);
>  
>  	for (i = 0; i < frags; i++) {
>  		skb_frag_t *frag = skb_shinfo(skb)->frags + i;
> +		struct hv_page_buffer *cur_pb = &pb[i + 2];

Hi Michael,

If I got things right then then pb is allocated on the stack
in netvsc_xmit and has MAX_DATA_RANGES elements.

If MAX_SKB_FRAGS is largs and MAX_DATA_RANGES has been limited to
MAX_DATA_RANGES. And frags is large. Is is possible to overrun pb here?

> +		u64 pfn = page_to_hvpfn(skb_frag_page(frag));
> +		u32 offset = skb_frag_off(frag);
>  
> -		slots_used += fill_pg_buf(page_to_hvpfn(skb_frag_page(frag)),
> -					  skb_frag_off(frag),
> -					  skb_frag_size(frag),
> -					  &pb[slots_used]);
> +		cur_pb->offset = offset_in_hvpage(offset);
> +		cur_pb->len = skb_frag_size(frag);
> +		cur_pb->pfn = pfn + (offset >> HV_HYP_PAGE_SHIFT);
>  	}
> -	return slots_used;
> +	return frags + 2;
>  }
>  
>  static int count_skb_frag_slots(struct sk_buff *skb)
> @@ -483,7 +450,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
>  	struct net_device *vf_netdev;
>  	u32 rndis_msg_size;
>  	u32 hash;
> -	struct hv_page_buffer pb[MAX_PAGE_BUFFER_COUNT];
> +	struct hv_page_buffer pb[MAX_DATA_RANGES];
>  
>  	/* If VF is present and up then redirect packets to it.
>  	 * Skip the VF if it is marked down or has no carrier.

...

