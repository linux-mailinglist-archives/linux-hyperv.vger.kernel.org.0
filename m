Return-Path: <linux-hyperv+bounces-10198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sORxEuXr4WmKzgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10198-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 10:14:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA607418743
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB9F3059580
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7E39BFE1;
	Fri, 17 Apr 2026 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcRClTFE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSbI1Sox"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F139B4AE
	for <linux-hyperv@vger.kernel.org>; Fri, 17 Apr 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413473; cv=none; b=kct8PZx94UL4GVGlDF1/Iia/0tfPuOUp9NouYNw+HJAP1Z4kwEwyCnSafm5QM8lxDY2hAY9f5F9IYGrhLvCMMJzj1oFCu4V0emlALq+iBljdJ0ZISPaRxV71/gNToup3HNE9MC2qLSah4pT9uyMFQ8pHIdJahLVHf0Ixco1/lXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413473; c=relaxed/simple;
	bh=KaCpviZPSmkiF4jmKYcWq3DzQZ2+p6j12ROyja2bfaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtC0ebG3zD1FX1wLKlhmUiJ8044EFkV/pF0kEdwYfHoXy3BjwtUXmwqBWVZRTkHq69EXEvi2iGmI86kkAF7dPDQtJeGmvymgjBP8UI30cPvTjQDvE3NahAKswEvHYLHbW311QeQVhX3DeT838XHrAsAdp23Mf+FvZybQIlAAI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcRClTFE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSbI1Sox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776413471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
	b=JcRClTFEVfGmISpUkkZQLKl2p7UTvg81kSJsLWKWszcVUvPTtdbJLuPbeCJbfw/04DD1Wy
	RO/tubgzPxZO2nSVHMWxO2HDaMq+HfIBhVpWRpazewnKrcOqwm2b+n1zwWHdM4fmLzDE51
	Gh8420KxQXxlAdC0paDueglNCCNCtGo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-SsgQpFWwN7mJ0u2XNN2IJg-1; Fri, 17 Apr 2026 04:11:10 -0400
X-MC-Unique: SsgQpFWwN7mJ0u2XNN2IJg-1
X-Mimecast-MFC-AGG-ID: SsgQpFWwN7mJ0u2XNN2IJg_1776413469
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d77286244so244223f8f.1
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Apr 2026 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776413469; x=1777018269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
        b=YSbI1SoxcM/EUyQYLWXfLfXB8dM2Yv0jrh9h3pUDwxDwagq1HIEBpXuMbkj74tb92o
         5sNDmFiXD4ZBX3bT8qfpOLNuvqeOBLHJvjZseAP8FCA/8FH3VEpCthzeF9H6brtFQNAS
         1xP80HXE09j36/vLkerK4Wi5p6tbOKs+dB09U8pgZUyjoLBDx+BJD35zPKOpG9g8yAt5
         dH11r+Xq+reLAwXd60IKsXafHDR8z/5xCpxftxL+kFDctO0/EwULR5QLOrmy1FQDQBQ3
         l9xRuVTXOffRm6+hOPCr58TmVX0X0pfmKrbV0p2LNG50mop6lQeZrTZrC1oAsEmaKp6C
         BzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413469; x=1777018269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
        b=MZ55ZSQUxI9s+uOM9lXUwUXIhmAGUTTVhYi3deWCaMJYzxwtyBi8g3G5dkiBNGKI4O
         yvhZ78+q/IbdmewR18WLxQ+rCrOF9kAxPyi/cmCPb8o0DcpE7yOMsKACuGTrQldE6pC5
         CwjaxtosSWREtHZkZgkg/B4Dn86tRufOenN1d/n8kesG7HcDFUrE62+lSEM+c2v/Dx/G
         IyddTWGY9rnUSCEEeJpgaCi0/jpJkkmxtLHQR/zYm8l69OzbkriGRG38jyLmz7izVZhk
         phFEvBUtQJJF6UdcmVv8YU6Fv9vMwXhfyhY2d4Khto+HDpArMu5XeN2Wc418JKe0a6Ud
         FF2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+80lZw43UrqpNOZjuftyp7Msmzo/pnIcJnDc8FK7w5xBw6jUtP3nbowm4Z13I8GCKMxqWIh7Ozv9/qAzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/DFm/c0HQkzSbzl61GZbrZSCmePn/Ns3beIsAk+Fn9oSUfRO
	MJQIrSY0yvNrajQxBDPdtBBb3ohBaEEN5jc8kwbEIPt4KwMeCEFpVPm818LDSEdUqVFUzY/t03n
	uqBXBU/qwYmpSho4We4TGABCKu7HYHjMCnwnJ4oB/pC8kpjTDqL/ZUXvGzlW8UK1q2g==
X-Gm-Gg: AeBDies4LnAakrseZvX5wXlNqkpgWkjhp5Fu6EXKeBF4imHlrVwEWQOCLc3lBf4Z+gF
	TvFgumRz6jn1U16gMHIdpE3p+OeeWmB3lIiL2GnBfPD+OhtBMqO9gBttJMne1xkiUvdYdOF83Jg
	czcAmkvqOLGFaYPrQMMk6MI7NRZsWlCsj2HxghObCuntHRmAYT2NEQGPTF1QGCsnfEdnwNTt9L4
	d8i94q56ZtQat6DxRHQ0BWoUe+azg+nMW6TIaPHk0aPM+IQLSHWI5LWZTptkYOf1JKUcbeAnDaG
	UwApmD/CypT2v/AMs8DfHdUhPyI68xwp0UH3Wxcye83lLK5nhDHApWMZNJckUb9ZMa2qzq7IgFQ
	BMKo3u7CN7VfRA3dqdoeRReCL2nwOyuMPjMAS/ruCRwvEaEFwwB5srNhhlf57HCc5vGxL4XQ5Cg
	MAbe8+NQ==
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr2356244f8f.36.1776413468882;
        Fri, 17 Apr 2026 01:11:08 -0700 (PDT)
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr2356185f8f.36.1776413468277;
        Fri, 17 Apr 2026 01:11:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a381sm2920727f8f.21.2026.04.17.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:11:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:11:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ben Hillis <Ben.Hillis@microsoft.com>, 
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO for FIN
Message-ID: <aeHor6IpXUDyMtnW@sgarzare-redhat>
References: <20260416191433.840637-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260416191433.840637-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10198-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA607418743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:14:33PM -0700, Dexuan Cui wrote:
>Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
>and the final read syscall gets an error rather than 0.
>
>Ideally, we would want to fix hvs_channel_readable_payload() so that it
>could return 0 in the FIN scenario, but it's not good for the hv_sock
>driver to use the VMBus ringbuffer's cached priv_read_index, which is
>internal data in the VMBus driver.
>
>Fix the regression in hv_sock by returning 0 rather than -EIO.
>
>Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
>Cc: stable@vger.kernel.org
>Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
>Reported-by: Mitchell Levy <levymitchell0@gmail.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Changes since v1:
>    Removed the local variable 'need_refill' to make the code more
>    readable. Stefano, thanks!

Thanks for the fix!

>
>    No other change.
>
> net/vmw_vsock/hyperv_transport.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


