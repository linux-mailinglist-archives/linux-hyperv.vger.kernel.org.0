Return-Path: <linux-hyperv+bounces-9812-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gk2CbFPxmk2IgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9812-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 10:36:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C0341CF1
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 10:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D760930FF3CF
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1863D5255;
	Fri, 27 Mar 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcAh2KPY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AF2FDC30
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Mar 2026 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603724; cv=pass; b=Lm4bEh0Q7nviKsaNXSmHHyG3amgYqmDdfPSvDK9IrVdDFXFyMkTXF3WTheclbWPKyPr+aOBO1E7vTq6xRuEyo7ET6MCeMKrKY/17ZqnYExQDeG6/By/EbC8Xa4gzDTyGYpm2CJRa7AxDimxeTLGc+TpKjBg2X5eTIUwkpz2jghY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603724; c=relaxed/simple;
	bh=7oLMUuPupb+L1Op6HEPLrQmwMosRD4AdfgnjTNss654=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foUAVkxerx+d+LslrdsbuyXjo1NYtrlAiUxRUbZyrbh6tmkp0Ug/vKQA6w4/dUqGi2XvV9KRRiXSkLkcww4ORpCE4KAuXvHP1L/meR0AmuH3nq3OJtAfZZ97z1NpPnL1d+iuQ7TMUv3QGhjrWmKr5Mk48cvJZewGQ4AKQGxlVEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcAh2KPY; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-126ea4b77adso2631768c88.1
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Mar 2026 02:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774603722; cv=none;
        d=google.com; s=arc-20240605;
        b=IfwbWEALQRrGpa3esgowMq9NfYD/ZW6kKXf9OmZOyvTYlae6MD8fiBqV6/D4s8Zf9p
         KH+0saVHldNg7IkvZMD3BBgbCJp98tL253Vasw1OPsBS40BlYVTI/Rpgyvadin8+KIYn
         X3ibOpzh7W7z0Io2FUHNGjrRCvcEQUzH5if3f2YFg3kUyRFv7vryq+Dqd1FVR/Mrg22l
         PKiB2MSdpOlzebSPR1pyjjoMNJwLftwtHJQHWhBdfvuyzeH6f2gz1U6x2VPXEPkt8yl1
         QPNfGZwX5k9mtnCsu3eSI3v9uwtsJHl0gyvQUe8UHEHusO6718OoaKeAa3lCd66GVU93
         DotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTqiO629e4vaqODkR007sl1mWS+CoRfkjGQNvwUfTFI=;
        fh=2o9ucVQChWp/RwluEe+1gw6tPoipKrj6GaIBT87NnZg=;
        b=Cd0lzAwI/p7zHe9w664/tjgKTgiKTW3YNbdGHlKmddvTiMhg525rEhS3PQNugBI4xy
         /CMmKO0YRIIoJIRsrWBv7KewgRiwdrDa1qYAdV7g26SiSY6JSHnSeVHwStCDaCfFJttI
         5mVhiXLFM6F9xFkEUhztZlFG3wle1Q+U+xnPTM5EgQIOtnxp6wi1+nGOArAAZ3p7K1uv
         SNL6oMPO1EpPv4HeKVB5xMUFr3irUmPhKftOZQVgcfLGcBoa4P6Wyod/agXTz+Qpbw0H
         bDHkkjh08PUzDQ7OtRSD9aqSs4vAqjrBB/8ux4dJaPzEaZheVDrYU3VMufOLI3QiU3nr
         RJJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774603722; x=1775208522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTqiO629e4vaqODkR007sl1mWS+CoRfkjGQNvwUfTFI=;
        b=bcAh2KPY7DVV53wrCWqbstN8Nm2lG55KlGyecFWRjygDEIUDAqrJvw/RZhyacvPDdQ
         CLnzDFsSjzaFb6V9FObVIZQ1INNNKrNv5iGQgFHeEfIOr4C+hOqn61e2q722t3xFzIw5
         rUQmuMZ9mahU7nfvdttJpy/ms2DbFegySeJXDo/6bI1H7WD4oYXJehvpV7G0jkP5eF6R
         hl3qUzqd+KheJ+5FHUX655rzUT4yxp37mvEwIWjsRehpTekCp0gt6fysDbkMN062kr+h
         KVTL94nYl+3OqrR5vgJtl2dL8cEiYtz0asy6ar9a4n9t0LppmU9MeuaMse+msuApepzC
         j0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603722; x=1775208522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTqiO629e4vaqODkR007sl1mWS+CoRfkjGQNvwUfTFI=;
        b=RBErIj/hEXHnXs0RKSfdlQbB0NtQrBcbtx/YlDnb8Yh+Wu0NK6ynuNGf4lOV0jDX9Q
         09mAeAQj3Ry0MZCFRzYRg7IRG0HjiNnBU65rucDoilX5IOH/P38taxRYnMTJ/jAKj/bo
         EVJfi/qUCi3AF9Nl9iBTbB8rhOF8w3WHCcMU6bBamxRiAHUbePK+u/SzOk1131nrT+U7
         K+UIqDvi3LPuGcHZ+r/091LUj5AQoUobGAb9WpfLeB7mnrkfBFPd1IT5dYf3hkbascfn
         EfzYEYXl6p/xiQO1LaHeVNgWdG2klCgFLpiNxd7m30smrL1w81ppbik0alhMJMy1sVYZ
         RbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTfY4trxLrxzkdd2PEBmqYalOUuA7J5aMY0mI1UdKJ6SM0DXZrjA6B2mrJfniaG+noBP8W1CpfEsfJAV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdxbAyD1IvUvDkadBk7ZL2BvP14fhk6HNO60RbdfZlnLRbFcH
	Dn1pKGGAeLZMnccPRhT78Venwhy3/cP/5R9aF5IjBjdAktpD0bRrKq+IWNV+wOxA2x9OKimFhZS
	A4yHgm4OUdA/wjyG3/xQwA1CNogSghO0=
X-Gm-Gg: ATEYQzxdm5iQ+T2PwTmlwpCibhM0Re/NlFFFK9mKUou1PNZ0CNngE79Z1rtJKYXPkn7
	I9VqoJ1CY6AVirX5SfGNBslKBRKgLFW+ivajUk2wf+qyVAJOezaD2d712JVrwwY7QvPMSrTm4M8
	XVRvEx24A/KvwWjKeFZNEHCm/pERsRHUci2+uQ8WbuByoLtdEiqJlR0wg9MiWhu85H8Yv5RR4HA
	m73sg1238FC14GjpFw8xz3X4tu0eZ8G3/CtOaVEN2GUodbj7f9SihqG0MuWpLqJoEVux3o8FT2W
	uNaPbKI=
X-Received: by 2002:a05:7022:4582:b0:128:bf8d:44d2 with SMTP id
 a92af1059eb24-12ab2857b7fmr889191c88.2.1774603722002; Fri, 27 Mar 2026
 02:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075649.248241-1-tiala@microsoft.com> <20260325092200.GQ814676@unreal>
In-Reply-To: <20260325092200.GQ814676@unreal>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 27 Mar 2026 17:28:23 +0800
X-Gm-Features: AQROBzBLnwHEzC-aBHT7vCI91pnunWW4V0hYH-fhfBRc9lS9WxOctI5Y8moHTkE
Message-ID: <CAMvTesCoRHcKip51j9H_WdyL0ggHMDaHUtwyEGo_w5n4=54_VQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA transfers
To: Leon Romanovsky <leon@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, 
	vdso@hexbites.dev, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9812-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,samsung.com,arm.com,lists.linux.dev,vger.kernel.org,infradead.org,hexbites.dev,outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 830C0341CF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 5:22=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Mar 25, 2026 at 03:56:49AM -0400, Tianyu Lan wrote:
> > Hyper-V provides Confidential VMBus to communicate between
> > device model and device guest driver via encrypted/private
> > memory in Confidential VM. The device model is in OpenHCL
> > (https://openvmm.dev/guide/user_guide/openhcl.html) that
> > plays the paravisor role.
> >
> > For a VMBus device, there are two communication methods to
> > talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> > DMA transfer.
> >
> > The Confidential VMBus Ring buffer has been upstreamed by
> > Roman Kisel(commit 6802d8af47d1).
> >
> > The dynamic DMA transition of VMBus device normally goes
> > through DMA core and it uses SWIOTLB as bounce buffer in
> > a CoCo VM.
> >
> > The Confidential VMBus device can do DMA directly to
> > private/encrypted memory. Because the swiotlb is decrypted
> > memory, the DMA transfer must not be bounced through the
> > swiotlb, so as to preserve confidentiality. This is different
> > from the default for Linux CoCo VMs, so disable the VMBus
> > device's use of swiotlb.
> >
> > Expose swiotlb_dev_disable() from DMA Core to disable
> > bounce buffer for device.
>
> It feels awkward and like a layering violation to let arbitrary kernel
> drivers manipulate SWIOTLB, which sits beneath the DMA core.
>

Hi Leon:
     Thanks for your review. I will try other way since now DMA core has
not stand way to disable device swiotlb.

--=20
Thanks
Tianyu Lan

