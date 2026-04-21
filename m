Return-Path: <linux-hyperv+bounces-10259-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIf9MqYe52mY4AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10259-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 08:52:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBC4372B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2B0B30060A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F7B284690;
	Tue, 21 Apr 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="rq9cuXKn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902027F01E
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754337; cv=pass; b=YuTJzhX2ucuOQn+HIKZJlSb4X7uHtdgZA4YgopjEHVwkL7LyFCtw5VaZisYy9RCeIoQymHVYqUpiDXPeq1WMusIuhy6WtpDr1B6M+5kqeyLOJ7316TR3v9qCnRlKg6cMFcMltZLjVWhglZeNuBC3TfzCs4svBE3dtqlKTiGY/Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754337; c=relaxed/simple;
	bh=/bgB+q41EPoWiHWc4t7T/MJYgD7V/pLVyjw45I/8+X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gib/tDG+hnpayc2tWr8ent99/75JOP8LOu8Uxa+VGUHdci8n+LXrm7nCx7zWeMSolV3eGVYu5Wbv35uCL3PDKsbvWwhtEhWoikkDgHmgMtzNFZFCtlN1oZm2vKjGMxMq+q5RZZ4yQPtitNC4+H0IMOoTR2PuhwV/6ZD9xQQ4okg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=rq9cuXKn; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D3763F9B4
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 06:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776754333;
	bh=D+RL2CG72Gfe4A5JJhIqbBZ1B82PnGlL44VaM7GQN14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rq9cuXKnzRJBfhOWlWQjvt+QbiUwT80D/CkiJF2yFTLjQyXdvOKRTBaJxa8beEnez
	 hgk7Ay5QYV2SIt5e9N6TvF/YKExOgwF3vQd4nxMREd3nlocbWuPgeKrv2t5Fzvhxim
	 /0aWdu0SgPbBOi4+ru30Qy9eyMNGK8f9tU6o3/8p/NQKZdZvLMtIJBI5yum0Da1o/S
	 xcvW8btU+BAEL1a/zNefYiCD/EUyvS7tkajM9c1WYEs2BKFpgMOMuI81b+hv/0No+P
	 C2aX17Dd4QpWkwCPQzYd3Wm6Sh8xQYClTIEfhCBPZm79MuKdMlzIW44gpAXtxfK6FE
	 kD4H93RZ4Bf1p8WVVF0cO1sFWnhpGgLJxwEZwz2WUewxWzpgMYY9S1cSc+TFzU0tMi
	 4nLh7Obx/bIyBlx7HHHOjjqPXP/trd8Q75xTNrlrPi81GzmxTnRmOlqR6TIdymwtdE
	 pt9VG/cJs0+Yqa8279GGE1XxccJoWb0ODk8uClNAtEay3i6en9IMQA97oVULxLF85c
	 k69Da1ifZXEJy34YJa3UPi3NKCwLJOWSfmpaD1IFn/CZMVfVNW3dr2V04h65a9o4a2
	 bB5knpuH8Kr2SWb+V+JamMn8wwd+7XdXhwyzQvsRLQbXQt9XIl1REn0NPBVSjuowI/
	 0qOo/sfxC+JtYmSEnyxWQ+Kc=
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7a3715e9e69so141833347b3.0
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Apr 2026 23:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776754331; cv=none;
        d=google.com; s=arc-20240605;
        b=Cxhms/gOahRlufR4HI7qTVEqcRn/R0Lsj2/XW91+GWhHT2N3nnmX1sP2f4Y3+p6URH
         tt1WwBJ0ZbZSKjzv3jPZ9EX468iJZZCxjs2Zqy5DIljIza0hLXRgOiGwslEDs6CWLsVd
         29o+T+6i1CiZu/zVts4TxneePnw+uR0uLq0SJ8gBJWfSVGsFA4l8pX6QniMKis/OnI/c
         NSj/Fm4dzrTndH/1eWe1mUzIGP80UYT+B9q8wEtj/bWPcRXPATK/WCeCurNSjAZ2IquQ
         bzirLxwAdw1uCMtiPexJ40QaexCHc+MnPMeU41CwgyAx5d4b8TetKcO7MKqcHrR5swUr
         dhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=D+RL2CG72Gfe4A5JJhIqbBZ1B82PnGlL44VaM7GQN14=;
        fh=5ISMVAKWCH1D5xGaOhhmUpUAXCa8YZBwJbqvgvlRBIM=;
        b=P45zrK+qUdu9BfUgVdw9u8V2U6Kt+jlfFRxC+8u+lC8lMMgeRlsViy4SsF5SLYkHk0
         3LcPdJ9+Jyj/+LJSRomgMsikG/zdfy2NTUNvT/W8ePXzXvA60GeUquyria8vXxPjEvgK
         47UKtveryWZJf2O+0MvkHX7FB02OFZ49NRUISFkwnc6tOd1Gh/DF7CkAERfHOU2NGHXe
         KYDqctSxuOC6bT4Wb5dchedCyUjcx+/mVJG+GzLtKQ2BlWunnSar5xQroXVVBW2Fwcgw
         SFErE5jjZeRIvYuh2YQQrhmTqyq5UCK3WynxmJk4zBuXnV1cWnEcZ0Waa3PpDBiRTJ6L
         2KlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754331; x=1777359131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+RL2CG72Gfe4A5JJhIqbBZ1B82PnGlL44VaM7GQN14=;
        b=ag7jAuJ9GEjGZ04DNGA/p6/sV02LbsDDZrpRkAoGSXaoVJY2Zw3cQRz9IJ/CGD6DBr
         9fa1CeSpsYwXL/yosj8d/ZZA1VHgZDnzJU/VBerFgzdrcTDRpsHhr2INQcy4ttUTNosY
         aGE0BDPxlfc4aT6UXFhG/OplCo6fxExxf9ZkvCy9wTn1H6TCcGVS4ByKcLA/4iWO5Bjk
         1F63EYM9RbpKj949Evv8Iz/9/IhL1OYzw79EVvsWreuY6/tTWPJYi2Kbkt2x2LVUREdB
         8iABGhGg+LgVX62P9mTfbuI8WrqZ4ibxbgMWEM8RPx8wG4yXKXEsj190QloS9tlF/F45
         A1Nw==
X-Forwarded-Encrypted: i=1; AFNElJ9DjKVcA9BG7SuJ4dSxMy/JCYtoWcb0JIY/9xhqFgkssZ0KqUm984yVQ3bLV78tN0c8UPnIvISOcd3I/bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwlv9Qj94Wc89QWk6HwS96Ocs339uXdaE1UdQzP4yvCTL2InLT
	ZcE7l5XzfleAbNGXU18HnA82/EB77kQ8U7YYm5OXoh63rFooB0fl71LuHicfxXXpdoqkRJkhKLu
	/R1zqg/a/nvGL4S9tpvKj+PLrv96pAeFXx9wRkt9UNTLNsFcCqhYrlK/gekcGg/OG1GqGuRfA/j
	ReasSWHGxYWARQpvsAMfeRR61f6ZS7bPH+JfjWl8rS8u5zyrDsC9Sw26AK
X-Gm-Gg: AeBDietHN7PqIucEMJ1OsxsyrVQ15L6YgQTgnF3HgFPvZHdFKm/7XCzwN2C22tL45k2
	6nCt1eod3qrA4zknF97cDrgxHMjMLh68SouBVoE9nvuhgYetZWMvmq6azo6u6digqKotvXrPCHi
	4/hVSB5pkulmE7sSF06VbtVYuLv3+VuBrFiKfFn/Ma5jyDRIQ7mb2LI10Cgx+asc00cKDfvkgGB
	SmTofU4uiT0Ojctrg==
X-Received: by 2002:a05:690e:b81:b0:651:c221:9649 with SMTP id 956f58d0204a3-65311aa1c92mr11125985d50.19.1776754331515;
        Mon, 20 Apr 2026 23:52:11 -0700 (PDT)
X-Received: by 2002:a05:690e:b81:b0:651:c221:9649 with SMTP id
 956f58d0204a3-65311aa1c92mr11125976d50.19.1776754331172; Mon, 20 Apr 2026
 23:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416183529.838321-1-decui@microsoft.com> <aeKW4ESwsoK5La-t@templeofstupid.com>
In-Reply-To: <aeKW4ESwsoK5La-t@templeofstupid.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Tue, 21 Apr 2026 18:51:59 +1200
X-Gm-Features: AQROBzCOYLS9ahTqhC3AsFYzvmOgcBzj6fluavm1dAXUvzYAks3nnodb2akIFHc
Message-ID: <CAKAwkKtNGC9QcRVkyChDnR+1j1GA1ncUpKMspMcmt_kisjbmRA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhklinux@outlook.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_FROM(0.00)[bounces-10259-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.ruffell@canonical.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[templeofstupid.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,canonical.com:dkim,canonical.com:email]
X-Rspamd-Queue-Id: CDFBC4372B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Dexuan for all your hard work and analysis on this patch.

I have tested this patch on Azure with:
- Standard_D4ads_v5
- Standard_D4ads_v6

with the following images:
"Ubuntu Server 22.04 LTS - x64 Gen2"
"Ubuntu Server 24.04 LTS - x64 Gen2"

with the following kernels:
- 7.1 merge window at c1f49dea2b8f335813d3b348fd39117fb8efb428
- 7.1 merge window at c1f49dea2b8f335813d3b348fd39117fb8efb428 + this patch

Without this patch, I could reproduce the issue on 22.04 + v6 based instance
types.

I can confirm that with this patch, v6 instance types can correctly kdump and
create a vmcore correctly and restart correctly without running into
MMIO issues.

I can confirm that with this patch, v5 instance types continue to operate the
same as they did previously.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

On Sat, 18 Apr 2026 at 08:24, Krister Johansen <kjlx@templeofstupid.com> wrote:
>
> On Thu, Apr 16, 2026 at 11:35:29AM -0700, Dexuan Cui wrote:
> > If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the
> > framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1],
> > there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv.
> > This is especially an issue if pci-hyperv is built-in and hyperv_drm is
> > built as a module. Consequently, the kdump kernel fails to detect PCI
> > devices via pci-hyperv, and may fail to mount the root file system,
> > which may reside in a NVMe disk.
> >
> > On Gen2 VMs, if the screen.lfb_base is 0 in the kdump kernel, fall
> > back to the low MMIO base, which should be equal to the framebuffer
> > MMIO base (Tested on x64 Windows Server 2016, and on x64 and ARM64 Windows
> > Server 2025 and on Azure) [2]. In the first kernel, screen.lfb_base
> > is not 0; if the user specifies a high resolution, it's not enough to
> > only reserve 8MB: in this case, reserve half of the space below 4GB, but
> > cap the reservation to 128MB, which is the required framebuffer size of
> > the highest resolution 7680*4320 supported by Hyper-V.
> >
> > Add the cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) check, because a CoCo
> > VM (i.e. Confidential VM) on Hyper-V doesn't have any framebuffer
> > device, so there is no need to reserve any MMIO for it.
> >
> > While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> > the > to >=. Here the 'end' is an inclusive end (typically, it's
> > 0xFFFF_FFFF).
> >
> > [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> > [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> >
> > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
>
> Thanks for the updated patch.  I tested this on the arm64 instances that
> had been failing and was able to confirm that without it present the
> failure still occurred, but with the new patch networking was able to
> attach correctly in the dump environment and kdumps were successful.
>
> Tested-by: Krister Johansen <kjlx@templeofstupid.com>
>
> -K

