Return-Path: <linux-hyperv+bounces-10107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGQcAdCH2GkIewgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10107-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 07:17:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C03D23E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 07:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71D61301E22D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B443290C2;
	Fri, 10 Apr 2026 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lIEQrpQc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBB3135A53;
	Fri, 10 Apr 2026 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798220; cv=none; b=ANEUCtSGBrz3VPdMfOcp9eE56VmmicK+ZLldMqCmoHnTDtGHp/ZHoPoaqedhAwWeRIu1IYP51J8Y/Z+pt1HeGdG0xIiNGsjEkoGfibOXK6SUuOaaLbcPpd0qkma/C/g/hcFtIdl8cjzLaCl0WlM9m8bB9cHjfEkOvyI0PctUqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798220; c=relaxed/simple;
	bh=3IDmo4yq5EwUAHnshOGecVTFp1hMXNkC5Ayvumo+ZG8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IukYdYPe67XLE3+eBYLdnCSzCivW6GVumUh42Eyf7rM1KZ/nIIp1/iTz22N2TrR2SS1VrpzJxA25lw8Cw2AEH/YHpOq8sNqBy3xJqQT3ypeePNLPHI1/Aphs8uXs5s6hjNUAMsKTb50hdEP0jtbxKj56OYc1vGL6s8ii+twIc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lIEQrpQc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3FE1320B710C; Thu,  9 Apr 2026 22:16:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FE1320B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775798219;
	bh=M5KQJVPRasC9u3hm427fEyDiVTUVpT0+/XgxZI/YhVw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=lIEQrpQczgW43Nw1nCyydbVB/zQarBVDHznbOlrJOlvOP2IuDmuFpyb1TL67pm6xW
	 wB01D6NQHMe4dBe8GQSo0HnrHks6wYXtNcZPEK2s8prqVx5krSEMNbOit8wcr/aLw5
	 zvGDVfORLxcLBHYaxprOkmg43fWAQh/edJ0UnBgo=
Date: Thu, 9 Apr 2026 22:16:59 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: hardening: Reject zero
 max_num_queues from MANA_QUERY_VPORT_CONFIG
Message-ID: <adiHy5/ilucFKv1g@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260326174815.2012137-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326174815.2012137-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10107-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A33C03D23E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:48:10AM -0700, Erni Sri Satya Vennela wrote:
> As a part of MANA hardening for CVM, validate that max_num_sq and
> max_num_rq returned by MANA_QUERY_VPORT_CONFIG are not zero. These
> values flow into apc->num_queues, which is used as an allocation count
> and loop bound. A zero value would result in zero-size allocations and
> incorrect driver behavior.
> 
> Return -EPROTO if either value is zero.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b39e8b920791..a4197b4b0597 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1249,6 +1249,12 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
>  
>  	*max_sq = resp.max_num_sq;
>  	*max_rq = resp.max_num_rq;
> +
> +	if (*max_sq == 0 || *max_rq == 0) {
> +		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
> +		return -EPROTO;
> +	}
> +
>  	if (resp.num_indirection_ent > 0 &&
>  	    resp.num_indirection_ent <= MANA_INDIRECT_TABLE_MAX_SIZE &&
>  	    is_power_of_2(resp.num_indirection_ent)) {
> -- 
> 2.34.1

Hi,

Gentle reminder regarding this patch.

I would really appreciate any feedback whenever you get a chance.
Please let me know if any changes are required from my side.

Thanks for your time.

Regards,
Vennela


