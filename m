Return-Path: <linux-hyperv+bounces-9134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOXjA2JOqGlbtAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9134-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 16:23:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D410202935
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 16:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34FB312AACD
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190293BE159;
	Wed,  4 Mar 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dstx0aXq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2F3BE154;
	Wed,  4 Mar 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636305; cv=none; b=P2rMp2GTelFbXo/EErVGELVLCoKprKuzEAS3z0xAAcKJuhVEyoiFdSprGd3BQ2Hm62y2cuk1d/Ia3fIPj3wC6jUW42rPo48v0MKmEquWM6Hgm+4R6fBvmEFchssnDtNKKRBPFpo06DikOQMpaTf2P3GdtabgkKPRhP0TRmAMvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636305; c=relaxed/simple;
	bh=rII9J+C8rL3DLwgthbPiKKXig5D44fsZZam2ZJybaOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9t2IBC74UnQW/BQhoY3djmm1fYeJ9J64XVA9y1ysHi/KGWX2xoBJJfOCmYe750MMiXcup0vzstirYPhJlNlzUqPkNP1/4VE2JDk56y6IwELOkBjPIGroSvyGlhkumvQVI955o0qsInd/QDXQOpeYYIDgwfndOa0LylD3aOu/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dstx0aXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3ABC4CEF7;
	Wed,  4 Mar 2026 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636304;
	bh=rII9J+C8rL3DLwgthbPiKKXig5D44fsZZam2ZJybaOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dstx0aXqu9NGQnL0nJbFa7c1p9wi3Mtlr+DAOueHLuCVtuoeJZXKTyoAXYohLsIsp
	 2D64T6qemce3FeQivq0zDzV7aOx77IM697VnYDEF9Yi5/HOC3Qc8jBkrkXskzQZp0z
	 atWvJ1ojTKdV846WmlQT8CcgD9i/kOrvXE/FH+7eAtrIpf51Pd1aKzC/fnmEIGcVqN
	 NPd7cs1Ldj5XcCRMHnuCMqlLO/019stL30rVoLq6mG6KjZCdv3Pnq8zDcFa1UO8Zxg
	 vciN2rMVada4X2ISPAHAEvGckrLW4GkFnIV+AVY1F56BVa+EfYq2YDOQwYiKvxi7SJ
	 Z7AXPfs8IAzAQ==
Date: Wed, 4 Mar 2026 16:58:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/6] net: mana: Create separate EQs for each
 vPort
Message-ID: <20260304145820.GD12611@unreal>
References: <20260304000017.333312-1-longli@microsoft.com>
 <20260304000017.333312-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304000017.333312-2-longli@microsoft.com>
X-Rspamd-Queue-Id: 0D410202935
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9134-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 04:00:12PM -0800, Long Li wrote:
> To prepare for assigning vPorts to dedicated MSI-X vectors, remove EQ
> sharing among the vPorts and create dedicated EQs for each vPort.
> 
> Move the EQ definition from struct mana_context to struct mana_port_context
> and update related support functions. Export mana_create_eq() and
> mana_destroy_eq() for use by the MANA RDMA driver.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c             |  14 ++-
>  drivers/infiniband/hw/mana/qp.c               |   4 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 109 ++++++++++--------
>  include/net/mana/mana.h                       |   7 +-
>  4 files changed, 82 insertions(+), 52 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org> # drivers/infiniband

