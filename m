Return-Path: <linux-hyperv+bounces-641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182F7DA49F
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Oct 2023 03:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B93B2153B
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Oct 2023 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815980C;
	Sat, 28 Oct 2023 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02tPC/ad"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518E644
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Oct 2023 01:20:28 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E51A6
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Oct 2023 18:20:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso394530366b.0
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Oct 2023 18:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698456020; x=1699060820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g5kyZ0hA+DlGKnaeXH//43ksUqY7YG+r7+U+dNLRdo=;
        b=02tPC/adqUNXEVxZdpfa8ChKeGvkNSWpRVTeeriwDB3dnCbPWDuDmMn2QzvwjjVOMO
         qG6bEO6ayaRfFqCvszVNtDuJqNyEvVEwCrXDKOycypIWEsh973JXySVPmzIo8hRwdPZA
         E94KQP/txhxd39BCySswahxLDe48QKo/VKMl3UpsaPqwvp7KxjuHNbPbH/8lKFOVGyJv
         DcxxEPDQYDhwroe+irZ8t8C1rlCwBq4UGDNTyKK9k7acjOMlnnbT4ejkqRXEPEgKX5IQ
         OworsEHTiD3sWxK6l+qkbZbN9DJi6Plbd2VT1olMzM46g4AHriMFFvLH1ySTd4EKyp7P
         Sbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698456020; x=1699060820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g5kyZ0hA+DlGKnaeXH//43ksUqY7YG+r7+U+dNLRdo=;
        b=BW9p6m0tbYR6FTKKEepsuL/SwYNpJJA6iwV6R1uVBY99QBZHFKIHUByZQ+N57LecQW
         t3Lm0cdcMEsa4kuO79DmG7GN201jwwfTb+hUKXYFnAhctw5MxnXJRN8uS6LV8hMzKqEf
         M8InyCNBb6N0hv6kUHc0XREQvgChYQMX20QoMckynda1XvtyTVaN39/JvK51N+S0aNRw
         2RXZadlQqHWFfl5mribAEeDneKd3o0gUU/3Msj5f4/pu95nEGIxy73KpMX3ZfjwQyKa6
         IBRXVsktpzl2KpqkFdwKYHT92jl5DqynMnVpYVJ4ndY3D+GZnHHmQntyBVxuxm8yHTpW
         J+4w==
X-Gm-Message-State: AOJu0Yx8kONGbnZGh/gFykEj0X+Yf/W4xnQRLLq8/CKbBFHoPw2B2Iay
	dl/07ww4XZIkyIoUEpaOG0UI2qz/epqVT7ltAuqH3A==
X-Google-Smtp-Source: AGHT+IHxolWSAC4XvBLAiS8bNkb50iFHz5nOkd4FFLXw/+WDrtcRsN44VBQ67SWxWTbp7GfzFR6SM97u7XxM3x0zW6s=
X-Received: by 2002:a17:906:fe46:b0:9c3:b3cb:29b2 with SMTP id
 wz6-20020a170906fe4600b009c3b3cb29b2mr3275410ejb.42.1698456020364; Fri, 27
 Oct 2023 18:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com>
 <20231027-ethtool_puts_impl-v3-1-3466ac679304@google.com> <8ca4ba13-1bcf-4c7b-91b6-8c77fbe55b30@lunn.ch>
In-Reply-To: <8ca4ba13-1bcf-4c7b-91b6-8c77fbe55b30@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 27 Oct 2023 18:20:08 -0700
Message-ID: <CAFhGd8p8mmGfR-eTu_g3k64Z79z=M1xfjTFDhmJ1XaszCtQx1w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] ethtool: Implement ethtool_puts()
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:43=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/**
> > + * ethtool_puts - Write string to ethtool string data
> > + * @data: Pointer to start of string to update
>
> Isn't it actually a pointer to a pointer to the start of string to
> update?

I suppose.

FWIW, I just copy-pasted the sprintf doc and tweaked:
/**
 * ethtool_sprintf - Write formatted string to ethtool string data
 * @data: Pointer to start of string to update
 * @fmt: Format of string to write
 *
 * Write formatted string to data. Update data to point at start of
 * next string.
 */


>
> > +extern void ethtool_puts(u8 **data, const char *str);
>
>         Andrew

