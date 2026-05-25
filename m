Return-Path: <linux-hyperv+bounces-11192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FqcIfTUFGrxQgcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11192-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 01:02:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9175CF188
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 01:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A2E3019F22
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51833E367;
	Mon, 25 May 2026 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WpsgWDEb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A162857EA
	for <linux-hyperv@vger.kernel.org>; Mon, 25 May 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779750127; cv=none; b=g9E47l/73TVJPBhMaFZMjzstiETDQDdPfvEThXX07Nh8DlpvnKHweDcrqU3/YNlq5q/F3I2GNHSyjeMkLveiVhZc+1El2VWsdUFvBNP+Huw/L8UoW2xMeaGNg+JTu1FUj6y5HLhm0VEpyokjph7URirtLNAk8yeim7V2WMwJPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779750127; c=relaxed/simple;
	bh=eu7oHNR9mcfU4ioBLEp3xWRPG5uK3jDdylzyfDDX5aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzJsAG2OoTcpvZ64C/gpRDaSbzMlXxxgJiwEBW7udpR3Vb/cChpqWlGuA1xokFiN/VsVFYs4FtGxL04QBm3umot2a39Ko7jAHdb7tl4v982jpaeNaFlXQD+oD9VdcfwWTL8oRjVXp/b+APfJ+ztkHco7kSYvgWIptAe9DKeeKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WpsgWDEb; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95f6b47b309so1926786241.0
        for <linux-hyperv@vger.kernel.org>; Mon, 25 May 2026 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779750125; x=1780354925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHgkHa6ZlvV1jsZqbopBOds1Pj5+WDOoiFTPjaNINSw=;
        b=WpsgWDEbcl/mfC97gfvBOT7Hw6/l9/kWQL/Ma8C0H7ac3HKyq+bIWmkMbAgdSFbtyo
         q23WeK1liMif77t34U/hWxZhXdaYHG2bojD96WSGMEZAIMgpYsxkmyuaFpEKmvgNvEos
         zTRDNUfE1iFQkXwpbAclkptHsrgAahLFdRFxY0PgCeIeDuWKibTWORIIDIQJz56xAZHR
         9EhV7Zwai8voxIq7sgc1wwQJZM8N9nsH6CWeCQd+WPRBcwoWZjMFjznNdEd3jn5JxjLT
         rBSvNgSCvoHLaX3SSP1UD58EME6mgKSrCZai71msRye3T5wjGd7ZMZcbQFt8OPGBK5O+
         3a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779750125; x=1780354925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHgkHa6ZlvV1jsZqbopBOds1Pj5+WDOoiFTPjaNINSw=;
        b=nFUo0u9+pkBtmIsNTwSl841TNfu1MuvCcd6AJkrMCxXLCFFyEr/G0pwDOacO7wym3O
         3EJsjRN2+uaO7IURZyatd44rI/dGU60rOAeg6yh8hz3EgYeSGEhKAcBpInEGmmdX12xF
         xV1ErnV2P0BT9bJTNXLK6k1DN1p5j/HQdkY4P87FPyAnaBI3BqvILRIXq7AWKtyQyL1y
         TxRuIAhzvp9RRgAs+BUo3IRlyrNYsikimHS4pi0pnrE0AJlmLq1ekeS5il6+99jLkzYp
         SwKRXoJqAzxoWOCGt3rzEhtdCdceqkFwDmeVVvUy0alKP+eKGsxFpU585rGS3uFEExMh
         aS1A==
X-Forwarded-Encrypted: i=1; AFNElJ/dsWkCsDWbPDKshiQXsXSIW41/8vV40JCvg+OobulslRaQCc7lJnIzSMqqXZHUkq+w4kkunbWwViZIpMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznti19XrqjnN/E2YVJO5Y8wYVZMhh8ZmAkCKEO5656FVYa5dIc
	ueAAMya+4bmEzJebzo2zuqQxx2F8YCrN1LGTWj94N0MdZZ6XuG90QnKYiF/OLUbyOeY=
X-Gm-Gg: Acq92OGzdDLek+aOrI/x9KS7ByPwfPCF7IU7G1G4YJGZJtPSqU6LUUbYvkhdUHgbvaa
	GKVaLA0OeAnzGA9Pwkm23kW6djNbDFkR6Dg2IVMKcCOjve5O8XO+6ByN/L4lsD9a4uKs8Lh9lL8
	6WU24lJTdatFq80xdXycKM4id+2zapxYVo/hwZbDI7DmYlGdBftUIbgtVSwnLpvA0aB5PFd7rOf
	7m0Mo2cKBWNbmGnH2ggqAJ8w9DdJfzMudbqVzRI367uGGD8TvyEvBr0xQV/DhI/AAdrYSgrRQQJ
	5AxPG1/moIypO4sK6PZu0+Q8RV1qw8Rp8A0I9UEePhEQ4nL5ccMaz5YSSDfbhcjuo7Ui6wehFJa
	/9AQ1rURmAp2Gi5yotzVzUGOvAQ2yv3S0FWOce3Ifqmceew/gDX+TmKh05sZ4Wg0+GMmQwlqmtc
	uIV55K8MbmPMtohyaSOsfGwc0Hi2FIuleBUY7y8sbkL5Q1KDyC4UHGYSyxigGtber4f2WxBBQ5R
	Y+1Cw==
X-Received: by 2002:a05:6102:32ca:b0:633:2389:3a84 with SMTP id ada2fe7eead31-67c84613d08mr6201357137.24.1779750116975;
        Mon, 25 May 2026 16:01:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf4a9sm121808066d6.2.2026.05.25.16.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 16:01:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wReJ1-0000000BVd6-1lfG;
	Mon, 25 May 2026 20:01:55 -0300
Date: Mon, 25 May 2026 20:01:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260525230155.GB2487554@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
 <20260413134602.GL3694781@ziepe.ca>
 <ahSbyYcq0sgfJnmZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahSbyYcq0sgfJnmZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-11192-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB9175CF188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:58:17AM -0700, Erni Sri Satya Vennela wrote:
> > “There is no reason they should be signed, you should just fix the
> > type.”
> 
> It is not allowed to change sign in props, so clamping is the best bet.

Why not? Fix the core code, it is just old junk they are signed, they
should't never have been.

Jason

