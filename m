Return-Path: <linux-hyperv+bounces-10449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI21H5Y58WkmewEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10449-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 00:49:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E748CD3B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 00:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98AA43004C7D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827F3806B3;
	Tue, 28 Apr 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hY8YRLmR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B927D29D288;
	Tue, 28 Apr 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416562; cv=none; b=hEwOqGBR1m4UXBg9PIwiDXq777h0RLCPk03XAdcrhPGgAMsO0QI8iq9g45A4Va/ZJ6XkesgpK1WdnI1Ztvkjfak7DXj5FivCBoHQz7SKjuKvjP3+me3zm9xa2935HbWGosaXIjoJzMjMRhfH7XGbID7PGtUjwHrRzHz2B35LFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416562; c=relaxed/simple;
	bh=yTn3EfOIdJbIumOYh2Dvka6eFEyHR2CYy9Xzu2rSZI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrDMIF0IOvLwoqqicy94GsF74NY222FcajXL4LGCMZ5YgJ6GfEINsr4hGw/C9lVgJM1A6qIScHouYl2T4t/co03LFsUaXpzn/yNHFikfLb1Ijy34FNX9CRxcvU0CUDKp8OXk3uAV1P9RevgujgEOI7UFpe7rfbGiBqF6o1shU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hY8YRLmR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7ED6B20B716D;
	Tue, 28 Apr 2026 15:49:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7ED6B20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777416561;
	bh=zavKiJGKnsWGG8JUSgUxa4bqnOY9ktmLiEJ74TwrZEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hY8YRLmRfHneiRSpyfOTFATryEh018xS2pa8vXmpwy3pQpLKRxoUwH20xYVTYiiS8
	 jZsHDJ+n8ex7lrDlbo+Nc6hIT1wEV/bi2/bQx7FSEN/JO1M4C4XZ1mLbrfeRCmcmaw
	 EPCnNvtQJZakDPzCwdnVn7XgXHen2ryhBymO0PCk=
Date: Tue, 28 Apr 2026 15:49:19 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix interrupt state corruption in hv_do_map_pfns
 error path
Message-ID: <afE5b5J-fhMzmFvb@skinsburskii.localdomain>
References: <177681692062.637858.4160821495321404639.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260424-merry-elfish-fossa-885586@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-merry-elfish-fossa-885586@anirudhrb>
X-Rspamd-Queue-Id: D11E748CD3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10449-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid]

On Fri, Apr 24, 2026 at 02:35:09PM +0000, Anirudh Rayabharam wrote:
> On Wed, Apr 22, 2026 at 12:15:28AM +0000, Stanislav Kinsburskii wrote:
> > Restore interrupt state before breaking out of the loop on error.
> > 
> > The irq_flags are saved before entering the loop, but the early exit
> > path on error fails to restore them. This leaves interrupts in an
> > inconsistent state and can lead to lockdep warnings or other
> > interrupt-related issues.
> > 
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_hv_call.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index 7ed623668c8ec..6381f949d9d91 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -237,8 +237,10 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
> 
> Umm... I don't see this function in the hyperv-next tree at all.
> 

Please see v2.

Thanks,
Stanislav

> Anirudh.
> 
> >  			} else {
> >  				pfnlist[i] = mmio_spa + done + i;
> >  			}
> > -		if (ret)
> > +		if (ret) {
> > +			local_irq_restore(irq_flags);
> >  			break;
> > +		}
> >  
> >  		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> >  					     input_page, NULL);
> > 
> > 

