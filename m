Return-Path: <linux-hyperv+bounces-9391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEf4BLpCs2l6TgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9391-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 23:48:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4B27B1A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 23:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30AE53016157
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 22:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC943264D2;
	Thu, 12 Mar 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="htKkcFPc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37A21D00A
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Mar 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355700; cv=none; b=foVt2lkix0HUsKvecwQu/LxoBV62aXFXNtOMeULuJoLltBwNOnfJ9BvNyY00zOxUNFRA/6VooAIcWCBSk348iGKoY6s095/x3GmFiG3ckHTstkoa0X3xV+A6bdxlhpZ1upLEpE9F8FHNqQwAzNUfWfKf5Tl9fmYcFxCDBav3WNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355700; c=relaxed/simple;
	bh=z28IegkFi2/sHsgKnojVtJ4sbkMmOSoNwWw72Tc3qc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD/lXW2Op7CgGJXpe4rQEhb4dVBixztROl5TPQdkVoRC1nrsKLPnpELfPdEMhWUB7ZWXTRuBd4VJGmerm74AKWmjElUtCUfyA2/SNNwq9njFLohhvphT2Tu6OZORndgnYIR612u8jJHmIETxPw2Al9Tre5c0NrjtnZr1eZ0NbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=htKkcFPc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a747448dso13481611cf.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Mar 2026 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773355698; x=1773960498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z28IegkFi2/sHsgKnojVtJ4sbkMmOSoNwWw72Tc3qc8=;
        b=htKkcFPcyba9ssMuutCn68GPFyd6UPFChGttIli8uNyYV1wbsU88fWstPZH/aTBdnQ
         6F6e3pPlW4mt4mD7JnzWugIBpgVbdMFeEJcKUBS843ZnR63x0KwEFN/kQOTQBEThczwM
         sJmREO46/FIf+mLfxjs5mv+AnJFcbpJfJw3zsTTRdrWZ4UaA06XY5KNJI5d1QXKmf3DJ
         yuUKUemvswQRrmLCKNZbqcwrypZxgvuXiVjFza4F8Tr5YqVbLGCceXySYpsjPVzdFmof
         mx03XKTcHQatKbG6BZAhEN6WuSzv8I/l8EL2GRikqOZcmzO3lfJbny6i7DX6ecxz5wZx
         c0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773355698; x=1773960498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z28IegkFi2/sHsgKnojVtJ4sbkMmOSoNwWw72Tc3qc8=;
        b=WQgonHLksbtde8mFv3vXWQ2cU4SX/h7cdc4k64oO5ET12FZNler1K2i5jGwX6b75Ct
         tpboNCowbPuhLAxVTB0XccgnbyCcZGLEXSudJZrW+EAWT/PeXH8RDPXjM8PRThx1Yl+D
         cl94uXV4hgqh6ku2XElbrgCoHOTTF7PlnlKgn3WAx6N/S9DHpw6WiiBteg9dy6bgm6eQ
         dT76MCdIaxvxTKBfSLFQZfi40GxQvUdqCDAO8S3tecd3HpYdPsU/HOvAIaPRoHuHVr2h
         qCCBlVwUl7EApKuon4s/9FYpDLT4HOpygGoSC8yMb+nkRaBfgsbB80VefctQDkOzsgtE
         SOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCTZuaxjm3N+ucZQmrAHkw9jsL+L/mtrt1VTcUgEOtaaZ42rrxfy10z74X9S+1uQjImqEG/vaY7/vro3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmqiMJZjOOTrfnTxSD1xJKn38YaZh/O/epfaYC8kILifOxFsa
	Lg71FrRKqpiKmu1UVf78gP99oAuChdQVthR5o3xyW7dUa2eZg79Z36APWsH11ZNKsaA=
X-Gm-Gg: ATEYQzyCSRx8w3dcNihn7/DgcJ0ouw8IzjE9EBn7klhgP5zX8UP9TsQdqItXaTFQ0zZ
	5saSJMb0qmdORhZRGG71dOM+6pYScu1qw4OWHPR1t3eZDU0+y2PXdGA2muHuDckJOCxTmZbqCQF
	rWGgkB6riVfor7CByiqIGW5C8fJk/5nvlPAt7K14RvaxjzYpAWFWpNYPzVeFyJQEsDFglPLU0z2
	qcnVLyhd0BQ59d1Eo1BrtCHFeiLZk1mcWLdUkYrn3s5bOkbffEMO7YBxwYR6mshKMJP+wgXwiwL
	DK7mbZFCFBuCFMs+B3DfWX4ZZGOYtPC9IqYZ45h+7f2vyYWPvl+OMTLcvN2RRtvHVhFnf1YbfN1
	dtD4B4dq4V4XPF1kAMVxMVrpQq+dp08XitH0ePZ32Fe+0ahgKxvW3g7Q/mY+GlGpIMFwmIL+oCL
	nQDKB6yNoLB5w5UpbLMmTP8+kuSKYL+caAS7hjxTME7fmH5n1z8u4nWaENzVbur3LU2fFQu4OnL
	pIvdxql
X-Received: by 2002:ac8:590d:0:b0:506:a56d:3f2d with SMTP id d75a77b69052e-50957e41b49mr16122411cf.75.1773355698330;
        Thu, 12 Mar 2026 15:48:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8e14esm40241411cf.6.2026.03.12.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:48:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0opE-000000070dH-1Z0r;
	Thu, 12 Mar 2026 19:48:16 -0300
Date: Thu, 12 Mar 2026 19:48:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: longli@microsoft.com, kotaranov@microsoft.com,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening: Clamp adapter
 capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260312224816.GO1469476@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312181642.989735-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-9391-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 14A4B27B1A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:16:41AM -0700, Erni Sri Satya Vennela wrote:
> The response fields (max_qp_count, max_cq_count, max_mr_count,
> max_pd_count, max_inbound_read_limit, max_outbound_read_limit,
> max_qp_wr, max_send_sge_count, max_recv_sge_count) are u32 but are
> assigned to signed int members in struct ib_device_attr.

There is no reason they should be signed, you should just fix the
type.

I'm also not convinced clamping to such a high value has any value
whatsoever, as it probably still triggers maths overflows elsewhere. I
think you should clamp to reasonable limits for your device if you
want to do this.

Jason

