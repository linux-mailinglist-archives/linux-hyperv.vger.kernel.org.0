Return-Path: <linux-hyperv+bounces-10379-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHmwAxcQ7mndqQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10379-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2026 15:16:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3BF469EA2
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2026 15:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922C2300CC19
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2026 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6D361678;
	Sun, 26 Apr 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ic6KsYgG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5E359A67
	for <linux-hyperv@vger.kernel.org>; Sun, 26 Apr 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209360; cv=none; b=vDLRRBzoeFa5QYfkLBrB/QxEGQsB46ot8/NXCu3lH00vByF/3qHLrwTzeuvzoQ0rPQ8Orltn5iKaY9T/WRtrRgamcx7WHSySH+eJI17wvq+MEial3dWRWFFoSh9LzvUbQOKuyb1h4eq0muYeXHSwu/ayIjVVk3YrnoZfyEZ6JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209360; c=relaxed/simple;
	bh=eyKjK9DnmrMAk5/TDuX9Ob6Z7Uj0pC06AmilCu18QOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8qXuwywAkcRJKLMLtKXL8AIS38INbn5u8IJzzWKxGtyvQOE+4OEM+mz4GeqZKs1JDZWmSBcnmb1NQ5EXqUExP/N0i9daYDAZPMbjd6vCrDFoTJY7QjUkmUikS8W4BnZABVeoeItwrNpNNnEt6Wlg9SL3xeQag9k/ygophqwv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ic6KsYgG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50fb8e9a4edso64266651cf.1
        for <linux-hyperv@vger.kernel.org>; Sun, 26 Apr 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777209357; x=1777814157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hWkzkPAt0w9C0nxCrWB+8VxSXZOrmsyO57QsFIVVZU=;
        b=ic6KsYgGNoeG6h9tCNcjsbujNQzxJJBdQFLVtrq4uoMrBDZjWv4JVPLONCdaeiADlL
         d2dXIARFaE48OewbCK18Vo5kc0zTHnjp6AlG++XxlvzhaRBQqNyZusZDZRKxXFsxjWIB
         EJGCXedGJQqWW7fuG4QkW/ut1csHnFgCj9KZC8cpMKbdCMVpfjJv0W1vcLp3c7IQmsVF
         YPoIwmb4i58PrtblLxH/L3OzmRo37Fy+Dckpw5L8GeyT72YVEcqvv+30B/HGQjFcQDKj
         QuFHyhZMUqKiCqE70G+gCI0XZtLleBbo+WAg0HJwsZnbAAMMB/70WEZJtLFk9rlfnj8j
         1mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777209357; x=1777814157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hWkzkPAt0w9C0nxCrWB+8VxSXZOrmsyO57QsFIVVZU=;
        b=IWqcmZFt36LyB3TEvtPzPx/HCndo0an1SnGkhr+UajK0f9e4cFuugCJVYaaxQtHNBZ
         hzn3b5LOCuUVZ55OeAOSvWRULRabs284MOGcoqigAmsv3ZbAZLR4m93rNlljmAMKC+NM
         TUDnis2lFR3RrGMCWAClYCuOxViv5FfZgfe4+2tvdmH+UVq97HIzEg6Op+UslYbum2Ir
         ysBiE/o1peyc17K5OhO+FYdUxjFa6wWIWnIc/xpGMxYyaKgfhXy13E31dSUc7rzeCmfj
         DNvEQ32jICJxz2wSThZ2MphXGIWiqd7DEGj011+knbQtPcaM710PMNkz6KVRmDTSksI1
         CW/A==
X-Forwarded-Encrypted: i=1; AFNElJ/q8O1kQiPTNhOmJMuDCXLHU+1Ys2VHf5fjKy/27rNWSRwBm1/WfWsgej8NTer/fPhHXhOKK96Obx1pslA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEdVykkTFGgZzNPMqcs8VFVv1YKDIZl+BX+O4R+iiXj/BvrtC
	WSMfS9VhAq5YTyYp1bXd1K4B+7RlEG9qluWEao97zHqmqZsSIsnwq/uNnVbovcEcFBE=
X-Gm-Gg: AeBDiesEXPtZ1GD/5LKPmAzCXUN80gn7B/KFNVbKRi4EZepIP5hksClyXagN9nMNX3Q
	QvQNwI9nuQMjokcmch83efoLprUO7R3C++5fcfWBY/6B+IxzIl/B21dacAdRhDtem31smIytoG4
	dCbkifdDCMqhQUUAf4b6q4e0guVD70egzrrw94W6WR5g7A0RHeFZ9MvG+7W83O7nnPsnKzsE2Oc
	9U95DaiTlw9jeI2F6b0gDrIKS9GdWSkE9jfphTj8TCjdcMXumfaNjrkH78HzhkXn+lQViF4UuIk
	hdBnOwI2ZBcvkwzwLHkJvGWsw5Ti2DWE/gjpOcQnGlgKL58HTKxEU2PkFIYbFEv33lwgYv6wTXw
	ELn96XfczQ6yVkNiz2WiyV1GNrOVaQnaldtkPw/AUs2vmVbsx6fzkZzXZEQ+qFSHk0VaSd9bNX1
	MC/al/WnSEIbmBZYHJd9DBp8kDmxHafC2+bqk2ambnTxSiOX2ytGlayfJM4wbcs5PifZHJBYNHh
	JnSaa+F71jZVEJK
X-Received: by 2002:a05:622a:1189:b0:50d:84a7:72d0 with SMTP id d75a77b69052e-50e36e9c0c7mr584902211cf.36.1777209357541;
        Sun, 26 Apr 2026 06:15:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39487921sm230305001cf.24.2026.04.26.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:15:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGzL1-0000000Ejbg-22WN;
	Sun, 26 Apr 2026 10:15:55 -0300
Date: Sun, 26 Apr 2026 10:15:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
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
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <20260426131555.GA3501894@ziepe.ca>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Queue-Id: 6D3BF469EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10379-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 09:16:28AM -0700, Dipayaan Roy wrote:
> During Function Level Reset recovery, the MANA driver reads
> hardware BAR0 registers that may temporarily contain garbage values.
> The SHM (Shared Memory) offset read from GDMA_REG_SHM_OFFSET is used
> to compute gc->shm_base, which is later dereferenced via readl() in
> mana_smc_poll_register(). If the hardware returns an unaligned or
> out-of-range value, the driver must not blindly use it, as this would
> propagate the hardware error into a kernel crash.

It is not what we are calling "hardening" if you are hitting actual
crashes in actual real systems.

"hardening" is the driver defending against actively malicious
hardware, operating in ways that will never be seen in real systems,
attempting to compromise the kernel.

Drivers working around real world broken/buggy/malfunctioning HW is
just entirely normal stuff.

> @@ -73,10 +74,25 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
>  
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >= gc->bar0_size ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u32))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

.. and if it is entirely normal and something that happens is EPROTO
really the right way to deal with this race, or should the driver be
looping somehow until the device stabilizes??

Jason

