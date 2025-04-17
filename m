Return-Path: <linux-hyperv+bounces-4964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB750A92BEB
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 21:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA837AEC98
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E69204C2F;
	Thu, 17 Apr 2025 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Th1gFQW4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F4204879;
	Thu, 17 Apr 2025 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919103; cv=none; b=WYgMTVY+MWvl29rAoKtA5atIU57W2QCs5aVnBgR17A5iNd5yMY+Mn/CMQo7yuUkJopB+rkZQ0JOEcZdvQb/vFzB9/WxcIIZMKnaW7OE0zcy9AWlcG6hiFhIxOaBzoBy/XuQhmbrzG5epnC+buGyUKWIB0M4l0sIN3jShOvZglhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919103; c=relaxed/simple;
	bh=FxUZyivBdVS2oSK3H4VoSVL5wuRT3fWrY3NbttPNQQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVcF0fN6m1kHbsAMwIQAHkayintiRanHRakSmqUoB72iF8dtEFjynYGuCr1UrDaZ5HKwU9RYxEuY2Ouu+/0xBTBDYE5XAFX8rM550ZJZ8Vh2YepYyT1u/QXxre/pB5CDiOKGgtijvFtQveHA2Oc6CsUY9WwXMMo0v2eQQu3EVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Th1gFQW4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2E34D20BCAD1; Thu, 17 Apr 2025 12:44:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E34D20BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744919096;
	bh=vLe6OeCxggQNm3o2MQZoR4n2oTMye2yNJP2beKF7Zvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th1gFQW47n6EuMZzL/mopyZIZytQ1LGMVazI12IqEoU1jrqOc59ydvb9FjDOSChwb
	 qgniW4eOzYaTvkA8wMu/4na8Ga1IBTxybx5nA8QzhFamt7EWA1H04k2uRL6vfJuO9w
	 DNgLeLNxnHiZ3pM8myUWXLx7GfkWd2HgJ22DH2ZA=
Date: Thu, 17 Apr 2025 12:44:56 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	kent.overstreet@linux.dev, brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, rosenp@gmail.com,
	paulros@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/3] net: mana: Add speed support in
 mana_get_link_ksettings
Message-ID: <20250417194456.GA10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
 <1744876630-26918-2-git-send-email-ernis@linux.microsoft.com>
 <b1e513f8-2e0d-4b09-aa10-02b7b593d3c9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e513f8-2e0d-4b09-aa10-02b7b593d3c9@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 17, 2025 at 03:38:26PM +0200, Zhu Yanjun wrote:
> On 17.04.25 09:57, Erni Sri Satya Vennela wrote:
> >Add support for speed in mana ethtool get_link_ksettings
> >operation. This feature is not supported by all hardware.
> >
> >Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> >Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> >Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> >---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 42 +++++++++++++++++++
> >  .../ethernet/microsoft/mana/mana_ethtool.c    |  6 +++
> >  include/net/mana/mana.h                       | 17 ++++++++
> >  3 files changed, 65 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >index 2bac6be8f6a0..ba550fc7ece0 100644
> >--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> >+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >@@ -1156,6 +1156,48 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
> >  	return err;
> >  }
> >+int mana_query_link_cfg(struct mana_port_context *apc)
> >+{
> >+	struct net_device *ndev = apc->ndev;
> >+	struct mana_query_link_config_resp resp = {};
> >+	struct mana_query_link_config_req req = {};
> >+	int err;
> >+
> >+	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> >+			     sizeof(req), sizeof(resp));
> >+
> >+	req.vport = apc->port_handle;
> >+
> >+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> >+				sizeof(resp));
> >+
> >+	if (err) {
> >+		netdev_err(ndev, "Failed to query link config: %d\n", err);
> >+		goto out;
> >+	}
> >+
> >+	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> >+				   sizeof(resp));
> >+
> >+	if (err || resp.hdr.status) {
> >+		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> >+			   resp.hdr.status);
> >+		if (!err)
> >+			err = -EPROTO;
> 
> EPROTO means Protocol error. Thus, ENOTSUPP or EPROTONOSUPPORT is better?
> 
> Zhu Yanjun
Thank you for the suggestion, Zhu Yanjun. I will also make this change
in mana_set_bw_clamp(). This update will be included in the next version
of the patch.
> 
> >+		goto out;
> >+	}
> >+
> >+	if (resp.qos_unconfigured) {
> >+		err = -EINVAL;
> >+		goto out;
> >+	}
> >+	apc->speed = resp.link_speed_mbps;
> >+	return 0;
> >+
> >+out:
> >+	return err;
> >+}
> >+

