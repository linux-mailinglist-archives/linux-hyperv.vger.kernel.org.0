Return-Path: <linux-hyperv+bounces-10200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC+zG0xA4mmB3wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10200-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 16:14:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C941BEDE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3EA30F3315
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4E39D6C8;
	Fri, 17 Apr 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMbQCh9t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311CC27E1DC;
	Fri, 17 Apr 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434927; cv=none; b=mOOowEopy+8yeh6wklI0lFhW0yGYRLWAVVTLRnjUyPxR025oMTGe5PNIjN0Iuh37Qg6UiMq6NcqVvEHZrLJM/oeIWVcv2rfLcKh9Vy2nwBOvQspIFAL3hxaBRiN9Xh76UeHFUAm7vruiJgUzbOpmmiViYWAcJsO6XnfUR7sc9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434927; c=relaxed/simple;
	bh=5trXQSOgOJ7eFKoDmo6UoUhSEJRJR8wzR8pcrXIc12I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWDSAymy9td8GW+zNbCrxZfjPTPQdCse+dXy1Nkh4IyObnxG33JvXfbhCUmpF0/T1j2RvzSopqHEpBKTT3imFrD+LbFnPshVrhaDdk569n+SuM3HoTzcM11qyrqM5EZeEn5W/lxJRfl3tyFqU6fWoIGMHsnAUnA9MyuyfZVwqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMbQCh9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E0C2BCB6;
	Fri, 17 Apr 2026 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776434927;
	bh=5trXQSOgOJ7eFKoDmo6UoUhSEJRJR8wzR8pcrXIc12I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMbQCh9tAYm3Q2aALGdhquuFDQcf70jSZZ0keHsbDm7znhcIOYBXcbjQFti/ktdYH
	 715iBlUJnWMVTXgQKk03NJMJhGdi+EMjtjcBFu6XughhjtjTMGtWWgpoJjzywmB4p5
	 SwVny0kAb33R6RFK+h4U1VNZgoV/5C/zhCwa/7CGUlqOihmq/Gl4t7lEKk3h4GDXzZ
	 bcseNyHarfSjfBf/22+BIPU5DOk4mNvrOirbWU8lMVtFyZUTkptapWgEmcC3kAvw91
	 1gri5WfOqsU2NuXDUxzZRVS12baqdX02WcpTXhBDJPl7XjrsTTGQW6Z3IPBw901OqS
	 8wmP8cRRgIWHA==
Date: Fri, 17 Apr 2026 15:08:39 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/5] net: mana: Init gf_stats_work before
 potential error paths in probe
Message-ID: <20260417140839.GE31784@horms.kernel.org>
References: <20260415080944.732901-1-ernis@linux.microsoft.com>
 <20260415080944.732901-3-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415080944.732901-3-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10200-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E31C941BEDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:09:38AM -0700, Erni Sri Satya Vennela wrote:
> Move INIT_DELAYED_WORK(gf_stats_work) to before mana_create_eq(),
> while keeping schedule_delayed_work() at its original location.
> 
> Previously, if any function between mana_create_eq() and the
> INIT_DELAYED_WORK call failed, mana_probe() would call mana_remove()
> which unconditionally calls cancel_delayed_work_sync(gf_stats_work)
> in __flush_work() or debug object warnings with
> CONFIG_DEBUG_OBJECTS_WORK enabled.
> 
> Fixes: be4f1d67ec56 ("net: mana: Add standard counter rx_missed_errors")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v3:
> * No change
> Changes in v2:
> * Apply the patch in net instead of net-next.

Reviewed-by: Simon Horman <horms@kernel.org>


