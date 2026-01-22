Return-Path: <linux-hyperv+bounces-8454-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHjsNvoEcmmvZwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8454-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 12:07:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD465BA6
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 12:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 205153CB8B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B540F8D4;
	Thu, 22 Jan 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QgE+nUe0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD373B530E;
	Thu, 22 Jan 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078626; cv=none; b=mXDDpcD6Z2dqfmQzbiJWDcqDjXRnK+BUFRazDDjZeikQD7laQx6RQiohkQXXdZJgjuMmM6wLuypKAYMwjLTuauEjKsikIM/jalcOM2QQuK9mooVPwj+2b9ZM5SaIq1qEVBlsxGrcVdPMM81IOFbeTv3O0Tv4+AGmhfJJohZc/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078626; c=relaxed/simple;
	bh=alEohrBI/JLEbgcJb8e7wpbjle6K9L0/dTLOnLOjFeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcuZHUAS/gkqurtNM0yewW1aimYz8Vc4mncNnOKdjmkhuBBwq0GzetAg4fHLRrkgboLLwAsiM3o7UpLtdIpl4tN5jf9XTRqCsGdEs/acS92XqKHFrzzaXC5zBdPVtiwhJ/WhNLbUOTkvV48BMCdE7ZQrWuuuxEgBD9NtoYh6Rec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QgE+nUe0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2Ewrz6BGF+e8gQ4RD39fk9r4aqYPqkL5w/aREtx874=; b=QgE+nUe0PaFMs+CYRo+UlQO+zG
	HhJWWAoH2wuKWMOlxqs4VcBs0r2ujAwnn7/EgyPhkINNjutaGEJThdl5Sfrmk3/OnnUlvCAs696K1
	INZVlbVUxNuTpW/el7Yk2FkWPtfqKmEQdB+CQ4lJVq0DvownGjduoxiwXomU4N4KRz+Rm9S7JS6vd
	F+Mvp3XggKyQivsmwdoiLA1QFgs29wTHkgWMJsfYAyUCkwtRgoH3bw6xz3lhv1Kjf6oBYwBxiTHSa
	KI6QqU/FngK7MqlrTPtPDSsRQl1qZwCsvSCi1osXc071CrTvxyCeUPni7hJUTHIEaqgSTtgZz941L
	9X9Uh3gA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vis9q-00CxCu-Vq; Thu, 22 Jan 2026 10:43:23 +0000
Date: Thu, 22 Jan 2026 02:43:16 -0800
From: Breno Leitao <leitao@debian.org>
To: "Creeley, Brett" <bcreeley@amd.com>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Igor Russkikh <irusskikh@marvell.com>, 
	Simon Horman <horms@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	linux-net-drivers@amd.com
Subject: Re: [PATCH net-next 2/9] net: atlantic: convert to use
 .get_rx_ring_count
Message-ID: <aXH--MjkP03_aDkB@gmail.com>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
 <20260121-grxring_big_v4-v1-2-07655be56bcf@debian.org>
 <4daf0901-20a6-4c9b-9b56-32efef24e5e5@amd.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4daf0901-20a6-4c9b-9b56-32efef24e5e5@amd.com>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8454-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com,vger.kernel.org,corigine.com];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 87CD465BA6
X-Rspamd-Action: no action

Hello Brett,

On Wed, Jan 21, 2026 at 08:49:23AM -0800, Creeley, Brett wrote:
> On 1/21/2026 7:54 AM, Breno Leitao wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> > of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> > index 6fef47ba0a59b..d8b5491c9cb2b 100644
> > --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> > +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> > @@ -500,20 +500,22 @@ static int aq_ethtool_set_rss(struct net_device *netdev,
> >          return err;
> >   }
> > 
> > +static u32 aq_ethtool_get_rx_ring_count(struct net_device *ndev)
> > +{
> > +       struct aq_nic_s *aq_nic = netdev_priv(ndev);
> > +       struct aq_nic_cfg_s *cfg = aq_nic_get_cfg(aq_nic);
> > +
> > +       return cfg->vecs;
> > +}
> > +
> 
> Tiny nit, but RCT ordering is not maintained.

Damn, I will re-spin. Thanks for catching it.

--breno
--
pw-bot: cr

