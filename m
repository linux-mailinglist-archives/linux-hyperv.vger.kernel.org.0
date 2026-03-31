Return-Path: <linux-hyperv+bounces-9861-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKz3LAsPzGnGNgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9861-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 20:14:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2AA36FD1E
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B03D302E437
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51B44BC94;
	Tue, 31 Mar 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BbZHuRX+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4944BC87;
	Tue, 31 Mar 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980039; cv=none; b=gpZB+7Yq+zL15Bg40Qa+XWRmKhoGMj8Ubqg0mBGcK5U86psdUFzJzVbaRkulCefRpgBhvVaFhe2KhtR7xGP32VcezNHk91o1h35/zczjqOIzJzcwp8/EUPq8X01Zt7EldcD1qE6LQl8i4dCh+BPLjKRKYW4HKtNB3W35EhupX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980039; c=relaxed/simple;
	bh=z1vi0DoG9t3PUYugDsafV2YgBY58JD8O6uM0zIAVL4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4e1WZUpIh5O2VP6/vu5pUA8RFnAsawnII3QiWkDr2xUMQTliCPleAXKqu4DFAI/9y2vF/H9dm/bpY+PbmfRzCBpCCYMyhbnaL/YlyKxohyeKtPme6cTgoSmU/QWBSvL4uq4bfZRu4wVO+DnP/HrC4PsA1hHCj+Kbat+avPcuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BbZHuRX+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 82DCE20B7136; Tue, 31 Mar 2026 11:00:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82DCE20B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774980036;
	bh=y230CCKwSyzYJhTKDYaSMqrenP2VnfpFDmx95vI8n0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbZHuRX+sUtXMHMkLoQNoNKOiAS+VqgMdyDhfYeIwV7eNYVeuDo7CgS8qWvEYTSMc
	 VzZh2C7AeyOnLvrJFTQxu+eT3SkL5zfk9QZ1ymJS26u+nEMIc6tDj7BVxJXJgvHn1z
	 UygcEkoDWOeI953s2SuJ7sKAhoTrJlNLu5JXok+Y=
Date: Tue, 31 Mar 2026 11:00:36 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com,
	kees@kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: hardening: Validate adapter_mtu from
 MANA_QUERY_DEV_CONFIG
Message-ID: <acwLxNfSO2h8NgXS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260326173101.2010514-1-ernis@linux.microsoft.com>
 <4ceecee2-ea5a-4026-ad38-66c0a7d263cd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ceecee2-ea5a-4026-ad38-66c0a7d263cd@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9861-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 0B2AA36FD1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > -	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
> > +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2) {
> > +		if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
> > +			dev_err(dev, "Adapter MTU too small: %u\n",
> > +				resp.adapter_mtu);
> > +			return -EPROTO;
> 
> AI review says:
> 
> If this returns -EPROTO, does the caller mana_probe() jump to an error
> label and call mana_remove()?
> If so, mana_remove() unconditionally calls
> disable_work_sync(&ac->link_change_work) and
> cancel_delayed_work_sync(&ac->gf_stats_work).
> Since mana_query_device_cfg() is called before INIT_WORK() and
> INIT_DELAYED_WORK() in the probe sequence, wouldn't this result in
> calling sync cancellation functions on uninitialized, zeroed work
> structures?
> This can lead to a WARN_ON(!work->func) in __flush_work(), or debug
> object warnings if CONFIG_DEBUG_OBJECTS_WORK is enabled.
> While this initialization issue appears to already exist for other early
> error paths, this new error path can also trigger it.

Thankyou for the review.
Since the issue is pre-existing. I will send it in a separate patchset.
The patchset will include the the issue reported with:
[PATCH net-next] net: mana: hardening: Reject zero max_num_queues from
MANA_QUERY_VPORT_CONFIG

- Vennela

