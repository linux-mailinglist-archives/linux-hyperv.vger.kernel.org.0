Return-Path: <linux-hyperv+bounces-11956-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qTxdIOH0VGrehwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11956-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 16:23:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698274C565
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 16:23:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mbMcYpft;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11956-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11956-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33DE33030061
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C72431E5F;
	Mon, 13 Jul 2026 14:22:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CA3EBF1A
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 14:22:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952524; cv=pass; b=PWIWhxtbZZkGi68ZnZinUSN9c28lwySvrLWBeMmDscaO05NQW3BG3t0Aa0jzar0hgtFNNvhYf5Yqnnps5iVt2uR14bJunFSFT/EPQfxAKc+1FFVdBcfTVndKBLAuoGF/VEtoB/xm96Bgj86W19oxkb8a+XyRMnHly0ml3PCjRok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952524; c=relaxed/simple;
	bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoeZCQlLtntbOpZWqfHw6UB2DJ8h24dyTlszJuAdsNRpPvmixTaXcTsRSAKn5FnLUT76HpT/yrbQWoPVBAYOHRD2vu/bkn9UCqSSJKgfcON2hOM8ZkcS/oSO5EOwAIqinyK9yEFVMsE41RV/xTdnPbupRNebwBkLwbyEkfxrfOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbMcYpft; arc=pass smtp.client-ip=209.85.210.49
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb68bdf53aso1274540a34.3
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 07:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952522; cv=none;
        d=google.com; s=arc-20260327;
        b=L/0gyIBOOVvKEEEXWNPRJNF+D433A1Dxm5rFnWM6XGQ+8AcghMq6ZOeMdTMtEhryRk
         fiwxPwU0Or2eo0ESvmdEJRkboVE/MXTaXNO6o3ieyBXh0DG24nzb6hHiSAzAfD+z9xuz
         jTRrsFcgyIf+ToE+/RixooIu9Q8QV4AmOOkHdAdeWryXAG6zACWRDcg3/kFSqDSvBCNH
         mLiYS68WR76uTTmrrB62h0oebOo232LrCM0L2oubaU9tQ6+gIyAgnu9aTFEGRMPrgVLe
         CCxwc2BaTfBRWB4e0VA6FSi2FtgqDeIhNqUTiivkJ0SBCeHJUA8/E3mmf4X7hebtTieQ
         fa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
        fh=wD69K7wY18rg83B6Q5UX4S3E9umZse9MnlXK//5ib+w=;
        b=QUjsPmCTyjwd4BxFKfNtXF6O4QMQMcmF66CLGpSY6u68oLhWon8Li9ZrY6/H4dqrFV
         b0UVFw2Xih+6xZyDFaCtW3eOUPVBa9PBpUgogtKUEOXHHjR0o+BUlKti8TeqXdIcwcQv
         Sc96AGBaK5TsFaVdsV1slY9wgNUpWlFwSwWXEBwT80lby6F5JqtxtBqMJUFLkZRH1ixY
         OVKeEinNv46fICVaZx6qSP5ADk79nrXrKmRMblJegP6r7BTu3vx2n0rd73BczVQuc8xp
         csSb4nKdBCC2P5kqINaE4BAMmvUq6OHbqDzOLzgjcllv+i+oVEEHcuneBANVNO3zVw5n
         vaAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783952522; x=1784557322; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
        b=mbMcYpftkDZ2ZtLZh4m0AogZrclCBh2dI5bsx34XXCKC89vh/6RvkLRc7r9AQTt6WG
         aJHic08kjKADhXf3TDme7J2Kry1G5J8sqoiZmeSCt/BY9gLrYNcXcZHqZWbeospx0k40
         rbLv22rd0CnrxjY7KssB1n5e110n8KzfVjKep1iO/pKmvTQ0M3U4gv1szdw7EfwhsjY0
         JUN45n2CEZlsvF8QUhfPaMKWi0IosrjZ/KU6t9a77G2JXPI/KgSG5rGW7Q0q4yQL+3gY
         OFLWJF/WOIuCbBAwLd7HIFSB6WDfQ7ylba+ALeE9VPfv+Ml5tkUuCkk1ENSt6EsZtrPH
         dP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783952522; x=1784557322;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
        b=SRmbnkYKcqvfr2Ozjm+YlGhLHzperPZ7QeK4mzrXgxFNg5116srwiHtT6abnXgApZq
         gQZpLje9AVlpAq039KmHLeMJydUm3P5oFflWWcwADMWFSzT7dWDw2tqLovd+G7NQqmQk
         8/gNP0eeLyCIoQpFWMS4gCkM6QKTgi7HRosq5+EPR8V/rWUL+W0wsdRrIoNm8JcHkLjD
         XgJvChiBlZxeqmCumZhLp1V0xGiRXRxxRNBLjwV9mg9Q6yfglH5QApgmtw+DNIUTGiq2
         BZhuJPYCLsFJlmcIN25YvNHAyWM5m6SLkajtgWhCIVbdhlviIHLufHT5DRZe/7LM9ZLq
         qZ5w==
X-Forwarded-Encrypted: i=1; AFNElJ+vvNooFuwEZAhlpBUScCh+Ea2u6HqzDt2LpgBGUftLX2w4u6h7QiDN6Bo255V2Aip6UtuSc3vNVwQV8aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOWh2JN5n3xqXJ/IndCTJhi+1Alk0olwG3VfAX/ov+pEPmVCy
	+CIqOCSGQNIx0nrXzGwMouArJ8poMb2oQqeWJhAr2FhYnQnUntwSb0ej4lqSfKvYSgjBbTzNJnc
	0YxLXsdF5tcHvGn0Plu8On0cCzjUQyxm9S/7XC+cO
X-Gm-Gg: AfdE7ckjf6ZkkmsN8FpC+MXo0g38dNm7Eec40LK0lRfl1OyFHszFzZlMPWKEOTkL7JW
	99OPJv/Ik6j1BQlyq+VMQpG5y98wcemkevs+oReitTSSDMMAanmLeGvP7wo7oFHo8/kMLhDbquM
	RMKVq2s6Svvt/WGy9deJTPnde1R9OyoEfpombY2XDq6d/bpPB3aK4a8IyEf6txseDq9PRQwdqsW
	L9vuyvHhbggTCpz04hX63ZpbtrHBCJMNW86cJRdWwNClc+j/IW0X9UayOSPzG3kEGrXpSWNpA==
X-Received: by 2002:a05:6808:1b0a:b0:497:e619:56a with SMTP id
 5614622812f47-4a42ae75c67mr6356591b6e.25.1783952520941; Mon, 13 Jul 2026
 07:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com> <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
In-Reply-To: <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Mon, 13 Jul 2026 10:21:49 -0400
X-Gm-Features: AVVi8Ceov_xTc7vx5G47OmxMYew4NiGS4svgZ9NnqFn3IOne2mO01SvVqYQIyGE
Message-ID: <CAHYDg1S5jpZY=CRmbcH8MYHzyV4ro4MdzJ2gAj2fhaFfQo-yXA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/bnxt_re: Validate udata before
 destroying resources
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Michael Margolin <mrgolin@amazon.com>, Gal Pressman <gal.pressman@linux.dev>, 
	Yossi Leybovich <sleybo@amazon.com>, Cheng Xu <chengyou@linux.alibaba.com>, 
	Kai Shen <kaishen@linux.alibaba.com>, Chengchang Tang <tangchengchang@huawei.com>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Nelson Escobar <neescoba@cisco.com>, 
	Satish Kharat <satishkh@cisco.com>, Bernard Metzler <bernard.metzler@linux.dev>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-11956-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1698274C565

These changes look good but there is also a call to ib_respond_empty_udata
in bnxt_re_resize_cq (but that method does take input data).

Is that one a problem? I guess the resize could complete but the upper
layers would think it failed if the ib_respond_empty_udata call fails?

Reviewed-by: Jacob Moroni <jmoroni@google.com>

