Return-Path: <linux-hyperv+bounces-8950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBJ+MqpenGkUFQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8950-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 15:05:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF489177B6E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 15:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3783D3000A2F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05049279334;
	Mon, 23 Feb 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dR1kWave"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03426A0B9;
	Mon, 23 Feb 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855289; cv=none; b=IU+f5FlcA4/gRm0JSxQwVc3goGoV7OLdRKH3FEVSsDotNfo7weIoH0UbtLogZyff46WBpeq9k87ZqSjXeZSQ77yLlSyJjymgVcfzhVfc4+pZ6j3Tl2Z1M/+TJ1DPCumAhdJ64PxAv3LWWiPTj+B6B3os6daClcri3yNqQfUEf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855289; c=relaxed/simple;
	bh=XUY21FuMSKmjH9no37t97xDUClgPkt8GSLIbeRnj1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe+OrSnLJ26srT3o55E/kgyeXhCCBd/Vtr4toBOI2vEddNfMxueJ3DthUuPpx++GvwWqujJ+hSngDetonPnDPijVIbHRGvD0SNLkhP1crqmR4K94fcK94nO/k7z53N6Pzfa/ghh9JZGthohgZxOJs19zp/kQQjBWKob0zUAzrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dR1kWave; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KcaaE3LpE+ovUHUhrkXgidu+ShMuBdBbTFEmpE5F3Z8=; b=dR1kWaveG/58vzDduCUVL6/iRy
	IMCNsb8X2jaHAdR6CcU+flvXE4K/b3S90+mAmrdSqJWc1P15idRYoeGv8kIZjQ9QJx9EA2hT7nn3r
	n1AiAGs722yvTlCIsRaupH2TBbtm2aiikwS4nzAhnHSylbe2usBVrPJPJKVxo9QJLnqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuWUY-008Sz2-HQ; Mon, 23 Feb 2026 15:00:54 +0100
Date: Mon, 23 Feb 2026 15:00:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	haiyangz@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH net-next] net: ethtool: add COALESCE_RX_CQE_FRAMES/NSECS
 parameters
Message-ID: <6bf21536-569b-49b4-9541-c22a152570fd@lunn.ch>
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8950-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev,microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF489177B6E
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 01:23:17PM -0800, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add two parameters for drivers supporting Rx CQE Coalescing.
> 
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE.
> 
> ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> Time out value in nanoseconds after the first packet arrival in a
> coalesced CQE to be sent.

A new API needs a user. A kAPI especially needs a user. Please add
support to at least one driver.

    Andrew

---
pw-bot: cr

