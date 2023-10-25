Return-Path: <linux-hyperv+bounces-587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AD7D7903
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 01:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E1C1C20A14
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DBE381B1;
	Wed, 25 Oct 2023 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UB72BJq3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005B33E3
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 23:59:25 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098BD8
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:59:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50797cf5b69so348623e87.2
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698278362; x=1698883162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOKIo8DF+sUuPmcncHrP3egXRJzB8ddS10YhGbuNSzU=;
        b=UB72BJq30rGKXf7E1VClFhiDBSQdC/A/I7YETf/8ML6csp5zKnN7t00iKD5vtOmoXU
         dcdHQXCL1O3qlHdvVcDcHpLvyV29VLutrqr1UTLVWAA9WXbMp8z95kgaEKYaj44WabNe
         fGgmvEuZ+I1iGodb+i2IJx7AG1Q/3yp6qZzFBvv+wVMP8Aixjl9RwX6JBbKOgbWhQDqe
         dS6CU9hWQa/k/psvIL8aKmFLLx7C4Cs/Jwk4Z18JPNNcgWpa952z61f9/nCxCJjrwArH
         DLrZW6c+EH84f3p9ajt+VXktdRLAE5+Bt0hrKWM7tUzO0nvLnfzLxwq/AQF0qyjFpzME
         a/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698278362; x=1698883162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOKIo8DF+sUuPmcncHrP3egXRJzB8ddS10YhGbuNSzU=;
        b=W18hmXvJ0YneLF8qwq2gwRCXvJ5kxybfXBj82ApdatbIL2HfBydeXF6CvYY1O9nmX6
         aJr8XOLiCUEau+8h51tPDWOnan0VQPCVaaxHsSIsDEl/2XRmX+HweqSPlaX7TJ1/Yl+J
         oA0kCM1E+lz8Qup/NfwZP/GmjS5/tlRZ+CxpJZ4MLm/eEbN/XOSYEPi2mvgskZpjs+ko
         9K3rxW5UlAfwgZOybP4jlI1Ygm5sEANYrky81tOjP+emyvro6zeG4TfCgRxk/CVbhBYL
         jpqXtgbqpF7pTG5ZZdg8vkyMQ0yandsQfBiEp3lP2v5g7xKERy6vM9L1COdvdNyMv5pB
         fzpQ==
X-Gm-Message-State: AOJu0Yy74P1e/upbm/LfTZQUhRRu6aaWzrux+VHGU0skxJohp4/rc/FZ
	42y50ZEi6qjq1LPe4ytfdJHxqq6XxJ8I8/c/1CL22g==
X-Google-Smtp-Source: AGHT+IGtsFDBZKN+N/ZF4VcJsolWlfdEFrnQ/DXEW85XQ02kN1A3YBCHAzvuiK4AYre/UMSRQEecJKagI7QT12Wqsd4=
X-Received: by 2002:a19:2d54:0:b0:507:ceba:a94d with SMTP id
 t20-20020a192d54000000b00507cebaa94dmr12847400lft.14.1698278362169; Wed, 25
 Oct 2023 16:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com> <10a072f549e187bc2fdc735c0161c09c90fc1392.camel@perches.com>
In-Reply-To: <10a072f549e187bc2fdc735c0161c09c90fc1392.camel@perches.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 25 Oct 2023 16:59:10 -0700
Message-ID: <CAFhGd8r5YFJrpy7xvhi2LZUrsPNTTpWKy2PYgDOjnrnTNBN3Bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to ethtool_puts()
To: Joe Perches <joe@perches.com>
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 4:51=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> > This patch converts some basic cases of ethtool_sprintf() to
> > ethtool_puts().
> >
> > The conversions are used in cases where ethtool_sprintf() was being use=
d
> > with just two arguments:
> > >       ethtool_sprintf(&data, buffer[i].name);
>
> OK.
>
> > or when it's used with format string: "%s"
> > >       ethtool_sprintf(&data, "%s", buffer[i].name);
> > > which both now become:
> > >       ethtool_puts(&data, buffer[i].name);
>
> Why do you want this conversion?
> Is it not possible for .name to contain a formatting field?

The case of using just two arguments to a ethtool_sprintf
call may cause -Wformat-security warnings. If it did indeed
have format specifiers then we would have more format
specifiers than arguments. Not ideal.

The second case of having a standalone "%s" isn't
necessarily bad or wrong. I used this exact approach to
replace some strncpy() usage in net drivers [1].

I'm working off guidance from Andrew Lunn [2] and Kees
who said it may be a good idea to tidy this up with a puts().

All in all, this patch doesn't do much but fix some warnings
and provide a more obvious interface. The number of
actual replacements are relatively low (around 20ish) so
I was hoping to sneak them in via this series.

>

[1]: https://lore.kernel.org/all/?q=3Ddfb%3Aethtool_sprintf+AND+f%3Ajustins=
titt
[2]: https://lore.kernel.org/all/a958d35e-98b6-4a95-b505-776482d1150c@lunn.=
ch/

Thanks
Justin

