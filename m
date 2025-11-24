Return-Path: <linux-hyperv+bounces-7806-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561CC81C8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A55A734208C
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229352C159A;
	Mon, 24 Nov 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im4OP44f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147629CB48
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003891; cv=none; b=uKpaNTr1oNUZd/ACi+xr5GhkGvzJlAcDcfXE9Rd/MwtMsuM4CE3actY8yLO91ztEkYH4EJYBIsZbNBhv8NcgRF2tj5Z+4ZlFcsxsQyCoN82st1lSm3kUHHwa4PCMR+/c7STDTXW9DxGRCQsmL+tYViDqhUCJp83F/4NOjXTrv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003891; c=relaxed/simple;
	bh=ni6ryahXA4WhKdPgeajWMOfblZG+42XfxR7yeQeGziE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7w2neqdEUGz0CJCwUqidSQQWfi9/zG3JN0+j2XRbC32fgqPobwaaUnvhL5lKdp0Bj6F23feEwiIMURnr9y02w7KEi+dgJA790tmbfIHwlLh4z6JtSSgutNbTiwYKRBSrlG/7Q6PLVW71kdvOBJVzog9OZBk4E7wcDIGnlVCBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im4OP44f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A61C19425
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003890;
	bh=ni6ryahXA4WhKdPgeajWMOfblZG+42XfxR7yeQeGziE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=im4OP44fxcV8oBiXqMZXwaFtVS4yC5hoDr6iH4M/56YLQZOOKaRle7OQov/Qnlgpc
	 pweOpV/Qx9+TaPNP1i64KV9t0z1kwKpRZHEl/J3XlJC+cR+wqtv3oO8T3HsjEmhsrU
	 ZtVBinn//9N8lupqgYuMpHVTmkr/1WpTaxJqeZFFs5ZzEB/cnxrzd6v+Cv9nfPUHID
	 p7UIXEGSLpaf/Q67sQEMT1wDqa7UVI7zjqvecNs5hfGGIYGz+6abqQqYBsgMSYc7qn
	 XhyxLD1u4+AfK9rfCUrFTgWqsCPefTxj02aekr97RvlQqXNTGyPfxQk2KneFbFI/b6
	 uJjshK0d7lslQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957e017378so4729674e87.3
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 09:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4Qv+gUsX67J86Ep3smD8cQRX2sCEyAE9nb94u7bD62V3XXlxaUoY7PCyLle7QBXS8OG9ydZJkbBLcoKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3lR6N4YCqR6eoQZBTpTysDT1mmid55p8Nk4EwQ8v6FmYe5VY
	abiECUE7pI9WwQr3rD2niFc3D+VbM6SsEAqvzSIr4K0JCsxrMgnDQgO/FkLplyeqFSXa7XM0AIy
	2vTZSaKWyYZ7dkXrQ3UtLfhhPjGTWBFo=
X-Google-Smtp-Source: AGHT+IGGU4X2n28nXl03AZEGYJ2qP+YdFmcNyxyi9o9xFWaX9qXe+5YYYmW9XiGzz0iE7mMdFpmgf1MgItGyyi+uahA=
X-Received: by 2002:a05:6512:1282:b0:594:4c90:8415 with SMTP id
 2adb3069b0e04-596a3edab39mr4528817e87.27.1764003889213; Mon, 24 Nov 2025
 09:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124165116.502813-1-tzimmermann@suse.de> <20251124165116.502813-9-tzimmermann@suse.de>
 <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
In-Reply-To: <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 24 Nov 2025 18:04:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtsneE3dFgUx6Hd=iBhD8YpvjfTSi-KZpuNaXfX07KyA@mail.gmail.com>
X-Gm-Features: AWmQ_bkKMcK7WGWFCCrQ1b9TEIPkREY9pqhPyguPzmrEL1z0shGOixam-7jvNpI
Message-ID: <CAMj1kXFtsneE3dFgUx6Hd=iBhD8YpvjfTSi-KZpuNaXfX07KyA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] efi: Support EDID information
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 18:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 24 Nov 2025 at 17:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Add LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID to the list of config-table
> > UUIDs. Read sysfb_primary_display from the entry. The UUID has been
> > generated with uuidgen.
> >
> > Still support LINUX_EFI_SCREEN_INFO_TABLE_GUID as fallback in case an
> > older boot loader invokes the kernel.
> >
> > If CONFIG_FIRMWARE_EDID=n, EDID information is disabled.
> >
> > Make the Kconfig symbol CONFIG_FIRMWARE_EDID available with EFI. Setting
> > the value to 'n' disables EDID support.
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Why are we adding a new config table again?
>
>

Note that LINUX_EFI_SCREEN_INFO_TABLE_GUID is internal ABI only
between the EFI stub and the core kernel.

