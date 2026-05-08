Return-Path: <linux-hyperv+bounces-10713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HWQGsm//WkpigAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10713-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 12:49:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C04F544E
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 201BB3046518
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64FC30FC23;
	Fri,  8 May 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KTYPKjJE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18330AD00;
	Fri,  8 May 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237289; cv=none; b=cOmUww3BXkoYwN/PVLqm5qXmvoTQNHStUB1f+pk7SpPLuZP562T2BfLYIw5qC8RaqHjBDhIS+zJhpOdDNKIUb9DlwZR4Vq1X2mwGyXM65qBD1537CR5aZql9WjTi1sHXAtK09zXamdsP20wSSbzkQi2esy1mizDsvD5GBUJJRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237289; c=relaxed/simple;
	bh=704LoShnBhfc4BOzl7uMnrCuDGCmToqjLul+3GBrosI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCjgMSTkCdF42s15qEBWqioZNwFAXLhrqO2UtqTssckYRxsx47Pi0qfFRewakoT+wJSouCTLUMXwKff/ML7u4CecZfBxOjv4APyz6XVWpKG9Ciz48ucs31SyNPWOq9avnQS2tw3mxLVsFcYfI99jBrlHTHCNuLcs5JZMRzXP6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KTYPKjJE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 7D59320B7165; Fri,  8 May 2026 03:48:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D59320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778237284;
	bh=EMRzlxwa2F6A2f1IpuIIEERVsdP9/sX2AoRibGQygb8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=KTYPKjJESkeQ8FE2LpbeH2mjIlTxN/mT+WiPvLxIT5KgK2EgEFn7fuOjP461H3eFK
	 MDqwqMgBPfIEH0vfIwpAruEZeMHNRgHRIK4co42UFI7hlYuuaq1sKXY3X6J/uSAofe
	 fAl64+1kHWnScMOS0HlM0wXeFgZO/jWGJsrquskI=
Date: Fri, 8 May 2026 03:48:04 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net-next v7 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <af2/ZPVtR0OrUwom@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260506170034.327907-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506170034.327907-1-dipayanroy@linux.microsoft.com>
X-Rspamd-Queue-Id: BA6C04F544E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10713-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 09:58:56AM -0700, Dipayaan Roy wrote:
> On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool 
> fragments for allocation in the RX refill path (~2kB buffer per fragment)
> causes 15-20% throughput regression under high connection counts
> (>16 TCP streams at 180+ Gbps). Using full-page buffers on these
> platforms shows no regression and restores line-rate performance.
> 
> This behavior is observed on a single platform; other platforms
> perform better with page_pool fragments, indicating this is not a
> page_pool issue but platform-specific.
> 
> This series adds an ethtool private flag "full-page-rx" to let the
> user opt in to one RX buffer per page:
> 
>   ethtool --set-priv-flags eth0 full-page-rx on
> 
> There is no behavioral change by default. The flag can be persisted
> via udev rule for affected platforms.
> 
> Changes in v7:
>   - Rebased onto net-next.
>   - Retained private flag approach after David Wei's testing on
>     Grace (ARM64) confirmed that fragment mode outperforms
>     full-page mode on other platforms, validating this is a
>     single-platform workaround rather than a generic issue.
> Changes in v6:
>   - Added missed maintainers.
> Changes in v5:
>   - Split prep refactor into separate patch (patch 1/2)
> Changes in v4:
>   - Dropping the smbios string parsing and add ethtool priv flag
>     to reconfigure the queues with full page rx buffers.
> Changes in v3:
>   - changed u8* to char*
> Changes in v2:
>   - separate reading string index and the string, remove inline.
> 
> Dipayaan Roy (2):
>   net: mana: refactor mana_get_strings() and mana_get_sset_count() to
>     use switch
>   net: mana: force full-page RX buffers via ethtool private flag
> 
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  22 ++-
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 164 ++++++++++++++----
>  include/net/mana/mana.h                       |   8 +
>  3 files changed, 163 insertions(+), 31 deletions(-)
> 
> -- 
> 2.43.0
>

Sashiko pointed out a valid point,I will reshare a v8 adressing that.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260506170034.327907-1-dipayanroy%40linux.microsoft.com

Thank you 

