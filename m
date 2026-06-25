Return-Path: <linux-hyperv+bounces-11669-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NlxVOL9bPWow1wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11669-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:47:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9AE6C78B2
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:47:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="L3fcd1+/";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11669-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11669-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3E3B3033E65
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0A3EB0ED;
	Thu, 25 Jun 2026 16:47:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E01F1534;
	Thu, 25 Jun 2026 16:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406074; cv=none; b=lL8pxaIv+KGrp7+mR+isU40xm2OCXgxQ8tHTkMuGTXXx5C5sdaJT7VHToyoNOKDsmJT+F1hkiJVfBDknYOmy/3tnIZBJvjWBDGURS8hTPg89VPUZPchHi2KQI9z9CHEjnFdoKbQdQMKxy4I3gssiNO9Md8xWb7fRfHg8AszvS68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406074; c=relaxed/simple;
	bh=6nx+0OO4UdD24tZ8q/MQ027UX9B3EPpe+eGnGMmyyHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2iGo3y3UtHfrPAs4TmI3Av7xYxpg+RyQwXUs+t+U08LdqlQ/wD3byTNGY1nzgyh4EePH97m5/nuRwpkbk8sarTnLyAbByxlai5KCkn8lEtKwnDsXudm/0Q7QH58VSqQNgXz5OoUyjQZZe1ihPLHvseBXXtpUegEt0jB45OIt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=L3fcd1+/; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dUVqNH0sF2VDjlyOlgXl2DQF+Wyz+CjJZf1nWQi/wOQ=; b=L3fcd1+/5LLlT6wYCHAy3dPMKK
	LLoHntODYesRlKMRDjShUJQOXbCBsJKgZcf7dalxdUtppecXk5+cJ2WFc3unsg1d3yg2lW2s1OMs3
	YqiUobpw1zSPGeU6ktVYY6NKklIW+j9g+vpr0tzuADTIQCmJC8//+61kcrHrX3Fn1BcxYwZlOiyhy
	rDnyAqCq7WF5qKUe7iUKVBqyGGToRmkLaocUomcfwkQRzxQzB5xscVTOGOfS+klz6hUJsG9uJ+GsW
	MvQWtyFT/X76LeYtrjBK0SE+YypkYBZEV0sEgCHyitPmAVTvkAbxC4Ql82y6c6FmJ8ziDHTLmP8LG
	F/6Si45Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcnEr-003Kz3-2N;
	Thu, 25 Jun 2026 16:47:41 +0000
Date: Thu, 25 Jun 2026 09:47:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, joshwash@google.com, hramamurthy@google.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, alexanderduyck@fb.com, 
	kernel-team@meta.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, jordanrhee@google.com, 
	jacob.e.keller@intel.com, nktgrg@google.com, debarghyak@google.com, mohsin.bashr@gmail.com, 
	ernis@linux.microsoft.com, sdf@fomichev.me, gal@nvidia.com, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: keep rtnl_lock for ops using
 ethtool_op_get_link()
Message-ID: <aj1bi7xuFlRZGxar@gmail.com>
References: <20260624190439.2521219-1-kuba@kernel.org>
 <aj1Nqe3RoITzxSEb@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj1Nqe3RoITzxSEb@devvm7509.cco0.facebook.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:alexanderduyck@fb.com,m:kernel-team@meta.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:jordanrhee@google.com,m:jacob.e.keller@intel.com,m:nktgrg@google.com,m:debarghyak@google.com,m:mohsin.bashr@gmail.com,m:ernis@linux.microsoft.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:sdfkernel@gmail.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11669-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,intel.com,nvidia.com,fb.com,meta.com,microsoft.com,gmail.com,linux.microsoft.com,fomichev.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D9AE6C78B2

On Thu, Jun 25, 2026 at 08:48:03AM -0700, Stanislav Fomichev wrote:
> On 06/24, Jakub Kicinski wrote:
> > Breno reports following splats on mlx5:
> > 
> >   RTNL: assertion failed at net/core/dev.c (2241)
> >   WARNING: net/core/dev.c:2241 at netif_state_change+0xed/0x130, CPU#5: ethtool/1335
> >   RIP: 0010:netif_state_change+0xf9/0x130
> >   Call Trace:
> >     <TASK>
> >      __linkwatch_sync_dev+0xea/0x120
> >      ethtool_op_get_link+0xe/0x20
> >      __ethtool_get_link+0x26/0x40
> >      linkstate_prepare_data+0x51/0x200
> >      ethnl_default_doit+0x213/0x470
> >      genl_family_rcv_msg_doit+0xdd/0x110
> > 
> > Looks like I missed ethtool_op_get_link() trying to sync linkwatch,
> > which needs rtnl_lock. Not all drivers do this - bnxt doesn't,
> > it just returns the link state, so add an opt-in bit.
> > 
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Fixes: 45079e00133e ("net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Breno Leitao <leitao@debian.org>

