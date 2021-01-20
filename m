Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683DF2FD4D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbhATQC0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 11:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388486AbhATP6x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 10:58:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB4C061575
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 07:58:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b2so26342653edm.3
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCuMF59B75JqVZRhUet2Yi3cLtXy0EDEiwxjM9Hz1MA=;
        b=VKJaXqGF5WS+x6qqQVL8towVM+Fs6mOF52cERPGOF256NSc0stzZeiyd+yEIlqipJM
         4aSZwbXPPypgcZ5VnQTX3nknuSIBOevMjlr4FKBbp0+7jtzLVfo+4k5ndliZNMM43lJH
         QljeH0cWV55LcLU8pVK+OZdU5O7WPEnSPsLqBcm1YunALWs3RoeztvB0He7lpF6xXGl7
         imnY6os11BG4kI4Dhq4UVrui3t8Qg05RhQLsJd1ZZwBsbI5QN4NjytDNbHUFHOYznihS
         3hetaM+CVwTavWBJRdAZLvajJ56jUxx7vxZzNB4ecNRMRzt8w8PRE9wH6IrxTmvyAZSb
         oKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCuMF59B75JqVZRhUet2Yi3cLtXy0EDEiwxjM9Hz1MA=;
        b=tZgusTdBRhLl3BgKPGCgVl/yJs/2/1ynthAI0Od8Bd37I4JSbrg7n7KIgxOZxCUjhB
         q7qdxZ2/AnL5Go78DxyOYSeixmu+zGZ5S/tixgtgxcstMFfCNUHIEe9RzoRzh4YWDtGS
         3LrzyvluwcaEQ5ENLcVpTwqcvEOT8hTy1TGMVXC9R0MKHG0QcbQS8r7uGn/ToCioPW0c
         lB9HKzMkaKB8Qwv7s2Kr7gyp0QciJynJ9T/zW8mBTv/DdwvZMZWzE+zH8oRVBiIjDLtW
         MqMcuoS4ZJHh2ZZ4+dX3RJ7lid6DhfjC/cA4u+IlAqMIkW0gM9oq5X0nRA7FGVweKh1R
         Id/g==
X-Gm-Message-State: AOAM530BWNhGzlmtu36QCgi0++hQHHUPOTiKRZX2sk6sOzSj6ay9zkmE
        gqr92wFMVr34LRiwTl1P8XGF9uKd/sN35wHoQS5A4w==
X-Google-Smtp-Source: ABdhPJwX/Q4xQp3XH8ogo8mdjPkIAyaTubhtdUMly2dIrPifA7A3MMAZC5W5GCCC4gFAzCV5TtScoAlTWEg/zN3wit4=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr7843959edd.62.1611158288805;
 Wed, 20 Jan 2021 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-2-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-2-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 10:57:33 -0500
Message-ID: <CA+CK2bB0pO61=BX89CNycNKEzjHygzNFxCbn6zDD=5by44qijQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT
 to HV_CPU_MANAGEMENT
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> This makes the name match Hyper-V TLFS.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e73a11850055..e6903589a82a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -88,7 +88,7 @@
>  #define HV_CONNECT_PORT                                BIT(7)
>  #define HV_ACCESS_STATS                                BIT(8)
>  #define HV_DEBUGGING                           BIT(11)
> -#define HV_CPU_POWER_MANAGEMENT                        BIT(12)
> +#define HV_CPU_MANAGEMENT                      BIT(12)

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
