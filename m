Return-Path: <linux-hyperv+bounces-11460-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rm53LQu8H2q4pAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11460-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 07:30:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE663447F
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 07:30:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J2jm6rRI;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11460-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11460-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39DB2300CC37
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7E37996C;
	Wed,  3 Jun 2026 05:29:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F417376464
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jun 2026 05:29:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464585; cv=pass; b=UJ48a+ONMMCOpJZJJU4gkkem0ZhsOoLr3cTXURPx56SJiScSR4B1jV2NQYK2TX2EmtZWrIuLAneTB1hAlkhEiYiIMW1Lob2K5qTTJ4iRBmtJBQYdYy1LV+jKK4TIHELTxCV0ci9LvAsbmEUZES42q4CBXfc8VkLjpoepoqJvVTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464585; c=relaxed/simple;
	bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IumTQm6pqwbbcgRojr0Eu+HJ1P5o9Sw6kU4zta1KJ+loQbSWXHqTz1d/qlgWJA2nxhEg2X67fptRjFgsNfDHIPp9orHv4V1ixRH7aIHaAMcwxkCTxR50cXpuGhiINsrPHeHan1hD7rB2MeBqD8KZ67Pp1rQLp47KDHnshF55AiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2jm6rRI; arc=pass smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65eb226b1ceso12705253d50.0
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Jun 2026 22:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780464583; cv=none;
        d=google.com; s=arc-20240605;
        b=VGkTIlgpeVi0VYHhfwAti4lQVJc508Car7talNOkligumET0RtVVw7LCiA7foOVUm6
         QF9Bjo1Uk1WQejJNmXCJG77fU4Z1yVPvb0i58DD5CgTYPtG/ZMfNR7BCp3ZKLtfzPUXu
         WysDNGD+WfPkFPxdcnNhYUwYV0oRYNX0NwFBQYvD2Zz0Xj2tAfYdXXsnvQoIJMi+VhBW
         xo0unWiB1sAIklLeQJbS1qC3M0NvwbnAqQ/52UdjttFjYrLQF6+dXtY426yTm0G5HCnB
         cwAA/9opklL+qH9JClm0L3vkjJ7bXC36erUNwsJO3XEDiidsMmMSWmTHbJe/1NbN2sP/
         n7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        fh=Et7QYdQr6DzADdVbrocgKrHMBT9Fhfz77kP+w+3x7Jc=;
        b=lPEIat1zwvgVB3fcKaSOpomEP1qnZFtBDkQ6oBvXXWMmZfHvReeGtXtkX2mhHHx5a5
         eFf+zoWaveDCVF5Ak+f10+q+YC594TsNWK4NBYNnSDMiwjNOSvni2WbrOiVH/tCBOncI
         ZrS9NrhHJKAaHKMYVw9CJYLN1s6KvZN+Tl48+LKgyFKhPpSknOsmO4WIkAOT1Ix1Zp4y
         O6O2MtD98GZYyqa5buKAQOZJ3VxOvp8KC24Gq2RQckRaudnQunL8m8hmnUB734pchVWy
         wqGRcTL4FYzXDxZObTS+/xdhTHMDk1wmNAFffNoHwkG2o85E/oZiTGiVyIroQsh/bz7k
         yBfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780464583; x=1781069383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        b=J2jm6rRIZj2zRdB8XCHuo9IqWk+9TVP+MwA9DrupQ3m7exO4eNX3O/6iDvr7axLuAw
         VaynVLRzB/PP/0R61WveRyPuxbuLRgYf/L6RaJVb1XMGE5yv8lHl9jEuFK9mYGsghNUW
         0/TTB2BCJjNyFdKekcPHHcccx6Y4amE5oJNYnp0Z7s5QvXQ4QaOmi7FyidU2OCey/IqX
         Ys62GRofGN9AqMX2pJosjZqZXsQSROGSlLWbCafTkIEIQpXPwiR3XobtXTTMRB2MJmG5
         zBAd9Rm85DUzxz7qm3nL99QyTft5ndxNcsOsB1ldoNKGtmpv2gOzAGMhqlRGIWuUF0K7
         q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464583; x=1781069383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        b=Qgnft1IicRUsEHeDPRD1sNpN308UlSvsxtHth9pzExBweElDatmEfU4PN47AN53M4Z
         qE/c/ssQtWexC6sAHHdmLlRFgFJud1tUWPnJy6oI3vf4LPJotBhMmWQSs6MzC2sW53FE
         Enc+aEwrJ7gcF9saOcbSi3kwbi7VAhI+ByRLlH9RbhKfJ/dA1UMzKKwjB9PJq3NPpncu
         1BMZ/iP3ddl8MQxxRmQ4qjKBH2VPOI4ikjea/HYXF0+thsPrZscy8wxRs0TEn54FPQc+
         iuL5g3d4CxvCDSjtEnsx32nFVuOYu+++Wv0/9xdZpUjUlW+XbxNPeL+cJAMjRdVdUr2v
         nb5w==
X-Forwarded-Encrypted: i=1; AFNElJ/2OXKBWA44jWiMz7YJB0V84BCvZCssEMzswLaP7C6PmVNzvXgIYODBjNDxsAxtekk7m8Av4xFwuQ1N3ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5IAEWmdyRaHtQerDkcpAiWtzu+UhbAh0GnpoRiU138BL99j6
	md64+H3TbWfRzmVEQTHEBtfhv+1Ka8TNyG+BJs/mtcFeNutpyMgj4X6X/q3bblcKTMN/CNquIYN
	CqO4q7Il6t//aHqTrN5YyvS0mqHzC3RE=
X-Gm-Gg: Acq92OG8bx0x7eejLN6257L2bSB/3/qDw7jGCqFVmeUsxH+jCxbrKjuG6vOk7+m5Gky
	k0CYW2GKkOfJJkcaFfQ1tOH7n52hmX6cNXdDuxbCj/oztO6i6W5fiR9QvqZYorSs6xEBKbjxWGQ
	k5TBcMn8/ZUcY5Kbwc3IxUAHgsFpVANHEgmBsL+yQLy5WCei8vpBUbxmS9+XiEIDaHJn9NQm07f
	t723GZS0Lr8EpOGQisoyfZ3iDZvUBPzESFaFWzgsiURKNr54L3hprnUZ53svx09GvylZLlAFanY
	UZw6uB7oVGNRMZJkp5oD
X-Received: by 2002:a05:690e:408b:b0:651:b2e4:63c1 with SMTP id
 956f58d0204a3-660dd530b47mr1468054d50.22.1780464583418; Tue, 02 Jun 2026
 22:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602155210.90987-1-leontyevanton1995@gmail.com> <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
In-Reply-To: <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
From: Anton Leontev <leontyevantony@gmail.com>
Date: Wed, 3 Jun 2026 08:29:41 +0300
X-Gm-Features: AVHnY4JnwoCsNKa6ADnSbG6NTG6nP0KaPkNGbMnFr4WC0wsdE_B23uevxeXo304
Message-ID: <CAAN-wAkSjVbfzto+Pi4-OLt2vXyzeCNpqhen2VQFA+VCFH2HrA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11460-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@microsoft.com,m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17EE663447F

>
>
>
> > -----Original Message-----
> > From: LeantionX <leontyevantony@gmail.com>
> > Sent: Tuesday, June 2, 2026 11:52 AM
> > To: netdev@vger.kernel.org
> > Cc: linux-hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> > andrew+netdev@lunn.ch; kuba@kernel.org; pabeni@redhat.com;
> > edumazet@google.com; davem@davemloft.net; stable@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Anton Leontev <leontyevantony@gmail.com>
> > Subject: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in
> > netvsc_copy_to_send_buf
> >
> > [You don't often get email from leontyevantony@gmail.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Anton Leontev <leontyevantony@gmail.com>
> >
> > netvsc_copy_to_send_buf() copies skb fragment pages into the shared
> > VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
> > x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
> > for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
> > address that has no kernel page table entry and lies outside the
> > kernel direct map, so the subsequent memcpy() faults. As this happens
> > on the transmit softirq path, the fault is fatal.
> Please include the stack trace in patch description.
>
> > A HIGHMEM fragment reaches this path whenever the page backing an skb
> > fragment lives above the LOWMEM boundary, which is common on a 32-bit
> > guest with several GiB of RAM (for example when the in-kernel NFS
> > server splices page cache pages directly into the reply skb).
> >
> > Map the fragment page on demand with kmap_local_page()/kunmap_local()
> > instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
> > described by the page buffer entry. On configurations without HIGHMEM
> > (amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
> > page_address(), so this is a no-op there.
>
> So, on 64bit kernel, it has no performance impact?
>
> Thanks,
> - Haiyang
>

Correct. On 64-bit (and any !CONFIG_HIGHMEM config) all pages are
permanently present in the kernel direct map, so kmap_local_page()
folds to page_address() and kunmap_local() is a no-op. The generated
code is therefore equivalent to the previous direct-map access, with
no extra mapping cost on the tx path.

The kmap is only meaningful on 32-bit CONFIG_HIGHMEM, where the
fragment page may live above the LOWMEM boundary and the old
phys_to_virt() result is invalid.

Thanks,
Anton

