Return-Path: <linux-hyperv+bounces-11503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+YCCSNhImq5VgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11503-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 07:39:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D2645319
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 07:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=kCFlTesH;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11503-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11503-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A09300B129
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 05:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF738BF97;
	Fri,  5 Jun 2026 05:39:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2142AD2C;
	Fri,  5 Jun 2026 05:39:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780637983; cv=none; b=IEaYmcdiFovK/4ECa5/mccw/7RybzFRFWN0DyU0PrXyn6mzjS0Gi5SQaSFLz6g66BZzoIfxbp1ilDFIuuLJZ0cGIqAGvoCrmZ6hRoDXfjx4V+kLjXR9F6WAA54d6UIGP/0aqwsJYjJfzCadJmxsjoQxLcLkIqd/mwkBuNZhIG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780637983; c=relaxed/simple;
	bh=OtzFLoaL6YRibt5cWxU3Bh1ybqbe+mB6LqicVDYoSVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr4pkLA6xuIPAYSFkcPHYDS6YDHUrOoQKWQfrxlK1kZRyudiCpNj1DKtR4id5QKQrCU64QMTg3dEE/hEwXDY388dfYRmKoLgG03MpduwYpYTqMnoI4B8ss+CYrKKaLG6H9iRct6d4OBSZ/KTwzinjo4B72wkyYiXCeRzWUhVzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kCFlTesH; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BB02520B7169; Thu,  4 Jun 2026 22:29:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB02520B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780637369;
	bh=qIO/sBp81IBMRVL//sPxD46ntAHHAdA/+qb5LsOMY8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCFlTesHtfd61rL4g6Pk2Gf9tPjaIQvHUm8+WvC9ONeLMpNzq74ueTfVx+or9v5vv
	 i1BXiC6LmO5lem0eSeF2ac6gFBq4SoHHuxkTr/k7U+vLYWHs9daeBo9qR+YwUCTxqE
	 ITX8nLq26F57iawXJOMbSFnOTQtZUFCFpRzqXi3k=
Date: Thu, 4 Jun 2026 22:29:29 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kotaranov@microsoft.com, horms@kernel.org,
	dipayanroy@linux.microsoft.com, kees@kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Cache MANA_QUERY_LINK_CONFIG result
 to avoid repeated HWC queries
Message-ID: <aiJeuU3DLKL7JcPN@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260528180757.1536640-1-ernis@linux.microsoft.com>
 <20260602132127.25fc27ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260602132127.25fc27ee@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11503-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 688D2645319

On Tue, Jun 02, 2026 at 01:21:27PM -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 11:07:51 -0700 Erni Sri Satya Vennela wrote:
> > mana_query_link_cfg() sends an HWC command to firmware on every call,
> > but the link speed and QoS values it returns only change when the
> > driver explicitly calls mana_set_bw_clamp(). This function is called
> > not only by userspace via ethtool get_link_ksettings, but also
> > periodically by hv_netvsc through netvsc_get_link_ksettings and by
> > the sysfs speed_show attribute via dev_attr_show, resulting in
> > unnecessary HWC traffic every few minutes.
> 
> mana is ops-locked, right? Because you support net shapers
> 
> Could you instead take the netdev_lock() in the work?
> It's already held around the user space originated calls.

Hi Jakub,

I tried two netdev_lock-based variants. 

mana_query_link_cfg() has four callers:

1 ethtool ioctl/netlink			- has RTNL	- has netdev->lock
2 sysfs speed_show/duplex_show		- has RTNL	- no netdev->lock
3 netvsc_get_link_ksettings VF forward	- has RTNL	- no netdev->lock
4 mana_shaper_set			- no RTNL	- has netdev->lock

No existing lock covers all four.

A. netdev_assert_locked() in the mana_query_link_cfg() :
Lockdep WARN on every sysfs cat /sys/class/net/eth*/speed and every
periodic netvsc_get_link_ksettings() poll since callers 2 and 3 hold
RTNL only.
A slow firmware reply on callers 2/3 can land after mana_shaper_set
(caller 4) has changed the rate and invalidated the cache,
publishing a stale apc->speed / apc->max_speed as "cached valid". 
Because the value is cached, the staleness then persists until the next
shaper change

B. ASSERT_RTNL() + netdev_lock_ops() inside mana_query_link_cfg():
Self-deadlocks on #1 (__dev_ethtool already holds it) and #4
(mana_shaper_set already holds it and calls mana_query_link_cfg() before
the clamp).
ASSERT_RTNL() also WARNs from #4 — shaper genl ops don't take RTNL.

Eg. Deadlock scenario:
__dev_ethtool()
  netdev_lock_ops(dev)              ← held
    ops->get_link_ksettings()
      mana_get_link_ksettings()
        mana_query_link_cfg()
          netdev_lock_ops(ndev)     ← DEADLOCK

Can we consider private link_cfg_mutex which is orthogonal to RTNL and
netdev->lock and covers all four callers?

Thanks,
Vennela

