Return-Path: <linux-hyperv+bounces-5862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE6AD5417
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 13:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F05E1899435
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F5242D99;
	Wed, 11 Jun 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tD8xfmPi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D92E611B;
	Wed, 11 Jun 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641741; cv=none; b=OVjr0vvFaHlTtHAe2NVm/ZyD74/3sV53FCnHEnZec6ORbq80QCMJ2G5ljjPAZaupED9YoGiVe3U7Y6V+0ab9jTN/D9/avtTTKZ20MhXPweB0kFjNbbwZGSWUMHgZVWA5cZH+owGymHJmDglgIUCoVRixstvrBx2eTIdhomppguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641741; c=relaxed/simple;
	bh=gdzkfF2i2Tltnxp3wCW3EYmYB3Ip+td0r7l4VMxs5ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGyPs9UN46sbz1shp7JDfnZhtTnNkHwL0jq2ah9FbFO5dORCpt8rm40uWpzPOe8oVQJ49B3XHvH+Dw2NTanuCGXexG80wMAQJOG4RwAAUfQEQh1b0tQw6npY4kQMfNuzzRLRKFXAPGY9vytlyCtjcvrDlYEy83J5J5fjWBGW1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tD8xfmPi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 679F52115190; Wed, 11 Jun 2025 04:35:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 679F52115190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749641739;
	bh=yTM0EgThVZQxa2c0e+/uF2mVqguQ/f7u3RX7IVxP8Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tD8xfmPinXTIogxftAkkmwRRNqSWjiDqnrdFyJPG4ZhaaaXpwiPD/YjxcBDDUVZzx
	 7gi5WUQDUWJZQ1TI/94+3m6IkjT/I2JXb+8RycBqK7POrXWUBipwXeNFCxjqt4OZUo
	 4Hk0koikSo3CIk3lciY1GvcNO/DZNErd2CK+Qek8=
Date: Wed, 11 Jun 2025 04:35:39 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kotaranov@microsoft.com, longli@microsoft.com, horms@kernel.org,
	shirazsaleem@microsoft.com, leon@kernel.org,
	shradhagupta@linux.microsoft.com, schakrabarti@linux.microsoft.com,
	rosenp@gmail.com, sdf@fomichev.me, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: mana: Handle unsupported HWC commands
Message-ID: <20250611113539.GB4690@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
 <1749631576-2517-5-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749631576-2517-5-git-send-email-ernis@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 11, 2025 at 01:46:16AM -0700, Erni Sri Satya Vennela wrote:
> If any of the HWC commands are not recognized by the
> underlying hardware, the hardware returns the response
> header status of -1. Log the information using
> netdev_info_once to avoid multiple error logs in dmesg.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/hw_channel.c |  4 ++++
>  drivers/net/ethernet/microsoft/mana/mana_en.c    | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index a8c4d8db75a5..70c3b57b1e75 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -890,6 +890,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	}
>  
>  	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
> +		if (ctx->status_code == -1) {
Minor comment: instead of == -1 could use some macro like GDMA_STATUS_CMD_UNSUPPORTED, rest LGTM.

> +			err = -EOPNOTSUPP;
> +			goto out;
> +		}
>  		dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
>  			ctx->status_code);
>  		err = -EPROTO;
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d5644400e71f..10e766c73fca 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -847,6 +847,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
>  	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
>  				   out_buf);
>  	if (err || resp->status) {
> +		if (err == -EOPNOTSUPP)
> +			return err;
> +
>  		dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
>  			err, resp->status);
>  		return err ? err : -EPROTO;
> @@ -1251,6 +1254,10 @@ int mana_query_link_cfg(struct mana_port_context *apc)
>  				sizeof(resp));
>  
>  	if (err) {
> +		if (err == -EOPNOTSUPP) {
> +			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
> +			return err;
> +		}
>  		netdev_err(ndev, "Failed to query link config: %d\n", err);
>  		return err;
>  	}
> @@ -1293,6 +1300,10 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
>  				sizeof(resp));
>  
>  	if (err) {
> +		if (err == -EOPNOTSUPP) {
> +			netdev_info_once(ndev, "MANA_SET_BW_CLAMP not supported\n");
> +			return err;
> +		}
>  		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u, err = %d",
>  			   speed, err);
>  		return err;
> -- 
> 2.34.1
>

Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

