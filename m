Return-Path: <linux-hyperv+bounces-11718-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YNjRKoYmRWp47woAu9opvQ
	(envelope-from <linux-hyperv+bounces-11718-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 16:39:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D506EEDAB
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 16:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=Yg7NZpNh;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11718-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11718-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97BF23019F34
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA123403EF;
	Wed,  1 Jul 2026 14:29:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E9330D43;
	Wed,  1 Jul 2026 14:29:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916179; cv=none; b=HOZdHEqBKxaCDGYZ/yf05OWPgJoG7ZUkkHKsFyhftSI18gNk5p9BALaIDijiCE5tTo74iIQLnBO6EArqiyogC/1gnZtbE8abEAnoLi2kzvrGpPpihsZPPeAbWvogOzCR1ZHVvexhl2sGoWTA9cKnE+vqPPvfSQHOt/zvCjjTFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916179; c=relaxed/simple;
	bh=e9zG2J/6CtdG9sjGYRXm1SrI6+g1Ut9XvKMQhA1bYmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbnJj4dfTDyZ2ZIZRbJo05bq7wwuGXNNXC9Iq4c48OfurYe47xTcCw3ExRlJEkOVEhrCO4wdGxsrlkDm2OZUg5jE4DrzEpDvNj2V1Otb8UsAc++1Hi/g9ncbiev8slCchaU/pcyBrsAS3fiuJ9tQXAGN/+n5MwkFQEaGUdfuIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yg7NZpNh; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 6968F20B7166; Wed,  1 Jul 2026 07:29:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6968F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782916177;
	bh=TuyXNNDkjGNekj9kasMP1vdYOegRSZ1Lu0MTl3ivfaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yg7NZpNhaMOocVoelqZdHjJCxfd5hjS25T7nWNlCwzs1y5cgpyXjbPY6Xm1zySWOo
	 AGmfgQmaaVX/xd4Y8fQ//w/DkYHAnqM8T5WRPjB5kWmq26PcxtuW4pZMRrB4aQ3yKP
	 P711eBRlyu/iRbBcM5k7AYT6kqrUFVymte/yljL0=
Date: Wed, 1 Jul 2026 07:29:37 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v10 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <akUkUQodHuxZFUZV@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260602202801.1873742-1-dipayanroy@linux.microsoft.com>
 <ajBRwYftEol8IE49@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260615134247.0bd7e16e@kernel.org>
 <ajCXIpDVaVcUcQwd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260615173314.677c33a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615173314.677c33a8@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11718-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7D506EEDAB

On Mon, Jun 15, 2026 at 05:33:14PM -0700, Jakub Kicinski wrote:
> On Mon, 15 Jun 2026 17:21:54 -0700 Dipayaan Roy wrote:
> > On Mon, Jun 15, 2026 at 01:42:47PM -0700, Jakub Kicinski wrote:
> > > On Mon, 15 Jun 2026 12:25:53 -0700 Dipayaan Roy wrote:  
> > > > Just a gentle ping on this series. The approach was agreed upon, and it
> > > > has picked up a few Reviewed-by tags as well.
> > > > 
> > > > Please let me know if you need anything else from me, or if I should
> > > > resend it to collect the tags.  
> > > 
> > > Don't recall now what the exact sequence was but pretty sure this 
> > > no longer applied after some other mana series was merged.  
> > 
> > I see, the net-next is closed now, I will rebase and resend this
> > once it opens on June 29th.
> 
> Sorry for not flagging this sooner, IDK how it escaped the reply.
> Maybe some mix of Jake's comments plus it not being applicable 
> later.
> 
> Not to deflect blame but y'all should coordinate better, the "no longer
> applies" situation happens in mana a lot more often than with other
> drivers :(

Hi Jakub,

I have rebased and sent a v11:
https://lore.kernel.org/all/20260701141808.461554-1-dipayanroy@linux.microsoft.com/

Thank you for all the support.

Regards
Dipayaan Roy

